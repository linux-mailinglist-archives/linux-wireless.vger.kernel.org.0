Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7116404E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2020 10:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgBSJYM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Feb 2020 04:24:12 -0500
Received: from sonic313-13.consmr.mail.bf2.yahoo.com ([74.6.133.123]:35704
        "EHLO sonic313-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbgBSJYL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Feb 2020 04:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1582104250; bh=KB5k1+sCGpSRd9pTKc0P9/4ZGPy9ZVtmix5g8Hf7Eac=; h=Date:From:Reply-To:Subject:References:From:Subject; b=b9WEKpkhlinmHq+39VYH4BbD7FBsdXr7u15bY30noVqPvDs1Np8+YjX61EuqeQD+3oHvJ0aQnFUaHADtBoP29waIc7fZAqq5BVogPBpQ7+6ttReE6dBCk4+2I3yrLtyOLHiOT+zYiuwo2gicI60lGXgMK8dhMZguhkQvtce4Tuv+j0El6Wo+Wt2CkxhhXoWFlq9tI0B3jRBTaOmkoZP4UX4HoVjV4iwwBtPM7F+xUVxtBsz7a3CQmtAve4SuWhWaK18+BcQFVqzbOUzgzaF0VQrzxQPlZxhApz1gNtcIcx/2iPwpheUApM/ichOWUkReyhaQ333nu8CEq3S3bE8wXQ==
X-YMail-OSG: P_eaQMwVM1ndgGfWMKl0vZhRfXnooeWl9SIU1FWQxGiVGRrWoyist_EZtpeDjIJ
 UCnQ3SRm9qb55gS9_h0ULrGOPxs0pnd6FQf95yjwfJCSORsIQRy_1qvM7daPM4UUF_WJ2.kuaZhr
 YY5uAstAoZ2JKmXyvB9dcS7AsiuAovmPHn.kVuAEstK0xcleBgneho6RTQ2g09tkM.dLiOMhWTGA
 9p1VExg__XIzv8daoL5nH3Vr5PkXVaR2QGJImSfYs6ZrFw2OVEYo3_As_vRdeUYjVMYnQJMBwAoo
 4SwDHvwg6aM.gG.wmyFN9qJNvAKucdi4fiYHafenYBgOJaiS61pqtG4YpjeKM8me131aR.P0UBlW
 SAxjKWr5p1E2XTMWFu3YXHi7d7VM.clNyxpWLynaSojF.fnWQ_N_gnrBJ00ErooQHvz0G4RIytqz
 wSIuyOOTRgD060w6iSxSeiXTkg0B4gHfsiBrg1MoHda0_zePEQ97zLpOe0Fnfts2_bI5c56dAUOm
 uE164FFyvVVaRYDk1_OKGrZTbLxfYyPNVsqpYZUKEujgPuLHGDo7NDWi7PCcDyNZl.B2OUbBcFXC
 CWD3tUti4rRQ.vqVdNtnAQDHbpg9_rM9Bk9GA7HvTfG4MWBnIpY786.ZbCyu49rqpOyPUHyoMzys
 HhUadHxqlYbD43XW9z6UVuXA6QpYpgPn7doUHijBx0bUv_zVaaYAgm1gxuAlzudTYR5gT_mnkVZn
 u.F7upSib7TbaBxZ7xhNUWX4Anozag7e2P0e4E8AUJ428ydDuWgpBQQCBz0EX8.eHvhZoNMsr4FD
 kDBuvtQ0_p3Vbu53F6GzvobMJnD8VUbPyL15FPsccUMfN64FFTXT5DDJJnsPbCojpkCzeLrHW5C5
 5FqC79gHVEW_YBIIjX93i8jFQUsHuyKmcpo55XZHg8kZPJzaa4_AXuggJEBnq1voRJsdfICjfQsw
 D_22J.5UFqwz.i.BSCTJ0zYRi4UsxIQXy6nPvub.D07RZTCnaK14ONqbYbHCjpqpW6POx7GJP78n
 2oEdMV..KPmpKO0_d9BpLG3qMX3TRbsPZfniH4hWLsZLkAjPcm4ayBEWdUH4MXV6SR7IbSBQcvmE
 .AU9qshmoGfKSEhuNwsiWV2kN67uCFcTkBr3khFkVPOI6VvcKRzU7LAdfkUS9XZ6taOSY2oyLe.4
 IvQZBSUrFf8YjkLeD5kvYm4i3rB2bqhMC2VfBbnB.pHWt1PWiy_ENmMwaFDz960Sn13dovT80GIn
 l37oZSrFqwHIQBRaQ6LXDuJunj9mvq5q3cWlp8xO98EKwYXLlxt0rwZfEuWTRICDoTtlwcXA6Hwc
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Wed, 19 Feb 2020 09:24:10 +0000
Date:   Wed, 19 Feb 2020 09:24:06 +0000 (UTC)
From:   jerom Njitap <jeromenjitap10@aol.com>
Reply-To: jeromenjitap100@gmail.com
Message-ID: <2017596654.3644647.1582104246363@mail.yahoo.com>
Subject: SESAME SEED SUPPLY BURKINA FASO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2017596654.3644647.1582104246363.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:73.0) Gecko/20100101 Firefox/73.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Sir,

This is to bring to your notice that we can supply your needs for
quality Sesame seeds and other products listed below :


Cashew nut
Raw cotton
Sesame seed
Copper cathode
Copper wire scraps
Mazut 100 oil,D6
Used rails
HMS 1/2


We offer the best quality at reasonable prices both on CIF and FOB,
depending on the nature of your offer. Our company has been in this
line of business for over a decade so you you can expect nothing but a
top-notch professional touch and guarantee when you deal or trade with
us.all communication should be through this email address for
confidencial purpose(jeromenjitap100@gmail.com)and your whatsaap number.

Look forward to your response.

Regards
Mr Jerome
