Return-Path: <linux-wireless+bounces-3528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D885304F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECF01F29EB2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 12:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8028439FF0;
	Tue, 13 Feb 2024 12:13:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A38383B4
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826401; cv=none; b=bhWfJqcj+/oLxedxp29I1pL1Ckog4VovEOEzPfEpRrMbiJrHMiAa0EkmBzcGP0vzQ7lpk1wtQWMXZ/P/AucrIKztNBlXKpAMgq5Uy4MzP7un1Qsad/qc36tvyHkNO78wM1204g5ClI2wTiiiAPfT/rZwcEPjGtosIQZ8Gp8/o4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826401; c=relaxed/simple;
	bh=ZDbzR8M4s3tqNpi5eOpAKinYKrp8/wYefpxvHedINk8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rYL/Gi5KlsJcXJxqCCqLqQ1pGxCbFyfBNTF701Gp5+NpMejufAS2CJzycJak9xd+r714jOiEFIkkjFwcJO+CcXvi121wmyYLjerOpHcK355wbLqaj45FlC4xE/lctpDV3uq1ms04enfXz06a5SEIyTJ9lhOUKyEm0+OqgAvzgF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41DCD6AD01720494, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41DCD6AD01720494
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 20:13:06 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 13 Feb 2024 20:13:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 20:13:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 13 Feb 2024 20:13:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into chandef
Thread-Topic: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
Thread-Index: AQHaUuQAKtICccJuvkyOo86/O7KcarEHdDiAgAAVK4CAADaQAA==
Date: Tue, 13 Feb 2024 12:13:06 +0000
Message-ID: <a17862ae423422b636c76f116e712e7ebed51c09.camel@realtek.com>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
	 <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
	 <f489a916f416cb37b527868c4be0c59547bdeb4d.camel@realtek.com>
	 <94bd67a6f261d945917067334b633c78be665c6b.camel@sipsolutions.net>
In-Reply-To: <94bd67a6f261d945917067334b633c78be665c6b.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <1962D615B2441843A9737F5A26EF5633@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSm9oYW5uZXMsDQoNCk9uIFR1ZSwgMjAyNC0wMi0xMyBhdCAwOTo1NyArMDEwMCwgSm9oYW5u
ZXMgQmVyZyB3cm90ZToNCj4gDQo+IA0KPiBBY3R1YWxseSwgc29ycnkgYWJvdXQgdGhpcyBwYXJ0
IG9mIHRoZSBwYXRjaC4gUHJldHR5IHN1cmUgSSBtZWFudCB0byBhc2sNCj4geW91LCBidXQgdGhl
biB3YW50ZWQgdG8gZ2V0IHRoaW5ncyB0b2dldGhlciBiZWZvcmUgZXZlcnl0aGluZyBicm9rZSAu
Li4NCj4gDQo+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3
LmMNCj4gPiA+IEBAIC0yNDk1LDggKzI0OTUsMTEgQEAgaW50IHJ0dzg5X2Z3X2gyY19hc3NvY19j
bWFjX3RibF9nNyhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsDQo+ID4gPiAgICAgfQ0KPiA+ID4g
DQo+ID4gPiAgICAgaWYgKHZpZi0+YnNzX2NvbmYuZWh0X3N1cHBvcnQpIHsNCj4gPiA+IC0gICAg
ICAgICAgIGgyYy0+dzQgfD0gbGUzMl9lbmNvZGVfYml0cyh+dmlmLT5ic3NfY29uZi5laHRfcHVu
Y3R1cmluZywNCj4gPiA+ICsgICAgICAgICAgIHUxNiBwdW5jdCA9IHZpZi0+YnNzX2NvbmYuY2hh
bnJlcS5vcGVyLnB1bmN0dXJlZDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgICAgIGgyYy0+dzQg
fD0gbGUzMl9lbmNvZGVfYml0cyh+cHVuY3QsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQ0NUTElORk9fRzdfVzRfQUNUX1NVQkNIX0NCVyk7DQo+ID4gPiAr
ICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsNCj4gPiANCj4gPiBXZSBkb24ndCBkZWZlcmVu
Y2UgY2hhbmN0eCB0byByZWZlcmVuY2UgcHVuY3R1cmUgdmFsdWUuIEluc3RlYWQgdXNlIHRoZQ0K
PiA+IHZhbHVlIGZyb20gdmlmLT5ic3NfY29uZi5jaGFucmVxLCBzbyBJIHRoaW5rIHdlIGRvbid0
IG5lZWQgUkNVIGxvY2tzLCByaWdodD8NCj4gDQo+IFdlbGwsIGNsZWFybHkgdGhlIHJjdV9yZWFk
X3VubG9jaygpIGlzIHdyb25nIHNpbmNlIGl0J3Mgbm90IHBhaXJlZCB3aXRoDQo+IHJjdV9yZWFk
X2xvY2soKS4gSSBkb24ndCBrbm93IGhvdyBuZWl0aGVyIEkgbm9yIHRoZSByb2JvdHMgbm90aWNl
ZA0KPiB0aGF0PyENCj4gDQo+IFRoZSBvdGhlciB0aGluZyBoZXJlIGlzIHRoYXQgSSdtIG5vdCBl
bnRpcmVseSBzdXJlIGhvdyB0aGUgZHJpdmVyIHdvcmtzLA0KPiBjaGFuY2VzIGFyZSB0aGF0IHRo
aXMgd2FzIHByZXZpb3VzbHkgYSBidWcsIGFuZCBub3cgaXMgc3RpbGwgYSBidWcsDQo+IHVubGVz
cyB0aGUgZHJpdmVyIGRvZXNuJ3QgcmVhbGx5IHN1cHBvcnQgY2hhbm5lbCBjb250ZXh0cywgb3Ig
YW55IGZvcm0NCj4gb2YgY29uY3VycmVuY3kuDQoNClRoaXMgZnVuY3Rpb24gaXMgdG8gaW5pdGlh
bGl6ZSBhIHN0YXRpb24gaW5zdGFuY2UgaW4gZmlybXdhcmUgd2hpbGUNCmFzc29jaWF0aW5nLCBh
bmQgdGhlIGZpZWxkIG9mIGZpcm13YXJlIGNvbW1hbmQgaXMgdG8gdGVsbCBNQUMgaGFyZHdhcmUN
CnRoZSBzdWItY2hhbm5lbHMgaXQgY2FuIHVzZSB0byB0cmFuc21pdCwgd2hpY2ggc2hvdWxkIHJl
bHkgb24gDQpiaXRtYXAgb2YgcHVuY3R1cmluZy4gSW5pdGlhbGx5LCB3ZSBqdXN0IHdhbnRlZCB0
aGUgZmllbGQgdmFsdWUgdG8NCmJlIH4wICgweEZGRkYpIHRvIHByZXZlbnQgVFggc3R1Y2ssIGJ1
dCBub3QgZnVsbHkgaW1wbGVtZW50ZWQgcHVuY3R1cmluZw0KZmVhdHVyZS4NCg0KSSB0aGluayB0
aGlzIGlzIHRoZSByZWFzb24geW91IGFyZSBjb25mdXNlZC4gDQoNCj4gDQo+IElmIHlvdSBhY3R1
YWxseSBoYXZlIHRoZSBhYmlsaXR5IHRvIHN1cHBvcnQgdHdvIGNvbm5lY3Rpb25zIChlLmcuIFAy
UA0KPiBhbmQgQlNTIGNsaWVudCkgdGhlbiB0aGVvcmV0aWNhbGx5IGl0J3MgcG9zc2libGUgdGhh
dCB5b3UgaGF2ZSB0d28gRUhUDQo+IGNvbm5lY3Rpb25zIHdpdGggY29tcGF0aWJsZSBwdW5jdHVy
aW5nLCB1c2luZyB0aGUgc2FtZSBjaGFubmVsIGNvbnRleHQsDQo+IGJ1dCB3aXRoIGRpZmZlcmVu
dCBiYW5kd2lkdGhzLCBlLmcuDQo+IA0KPiBCU1MgMTYwIE1IeiAgIHwgICB8ICAgfCAgIHwgICB8
IEMgfCAgIHwgICB8IFAgfA0KPiBQMlAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IEMgfCAg
IHwgICB8IFAgfA0KPiANCj4gKFApIGluZGljYXRlcyBwdW5jdHVyZWQgc3ViY2hhbm5lbCwgKEMp
IGluZGljYXRlcyBjb250cm9sIGNoYW5uZWwNCj4gDQo+IEluIHRoaXMgY2FzZSwgcDJwX3ZpZi0+
YnNzX2NvbmYuY2hhbnJlcS5vcGVyLnB1bmN0dXJlZCA9PSAweDggd2hlcmVhcw0KPiBic3Nfdmlm
LT5ic3NfY29uZi5jaGFucmVxLm9wZXIucHVuY3R1cmVkID09IDB4ODAuDQo+IA0KPiBIb3dldmVy
LCB5b3UnZCByZWFsbHkgYmUgdXNpbmcgdGhlIGFjdHVhbCBjaGFubmVsIGNvbmZpZ3VyYXRpb24g
ZnJvbSB0aGUNCj4gY2hhbm5lbCBjb250ZXh0LCB3aGljaCBtYXRjaGVzIHRoZSBCU1MgdmlmLCBz
byBzaG91bGQgYmUgcHVuY3R1cmluZw0KPiBiaXRtYXAgMHg4MC4NCj4gDQo+IA0KPiBTbyByZWFs
aXN0aWNhbGx5LCB3aGF0IHlvdSBwcm9iYWJseSBuZWVkL3dhbnQgdG8gZG8gaXMgbW92ZSB0aGlz
IHdob2xlDQo+IGNodW5rIG9mIGNvZGUgdG8gd2hlbiB0aGUgKmNoYW5uZWwgY29udGV4dCogY2hh
bmdlcywgaS5lLiB0bw0KPiBydHc4OV9jaGFuY3R4X29wc19jaGFuZ2UoKS4gWW91IGV2ZW4gZ2V0
IHRoZQ0KPiBJRUVFODAyMTFfQ0hBTkNUWF9DSEFOR0VfUFVOQ1RVUklORyBmbGFnIHdoZW4gdGhl
IHB1bmN0dXJpbmcgY2hhbmdlcw0KPiB0aGVyZS4gQWxzbyBuZWVkIGl0IGluIHJ0dzg5X2NoYW5j
dHhfb3BzX2FkZCgpIG9mIGNvdXJzZSwgYW5kIHBvc3NpYmx5DQo+IGluIHJ0dzg5X2NoYW5jdHhf
b3BzX3JlbW92ZSgpLg0KDQpUaGFua3MgZm9yIHRoaXMgaGludC4gSSB3aWxsIGNoZWNrIG15IGNv
bGxlYWd1ZXMgYWJvdXQgdGhlIGRldGFpbCBvZiANCnB1bmN0dXJpbmcgYmVoYXZpb3IgbmV4dCB3
ZWVrLCBiZWNhdXNlIHBlb3BsZSBhcmUgb2ZmbGluZSBmb3IgdGhlIGx1bmFyDQpuZXcgeWVhci4g
SSB3aWxsIGFsc28gY2hlY2sgcGVvcGxlIGFib3V0IHRoZSBiZWFjb24gQ1NBIG1lbnRpb25lZCBp
bg0KYW5vdGhlciBkaXNjdXNzaW9uIHRocmVhZC4NCg0KPiANCj4gVGhvdWdoIGl0IF9sb29rc18g
bGlrZSB5b3Ugb25seSBzdXBwb3J0IG9uZSBjaGFubmVsIGNvbnRleHQgdGhlcmUsIHNvDQo+IG1h
eWJlIGFsc28gb25seSBvbmUgdmlmLCBhbmQgaXQgZG9lc24ndCBtYXR0ZXI/IEknZCBwcm9iYWJs
eSBzdGlsbCBtb3ZlDQo+IGl0IG92ZXIgdG8gdGhlIGNoYW4uYyBjb2RlIHRob3VnaCwgaXQgcmVh
bGx5IGRvZXMgYmVsb25nIHRoZXJlIG1vcmUgYXMNCj4gZGlzY3Vzc2VkIGluIHRoZSBjb21taXQg
bWVzc2FnZSBvZiB0aGlzIGNoYW5nZS4NCj4gDQo+IEJ1dCBJIGRpZG4ndCB3YW50IHRvIG1ha2Ug
dGhvc2UgbW9yZSBzZW1hbnRpYyBjaGFuZ2VzIGJlY2F1c2UgSSBkb24ndA0KPiBrbm93IHdoYXQg
bG9naWMgeW91ciBkZXZpY2UgYXBwbGllcyBoZXJlLg0KDQpXZSBhcmUgZ29pbmcgdG8gc3VwcG9y
dCBNQ0MgYW5kIE1MTywgc28gd2Ugd2lsbC9tdXN0IGNvbnNpZGVyIG1vcmUgdGhhbg0Kb25lIGNo
YW5uZWwgY29udGV4dC4gQ3VycmVudGx5LCBydHc4OSBqdXN0IGNvbnNpZGVyICdkZWZsaW5rJyBu
b3QgYWN0dWFsbHkNCidsaW5rcycgdGhhdCBpcyB0aGUgbmV4dCBtYWluIHdvcmsgd2UgYXJlIGRv
aW5nLiANCg0KPiANCj4gDQo+IEFuZCBzb3JyeSBhYm91dCB0aGUgbG9ja2luZyBidWchIE5vdCBz
dXJlIGhvdyB0aGF0IGhhcHBlbmVkIDooDQo+IA0KDQpJIHdpbGwgc2VuZCBhIHBhdGNoIHRvIGZp
eCBsb2NraW5nIGFoZWFkLiANCg0KUGluZy1LZQ0KDQo=

