Return-Path: <linux-wireless+bounces-7632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C78C4CA0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 09:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61361F21B6C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 07:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59B101E2;
	Tue, 14 May 2024 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myKq7mnw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F5F9F5
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715670656; cv=none; b=s0UicDLLajxsCgJQtGw1bF8+STisCKdrr5rLBJO26I1aG5des5RF0AnxHEQeh7KBvennePZVztTXT25VmSmYyoKQb6ezlC5x31YJ0ElzHH/Vo2xENz36TE6tkzysMgir1dQO4wzsl4wTqLZgPhLnQpsdVtypqexMHA+hIs8neZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715670656; c=relaxed/simple;
	bh=OCSFsw++B9g1fyDk62bq0agzH+leGOJzH4rhkxVycRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ltaj2AXT9IGn7cdfWJ6jmM0sEyJew3S2FW35BvNl9/mHEWwpJ2nRFsx2lLYH5x+nqxYImN1IcxjjWbcq1S68itwulyIsMqHf2U96DCeHSTe+gPVSp4xdpmTpKMpXsOIhckEgqPe/nIpXqIceBybmWR8LiFOlHKXfqki7210OUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myKq7mnw; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so65658941fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 00:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715670653; x=1716275453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLHuXjcB9wGRV6ntL/09JIOWd3SdQ4ZnB3JttymsKLc=;
        b=myKq7mnwM8ZKfeGydxVgAgflr4ZnUr8t+aMnogdtTkWhipp/HChWSKo3K46/AgLwDY
         oPDU8CFm4Iwhqko2GzsxyVUGb3X9KOoXcOAl7x1PH/i/93JsD7Snr4ElUPHGHt7S+JBF
         qAKGLEwAhiwgjMlWeRwincrcgFfwhx2Cp2Mx6TTu8RkM19OOY1BIX8m4afchK8pIA3iY
         IOq2bTXrUxdHUX+DMD3wW1vbQueiJ8KWI6u8p1IyeoUZfTksjA0Tg8rqhyK7sDN8WjaV
         2MLpt9xmEIWK25pT2EuVJHYnonawptRXwIUkMcCcJyutRK/ZNHmg9W3vEQU3H4P0pRrC
         UFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715670653; x=1716275453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLHuXjcB9wGRV6ntL/09JIOWd3SdQ4ZnB3JttymsKLc=;
        b=xPP5NnqasPLnsTzBAA0ID5iXxptiy/EL6smaZIt4+zUvePp9niColJ9LigUdlEyCQ+
         bPhKHG+2n19/39ArbMUMdJ9xMSVJyjVdANXejQUhpRol7Zu+i3kCtRBUD+dqOOemkufc
         CHqo2oRWwoZZD0nhCejr/38vTcqo6Lnq3M4qRSy+SIGx0Gk7ZenzOiKOtcImGmP1wNuK
         gpMgTigeaxMPcUusEyHcvEi5Ori+P/Yp6CD+INj9SY+9DUJ2xHyvlrdO7AAjp2VezDzI
         VJ/gVcFyMll6BBcToEl2v3K0F0b/B7FI/hyI+jRtivuSC0XOe1FBanOs4blhkcmObSZa
         O+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUuEmF155Py3CFwZ0lBZiFTLJiRPZNEdIhMOQn2SBuAMxIJqvVbxXycGWKF7odKdqp9cRhmSY4uKfegUOL71zT6vtq7GnWnzu/EffLy+GI=
X-Gm-Message-State: AOJu0Ywrc6dlgzKaPxoekWWoDLj9Yo3Mke2SETddBEwf+2lmMPfDjX+S
	0a9HULkHkZkuOAygON8x9jhy9kH5CM0NEaimt5IOfMTLVrCPSxZISel3cENrp3mTpAE67xLz0hX
	2yRYK3oN/JATnzV2NmNYWMVrdEeI=
X-Google-Smtp-Source: AGHT+IFgAy0YOtgtVUXQWVAvidg7ADW0AJ/Anz9p4HQd7qYZxQFow4qu2PomiLh9xoibAZTn4ea4Go7rO67BJpjoL+0=
X-Received: by 2002:a2e:93d7:0:b0:2dc:b467:cb32 with SMTP id
 38308e7fff4ca-2e51fd4a7c4mr81612101fa.14.1715670652553; Tue, 14 May 2024
 00:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b0aa2d8-4e3e-4e50-8c04-f3a2637bb18d@axians.rs>
 <PAXPR10MB4948B9B69A8D9964B60BB5F68DE52@PAXPR10MB4948.EURPRD10.PROD.OUTLOOK.COM>
 <3c136f96-83b9-4989-92a6-9e7cf79d7e5c@bootlin.com>
In-Reply-To: <3c136f96-83b9-4989-92a6-9e7cf79d7e5c@bootlin.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Tue, 14 May 2024 09:10:40 +0200
Message-ID: <CAEyMn7Z51H9caXT9UUO4zP7gBn_NVdG_VQgT+AYmgr+qkrknfw@mail.gmail.com>
Subject: Re: AW: wilc1000: error when transferring large files
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Heiko Thiery <Heiko.Thiery@kontron.com>, BUKSHA Kirill <kirill.buksha@axians.rs>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Ajay Kathat <ajay.kathat@microchip.com>, 
	"kvalo@kernel.org" <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexi,

Am Mo., 13. Mai 2024 um 10:58 Uhr schrieb Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com>:
>
> Hello Heiko,
>
> sorry for the late reply, I was away from computer most of the previous w=
eek.
>
> On 5/8/24 08:36, Heiko Thiery wrote:
> > Hi Alexis,
> >
> >> Hello,
> >>
> >> I'm part of a team working on a BSP for a board with a WILC1000 module=
 from Microchip (connected via SDIO interface). Currently we are having iss=
ues when transferring large files over a WiFi connection. Here is our steps=
 to reproduce:
> >>
> >> # generating file to transfer
> >> dd if=3D/dev/random of=3D./test_300mb_file bs=3D1M count=3D300
> >>
> >> # transferring a file from a linux laptop to the test board
> >> scp test_300mb_file user@192.168.1.25:~/
> >>
> >> During transmission, the connection speed drops to almost zero and ret=
urns to usual values after a while. At the moment of the drop, we see the f=
ollowing messages in the kernel log:
> >>
> >> ------------------------------------
> >> [  138.016229] NOHZ tick-stop error: Non-RCU local softirq work is pen=
ding, handler #08!!!
> >> [  140.001682] NOHZ tick-stop error: Non-RCU local softirq work is pen=
ding, handler #08!!!
> >> [  140.009719] NOHZ tick-stop error: Non-RCU local softirq work is pen=
ding, handler #08!!!
> >> [  142.003636] NOHZ tick-stop error: Non-RCU local softirq work is pen=
ding, handler #08!!!
> >> [  142.011670] NOHZ tick-stop error: Non-RCU local softirq work is pen=
ding, handler #08!!!
> >> [  144.006676] NOHZ tick-stop error: Non-RCU local softirq work is pen=
ding, handler #08!!!
> >> [  144.014709] NOHZ tick-stop error: Non-RCU local softirq work is pen=
ding, handler #08!!!
> >> [  146.007049] NOHZ tick-stop error: Non-RCU local softirq work is pen=
ding, handler #08!!!
> >> [  146.015082] NOHZ tick-stop error: Non-RCU local softirq work is pen=
ding, handler #08!!!
> >> [  156.123890] mmc0: Timeout waiting for hardware interrupt.
> >> [  156.129318] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI=
 REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [  156.135764] mmc0: sdhci: Sys addr:  0x4cef1400 | Version:  0x000000=
02
> >> [  156.142211] mmc0: sdhci: Blk size:  0x00000170 | Blk cnt:  0x000000=
01
> >> [  156.148655] mmc0: sdhci: Argument:  0x14000170 | Trn mode: 0x000000=
13
> >> [  156.155102] mmc0: sdhci: Present:   0x01d88a0a | Host ctl: 0x000000=
13
> >> [  156.161547] mmc0: sdhci: Power:     0x00000002 | Blk gap:  0x000000=
80
> >> [  156.167992] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x000000=
3f
> >> [  156.174438] mmc0: sdhci: Timeout:   0x0000008f | Int stat: 0x000000=
00
> >> [  156.180883] mmc0: sdhci: Int enab:  0x107f100b | Sig enab: 0x107f10=
0b
> >> [  156.187330] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x000005=
02
> >> [  156.193776] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b4=
07
> >> [  156.200223] mmc0: sdhci: Cmd:       0x0000353a | Max curr: 0x00ffff=
ff
> >> [  156.206669] mmc0: sdhci: Resp[0]:   0x00001000 | Resp[1]:  0x000000=
00
> >> [  156.213113] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x000000=
00
> >> [  156.219557] mmc0: sdhci: Host ctl2: 0x00000000
> >> [  156.224005] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0x408812=
00
> >> [  156.230450] mmc0: sdhci-esdhc-imx: =3D=3D=3D=3D=3D=3D=3D=3D=3D ESDH=
C IMX DEBUG STATUS DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [  156.238024] mmc0: sdhci-esdhc-imx: cmd debug status:  0x3100
> >> [  156.243687] mmc0: sdhci-esdhc-imx: data debug status:  0x3200
> >> [  156.249438] mmc0: sdhci-esdhc-imx: trans debug status:  0x3300
> >> [  156.255276] mmc0: sdhci-esdhc-imx: dma debug status:  0x3400
> >> [  156.260938] mmc0: sdhci-esdhc-imx: adma debug status:  0x35b4
> >> [  156.266690] mmc0: sdhci-esdhc-imx: fifo debug status:  0x3610
> >> [  156.272439] mmc0: sdhci-esdhc-imx: async fifo debug status:  0x3751
> >> [  156.278710] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> [  156.287352] wilc1000_sdio mmc0:0001:1: wilc_sdio_cmd53..failed, err=
(-110)
> >> [  156.294177] wilc1000_sdio mmc0:0001:1: Failed cmd53 [0], bytes read=
...
> >> ------------------------------------
> >
> > since you are also using the WILC1000 device, I wanted to ask if you ha=
ve ever seen such behavior?
> > As Kirill wrote, with newer kernel versions it only occurs with longer =
transfers.
>
> I remember having seen a few time the described behavior (speed dropping =
to 0,
> then resuming normally during iperf sessions) but not the associated logs=
. Maybe
> my kernel configuration is different enough from Kirill's one, especially
> regarding the tick configuration. Can I have the corresponding defconfig =
?

you can see the used defconfig here:

https://pastebin.com/raw/HbTe1cEv

>
> For the second part of the logs (starting from "Timeout waiting for hardw=
are
> interrupt), I have seen them, but never in "nominal" operation, only when
> unplugging the module during operation (I am working with wilc1000 sd, wh=
ich is
> a kind of "hotpluggable" wilc 1000 in SD/MMC port).

Yes .. this seems to be a different problem.

>
> I am wondering if this scp transfer may make the chip reach a memory limi=
t,
> especially since you observe the issue less frequently with newer kernel.=
 I
> remember some patches from Microchip team mitigating issue about this on =
tx side
> (a08bb28f6eb6 ("wifi: wilc1000: add back-off algorithm to balance tx queu=
e
> packets")). That's only a wild thought of course, and the face issue cert=
ainly
> needs some new fix even if it is indeed this patch reducing the issue fre=
quency

The idea is not bad. But we see the problem (so far) on the RX side. So whe=
n
we do a download or a transfer to the target board (where the WILC1000
is installed).

> Thanks,
>
> Alexis
>
> --
> Alexis Lothor=C3=A9, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

