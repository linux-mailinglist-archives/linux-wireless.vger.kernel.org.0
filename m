Return-Path: <linux-wireless+bounces-29351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8393FC87F3C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 04:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430B73B4D6A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 03:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75BC30E834;
	Wed, 26 Nov 2025 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qOIlFFCj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE1B30E0C3;
	Wed, 26 Nov 2025 03:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127622; cv=none; b=ETStB7mwBHHZ/um6ENoyywQBe5o16noV/yCyCH5DO0hkvOsIuzqiMsBAWiaoQ9lHADKD9eC8iSr5/bntsvNYEIucYfmnn+PVnzF7CNBBzTiHneK/GcXz9AYvKKh8Yvboh9uxhI3+rReaaqmUYkwdD1bKd8ftBHSs+kvmkfd7q9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127622; c=relaxed/simple;
	bh=QvQWNTzAha/pjhXOIsexT1PVcm/R9MAVan25HFoMY7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eUrPpgbYFbyobufETaz84Zu3rNMz77gpPpoanz1CMNoDGQnqE23rzRaVt92SOhhhjYqoRqxvamNFJhjp5zQdUEUKPZGegH/LTpIJgSMJ0W79F1XoeKKh9VVo0DmFMW3LJgZ7gesqZXIg2WQIAEnQ8d+OyLUhL6JJaY1bl/Oq9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qOIlFFCj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AQ3QaMhA107475, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764127596; bh=QvQWNTzAha/pjhXOIsexT1PVcm/R9MAVan25HFoMY7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qOIlFFCjWZGiS8RXDqPig1idzUEoU9U3Fe3hvajmp12Yh+7Js2V74wTOGNgyk6Iz4
	 CIxNj30cleJK94o84d7iQfxrYix7MTMOPlH098J8sSrbDMlpJGp585Ku5BvMQjcoJQ
	 E7UG+0In8+C3Sv2sftBdO5Re4zXuJnMgjgs4bB2Ge0qA9AKDs9YyFe23ib8ahbCWKh
	 0x6xOfFXjxtw5yilf322C1sFas36KQuwklT1ziSpwpKoxuRo3lJP3w7n2nXiIYE+Uk
	 cEs1FNfTNlzyKBy7LeQm/mcXDMoGcMS+z1yKl/Y4UeXJEW7GJm3e7irCUclJU2i8Lu
	 J7cK2lFvwfteg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AQ3QaMhA107475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:26:36 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 26 Nov 2025 11:26:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 26 Nov 2025 11:26:36 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 26 Nov 2025 11:26:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Zenm Chen
	<zenmchen@gmail.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>
CC: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "gustavoars@kernel.org"
	<gustavoars@kernel.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Thread-Topic: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Thread-Index: AQHcWTQWm+ekto8gdkOtuZTX88y/HbT8ZJsAgAADogCAAA5sgIADwJWAgAQc65A=
Date: Wed, 26 Nov 2025 03:26:36 +0000
Message-ID: <c0d187d6fead4e5387db2a14129be96c@realtek.com>
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
 <20251121111132.4435-1-zenmchen@gmail.com>
 <475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
In-Reply-To: <475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
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

SGkgQml0dGVyYmx1ZSwNCg0KQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+IHdyb3RlOg0KPiBPbiAyMS8xMS8yMDI1IDEzOjExLCBaZW5tIENoZW4gd3JvdGU6DQo+ID4g
R3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4g5pa8IDIwMjXlubQx
MeaciDIx5pelIOmAseS6lCDkuIvljYg2OjIw5a+r6YGT77yaDQo+ID4+DQo+ID4+IEhpLA0KPiA+
Pg0KPiA+PiBPbiAxMS8yMS8yNSAxOTowNiwgWmVubSBDaGVuIHdyb3RlOg0KPiA+Pj4gRGVhciBt
YWludGFpbmVycywNCj4gPj4+DQo+ID4+PiBXaXRoIHRoaXMgcGF0Y2ggYXBwbGllZCwgbXkgc3lz
dGVtIGFsd2F5cyBmcmVlemVzIHJpZ2h0IGFmdGVyIHRoZSBydGw4eHh4dQ0KPiA+Pj4gZHJpdmVy
IGlzIGxvYWRlZC4gaXMgaXQgbm9ybWFsPw0KPiA+Pg0KPiA+PiBJIGRvbid0IHRoaW5rIHNvLi4u
IEl0IHByb2JhYmx5IG1lYW5zIHRoYXQgc3RydWN0IHVyYiB1cmI7IGNhbm5vdCByZWFsbHkgYmUN
Cj4gPj4gbW92ZWQgdG8gdGhlIGVuZCBvZiBzdHJ1Y3QgcnRsOHh4eHVfcnhfdXJiIG9yIHN0cnVj
dCBydGw4eHh4dV90eF91cmI/DQo+ID4+DQo+ID4+IEl0J2QgYmUgZ3JlYXQgaWYgeW91IGNvdWxk
IHNoYXJlIGEgbG9nLg0KPiA+Pg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBOb3RoaW5nIGhlbHBm
dWwgZm91bmQgZnJvbSB0aGUga2VybmVsIGxvZy4gTWF5YmUgUmVhbHRlayBkcml2ZXJzIG1haW50
YWluZXINCj4gPiBQaW5nLUtlIGNvdWxkIHRha2UgYSBsb29rIHdoYXQgaXMgd3JvbmcgbmV4dCBN
b25kYXkuDQo+ID4NCj4gWy4uLl0NCj4gDQo+IEkgZ290IHNvbWV0aGluZy4gSW4gbXkgY2FzZSBl
dmVyeXRoaW5nIHNlZW1lZCBmaW5lIHVudGlsIEkgdW5wbHVnZ2VkIHRoZQ0KPiB3aWZpIGFkYXB0
ZXIuIEFuZCB0aGVuIHRoZSBzeXN0ZW0gc3RpbGwgd29ya2VkIGZvciBhIGZldyBtaW51dGVzIGJl
Zm9yZQ0KPiBpdCBmcm96ZS4NCj4gDQoNClplbm0gYW5kIEkgdGVzdGVkIGJlbG93IGNoYW5nZXMg
d2hpY2ggY2FuIGFsc28gcmVwcm9kdWNlIHRoZSBzeW1wdG9tLCBzbw0KSSB3b25kZXIgZHJpdmVy
IG1pZ2h0IGFzc3VtZSB1cmIgaXMgdGhlIGZpcnN0IG1lbWJlciBvZiBzdHJ1Y3QsIGJ1dCANCnVu
Zm9ydHVuYXRlbHkgSSBjYW4ndCBmaW5kIHRoYXQuIENvdWxkIHlvdSBhbHNvIGhlbHAgdG8gcmV2
aWV3IGlmIHNvbWV0aGluZw0KSSBtaXNzZWQ/IFRoYW5rcy4NCg0KDQotLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1LmgNCisrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KQEAgLTE5NDIsMTUgKzE5NDIs
MTkgQEAgc3RydWN0IHJ0bDh4eHh1X3ZpZiB7DQogfTsNCg0KIHN0cnVjdCBydGw4eHh4dV9yeF91
cmIgew0KKyAgICAgICB1OCBwYWRbMTI4XTsNCiAgICAgICAgc3RydWN0IHVyYiB1cmI7DQogICAg
ICAgIHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3Ow0KICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkIGxp
c3Q7DQp9Ow0KDQogc3RydWN0IHJ0bDh4eHh1X3R4X3VyYiB7DQorICAgICAgIHU4IHBhZFsxMjhd
Ow0KICAgICAgICBzdHJ1Y3QgdXJiIHVyYjsNCiAgICAgICAgc3RydWN0IGllZWU4MDIxMV9odyAq
aHc7DQogICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgbGlzdDsNCn07DQoNCiBzdHJ1Y3QgcnRsOHh4
eHVfZmlsZW9wcyB7DQoNCg0K

