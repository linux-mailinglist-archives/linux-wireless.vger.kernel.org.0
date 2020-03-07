Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8332E17CFEA
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2020 21:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgCGUHZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Mar 2020 15:07:25 -0500
Received: from sonic302-3.consmr.mail.bf2.yahoo.com ([74.6.135.42]:46852 "EHLO
        sonic302-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgCGUHZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Mar 2020 15:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1583611644; bh=iacnFiNuwClBuBYRq2lTmctydZVIx7u3n0jKyEZOUEk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=EtA1c4yoUgJHsTf3GXIO9LYmy75ZABDt7ltu2JCU+t1i2Xmc+SMZOq6WplLOB9w7NyN3mpGiSADqcLaGO9NTVMySimDlAkhZ9RR3F3pAhsfWJe/NBVNpOunIqIVzBHGJ6rX/bn9pUOueyXRYzUiigxNDEgiIeF8znNkKfaG681pq3jj5A5YX9GBZQSReZYH5OItsFG2q3RGeZEWm7SeqVcdCZ3KLkgvW4G5HBpd1QACXI02Z/ZRepQntrjsWRfl/27cm3qNQXbrVgWAjOxFWFHeU3MGhV+Yoevu2yVQlsLrYNUW8ohN2jqXHp3aO+WUSfH9izvhyHEZFsmLjSOmZnw==
X-YMail-OSG: jQOhAycVM1m00Cs9iIv9P7V0Sho4iyZ8ppV2MYffDAZBaRyWLDMD_y7g5CQX_Kh
 LehaBWPA1kdrCzZcqeNqnI7oAcWgus40VnsNTT5NJ1z7Oa.70CcxsE764oPtTe9mhA1iEMQ6J4nC
 kmNWRi1CZO3ydCLMXrLZGFFBfcJxZro9HSxdg3Nk70jyAu3eE3SnLfr5jIaiARHf_zBmX.255wo1
 SmGhDKO.zbvqxBhURdOKWiJO7icqTB90t6Of7lmHVHqO3h1sFkRtLgtwdTUpMRt2Fga2dLB26pH_
 kX_UTAYiX4k7lvrFJMisBNI6.cMiokV6RcoVLVOEjIz79rSstsEvqOjmVuzkKGK1Tdly2EHFeKOz
 0mNggEMZgtI7JnS3Msm5sy5WnGYkLg_2oAGj8t9KqN.bSpkXdicsjfe6X1TaTlX.oSUjZM3zMFEi
 umgha58S50gWGRsnUdRpRWaAlN0fPpAcd28dmC5hQjtsZl7xW8zsk48ohEvYvre.eda7qQgP_HDu
 LDUg6nQy6O0nn0EWfpquutDoKMpGpR1aOLv6de.rf0dInvoqj3ES7vwswWr1V4x3DY6V8ltYhpsq
 bY0pG5UJ5Ft9PawtWIaOxYox7knXvy0_T9Tcu8Osfx._pPFUfKspV4SOiIr0x8FkCABBnvGaoE7L
 GB7K6UBnkkk192Pq45soXKP5M9nECDxRgz9r02WqTcMAlorH0TEye_WpbShJy48CekJG9u0pg.LM
 2OufXCWcWs1VQvYDRXzDJl9ChQec7EDYFp634MzaP4jjMKjVo4rzJf0gyRPaleuM5t79ay7IFW2O
 jqFSEQ3JqxpWg2SLQtd0C85QB.xb7q3AHi410G1EhyFX084kxj.F8q2iIxAE.bSjAjMsTt68d_7.
 fOdLXEnEsnBtRBbu2tgZKf7ZPdbVtdflqXHkAFF1cnh.se4pujwTeU.b9b36F.155ITTOO6Gqjir
 bdYTLVjO9nbDJzX8jMhsF1VCCEwBPBOnJjF32NHBIqZfL_hWG7rnxkIujzk636RmOWCVZ8ueO_Ov
 GwTq8J4rv.cUwfAyoAsbC0Vy5uZ_kLVrTuNc8y1a76pAyXbL5qRRmbRmLEuH4H8E0G0KZIbAdKgj
 dwH_MktOPHzVJc22I2SlhyKSlSySUiuxSmJ.qd7E62Hd1WtEv4UHlob94W00oQRfx8F9lqH1mcPg
 VvKPbDNoTWLbCQvDwk6xCIZoOHf78nNwwxulAgXhdurufJi9dsS.cISVLuBklfRq3Qo.ziTDyIiw
 5TqmyMipxy27h8yk2PFv9GY3XO0lncm2X7OZF6L.u1bvcEqwVGFU_KwZCAZlLrDJJHng-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Sat, 7 Mar 2020 20:07:24 +0000
Date:   Sat, 7 Mar 2020 20:07:22 +0000 (UTC)
From:   ABDUL MAJID <majidabdul55@aol.com>
Reply-To: majidabdul70@aol.com
Message-ID: <602307896.959161.1583611642415@mail.yahoo.com>
Subject: Hello Dear.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <602307896.959161.1583611642415.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15342 YMailNodin Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:73.0) Gecko/20100101 Firefox/73.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DR.ABDUL MAJID
AUDITING AND ACCOUNTING MANAGER,
AFRICAN DEVELOPMENT BANK
50-54 RUE DE THOMPSON,
OUAGADOUGOU, BURKINA FASO, WEST AFRICA
 
Dear Friend,
 
Greetings and how are you doing?
 
I want you to be my partner in the transfer of the sum of $38.6
Million dollars discovered in my department in a Bank here in West
Africa and I will give you more details on this when I get your reply
but be rest assured that I will give you 40% of the total sum once the
transfer is completed but you have to maintain secrecy of this deal if
you are ready to work with me.
 
Yours Sincerely,
 
Dr.Abdul Majid
Auditing and Accounting Manager.
