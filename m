Return-Path: <linux-wireless+bounces-17366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C506FA0A6F5
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 03:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CB63A4935
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76D24B254;
	Sun, 12 Jan 2025 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ffy8Q4iR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF074D528
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736647946; cv=none; b=j5WG7w2vdChSLZjS+8V0zT1uMCcyVVldbPTysH3qhT7QNOvqf9zZ885MfI1SU8wsMvcgwAM3vl6jbDqSOgpEDtZXBPg3DJB7DHFj7DTqOEsqgXSdlyX3agZkoJiCcddEaol2JqgMYZMsiK+jjdd0rWjE2eSa35kUfz6Hg8mSGCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736647946; c=relaxed/simple;
	bh=3YxNiqK8zk0D2x4/cjAYL8tnqr3KIgtgNJ0exJg9VHo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=oVhmGXPzlmlV5ldUXqJ0BvMHTYP9yoeHGrMW8ye6kRUv3BLaxgVq/B5ByQoJzhsAT1xrFyA88eGrIXpi6208/FIFKROcJ0xTwxsFBpx0MKqGp2rBdOu4xkylwtVGRWvUmS+FK3XQlOOUrWfuVO7FUMS/JhbSnd2ub6CEVmzYneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ffy8Q4iR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C2CHsaC1614531, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736647937; bh=3YxNiqK8zk0D2x4/cjAYL8tnqr3KIgtgNJ0exJg9VHo=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Ffy8Q4iRAFg4hHCHJ8bw7ml1rU5J74ED2ikVI7MJ9ZZMKN6qirHL9KeWry7wmTZOc
	 aYi8vtjHESQ40yNBuxnjSqH4PCNnlGm/XtMQLSM4aMz9g6ibnmGwVxyUftlJQYRRZj
	 nEiodV8ghW53BcPD75CIHJUpVuW/jXNiDox0TMtO60Ar/U27h+hb0ygE2Es2rK3k1B
	 MCIZKIfHqGSKG7vWJn+zwtnY8H/celsW5b144D3U3Jj+1xTu3SeP2VrT0DvuOyVJix
	 b1FMGSaIfA3mIXTYPe07jLzh6dmds7iJKBuw7pz9eE7W1FwWHBBMEyrUXhgrg0OU2C
	 6aSTjL9L2x1QA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C2CHsaC1614531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Jan 2025 10:12:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 10:12:17 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 10:12:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
Subject: Re: [PATCH v3] wifi: rtw88: Add support for LED blinking
In-Reply-To: <6c43451f-ab2f-4e76-ac6e-ff5a18dd981d@gmail.com>
References: <6c43451f-ab2f-4e76-ac6e-ff5a18dd981d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <504cfeff-eb9d-481e-b1ca-ab3addad3daf@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 10:12:16 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Register a struct led_classdev with the kernel's LED subsystem and
> create a throughput-based trigger for it. Then mac80211 makes the LED
> blink.
> 
> Tested with Tenda U12 (RTL8812AU), Tenda U9 (RTL8811CU), TP-Link Archer
> T2U Nano (RTL8811AU), TP-Link Archer T3U Plus (RTL8812BU), Edimax
> EW-7611UCB (RTL8821AU), LM842 (RTL8822CU).
> 
> Also tested with devices which don't have LEDs: the laptop's internal
> RTL8822CE and a no-name RTL8723DU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

4b6652bc6d8d wifi: rtw88: Add support for LED blinking

---
https://github.com/pkshih/rtw.git


