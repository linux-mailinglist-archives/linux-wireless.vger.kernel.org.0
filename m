Return-Path: <linux-wireless+bounces-18901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD8A3392E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 08:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FBD3A216F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA04BA2D;
	Thu, 13 Feb 2025 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CmT4C6RB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C720B1EF
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432891; cv=none; b=GsqfyxxrWWJTeG3Y9RM5XiekjRWPkL1rSS1cPfZA0UxzqDksc+T4OgMc7MHEjuOI5hJX7TSPb/w6TNtJWOUD9t7bd8wZGuGk0aEYjuUZbJ8jOKq8kXi5DaKkoYJloVJ3h7asy3oJCDzBhmWngH3l+HBrFOuseHxWg99bIyZ4uR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432891; c=relaxed/simple;
	bh=Gf1Roj7hHu3drps2h7PiT6PFGjPY1+d9WakkFC8dMcw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R0AbzKqmDFM0lGNarjjEXJnadd6a5ZhVrVLX8V67K0T+zjnWJO2jEBxRCUNidjSUUWBckY/Hm5DEkUbCNhLICIczs61RW55dZFquEHl+ZQc1DAt6/8N2W4kaiubUPAaHIF6+QiVkWnSSG9hVTWE0//itRWrnW0u2hBhly7cQcUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CmT4C6RB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D7m6kC5597879, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739432886; bh=Gf1Roj7hHu3drps2h7PiT6PFGjPY1+d9WakkFC8dMcw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CmT4C6RBBtmMUQZVzvDo1EgNhK1CJVZntaVWmQ7SAlBgjLAs/9TRRX0SBPOxmSQMM
	 Ps1Urrnas1lL1L3B4aYTlUBIA5eRAFH3k1J8lc9LW7FrdzZli5kC+dlX2DxdAtabt8
	 R+CsybnnRJDwfeEqydOCQHpb8vkYN3FXvBFu5/qkWY9G376Ex9VLCYVpXWI+SRLxPF
	 qT5CymHP1AFDJlfNY9IeArUbuH8Ci6ibK5eGrfn60ZpZHcYrrdgJ3XNqUlqllOCNWJ
	 WJOYq/za3HXL/r/KAadk9woFIVY0TGTts14MWkV2wqcd7vA8sxVQq7O/a/nAnNHc3e
	 AOj06zHXjxkBQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D7m6kC5597879
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:48:06 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 15:48:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 15:48:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 15:48:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 7/8] wifi: rtw88: Extend rtw_debugfs_get_phy_info() for RTL8814AU
Thread-Topic: [PATCH 7/8] wifi: rtw88: Extend rtw_debugfs_get_phy_info() for
 RTL8814AU
Thread-Index: AQHbfNPgcISToMuv8kClOe4euUEYM7NE3Spg
Date: Thu, 13 Feb 2025 07:48:05 +0000
Message-ID: <630ad86a4a41424b8c8e7c8ff79cf0a9@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <2af9cee8-1b4e-4d97-bbf6-4f793005f910@gmail.com>
In-Reply-To: <2af9cee8-1b4e-4d97-bbf6-4f793005f910@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBQcmlu
dCBpbmZvcm1hdGlvbiBhYm91dCB0aGUgM3JkIGFuZCA0dGggUkYgcGF0aHMgYW5kIGFib3V0IHRo
ZSAzcmQNCj4gc3BhdGlhbCBzdHJlYW0uDQo+IA0KPiBBbHNvLCBmaXggYSBzbWFsbCBidWc6IGRv
bid0IHNob3cgdGhlIGF2ZXJhZ2UgU05SIGFuZCBFVk0gZm9yIHRoZSBPRkRNDQo+IGFuZCBIVC9W
SFQgcmF0ZXMgd2hlbiB0aGUgcmF0ZSBpcyBhY3R1YWxseSBDQ0sgMTFNLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFj
a2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KWy4uLl0NCg0KDQo+
IC0gICAgICAgaWYgKGRtX2luZm8tPmN1cnJfcnhfcmF0ZSA+PSBERVNDX1JBVEUxMU0pIHsNCj4g
KyAgICAgICBpZiAoZG1faW5mby0+Y3Vycl9yeF9yYXRlID49IERFU0NfUkFURTZNKSB7DQoNCkdv
b2QgY2F0Y2ggdGhlIGVycm9yLg0KDQo+ICAgICAgICAgICAgICAgICBzZXFfcHV0cyhtLCAiW1J4
IEF2ZXJhZ2UgU3RhdHVzXTpcbiIpOw0KPiAgICAgICAgICAgICAgICAgc2VxX3ByaW50ZihtLCAi
ICogT0ZETSwgRVZNOiB7LSVkfSwgU05SOiB7JWR9XG4iLA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAodTgpZXdtYV9ldm1fcmVhZCgmZXdtYV9ldm1bUlRXX0VWTV9PRkRNXSksDQoNCg0K
DQo=

