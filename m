Return-Path: <linux-wireless+bounces-16640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2899F89AE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 02:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC2F7A0425
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 01:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A82594B4;
	Fri, 20 Dec 2024 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IWr6KSjl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C132594A7
	for <linux-wireless@vger.kernel.org>; Fri, 20 Dec 2024 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734659071; cv=none; b=n0K+ainth9oAdTqCVoWIjaIm/nkOhO38Tn6mb8wSSLNzi5evWLqpaCWIt4JUcSRCNChG7mo+DwBVqyL7Xz9zkJh0PLiMmbn/UyeoFLIEbPYSRoVXexVHt+8vqVIE9oQLIim85XxOpP9pp1uTQARY8UPKyN3KSvw4bbHeqAMik98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734659071; c=relaxed/simple;
	bh=+cN5Fh3KP0EXDWQzzuUQIvX/3dIH9D6rWRZpC2NGG5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fii2JPxB130qefR5xECwkFmg+13wraNjyO+UPtaHf+RkHr4KN+A0RkLkU5uf9i1SOJKN58p3JiNKDanUcxHkjNFaQXXBXYhwrYGrKJMnrWnn0Ou+2oAOqp+9X5NaM5QBY6Cz4x7ai7PpxYThoKfre0+EGI26FfGHQwUISR88jBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IWr6KSjl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BK1iCRm9727205, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734659053; bh=+cN5Fh3KP0EXDWQzzuUQIvX/3dIH9D6rWRZpC2NGG5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IWr6KSjlcZs7st2YYqHoIu6szDsT+zoNoPyrk6pA8KVMeGxRWbCv5ZrZtendrcSuY
	 PYB/Vfz/Y82SAzzzwf9YyZ/ft1k9mPmbaGf0+b729Y/m62WfYu62l3eL7dlCRIDY60
	 x0on4op3yfEciN+Zcn1gnPGuJiAKWd5tNXHITSjPX3pltLKjyM8v09TDeSvh2+7ppu
	 3s0oojVca+Tz6OqMoOgkiP3pWEoIEpPnUklhk4WAyW6tQZOAbFVNzQ2QS/MxOvzcd1
	 kAIskNwRFzksm+YeLx1pZBWdP1dCzQOXwk8HABIoGoQ/jL8NwvjAKy9ZnKuqsW4Dkf
	 I+kFVdWUU5LaA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BK1iCRm9727205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 09:44:12 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Dec 2024 09:44:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 20 Dec 2024 09:44:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 20 Dec 2024 09:44:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH] wifi: rtw88: Add USB PHY configuration
Thread-Topic: [PATCH] wifi: rtw88: Add USB PHY configuration
Thread-Index: AQHbUjHyD5bs1Y5Kp0O9qQAueHs6ILLuRu2ggAAVs2A=
Date: Fri, 20 Dec 2024 01:44:12 +0000
Message-ID: <0253941dda7841bd941beb58605062ab@realtek.com>
References: <a3b87566-4e11-4fc2-8c51-db592e56af13@gmail.com>
 <8cc7b4d2051a4b2abe02f6359243bff4@realtek.com>
In-Reply-To: <8cc7b4d2051a4b2abe02f6359243bff4@realtek.com>
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

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gKw0KPiA+ICtzdGF0aWMg
dm9pZCBydHdfdXNiX3BoeV93cml0ZShzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1MTYgYWRkciwg
dTE2IGRhdGEsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSB1c2JfZGV2
aWNlX3NwZWVkIHNwZWVkKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpZiAoc3BlZWQgPT0gVVNCX1NQ
RUVEX1NVUEVSKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJ0d193cml0ZTgocnR3ZGV2LCAweGZm
MGQsICh1OClkYXRhKTsNCj4gPiArICAgICAgICAgICAgICAgcnR3X3dyaXRlOChydHdkZXYsIDB4
ZmYwZSwgKHU4KShkYXRhID4+IDgpKTsNCj4gPiArICAgICAgICAgICAgICAgcnR3X3dyaXRlOChy
dHdkZXYsIDB4ZmYwYywgYWRkciB8IEJJVCg3KSk7DQo+IA0KPiBUaGUgY2FzdGluZyBvZiB1OCBp
cyBub3QgdW5uZWNlc3NhcnkuDQo+IA0KDQpTb3JyeSBmb3IgdGhlIHR5cG8uIEkgbWVhbnQgIi4u
LiBpcyBub3QgbmVjZXNzYXJ5LiINCg0KDQo=

