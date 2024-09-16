Return-Path: <linux-wireless+bounces-12886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349A979C2C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 09:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58761C2209F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D642E659;
	Mon, 16 Sep 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="S0ncMgWW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA1117FE
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472592; cv=none; b=pRZW8s7q+9qeCMS59OAcyiK513IvFaXEFN1w8QK07J5FeBMz4kTryr/InNA2KNy7vt+ijMRbrh2qaUyruKkMppaueHT8+JwJTW65gDcqEnODM+AYgHEWijH92KFLNKPUecFQoL+c5YgPRE3vCpTAxhTSPVOWZkeM5CSNFBA3bCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472592; c=relaxed/simple;
	bh=0UrX5cJIxi4VVEsANdUz9TwxG2dZTQvKLy0XyLW+51M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oaOStvq43SYdi93hV5Eq9f3il4zOR8jvFfms6EgEd0zB0PSyolhsN0/aUl5krbi8KGQYg6rCq0lrpjGrioX2+1t1/oU8PJBsAMBSZ5V6QBlhrFPmVFsz3+jUWLMKe+kXOzPzSL4U4HVC2VPdiz4aZHw01VBL4AIdJBGaQ91YK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=S0ncMgWW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48G7gkcC72756579, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726472566; bh=0UrX5cJIxi4VVEsANdUz9TwxG2dZTQvKLy0XyLW+51M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=S0ncMgWW+bAXYgiUtK1nOqOMqeJ7fI+1Wu/oVzDRgyogc1CBpjuiHNWraA/TVZsNR
	 N/hZ9MFiQUcL1LwWQ5fYi96Qr+ixrYC+LyZSBZAdSlYGXREMAAZApHiEjy0fJGuEgS
	 oC+TEWJqR5lwt3iQszbdL7GAsehw3GLx7rjOd10RD9sGcC242fckeLb22v9agpdfRe
	 OFR0ORCpO+CzoYmmqI06mAI02iAWCmai99zDKZZtkpJZ5IIcV/cuU1lxQRwduwJRqg
	 CEz5Kdb0Oq7Vx9s9YGii6nhBNo2pdtOwaWXdB4WjJBDT7Fzu7VeDiLGeFe3uKSCdEf
	 VYIYXHQQONm5Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48G7gkcC72756579
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 15:42:46 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 15:42:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Sep 2024 15:42:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 16 Sep 2024 15:42:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Stefan Lippers-Hollmann <s.l-h@gmx.de>
CC: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: RE: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
Thread-Topic: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Thread-Index: AQHadMtD5PbM3LC0pEyBntnmuPy2drE0pKyAgAABjICBJFRbAIACMVJw
Date: Mon, 16 Sep 2024 07:42:45 +0000
Message-ID: <f0900afbfbd54f5a9fae875e1cb53470@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	<20240313064917.527110c4@mir>
	<4c4aa8160119935e48f9da679b502f80da4c0fc7.camel@realtek.com>
 <20240915080434.564d1c66@mir>
In-Reply-To: <20240915080434.564d1c66@mir>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Stefan Lippers-Hollmann <s.l-h@gmx.de> wrote:
> On 2024-03-13, Ping-Ke Shih wrote:
> > On Wed, 2024-03-13 at 06:49 +0100, Stefan Lippers-Hollmann wrote:
> > > On 2024-03-13, Bitterblue Smith wrote:
> > > > Create the new module rtl8192d-common and move some code into it fr=
om
> > > > rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du dri=
ver
> > > > (USB) can share some of the code.
> [...]
> > > Using the firmware from https://github.com/lwfinger/rtl8192du/,
> > > it would be great if someone could publish the necessary firmware
> > > to linux-firmware.
> > >
> > > MD5:
> > > abccba1e9bb456eb81dfc88502a56300  /lib/firmware/rtlwifi/rtl8192dufw.b=
in

I found its version is 38 that is little bit older than [1] (version 39).=20
Bitterblue has made a binary from [1] and I have verified the binary.=20
I will send this firmware days later because my previous firmware is
still under review.=20

> > >
> > > SHA256:
> > > 9b51f15642b7f2d41e8369d7df956f92333c09699d8a88039081a8bdc77242a1
> /lib/firmware/rtlwifi/rtl8192dufw.bin
> >
> > I can do that after this patchset get merged.
>=20
> As kernel v6.11 premiering with rtl8192du (which works well) isn't that
> far away, I'll just drop a reminder about publishing the corresponding
> rtlwifi/rtl8192dufw.bin firmware image to linux-firmware.
>=20

Thanks for the reminder. I have queued this firmware to my local tree.

[1] https://github.com/lwfinger/rtl8192du/blob/master/hal/Hal8192DUHWImg.c


