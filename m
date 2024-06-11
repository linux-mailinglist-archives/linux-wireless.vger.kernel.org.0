Return-Path: <linux-wireless+bounces-8774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A46902E62
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 04:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885F0B21560
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 02:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C716F835;
	Tue, 11 Jun 2024 02:32:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663516F827
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073154; cv=none; b=GaCsN9bjEDx1AKoUjZU+/6V5XMDaHnzuxY4/FCu42IuBLYvAqh2ympNA9gX8crlEkbgJJavhIHQaFOGUSIDvXZJhds7pV9YCGokQ+ds4ABs49m4/y7yzVfJ7QWE/dMjnhT5WtIqjWk4XVNe5Iv1HaLxC6tPfBuO79pbCs0JTznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073154; c=relaxed/simple;
	bh=kYh0B0zo5YA7zyLiUbDxjhione6Kuk7MTori5Ym/aeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nn91PRm3TLLtSWPY6w0D9nEJYxGbRIdiB1Dbd/D8QcDWIauV4cnTe2eXmR1CGU6o6Pt6FZFAT8n3wfdAehaASzPvfhV6HHOTSX32x8oPS3q4i0Zkk5XNNgyPr+9XrgP2K7W/pO4uTYl+PKJ6Iey6kJSAziXQOOOYF4k/E7ss/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45B2WI2B03661719, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45B2WI2B03661719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 10:32:18 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 10:32:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 11 Jun 2024 10:32:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 11 Jun 2024 10:32:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        =?utf-8?B?TWFyY2luIMWabHVzYXJ6?=
	<mslusarz@renau.com>
Subject: RE: rtw88 multicast failure in AP mode
Thread-Topic: rtw88 multicast failure in AP mode
Thread-Index: AQHauOwsgeUJhnLB0Eaji1GrCgk797HB3Ewg
Date: Tue, 11 Jun 2024 02:32:18 +0000
Message-ID: <868343c920c24204972ddaa108e5d00e@realtek.com>
References: <CA+GA0_t7RPsqQ2XztOtRyW3BVZfE54h+Rg+fxRNPL8qwQWKeDw@mail.gmail.com>
In-Reply-To: <CA+GA0_t7RPsqQ2XztOtRyW3BVZfE54h+Rg+fxRNPL8qwQWKeDw@mail.gmail.com>
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

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOg0KPiBMZXQn
cyBhc3N1bWUgd2UgaGF2ZSAzIHN5c3RlbXM6IEEgYW5kIEIgdXNlIDg4MjFDVSBjaGlwLCBhbmQg
QyB1c2VzDQo+IGFub3RoZXIgY2hpcCBmcm9tIGEgZGlmZmVyZW50IHZlbmRvci4NCj4gDQo+IElm
IEEgaXMgaW4gQVAgbW9kZSBhbmQgQSBhbmQgQiB1c2UgdGhlIHJ0dzg4IGRyaXZlciwgcGluZ2lu
ZyBBIGZyb20gQg0KPiBhbmQgQyBieSBsb2NhbCBuYW1lIGRvZXNuJ3Qgd29yayBiZWNhdXNlIG5h
bWUgcmVzb2x1dGlvbiBmYWlsczogYXZhaGkNCj4gb24gQiBhbmQgQyBzZW5kcyBhIG11bHRpY2Fz
dCByZXF1ZXN0IHRvIHJlc29sdmUgQS5sb2NhbCwgQSBzZWVzIGl0IGFuZA0KPiByZXNwb25kcywg
YnV0IG5laXRoZXIgQiBub3IgQyBzZWVzIHRoZSByZXNwb25zZS4NCj4gDQo+IEluIHRoZSBzYW1l
IHNpdHVhdGlvbiwgYnV0IHdpdGggQSBhbmQgQiB1c2luZyB0aGUgcnRsODgyMWN1IGRyaXZlcg0K
PiAoZnJvbSBodHRwczovL2dpdGh1Yi5jb20vbW9ycm93bnIvODgyMWN1LTIwMjEwOTE2LmdpdCks
IGV2ZXJ5dGhpbmcNCj4gd29ya3MgLSBCIGFuZCBDIHNlZSBBJ3MgcmVzcG9uc2UgYW5kIGNhbiBy
ZXNvbHZlIEEubG9jYWwuDQo+IA0KPiBJZiBDIGlzIGluIEFQIG1vZGUsIHJlc29sdmluZyBDIGZy
b20gQSBhbmQgQiBhbHNvIHdvcmtzLg0KPiANCj4gVGhpcyBsZWFkcyBtZSB0byBiZWxpZXZlIHRo
ZXJlJ3Mgc29tZXRoaW5nIHdyb25nIHdpdGggcnR3ODggd2hlbg0KPiBzZW5kaW5nIG11bHRpY2Fz
dCBwYWNrZXRzIGluIEFQIG1vZGUuDQoNCkhhdmUgeW91IGNhcHR1cmVkIGFpciBwYWNrZXRzIHNl
bnQgYnkgQyAoQVAgbW9kZSk/IChUbyBjaGVjayBpZiBUWCBwcm9wZXJseS4pDQoNCkhhdmUgeW91
IHRyaWVkIG5vbi1zZWN1cmUgY29ubmVjdGlvbj8gKFRvIGNoZWNrIGlmIGVuY3J5cHRpb24gcHJv
cGVybHkuKQ0KDQpJIHRoaW5rIHRoaXMgY2FuIGhlbHAgdG8gYWRkcmVzcyBwcm9ibGVtLiANCg0K

