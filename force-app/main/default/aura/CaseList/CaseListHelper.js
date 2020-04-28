({
    helperMethod : function() {
        
    },

    sortBy : function(key, reverse) {

        // Move smaller items towards the front
        // or back of the array depending on if
        // we want to sort the array in reverse
        // order or not.
        var moveSmaller = reverse ? 1 : -1;

        // Move larger items towards the front
        // or back of the array depending on if
        // we want to sort the array in reverse
        // order or not.
        var moveLarger = reverse ? -1 : 1;

        /**
        * @param  {*} a
        * @param  {*} b
        * @return {Number}
        */
        return function(a, b) {

            var left = a[key];
            var right = b[key];

            if (left == undefined) {
                left = '';
            }
            if (right == undefined) {
                right = '';
            }


            if (left < right) {
                // console.log('result: ' + a[key] + ' is smaller');
                return moveSmaller;
            }
            if (left > right) {
                // console.log('result: ' + a[key] + ' is larger');
                return moveLarger;
            }

            // console.log('result: same');
            return 0;
        };
    }
})