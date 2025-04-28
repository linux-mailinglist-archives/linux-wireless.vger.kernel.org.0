Return-Path: <linux-wireless+bounces-22119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B66BA9E888
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 08:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E194E7A65D3
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 06:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCE1C5F13;
	Mon, 28 Apr 2025 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="N6G51Hus"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388B1C5D46
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745822997; cv=none; b=JrUnKVNOOFedAzdYMM+XM7rU96Olc94j81fiHtHSzLCDX/MLev+Sli0M2OOys2JDDx2qW/D/eDkSgnLj0lAaWz0Ro328qXofk3MPDaQI1SP6NcNwHDkPpZ4psZ2XSSlKr4/Px5up8MxfUUIVlmMjQibuRVXRI12p/+t6H3HfH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745822997; c=relaxed/simple;
	bh=dISQJ7K6KC5obMPRT4fKpKbP/kzsFeqtzanjmIKBjyA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=jktkG5iY2gF2hLEpWBq+trM7N9mNIgc5luB/He5qa71oBLPYiy0EwZ7kT34wPMAQYuSknPg6PT+3LHNBN2zjbSHgKi/yMQBRbffvOldKleCn9ooLzHZnbjXonFo8FMurJtNLQs4Bbz5x8F2Qf1AxSh6ugUq7AWf9llZul4o+tbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=N6G51Hus; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53S6noyhF1674311, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745822990; bh=dISQJ7K6KC5obMPRT4fKpKbP/kzsFeqtzanjmIKBjyA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=N6G51Husad7hfVw4rJM31cuCxy2tvK9ftRCNbaX0TG6bnx+zeLvXgMKuUqqJ+L3+3
	 /Uypcw+54ikQ8BIFTd1K1GAcN18C8MXtIs7canqsZI3uaYDoJ+BOw0jOnANMikYuMy
	 LVtaQtt+CAP/V2K0HDOwKw+qHtQC0yGro9gdYbX/s1AGlDsOzhfB3hTaabLSqmzxNY
	 fsE9qh7BLBYggxfJTwtsg9dNpyRf1U9nMr3daIfbONJv5/4AHC8jjOmWL4786NYlT6
	 voOw741El2kNgvXZoE0HQrjS8HywCestpxkdq9dBlPw8vW5D9mWfatxxUj1zbj9TKW
	 rB8g3rYsMM13A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53S6noyhF1674311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 14:49:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 14:49:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 14:49:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: Re: [PATCH rtw-next 01/12] wifi: rtw89: 8922a: increase beacon loss to 6 seconds
In-Reply-To: <20250422014620.18421-2-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com> <20250422014620.18421-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <177830ed-c898-4fe1-8fef-7791fe626034@RTEXMBS04.realtek.com.tw>
Date: Mon, 28 Apr 2025 14:49:49 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> Intermittent beacon loss from specific AP triggers disconnection
> and reconnection. Increasing the beacon loss count will make the
> connection more stable.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

12 patch(es) applied to rtw-next branch of rtw.git, thanks.

74f754da761b wifi: rtw89: 8922a: increase beacon loss to 6 seconds
df6da0b81e2f wifi: rtw89: acpi: introduce country specific TAS enabling
27982c908240 wifi: rtw89: add suffix "_ax" to Wi-Fi 6 HW scan struct and func
57a5fbe39a18 wifi: rtw89: refactor flow that hw scan handles channel list
98019abbf97d wifi: rtw89: mcc: make GO announce one-time NoA for HW scan process
13bd2b36f22f wifi: rtw89: don't re-randomize TSF of AP/GO
50f9dc17a181 wifi: rtw89: mcc: make GO+STA mode calculate dynamic beacon offset
b8a2f9e0fab9 wifi: rtw89: mcc: handle the case where NoA start time has passed
584a423e7527 wifi: rtw89: mcc: update entire plan when courtesy config changes
ab67677712c0 wifi: rtw89: mcc: support courtesy mechanism on both roles at the same time
1cc8a27bf621 wifi: rtw89: mcc: refine filling function of start TSF
6644a416727c wifi: rtw89: mcc: avoid that loose pattern sets negative timing for auxiliary GO

---
https://github.com/pkshih/rtw.git


