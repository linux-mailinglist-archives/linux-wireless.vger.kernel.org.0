Return-Path: <linux-wireless+bounces-13138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4BC98516E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 05:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8254A284EA7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 03:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC578126F0A;
	Wed, 25 Sep 2024 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vhXwc2W6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF313D28F
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 03:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235063; cv=none; b=CjLitO1lRz67dmIt5zo9xii1VelX171BKKfvUKAYNjZkLLBHkZiHAvdEV6m1D71zOdOl+anl7EbqNKC4tCfE8VkAAPdSKLEt0EQH89ulkkoO15Tv7SLz7GOgJKY2phnpOPN1w1ZroANy2zHIKEnjQ/EEX6sbaynJ4uboeXKM9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235063; c=relaxed/simple;
	bh=lZ41XrreKb2idHJ+XV7apS1aU0INQwOXazUfy77CtzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OP/4ahVpl5MZ9Uf9B3iYLAAMs4gsju5+dEFXhx/ymvorONhe3c6mJWC5Z3N2MuAPxKMudgbGTSOCmvstfZRUM7f3BA3iipowzqsx9yCfgKIdScD8k9Jqdc8h0B/pitpl9DhA3tDgzyAeIXmQURNf/YXRFgwnu8mF/0xm4jiVLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vhXwc2W6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48P3UGE403967754, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727235016; bh=lZ41XrreKb2idHJ+XV7apS1aU0INQwOXazUfy77CtzY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vhXwc2W62CH2zX5m+FqTVQ7LJM6PQpYR0JT6fuotO4D5PX0zprR/606T755yoE0aE
	 V21Lch1AsrMn7TVKO71PaCgcTxtK0x+VCahX7Pu/KPp66fRY8p5aHoPgDEd43KRsDg
	 Z9c84qugWxqFy4ECXHXOZKKgStYALLkC9s0aDEdNSLBvWukaOXICWBPJMXMG1G1H4l
	 GcKkey/8LmWZnd830Gnhx8UKKt2AG4qeU2O0DHFk5EUlFsCCo+Tl9ohjtgR5wz5sdo
	 eHVixwgZzS6ubW1AHrdUKo8TSRxUfCKZgjsMw6PoFpKXwoOUTOuCFf7qJPEm3MG2kf
	 cp3c4qxrQzXsQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48P3UGE403967754
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 11:30:16 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 11:30:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 25 Sep 2024 11:30:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 25 Sep 2024 11:30:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "petter@technux.se" <petter@technux.se>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
CC: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "morrownr@gmail.com"
	<morrownr@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: rtw88: rtw8822cu: Kernel warning in cfg80211: disconnect_work at net/wireless/core.h:231 on CPU 0
Thread-Topic: rtw88: rtw8822cu: Kernel warning in cfg80211: disconnect_work at
 net/wireless/core.h:231 on CPU 0
Thread-Index: AQHbDlBMQrWI+wnn6UWsv+tgTc/yIbJn1a/Q
Date: Wed, 25 Sep 2024 03:30:15 +0000
Message-ID: <9d243087654c4f3492d0046b7444c6a6@realtek.com>
References: <80de30f72595480a2e061dc462191c9f@technux.se>
In-Reply-To: <80de30f72595480a2e061dc462191c9f@technux.se>
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

+ Johannes to comment wiphy_lock stuff=20

petter@technux.se <petter@technux.se> wrote:
> Hi,
>=20
> I have an issue with my 8822cu based usb device on >=3D 6.6 Linux with AP
> mode. Using latest changes AP-mode seems to work fairly good. But when
> enabling/disabling it I seems to always get below. It sometimes happens
> without using AP-mode also, when for example disconnection happens due
> to bad connection. Any ideas what might be causing this? Please also let
> me know if you want additional debugging logs etc.
>=20
> BR Petter
>=20
>=20
> ```
>=20
> [ 1429.886683] WARNING: CPU: 0 PID: 9 at net/wireless/core.h:231
> disconnect_work+0xb8/0x144 [cfg80211]
> [ 1429.898367] Modules linked in: rtw88_8822cu rtw88_8822c rtw88_usb
> rtw88_core mac80211 libarc4 cfg80211 btusb btrtl btintel btbcm btmtk
> imx_sdma ip_tables x_tables
> [ 1429.913362] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted
> 6.6.51-00141-ga1649b6f8ed6 #7
> [ 1429.921228] Hardware name: Freescale i.MX6 SoloX (Device Tree)
> [ 1429.927082] Workqueue: events disconnect_work [cfg80211]
> [ 1429.933556]  unwind_backtrace from show_stack+0x10/0x14
> [ 1429.938833]  show_stack from dump_stack_lvl+0x58/0x70
> [ 1429.943922]  dump_stack_lvl from __warn+0x70/0x1c0
> [ 1429.948759]  __warn from warn_slowpath_fmt+0x16c/0x294
> [ 1429.953939]  warn_slowpath_fmt from disconnect_work+0xb8/0x144
> [cfg80211]
> [ 1429.961935]  disconnect_work [cfg80211] from

I think the cause is picking commit 268f84a82753=20
("wifi: cfg80211: check wiphy mutex is held for wdev mutex"), and
cfg80211_is_all_idle() called by disconnect_work() uses wdev_lock()
but not wiphy_lock().=20

I'm not sure if we should simply revert the picked commit 268f84a82753
or should pick more commits.

By the way, I think the latest kernel will not throw these messages.
Could you try it?


