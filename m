Return-Path: <linux-wireless+bounces-24811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 692E2AF873B
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 07:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FF71C47DE8
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 05:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32E1CD15;
	Fri,  4 Jul 2025 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="tdelMWZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1111CA9
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 05:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751607045; cv=none; b=ldLW71eP0m6j9sSCeMavX7sLgFFamf2/swy6RrB2DcB0Hhzu0TZ5MZpw7YqZNM2onk44SQ8/ARiJQpH7dII0CHbPvS4fOEV75d5JsPi+OFjUcynIOJF5GGZ3U6NpAEHN5YgogxqqbfYloH3sK7DOL9gueh05eBqAXkyC+C9R4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751607045; c=relaxed/simple;
	bh=7dji/Ee1+qHLVlz3i+f5q4B1BjBBpC/Tl2+dfZyqyqU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7Nyfs84w2d5IkOb0+hBfBEFoUSD1zZ/ygKi+oPOkOqioY5uF2IG5jeMidD8NoTT/kJ7IfnELYcmduAE7Nvc1dttj98pTEp8EbwJadc+g/H892/S+yXLFRuaBqqpRPjBP/6+rLWd1iUN2YCVYiQtzRCv7tS/6V1+Mfv/3R4OuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tdelMWZP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5645UdPS23796695, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751607039; bh=7dji/Ee1+qHLVlz3i+f5q4B1BjBBpC/Tl2+dfZyqyqU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tdelMWZP1rsMT1m5WNKnOUl4SHdYq5tWrsFIry38h4vQ72CL21ZDvcbsOJxT54NoY
	 fgdbf+K/MumtXAuH4kQmf9mLwmYhKCHwnhROK3MT5mvXDApmoLK81sT/A/6titokwa
	 LowpPEV4dx3x/aYGBHVx8D9ceQEg4coOIdvWkScQGG3wfdn/4zNWMshNlLFn+Qpy2q
	 51cE8ippambpHVP759elSOCFVy9RofrLM7DFrZAm7TObv135hPN1gspoO59IwqoqNm
	 JeB/XYVhtpe8cA1HxJe4lXtt4CflPa8lp4PDt9hg08lv3ikuEXBJlrhNnsnrIGbbmE
	 yZ+bne6FJcMNg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5645UdPS23796695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 13:30:39 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Jul 2025 13:31:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 4 Jul 2025 13:31:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 4 Jul 2025 13:31:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 3/6] wifi: rtw89: 8852b: Add rtw8852b_dle_mem_usb3
Thread-Topic: [PATCH rtw-next 3/6] wifi: rtw89: 8852b: Add
 rtw8852b_dle_mem_usb3
Thread-Index: AQHb6qHDZjINzE4qSE+OsjP+ZEOOY7QhdFFw
Date: Fri, 4 Jul 2025 05:31:03 +0000
Message-ID: <f279e4024b984426800b4960148cbf92@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
 <a849b808-a998-4f31-95ed-263a3ddd9d5c@gmail.com>
In-Reply-To: <a849b808-a998-4f31-95ed-263a3ddd9d5c@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiAiZGxl
IiBjb3VsZCBiZSAiRGF0YSBMaW5rIEVuZ2luZSIgb3IgIkRvdWJsZSBMaW5rIEVuZ2luZSIuIFRo
ZXNlIGFyZQ0KPiBzb21lIHBhcmFtZXRlcnMgbmVlZGVkIGZvciBSVEw4ODUyQlUuDQo+IA0KPiBJ
biB0aGlzIGNhc2UgdGhlIHNhbWUgcGFyYW1ldGVycyBhcmUgdXNlZCBmb3IgVVNCIDIgYW5kIFVT
QiAzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCg0KDQoNCg==

