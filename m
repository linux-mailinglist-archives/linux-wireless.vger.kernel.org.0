Return-Path: <linux-wireless+bounces-22150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EFAA9F5D9
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 18:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B3A7AC520
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51CD27A12F;
	Mon, 28 Apr 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUjkMvC+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E055B199E9A;
	Mon, 28 Apr 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857876; cv=none; b=cHkZ+g6cvICkoKa5lGadEEXvwgc7FnQpgxdzae3aRGyWONGVO58TdhOZ/1wP9VnKpMYwtdrL6kplrZ2mtexldjzkKet8uepkTKPPre1UYRHuEI7cKNexVuR1TigKevmI7hyk5qQElbPLyF2IOGAj9Xt0dx8ijZIyzJ4x0n2N1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857876; c=relaxed/simple;
	bh=XoHO3hXFTm90wQdVfiTx7lJNABIj/qSyodbgxEJXrwU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HJxi/+sFLWTBsEeybY9Rlk/Cfv9/IaEWBD7ABvzzTLbs9b2t3Fev+4nc3wsphBq7Gxefb74B+06+Y7V5wn4xSlsPiYm8CQjJN6AF8nY4faCgA00ouccNo1t1A/R7OIy1k2NWzCVAaVNf3eAWAZSQJfdTDVN0llR1tkxDysVSJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUjkMvC+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf861f936so8727885e9.3;
        Mon, 28 Apr 2025 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745857873; x=1746462673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rpLoGS47sE5MLiLABPtEKiVLu5JTrAcQvnYc7S0qkE=;
        b=DUjkMvC+p49KAzNwPX1pCwl0UW2IznxosN9GkK88VMqBrVrHRPEbdCbL/JbKoRqKLt
         sS4mnyjhmOs7vf3nUJwA9sB7G9AMtfk/Pj2PtczeEVJUJJfJpKzbpnFnGwWA1W/AU/WK
         rQoe/BHDYItMd8E9b09FaalKvTXlDTz9dTAy8B/BKM0Fc6Ty3HTTTd4Og3smQmQPfGKM
         1qBxCnKTQKJ5TIrkWpxYWCe+JGsXsw4wmcjYnglDd/6taGMi7meDZ8+ju+96zv2GLsbd
         +evt84lVMsicfoC+YMrdJbH7P4KFWwJl3u6wyXcddBTcQgp7Ab6FsRj9m2AnrFqIx1y/
         P+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857873; x=1746462673;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rpLoGS47sE5MLiLABPtEKiVLu5JTrAcQvnYc7S0qkE=;
        b=kujAL+EFt1bxajm2/w+Y0JLrM2RtvUWuhpxZFACd2IlC29+1b8Yp053iPBM+mfV5kQ
         p60JeYZ2ZTmIjG6WZhVRiEkH691fBeWLstJf8iT56LIQ0Pz041tIl6KHxvMwVQitxY3/
         xpvYyH5egh9BlqR0XB93DEdaYwikgHIxrRGZbL3yivIemitI+FyajmAPa7WzemwvUYHW
         8/izGPZjI5IYpeoFTFrYlYcVSLdyp0pZHeub+tzmIwqR8ieTweMETeCeq595UQVZlhHq
         2wqrzTeKuH7P6FjT17yFv3+Ie4QV4CQVdtCW4u6Le0R9kxki4HVUlETUnDxcUvYRqlPg
         LNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsbDPxjtZFAdBYs56lyRulSEIgmsBuxdp+aTxW5WiRQxHj75YGz+QISrOJAOlMPEHzAr4aEa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FMc8EpS8GGnyhs7wiyKet7HNUUBNqCKZ2LZfGL3UQCVZm5ww
	1e/ikauOAR7huWlrUR2juEqubzL5jwkhpjRcuIuj4qGSPLj/XFknFI3RMaA/
X-Gm-Gg: ASbGncvJPnERc4ArnNjCIXrY7omckB5VANwPdbGktPt/4Jkx0nFV9VQve3nvF6DQSpz
	wUKVjk+Aa7UetYg80mFkkO1VIXNa3kXV6O/pXigZ/QwfO6pGexDZgyzE171vpp/T6HUdo78xxEg
	oMWffY+2kRzvUCI5kUoLDjYT3aEHhHmgiU1QPm3E+LTVK8j/hhJ47R0TE8//+jvJ0+M2g37uNWP
	2sh9sKywoGzLDWDu1Zp1sk2PA+Cd7CZZxuyxAXFlsv32V1UjjzSFYRslv+dyxeIGOJCCz9p1GfL
	az7fS8hP/CdVl/6hY+nQbJvUYFtvEbMvb729CpLK6ti+hrMg6yt52QgPFQ==
X-Google-Smtp-Source: AGHT+IHmjNe3scTe8qIdIgHxl5WlUB1dX8XR8Fa4lJ29b14HLel6DUXMTEQxxoDEsqw4QywjAo8agw==
X-Received: by 2002:a05:600c:4685:b0:43b:cab3:1fd1 with SMTP id 5b1f17b1804b1-440a65bb7d5mr41472465e9.1.1745857872642;
        Mon, 28 Apr 2025 09:31:12 -0700 (PDT)
Received: from [192.168.36.152] ([82.66.27.2])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4409d2ad112sm161000125e9.24.2025.04.28.09.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 09:31:12 -0700 (PDT)
From: "=?UTF-8?Q?Jean-Fran=C3=A7ois_Ingelaere?=" <masterprenium@gmail.com>
X-Google-Original-From: =?UTF-8?Q?Jean-Fran=C3=A7ois_Ingelaere?= <MasterPrenium@gmail.com>
Message-ID: <bb95fe33-bc31-4aa3-a93d-3deadbcb4973@gmail.com>
Date: Mon, 28 Apr 2025 18:31:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FW: Wireless speed regression issue with >6.12.12/6.13.x +
 firmware update for mediatek MT7925
To: =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
 <Mingyen.Hsieh@mediatek.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 =?UTF-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CACr2tqu10_mXiXw-Q3VSqYBJhQU1s_m77_uhvjpe0j3H3jhbgA@mail.gmail.com>
 <TYZPR03MB61644B8F34946A73E2C16E27F4DF2@TYZPR03MB6164.apcprd03.prod.outlook.com>
 <5a07aea2090532682c8cd4df3ab1b9026f2e1cd5.camel@mediatek.com>
 <04dca014-881c-46b4-a084-2001c62b466e@gmail.com>
 <6cebf6265f5f981dd951851d0832633292a60a46.camel@mediatek.com>
 <28ff58dc-72f3-4b71-817c-ccb4ff5f777d@gmail.com>
 <bc09e1613e1dd31489d1d2290a67da987481f03d.camel@mediatek.com>
Content-Language: fr-FR
Disposition-Notification-To: =?UTF-8?Q?Jean-Fran=C3=A7ois_Ingelaere?=
 <MasterPrenium@gmail.com>
In-Reply-To: <bc09e1613e1dd31489d1d2290a67da987481f03d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

The Cisco Catalyst C9120AXI (not Meraki), is running in Lightweight 
mode, connected  to the Cisco Virtual Wireless Controller.

I was running tests in 5Ghz, WPA2 + 160Mhz Channel width, not 80 (+all  
supported rates enabled, RRM+DCA enabled, 802.11h enabled, BSS enabled). 
As tested previously 20Mhz channel width gives better performances than 
160Mhz after regression.

Following speed are observed with highest steams as I can (multi thread 
iperf/nperf ect). Speed test isn't run in perfect conditions but it 
doesn't really mind.

With 6.14.3 + latest firmware 20Mhz channel width (DL/UL) : 
130mbps/160mbps (ch36)
With 6.14.3 + latest firmware 40Mhz channel width : 230mbps/330mbps (36,40)
With 6.14.3 + latest firmware 80Mhz channel width : 340mbps/6mbps 
(36,40,44,48)
With 6.14.3 + latest firmware 160Mhz channel width : 640mbps/7mbps 
(36,40,44,48,52,56,60,64)

As you can see, Upload speed is dropping with 80Mhz channel width. Can 
you please try in your setup with 160Mhz ? As a check.

-> With 6.14.3 + latest firmware 160Mhz in 802.11AC (Cisco 2802E): 
800mbps/380mbps (52,56,60,64,36,40,44,48)

As a debug/comparison :

With 6.14.3 + 202412 firmware 20Mhz channel width (DL/UL) : 
130mbps/170mbps (ch36)
With 6.14.3 + 202412 firmware 40Mhz channel width : 130mbps/280mbps (36,40)
With 6.14.3 + 202412 firmware 80Mhz channel width : 390mbps/580mbps 
(36,40,44,48)
With 6.14.3 + 202412 firmware 160Mhz channel width : 630mbps/950mbps 
(36,40,44,48,52,56,60,64)


I don't have any other 802.11ax AP at the moment. Remember : no issue 
with 802.11ac.

Best regards,
Jeff

Le 28/04/2025 à 13:00, Mingyen Hsieh (謝明諺) a écrit :
>
> On Thu, 2025-04-24 at 13:20 +0200, Jean-François Ingelaere wrote:
> > 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > Hello,
> > 
> > I hoped you had previous messages. Firmware is the released from my
> > distro (Gentoo Linux) 20240410, but yes you're right, the firmware
> > used
> > in this case for mt76 is 20240305, sorry.
> > 
> > [74734.459451] Loading firmware:
> > mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
> > [74734.463449] mt7925e 0000:73:00.0: ASIC revision: 79250000
> > [74734.539692] Loading firmware:
> > mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
> > [74734.539760] mt7925e 0000:73:00.0: HW/SW Version: 0x8a108a10, Build
> > Time: 20250305132908a
> > 
> > [74734.878892] Loading firmware:
> > mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
> > [74734.879069] mt7925e 0000:73:00.0: WM Firmware Version: ____000000,
> > Build Time: 20250305133013
> > [74734.974255] Loading firmware:
> > mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
> > 
> > 
> > The AP used is a Cisco C9120AXI-E.
> > 
> > 
> > Best regards,
> > 
>
> Hi,
>
> I had tested with this AP (5G HE80 & WPA2), and my setting is v6.14.3 +
> latest firmware. It looked good for me.
>
> Could you give me your AP setting and could you test with another AP?
>
> Best Regards,
> Yen.
>
>
> *********** MEDIATEK Confidentiality Notice
>   ***********
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or
> otherwise exempt from disclosure under applicable laws. It is
> intended to be conveyed only to the designated recipient(s). Any
> use, dissemination, distribution, printing, retaining or copying
> of this e-mail (including its attachments) by unintended recipient(s)
> is strictly prohibited and may be unlawful. If you are not an
> intended recipient of this e-mail, or believe that you have received
> this e-mail in error, please notify the sender immediately
> (by replying to this e-mail), delete any and all copies of this
> e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

