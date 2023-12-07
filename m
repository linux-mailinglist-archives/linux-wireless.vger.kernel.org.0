Return-Path: <linux-wireless+bounces-519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5856807D00
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 01:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6013D282541
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 00:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B4362;
	Thu,  7 Dec 2023 00:18:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EEFAC
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 16:18:04 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B70HrdoE3899459, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B70HrdoE3899459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Dec 2023 08:17:54 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 7 Dec 2023 08:17:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 7 Dec 2023 08:17:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 7 Dec 2023 08:17:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: ZeroBeat <ZeroBeat@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Thread-Topic: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Thread-Index: AQHaKDonMO77xna6akOZJq4x2zvwerCcbxLw
Date: Thu, 7 Dec 2023 00:17:53 +0000
Message-ID: <4cd8742d1dc247fb9a2d315be373c9d0@realtek.com>
References: <5fe2c3dd-5eb8-45df-9717-87808537ff6b@gmx.de>
In-Reply-To: <5fe2c3dd-5eb8-45df-9717-87808537ff6b@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmVyb0JlYXQgPFplcm9C
ZWF0QGdteC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciA2LCAyMDIzIDc6NDggUE0N
Cj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVzLlNvcmVuc2Vu
QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBbUEFUQ0hdIHdpZml3aWZpOiBSZWFsdGVrOiBydGw4eHh4
dSBBZGQgbmV3IGRldmljZSBJRA0KDQpzdWJqZWN0IHByZWZpeCBzaG91bGQgYmUgIndpZmk6IHJ0
bDh4eHh1OiAuLi4iDQoNCj4gDQo+IEZyb206IE1pY2hhZWwgRGllY2ttYW5uIChodHRwczovL2dp
dGh1Yi5jb20vWmVyQmVhKQ0KPiBUbzogbGludXgtd2lyZWxlc3MNCj4gDQo+IFN1YmplY3Q6IFtQ
QVRDSF0gd2lmaTogUmVhbHRlazogcnRsOHh4eHUgQWRkIG5ldyBkZXZpY2UgSUQNCj4gDQo+IFRo
aXMgcGF0Y2ggd2lsbCBhZGQgYSBuZXcgZGV2aWNlIElELg0KPiBQYXRjaCB3aWxsIGNsb3NlOiBo
dHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxODIzMQ0KPiANCj4g
DQo+IFRQLUxpbmsgVEwtV044MjAwTkQoVU4pIHYzLjANCj4gSUQgMjM1NzowMTI2IFRQLUxpbmsg
ODAyLjExbiBOSUMNCj4gaHR0cHM6Ly93d3cudHAtbGluay5jb20vZGUvaG9tZS1uZXR3b3JraW5n
L2FkYXB0ZXIvdGwtd244MjAwbmQvDQo+IFNvbGQgaW4gR2VybWFueS4NCg0KTWlzc2VkIHlvdXIg
c2lnbi1vZi1ieSwgYW5kIHRoaXMgcGF0Y2ggbG9va3MgaXJyZWd1bGFyLiANClBsZWFzZSByZWZl
cmVuY2UgdG8gaHR0cHM6Ly93aXJlbGVzcy53aWtpLmtlcm5lbC5vcmcvZW4vZGV2ZWxvcGVycy9k
b2N1bWVudGF0aW9uL3N1Ym1pdHRpbmdwYXRjaGVzDQoNCj4gDQo+IA0KPiAtLS0gbGludXgvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMub3JpZwky
MDIzLTEyLTA2IDEyOjM4OjUxLjkyOTQ4NDI1Mg0KPiArMDEwMA0KPiArKysgbGludXgvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMJMjAyMy0xMi0w
NiAxMTo1NDoxMi41MjQzMDIyNzYgKzAxMDANCg0KVGhlIGRpcmVjdG9yeSBwYXRoIGlzIGluY29y
cmVjdC4gDQoNCj4gQEAgLTc5NTcsNiArNzk1Nyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNi
X2RldmljZV9pZCBkZXZfdGENCj4gICAvKiBmb3VuZCBpbiBydGw4MTkyZXUgdmVuZG9yIGRyaXZl
ciAqLw0KPiAgIHtVU0JfREVWSUNFX0FORF9JTlRFUkZBQ0VfSU5GTygweDIzNTcsIDB4MDEwNywg
MHhmZiwgMHhmZiwgMHhmZiksDQo+ICAgCS5kcml2ZXJfaW5mbyA9ICh1bnNpZ25lZCBsb25nKSZy
dGw4MTkyZXVfZm9wc30sDQo+ICt7VVNCX0RFVklDRV9BTkRfSU5URVJGQUNFX0lORk8oMHgyMzU3
LCAweDAxMjYsIDB4ZmYsIDB4ZmYsIDB4ZmYpLA0KPiArCS5kcml2ZXJfaW5mbyA9ICh1bnNpZ25l
ZCBsb25nKSZydGw4MTkyZXVfZm9wc30sDQoNClRoZSBpbmRlbnRhdGlvbiBpcyBkaWZmZXJlbnQg
ZnJvbSBvdGhlciBleGlzdGluZyBvbmVzLiANCg0KPiAgIHtVU0JfREVWSUNFX0FORF9JTlRFUkZB
Q0VfSU5GTygweDIwMTksIDB4YWIzMywgMHhmZiwgMHhmZiwgMHhmZiksDQo+ICAgCS5kcml2ZXJf
aW5mbyA9ICh1bnNpZ25lZCBsb25nKSZydGw4MTkyZXVfZm9wc30sDQo+ICAge1VTQl9ERVZJQ0Vf
QU5EX0lOVEVSRkFDRV9JTkZPKFVTQl9WRU5ET1JfSURfUkVBTFRFSywgMHg4MThjLCAweGZmLCAw
eGZmLCAweGZmKSwNCj4gDQo+IA0KPiBUaGFua3MgZm9yIG1haW50YWluaW5nIHRoaXMgZHJpdmVy
Lg0KPiBCZXN0IHJlZ2FyZHMNCj4gTWljaGFlbCBEaWVja21hbm4NCg==

