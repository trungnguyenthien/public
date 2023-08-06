# Tính dễ đọc của source code

**Lập trình viên** đều đồng ý rằng việc viết mã nguồn (source code) **dễ đọc** và **dễ bảo trì** là một yếu tố quan trọng trong quá trình phát triển phần mềm.

Ảnh hưởng của 1 source code kém chất lượng thì không cần liệt kê nhiều vì tôi nghĩ các bạn **lập trình viên 2-3 năm kinh nghiệm** đã nắm rất rõ. Tuy nhiên, khi được người phỏng vấn hỏi tới: "**- Theo bạn, code như thế nào là dễ đọc?**" nếu ứng viên đó trả lời: "**- Thấy code dễ đọc là được**" thì mình tin rằng code của bạn ấy đang không dễ đọc. Tuy "dễ đọc" có phần cảm tính nhưng không có nghĩa phương pháp giải quyết cũng có thể cảm tính, câu trả lời làm mình phần nào yên tâm hơn là cho mình các phương pháp đánh giá có thể **Định Lượng - Định Tính** được chất lượng source code.

Như vậy, mặc dù nội dung bài này sẽ hướng đến cách viết code dễ đọc, nhưng đừng comment code rằng "**Tôi thấy chỗ code này của bạn đang dễ/khó đọc**" mà hãy chỉ ra những điểm có thể cải thiện. 

Trong chuỗi bài này, chúng ta sẽ thống nhất với nhau những vấn đề gây là, code phức tạp hơn, và những điểm cải thiện chắc chắn giúp code tốt hơn.

**SỰ PHỨC TẠP TRONG NGÔN NGỮ**

Ngôn ngữ lập trình cũng giống Ngôn ngữ thường ngày trong cuộc sống. Trong lập trình, ta dùng Java, PHP, C/C++ để chỉ dẫn máy thực hiện nhiệm vụ, tương tự như khi ta viết một hướng dẫn cho ai đó phương pháp thực hiện công việc. 

Hướng dẫn phức tạp không ở số lượng công việc cần làm, mà nằm ở số lượng hướng dẫn có các từ khóa "Nếu ... thì mới được ...", "Trong trường hợp ... thì hãy ...", ... Chắc chắn rằng, nếu yêu cầu và hướng dẫn là "Chỉ được mở cánh cửa và vào phòng làm việc sau 7h30 && khi đã có người đã ở trong phòng rồi" thì khả năng có người phạm lỗi sẽ cao hơn yêu cầu: "Mở cửa, vào phòng, mở hết rèm trong phòng họp, lau bảng phòng họp" (Số Business nhiều, không có Logic).

Quay lại ví dụ cánh cửa, ở hướng dẫn trên, thì Business là "Mở cửa + vào phòng", Logic là "Sau 7h30 && Có người trong phòng". Chúng ta thấy:

- **Số Business càng nhiều càng làm người đọc khó Ghi nhớ.**
- **Số Logic càng nhiều càng làm người đọc khó Phân tích và Ghi nhớ.**
- **Cùng một Giải pháp có thể Trình bày hướng dẫn đơn giản hơn đến mức nào đó, Để giảm được cả Business và Logic nhiều hơn nữa đôi khi chúng ta phải chọn Giải pháp khác đơn giản hơn.**

Source code là sản phẩm của Tập thể, nhưng mỗi Cá nhân sẽ có khoảng cách năng lực riêng. Mỗi người trong chúng ta sẽ có khả năng ghi nhớ, khả năng tập trung và phân tích khác nhau. Hoặc cùng là mình, vẫn là đoạn code đó, nhưng đầu ngày đầu óc thoải mái (chưa ghi nhớ nhiều logic) thì có thể đọc hiểu được, đến gần đến hết ngày (đầu óc đang phải ghi nhớ nhiều vấn đề) hoặc bị trễ deadline thì vẫn cùng đoạn code đó nhưng nó sẽ khó đọc hơn.

Chắc chắn khi nói về khoảng cách năng lực, tâm trạng buồn vui, stress,... với ý muốn mọi người giữ code tốt nhất có thể, nghe rất khó chấp nhận nhưng ai cũng biết nó đang diễn ra mỗi ngày. Vì vậy:

- **Trong quá trình code, hãy cố gắng tối ưu cho code đơn giản hơn.** 

Trong bài tiếp theo, chúng ta sẽ tìm hiểu về chỉ số **Cognitive Complexity** và một số cách cải thiện giúp code đơn giản hơn.