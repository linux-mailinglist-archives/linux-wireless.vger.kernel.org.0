Return-Path: <linux-wireless+bounces-30080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9483BCD8685
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 08:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 294D13018742
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60762156F45;
	Tue, 23 Dec 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eEa16hv7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90D1487E9
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766476088; cv=none; b=TuUgykkVBkzbSNqB2yd7PM5dZWmJFYTWeiV68ZOWDOR2elpLbcbQ6pM4bk0Lph0eTW+9N4gIf78H7xpqdJcfTUiy2siossLYc1pRM4dHCYvpCBIv9qF7Nt/XsnhhdHGuYNK8KB/Xpquh5YsQ6/zNWIjcDXaZzeN6OexrH4RZ9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766476088; c=relaxed/simple;
	bh=NuSXIRl/BejsUWQrvwolaw1yDVuwKDVkaKQJL1PA8q8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l8NT3U27bEMgt6YrqMg6sXIk/Qwamq28h03+OlfSY5+IiWUcamgqh9K3N9mvWddvzQUBYS95OOh8zis15GwF27aO2Ctz/3/lCCNtldF5oLGgsPVOfxg+qri1b5RFcnE4QPSGiYkA9b0qn1xjMv4kU7MF80fweY/NrdMyDHi3tnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eEa16hv7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN7lvLN3961266, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766476077; bh=xByRV1TY48tGSFoUCJDAh3e/CdOl93sKfyavZMY91wE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eEa16hv7w4iMTsKRtL7NU1oC6rbtm5oOdjGouu1OSaqP+8ibwoSjgcMNHv9b3uY4e
	 bAfS2IgU/18Tqu/HlqeZVcuazzMZunsv4lnCK1OSPTr4VxnL+/7jZX1iMlq+sgycEI
	 1IIHu94PjxGKUEOtgyG/w+ettjldltb25u7ZpRIaF0M+NeUPddSq03ANQ+tyUXIlJD
	 UB6ZCuQYbIzJdocgZT2R6whoaA1VuMaLwYMgOoJkeR4HwDUJG7JXPmXdHKM/z2IDfc
	 JRE7ul6rrvEl9yN1TShpiFCtjkueqM9QUE/0kaEb1JNIoS/zkccxSnZVvdehrBlqKu
	 cJolkAqQKcH/Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN7lvLN3961266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 15:47:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 15:47:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 15:47:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 23 Dec 2025 15:47:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Chris Russomanno <russomch@aol.com>,
        "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [BUG] Intel B580 (e20b) HDMI Flicker & Realtek RTL8922AE 6GHz
 missing - Mint 22.3
Thread-Topic: [BUG] Intel B580 (e20b) HDMI Flicker & Realtek RTL8922AE 6GHz
 missing - Mint 22.3
Thread-Index: AQHccYNzkqomb5qXxkujgzhV+EMuFbUu29YA
Date: Tue, 23 Dec 2025 07:47:57 +0000
Message-ID: <3dcf5e11aa284daa9d3733141ccdc17f@realtek.com>
References: <AB8446D8-708B-4971-8852-87353112E60F.ref@aol.com>
 <AB8446D8-708B-4971-8852-87353112E60F@aol.com>
In-Reply-To: <AB8446D8-708B-4971-8852-87353112E60F@aol.com>
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

Chris Russomanno <russomch@aol.com> wrote:
> Hello,
>=20
> I am reporting two issues encountered on brand-new hardware using Linux M=
int 22.3 with Kernel 6.14.0-generic.
>=20
> Hardware Environment:
> - GPU: Intel Arc B580 (Battlemage), PCI ID: [8086:e20b]
> - WiFi: Realtek RTL8922AE (rtw89), Firmware: rtw8922a_fw-3.bin
> - Display: Samsung 4K Monitor connected via HDMI (No DisplayPort availabl=
e)
>=20
> Issue 1: Intel Xe HDMI Flickering
> The Samsung monitor experiences intermittent black-screen flickering (1-2=
 seconds) at both 4K and 1080p
> resolutions. This behavior is not present on Windows 11.
> Troubleshooting attempted:
> - Added kernel parameters: quiet splash i915.enable_psr=3D0 xe.force_prob=
e=3De20b i915.enable_dc=3D0
> intel_iommu=3Digfx_off intel_idle.max_cstate=3D2
> - Forced "TearFree" and "TripleBuffer" in xorg.conf.
> - Frequency remains at 60Hz.
>=20
> Issue 2: Realtek RTL8922AE 6GHz/WiFi 7 Missing
> The card functions on 5GHz (1200 Mb/s) but does not scan or see 6GHz freq=
uencies.
> Troubleshooting attempted:
> - Set regdom to US (iw reg set US).
> - Driver options: rtw89_pci disable_aspm=3Dy, rtw89_core disable_6g=3DN.
> - 'iw list' does not return any 6GHz/6105 MHz frequencies.

Please share output of 'iw list' before/after setting US.=20

In my side (expected) frequencies of band 4 are:

[Before]
                Frequencies:
                        * 5955.0 MHz [1] (disabled)
                        * 5975.0 MHz [5] (disabled)
                        * 5995.0 MHz [9] (disabled)
                        * 6015.0 MHz [13] (disabled)
                        * 6035.0 MHz [17] (disabled)
                        * 6055.0 MHz [21] (disabled)

[After]
                Frequencies:
                        * 5955.0 MHz [1] (12.0 dBm) (no IR)
                        * 5975.0 MHz [5] (12.0 dBm) (no IR)
                        * 5995.0 MHz [9] (12.0 dBm) (no IR)
                        * 6015.0 MHz [13] (12.0 dBm) (no IR)
                        * 6035.0 MHz [17] (12.0 dBm) (no IR)



