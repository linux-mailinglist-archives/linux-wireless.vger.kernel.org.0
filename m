Return-Path: <linux-wireless+bounces-5086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FE68857AA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 11:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C0A1F21BCE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B3F5645E;
	Thu, 21 Mar 2024 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inside-m2m.de header.i=@inside-m2m.de header.b="G0bEnPch"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.inside-m2m.de (mail.inside-m2m.de [188.68.57.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1F14284
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.57.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018554; cv=none; b=FHv7A8+dBf+RiAEbTQhpf9z24kWPTczXGAnpvF2zMarliTY8cVN+bDpIefpNtRxwcnhc37M5sz4gC9PtP0L0rRwfJuyH1IkHTShxa0vyOp0Wzp+PGXzuRP55ISapd/7ShQGzvMhNEzOA7JhCiMxLx6tgbS/U/kMlemN9H6CDXDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018554; c=relaxed/simple;
	bh=/OMSClYFa6oCiHHdSWa+gq+pInQxzfl8Z4v9phP+YOw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qxdTQrJHotgWURV9/JQPh9gdUs/uihfwoKKrRCcoD0GX+7S65XFfkwcJPTyhLo0gY7QpLl/jJRaB8VcAJMF0InGbRs2q9jZLmTfTB6G01IrxNvqr0YTXvN7rtXIo+xJto4REmdTA6cAPuNXsv8c9lEgSrw8vkulAgUP8nyxlA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inside-m2m.de; spf=pass smtp.mailfrom=inside-m2m.de; dkim=pass (2048-bit key) header.d=inside-m2m.de header.i=@inside-m2m.de header.b=G0bEnPch; arc=none smtp.client-ip=188.68.57.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inside-m2m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inside-m2m.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=inside-m2m.de;
	s=default; t=1711018548;
	bh=/OMSClYFa6oCiHHdSWa+gq+pInQxzfl8Z4v9phP+YOw=;
	h=Date:From:To:Subject:From;
	b=G0bEnPchdDxYyHsE0JsewdmAu+/Q0gDiCI1DRTkYllSL15PmKA1AfspTYzTbvOaE7
	 s8E/WBrebHcIf6DMRR2vXoiecJb9BWkrJArytgTX9i5D8wnUsVerbOASHpZHh+gXiy
	 E9BjGpiFsuLhF4M553lNs/wHSh98RuSIWs5uFMX83KXbJE0UlSKbbcMaIl+TmQIhTl
	 pGkT5lXEsnpwqIg/V+mPuFaaLt9EgkKFkHC5QBhiFv/f/bCoEM1Q5/IFPlE2y0PGDS
	 xoFTfIip16YAX8wsS1glRBcR4go0ZJwv++TWQKADYs4/I6XztiXjN7i88F3KuHSDgY
	 vQYuvPBRkWozQ==
Received: from hephaistos.inside-m2m.de (business-90-187-159-109.pool2.vodafone-ip.de [90.187.159.109])
	(Authenticated sender: konstantin.kletschke@inside-m2m.de)
	by mail.inside-m2m.de (Postfix) with ESMTPSA id B0AAF400E1
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 11:55:48 +0100 (CET)
Date: Thu, 21 Mar 2024 11:55:47 +0100
From: Konstantin Kletschke <konstantin.kletschke@inside-m2m.de>
To: linux-wireless@vger.kernel.org
Subject: AP mode on RTW88 8821cs
Message-ID: <ZfwSM0paZg23iEPS@hephaistos.inside-m2m.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


We have a rockchip rk3328 board with an 8821cs chip connected via SDIO.
Well, cs impiles SDIO, cu is USB variant.

Normally thinks work quite well for use but we do not get AP mode to
work.
We use 6.5.13 kernel with our customized DT and the in kernel 8821cs
driver:

rtw88_8821cs           12288  0
onboard_usb_hub        12288  0
rtw88_8821c            81920  1 rtw88_8821cs
crct10dif_ce           12288  1
rtw88_sdio             24576  1 rtw88_8821cs
rtw88_core            167936  2 rtw88_8821c,rtw88_sdio
mac80211              929792  2 rtw88_sdio,rtw88_core
libarc4                12288  1 mac80211
cfg80211              921600  2 rtw88_core,mac80211

We tried with wpa_cli and hostapd but to no avail.
I tried hostapd with wlan0 and eth0 bridged into br0, the SSID appears
in the wlan search results in other devices, connectig _seems_ to work
but getting an IP is not possible.

What my colleauge and me especially noticed, the TX counter for the
wlan0 interface in this use case runs, RX stays at 0:

br0       Link encap:Ethernet  HWaddr 4A:86:7D:63:5C:59
          inet addr:10.16.10.103  Bcast:10.16.255.255  Mask:255.255.0.0
          inet6 addr: fe80::4886:7dff:fe63:5c59/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:111361 errors:0 dropped:3479 overruns:0 frame:0
          TX packets:28144 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:13333769 (12.7 MiB)  TX bytes:3847859 (3.6 MiB)

eth0      Link encap:Ethernet  HWaddr 86:E0:C0:EA:FA:A8
          inet6 addr: fe80::84e0:c0ff:feea:faa8/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:112803 errors:0 dropped:219 overruns:0 frame:0
          TX packets:28405 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:15102222 (14.4 MiB)  TX bytes:3891727 (3.7 MiB)
          Interrupt:51

wlan0     Link encap:Ethernet  HWaddr F0:B0:40:4F:70:BC
          inet6 addr: fe80::f2b0:40ff:fe4f:70bc/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:123446 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:18783966 (17.9 MiB)

In order to provide useful debug information, what should I look into?

Is it a known issue or should AP mode work flawlessly with those
drivers, which implies I forgot something.
When I use my software with an external USB WLAN stick with another
driver, exchange all wlan0 by wlan1 occurences only:

rtl8xxxu              192512  0
rtl8192cu              81920  0
rtl_usb                16384  1 rtl8192cu
rtl8192c_common        65536  1 rtl8192cu
rtlwifi               118784  3 rtl8192c_common,rtl_usb,rtl8192cu

the software AP works immediately.

Kind Regards
Konstantin


-- 
INSIDE M2M GmbH
Konstantin Kletschke
Berenbosteler Straße 76 B
30823 Garbsen

Telefon: +49 (0) 5137 90950136
Mobil: +49 (0) 151 15256238
Fax: +49 (0) 5137 9095010

konstantin.kletschke@inside-m2m.de
http://www.inside-m2m.de 

Geschäftsführung: Michael Emmert, Derek Uhlig
HRB: 111204, AG Hannover


