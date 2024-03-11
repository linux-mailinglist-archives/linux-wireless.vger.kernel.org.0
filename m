Return-Path: <linux-wireless+bounces-4530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD443877A60
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 05:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D84280E07
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 04:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E99C1C3D;
	Mon, 11 Mar 2024 04:28:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47009187F;
	Mon, 11 Mar 2024 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131300; cv=none; b=NE5tlW2jAgHT5Ss4fZfy453X6DF05kfJHXT9v6zuEC9PeO6cXOBHDZEEVTcKSllHyBtoK/DacxC73HMiaa54j/aBBt+OqyECTgcOLYJhGVt34rr/fvHZQHlU7GR7oc36AvzAM5ezJaTCietgBYzAmz8gkTUfJrjo8CUN5tMI9gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131300; c=relaxed/simple;
	bh=80GhhKQ6Y5uP8Hh+7+oaKNqwqUYJ15XVi2nPo2ur6d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EEA9vVyA9ncYheT4K5aBKG0mpkaGbzrtYxfLS4v6Jc0UNmEqX2gnrQzssrAVZpqYJNMwawDrsEjMJTHEtqHptZKvMf2rct/NJTRsU+wbfO7FoBLuc7Jn2gCunbpg2VXXAVgWnUd51+RjO3n3mIwJDZIEzlZFqxXZSsVh//8ei4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42B4RqqU63382925, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42B4RqqU63382925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 12:27:52 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 12:27:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 12:27:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 11 Mar 2024 12:27:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?utf-8?B?T25kxZllaiBKaXJtYW4=?= <megi@xff.cz>
Subject: RE: [PATCH v3 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Topic: [PATCH v3 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Index: AQHachj48zDFhFt5T0W659zLqkqlIbEx649Q
Date: Mon, 11 Mar 2024 04:27:51 +0000
Message-ID: <f77fa5db0b3b4145878bf47f9ba11c8b@realtek.com>
References: <20240309115650.367204-1-fiona.klute@gmx.de>
In-Reply-To: <20240309115650.367204-1-fiona.klute@gmx.de>
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

DQo+IA0KPiB2MyBoYXMgb25seSBtaW5vciBjaGFuZ2VzIHJlcXVlc3RlZCBpbiByZXZpZXcsIHNv
IEkgaG9wZSBpdCdzIGdvb2QgdG8NCj4gbWVyZ2Ugbm93Og0KPiAgICogcnR3ODcwM2IuaDogI2lu
Y2x1ZGUgcnR3ODcyM3guaCBpbnN0ZWFkIG9mIGxpbnV4L3R5cGVzLmggYW5kDQo+ICAgICBsaW51
eC9jb21waWxlcl9hdHRyaWJ1dGVzLmgNCj4gICAqIHJ0dzg3MDNiX3RhYmxlcy5jOiAjaW5jbHVk
ZSBydHc4NzAzYl90YWJsZXMuaA0KPiAgICogcnR3ODcwM2IuYzogZGVmaW5lIFRSQU5TX1NFUV9F
TkQgd2l0aG91dCBicmFjZXMgKGNoZWNrcGF0Y2gucGwNCj4gICAgIGRvZXNuJ3QgbGlrZSB0aGlz
LCBidXQgSSBhc3N1bWUgbWFpbnRhaW5lciByZXF1ZXN0IG92ZXJyaWRlcyBpdCkNCg0KdjMgaXMg
YWxtb3N0IGZpbmUgdG8gbWUuIE9ubHkgb25lIG1pbm9yIGNvbW1lbnQgb24gcGF0Y2ggNS85LiAN
ClBsZWFzZSBzZW5kIHY0IHRvIHJldmlzZSBpdC4gDQoNCkkgYWxzbyBoYXZlIHJ1biBzcGFyc2Ug
YW5kIHNtYXRjaCB3aXRoIHRoaXMgcGF0Y2hzZXQsIG5vIGVycm9yL3dhcm5pbmcuIA0KDQpQaW5n
LUtlIA0KDQo=

