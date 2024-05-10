Return-Path: <linux-wireless+bounces-7404-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3A38C1C50
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 04:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF8C1F2173E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 02:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C9413B5B3;
	Fri, 10 May 2024 02:14:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D854ECF
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 02:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307274; cv=none; b=SAvJGC5WvLzwXHPORJOU00xaNOmLbf50j9ZgRRGifyg1nrf6Rzdy8Ns8YB0d9Pf37Ean0LJEyrZ25vymT7DB+rOGp5kknz6hguIGCdfimYJXPCwTfbLDa9wB+WxR4qn3TI0KupQaUsBMVBVSHUP/xTGhoEdndD+p7Pa94n2kXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307274; c=relaxed/simple;
	bh=pDm2wnjshbIqUQN1gz1slAoTJX7qGInV3DHxyEFA8WM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f9A62aJj8DME2nFOAArnc2Nrvjn3Jp159sIX+SqVm8FqLngSO4Jcoc3sPUmXpIJwwoSJ9T527Kter5ZjUlXLfK4GTkCj4fBw1WRKRt5QAZkRfOytUhCzjI2qNFbCNkBiRRkinntv9c3ytuiLGku8yPO9W2ptQAHyA7Yelbc7+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44A2EDLG02238172, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44A2EDLG02238172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 10:14:13 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 10:14:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 10:14:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 10 May 2024 10:14:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 02/11] wifi: rtlwifi: Add new members to struct rtl_priv for RTL8192DU
Thread-Topic: [PATCH v5 02/11] wifi: rtlwifi: Add new members to struct
 rtl_priv for RTL8192DU
Thread-Index: AQHaoTVE5yHge4Rab0mUReibkjBR47GPt5pA
Date: Fri, 10 May 2024 02:14:13 +0000
Message-ID: <df8786829d2f41149a590ea3912b17d9@realtek.com>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
 <0da95992-c93b-479a-93fb-eeca2cefc8c7@gmail.com>
In-Reply-To: <0da95992-c93b-479a-93fb-eeca2cefc8c7@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBhcmUgbmVlZGVkIGZvciB0aGUgZHVhbCBNQUMgdmVyc2lvbiBvZiBSVEw4MTkyRFUuDQoNClBs
ZWFzZSBleHBsYWluIGEgbGl0dGxlIGJpdCBob3cgeW91IGNhbiBzaGFyZSB0aGUgZGF0YSBiZXR3
ZWVuIHR3bw0KVVNCIGludGYsIGFuZCB3aHkgeW91IG5lZWQgdGhpcy4gDQoNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiAt
LS0NCj4gdjU6DQo+ICAtIFBhdGNoIGlzIG5ldyBpbiB2NS4NCj4gLS0tDQo+ICBkcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvd2lmaS5oIHwgNiArKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvd2lmaS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGx3aWZpL3dpZmkuaA0KPiBpbmRleCA0NDI0MTk1Njg3MzQuLjZhODIxMmZkMzZhZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3dpZmku
aA0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvd2lmaS5oDQo+
IEBAIC0yNzQ2LDYgKzI3NDYsMTIgQEAgc3RydWN0IHJ0bF9wcml2IHsNCj4gICAgICAgICAgKi8N
Cj4gICAgICAgICBib29sIHVzZV9uZXdfdHJ4X2Zsb3c7DQo+IA0KPiArICAgICAgIC8qIEZvciBk
dWFsIE1BQyBSVEw4MTkyRFUsIHRoaW5ncyBzaGFyZWQgYnkgdGhlIDIgVVNCIGludGVyZmFjZXMg
Ki8NCj4gKyAgICAgICB1MzIgKmN1cnZlaW5kZXhfMmc7DQo+ICsgICAgICAgdTMyICpjdXJ2ZWlu
ZGV4XzVnOw0KPiArICAgICAgIHN0cnVjdCBtdXRleCAqbXV0ZXhfZm9yX3Bvd2VyX29uX29mZjsg
LyogZm9yIHBvd2VyIG9uL29mZiAqLw0KPiArICAgICAgIHN0cnVjdCBtdXRleCAqbXV0ZXhfZm9y
X2h3X2luaXQ7IC8qIGZvciBoYXJkd2FyZSBpbml0ICovDQo+ICsNCj4gICNpZmRlZiBDT05GSUdf
UE0NCj4gICAgICAgICBzdHJ1Y3Qgd2lwaHlfd293bGFuX3N1cHBvcnQgd293bGFuOw0KPiAgI2Vu
ZGlmDQo+IC0tDQo+IDIuNDQuMA0KDQo=

