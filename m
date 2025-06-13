Return-Path: <linux-wireless+bounces-24086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA68AD7FD9
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 02:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7BF1E1EBD
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 00:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B801BEF7D;
	Fri, 13 Jun 2025 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="W5drcmAv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A281D6DB5
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 00:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776158; cv=none; b=aWVAX/iJBjH6BfxTL6LVk2QSvUoGpSoi2DwJY7gPoC0cHV0xmwBWXYv24vLMKXpiJGYXZyYFAExt1lwOlKv2jxy2TKqE2GiGS14WkIpLv5SOVGuMfFDjPGmEcXqU7VjYunWlw6t+Uno4xP7XOZpInJPeLISxfqjq1XFKNmN+Ctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776158; c=relaxed/simple;
	bh=03hBKJflU8DIeTnbisXQU4NNwZCHpi786r2qdIh9yxM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iIGNVC7hbOaSXSZuoTulUKFg/TgoDqN6IhzEDGj8KyBMVeH2TAoDH/r/pmhOBmZTmaUEsvewuWAH/Tzpk0mgX4x2aVX/NKFVgtlEUqgQcoWYTb6S9xGpChGV1rTGM/dOyx5JuJ6X90Q8AE88Q4afJ86rBMF5mYH8hBksJzm+RnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=W5drcmAv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55D0tk8533295576, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749776147; bh=j2UFqHn6iOqLdcppO7I+AD5MFZhuymSWU33i7aSCWv0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=W5drcmAvdvZwmhmnv/XynHIAGGvUHo+nHDodcpaUImirWXvys4be5cp2lkaC5MQYi
	 BhZLQOsMhIS6ryBBmroSc1O5Y5tJqD5WivfHoOJ25gHzP6KZo9TJbCL2ojtGghdTnn
	 7cIBO/345cYC8xjLoGWoZBTgkZbmP9ZVVNS5V2zzYE4HgeLuAEAj4EMgS4WKAAZXP7
	 ocwJme5M6YSak8XrXluK68aOvIsVbY6sv9sGhwX5No/g/slZiJaTw11G31QsVa1sVb
	 Z/evi1yIjXyZKsuS3EGG3BejCX8o0r79fWijF6Cds1daSOhvXSGzXUFHLwRb0Exkpk
	 BR9zTML1iJbYA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55D0tk8533295576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 08:55:46 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Jun 2025 08:55:48 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 13 Jun 2025 08:55:47 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Fri, 13 Jun 2025 08:55:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: lonthn <lonthn@163.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [rtw89] PCI Passthrough Issue: rtl8852be on ARM VM (Ubuntu host/OpenWrt guest)
Thread-Topic: [rtw89] PCI Passthrough Issue: rtl8852be on ARM VM (Ubuntu
 host/OpenWrt guest)
Thread-Index: AQHb22zxVTHq2WpqB0Cl1dYfkss9mLP+8PEAgAFQWuA=
Date: Fri, 13 Jun 2025 00:55:47 +0000
Message-ID: <831534d6b74040968538bd2124c92122@realtek.com>
References: <684A83E1.25166C.00001@m16.mail.163.com>
 <757a4801.a04e.197642679a4.Coremail.lonthn@163.com>
In-Reply-To: <757a4801.a04e.197642679a4.Coremail.lonthn@163.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

lonthn <lonthn@163.com> wrote:
> At 2025-06-12 15:38:09, lonthn@163.com wrote:
> >Thanks for your quick response.
> >
> >> This looks like interoperability problem of 36-bit DMA.
> >> If you have below commit in your guest OS:
> >> 1fd4b3fe52ef ("wifi: rtw89: pci: support 36-bit PCI DMA address")
> >>
> >> Please also have below commit to rollback 32-bit DMA.
> >> aa70ff0945fe ("wifi: rtw89: pci: early chips only enable 36-bit DMA on=
 specific PCI hosts")
> >>
> >> With the latest kernel, you can just comment code as below to use 32-b=
it DMA.
> >
> >I tried it and found that it still doesn't work

The error means that firmware isn't ready, and download firmware is the
first part driver asks WiFi device does DMA. Before the DMA, driver has
done many memory mapping IO, so IO is okay, but DMA isn't.=20

I think you can try to force 36-bit DMA to see if it can work. (I suppose
the experiments before is 32-bit DMA.)

> >
> >> I have not ever tried passthrough, so I'm not sure if it can work.
> >> Can I know how different the passthrough is?
> >
> >You can refer to this: https://docs.kernel.org/driver-api/vfio.html

I don't quite understand what I should modify the driver. Do you have
hints for me?

I feel PCI passthrough should be transparent to driver/device. I mean
driver/device shouldn't need to know that it operates in host OS or
guest OS (passthrough).=20

> >
> >> Does rtl8852be work on host OS?
> >
> >I'm trying, but when I load the 8852be driver, strangely, I get nothing.
> >$> dmesg |grep 8852be
> >no message!
> >$> lsmod |grep rtw
> >rtw_8852be             16384  0
> >rtw_8852b             352256  1 rtw_8852be
> >rtw89pci               61440  1 rtw_8852be
> >rtw89core             569344  2 rtw89pci,rtw_8852b
> >It looks like my device is not detected
>=20
> I've confirmed that the host system is working

What were you do to fix that? Did you turn off iommu/VT-d or something?=20




