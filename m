Return-Path: <linux-wireless+bounces-5131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DBC886599
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 04:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126B81F234AD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 03:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDE14436;
	Fri, 22 Mar 2024 03:42:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141F23C39
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078940; cv=none; b=tqHqxU7AH0G4tJaFRLq+9zBnETDOarJLcQrGuclj5K4xNSoYI91yRu1NT3xKdNaATxr/3qrstqZp+QI5NkqYeUe6HNunFZyuUjMSuir3dMK6TqI0zHuZu5Q5RUMDEInhg488Cyt4yGx3+PrIVjCGYDfRW3lmP9M6zh3G3AyR2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078940; c=relaxed/simple;
	bh=VEhDY3Vfo2yIbEY4MoYg8eJN2nefZy64exRe8HBm3d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lJFZP/xuBGF/HtFDMU2IZXWJS3hycw9qknTDbgZZPNco6/CHESg20BRtS10eDA0MkfIiVtrEskGOi1JgWQl1fhl/7DUQEOTzlDaisbc48MNtTz63IqL3HMCrERFPpDykVCZn/k5WuA9RyxKNhzYTVDATquDz9zCkftZC9rGk+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42M3fnI331442500, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42M3fnI331442500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 11:41:49 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 11:41:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 11:41:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 22 Mar 2024 11:41:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 03/12] wifi: rtlwifi: Adjust rtl8192d-common for USB
Thread-Topic: [PATCH v3 03/12] wifi: rtlwifi: Adjust rtl8192d-common for USB
Thread-Index: AQHaev3SeoTb6VVh0UuBmXNZGG2U87FCmVmA
Date: Fri, 22 Mar 2024 03:41:49 +0000
Message-ID: <ab39def7264f89834911b1e06bbf18251f19da66.camel@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	 <99401b5f-7092-43ff-962f-20a53bb53981@gmail.com>
In-Reply-To: <99401b5f-7092-43ff-962f-20a53bb53981@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <016EF0AC0F39404C96E057769A038258@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTAzLTIwIGF0IDIxOjM1ICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gQSBmZXcgb2YgdGhlIHNoYXJlZCBmdW5jdGlvbnMgbmVlZCBzbWFsbCBjaGFuZ2Vz
IGZvciB0aGUgVVNCIGRyaXZlci4NCj4gDQo+IEFsc28sIGFkZCBhIGZldyBtYWNyb3MgdG8gd2lm
aS5oIGFuZCBpbml0aWFsaXNlIHJ0bGhhbC5pbnRlcmZhY2VpbmRleA0KPiBmb3IgVVNCIGRldmlj
ZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUy
QGdtYWlsLmNvbT4NCj4gLS0tDQo+IHYzOg0KPiAgLSBTaWxlbmNlIHNwYXJzZSB3YXJuaW5ncyBh
Ym91dCBsb2NrcyBpbiBwaHlfY29tbW9uLmMgYnkgdXNpbmcgaGVscGVyDQo+ICAgIGZ1bmN0aW9u
cyBfcnRsOTJkX3BjaV9sb2NrKCkgYW5kIF9ydGw5MmRfcGNpX3VubG9jaygpLg0KDQpjaGVja3Bh
dGNoLnBsIHdhcm5zIHRoaXMsIHNvIHBsZWFzZSBtb3ZlIHRoZW0gdG8gcGh5X2NvbW1vbi5oLg0K
DQpXQVJOSU5HOiBleHRlcm5zIHNob3VsZCBiZSBhdm9pZGVkIGluIC5jIGZpbGVzDQojMjQzOiBG
SUxFOiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmQvcGh5X2Nv
bW1vbi5jOjEwMDoNCit2b2lkIF9ydGw5MmRfcGNpX3VubG9jayhzdHJ1Y3QgcnRsX3ByaXYgKnJ0
bHByaXYpOw0KDQoNCj4gQEAgLTg1OCw3ICs4NzYsNyBAQCBzdGF0aWMgdm9pZCBydGw5MmRlX3Vw
ZGF0ZV9oYWxfcmF0ZV9tYXNrKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEgOiAwOw0KPiAg
ICAgICAgIGVudW0gd2lyZWxlc3NfbW9kZSB3aXJlbGVzc21vZGUgPSAwOw0KPiAgICAgICAgIGJv
b2wgc2hvcnRnaSA9IGZhbHNlOw0KPiAtICAgICAgIHUzMiB2YWx1ZVsyXTsNCj4gKyAgICAgICBz
dHJ1Y3QgcnRsOTJkX3JhdGVfbWFza19oMmMgcmF0ZV9tYXNrOw0KDQpLZWVwIHJldmVyc2UgWCdt
YXMgYXMgcG9zc2libGUgYXMgeW91IGNhbi4gDQpJIG1lYW4gZG9uJ3QgbmVlZCB0byB0b3VjaCBv
dGhlcnMsIGJ1dCBzdGlsbCBrZWVwIHRoaXMgbmV3IGRlY2xhcmF0aW9uIGluIA0KcmV2ZXJzZSBY
J21hcyBvcmRlci4NCg0KPiAgICAgICAgIHU4IG1hY2lkID0gMDsNCj4gICAgICAgICB1OCBtaW1v
X3BzID0gSUVFRTgwMjExX1NNUFNfT0ZGOw0KPiANCj4gQEAgLTk2NiwxMiArOTg0LDIwIEBAIHN0
YXRpYyB2b2lkIHJ0bDkyZGVfdXBkYXRlX2hhbF9yYXRlX21hc2soc3RydWN0IGllZWU4MDIxMV9o
dyAqaHcsDQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgICB9DQo+IA0KPiAtICAg
ICAgIHZhbHVlWzBdID0gKHJhdHJfYml0bWFwICYgMHgwZmZmZmZmZikgfCAocmF0cl9pbmRleCA8
PCAyOCk7DQo+IC0gICAgICAgdmFsdWVbMV0gPSBtYWNpZCB8IChzaG9ydGdpID8gMHgyMCA6IDB4
MDApIHwgMHg4MDsNCj4gKyAgICAgICBsZTMycF9yZXBsYWNlX2JpdHMoJnJhdGVfbWFzay5yYXRl
X21hc2tfYW5kX3JhaWQsIHJhdHJfYml0bWFwLCBSQVRFX01BU0tfTUFTSyk7DQo+ICsgICAgICAg
bGUzMnBfcmVwbGFjZV9iaXRzKCZyYXRlX21hc2sucmF0ZV9tYXNrX2FuZF9yYWlkLCByYXRyX2lu
ZGV4LCBSQUlEX01BU0spOw0KPiArICAgICAgIHU4cF9yZXBsYWNlX2JpdHMoJnJhdGVfbWFzay5t
YWNpZF9hbmRfc2hvcnRfZ2ksIG1hY2lkLCBNQUNJRF9NQVNLKTsNCj4gKyAgICAgICB1OHBfcmVw
bGFjZV9iaXRzKCZyYXRlX21hc2subWFjaWRfYW5kX3Nob3J0X2dpLCBzaG9ydGdpLCBTSE9SVF9H
SV9NQVNLKTsNCj4gKyAgICAgICB1OHBfcmVwbGFjZV9iaXRzKCZyYXRlX21hc2subWFjaWRfYW5k
X3Nob3J0X2dpLCAxLCBCSVQoNykpOw0KDQpHb29kLCB0aGF0IGxvb2tzIG11Y2ggYmVhdXRpZnVs
LiA6KQ0KDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRs
d2lmaS9ydGw4MTkyZC9waHlfY29tbW9uLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0bHdpZmkvcnRsODE5MmQvcGh5X2NvbW1vbi5jDQo+IGluZGV4IGY3MjY1NzEyYjljMi4u
ZTBlNDkxN2Y4ZTFlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0bHdpZmkvcnRsODE5MmQvcGh5X2NvbW1vbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTkyZC9waHlfY29tbW9uLmMNCj4gQEAgLTgxLDYgKzgx
LDI0IEBAIHN0YXRpYyB2b2lkIF9ydGw5MmRfcGh5X3JmX3NlcmlhbF93cml0ZShzdHJ1Y3QgaWVl
ZTgwMjExX2h3ICpodywNCj4gICAgICAgICAgICAgICAgIHJmcGF0aCwgcHBoeXJlZy0+cmYzd2ly
ZV9vZmZzZXQsIGRhdGFfYW5kX2FkZHIpOw0KPiAgfQ0KPiANCj4gKy8qIFdpdGhvdXQgdGhlc2Ug
aGVscGVycyBhbmQgdGhlIGRlY2xhcmF0aW9ucyBzcGFyc2Ugd2FybnMgYWJvdXQNCj4gKyAqIGNv
bnRleHQgaW1iYWxhbmNlLg0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgX3J0bDkyZF9w
Y2lfbG9jayhzdHJ1Y3QgcnRsX3ByaXYgKnJ0bHByaXYpDQo+ICt7DQo+ICsgICAgICAgaWYgKHJ0
bHByaXYtPnJ0bGhhbC5pbnRlcmZhY2UgPT0gSU5URl9QQ0kpDQo+ICsgICAgICAgICAgICAgICBz
cGluX2xvY2soJnJ0bHByaXYtPmxvY2tzLnJmX2xvY2spOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMg
aW5saW5lIHZvaWQgX3J0bDkyZF9wY2lfdW5sb2NrKHN0cnVjdCBydGxfcHJpdiAqcnRscHJpdikN
Cj4gK3sNCj4gKyAgICAgICBpZiAocnRscHJpdi0+cnRsaGFsLmludGVyZmFjZSA9PSBJTlRGX1BD
SSkNCj4gKyAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZydGxwcml2LT5sb2Nrcy5yZl9sb2Nr
KTsNCj4gK30NCj4gKw0KPiArdm9pZCBfcnRsOTJkX3BjaV9sb2NrKHN0cnVjdCBydGxfcHJpdiAq
cnRscHJpdik7DQo+ICt2b2lkIF9ydGw5MmRfcGNpX3VubG9jayhzdHJ1Y3QgcnRsX3ByaXYgKnJ0
bHByaXYpOw0KDQpBcyBtZW50aW9uZWQgYWJvdmUsIHBsZWFzZSBtb3ZlIHRoZXNlIHRvIC5oIGZp
bGUuDQoNCg0K

