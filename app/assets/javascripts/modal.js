$('.openBtn').on('click', function () {

        $(".modal-body").html("<%= j (render 'orders/order_items')%>");
    $('#myModal').modal("show");
});

