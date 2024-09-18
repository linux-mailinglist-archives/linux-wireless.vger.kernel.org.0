Return-Path: <linux-wireless+bounces-12933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207C497B859
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 09:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12E31F2282C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 07:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195AD7E792;
	Wed, 18 Sep 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linuxmail.org header.i=cemunal@linuxmail.org header.b="BFDDZLbn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996CE136A
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643769; cv=none; b=Xn6yunUJUuXHFTTf1thDPi92EUS5St3wr+/hBApTuUXA/Y3CwrPfSygw7cPsJdv5OWj+8WMUXVOGlTcCMcNyw1ynzlVzObR/QSaofHHnzTgqfg9T+6oL6bhqwX1jgMHM+4SbXQwjox6+QpRE+f/LwLPc7o+5KabKO6cp/TY7dgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643769; c=relaxed/simple;
	bh=YqfK+a191XCFODEiB1DSmcDL+E+bWVOlK145bubxm1w=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=OsPBtab7yqvG33OVzUG+k4cgt3RApaB9KFynYo4znqOHC7XRpfb4MGrIiWfxKv/BvTbWhv1hGIj7yT6syAhgxNGXXZGq3NDOjMsFX3jNmfKgSqk8AT6/vWeWsm6cH1Gw9CQgNFPqSGlxnTOayiQg1rdMk2KDnM66syLK5haCdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxmail.org; spf=pass smtp.mailfrom=linuxmail.org; dkim=pass (2048-bit key) header.d=linuxmail.org header.i=cemunal@linuxmail.org header.b=BFDDZLbn; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxmail.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxmail.org;
	s=s1089575; t=1726643761; x=1727248561; i=cemunal@linuxmail.org;
	bh=mFxxwyO7WFLH/LXfwkrNAJGwM2gJN2sujyI4jQAYvQE=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BFDDZLbnjxESOZEoiq90FcljPzy0ynMNZEWVG2q0yMI8YR8Lpu5ZWQCUd2dG7goH
	 NcMzhWCBxDGVGSlApQ6dnidOYbSPTuirCa5zFhmXmzFsV3hfBYZbuXQPBYuyyqHm+
	 G3lh5Cv7IP0bolhh9PHsC7Fj9uGLIcaUBy2oUGTBqAyHOb9VJXi3KQ6Dyyhg/M4hz
	 jSgjsaPNsS0J5+n3v15CX5R5FUCQmiAkhqwy9QFWo3NrihHsA/4EKj4y5XSFkpNE0
	 N8HXY7Mb9dpAz8S5P7U510GU3s50ciRE08Xg7/k7dYEQm4RmJRy7+ipN2D7WW6N/e
	 pPCc4fqU8jS2jtJ/ZQ==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [188.3.12.169] ([188.3.12.169]) by web-mail.mail.com
 (3c-app-mailcom-lxa04.server.lan [10.76.45.5]) (via HTTP); Wed, 18 Sep 2024
 09:16:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-154f2ef3-0df7-4802-88fc-d2ddcfb70a52-1726643761105@3c-app-mailcom-lxa04>
From: =?UTF-8?Q?Cem_=C3=9CNAL?= <cemunal@linuxmail.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: RE: PCIe Bus Error from rtw_8821ce
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Sep 2024 09:16:01 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <6d0fc72b21794f73a6017b467a102500@realtek.com>
References: <trinity-7a84c76b-e8b0-4da8-8f8c-07ad3485a23d-1726560422197@3c-app-mailcom-lxa11>
 <6d0fc72b21794f73a6017b467a102500@realtek.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:RjtOtT9PWBHqqmHo3gjFGwudrjt66bgtzLYxTSvsFoxh6zGtuP5t0SUVlcJ7ZS+9D3ARn
 yMG8oL3eyc4h4VfBVHCqckmM4RsMzg328o0jCAwPmYNGA3W2S6dRxaXuuE+97K1at1jschMBPulE
 J0a6RavHPoSlOhizLvfacEv7jmC2U1Zzr676TzBFy7kHMepN/kX8Q86vpcruPfG9tc6jNK+T3FcY
 IyuLJfhvd/jVjtt7sdcz50/slCAtsINHRlPIPUWdxDVHK4wumCupoCdXxy4UvzZziusktjKFe1s5
 9M=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wZvw+4ge9vA=;UW6n9we1s+63zEcKBE0VvabLo5l
 lR1v8zealfGZ0VI62Yfy+34BVyu4q9nfSiZnyY0tWjd7rhHoMKYEe1UBXu6sgUb7/NJDJVMNr
 KEngPdfP9LOr0jRwCv7KuwBJvTDr5qRPPzRZ+YqhFAvMR6xLtM7gh30A2JshRAAmafPO8MvPj
 WC6g2ub3/j2WHLcRRIRMm8a0qXhnBmGFRJAyyiLO3NbVX+hLDBbAvSCanuLbe5Oq24vwnX5rX
 OiTzDKrETWuNFrH/z/DVctjBMJEpZdw9g7pE5C3N/wuvfft8oTqmKz7Xqql7MaoppG+woVSAl
 6thdbs/16cHuNWs4Cvm6FLue2Y9M77XB0TT5dsHHV99iNa4QR95wnrIGsEEUw3x0Jbd6lVJrs
 3DxQlpRgPzDWUZ70OGT6NlwYLqnQrFvtNY2FTIBSPPz/ieOIqsV8WQCx64oxJdT3xwgU+Qhpy
 JzbYsEdDiWpOKfEPOlOcIX1rrYoMzy7sPGNK9tWIG+G5RY/OU1AvgsXbvCGHunlkuwO7ye8Ra
 GgkG3bkmqjpyA9YMQGVt8WBh4r7sYZqw0lClHoHbj8brVm0GEOTTh8jb9mFLvC+APuGrsJEA4
 rfdWANdBnl/XQcp68OFWtAEv6iXMuR+568afOsJRzwaRUadAtnXvhY1tR0eK2F5kwJYLj2+WW
 Xv56QMOKsHLR/4jESzZQBr4V4ans5KWTXFbLaDXeZA==

Thank you but this did not solve the problem=2E

> Sent: Wednesday, September 18, 2024 at 4:28 AM
> From: "Ping-Ke Shih" <pkshih@realtek=2Ecom>
> To: "Cem =C3=9CNAL" <cemunal@linuxmail=2Eorg>, "linux-wireless@vger=2Eke=
rnel=2Eorg" <linux-wireless@vger=2Ekernel=2Eorg>
> Subject: RE: PCIe Bus Error from rtw_8821ce
>
> Cem =C3=9CNAL <cemunal@linuxmail=2Eorg> wrote:
> > I am testing build-in kernel drivers for rtw_8821ce and getting same e=
rror logs only=2E Here is some info:
> >=20
> > sudo lspci -v:
> >=20
> > 02:00=2E0 Network controller: Realtek Semiconductor Co=2E, Ltd=2E RTL8=
821CE 802=2E11ac PCIe Wireless Network Adapter
> > Subsystem: AzureWave Device 3040
> > Flags: bus master, fast devsel, latency 0, IRQ 130
> > I/O ports at e000 [size=3D256]
> > Memory at ef000000 (64-bit, non-prefetchable) [size=3D64K]
> > Capabilities: [40] Power Management version 3
> > Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> > Capabilities: [70] Express Endpoint, IntMsgNum 0
> > Capabilities: [100] Advanced Error Reporting
> > Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-c8-21-01
> > Capabilities: [158] Latency Tolerance Reporting
> > Capabilities: [160] L1 PM Substates
> > Capabilities: [170] Precision Time Measurement
> > Capabilities: [17c] Vendor Specific Information: ID=3D0003 Rev=3D1 Len=
=3D054 <?>
> > Kernel driver in use: rtw_8821ce
> > Kernel modules: rtw88_8821ce
> > __________
> >=20
> > uname -r:
> >=20
> > 6=2E10=2E9-200=2Efc40=2Ex86_64
> > __________
> >=20
> > sudo dmesg | grep rtw:
> >=20
> > [ 7=2E785903] rtw_8821ce 0000:02:00=2E0: enabling device (0000 -> 0003=
)
> > [ 7=2E799541] rtw_8821ce 0000:02:00=2E0: Firmware version 24=2E11=2E0,=
 H2C version 12
> > [ 7=2E852418] rtw_8821ce 0000:02:00=2E0 wlp2s0: renamed from wlan0
> > [ 143=2E722023] rtw_8821ce 0000:02:00=2E0: PCIe Bus Error: severity=3D=
Correctable, type=3DPhysical Layer, (Receiver
> > ID)
> > [ 143=2E722043] rtw_8821ce 0000:02:00=2E0: device [10ec:c821] error st=
atus/mask=3D00000001/0000e000
> > [ 143=2E722058] rtw_8821ce 0000:02:00=2E0: [ 0] RxErr (First)
> > [ 161=2E626544] rtw_8821ce 0000:02:00=2E0: PCIe Bus Error: severity=3D=
Correctable, type=3DPhysical Layer, (Receiver
> > ID)
>=20
> Suggest to turn of power save by editing /etc/modprobe=2Ed/70-rtw88=2Eco=
nf
> with these two options:
>=20
>   options rtw88_pci disable_aspm=3Dy
>   options rtw88_core disable_lps_deep=3Dy
>=20
> Then cool reboot your computer=2E=20
>=20
>=20
>

