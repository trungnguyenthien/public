# Cách đo Cognitive Complexity

Như bài trước đã đề cập, source code đơn giản hay phức tạp dựa vào:

- Số lượng/ Số loại Logic trong giải pháp.
- Cách diễn đạt, trình bày các Logic trong giải pháp.

Trong bài viết này sẽ đi chi tiết hơn cách SonarQube xác định chỉ số Cognitive Complexity của source code.

Cognitive Complexity được tạo ra với mục tiêu đo lường mức độ phức tạp của mã dựa trên khả năng hiểu một cách tự nhiên của con người. 

Cụ thể, nó hướng tới đánh giá mức độ khó khăn mà lập trình viên phải đối mặt khi đọc, hiểu và bảo trì một khối mã cụ thể.

Điểm Cognitive càng cao, code càng khó đọc.

Cognitive Complexity đánh giá độ phức tạp code dựa vào 3 ý cơ bản:

- +0 khi sử dụng một số cách shorthand do ngôn ngữ lập trình hỗ trợ (ternary operator, null-coalescing operators,...) --> Khuyến khích sử dụng các shorthand để làm code dễ đọc.
- +1, cho mỗi lần phá vỡ cấu trúc linear khi đọc code (if, switch, loop) và tăng dần lên cho mỗi lần lồng nhau.
- +1, cho mỗi lần trộn lẫn các logic operator (AND và OR) lại với nhau.

Tiếp theo, ta đi vào chi tiết các trường hợp code gây tăng (+1) độ phức tạp.

## 🍋 +1 cho mỗi lần phá vỡ cấu trúc linear khi đọc code

Các bạn chú ý là "**...khi đọc code**" nhé.

Khi lập trình viên đọc code, đọc code càng linear (đọc liên tục không ngắt khoảng, không rẽ nhánh) càng dễ hiểu, ghi nhớ. Và ngược lại.

\+ 1 cho lệnh `goto` : Ngày nay, mọi người đã ít sử dụng cấu trúc điều khiển `goto` cũng vì sự khó đọc, chính xác là 1 sự phá vỡ cấu trúc linear nghiêm trọng của việc đọc code.

+1 cho `loop và đệ quy` : Vòng lặp (for, do, while) hoặc đệ quy khiến việc đọc code flow xoay vòng

++1 cho mỗi lần lồng code `{ }` : việc lồng code bởi các {...} cũng gây khó hiểu, cùng là 5 câu if nhưng khi trình bày 5 cấu trúc một cách tuần tự (linear) sẽ dễ hiểu hơn so với cùng 5 cấu trúc if lồng nhau. Khi các cấu trúc được lồng nhau, việc hiểu mã trở nên khó khăn hơn vì ta phải theo dõi các cấu trúc con và hiểu các điều kiện lồng nhau.

Cứ mỗi cấp lồng thêm vào nhau, độ khó đọc code càng tăng nhiều hơn.

```
void myMethod () { 

  try {

​    if (condition1) {                    // +1

​      for (int i = 0; i < 10; i++) {     // +2 (nesting=1) 

​        while (condition2) { … }         // +3 (nesting=2)

​      }

​    }

  } catch (ExcepType1 | ExcepType2 e) {  // +1

​    if (condition2) { … }                // +2 (nesting=1)

  }

}                                        // Cognitive Complexity = 9
```

Tuy nhiên không phải cứ xuất hiện {...} là phá vỡ linear, ngoại lệ là `try {}` .

+0 cho `try {}` : Khác với if {} và else {} có sự rẽ nhánh, "**tùy điều kiện"** luồng xử lý có thể vào if {} hoặc else {}. Với try {}, luồng xử lý "**sẽ luôn**" vào try {} trước nên try vẫn giữ được cấu trúc linear.

+1 cho `catch {}` :" **tùy trường hợp**" nếu có ngoại lệ thì mới xử lý catch {}. Nên catch {} cũng tính là 1 sự rẽ nhánh, vẫn "bị +1".

```
public void exampleMethod() {

​    try {                         //+0

​        // Đọc xong code chính

​    } catch (Exception ex) {      //+1

​        // Xử lý ngoại lệ ở đây

​    }

​    // Các câu lệnh tiếp theo sau khối catch

}
```

Tóm lại:

1. goto, if, else, switch, catch, đệ quy, các loại loop đều tăng cognitive
2. Mỗi cấp lồng thêm vào nhau cấp 2, 3,.. sẽ tăng cognitive thêm ++1.
3. try {} không tăng cognitive

## 🍋 +1 cho mỗi lần trộn lẫn các logic operator

Xem xét 3 chuỗi logic dưới đây và cảm nhận chuỗi nào phức tạp hơn:

```
1) a && b && c && d
2) a || b || c || d
3) a || b && c || d
```

Số ( 1 ) và ( 2 ) nếu cùng 1 toán tử logic (AND, OR) liên tiếp nhau thì dù có kéo dài từ a đến z cũng dễ hiểu, => Chuỗi ( 1 ) và ( 2 ) không làm tăng cognitive.

Đối với chuỗi ( 3 ), chắc chắn sẽ cần một nỗ lực lớn hơn 2 chuỗi logic đầu để hiểu được. Mỗi lần có sự chuyển giao toán tử trong cùng chuỗi logic thì sẽ +1.

```
bool result = a && b && c
  || d || e   // +1 do có sự chuyển giao toán tử
  && f	      // +1 do có sự chuyển giao toán tử

if (a         // +1 for `if`
  &&          // +1
  !(b && c))  // +1
```

# KẾT LUẬN

Khác với các mô hình đánh giá trước đây dựa trên các mô hình toán học.

Cognitive Complexity là mô hình đánh giá độ phức tạp của việc đọc source code dựa trên yếu tố con người, nhận được sự đồng thuận của số đông nhiều hơn, được đánh giá là công bằng hơn và có ý nghĩa hơn đối với lập trình viên.

Nhận xét cá nhân: 

Trong khi cách **Định Tính** các vấn đề của source code (*phá vỡ cấu cấu trúc linear hay mix các toán tử logic*) thì hoàn hợp lý, thì cách **Định Lượng** (*vì sao luôn là +1 mà không là +1.2, +1.5,...*) thì khá gượng ép. Nhưng thôi, có (công thức) còn tốt hơn không. Chúng ta cần có sự thống nhất chung để đánh giá và tìm hướng cải thiện code tốt hơn hoặc một thỏa thuận mỗi method nên giữ độ phức tạp tối đa là 10, 15 điểm chẳng hạn./