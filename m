Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30231232750
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 00:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgG2WGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jul 2020 18:06:33 -0400
Received: from sonic305-21.consmr.mail.sg3.yahoo.com ([106.10.241.84]:43809
        "EHLO sonic305-21.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbgG2WGd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jul 2020 18:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596060388; bh=fWjln6K44Eskt5xJ54p36XH05v6HgNA/YUSUPVdtmXQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=drXx6Pui6u79iFHerEJS5yFeD6ckeNCbPelfMxpBWczyAzfR1BS4OlshYOk5EWbVSELmOpkSBVhOiTSneU/KChc7/XrraTlLn2olPh7t1w6T/izGWPYRlioOOoAQNCc9EYKmX43e/dzLZvU2BFQnDUHgvGeU5X5e0QBFNYAg+Bx/LiC0Rgi/AF4aeCOrxFaETGnZ063ym8ot3/xy9UNyN9rvGEbffYchJcDTGrSBuX4+O2CETs7whnOoCmFRSju6XIVCVeIFEkeKueT8/Z54Hdz31u3mx/4wIRCTt8J4rTUxFc0aIMknZSL2L1rxEpe1J518NnZk7RDE7CA3zRXCpA==
X-YMail-OSG: C9KlBWkVM1kDjaVQZdecNuQmeZvQNHMMF_ciACBI4tTqBksOxnGGobLSMCqY4_e
 CjskP6C0eidnYqQSposLRSLQmtwxLwe4Zm.Wc.id0BWXwXD6Sv1bQ7RTo7YaaHnXuKOT3Nh9PGM_
 f7qFfQsVOVTqxqV_qpnnSWVa6kq555A1po2Sa1CCh7FwNFRcUAER.BH504iHmmSkxENB47g7Endd
 GcF5KElFGGja21XZgtlO1dN.aaBjKP9pwnuIKTLB0Yd_vEbPQKUCtIKe6SKvRgOQEAE0zFZVmQuy
 y2IkRWT4fTlGIYEpw6qfiiQ7OZJxl85YiVXRGW80RvK.UVgCI16UWO1_c1qGtNCSp.lbyi4z9LtM
 pjpP.sYYVAdR0Hq86uJyXUCojTxb.ncOWrJqJ.Fy38JWSWhwnJuyUAz1Hw0I6DDN33nwCcgT8dzV
 4DrRRxp_SwLzYUWrHEeL.1RNgME3.Xbck4FVxSTLFriKjVWZV4z7q8pqzUSXJFx5WMsJ1COpwJ1f
 aA82jk.jLw4RMa7_NOpKOVACe9xjdmB3wm0ZGq9ompCyeKB1mYcDAqyYOm0V6xNIgSzF_lyGJ3Mk
 XLP.dHmlVK2s2vqZwXM_Oq.voZnva066gKhbWNaapU4Nugrc.pRPsxzqalDJk294GNzXhs16ijnQ
 tgqrh2e5NLdUWkyVqBarFOl8Zf.ER2McMeb9L3MxDJRLEdWczLLR.pr1gaQzP_Xee.4EllI8J9xR
 DIj8L3AiHDjOQc0UeKcMSP8lts1Kt9TYLGNv4xJqVHsPzHKuFwSbvQOQeepzAoaQP734itIpHUwA
 kpI.xK0RW2ZmAbg3DUBuUG8g8j5a5pn3MMAseCFajgFMWDFMRfEV2S94.1weQPJrunB4p84Bzrpp
 4V1NHfq.aMTEbrpptoUuT5IiOzDD.fYE7tfU0z8w.CLsX_wRjgyKqGI99wESbp8SX5ulJhg1c1XG
 Zt..5mUABG5fbAw.G5Ez2BxRF31QcixJU1E0T1vccovHErUzemuwsHY0Sm20HlOfnnzJgLG5Od4X
 QXQ7FtnyyfobFkp5bXgsv5r0I13FLJ1od_YrQ8UrYC12U0dLl7glCkbdDSd07AcQ6OdrkAF8y5P3
 krJuElwcwFIT.Wzq4AztBQDvnVxvSeEesPQ0msbweYJwc1xVTNGxR2XyfVNH7hVCHsgnlQ7vpjf0
 Q5WQeK1DBd3KUHrP0CJUHRgywoaEbK5lJfmZru9umYOW7cUcIveRPjobaqaRDMydCF3WeO8YvMN.
 kGtJlTOz.bFM1hJ0hzbVYpq535mf1WjiG0jyluQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Wed, 29 Jul 2020 22:06:28 +0000
Date:   Wed, 29 Jul 2020 22:06:24 +0000 (UTC)
From:   Celine Marchand <official017892@uymail.com>
Reply-To: celine88492@gmail.com
Message-ID: <1117425258.7485600.1596060384026@mail.yahoo.com>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1117425258.7485600.1596060384026.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Urgent attention please
Dearest, how are you? I am sorry for intruding your mailbox, but I need to =
talk to you. I got your email address in my dream and i wonder if it is cor=
rect because i emailed you earlier without any response. You should know th=
at my contact to you is by the special grace of God. I am in urgent need of=
 a reliable and reputable person and i believe you are a person of fine rep=
ute, hence the revelation of your email to me in the dream.
I am Mrs. Celine Marchand a citizen of France (French). But reside in Burki=
na Faso for business purposes. I need your collaboration to execute some pr=
ojects worth =E2=82=AC 2.800.000 Euro and it is very urgent as am presently=
 in very critical condition.
Please reply through this email address ( celine88492@gmail.com ) with your=
 full contact information for more private and confidential communication.

Thank you as i wait for your reply.
Mrs. Celine Marchand
