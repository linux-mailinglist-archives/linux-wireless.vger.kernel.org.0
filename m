Return-Path: <linux-wireless+bounces-29236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A2C78B7E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 12:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 721FC363719
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79D347BA8;
	Fri, 21 Nov 2025 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ib2r4r1a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A38349B03;
	Fri, 21 Nov 2025 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723584; cv=none; b=Rz+fs3jGgr+A6AYdGjXQGvKCch5w8BBOD/a2HcFRPSUUV4n3XmQk5fqxUW/k/VPbfLrjtxcYvSW89u7QIpxCbH4FX7YnyBOdr/uA4CjZUywrLtUrddKBXCbaKw6BhlViQQK95YmHTgJmQ4DRTAiCwXmKfDigoVEd9+Vs6qybwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723584; c=relaxed/simple;
	bh=0mEWGPS5eTsTuZX5jEeHYWG/Gd99iHCmw8ReRd54iyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EW8KxJ6IUwOlHGQT0D/WU+nJyULCZ0VoadURYckouRKughmbMFanDHZpls9wqr9gM9TJ9zAkSbwF+n+vkXnf6YugmGhbmr+vwmDCOsJOxhoCj9m/JLaKP3Z2xfX18U2fyyI89u5VvOm/WDVzhUlAht7yKWx15lHbL1V0rrp0qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ib2r4r1a; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5ALBCeSmA3461944, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763723560; bh=0mEWGPS5eTsTuZX5jEeHYWG/Gd99iHCmw8ReRd54iyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ib2r4r1abF7j5UtFzRGOuBYsQDUbWjGj6+u0Yi4MF4OjOzE/2dLMkkEuZobSsWCw2
	 tbgdS+KLXXewSIbgCANTArFFecUNSLqvah3gLsgJP/2WMj7CiFOBIZ0/FSahfyaCxZ
	 7Xyffd2tnaC3PpsoXibHNppStPtknxDyvxlgzD28dFIB5JoYztUu4+97fVk0MfJNDs
	 ER1IMkCambLcqEj/AoCxWTH8MDPp3YfbhlZHGjjweOwCRLyEB1q8ls3lh+i2h6pL25
	 pUmaZi5AyW6oZa+cVBioIw2CUZjGijaE9sYQMPdR2+a77YWEDr16c9gbN+FjvjRWwO
	 cL0xli2rOQlOQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5ALBCeSmA3461944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:12:40 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 19:12:40 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::2514:51f7:92e3:7d6a%9]) with mapi id
 15.02.1544.027; Fri, 21 Nov 2025 19:12:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Zenm Chen
	<zenmchen@gmail.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>
CC: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Thread-Topic: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Thread-Index: AQHcWTQWm+ekto8gdkOtuZTX88y/HbT8ZJsAgAADogCAAJNFUg==
Date: Fri, 21 Nov 2025 11:12:40 +0000
Message-ID: <884145e57dc640d3bed29922d352f658@realtek.com>
References: <aR2I9Sere0W-4VZz@kspp>
 <20251121100654.9125-1-zenmchen@gmail.com>,<ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
In-Reply-To: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> On 11/21/25 19:06, Zenm Chen wrote:
> > Dear maintainers,
> >
> > With this patch applied, my system always freezes right after the rtl8x=
xxu
> > driver is loaded. is it normal?
>=20
> I don't think so... It probably means that struct urb urb; cannot really =
be
> moved to the end of struct rtl8xxxu_rx_urb or struct rtl8xxxu_tx_urb?
>=20
> It'd be great if you could share a log.
>=20
> Thanks for the report!
> -Gustavo
>=20
> >
> > OS: Arch Linux
> > kernel: 6.17.8-arch1-1
> > test devices: RTL8192{CU,EU,FU}
> >

As my review, 'struct urb urb;' seems only a member data.
No order problem.

To have enough time to dig the problem, I'd drop this patch
from my pull-request for now.

