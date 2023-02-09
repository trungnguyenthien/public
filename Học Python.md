# Học Python



## Sample Function

```python
def permute(data, i, length):
    if i == length:
        print(data)
    else:
        for j in range(i, length):
            data[i], data[j] = data[j], data[i]
            permute(data, i + 1, length)
            data[i], data[j] = data[j], data[i]

# Test example
data = [1, 2, 3]
permute(data, 0, len(data))

```



## Class

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def greeting(self):
        print("Hello, my name is", self.name)

p = Person("John Doe", 30)
p.greeting()

```



## Constructor

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

p1 = Person("John Doe", 30)
print(p1.name)
print(p1.age)

```



## Inheritance (Kế thừa)

```python
class Animal:
    def __init__(self, name, species):
        self.name = name
        self.species = species

    def show_species(self):
        print(f"This animal is a {self.species}.")

class Dog(Animal):
    def __init__(self, name, breed):
        Animal.__init__(self, name, species="Dog")
        self.breed = breed

    def show_breed(self):
        print(f"This dog is a {self.breed}.")

dog = Dog("Rufus", "Labrador")
dog.show_species()
dog.show_breed()

```



## Polymorphism (Đa hình)

```python
class Shape:
    def area(self):
        pass

class Square(Shape):
    def __init__(self, side_length):
        self.side_length = side_length

    def area(self):
        return self.side_length**2

class Triangle(Shape):
    def __init__(self, base, height):
        self.base = base
        self.height = height

    def area(self):
        return 0.5 * self.base * self.height

shapes = [Square(5), Triangle(6, 8), Square(9), Triangle(3, 4)]
for shape in shapes:
    print(f"Area: {shape.area()}")

```



## Encapsulation (Đóng gói)

```python
class BankAccount:
    def __init__(self, name, balance):
        self.__name = name
        self.__balance = balance

    def get_balance(self):
        return self.__balance

    def deposit(self, amount):
        self.__balance += amount

    def withdraw(self, amount):
        if amount > self.__balance:
            print("Insufficient funds.")
        else:
            self.__balance -= amount

account = BankAccount("John Doe", 1000)
print(account.get_balance())
account.deposit(500)
print(account.get_balance())
account.withdraw(1500)
print(account.get_balance())

```



## Abstraction (Tính trừu tượng)

```python
from abc import ABC, abstractmethod

class Shape(ABC):
    @abstractmethod
    def area(self):
        pass

class Square(Shape):
    def __init__(self, side_length):
        self.side_length = side_length

    def area(self):
        return self.side_length**2

class Triangle(Shape):
    def __init__(self, base, height):
        self.base = base
        self.height = height

    def area(self):
        return 0.5 * self.base * self.height

square = Square(5)
triangle = Triangle(6, 8)
print(square.area())
print(triangle.area())

```



## Duyệt LOOP

```python
// Vòng lặp for
array = [1, 2, 3, 4, 5]
for element in array:
    print(element)
    
// enumerate
array = [1, 2, 3, 4, 5]
for index, element in enumerate(array):
    print(index, element)

// zip
array1 = [1, 2, 3]
array2 = [4, 5, 6]
for element1, element2 in zip(array1, array2):
    print(element1, element2)

// map
array = [1, 2, 3, 4, 5]
for element in map(lambda x: x**2, array):
    print(element)

```



## Overload function (KHÔNG SUPPORT)

Chỉ có sử dụng default value

```python
def print_message(message, bold=False):
    if bold:
        print("\033[1m" + message + "\033[0m")
    else:
        print(message)

print_message("Hello World!")
print_message("Hello World!", bold=True)

```



## Switch case (KHÔNG SUPPORT)

```python
def switch_example(case_value):
    if case_value == 1:
        print("Case 1")
    elif case_value == 2:
        print("Case 2")
    elif case_value == 3:
        print("Case 3")
    else:
        print("Default case")

switch_example(1)
switch_example(2)
switch_example(3)
switch_example(4)

```



## Enum

```python
import enum

class Color(enum.Enum):
    RED = 1
    GREEN = 2
    BLUE = 3

print(Color.RED)
print(Color.RED.value)

```





## Access Modifier

Trong Python, không có những tính năng chính thức để xác định truy cập cho thuộc tính hoặc phương thức của một lớp. Tuy nhiên, bạn có thể sử dụng kỹ thuật đặt tên gần giống với access modifier, ví dụ như sử dụng dấu "_" hoặc "__" trước tên thuộc tính hoặc phương thức để biểu thị rằng chúng không nên được truy cập bởi bên ngoài.

```python
class MyClass:
    def __init__(self):
        self.__private_property = 42

    def __private_method(self):
        print("This is a private method")

    def public_method(self):
        print(self.__private_property)
        self.__private_method()

obj = MyClass()
obj.public_method()
print(obj.__private_property)  # This will raise an AttributeError
obj.__private_method()  # This will raise an AttributeError

```



## Computed Property

```python
class Rectangle:
    def __init__(self, width, height):
        self._width = width
        self._height = height

    @property
    def area(self):
        return self._width * self._height

    @property
    def width(self):
        return self._width

    @width.setter
    def width(self, value):
        if value <= 0:
            raise ValueError("Width must be positive")
        self._width = value

    @property
    def height(self):
        return self._height

    @height.setter
    def height(self, value):
        if value <= 0:
            raise ValueError("Height must be positive")
        self._height = value

```



## `as`

`as` là một từ khóa trong Python, được sử dụng để gán một tên alias (tên gọi khác) cho một thư viện hoặc module được import.

```python
import math as m

# Now you can refer to the math library as "m"
result = m.sqrt(16)
print(result) # Output: 4.0

```



## `del`

`del` là một từ khóa trong Python, được sử dụng để xóa một biến, list item, hoặc phần tử trong dictionary. 

```python
a = 10
del a
print(a) # Output: NameError: name 'a' is not defined

lst = [1, 2, 3, 4, 5]
del lst[2] # Deletes the 3rd item in the list
print(lst) # Output: [1, 2, 4, 5]

d = {'a': 1, 'b': 2, 'c': 3}
del d['b'] # Deletes the key-value pair with key 'b' from the dictionary
print(d) # Output: {'a': 1, 'c': 3}

```



## `except`

`except` là một từ khóa trong Python, được sử dụng trong một cấu trúc `try-except` để xử lý các ngoại lệ (exceptions). Nếu một đoạn code trong một khối `try` gây ra một ngoại lệ, thực thi sẽ chuyển sang khối `except` tương ứng để xử lý ngoại lệ đó.

```python
try:
   # Code that may raise an exception
   a = 10 / 0
except ZeroDivisionError:
   # Code to handle the ZeroDivisionError exception
   print("Cannot divide by zero")

```



## `finally`

`finally` là một từ khóa trong Python, được sử dụng trong một cấu trúc `try-except-finally`. Khối `finally` luôn được thực thi, bất kể có gây ra ngoại lệ hay không trong khối `try`. Nó thường được sử dụng để thực hiện các hoạt động phục vụ,



```python
try:
   # Code that may raise an exception
   a = 10 / 0
except ZeroDivisionError:
   # Code to handle the ZeroDivisionError exception
   print("Cannot divide by zero")
finally:
   # Clean up code
   print("This will always be executed.")

```



## `raise`

"raise" là một từ khóa trong Python, được sử dụng để ném một ngoại lệ. Điều này cho phép bạn tự mình điều chỉnh xử lý lỗi trong chương trình của mình. 

```python
def divide(a, b):
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b

try:
    result = divide(5, 0)
except ValueError as e:
    print("Caught an exception:", e)

```





## `from`

`from` là một keyword trong Python, chỉ định module hoặc package mà các đối tượng, hàm, v.v. sẽ được import từ đó. Ví dụ, câu lệnh sau import hàm sqrt từ thư viện math

```python
from math import sqrt
```



## `global`

"global" là một keyword trong Python, được sử dụng để chỉ định một biến là biến toàn cục (global variable).

```python
x = 10
def foo():
  global x
  x = 20

foo()
print(x)  # Output: 20

```



## `lambda`

"lambda" là một từ khóa trong Python, được sử dụng để tạo các hàm anonymous (hàm vô danh). Lambda hàm là những hàm tạm thời, không được gọi bằng tên mà chỉ được gọi trong một biểu thức.

```python
sum = lambda a, b: a + b
print(sum(1, 2))  # Output: 3

```



## `none`

"None" là một giá trị đặc biệt trong Python, được sử dụng để chỉ rằng một biến hoặc một hàm không có giá trị trả về. Nó cũng có thể được sử dụng như một giá trị cho các biến mà chưa được gán giá trị. 

```python
def my_function():
    return None

result = my_function()
print(result)  # Output: None

```



## `nonlocal`

"nonlocal" là một từ khóa trong Python, được sử dụng để xác định rằng một biến nằm trong một phạm vi nội bộ (inner scope) cần được sửa đổi trong một phạm vi ngoại bộ (outer scope). Nó chỉ có thể được sử dụng trong các hàm lồng nhau. 

```python
def outer_function():
    x = 10
    def inner_function():
        nonlocal x
        x = 20
    inner_function()
    print(x)  # Output: 20

outer_function()

```



## `pass`

"pass" là một từ khóa trong Python, được sử dụng để chỉ ra một khối lệnh trống hoặc chưa được định nghĩa. Nó thường được sử dụng khi bạn muốn tạm thời không làm gì cả trong một hàm hoặc vòng lặp.

```python
def example_function():
    pass

for i in range(5):
    pass

```



## yield

"yield" là một từ khóa trong Python, được sử dụng để tạo một generator. Generator là một kiểu dữ liệu cho phép bạn tạo một danh sách các giá trị trong một hàm mà không cần phải trả về toàn bộ danh sách này tại một thời điểm nào đó. 

```python
def my_range(n):
    i = 0
    while i < n:
        yield i
        i += 1

for i in my_range(5):
    print(i)

```



## `async`, `await`

`async` và `await` là hai từ khóa trong Python dùng để tạo và sử dụng asynchronous function.

`async` được sử dụng để khai báo một asynchronous function. Điều này cho phép function này chạy song song với các task khác trong chương trình.

`await` được sử dụng để chờ một task asynchronous hoàn thành trước khi tiếp tục chạy các dòng code sau.

```python
import asyncio

async def fetch_data():
    # Do some asynchronous work
    await asyncio.sleep(1)
    return "data"

async def main():
    data = await fetch_data()
    print(data)

asyncio.run(main())
# Output: data

```



## `Thread` và `thread pool`

Thread là một đơn vị chạy độc lập, có thể chạy song song với các đơn vị chạy khác trong một chương trình. Trong Python, chúng ta có thể sử dụng module `threading` để tạo và quản lý thread.

Thread pool là một tập hợp các thread đã được tạo trước, sẵn sàng để sử dụng khi cần. Chúng ta có thể sử dụng thread pool để tăng hiệu suất, giảm tải bộ nhớ của chương trình.

```python
import concurrent.futures
import time

def worker(n):
    time.sleep(n)
    return n

with concurrent.futures.ThreadPoolExecutor() as executor:
    futures = [executor.submit(worker, n) for n in [2, 4, 3, 1]]
    for future in concurrent.futures.as_completed(futures):
        print(future.result())

```



## Request API (GET, POST)

```python
import requests

url = 'https://www.example.com/api/data'
response = requests.get(url)
if response.status_code == 200:
    data = response.json()
    print(data)
else:
    print('Request failed with status code: ', response.status_code)

```



```python
import requests

url = 'https://www.example.com/api/create'
payload = {'key1': 'value1', 'key2': 'value2'}
headers = {'Content-Type': 'application/json'}
response = requests.post(url, json=payload, headers=headers)
if response.status_code == 201:
    data = response.json()
    print(data)
else:
    print('Request failed with status code: ', response.status_code)

```



## Package `os`

Package `os` trong Python cho phép bạn tương tác với hệ điều hành (operating system) bằng cách cung cấp các hàm và biến để thao tác với hệ thống tập tin, thư mục, environment, v.v.

```python
import os

# Lấy tên hiện tại của thư mục làm việc
print(os.getcwd())

# Tạo một thư mục mới
os.mkdir("new_directory")

# Đổi tên một thư mục
os.rename("new_directory", "renamed_directory")

# Xóa một thư mục
os.rmdir("renamed_directory")

```

