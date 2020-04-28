({
    handleClick : function(cmp, event) {
        var attributeValue = cmp.get("v.text");
        alert(attributeValue);
        console.log("current text: " + attributeValue);

        var target = event.getSource();
        cmp.set("v.text", target.get("v.label"));
    }
})