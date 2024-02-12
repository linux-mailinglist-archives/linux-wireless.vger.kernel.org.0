Return-Path: <linux-wireless+bounces-3452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2B8513CF
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 13:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CB21C2173E
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372FB39FEF;
	Mon, 12 Feb 2024 12:50:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7E39FEE
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742225; cv=none; b=rs0sMKHnv/3zB1Qq7LY/Bx+pFUT7w2Tg8kdumHtowVLsdAIpWnbEnRLduUlIub38M4Gz9SKiohEM6Fj0vkAtY3ckFc34kccEqua9tHhCTbnIMjiaFaRG7HDa4N1NH445Pwzo7MBZcn5Ia0roCS1sjMcw6iMOeZniI4We36dqnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742225; c=relaxed/simple;
	bh=CsUmTbB56pKx4Fug5XESUkB1FZHZxjHgp9X7JFirNZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jkmxlHSArDRAEWkPcH16tt/Er9Of7Xye5IA87eIAlZ/KUGMi804/rW6mwiMUiJV84uSEc12rGka8jLghmaVro5doAbSLOz/3FAWz6gkP5pSmrcyWAt8tOG4a7FGfGtsC46YsG3piptpVt/P7Pt21Uqf7w2S7AFml5VxCpVeiXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41CCo57811384634, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41CCo57811384634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 20:50:05 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 12 Feb 2024 20:50:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 20:50:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 12 Feb 2024 20:50:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192cu: Fix TX aggregation
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192cu: Fix TX aggregation
Thread-Index: AQHaWsipl4rptCy500W5BwIBLsgXbrEGKCeA
Date: Mon, 12 Feb 2024 12:50:05 +0000
Message-ID: <cd687092be44f7fe596f20aa7305c0e4618437ab.camel@realtek.com>
References: <651dae37-1911-4dcd-870b-4b60f759ca82@gmail.com>
In-Reply-To: <651dae37-1911-4dcd-870b-4b60f759ca82@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D3F8AF63B4EA54B8BAD320016B39275@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTAyLTA4IGF0IDIxOjU0ICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gcnRsODE5MmN1IGlzIGNoZWNraW5nIHJ0bF9tYWMudGlkcyB3aGVuIGRlY2lkaW5n
IGlmIGl0IHNob3VsZCBlbmFibGUNCj4gYWdncmVnYXRpb24uIFRoaXMgaXMgd3JvbmcgYmVjYXVz
ZSBydGxfbWFjLnRpZHMgaXMgbm90IGluaXRpYWxpc2VkDQo+IGFueXdoZXJlLiBDaGVjayBydGxf
c3RhX2luZm8udGlkcyBpbnN0ZWFkLCB3aGljaCBpcyBpbml0aWFsaXNlZC4NCj4gDQo+IEFsc28s
IHdoZW4gZW5hYmxpbmcgYWdncmVnYXRpb24gYWxzbyBlbmFibGUgUlRTLiBUaGUgdmVuZG9yIGRy
aXZlciBkb2VzDQo+IHRoaXMsIG15IHJvdXRlciBkb2VzIHRoaXMuIEl0IHNlZW1zIGxpa2UgdGhl
IHRoaW5nIHRvIGRvLg0KPiANCj4gQWxzbyBhbHNvLCBpdCBzZWVtcyByaWdodCB0byBzZXQgdGhl
IEFNUERVIGRlbnNpdHkgb25seSB3aGVuIGVuYWJsaW5nDQo+IGFnZ3JlZ2F0aW9uLg0KPiANCj4g
QWxzbyBhbHNvIGFsc28sIGRlbGV0ZSB0aGUgdW51c2VkIG1lbWJlciBydGxfbWFjLnRpZHMgYW5k
IHRoZSB1bnVzZWQNCj4gbWFjcm9zIFJUTF9BR0dfT04gYW5kIFJUTF9BR0dfT0ZGLg0KPiANCj4g
TmF0dXJhbGx5LCB3aXRoIHdvcmtpbmcgQU1QRFUgdGhlIGRvd25sb2FkL3VwbG9hZCBzcGVlZHMg
YXJlIGJldHRlci4NCj4gQmVmb3JlOiA1OS8zMiBNYnBzLg0KPiBBZnRlcjogIDY4LzQ2IE1icHMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdt
YWlsLmNvbT4NCj4gLS0tDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJj
dS90cnguYyAgfCAyNyArKysrKysrKysrLS0tLS0tLS0tDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRl
ay9ydGx3aWZpL3J0bDgxOTJjdS90cnguaCAgfCAgMiAtLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGx3aWZpL3dpZmkuaCAgIHwgIDMgLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTkyY3UvdHJ4LmMNCj4gYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmN1L3RyeC5jDQo+IGlu
ZGV4IGU1YzgxYzFjNjNjMC4uY2JiZDFkYWI4YWYwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmN1L3RyeC5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTkyY3UvdHJ4LmMNCj4gQEAgLTQ3
NSw4ICs0NzUsOSBAQCB2b2lkIHJ0bDkyY3VfdHhfZmlsbF9kZXNjKHN0cnVjdCBpZWVlODAyMTFf
aHcgKmh3LA0KPiAgICAgICAgIHN0cnVjdCBydGxfcHJpdiAqcnRscHJpdiA9IHJ0bF9wcml2KGh3
KTsNCj4gICAgICAgICBzdHJ1Y3QgcnRsX21hYyAqbWFjID0gcnRsX21hYyhydGxfcHJpdihodykp
Ow0KPiAgICAgICAgIHN0cnVjdCBydGxfcHNfY3RsICpwcHNjID0gcnRsX3BzYyhydGxfcHJpdiho
dykpOw0KPiAtICAgICAgIHU4ICpxYyA9IGllZWU4MDIxMV9nZXRfcW9zX2N0bChoZHIpOw0KPiAt
ICAgICAgIHU4IHRpZCA9IHFjWzBdICYgSUVFRTgwMjExX1FPU19DVExfVElEX01BU0s7DQo+ICsg
ICAgICAgc3RydWN0IHJ0bF9zdGFfaW5mbyAqc3RhX2VudHJ5Ow0KPiArICAgICAgIHU4IGFnZ19z
dGF0ZSA9IFJUTF9BR0dfU1RPUDsNCj4gKyAgICAgICB1OCBhbXBkdV9kZW5zaXR5ID0gMDsNCj4g
ICAgICAgICB1MTYgc2VxX251bWJlcjsNCj4gICAgICAgICBfX2xlMTYgZmMgPSBoZHItPmZyYW1l
X2NvbnRyb2w7DQo+ICAgICAgICAgdTggcmF0ZV9mbGFnID0gaW5mby0+Y29udHJvbC5yYXRlc1sw
XS5mbGFnczsNCj4gQEAgLTQ5OCwxMCArNDk5LDIwIEBAIHZvaWQgcnRsOTJjdV90eF9maWxsX2Rl
c2Moc3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQo+ICAgICAgICAgc2V0X3R4X2Rlc2NfdHhfcmF0
ZSh0eGRlc2MsIHRjYl9kZXNjLT5od19yYXRlKTsNCj4gICAgICAgICBpZiAodGNiX2Rlc2MtPnVz
ZV9zaG9ydGdpIHx8IHRjYl9kZXNjLT51c2Vfc2hvcnRwcmVhbWJsZSkNCj4gICAgICAgICAgICAg
ICAgIHNldF90eF9kZXNjX2RhdGFfc2hvcnRnaSh0eGRlc2MsIDEpOw0KPiAtICAgICAgIGlmICht
YWMtPnRpZHNbdGlkXS5hZ2cuYWdnX3N0YXRlID09IFJUTF9BR0dfT04gJiYNCj4gLSAgICAgICAg
ICAgICAgICAgICBpbmZvLT5mbGFncyAmIElFRUU4MDIxMV9UWF9DVExfQU1QRFUpIHsNCj4gKw0K
PiArICAgICAgIGlmIChzdGEpIHsNCj4gKyAgICAgICAgICAgICAgIHN0YV9lbnRyeSA9IChzdHJ1
Y3QgcnRsX3N0YV9pbmZvICopc3RhLT5kcnZfcHJpdjsNCg0Kbml0OiBJdCB3b3VsZCBiZSBiZXR0
ZXIgdG8gYmUgc2VwYXJhdGVkIHN0YXRlbWVudCBvZiBpZWVlODAyMTFfZ2V0X3RpZChoZHIpDQoN
CnRpZCA9IGllZWU4MDIxMV9nZXRfdGlkKGhkcik7DQphZ2dfc3RhdGUgPSBzdGFfZW50cnktPnRp
ZHNbdGlkXS5hZ2cuYWdnX3N0YXRlOw0KDQoNCj4gKyAgICAgICAgICAgICAgIGFnZ19zdGF0ZSA9
IHN0YV9lbnRyeS0+dGlkc1tpZWVlODAyMTFfZ2V0X3RpZChoZHIpXS5hZ2cuYWdnX3N0YXRlOw0K
PiArICAgICAgICAgICAgICAgYW1wZHVfZGVuc2l0eSA9IHN0YS0+ZGVmbGluay5odF9jYXAuYW1w
ZHVfZGVuc2l0eTsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBpZiAoYWdnX3N0YXRlID09
IFJUTF9BR0dfT1BFUkFUSU9OQUwgJiYNCj4gKyAgICAgICAgICAgaW5mby0+ZmxhZ3MgJiBJRUVF
ODAyMTFfVFhfQ1RMX0FNUERVKSB7DQo+ICAgICAgICAgICAgICAgICBzZXRfdHhfZGVzY19hZ2df
ZW5hYmxlKHR4ZGVzYywgMSk7DQo+ICAgICAgICAgICAgICAgICBzZXRfdHhfZGVzY19tYXhfYWdn
X251bSh0eGRlc2MsIDB4MTQpOw0KDQpIYXZlIHlvdSB0cmllZCBsYXJnZXIgbnVtYmVyIG9mIHRo
aXM/IA0KQXMgSUVFRTgwMjExX01BWF9BTVBEVV9CVUZfSFQgaXMgMHg0MCwgc2V0IDB4M2YgaGVy
ZSB0byBnZXQgaGlnaGVyIFRYDQp0aHJvdWdocHV0IGlmIFVTQiBzcGVlZCBjYW4gYWZmb3JkLiAN
Cg0KWW91IGNhbiByZWZlcmVuY2UgYW4gZXF1YXRpb24gb2YgcnR3ODk6IA0KDQoJYW1wZHVfbnVt
ID0gKHU4KSgocnR3c3RhLT5hbXBkdV9wYXJhbXNbdGlkXS5hZ2dfbnVtID8NCgkJCSAgcnR3c3Rh
LT5hbXBkdV9wYXJhbXNbdGlkXS5hZ2dfbnVtIDoNCgkJCSAgNCA8PCBzdGEtPmRlZmxpbmsuaHRf
Y2FwLmFtcGR1X2ZhY3RvcikgLSAxKTsNCg0KVGhpcyBpcyBuZXcgZm9yIHJ0bHdpZmksIHNvIHdl
IGNhbiBoYXZlIHRoaXMgbGF0ZXIuIA0KDQoNClsuLi5dDQoNCg0KDQo=

