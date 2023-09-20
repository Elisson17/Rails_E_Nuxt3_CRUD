<template>
    <div class="all">
<h1 >Posts</h1>
<!-- Adicionando produto -->
<input type="text"
v-model="titulo"
placeholder="título"
class="titulo-input" >
   
<p>
 <input type="text"
    v-model="preco"
    placeholder="Preço"
    class="preco-input" >
</p>
<p>
    <input type="text"
    v-model="descri"
    placeholder="descrição"
    class="decricao-input" >
</p>
<p><input type="text"
    v-model="categoria"
    placeholder="catégoria"
    class="categoria-input" ></p>
    <p>
        <input type="text"
    v-model="quantidade"
    placeholder="Quantidade"
    class="quantidade-input" >
    </p>
<!-- botão de renderização IF -->
<button v-if="Editar" @click="updatePost">Update</button>
<button v-if="Editar" @click="cancelEdit">Cancelar</button>

<button v-else @click="createPost">Criar</button>

<div class="div-for" v-for="post in posts" :key="post.id">
    <h5>[ {{ post.id }} ] Título:{{ post.titulo }}</h5>
    <p>Preço: {{ post.preco }}</p>

    <p>Descrição: {{post.descri}}</p>
    <p>Catégoria: ${{ post.preco }} conto</p>
    <p>Quantidade: {{ post.quantidade }}</p>
    <button @click="editPost(post.id)">Editar</button>
    <button @click="deletePost(post.id)">Deletar</button>

</div>
    </div>
</template>

<script setup>


const posts = ref([]);
const titulo = ref('');
const descri = ref('');
const preco = ref('');
const categoria = ref('');
const quantidade = ref('');

const postId = ref(0);
const Editar = ref(false)
const api_URL = 'http://127.0.0.1:3000/produtos'

onMounted(async () => {
    const res = await fetch(api_URL)
    posts.value = await res.json()
})

const createPost = async ()=>{
    const res = await fetch(api_URL, {
        method: 'POST', headers: {
    'content-type': 'application/json'      
        },
        body: JSON.stringify({
            titulo: titulo.value,
            preco: preco.value,
            categoria: categoria.value,
            quantidade:quantidade.value,
            descri: descri.value
        })
    })

    const data = await res.json();

    posts.value.push(data)
    titulo.value = ''
    preco.value = ''
    categoria.value = ''
    quantidade.value=''
    descri.value = ''
    postId.value = 0;
}
const updatePost = async () => {
    const res = await fetch(`${api_URL}/${postId.value}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            titulo: titulo.value,
            preco: preco.value,
            categoria: categoria.value,
            quantidade: quantidade.value,
            descri: descri.value,
            id: postId.value
        })
    })

    const data = await res.json()

    const index = posts.value.findIndex(post => post.id === data.id)
    posts.value[index] = data

    titulo.value = ''
    preco.value = ''
    categoria.value = ''
    quantidade.value = ''
    descri.value = ''
    postId.value = 0;
    Editar.value = false


}
const cancelEdit = () => {
    titulo.value = ''
    preco.value = ''
    categoria.value = ''
    quantidade.value = ''
    descri.value = ''
    postId.value = 0;
    Editar.value = false


}

const deletePost = async (id) => {
    await fetch(`${api_URL}/${id}`, {method: 'DELETE'
    })
    posts.value = posts.value.filter(post => post.id !== id)
}

const editPost = async (id) => {
    const post = posts.value.find(post => post.id === id)
    titulo.value = post.titulo
    preco.value = post.preco
    categoria.value = post.categoria
    quantidade.value = post.quantidade
    descri.value = post.descri
    postId.value = post.id
    Editar.value = true

    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    })
}
</script>

<style  scoped>
.all{
    text-align: center;
}
.div-for{
    border-style: solid ;
    border-width: 2px;
    width: 250px;
}
</style>