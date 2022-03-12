Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283054D6DF9
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Mar 2022 11:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiCLKW3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Mar 2022 05:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiCLKW3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Mar 2022 05:22:29 -0500
X-Greylist: delayed 507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Mar 2022 02:21:22 PST
Received: from mail.longlandclan.id.au (eth2015.qld.adsl.internode.on.net [150.101.176.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AF64F18
        for <linux-wireless@vger.kernel.org>; Sat, 12 Mar 2022 02:21:22 -0800 (PST)
Received: from mail.longlandclan.id.au (localhost [127.0.0.1])
        by mail.longlandclan.id.au (Postfix) with ESMTP id 967E7808DE1;
        Sat, 12 Mar 2022 20:12:46 +1000 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=longlandclan.id.au; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=
        virtatomos; bh=3BRMAV8KQIuiCCpC2Io1EsA902M=; b=wUBxk+LIaIWHf6CEB
        2R5RYr2YXcBgtepxyE+K/bsQQyzKBtIc1jxpx83FF/lwbifR03VOOFCvWaBqGL9F
        hpByzL8S6spPm6ILJZ2O+Ju9w1Yd/9leAXIFqq2w4ZiTI+mHlARMVOaT0Ovy88ox
        DVJsQjjJuliX/g3IM6dzECmqnFMIJFF/yJasdFoxd1X46uYl9dgcc3WeKGREvdMm
        a86y62P36mac2+S6hUkvOZP/u8HeP3HtVYB0NZm1ZnMzrVZG32E/7mF4gD444y6s
        datPoSQK4+Ra08eJacl44sgt+QPvljmkYPioe2LDNQFQhL+61NE6xRQXvpsZCcWp
        CguPYtvs9vWv2Tq+ns+ditA14fDMWeWuXWPQDuIUMIhhWnwFA05ocT7OH3tn4t0p
        gzIyoHe0McmVtkWO93CDi1dzDAXptp3fxvhjaGRbLYVyg7T0l/wymksbV55FKEEb
        /rG0VSGmBoGJOwVCFmA6y0q2w2tRFttPtAKwyurmpk2JM63N38YQi61Z2riPtB7O
        idN1VBICBotEuuF1gaxGnX7opPLBXkGpsNaARz9zYXvHpbddGN7fwXbNGXMzB7gr
        Xzg6mxFRQEI3dOrOQsmClJwo2+wPoLoHEtr4F9e/Pllmfb6PKNGdVf0VZT7gPSek
        Yddsr3pt9bFXdPBE4q/fugDg9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=longlandclan.id.au; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        virtatomos; b=SjW1ehGsymllfYAah08+gF4t7zObA0fOCkDWEoIAOAlsXkp0fZ
        IglsvZHtSfhvspo5CCFX7uTlE+89hzHFrUZ1ITe4c6Vu2pPP4hOG+Gktu027N6tc
        EnNljqwmlXk3kdNMrMaUmR4dGeOUQPaqE9NsnNaVKfprBsKb58Urr1cCJMzR7x+p
        zotlGy2Lnf6elTh7zCM12nUMuToPNXW/eFiqQ35OjsZPhC22Ts4KX+SnSNUalRce
        Ug1hB6aQSPlvunREy02XxRgc/OvdxCtojyC2WllmpqDzJZUC5ZLdpeGoC6bpo4rx
        YwUP/TWLF0Iv1k2OuR2Owa5AORMq9sulcVzQEzPxFyKHJ0isSobpr413wahd45GV
        ad/37VJj6ZbdVdoIOqjZXFhhz051I21/UuLZ2T/05L3Xk3PvrmDY2sPOFK5ddI+f
        253nguoE1Q6LADfYj6RkI5+K7VvfYPOJWZfQnYhC7L6+dUL2sBzZwDFOJrh9OW8H
        gu37ADWYZtMWQHRv5EqEZq9wehjtc6wd+DwOWyRXC6wKgZNaqr8fCDtwSZZvP/bn
        EDwMY8QeGpVJH6wlLw1rkgAG91egf/TbQSUyoR3Iu65dai5OL0tSnmOISJ0DUQ1q
        gfT5iFCugzI+aJnyxt1prtaQZGQoQVLGBDMjcI2ztioiC8B5diqYqRC24=
Received: from localhost (unknown [IPv6:2001:44b8:21ac:7053:a64e:31ff:fe53:99cc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.longlandclan.id.au (Postfix) with ESMTPSA id 1A2B1808DE0;
        Sat, 12 Mar 2022 20:12:43 +1000 (EST)
Date:   Sat, 12 Mar 2022 20:12:40 +1000
From:   Stuart Longland <stuartl@longlandclan.id.au>
To:     Pkshih <pkshih@realtek.com>
Cc:     Bogdan Nicolae <bogdan.nicolae@acm.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: No support for Realtek 8821CE RFE Type 6
Message-ID: <20220312201240.48e27a63@longlandclan.id.au>
In-Reply-To: <3f5e2f6eac344316b5dd518ebfea2f95@realtek.com>
References: <CA+ORkNR97EvqPzHu-CoJXwKGH-HQ4B++57RE88MEF-mG=D=Jeg@mail.gmail.com>
        <46a80ab50f594ec1af1016ca272e82fd@realtek.com>
        <CA+ORkNQ_shEZGYQUmRT-_uSp3xkFA2fvfUbyGXzGkP6AmqXf6Q@mail.gmail.com>
        <e57352ddd0644463b398d6dc0a6e6a86@realtek.com>
        <CA+ORkNSzju=Oj4wy8s258exeWOSLEHRAfCoS+ViF-rprdtEr6g@mail.gmail.com>
        <3f5e2f6eac344316b5dd518ebfea2f95@realtek.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 8 Nov 2021 03:28:07 +0000
Hi Ping Ke, Bogdan et all=E2=80=A6
Pkshih <pkshih@realtek.com> wrote:

> Thanks for your information.=20
> Since we don't have this module, I'll have internal discussion further.
>=20
> I have a quick look of RFE type 0, 2, 4 and 6. I think type 0 and 6
> are similar. So, could you try following patch to see if it works?
>=20
> diff --git a/rtw8821c.c b/rtw8821c.c
> index 80a6f4da..1b86a21b 100644
> --- a/rtw8821c.c
> +++ b/rtw8821c.c
> @@ -1513,6 +1513,7 @@ static const struct rtw_rfe_def rtw8821c_rfe_defs[]=
 =3D {
>         [0] =3D RTW_DEF_RFE(8821c, 0, 0),
>         [2] =3D RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
>         [4] =3D RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
> +       [6] =3D RTW_DEF_RFE(8821c, 0, 0),
>  };

I'll give this patch a try but I stumbled on another machine with this
particular WiFi chip=E2=80=A6 the Leader SN4PROv3.

I have 14 of them sitting here=E2=80=A6 all victims of the 2022 Brisbane fl=
ood.
(My workplace at Milton bought a lot of these to load with Linux and
run NodeRED flows on =E2=80=A6 then the Brisbane River decided to get out of
bed and check them out.)

Despite this, they all power on, and I'm going through and assessing
the condition of the survivors.  If there's any corrosion, so far it's
on mounting hardware like screws, with little on the PCBs itself.  The
machines were in their factory packaging at the time.

I've got three powered on now, doing a test install of Gentoo Linux as
a stress-test.  Two of the lot are happily talking on the WiFi network
here with no ill effects=E2=80=A6 barring the odd complaint:

[    4.076641] rtw_8821ce 0000:03:00.0: enabling device (0000 -> 0003)
[    4.084721] rtw_8821ce 0000:03:00.0: Firmware version 24.8.0, H2C versio=
n 12
[    4.108215] rtw_8821ce 0000:03:00.0 wlp3s0: renamed from wlan0
[    7.196982] rtw_8821ce 0000:03:00.0: start vif 24:18:c6:cd:e2:28 on port=
 0
[   16.273500] rtw_8821ce 0000:03:00.0: sta 7a:45:58:c8:b4:33 joined with m=
acid 0
[   16.801990] rtw_8821ce 0000:03:00.0: failed to get tx report from firmwa=
re
[ 3104.402095] rtw_8821ce 0000:03:00.0: firmware failed to leave lps state
[ 3844.402114] rtw_8821ce 0000:03:00.0: firmware failed to leave lps state
[11020.402339] rtw_8821ce 0000:03:00.0: firmware failed to leave lps state
[11404.402353] rtw_8821ce 0000:03:00.0: firmware failed to leave lps state

A third one reports the error mentioned in this thread.  I'll grab more
details when I get it onto a wired network (at the moment it's
isolated).  Sadly, I've just nuked its Windows 10 installation.  (Not
that I expect such an OS to run well on a Celeron N3350 with 4GB RAM.)

The WiFi module appears to be soldered to the main PCB: not removable
without a hot air gun.  Seems strange that the same model PC would have
two different versions of the same family of modules.

Questions:

1. is it possible to read what "RFE" type the two working units are?
2. is this RFE value derived from reading GPIO pins?  (i.e. is possible
   my type 6 is actually a type 2 or type 4; but with some Brisbane River
   crud shorting pins out?)

--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
