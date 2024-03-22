Return-Path: <linux-wireless+bounces-5125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6A886448
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 01:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66276B20FEA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 00:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45E5376;
	Fri, 22 Mar 2024 00:16:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4019A
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 00:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711066600; cv=none; b=NSjg029K1PlY7COXpkP2rpEMaLUtX1RB4MI1hUsHDkxPdKlYOR0UBltSGDg2mf3xeMRzYCE69C9XFMhCscuU/0xCFcRh8wePNBJFd3XqGi16WRWEvAoTBuvj4KmD03EU+I5ULs+IiNHa26j4bsjDd9EFs3T6znDwKSKo55yzVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711066600; c=relaxed/simple;
	bh=cWVeTEWaEjJgKdABwHcbVzJVL/ICCuiXTxOPawpnwdk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WMoQge9TtEpJSA4RNUXlKIWaN0/bp32hLr8XYBykNA7maHcvfeKuVP8Bz+W8CAa8u6t1qrfZcfrSbCKRMuho6cC3BU7ZciDbb9bS9K2Uf5sA8XJtq9270NHMyG8nFqgJlrfM+9V5WOUTok6JeK+RHdnus7lt5onIySBSk1tKghU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42M0GEwiC1308811, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42M0GEwiC1308811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 08:16:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 08:16:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 08:16:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 22 Mar 2024 08:16:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Konstantin Kletschke <konstantin.kletschke@inside-m2m.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: AP mode on RTW88 8821cs
Thread-Topic: AP mode on RTW88 8821cs
Thread-Index: AQHae35fCRVxvatxIEuwJVdovXZIBbFC5F0w
Date: Fri, 22 Mar 2024 00:16:14 +0000
Message-ID: <be67119238e14fa09b3d9dc848d8edd9@realtek.com>
References: <ZfwSM0paZg23iEPS@hephaistos.inside-m2m.de>
In-Reply-To: <ZfwSM0paZg23iEPS@hephaistos.inside-m2m.de>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Konstantin Kletschke <konstantin.kletschke@inside-m2m.de>
> Sent: Thursday, March 21, 2024 6:56 PM
> To: linux-wireless@vger.kernel.org
> Subject: AP mode on RTW88 8821cs
>=20
> We have a rockchip rk3328 board with an 8821cs chip connected via SDIO.
> Well, cs impiles SDIO, cu is USB variant.
>=20
> Normally thinks work quite well for use but we do not get AP mode to
> work.
> We use 6.5.13 kernel with our customized DT and the in kernel 8821cs
> driver:
>=20
> rtw88_8821cs           12288  0
> onboard_usb_hub        12288  0
> rtw88_8821c            81920  1 rtw88_8821cs
> crct10dif_ce           12288  1
> rtw88_sdio             24576  1 rtw88_8821cs
> rtw88_core            167936  2 rtw88_8821c,rtw88_sdio
> mac80211              929792  2 rtw88_sdio,rtw88_core
> libarc4                12288  1 mac80211
> cfg80211              921600  2 rtw88_core,mac80211
>=20
> We tried with wpa_cli and hostapd but to no avail.
> I tried hostapd with wlan0 and eth0 bridged into br0, the SSID appears
> in the wlan search results in other devices, connectig _seems_ to work
> but getting an IP is not possible.
>=20
> What my colleauge and me especially noticed, the TX counter for the
> wlan0 interface in this use case runs, RX stays at 0:
>=20
> br0       Link encap:Ethernet  HWaddr 4A:86:7D:63:5C:59
>           inet addr:10.16.10.103  Bcast:10.16.255.255  Mask:255.255.0.0
>           inet6 addr: fe80::4886:7dff:fe63:5c59/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:111361 errors:0 dropped:3479 overruns:0 frame:0
>           TX packets:28144 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:13333769 (12.7 MiB)  TX bytes:3847859 (3.6 MiB)
>=20
> eth0      Link encap:Ethernet  HWaddr 86:E0:C0:EA:FA:A8
>           inet6 addr: fe80::84e0:c0ff:feea:faa8/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:112803 errors:0 dropped:219 overruns:0 frame:0
>           TX packets:28405 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:15102222 (14.4 MiB)  TX bytes:3891727 (3.7 MiB)
>           Interrupt:51
>=20
> wlan0     Link encap:Ethernet  HWaddr F0:B0:40:4F:70:BC
>           inet6 addr: fe80::f2b0:40ff:fe4f:70bc/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:123446 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 B)  TX bytes:18783966 (17.9 MiB)
>=20
> In order to provide useful debug information, what should I look into?
>=20
> Is it a known issue or should AP mode work flawlessly with those
> drivers, which implies I forgot something.
> When I use my software with an external USB WLAN stick with another
> driver, exchange all wlan0 by wlan1 occurences only:
>=20
> rtl8xxxu              192512  0
> rtl8192cu              81920  0
> rtl_usb                16384  1 rtl8192cu
> rtl8192c_common        65536  1 rtl8192cu
> rtlwifi               118784  3 rtl8192c_common,rtl_usb,rtl8192cu
>=20
> the software AP works immediately.
>=20

We had similar discussion before [1]. I think Martin will take his time to
investigate how to enable AP mode on SDIO WiFi cards.

[1] https://lore.kernel.org/linux-wireless/36972ff5-0c48-4bd2-8f9a-9649bfa2=
4225@lexina.in/




