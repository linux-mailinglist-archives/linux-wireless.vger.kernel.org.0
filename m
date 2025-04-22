Return-Path: <linux-wireless+bounces-21800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76B8A95A32
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 02:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC067A25E2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 00:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E74E74059;
	Tue, 22 Apr 2025 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pWsTRTri"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52372A95E;
	Tue, 22 Apr 2025 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745281699; cv=none; b=GGG+urXNZONpZ1VndzIo2f/sJoTNtOWAJl8Mihs8u8aTviEhyBfFZdqysdyCZXnjR/ApGbFuvbxHsMNFpBCOfUQ1Ic34ZD4B4989UtjxQ41vlV1XklL1LxWKgZrbX2nyaXHD87ZXlgJAWx81h0WLuopwc+gPzfUOGBKmMW4nP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745281699; c=relaxed/simple;
	bh=5bvGiubNrKBkPHJtUFc60qqhau+/z1pcrchovxujmlI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VmmCIEgfKHlbcDb96pPllE59rr7rPsfdj4CdESKmQAlSCFNToD08fAM7dlInjdHjt/KWvcab1eHznbA9/g1oZ4waon2EIi+R0Ph5gXMgLgdXtoowP5Ut1NkN19c5bzIIdPT/FweJ8L6YO2GRCStHAj5EIimBubvPoKitMS1szME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pWsTRTri; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M0RDHY03289616, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745281633; bh=5bvGiubNrKBkPHJtUFc60qqhau+/z1pcrchovxujmlI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pWsTRTriz4bE2MlnbkJl9vg/ZSkXu/ZcdmzCfZickUesxEeUJt5zef/cg16fxR516
	 BSrdmyDlL7hDETVfbW9soOxfVYRZlmhhb+RpQdgvlXGdAOTRik6PuEvgZCMCfFNzhJ
	 OdXAdz0s22vPTZ0VQ9mnrxp7YR0nT+fMRhvZN4F0seZfmtbXm+pBvceicbq6JKn9MV
	 2Dx2BDDlZRAcQ/yzOXX+5iqj1pawWMQwmxyW64qt/c1DlhTHcMJ91yzHcAZh5QDYbT
	 4pAujwFc4zz4xhT3Sbkz2dfKZaJxi9KCMODiyK69GG3j/CMfysXeDVuBh2zJ8f5cis
	 CZZuitVlb+uPw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M0RDHY03289616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 08:27:13 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 08:27:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 22 Apr 2025 08:27:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 22 Apr 2025 08:27:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingcong Bai <jeffbai@aosc.io>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Kexy Biscuit <kexybiscuit@aosc.io>,
        Liangliang Zou
	<rawdiamondmc@outlook.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [RFC PATCH] wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723
Thread-Topic: [RFC PATCH] wifi: rtlwifi: disable ASPM for RTL8723BE with
 subsystem ID 11ad:1723
Thread-Index: AQHbsQLzvT9MJD0RkUSfQMSmmYlilrOu11zA
Date: Tue, 22 Apr 2025 00:27:13 +0000
Message-ID: <4a7284bd703743959e709b9465dabf1d@realtek.com>
References: <20250419081251.285987-1-jeffbai@aosc.io>
In-Reply-To: <20250419081251.285987-1-jeffbai@aosc.io>
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

Mingcong Bai <jeffbai@aosc.io> wrote:

> RTL8723BE found on some ASUSTek laptops, such as F441U and X555UQ with
> subsystem ID 11ad:1723 are known to output large amounts of PCIe AER
> errors during and after boot up, causing heavy lags and at times lock-ups=
:
>=20
>   pcieport 0000:00:1c.5: AER: Correctable error message received from 000=
0:00:1c.5
>   pcieport 0000:00:1c.5: PCIe Bus Error: severity=3DCorrectable, type=3DP=
hysical Layer, (Receiver ID)
>   pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=3D0000000=
1/00002000
>   pcieport 0000:00:1c.5:    [ 0] RxErr
>=20
> Disable ASPM on this combo as a quirk.
>=20
> This patch is a revision of a previous patch (linked below) which
> attempted to disable ASPM for RTL8723BE on all Intel Skylake and Kaby Lak=
e
> PCIe bridges. I take a more conservative approach as all known reports
> point to ASUSTek laptops of these two generations with this particular
> wireless card.
>=20
> Please note, however, before the rtl8723be finishes probing, the AER
> errors remained. After the module finishes probing, all AER errors would
> indeed be eliminated, along with heavy lags, poor network throughput,
> and/or occasional lock-ups.

Let me clarify here means. Do you mean all work well after applying this
patch? Or still lag, poor throughput or lock-ups?

If all symptoms disappear, it would be worth to take this (quirk) patch.=20


