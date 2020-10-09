Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBDA2889FA
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbgJINp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 09:45:59 -0400
Received: from sonic317-26.consmr.mail.bf2.yahoo.com ([74.6.129.81]:40662 "EHLO
        sonic317-26.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732737AbgJINp6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 09:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602251155; bh=vwEPMXxlnKui2A6anShyb2NpJ3D8JWCHQa2USlPuv/A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=cc8FR290OYH3wnyVyTJ2hIUyAZeHznuB47E6UBhpBFCJCylmw2i/CZxcqKJCFNOhepsXy/Rlm+MZudZ6LOIL8xfVTR/y9t04Pum1pPGJrDWn+8J1a/rp4Q7JC3VbjoW5OYFr5iQKsjtagwZd8GowqhrUFzjNiH8TSU0yRwM4oHIzHmGxyKu9x7HSLWzxSrrjD3R6ilpANHTA+pqjbjfQFzaIvkFliVgoCtlgKDS7cbEdwE7sy6JnUvbd14nVPkZ8K+8G20AlpQniwG0MmOFtK52N1sjnnTyWFHfRgDGI3+cuLLVndwz2bqjhfRemfwG+gtKhS2gjbtgMTm6qrYELEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602251155; bh=GwhrInnx3caoAhAKcM0+KPxtak9OKmOMyZAGL6d7eg4=; h=Date:From:Subject; b=tMwYr1ZQ00MOeTIqHRcEaOMlyzIy86rmHrm2fuOGIfjmp+KyBBPpW8IJcdXr64RpUSwtk4Zkjw/dk4O0D9mgH4doKOW880dTHKHdjUKninYOGlNaJm6oY0loiaJF+pgFly/kzVdOwove+spIndT8uDv2RjXSWpavEcsSS10TS/1IR4zhDm7RuvP2R2pxQnVuVv3aCJep3/Zy9kcGdyywBBjABCMFAaHBHBi6Kco+DDcglBD2Pu7+qERzyGf8n+3CLnWOOkT2alQYkOya98JhfVQSmCVR+bdS3NWqbwcZf0sp6qkLDUpMRfOvhEFyXq3zESLBYG1HKTq9jxLG48jrTQ==
X-YMail-OSG: tFBslsMVM1lklpwzDt5RjIvwdLS2x1f.ly8b_twEvlFC0gsCOHUZ9f2GBtc_EOK
 1j1djofjmi6oi8F6CJw7O_E85lvtjsiGoAdy5R1uRvYPo28Js.c_6_1EG7hDLcAdJu2EwbpQSh4X
 fA0gVRDqXVj0lMTmFD83rk9XP3D9Elyb6asTT8tSUDRkxrXksy_DN6gg50Mmk.dAyOvNg.Xo_1GP
 vElWwoyCh5vZDCTRfosAhrCqJ6ceyFyQgmsYlbsNx.84wPl_7Rhr0LTDwXwEoY9KfTEFVfpEP3Ga
 PHZX.D42sNSV_lYFTJZoDBJBHnR2q0Bv7YwEPv2KGtIOLFSJKf7ogIWGfHxEVmpYEkEcYAyVP4Jm
 jTeoLunN_33arG_ea3Lw1od.DjO26MtrN9p6u28TyVjL4ieFk2BmYB6L1uM72P8U9AmUFRt5723Z
 HuJ0201w3XWctJlr_oar5GFgb8GDdh.VI0cyQaZQcaL1SaE5adXBjpSGLqP5le3T36XQOBPtuiaS
 XdrGyt.qukgz1c1r9W3iVltiywdTQ2YfTL3FOyG1otRAZ3yL_GnKFO0IY8yfw68F3Uw347NAouip
 fNh9rMVLbWkLMpi2z2pJlhVL0Mzpg1AcIUKoluz2t4r2tKZ6gC8XHlCFNgVRjWhwKTmYNf1cvbKM
 I341xbk9vt2AkytJC4NQvOtPicVx8wCokl3rYNJB.NEudgtxBHXiUGaeexqlMerBYoZBwGZJVIzc
 oQPOuhs16POPpUIT6Fn4wKHIBSrLOebt9Keyi9nQNSsa4Q_4x.8ED84AJ_hKaOL2MpIJ5i4WSzyc
 LIKdWKvRZmFK.ST6HJAKPPymTZdrTQHJG2s7vgECMqjLcqCE7hbngg_moREM.ND9Euopep8ZZk6d
 t3sjhyyvzi5NX84QjFVapBygIZChcq3KDBUgwY0UTFp5Kq6lDaLGz9A_ww6cVhcaMV8TLXOv2Q9B
 ovZNmz0PdI4ohjaDflB7aaCphs1dJSF8LOQ60RykLB4cp5k_E718DtMmsQxZQ8AwrgzcC7U0cIqC
 RKdQrCbk_jAB1NRMtJY6dydr.E7uUrIsXDHA1y4HnkwEvNs5PKilPUofSr18TKHnJl3egRXFPpq.
 KhR5s2fx9reB8Z1EA64i6LEY195rKAjF0GDlsxEQP2uSlAZnAStCE8Jc0JeVjIFkHm.bCI5wZXqw
 TRgA8xTyx2S8qMsnRPDBUhDO3suhVpqfPeRe8lgEY66sfkky56pB8e90ehwi5rlgVF4p5ckRxbRo
 fejn3YZ7JYT8UL06Q_vHWn89bzJJ26IaCIXqcN9s4q7l8E7F0bs.V2RRvRj8s77lxWxnj5cm.Bpa
 5Lurl5P81SJfIorIB3tb1s98ewVKEWaoKmRiyT_BFWoCfAyizrAj2dxHDQRmgfDyG57_Cgk9M3un
 Jwgp8XsAoir.Cjg7DADngE5kNp5So.RuG.ipYqh0Tsu1idIDOvk8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 9 Oct 2020 13:45:55 +0000
Date:   Fri, 9 Oct 2020 13:45:52 +0000 (UTC)
From:   Elisabeth John <elisabethj451@gmail.com>
Reply-To: elisabethj451@gmail.com
Message-ID: <671309797.719219.1602251152248@mail.yahoo.com>
Subject: Greetings My Dear,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <671309797.719219.1602251152248.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Greetings My Dear,

I sent this mail praying it will found you in a good condition of health, since I myself are in a very critical health condition in which I sleep every night without knowing if I may be alive to see the next day. I am Mrs.Elisabeth John a widow suffering from long time illness. I have some funds I inherited from my late husband, the sum of ($11,000,000.00, Eleven Million Dollars) my Doctor told me recently that I have serious sickness which is cancer problem. What disturbs me most is my stroke sickness. Having known my condition, I decided to donate this fund to a good person that will utilize it the way i am going to instruct herein. I need a very honest and God.

fearing person who can claim this money and use it for Charity works, for orphanages, widows and also build schools for less privileges that will be named after my late husband if possible and to promote the word of God and the effort that the house of God is maintained. I do not want a situation where this money will be used in an ungodly manner. That's why I'm taking this decision. I'm not afraid of death so I know where I'm going. I accept this decision because I do not have any child who will inherit this money after I die. Please I want your sincerely and urgent answer to know if you will be able to execute this project, and I will give you more information on how the fund will be transferred to your bank account. I am waiting for your reply.

May God Bless you,
Mrs.Elisabeth John.
