from bd import obtener_conexion

def obtener_data():
    conexion = obtener_conexion()
    listado = []
    with conexion.cursor() as cursor:
        cursor.execute("SELECT id, nombre, descripcion, precio FROM listadp")
        juegos = cursor.fetchall()
    conexion.close()
    return listado
