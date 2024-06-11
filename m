Return-Path: <linux-wireless+bounces-8778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7B1902F1A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 05:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00C9B209A3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 03:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38A16F83D;
	Tue, 11 Jun 2024 03:26:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A700FBA42
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718076395; cv=none; b=U4ZP3yHL94LvWCA2xinTjiycpQb9ktttJIdkcC7tyrZ7b8SHLeYKvohODqTwLvhz8WiHngMlPc/nZqYtqroxvHcEKscrbpPQ0ER+jViopgnozltKrrn6M0gp1puvTAwW2bjeL89wP20jB1nKSXyLkpFAKZjca8qf8YQue7ETv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718076395; c=relaxed/simple;
	bh=om+iEBiZ0IuA1VQ/oV/scGcVZ8PKPcT5JQuC9K+Zy1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s6I+9uHmLXhrjndaRqrubkNTNXyEchb5ljRWrY5s1Z0cjXilpeTtfwqyLTiPhXPxCJdJTI/7uQkBD72oLSCrIgGUFatjRP6sC7nM16qrDxNE6I1IwZ/jHMPhS359isHB6AgcnjbGwexQrDTGnALoTpaRhi3n0ayBAqE47P7Y9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45B3QE1203707788, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45B3QE1203707788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 11:26:14 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 11:26:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 11 Jun 2024 11:26:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 11 Jun 2024 11:26:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2] wifi: rtw88: usb: Further limit the TX aggregation
Thread-Topic: [PATCH v2] wifi: rtw88: usb: Further limit the TX aggregation
Thread-Index: AQHau1tuF6gqmbOASk++gzi0NXdTVrHB5AWg
Date: Tue, 11 Jun 2024 03:26:14 +0000
Message-ID: <3fedc4d56ac3414e8e500961b9850aa1@realtek.com>
References: <0996d2d0-e7b8-4e43-ba12-63074ba9df1b@gmail.com>
 <dfb019b6-4285-4381-86d2-d85409abee4b@gmail.com>
In-Reply-To: <dfb019b6-4285-4381-86d2-d85409abee4b@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBAQCAt
MjA2NSwyNSArMjA2NiwyNiBAQCBjb25zdCBzdHJ1Y3QgcnR3X2NoaXBfaW5mbyBydHc4NzAzYl9o
d19zcGVjID0gew0KPiAgICAgICAgIC5idF9yc3NpX3R5cGUgPSBDT0VYX0JUUlNTSV9SQVRJTywN
Cj4gICAgICAgICAuYW50X2lzb2xhdGlvbiA9IDE1LA0KPiAgICAgICAgIC5yc3NpX3RvbGVyYW5j
ZSA9IDIsDQo+IC0gICAgICAgLmJ0X3Jzc2lfc3RlcCA9IGJ0X3Jzc2lfc3RlcF84NzAzYiwNCj4g
LSAgICAgICAud2xfcnNzaV9zdGVwID0gd2xfcnNzaV9zdGVwXzg3MDNiLA0KPiAgICAgICAgIC8q
IHNhbnQgLT4gc2hhcmVkIGFudGVubmEsIG5zYW50IC0+IG5vbi1zaGFyZWQgYW50ZW5uYQ0KPiAg
ICAgICAgICAqIE5vdCBzdXJlIGlmIDg3MDNiIHZlcnNpb25zIHdpdGggbm9uLXNoYXJkIGFudGVu
bmEgZXZlbiBleGlzdC4NCj4gICAgICAgICAgKi8NCj4gICAgICAgICAudGFibGVfc2FudF9udW0g
PSBBUlJBWV9TSVpFKHRhYmxlX3NhbnRfODcwM2IpLA0KPiAtICAgICAgIC50YWJsZV9zYW50ID0g
dGFibGVfc2FudF84NzAzYiwNCg0KTm90IHN1cmUgd2h5IHlvdSBtb3ZlIGFycmF5IGFuZCBhcnJh
eSBzaXplIGFwYXJ0LiANCk5vIG5lZWQgdG8gY2h1cm4gdGhpcyBhcyB3ZWxsIGFzIG90aGVyIHNp
bWlsYXIgc3R1ZmZzLiANCg0KVGhpcyBwYXRjaCBjYW4gb25seSBjaGFuZ2UgdGhpbmdzIHJlcXVp
cmVkIGJ5IHdoYXQgc3ViamVjdCBtZW50aW9uLiBBbGlnbiB0aGVzZQ0KZmllbGRzIGJ5IGFub3Ro
ZXIgcGF0Y2gsIG9yIGRvIGl0IGxhdGVyLiBCb3RoIGFyZSBmaW5lIHRvIG1lLiANCg0KPiAgICAg
ICAgIC50YWJsZV9uc2FudF9udW0gPSAwLA0KPiAtICAgICAgIC50YWJsZV9uc2FudCA9IE5VTEws
DQo+ICAgICAgICAgLnRkbWFfc2FudF9udW0gPSBBUlJBWV9TSVpFKHRkbWFfc2FudF84NzAzYiks
DQo+IC0gICAgICAgLnRkbWFfc2FudCA9IHRkbWFfc2FudF84NzAzYiwNCj4gICAgICAgICAudGRt
YV9uc2FudF9udW0gPSAwLA0KPiAtICAgICAgIC50ZG1hX25zYW50ID0gTlVMTCwNCj4gLSAgICAg
ICAud2xfcmZfcGFyYV9udW0gPSBBUlJBWV9TSVpFKHJmX3BhcmFfdHhfODcwM2IpLA0KPiAtICAg
ICAgIC53bF9yZl9wYXJhX3R4ID0gcmZfcGFyYV90eF84NzAzYiwNCj4gLSAgICAgICAud2xfcmZf
cGFyYV9yeCA9IHJmX3BhcmFfcnhfODcwM2IsDQo+ICAgICAgICAgLmJ0X2FmaF9zcGFuX2J3MjAg
PSAweDIwLA0KPiAgICAgICAgIC5idF9hZmhfc3Bhbl9idzQwID0gMHgzMCwNCj4gICAgICAgICAu
YWZoXzVnX251bSA9IEFSUkFZX1NJWkUoYWZoXzVnXzg3MDNiKSwNCj4gKyAgICAgICAud2xfcmZf
cGFyYV9udW0gPSBBUlJBWV9TSVpFKHJmX3BhcmFfdHhfODcwM2IpLA0KPiArICAgICAgIC5jb2V4
X2luZm9faHdfcmVnc19udW0gPSAwLA0KPiArICAgICAgIC5idF9yc3NpX3N0ZXAgPSBidF9yc3Np
X3N0ZXBfODcwM2IsDQo+ICsgICAgICAgLndsX3Jzc2lfc3RlcCA9IHdsX3Jzc2lfc3RlcF84NzAz
YiwNCj4gKyAgICAgICAudGFibGVfbnNhbnQgPSBOVUxMLA0KPiArICAgICAgIC50YWJsZV9zYW50
ID0gdGFibGVfc2FudF84NzAzYiwNCj4gKyAgICAgICAudGRtYV9zYW50ID0gdGRtYV9zYW50Xzg3
MDNiLA0KPiArICAgICAgIC50ZG1hX25zYW50ID0gTlVMTCwNCj4gKyAgICAgICAud2xfcmZfcGFy
YV90eCA9IHJmX3BhcmFfdHhfODcwM2IsDQo+ICsgICAgICAgLndsX3JmX3BhcmFfcnggPSByZl9w
YXJhX3J4Xzg3MDNiLA0KPiAgICAgICAgIC5hZmhfNWcgPSBhZmhfNWdfODcwM2IsDQo+ICAgICAg
ICAgLyogUkVHX0JUR19TRUwgZG9lc24ndCBzZWVtIHRvIGhhdmUgYSBjb3VudGVycGFydCBpbiB0
aGUNCj4gICAgICAgICAgKiB2ZW5kb3IgZHJpdmVyLiBNYXRoZW1hdGljYWxseSBpdCdzIFJFR19Q
QURfQ1RSTDEgKyAzLg0KPiBAQCAtMjA5Niw3ICsyMDk4LDYgQEAgY29uc3Qgc3RydWN0IHJ0d19j
aGlwX2luZm8gcnR3ODcwM2JfaHdfc3BlYyA9IHsNCj4gICAgICAgICAvKiBUaGVzZSByZWdpc3Rl
cnMgYXJlIHVzZWQgdG8gcmVhZCAoYW5kIHByaW50KSBmcm9tIGlmDQo+ICAgICAgICAgICogQ09O
RklHX1JUVzg4X0RFQlVHRlMgaXMgZW5hYmxlZC4NCj4gICAgICAgICAgKi8NCj4gLSAgICAgICAu
Y29leF9pbmZvX2h3X3JlZ3NfbnVtID0gMCwNCj4gICAgICAgICAuY29leF9pbmZvX2h3X3JlZ3Mg
PSBOVUxMLA0KPiAgfTsNCj4gIEVYUE9SVF9TWU1CT0wocnR3ODcwM2JfaHdfc3BlYyk7DQoNCg0K
DQo=

