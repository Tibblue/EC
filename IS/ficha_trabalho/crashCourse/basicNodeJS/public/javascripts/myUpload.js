$(()=>{

    // botao HIDE e SHOW
    //// isto é jQuery do simples. Enjoy
    $("#hide").click(()=>{
        $("table").hide()
    })
    $("#show").click(() => {
        $("table").show()
    })

    // load da lista para a pagina
    $("#files").load("http://localhost:3000/files")

    // valida o folmulario garantindo que um ficheiro foi escolhido (aceito ficheiros sem descricao)
    function validateForm() {
        var text = document.forms["myUploadForm"]["ficheiro"].value
        if (text == "") {
            alert("File must be chosen")
            return false
        }
        return true
    }

    // adiciona um upload
    $("#adicionar").click(e => {
        if(validateForm()){
            e.preventDefault()
            // var file = document.forms['myUploadForm']['ficheiro'].files[0]
            var ficheiro = document.forms['myUploadForm']['ficheiro'].files[0].name
            var descricao = document.forms['myUploadForm']['descricao'].value
            // isto para dar um 'fake reload' (kiko dislikes)
            // em vez de reload adicionamos a info, quando se carrega no botão
            $("#files").append("<tr><td><a href='/uploaded/"+ficheiro+"'>"+ficheiro+"</a></td>"+
                                    "<td>" + descricao + "</td></tr>")
            ajaxPost()
        }
    })

    // envia o upload para o servidor ( ficheiro + descricao )
    function ajaxPost() {
        // gerar o data packet do formulario automaticamente
        var data = new FormData(document.getElementById("myUploadForm"))
        // // gerar manualmente o data packet
        // var data = new FormData()
        // data.append("ficheiro", document.forms['myUploadForm']['ficheiro'].files[0])
        // data.append("descricao", document.forms['myUploadForm']['descricao'].value)
        $.ajax({ // coisas importantes ser => type, url, data
            type: "POST",
            // contentType: "multipart/form-data",
            contentType: false,
            enctype: 'multipart/form-data',
            url: "http://localhost:3000/file/guardar",
            processData: false,
            data: data,
            success: data => {
                alert("Ficheiro gravado com sucesso: " + JSON.stringify(data))
                console.log("SUCCESS")
                console.log(data)
                // redirect para a pagina inicial (reload? in a way xD)
                window.location.replace("/")
            },
            error: e => {
                alert("Erro no POST: " + JSON.stringify(e))
                console.log("Erro: " + e)
            }
        })
        // isto permite limpar o texto nas caixas de texto
        // inutil se fizermos reload
        $("#ficheiro").val("")
        $("#descricao").val("")
    }

})