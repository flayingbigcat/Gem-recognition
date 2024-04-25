<script>
export default {
    name:'footerBar'
}
</script>

<template>
    <div class="footer text-center">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <ul class="footer-menu text-uppercase">
                        <li>
                            <router-link style="text-decoration: none" to="#">CONTACT</router-link>
                        </li>
                        <li>
                            <router-link style="text-decoration: none" to="#">SHOP</router-link>
                        </li>
                        <li>
                            <router-link style="text-decoration: none" to="#">Pricing</router-link>
                        </li>
                        <li>
                            <router-link style="text-decoration: none" to="#">PRIVACY POLICY</router-link>
                        </li>
                    </ul>
                    <p class="copyright-text">Copyright &copy;2021, Designed &amp; Developed by <router-link style="text-decoration: none" to="#">Themefisher</router-link></p>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.footer {
    background: #F7F7F7;
    padding: 50px 0;
}
.footer .footer-menu {
    margin-top: 30px;
}
.footer .footer-menu li {
    display: inline-block;
    margin: 0 10px;
}
.footer .footer-menu li a {
    color: #333;
    font-size: 12px;
}
.footer .copyright-text {
    margin-top: 20px;
}
.copyright-text a {
    color: #000;
}
</style>