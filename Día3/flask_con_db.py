from flask import Flask, request
from flask_mysqldb import MySQL
# Devuelve todas las variables de entorno de este dispositivo
from os import environ

from dotenv import load_dotenv
load_dotenv




app = Flask(__name__)
# cuando tenemos un diccionario poder OBTENER el valor de una de sus llaves con el metodo .get('LLAVE'), SOLO es para obtener, no para asignar
# environ.get('MYSQL_HOST') = 'hola'
# environ['MYSQL_HOST'] = 'hola'
app.config['MYSQL_HOST'] = environ.get('MYSQL_HOST')
app.config['MYSQL_USER'] = environ.get('MYSQL_USER')
app.config['MYSQL_PASSWORD'] = environ.get('MYSQL_PASSWORD')
app.config['MYSQL_DB'] = environ.get('MYSQL_DB')
app.config['MYSQL_PORT'] = int(environ.get('MYSQL_PORT'))

# Cuando una variable se le asigna una clase se llama INSTANCIA
# inicializamos la conexion seteando todos los parametros de nuestro bd
mysql = MySQL(app)
@app.route('/productos', methods=['GET', 'POST'])
def gestion_productos():
    if request.method == 'GET':
      #crea una conexion a la base de datos mediante un cursor
      cursor = mysql.connection.cursor()
      cursor.execute("SELECT * FROM productos")
      productos = cursor.fetchall() #LIMIT infinito
      # cursor.fetchone() #LIMIT 1
      print(productos)
      # cerra nuestra conexion
      cursor.close()
      resultado = []
      for producto in productos:
        print(producto)
        producto_dic = {
          'id': producto[0],
          'nombre': producto[1],
          'imagen': producto[2],
          'fecha_vencimiento': producto[3].strftime('%Y-%m-%d'),
          'precio': producto[4],
          'disponible': producto[5],
          'categoria_id': producto[6]
        }
        resultado.append(producto_dic)
        print(producto_dic)
      return{
        'message': 'Los productos son',
        'content': resultado

      }
    elif request.method == 'POST':
      cursor = mysql.connection.cursor()
      informacion = request.get_json()
      cursor.execute("INSERT INTO productos(id, nombre, imagen, fecha_vencimiento, precio, disponible, categoria_id) VALUES (DEFAULT, '%s', '%s', '%s', %f, %s, %d)" %(
        informacion.get('nombre'),
        informacion.get('imagen'),
        informacion.get('fecha_vencimiento'),
        informacion.get('precio'),
        informacion.get('disponible'),
        informacion.get('categoria_id')
        ))

      mysql.connection.commit()
      cursor.close()

      return{
        'message': 'Producto creado exitosamente'
      }

def validar_producto(id):
    # creamos la conexion
    conexion = mysql.connection.cursor()
    # ejecutamos el select con la clausula del id
    # conexion.execute("SELECT * FROM productos WHERE id={}"+id)
    conexion.execute("SELECT * FROM productos WHERE id=%d" % (id))
    # conexion.execute("SELECT * FROM productos WHERE id={}"format(id))
    resultado = conexion.fetchone()
    conexion.close()
    print(resultado)
    return resultado
  
 
@app.route("/producto/<int:id>", methods = ['GET', 'PUT', 'DELETE'])
def gestion_un_producto(id):
  if request.method == 'GET':
      resultado = validar_producto(id)
      if resultado is None:
        return {
          'message': 'Producto no encontrado'
        }
      else:
        producto = {
          'id': resultado[0],
          'nombre':resultado[1],
          'imagen':resultado[2],
          'fecha_vencimiento':resultado[3].strftime('%Y-%m-%d'),
          'precio': resultado[4],
          'disponile':resultado[5],
          'categoria_id': resultado[6]      
          } 
        
    
      return{
          'content': producto
        }    
  elif request.method == 'PUT':
    resultado = validar_producto(id)
    if resultado is None:
      return {
          'message': 'Producto no existe'
      }
    else:
      data= request.get_json()
      print(data)
      conexion = mysql.connection.cursor()
      conexion.execute("UPDATE productos SET nombre=%s, precio= %s, fecha_vencimiento=%s, categoria_id=%s, disponible=%s, imagen=%s WHERE id=%s", [
          data.get('nombre'),
          data.get('precio'),
          data.get('fecha_vencimiento'),
          data.get('categoria_id'),
          data.get('disponible'),
          data.get('imagen'),
          resultado[0]
      ])
      mysql.connection.commit()
      conexion.close()

      return {
        'message': 'Producto actualizado exitosamente'
      }
  elif request.method == 'DELETE':
    resultado = validar_producto(id)
    if resultado is None:
      return{
        'message': 'Producto no existe'
      }
    else:
      conexion = mysql.connection.cursor()
      conexion.execute("DELETEFROM productos WHERE id = %s", [id])
      mysql.connection.commit()
      conexion.close()

      return {
          'message': 'Producto eliminado exitosamente'
      }
      
app.run(debug=True)
