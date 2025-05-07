Return-Path: <linux-wireless+bounces-22699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90CDAAD31C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 04:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41CC3A43E3
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 02:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542CB15746F;
	Wed,  7 May 2025 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="v3gxNOsD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93499219ED
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583829; cv=none; b=NMXRv1vSedQjE4RTtI36y+L7zmZCu6EXLkq8Ohei5Mw2pjBsY9tUGGAsJmiW//JnPFzHLsJkqkvVa+JJRjgJG0Gj0LTIFTcB3ZZ02O/E1jciQB4EfeM6VfbcZ3v31nZaIirTn21MEOxrTF7W9p378zY5xxKSmr5PnZ2XIwBX1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583829; c=relaxed/simple;
	bh=JDdcrgaEn5ZC5rZbaqwWNMqE20rjVwxuZ7l1varsLB0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Er8m7XHP/YpjVFPwMgHYpmSFGRoGfZcDytqa1pRXrTy96vIanVCiybZJsFMypWSoJ0iSIMCHw2XLfmQaA2cr91zIDftWmzpnZVbDlNPhJEJ+7NdRZ7/IiQmvRr3fAF1cNpZVChA5GMFXRLMt0UL9RsCO5iwD1zCnKL9F7x6gtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=v3gxNOsD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5472AIJB03617273, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746583818; bh=JDdcrgaEn5ZC5rZbaqwWNMqE20rjVwxuZ7l1varsLB0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=v3gxNOsDEUUg3WOY2nkE97QzJDM/hFQvvEIzJ86Dd/zMx7LUBVc5TXtFD57s25htI
	 bu2/YuYnTJxRdPygeeP4POXMhgSB2Lq3AhwudwiNT+V9VAslZK4FDEQAjB+AB9bDZe
	 rPLtExs+q2zdUMHK2OrRg+kyAD2m7GGnu4wQBALhmxoy6Lx/40KjlRWwbAraglcajM
	 ufzxSb8bSf/hsGmGZrRUAkjfLKMpoMkT7y8NKTAQbNeRKpqCGN5niMJJ5nYilG7rgW
	 eAgImUtbzHFLs3G65YIJc+tRvAEOGqR204RuBPjlg5hklgj6jRvShobkNQYLEWUiXw
	 rSzTXezhMFVtA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5472AIJB03617273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 10:10:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 May 2025 10:10:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 May 2025 10:10:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 7 May 2025 10:10:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "zhengyushi(ZHENGYU SHI)" <zhengyushi@global.tencent.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [BUG] rtw89: high latency jitter on AzureWave Device 6110 (RTL8851BE) under Linux 6.14.4
Thread-Topic: [BUG] rtw89: high latency jitter on AzureWave Device 6110
 (RTL8851BE) under Linux 6.14.4
Thread-Index: AQHbvl9He46pkUrVxEWfnGKUw2rIorPGZ6MA
Date: Wed, 7 May 2025 02:10:18 +0000
Message-ID: <817f1db10717446ab92e85786ac34dd1@realtek.com>
References: <DM6PR13MB3324CB742CF4CE86B4B363ACF3892@DM6PR13MB3324.namprd13.prod.outlook.com>
In-Reply-To: <DM6PR13MB3324CB742CF4CE86B4B363ACF3892@DM6PR13MB3324.namprd13.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

zhengyushi(ZHENGYU SHI) <zhengyushi@global.tencent.com> wrote:
>=20
> I=1B$B!G=1B(Bm seeing severe ping spikes (1?90 ms) when using the onboard=
 Realtek RTL8851BE Wi-Fi (Device b851,
> rtw89_8851be) on Arch Linux. Switching to a USB-tethered phone (same AP) =
completely eliminates the jitter
> (<5 ms). The behavior is completely reproducible. I suspect an issue in t=
he rtw89 driver=1B$B!G=1B(Bs power-management
> or PCIe handling.
>=20
> I tried
> - Disabling power management via injecting ASPM/L1/L1SS and CLKREQ via rt=
w89_pci.disable_clkreq=3Dy
> rtw89_pci.disable_aspm_l1=3Dy rtw89_pci.disable_aspm_l1ss=3Dy
> - Verified no firmware=1B$B!>=1B(Bdriven roaming or reassociation in logs
>=20
> Device Info:
> % lspci | awk '/[Nn]et/ {print $1}' | xargs -i% lspci -ks %
> 07:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168=
/8211/8411 PCI Express Gigabit
> Ethernet Controller (rev 15)
>         DeviceName: Realtek RTL8125BG LAN
>         Subsystem: ASUSTeK Computer Inc. Onboard RTL8111H Ethernet
>         Kernel driver in use: r8169
>         Kernel modules: r8169
> 08:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b851
>         Subsystem: AzureWave Device 6110
>         Kernel driver in use: rtw89_8851be
>         Kernel modules: rtw89_8851be
>=20
> % uname -r
> 6.14.4-arch1-1
>=20
> % mtr 8.8.8.8
> Apotheosis (192.168.0.42) =1B$B"*=1B(B 8.8.8.8 (8.8.8.8)  2025-05-05T21:1=
5:47+0800
>  Host                    Loss%  Snt  Last   Avg  Best  Wrst  StDev
>  1. _gateway              0.3%   330   0.7   1.6   0.3  82.4   5.8
>  2. 100.66.0.3            1.2%   330   2.0   3.1   1.2 109.9   9.5
>  3. chj-dsl9.vqbn.com     0.3%   330   2.0   3.3   1.3  95.3   8.5
>  4. 132.147.112.109       0.0%   329   2.6   4.0   1.7 102.8   9.4
>  5. 132.147.112.194      24.0%   329   4.7   7.9   3.4 127.1  16.0
>  6. 209.85.255.97         0.0%   329   2.5   3.5   1.6 131.1   8.6
>  7. 142.251.241.1         0.0%   329   2.4   3.4   2.0 109.7   7.3
>  8. dns.google            0.0%   329   2.8   3.0   1.5 105.9   7.2
>=20

This is my test in office where at least 50 AP are existing:
(Actually I don't expect the latency is always low in this environment.)

64 bytes from 192.168.0.1: icmp_seq=3D1 ttl=3D64 time=3D3.40 ms
64 bytes from 192.168.0.1: icmp_seq=3D2 ttl=3D64 time=3D24.0 ms
64 bytes from 192.168.0.1: icmp_seq=3D3 ttl=3D64 time=3D4.32 ms
64 bytes from 192.168.0.1: icmp_seq=3D4 ttl=3D64 time=3D4.36 ms
64 bytes from 192.168.0.1: icmp_seq=3D5 ttl=3D64 time=3D6.30 ms
64 bytes from 192.168.0.1: icmp_seq=3D6 ttl=3D64 time=3D7.15 ms
64 bytes from 192.168.0.1: icmp_seq=3D7 ttl=3D64 time=3D2.48 ms
64 bytes from 192.168.0.1: icmp_seq=3D8 ttl=3D64 time=3D2.54 ms
64 bytes from 192.168.0.1: icmp_seq=3D9 ttl=3D64 time=3D2.04 ms
64 bytes from 192.168.0.1: icmp_seq=3D10 ttl=3D64 time=3D122 ms

This is another test in my house where AP is much less:

64 bytes from 192.168.1.1: icmp_seq=3D1 ttl=3D64 time=3D2.86 ms
64 bytes from 192.168.1.1: icmp_seq=3D2 ttl=3D64 time=3D1.33 ms
64 bytes from 192.168.1.1: icmp_seq=3D3 ttl=3D64 time=3D1.31 ms
64 bytes from 192.168.1.1: icmp_seq=3D4 ttl=3D64 time=3D3.54 ms
64 bytes from 192.168.1.1: icmp_seq=3D5 ttl=3D64 time=3D1.50 ms
64 bytes from 192.168.1.1: icmp_seq=3D6 ttl=3D64 time=3D4.03 ms
64 bytes from 192.168.1.1: icmp_seq=3D7 ttl=3D64 time=3D3.55 ms
64 bytes from 192.168.1.1: icmp_seq=3D8 ttl=3D64 time=3D2.86 ms
64 bytes from 192.168.1.1: icmp_seq=3D9 ttl=3D64 time=3D1.27 ms
64 bytes from 192.168.1.1: icmp_seq=3D10 ttl=3D64 time=3D3.49 ms

I'm using firmware v0.29.41.3. Please check which version you are using.

Turning off power_save by 'sudo iw wlan0 set power_save off' can improve
a little bit. You can also try it.=20

The factors of high latency might be caused by noisy environment, so
RTL8851BE is hard to transmit out or collision. Using a sniffer with
ping test would be easier to diagnose the reason.=20

Method to use another RTL8851BE or other WiFi devices as a sniffer:=20
   sudo iw dev wlan0 interface add mon0 type monitor
   sudo wireshark
Then select proper channel via wireshark GUI to capture packets from/to
target RTL8851BE.



