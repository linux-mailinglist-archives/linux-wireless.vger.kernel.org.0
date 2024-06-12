Return-Path: <linux-wireless+bounces-8829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5B0904B58
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 08:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76003284177
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 06:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1C112D1FE;
	Wed, 12 Jun 2024 06:08:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228084DEB
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718172504; cv=none; b=Jp9HEaKMui/GPINCnOocWfBZMd0kPw+PlVzgjUd4dMwwVmxoe+dMDzi/GkHppYFDGvWxuIy5rJueLOfGuythZiHPGPOrNbpBvfGjJmjBrWPo/4gmdV2Z96LQV+Hz6U1hjzFUS6GURYGlR8Fqw1GdES1C7+hmTgurJ9eN3vC7uE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718172504; c=relaxed/simple;
	bh=uupenwECk4laeCcjur+cGh8d8Ar97UUiHtDzi0K7KDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CtgWl51TBhBJRzdxN3NXNq+u7mtdceSQpZZXnobOfyDtY4iICyc5wJ/GQxxNtXM+gglxbG6DYC/ys46ihJJR8vHl/ZYUC+pn///wXiXFZNM1204CNLa8dVnN03FUdpuLcPmV5tcqf78YZFvV5Y0gWbcssDcc4LckUDUrxXObshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45C687gG4977213, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45C687gG4977213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 14:08:07 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 14:08:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Jun 2024 14:08:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 12 Jun 2024 14:08:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kalle
 Valo" <kvalo@kernel.org>,
        =?utf-8?B?TWFyY2luIMWabHVzYXJ6?=
	<mslusarz@renau.com>
Subject: RE: rtw88 multicast failure in AP mode
Thread-Topic: rtw88 multicast failure in AP mode
Thread-Index: AQHauOwsgeUJhnLB0Eaji1GrCgk797HB3EwggAALqwCAAXTlIP//xYwAgACHSEA=
Date: Wed, 12 Jun 2024 06:08:06 +0000
Message-ID: <9bec9d852273467fbf66af68e3c4d325@realtek.com>
References: <CA+GA0_t7RPsqQ2XztOtRyW3BVZfE54h+Rg+fxRNPL8qwQWKeDw@mail.gmail.com>
 <868343c920c24204972ddaa108e5d00e@realtek.com>
 <CA+GA0_vA1KRRyvnURfdjwVv5JBkRhkjdQnwrRWWKmZs9_z-X1w@mail.gmail.com>
 <c5b42d8b818b4bd5ac8a6921a29f9f18@realtek.com>
 <CA+GA0_vHeYLNw88KCnD9NACofA5rPJppj0nWZi+v5FqZLmpomA@mail.gmail.com>
In-Reply-To: <CA+GA0_vHeYLNw88KCnD9NACofA5rPJppj0nWZi+v5FqZLmpomA@mail.gmail.com>
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

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOg0KPiDFm3Iu
LCAxMiBjemUgMjAyNCBvIDAzOjMwIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiBu
YXBpc2HFgihhKToNCj4gPg0KPiA+IE1hcmNpbiDFmmx1c2FyeiA8bWFyY2luLnNsdXNhcnpAZ21h
aWwuY29tPiB3cm90ZToNCj4gPiA+IHd0LiwgMTEgY3plIDIwMjQgbyAwNDozMiBQaW5nLUtlIFNo
aWggPHBrc2hpaEByZWFsdGVrLmNvbT4gbmFwaXNhxYIoYSk6DQo+ID4gPiA+DQo+ID4gPiA+IE1h
cmNpbiDFmmx1c2FyeiA8bWFyY2luLnNsdXNhcnpAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4g
PiBMZXQncyBhc3N1bWUgd2UgaGF2ZSAzIHN5c3RlbXM6IEEgYW5kIEIgdXNlIDg4MjFDVSBjaGlw
LCBhbmQgQyB1c2VzDQo+ID4gPiA+ID4gYW5vdGhlciBjaGlwIGZyb20gYSBkaWZmZXJlbnQgdmVu
ZG9yLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSWYgQSBpcyBpbiBBUCBtb2RlIGFuZCBBIGFuZCBC
IHVzZSB0aGUgcnR3ODggZHJpdmVyLCBwaW5naW5nIEEgZnJvbSBCDQo+ID4gPiA+ID4gYW5kIEMg
YnkgbG9jYWwgbmFtZSBkb2Vzbid0IHdvcmsgYmVjYXVzZSBuYW1lIHJlc29sdXRpb24gZmFpbHM6
IGF2YWhpDQo+ID4gPiA+ID4gb24gQiBhbmQgQyBzZW5kcyBhIG11bHRpY2FzdCByZXF1ZXN0IHRv
IHJlc29sdmUgQS5sb2NhbCwgQSBzZWVzIGl0IGFuZA0KPiA+ID4gPiA+IHJlc3BvbmRzLCBidXQg
bmVpdGhlciBCIG5vciBDIHNlZXMgdGhlIHJlc3BvbnNlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
SW4gdGhlIHNhbWUgc2l0dWF0aW9uLCBidXQgd2l0aCBBIGFuZCBCIHVzaW5nIHRoZSBydGw4ODIx
Y3UgZHJpdmVyDQo+ID4gPiA+ID4gKGZyb20gaHR0cHM6Ly9naXRodWIuY29tL21vcnJvd25yLzg4
MjFjdS0yMDIxMDkxNi5naXQpLCBldmVyeXRoaW5nDQo+ID4gPiA+ID4gd29ya3MgLSBCIGFuZCBD
IHNlZSBBJ3MgcmVzcG9uc2UgYW5kIGNhbiByZXNvbHZlIEEubG9jYWwuDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBJZiBDIGlzIGluIEFQIG1vZGUsIHJlc29sdmluZyBDIGZyb20gQSBhbmQgQiBhbHNv
IHdvcmtzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhpcyBsZWFkcyBtZSB0byBiZWxpZXZlIHRo
ZXJlJ3Mgc29tZXRoaW5nIHdyb25nIHdpdGggcnR3ODggd2hlbg0KPiA+ID4gPiA+IHNlbmRpbmcg
bXVsdGljYXN0IHBhY2tldHMgaW4gQVAgbW9kZS4NCj4gPiA+ID4NCj4gPiA+ID4gSGF2ZSB5b3Ug
Y2FwdHVyZWQgYWlyIHBhY2tldHMgc2VudCBieSBDIChBUCBtb2RlKT8gKFRvIGNoZWNrIGlmIFRY
IHByb3Blcmx5LikNCj4gPiA+DQo+ID4gPiBZZXMsIEkgc2VlIHBhY2tldHMgaW4gYm90aCBkaXJl
Y3Rpb25zIG9uIGJvdGggQyBhbmQgQSBpZiBDIGlzIGluIEFQIG1vZGUuDQo+ID4gPg0KPiA+ID4g
PiBIYXZlIHlvdSB0cmllZCBub24tc2VjdXJlIGNvbm5lY3Rpb24/IChUbyBjaGVjayBpZiBlbmNy
eXB0aW9uIHByb3Blcmx5LikNCj4gPiA+DQo+ID4gPiBOb3RoaW5nIGNoYW5nZXMgLSBydHc4OCBp
biBBUCBtb2RlIHNlbmRzIG11bHRpY2FzdCBwYWNrZXRzLCBidXQgb3RoZXINCj4gPiA+IGRldmlj
ZXMgZG9uJ3Qgc2VlIHRoZW0uDQo+ID4NCj4gPiBIb3cgY2FuIHlvdSBhc3NlcnQgb3RoZXIgZGV2
aWNlcyBkb24ndCBzZWUgdGhlbT8gUmVjZWl2ZXJzIGRvbid0IEFDSw0KPiA+IG11bHRpY2FzdC9i
cm9hZGNhc3QgcGFja2V0cywgc28gaGF2ZSB5b3UgYWRkZWQgZGVidWcgbG9nIGluIEEgb3IgQj8N
Cj4gDQo+IEJlY2F1c2UgSSBkb24ndCBzZWUgdGhlbSBpbiB0Y3BkdW1wIG91dHB1dC4NCg0KTXVs
dGljYXN0IHBhY2tldHMgZnJvbSBBIChpbiBBUCBtb2RlKSBkaWRuJ3QgcHJlc2VudCBpbiB0Y3Bk
dW1wIG91dHB1dCBvZiBCLCBidXQNCm11bHRpY2FzdCBwYWNrZXRzIGZyb20gQyAoaW4gQVAgbW9k
ZSkgZGlkIHByZXNlbnQgaW4gdGNwZHVtcCBvdXRwdXQgb2YgQj8NCg0KPiANCj4gPiBDb21wYXJl
IGFpciBwYWNrZXRzIGluIG5vbi1zZWN1cmUgY29ubmVjdGlvbiBiZXR3ZWVuIHdoYXQgQSBhbmQg
QyBwbGF5cyBBUCBtb2RlLg0KPiANCj4gSSdtIG5vdCBzdXJlIHdoYXQgImFpciBwYWNrZXRzIiBt
ZWFuLiBJIGRvbid0IGhhdmUgYSByYWRpbyBzbmlmZmluZw0KPiB0b29sIHRvIHNlZSB3aGF0J3MN
Cj4gZ29pbmcgb24sIA0KDQpydHc4OCBjYW4gYmUgYSBzbmlmZmVyLiANCg0KICBzdWRvIGl3IGRl
diB3bGFuMCBpbnRlcmZhY2UgYWRkIG1vbjAgdHlwZSBtb25pdG9yDQogIHN1ZG8gaWZjb25maWcg
bW9uMCB1cA0KICBzdWRvIHdpcmVzaGFyayAgLy8gc2VsZWN0IG1vbjAsIGFuZCBzd2l0Y2ggY2hh
bm5lbCBieSBHVUkgdG9vbGJhcg0KDQoNCj4gYW5kIGJ5IHRoZSB0aW1lIHBhY2tldHMgYXJlIGF2
YWlsYWJsZSBpbiB0aGUgZHJpdmVyLCB0aGV5IHdlcmUgYWxyZWFkeQ0KPiBwcm9jZXNzZWQgYW5k
IGZpbHRlcmVkIGJ5IGhhcmR3YXJlLCBzbyB0aGV5IGNhbid0IGJlIGNvbnNpZGVyZWQgImFpciIu
DQo+IElmIHlvdSBoYXZlIGEgc3BlY2lmaWMgcGxhY2UgaW4gdGhlIGRyaXZlciB3aGVyZSB5b3Ug
d2FudCBtZSB0byBwdXQNCj4gZGVidWdzLCBsZXQgbWUga25vdy4NCg0KSSBkaWRuJ3QgaGF2ZSBh
IHNwZWNpZmljIHBsYWNlLiBKdXN0IHdhbnQgdG8ga25vdyBob3cgeW91IGNvbmZpcm1lZA0KIkFQ
IHNlbnQgcGFja2V0cyIgYW5kICJTVEEgcmVjZWl2ZWQgcGFja2V0cyIuIEl0IHNlZW1zIGxpa2Ug
eW91IGRpZG4ndCANCmNhcHR1cmUgcGFja2V0cyBpbiB0aGUgYWlyLiBTbyBwbGVhc2Ugc2V0dXAg
cnR3ODggdG8gZG8gdGhhdC4gQnkgdGhlIHdheSwNCm1vbml0b3IgbW9kZSBvZiBydHc4OCBoYXMg
YnJva2VuIFsxXSBzb21laG93LiBQbGVhc2UgdXNlIG9sZGVyIGtlcm5lbCB0bw0KY2FwdHVyZSBw
YWNrZXRzLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvNTMx
ODY0MGQ2ZWI3NDMwMWIxZmJmNmQ5Mzg1YmE2OWVAcmVhbHRlay5jb20vVC8jbTY5ODRkZmM0YTg1
YjM4OTUxMWMyNTNjMmI5NzU0N2E0MTQ4ZTgzZDkNCg0KDQoNCg==

