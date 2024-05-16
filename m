Return-Path: <linux-wireless+bounces-7725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7008C6F9F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 02:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6C21F21D6A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E00631;
	Thu, 16 May 2024 00:40:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B5620
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715820022; cv=none; b=qa0kW7nbw7N531/6gwDrXB1EPytr5EZYnW0m4c/tredjJ7nl8hNmZECwUric1tV9KAijyg30QYwf4BTgwaIkJbOnEnX50rInsWiobG1uSDbvshmA9ZFdNYzBxzFwpHxqwNim2NdQseLvjhPIAiDW32EqM1ZWpN6Nc6UNpq/JVUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715820022; c=relaxed/simple;
	bh=xIbMfBJOX5WuOfUTjFKbMCHmc6lCtDIZet7f3Sd1wxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tBRGmWTGwbUGVLvbUuEbnc0bg/WUnp5Cmj/wYcUwMPV3K6COggebF0DpXXroqAFLSIFaUlxPvjXmW1jZ9Y+fx8S7yVMlbQTQTcYmyO3E0hywJ41GydYgF/uc9UtQBPiZ6Ugbjw5wcnIcHkqHHVrcwrKQAchYDn5LoGAankxuWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44G0eASJ1542905, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44G0eASJ1542905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 08:40:10 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 16 May 2024 08:40:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 08:40:10 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 16 May 2024 08:40:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
CC: linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Problem with 8922ae
Thread-Topic: Problem with 8922ae
Thread-Index: AQHapvySFjuIGFw1t0ytdSVFqyYk5rGZA7uA
Date: Thu, 16 May 2024 00:40:09 +0000
Message-ID: <fec7536d76cd469e8fbc375219205d1b@realtek.com>
References: <898f027b-bf08-4f6b-b0c7-623ca5c5f23c@lwfinger.net>
In-Reply-To: <898f027b-bf08-4f6b-b0c7-623ca5c5f23c@lwfinger.net>
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

TGFycnkgRmluZ2VyIDxsYXJyeS5maW5nZXJAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEkgaGF2
ZSBiZWVuIGJ1c3kgd2l0aCB0aGUgODgyMWF1IGRyaXZlciBhbmQgaGFkIG5vdCBkb25lIGFueXRo
aW5nIHdpdGggdGhlDQo+IDg5MjJhZSBkcml2ZXIgaW4gdGhlIG1lYW50aW1lLiBOb3csIEkgYW0g
Z2V0dGluZyBzb21lIHdhcmhpbmdzIGluIHRoZSBsb2dzOg0KPiANCj4gVGhpcyB3YXJuaW5nIGNh
bWUgd2hpbGUgcnVubmluZyBhIGtlcm5lbCBnZW5lcmF0ZWQgZnJvbSBydHctbmV4dCB3aXRoIGNv
bW1pdA0KPiAyODgxOGI0ZDg3MWJjOTMuDQo+IA0KDQpUaGUgbG9nIHNhaWQgU0VSIG9jY3Vycy4g
SSB3aWxsIGNoZWNrIHRoaXMgaW50ZXJuYWxseS4NCg0KUXVlc3Rpb246IEhvdyBmcmVxdWVudCB5
b3UgbWV0IHRoaXMgd2FybmluZz8gYW5kIGlzIHRoZXJlIGEgbWV0aG9kIHlvdSBjYW4NCmFsd2F5
cyByZXByb2R1Y2UgdGhpcyBzeW1wdG9tPw0KDQpQaW5nLUtlDQoNCg0K

