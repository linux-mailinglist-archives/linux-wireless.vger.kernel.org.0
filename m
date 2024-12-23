Return-Path: <linux-wireless+bounces-16728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C49FAB53
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 08:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1243C1884874
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948FB19046E;
	Mon, 23 Dec 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="krUkTp/l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FA156C6A
	for <linux-wireless@vger.kernel.org>; Mon, 23 Dec 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734940678; cv=none; b=ASRAuP3tdL6knfmHNvd0Zw7RBUGY75k8eIixpHFa7Zts/Ba0cRPLz9wxZmdROTSVPKBq04PNVs172Qi/WyNsTqV1R9dNxncibLd/XfmVgm75MK5DuMoSWoZFSIh4iReAd+IEyE1v8D1TykVWNuIq64kizQy1KSA4E25s93l96QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734940678; c=relaxed/simple;
	bh=I8a+C9V8WiLCs6zmipgBtE7kN2mT/4o/Z7osfsRvuf0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=JE82RRNCw72+eDMZ5PP8MTqlRwy0zN1uQ46scN2JrSmBS0XIubxuoN41i4fYsjkitdnnsHWLw5y1OAsqRtllIYprhKwKCcH2DpG0kqgJ03iqkQ3jmWEIYzvGCK3SwoT7Vy80VFQJB/Yh7vJflmJCLVhgwGVtWe3Yqi19KdZ/p90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=krUkTp/l; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BN7vqRR31477335, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734940672; bh=I8a+C9V8WiLCs6zmipgBtE7kN2mT/4o/Z7osfsRvuf0=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=krUkTp/lzv0jiSwuVMt+Xwnph0mRK6QFilqXBjbLoNG6UpwgONJlbPGh1joRXsSr3
	 49QuvvWYhZ4LMTPO/32lCS1mxCI2aCztfWvYDvOEH1sp77tVqO5scmi4FmV/LAp6Y5
	 GPIglG6nc2ctZ1+/4mKHc843cLzxLvRJ9x+tLcOS759BaAH2p1wcTq7fe763nshAr8
	 sE84nZx71ZubvEuWsTMW4Uxy7ixwWVlijEcC6v8uSZXLzhlxbaof/Wd1q/iRtK6BKS
	 eT+uDVgqWYqno2mojXrFv5klLt2Bz8DVwjJQ+hNJonZ6swc1UCUFmtYzCgf+jWALAu
	 krdGn0GYr0ViQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BN7vqRR31477335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 15:57:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Dec 2024 15:57:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 23 Dec
 2024 15:57:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH] wifi: rtlwifi: rtl8821ae: Fix media status report
In-Reply-To: <754785b3-8a78-4554-b80d-de5f603b410b@gmail.com>
References: <754785b3-8a78-4554-b80d-de5f603b410b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5c4c3c5a-00f3-4e02-9d9d-a1536896ffc6@RTEXMBS04.realtek.com.tw>
Date: Mon, 23 Dec 2024 15:57:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> RTL8821AE is stuck transmitting at the lowest rate allowed by the rate
> mask. This is because the firmware doesn't know the device is connected
> to a network.
> 
> Fix the macros SET_H2CCMD_MSRRPT_PARM_OPMODE and
> SET_H2CCMD_MSRRPT_PARM_MACID_IND to work on the first byte of __cmd,
> not the second. Now the firmware is correctly notified when the device
> is connected to a network and it activates the rate control.
> 
> Before (MCS3):
> 
> [  5]   0.00-1.00   sec  12.5 MBytes   105 Mbits/sec    0    339 KBytes
> [  5]   1.00-2.00   sec  10.6 MBytes  89.1 Mbits/sec    0    339 KBytes
> [  5]   2.00-3.00   sec  10.6 MBytes  89.1 Mbits/sec    0    386 KBytes
> [  5]   3.00-4.00   sec  10.6 MBytes  89.1 Mbits/sec    0    386 KBytes
> [  5]   4.00-5.00   sec  10.2 MBytes  86.0 Mbits/sec    0    427 KBytes
> 
> After (MCS9):
> 
> [  5]   0.00-1.00   sec  33.9 MBytes   284 Mbits/sec    0    771 KBytes
> [  5]   1.00-2.00   sec  31.6 MBytes   265 Mbits/sec    0    865 KBytes
> [  5]   2.00-3.00   sec  29.9 MBytes   251 Mbits/sec    0    963 KBytes
> [  5]   3.00-4.00   sec  28.2 MBytes   237 Mbits/sec    0    963 KBytes
> [  5]   4.00-5.00   sec  26.8 MBytes   224 Mbits/sec    0    963 KBytes
> 
> Fixes: 39f40710d0b5 ("rtlwifi: rtl88821ae: Remove usage of private bit manipulation macros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

66ef0289ac99 wifi: rtlwifi: rtl8821ae: Fix media status report

---
https://github.com/pkshih/rtw.git


