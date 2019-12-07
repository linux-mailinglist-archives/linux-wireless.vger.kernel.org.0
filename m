Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C70115D52
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Dec 2019 16:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLGPVM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Dec 2019 10:21:12 -0500
Received: from sonic317-26.consmr.mail.bf2.yahoo.com ([74.6.129.81]:38354 "EHLO
        sonic317-26.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbfLGPVL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Dec 2019 10:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1575732070; bh=zPC9p8T5S06DA73PD5F75wViZ/EpBpeYylTS7OqjCU4=; h=Date:From:Reply-To:Subject:From:Subject; b=kuJy8cGzjbm6zyPpYcSuD/vge3S+CCkzMoRaUxYOvOGvEPBvDHGfSihvqJKRKIP+nVlHR9TOQWwDtd9puhMZ7X0BYSC8RHa9JmfFL1AYr2gHBWJYkK3oGDkxG5kidrbANKZ2fF+2H9BWe3Dk2D3WmUnFa0tdtN3uq15xTdmdi5zjBDNPoeDQ81oUcseud1JtEMvTwg+JpOHlXMNb0NvVsnCZzfjAYeBTmE4HEQtCw2iG2RaxbUKH9JZpRwDSMXmB346fOLo0o/I10DtRGqiJR/XKdI+QxJP865xWsFx16IT1W1eZj5hOzEYfzFf1wSb75AzUOECOBgGXOUq76tvzZQ==
X-YMail-OSG: v4s.g98VM1lltKIB9WKuW1wKdsBWI.fh.FCn0UfKMVa_TOWUVtDL5OmroElP0WT
 RmBylL2ue58WCTify6.RfkE6_vGnfrKq8dAaPbRko0h6YVbBFN3Z82Et4hsPIO91Hlft0gcGwSaZ
 g9PydE7NSX49_KE6rOreRFY40lw19XF.HiRcy3Fyv8coe7aiucHNhSM.c_I2yJstOm81P1CIJg88
 mTyWWqG6jfcV6VfiE12USiLkDw63.VLJ58EbFC7w8p1mdhMAicjbK2i0vZAS93bCPUlmIqaqVCnL
 AxCMYl_3FkdDJw37eJHVffR.9LKz2rk_yMdyMiTr7Of9Twfq16et5jvYyuFtjYoyIFslJ6V90bmv
 OtfiqhenbRQyRSBYYj6CSXb8X4WxpmAo4uiD8CZoZTnAm55MQKKljbfLQCKwdHAbXkQ1YbIFt.bd
 PPNsBq4y9V9KKT.moZm_WmC0e_S6cPY8GJrK3iN6zcKyWQx8PaYf_fYuFp4.lemVoWtoiH6FlgMn
 XNzDXKORjlmClNVp3_CxDZyIycPPB7QR_.jehTMtL3Sy3n7jJ86SUtO7jr4XApTX0QDeT2owqsNz
 EOUTWih1Bj2CxWQSMDOaVkPEwkEA0rPxzlaTE.Dx.H1XixL0MJcJ9IFpjXmd.jVq1ifJ8ZTuMJql
 3eHbQBhQJTUWey8ojsGz.z5zjCGMlpEdushglZwSyzziFcDmNTqGIuikDM3IGhSSUYTsTecSoNii
 DtyqgwxLPXwi_S6akBRVeXFwZsoEvSrrp9yyAHofTGZIZ.jf5LCM4QYhUzjNfnABa1ilJyoNlJ2R
 6KLlAuCG1p3GYdSIq6ccGTfIJwBxPx1bbeyXapb7Xi4YQGybJVs6ALwJknmGXaPES.bbjAcDHnBi
 WV8Do8gt4v6V6jjZlRj3bNmI8vuquFEh.QQtNe8orW3.49GRJUb5vDny3iycuyaQ0lfvsnF6rvpU
 wlVOaXweBg2zwrs60Y16uNBzBQnWbaDbZqwKySVdrdUE.u6TPJGbHacwdcJKJ2szJ7mr0quTRyMd
 ejJ1B319MdHH9OSes8qqW1DEN0yNwcicaWna1517fA8hz5c8Fy5SKFnen8RiDtn5_HAuhN.owkLq
 6aZvkBWORSaST1kG4HxUqhnTIhA9Qkt.QVnd7BoD3phqPlGkrJzdoJtW6Z5ZnfVWh.lI0DKEsYPQ
 7A3vLZwL5aZaaSl2NWIr_N7dJSEPTz3OWR1CYtpZOJV5Cjd1eh5BtCDTWeAqPA.PgY_tvu3EG1XF
 6I1pAIrIHuhFNwjr7eYUnJIeXZgVUFBT6V5PSpS0bsDWeZKPuTQ8KOLG_Y8G.HISpQsQDkCn.252
 a7Cslwg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Sat, 7 Dec 2019 15:21:10 +0000
Date:   Sat, 7 Dec 2019 15:21:05 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh222@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1183044059.6687849.1575732065141@mail.yahoo.com>
Subject: I NEED YOUR HELP FOR THIS TRANSFER.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me forsuccess.

Note/ 50% for you why 50% for me after success of the transfer to your bank
account.

Below information is what i need from you so will can be reaching each
other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa Hugh
