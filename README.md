# Mobile Challenge City Uala

Es una aplicación desarrollada en **SwiftUI** siguiendo la arquitectura **MVVM** para ofrecer una experiencia fluida al buscar y explorar ciudades. La aplicación permite visualizar una lista de ciudades, buscar de manera eficiente y acceder a detalles con información geolocalizada en un mapa interactivo.

## 📌 Tecnologías y Arquitectura

- **SwiftUI**: Para la construcción de la interfaz de usuario declarativa y reactiva.
- **MVVM (Model-View-ViewModel)**: Para una separación clara de responsabilidades y facilitar la escalabilidad y testabilidad.
- **SOLID**: Se aplicaron principios de diseño SOLID para mejorar la estructura y mantenimiento del código.
- **Singleton**: Uso del patrón Singleton para la gestión de la capa de red y la obtención de datos desde la API. 
- **Estrategia de Búsqueda con Binary Search**: Para optimizar la búsqueda de ciudades en grandes conjuntos de datos.
- **Patrón Strategy**: Para hacer la lógica de búsqueda más flexible y escalable.
- **Unit Tests & UI Tests**: Se integraron pruebas unitarias y de interfaz para garantizar el correcto funcionamiento de la aplicación.

---

## 🔍 Búsqueda de Ciudades con Binary Search

La búsqueda de ciudades se implementó utilizando **Binary Search** en lugar de una búsqueda lineal para mejorar el rendimiento. Esto es especialmente útil cuando se manejan listas de gran tamaño, ya que reduce la complejidad de búsqueda de **O(n) a O(log n)**.

La estrategia utilizada ordena las ciudades alfabéticamente y luego realiza una búsqueda binaria para encontrar coincidencias, lo que permite obtener resultados de manera mucho más eficiente.

---

## 🎯 Implementación del Patrón Strategy para la Búsqueda

Para hacer que la lógica de búsqueda sea más escalable, se implementó el **Patrón Strategy**, lo que permite intercambiar fácilmente diferentes algoritmos de búsqueda sin afectar otras partes del código.

Ejemplo:
```swift
protocol SearchStrategy {
    func search(cities: [City], query: String) -> [City]
}

class CityNameSearchStrategy: SearchStrategy {
    func search(cities: [City], query: String) -> [City] {
        // Implementación con Binary Search
    }
}
```
Esto permite agregar nuevas estrategias de búsqueda en el futuro, como búsqueda por país o por coordenadas, sin modificar la lógica existente.

---

## 🛠 Singleton para la gestión de la API

Se implementó un Singleton en la clase CityService para manejar la llamada a la API y obtener la lista de ciudades. Esto garantiza que solo haya una instancia del servicio y facilita su reutilización en diferentes partes de la aplicación.

---

## 🛠 Aplicación de Principios SOLID en el ViewModel

Se aplicaron los principios SOLID para dividir las responsabilidades del **ViewModel**, evitando que contenga demasiada lógica de negocio. Algunas mejoras incluyen:

- **Separación de la carga de datos** en un servicio independiente.
- **Encapsulación de la lógica de búsqueda** en estrategias reutilizables.
- **Reducción de dependencias innecesarias** para mejorar testabilidad y reutilización.

---

## ✅ Pruebas Unitarias y de UI

Se agregaron pruebas para garantizar la funcionalidad y estabilidad de la aplicación:

- **Pruebas Unitarias**: Validan la lógica del ViewModel, estrategias de búsqueda y gestión de favoritos.
- **Pruebas de UI (XCTest)**: Validan la navegación, interacción con la lista y detalles de ciudades en SwiftUI.

Ejemplo de prueba unitaria:
```swift
func testBinarySearch_ReturnsCorrectResults() {
    let strategy = CityNameSearchStrategy()
    let result = strategy.search(cities: mockCities, query: "Paris")
    XCTAssertEqual(result.first?.name, "Paris")
}
```

---

## 🚀 Cómo Ejecutar el Proyecto

1. Clonar el repositorio:
   ```sh
   git clone [https://github.com/Dolinkue/Mobile-Challenge-city-Uala]
   ```
2. Abrir el proyecto en Xcode.
3. Ejecutar en el simulador o en un dispositivo físico.

Para correr las pruebas:
```sh
Cmd + U  # Ejecutar pruebas en Xcode
```

---

## 📌 Conclusión

Mobile Challenge City Uala es una aplicación diseñada con un enfoque modular y escalable, aprovechando **SwiftUI, MVVM, Binary Search, Strategy Pattern y SOLID** para ofrecer una arquitectura robusta. La integración de pruebas asegura su confiabilidad y mantenimiento a largo plazo.


