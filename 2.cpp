#include <iostream>
#include <string>

// Базовый класс
class Animal {
protected:
    std::string name;

public:
    Animal(const std::string& name) : name(name) {}

    // Виртуальный метод (может быть переопределен)
    virtual void makeSound() const {
        std::cout << name << " издает какой-то звук" << std::endl;
    }

    // Обычный метод базового класса
    void eat() const {
        std::cout << name << " ест" << std::endl;
    }

    virtual ~Animal() {} // Виртуальный деструктор
};

// Производный класс
class Dog : public Animal {
public:
    Dog(const std::string& name) : Animal(name) {}

    // Переопределение виртуального метода
    void makeSound() const override {
        std::cout << name << " лает: Гав-гав!" << std::endl;
    }

    // Новый метод, специфичный для Dog
    void fetch() const {
        std::cout << name << " приносит палку" << std::endl;
    }
};

// Еще один производный класс
class Cat : public Animal {
public:
    Cat(const std::string& name) : Animal(name) {}

    // Переопределение виртуального метода
    void makeSound() const override {
        std::cout << name << " мяукает: Мяу-мяу!" << std::endl;
    }

    // Новый метод, специфичный для Cat
    void climbTree() const {
        std::cout << name << " залезает на дерево" << std::endl;
    }
};

int main() {
    // Создаем объекты
    Animal genericAnimal("Неизвестное животное");
    Dog dog("Бобик");
    Cat cat("Мурзик");

    // Демонстрация работы методов базового класса
    std::cout << "=== Базовый класс ===" << std::endl;
    genericAnimal.makeSound();
    genericAnimal.eat();

    // Демонстрация работы методов производного класса Dog
    std::cout << "\n=== Производный класс Dog ===" << std::endl;
    dog.makeSound();  // Вызов переопределенного метода
    dog.eat();        // Вызов унаследованного метода
    dog.fetch();      // Вызов нового метода


    // Демонстрация работы методов производного класса Cat
    std::cout << "\n=== Производный класс Cat ===" << std::endl;
    cat.makeSound();  // Вызов переопределенного метода
    cat.eat();        // Вызов унаследованного метода
    cat.climbTree();  // Вызов нового метода

    // Демонстрация полиморфизма через указатель на базовый класс
    std::cout << "\n=== Полиморфизм через указатель ===" << std::endl;
    Animal* animals[] = {&genericAnimal, &dog, &cat};
    
    for (Animal* animal : animals) {
        animal->makeSound(); // Вызовется соответствующая версия метода
    }

    return 0;
}