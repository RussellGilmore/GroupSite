$(function() {
    $(document).on('turbolinks:load', Dropzone.discover);
    $("#my-dropzone").dropzone({
        maxFilesize: 2,
        addRemoveLinks: true,
        paramName: 'upload[image]'
    })
})
