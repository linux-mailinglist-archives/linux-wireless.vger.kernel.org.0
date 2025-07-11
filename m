Return-Path: <linux-wireless+bounces-25257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D82B01711
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB371C43E30
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92142217666;
	Fri, 11 Jul 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IOt8Jjep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B051FE45B;
	Fri, 11 Jul 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224467; cv=none; b=U6/Ox3ASVz8SLPa+pby3tKWiLaM3NfutXwmUszZjDB9zlyIOELYbMM5nOIYhuhNOzha6zoNHbS+axqJrctJwcTDnsRX2EoQNurkqEwOWgfJmv0sjglNXPSanKnZQQ4Nwmr+9M0EoEiTpWQLs1M1LKJldykPL09HM6lJx2sRIuEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224467; c=relaxed/simple;
	bh=YpQaW6Q+LrADB4lXS5nz6IxnIoQPHJzVnqRq7V4UyOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qQWUXr14rfP2cuPKnIdHabSHq1nKkd1/tOR11cW4OQrY7yMReOPh+e1q3Thmcj8C0IV93rIpLh0xyW0HvvvBzjbeda4ejfX2oOyg1W9nam26BB+oC3pljqGS/Vu06UVzbiP2mLdSxbICArHDxQ1/Tvvm92RNNvQozeYXbzZdk60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IOt8Jjep; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56B90haE6756266, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752224444; bh=YpQaW6Q+LrADB4lXS5nz6IxnIoQPHJzVnqRq7V4UyOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IOt8JjepXiUTvjsWLwTcdkswSM+sogoyMkkpcg7o9yIpODn2hqz6KYSOG+15b6IHm
	 V7FZ00mVws65nqS63mp9Q1LKKAn8jX/fP2Eoj3/1wTmL/0QDOdN59RNy2Jp6ZG4ksM
	 3m8V+mgDMtED+x3n3tyU6WmOnpsVs+gLpR+HFkFz9grJfO2+Y+trvsm6Qdx/vBsOpe
	 4OlGYDDIThtYBviy0vqxXMTXaOoQxqjYh4RYgDm5OuHYTPM9cgYgc3bAqhnT4sX7T2
	 5LClBy5Pcrvze6hTUtZovdcai5zjrlV3Apb1vtieTzaXIGpV3HwYeFjLfQT7OkEfEd
	 2uYYn6H8JUzIw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56B90haE6756266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:00:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Jul 2025 17:00:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 11 Jul 2025 17:00:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 11 Jul 2025 17:00:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Fiona Klute <fiona.klute@gmx.de>
Subject: RE: [PATCH v3] wifi: rtw88: enable TX reports for the management queue
Thread-Topic: [PATCH v3] wifi: rtw88: enable TX reports for the management
 queue
Thread-Index: AQHb8enPOUIDreW220yczxSl7U1tKbQsC/OAgAAMeICAAIf9YA==
Date: Fri, 11 Jul 2025 09:00:43 +0000
Message-ID: <af19b6fff6e248cf89500989931ff4f4@realtek.com>
References: <20250710222432.3088622-1-andrej.skvortzov@gmail.com>
 <7e7a3532816b48ef94c18e735a0f7a3f@realtek.com> <aHDQ4ah-UpJ7ADvJ@skv.local>
In-Reply-To: <aHDQ4ah-UpJ7ADvJ@skv.local>
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

QW5kcmV5IFNrdm9ydHNvdiA8YW5kcmVqLnNrdm9ydHpvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiAN
Cj4gT24gMjUtMDctMTEgMDA6MTEsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBBbmRyZXkgU2t2
b3J0c292IDxhbmRyZWouc2t2b3J0em92QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiBUaGlzIGlz
IG5lZWRlZCBmb3IgQVAgbW9kZS4gT3RoZXJ3aXNlIGNsaWVudCBzZWVzIHRoZSBuZXR3b3JrLCBi
dXQNCj4gPiA+IGNhbid0IGNvbm5lY3QgdG8gaXQuDQo+ID4gPg0KPiA+ID4gUkVHX0ZXSFdfVFhR
X0NUUkwrMSBpcyBzZXQgdG8gV0xBTl9UWFFfUlBUX0VOICgweDFGKSBpbiBjb21tb24gbWFjDQo+
ID4gPiBpbml0IGZ1bmN0aW9uIChfX3J0dzg3MjN4X21hY19pbml0KSwgYnV0IHRoZSB2YWx1ZSB3
YXMgb3ZlcndyaXR0ZW4NCj4gPiA+IGZyb20gbWFjIHRhYmxlIGxhdGVyLg0KPiA+ID4NCj4gPiA+
IFRhYmxlcyB3aXRoIHJlZ2lzdGVyIHZhbHVlcyBmb3IgcGh5IHBhcmFtZXRlcnMgaW5pdGlhbGl6
YXRpb24gYXJlDQo+ID4gPiBjb3BpZWQgZnJvbSB2ZW5kb3IgZHJpdmVyIHVzdWFsbHkuIFdoZW4g
dGFibGUgd2lsbCBiZSByZWdlbmVyYXRlZCwNCj4gPiA+IG1hbnVhbCBtb2RpZmljYXRpb25zIHRv
IGl0IG1heSBiZSBsb3N0LiBUbyBhdm9pZCByZWdyZXNzaW9ucyBpbiB0aGlzDQo+ID4gPiBjYXNl
IG5ldyBjYWxsYmFjayBtYWNfcG9zdGluaXQgaXMgaW50cm9kdWNlZCwgdGhhdCBpcyBjYWxsZWQg
YWZ0ZXINCj4gPiA+IHBhcmFtZXRlcnMgZnJvbSB0YWJsZSBhcmUgc2V0Lg0KPiA+ID4NCj4gPiA+
IFRlc3RlZCBvbiBydGw4NzIzY3MsIHRoYXQgcmV1c2VzIHJ0dzg3MDNiIGRyaXZlci4NCj4gPiA+
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2t2b3J0c292IDxhbmRyZWouc2t2b3J0em92
QGdtYWlsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4NCj4gPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4g
PiAgLSBpbnRyb2R1Y2UgbWFjX3Bvc3Rpbml0IGNhbGxiYWNrIHRvIGF2b2lkIGNoYW5naW5nIHJl
Z2lzdGVyIHRhYmxlcw0KPiA+ID4NCj4gPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gPiAgLSBtZXJn
ZSB0d28gcGF0Y2hlcyBiYWNrIHRvZ2V0aGVyDQo+ID4gPiAgLSByZW1vdmUgdW51c2VkIGluaXRp
YWxpemF0aW9uIGluIHJ0d19tYWNfcG9zdGluaXQNCj4gPiA+ICAtIGluaXQgdW51c2VkIC5tYWNf
cG9zdGluaXQgZmllbGRzIGluIGRyaXZlcnMgd2l0aCBOVUxMDQo+ID4gPg0KPiA+ID4gIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFjLmMgICAgICB8IDExICsrKysrKysrKysr
DQo+ID4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWMuaCAgICAgIHwg
IDEgKw0KPiA+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jICAg
ICB8ICA2ICsrKysrKw0KPiA+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgv
bWFpbi5oICAgICB8ICAxICsNCj4gPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3J0dzg3MDNiLmMgfCAgMSArDQo+ID4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OC9ydHc4NzIzZC5jIHwgIDEgKw0KPiA+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvcnR3ODcyM3guYyB8ICA5ICsrKysrKysrLQ0KPiA+ID4gIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODcyM3guaCB8ICA2ICsrKysrKw0KPiA+ID4gIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgxMmEuYyB8ICAxICsNCj4gPiA+
ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MTRhLmMgfCAgMSArDQo+
ID4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIxYS5jIHwgIDEg
Kw0KPiA+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgyMWMuYyB8
ICAxICsNCj4gPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjJi
LmMgfCAgMSArDQo+ID4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4
ODIyYy5jIHwgIDEgKw0KPiA+ID4gIDE0IGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OC9tYWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvbWFjLmMNCj4gPiA+IGluZGV4IDAxMWI4MWM4MmYzYmEuLmUxZWM5YWE0MDFmYTAgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21hYy5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21hYy5jDQo+
ID4gPiBAQCAtMTQwOSwzICsxNDA5LDE0IEBAIGludCBydHdfbWFjX2luaXQoc3RydWN0IHJ0d19k
ZXYgKnJ0d2RldikNCj4gPiA+DQo+ID4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gIH0NCj4g
PiA+ICsNCj4gPiA+ICtpbnQgcnR3X21hY19wb3N0aW5pdChzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2
KQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgICAgY29uc3Qgc3RydWN0IHJ0d19jaGlwX2luZm8gKmNo
aXAgPSBydHdkZXYtPmNoaXA7DQo+ID4gPiArICAgICAgIGludCByZXQ7DQo+ID4gPiArDQo+ID4g
PiArICAgICAgIGlmIChjaGlwLT5vcHMtPm1hY19wb3N0aW5pdCkNCj4gPiA+ICsgICAgICAgICAg
ICAgICByZXQgPSBjaGlwLT5vcHMtPm1hY19wb3N0aW5pdChydHdkZXYpOw0KPiA+ID4gKw0KPiA+
DQo+ID4gJ3JldCcgaXMgbm90IHVzZWQgWzFdLg0KPiA+DQo+ID4gUHJlZmVyOg0KPiA+DQo+ID4g
aWYgKCFjaGlwLT5vcHMtPm1hY19wb3N0aW5pdCkNCj4gPiAgICAgcmV0dXJuIDA7DQo+ID4NCj4g
PiByZXR1cm4gY2hpcC0+b3BzLT5tYWNfcG9zdGluaXQocnR3ZGV2KTsNCj4gPg0KPiA+IFsxXSBo
dHRwOi8vd2lmaWJvdC5zaXBzb2x1dGlvbnMubmV0L3Jlc3VsdHMvOTgxMjcyLzE0MTUyNTEzL2J1
aWxkX2NsYW5nL3N0ZGVycg0KPiA+DQo+IA0KPiBUaGFua3MsIHNvcnJ5IEkndmUgbWlzc2VkIHdh
cm5pbmcuDQo+IEknbGwgdXNlIENPTkZJR19XRVJST1IgYW5kIGNoYW5nZSBteSBidWlsZCBwaXBl
bGluZSwgc28gdGhpcyB3aWxsIG5vdCBoYXBwZW4gaW4gdGhlIGZ1dHVyZS4NCj4gDQoNCllvdSBj
YW4gYWxzbyBjaGVjayB0aGUgcmVzdWx0IGluIHBhdGNod29yayBbMV0gYWZ0ZXIgYSB3aGlsZSB5
b3Ugc2VudCBwYXRjaC4NCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC13aXJlbGVzcy9saXN0Lw0KDQo=

