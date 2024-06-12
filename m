Return-Path: <linux-wireless+bounces-8824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD6904861
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 03:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579321F23D8C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 01:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA540EA4;
	Wed, 12 Jun 2024 01:25:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E0391
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155515; cv=none; b=mi/1aaf31toqY/Jt0vZEdQAFSML0u+L4mj0nsqSjKEWwRYaLdS1uH7osRd8RRwCsScPx6t/FBnEkl3BnmhyhJCrK636ZJ87vd58sxq4GHCpEfhUqRpMZF63hMlpWF4prymYxKvrPNzUwz6IXXn1Mo3rNeaRuaFomgJymd+8P7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155515; c=relaxed/simple;
	bh=zD4kMaawm9vy5kxCxaJDtqvJmMoX4Pq5IwKXp0r6yYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AeMzPK3w5rjQ7in1WReubcuSqbk7fjRKqOktK0IyCyQ4MDp0YLd7cdkgXDiZqXVed+0hSsKMlCgkiK1L0OT+iiHWm1FXb6eWeyXG6wmYLxTEpw0gDPSf7djY3Cqarnryzkk7A7f5RMzCtnOTpwQNIBb+4ctUrPJznJRpPyT4A5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45C1OwaU6665257, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45C1OwaU6665257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 09:24:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 09:24:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Jun 2024 09:24:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 12 Jun 2024 09:24:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2] wifi: rtw88: usb: Further limit the TX aggregation
Thread-Topic: [PATCH v2] wifi: rtw88: usb: Further limit the TX aggregation
Thread-Index: AQHau1tuF6gqmbOASk++gzi0NXdTVrHB5AWggAAm/4CAAUVhAA==
Date: Wed, 12 Jun 2024 01:24:58 +0000
Message-ID: <3c9e8312338b47f2a74fd58bf73528fe@realtek.com>
References: <0996d2d0-e7b8-4e43-ba12-63074ba9df1b@gmail.com>
 <dfb019b6-4285-4381-86d2-d85409abee4b@gmail.com>
 <3fedc4d56ac3414e8e500961b9850aa1@realtek.com>
 <6ea2dd8b-fe9e-4434-b502-5badfe547c1f@gmail.com>
In-Reply-To: <6ea2dd8b-fe9e-4434-b502-5badfe547c1f@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
MS8wNi8yMDI0IDA2OjI2LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBAQCAtMjA2NSwyNSArMjA2
NiwyNiBAQCBjb25zdCBzdHJ1Y3QgcnR3X2NoaXBfaW5mbyBydHc4NzAzYl9od19zcGVjID0gew0K
PiA+PiAgICAgICAgIC5idF9yc3NpX3R5cGUgPSBDT0VYX0JUUlNTSV9SQVRJTywNCj4gPj4gICAg
ICAgICAuYW50X2lzb2xhdGlvbiA9IDE1LA0KPiA+PiAgICAgICAgIC5yc3NpX3RvbGVyYW5jZSA9
IDIsDQo+ID4+IC0gICAgICAgLmJ0X3Jzc2lfc3RlcCA9IGJ0X3Jzc2lfc3RlcF84NzAzYiwNCj4g
Pj4gLSAgICAgICAud2xfcnNzaV9zdGVwID0gd2xfcnNzaV9zdGVwXzg3MDNiLA0KPiA+PiAgICAg
ICAgIC8qIHNhbnQgLT4gc2hhcmVkIGFudGVubmEsIG5zYW50IC0+IG5vbi1zaGFyZWQgYW50ZW5u
YQ0KPiA+PiAgICAgICAgICAqIE5vdCBzdXJlIGlmIDg3MDNiIHZlcnNpb25zIHdpdGggbm9uLXNo
YXJkIGFudGVubmEgZXZlbiBleGlzdC4NCj4gPj4gICAgICAgICAgKi8NCj4gPj4gICAgICAgICAu
dGFibGVfc2FudF9udW0gPSBBUlJBWV9TSVpFKHRhYmxlX3NhbnRfODcwM2IpLA0KPiA+PiAtICAg
ICAgIC50YWJsZV9zYW50ID0gdGFibGVfc2FudF84NzAzYiwNCj4gPg0KPiA+IE5vdCBzdXJlIHdo
eSB5b3UgbW92ZSBhcnJheSBhbmQgYXJyYXkgc2l6ZSBhcGFydC4NCj4gPiBObyBuZWVkIHRvIGNo
dXJuIHRoaXMgYXMgd2VsbCBhcyBvdGhlciBzaW1pbGFyIHN0dWZmcy4NCj4gPg0KPiANCj4gSSB0
aG91Z2h0IHlvdSB3YW50ZWQgdGhlIG1lbWJlcnMgaW5pdGlhbGlzZWQgaW4gdGhlIHNhbWUgb3Jk
ZXINCj4gdGhleSBhcHBlYXIgaW4gc3RydWN0IHJ0d19jaGlwX2luZm8gaW4gbWFpbi5oLiBNYXli
ZSBJIG1pc3VuZGVyc3Rvb2QuDQoNCk15IGJhZCwgeW91IGRpZG4ndCBtaXN1bmRlcnN0YW5kLiBJ
IGRpZG4ndCBsb29rIGludG8gZGVmaW5pdGlvbiBvZg0Kc3RydWN0IHJ0d19jaGlwX2luZm8sIHdo
aWNoIHB1dCB0aGUgc2FtZSBkYXRhIHR5cGUgdG9nZXRoZXIgdG8gc2F2ZSBzb21lIHNwYWNlDQpi
ZWNhdXNlIGNvbXBpbGVyIGNhbiBhbGlnbiBmaWVsZHM6DQoNCgl1OCB0YWJsZV9zYW50X251bTsN
Cgl1OCB0YWJsZV9uc2FudF9udW07DQoJdTggdGRtYV9zYW50X251bTsNCgl1OCB0ZG1hX25zYW50
X251bTsNCgl1OCBhZmhfNWdfbnVtOw0KCXU4IHdsX3JmX3BhcmFfbnVtOw0KCXU4IGNvZXhfaW5m
b19od19yZWdzX251bTsNCgljb25zdCB1OCAqYnRfcnNzaV9zdGVwOw0KCWNvbnN0IHU4ICp3bF9y
c3NpX3N0ZXA7DQoJY29uc3Qgc3RydWN0IGNvZXhfdGFibGVfcGFyYSAqdGFibGVfbnNhbnQ7DQoJ
Y29uc3Qgc3RydWN0IGNvZXhfdGFibGVfcGFyYSAqdGFibGVfc2FudDsNCgljb25zdCBzdHJ1Y3Qg
Y29leF90ZG1hX3BhcmEgKnRkbWFfc2FudDsNCgljb25zdCBzdHJ1Y3QgY29leF90ZG1hX3BhcmEg
KnRkbWFfbnNhbnQ7DQoJY29uc3Qgc3RydWN0IGNvZXhfcmZfcGFyYSAqd2xfcmZfcGFyYV90eDsN
Cgljb25zdCBzdHJ1Y3QgY29leF9yZl9wYXJhICp3bF9yZl9wYXJhX3J4Ow0KCWNvbnN0IHN0cnVj
dCBjb2V4XzVnX2FmaF9tYXAgKmFmaF81ZzsNCgljb25zdCBzdHJ1Y3QgcnR3X2h3X3JlZyAqYnRn
X3JlZzsNCgljb25zdCBzdHJ1Y3QgcnR3X3JlZ19kb21haW4gKmNvZXhfaW5mb19od19yZWdzOw0K
DQpCdXQgaW4gdGhpcyB0YWJsZSBJIHdvdWxkIGxpa2UgdG8gdHJlYXQgdGhlc2UgYXMgZXhjZXB0
aW9ucyBwdXR0aW5nIHRoZW0gdG9nZXRoZXIsDQpiZWNhdXNlIGVhY2ggb2YgdGhlbSBhcmUgcmVs
YXRlZC4NCgkudGFibGVfc2FudF9udW0gPSBBUlJBWV9TSVpFKHRhYmxlX3NhbnRfODcwM2IpLA0K
CS50YWJsZV9zYW50ID0gdGFibGVfc2FudF84NzAzYiwNCg0KT3IgaWYgbWVtYmVycyBvZiBCVC1j
b2V4aXN0ZW5jZSBwYXJ0IGluIHRhYmxlcyBhY3Jvc3MgY2hpcHMgYXJlIGluIHRoZSBzYW1lIG9y
ZGVyLA0KanVzdCBrZWVwIGl0IGFzIGl0IHdhcy4NCg0KV2hhdCBkbyB5b3UgdGhpbms/DQoNCj4g
DQo+ID4gVGhpcyBwYXRjaCBjYW4gb25seSBjaGFuZ2UgdGhpbmdzIHJlcXVpcmVkIGJ5IHdoYXQg
c3ViamVjdCBtZW50aW9uLiBBbGlnbiB0aGVzZQ0KPiA+IGZpZWxkcyBieSBhbm90aGVyIHBhdGNo
LCBvciBkbyBpdCBsYXRlci4gQm90aCBhcmUgZmluZSB0byBtZS4NCj4gPg0KPiANCj4gQWgsIGl0
IHNob3VsZCBiZSBkb25lIGluIGEgZGlmZmVyZW50IHBhdGNoLCBva2F5Lg0KDQpZZXMuIE9uZSBw
YXRjaCBpcyBsaWtlIHYxLCBhbmQgdGhlIG90aGVyIG9uZSBqdXN0IGNoYW5nZXMgdGhlIG9yZGVy
LCBubyBsb2dpYyBjaGFuZ2UuDQoNCg0KDQo=

