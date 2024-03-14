Return-Path: <linux-wireless+bounces-4720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA9187B618
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 02:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CF8285DCB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 01:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7B84A0F;
	Thu, 14 Mar 2024 01:20:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9394A08
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710379234; cv=none; b=f27pgUOvJ7mYAGxwvtW+p9yftZTEdM0DRi1g0nct2iHszmkUzMzwPuiYb+qg7DCIc/jzPZahlTZUfxZQCi9joUod+5ugmcPJb8zea3CIHz4swO9ceHIWvuskJSTqnugRl8JTcj9u/czMc5zApva4TePP6BtxKiEFRRl+QF2ZR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710379234; c=relaxed/simple;
	bh=Wjp3opTPtLne8ub46CupP0UX0moijXdWBrdVx9Z5UiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b7p0ftRhCNADGVFNJQI8orTQZ3qBxQCB1JNdYaSdOm7+zGz0mv6zQxLxRIjF0TI6s4s1/0B3phIJE4B/7vvIhsAb/kFJ/Hly2Dsi03k4hV0ZnxOLj5dyfbHy0KRuQwr21E1vpcbBDArle6Q50dPjdpkw4MAGir5mYsdYqiG1neg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42E1K68s81067549, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42E1K68s81067549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 09:20:06 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 09:20:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 09:20:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 14 Mar 2024 09:20:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH 2/3] wifi: rtlwifi: Adjust rtl8192d-common for USB
Thread-Topic: [PATCH 2/3] wifi: rtlwifi: Adjust rtl8192d-common for USB
Thread-Index: AQHadMuOOO7rHmATSEu0OX4oEjo6i7E0gg8AgAE/E4CAACplgA==
Date: Thu, 14 Mar 2024 01:20:06 +0000
Message-ID: <f07686170eed48c21f18ce2850ffde4401c25bf5.camel@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	 <d70dc39c-a3e5-43f6-9cb4-612d08035c57@gmail.com>
	 <fdd95844c3a127356bab4250dfc46b16041829ee.camel@realtek.com>
	 <a674d357-c917-413a-a4fb-1ee22f43d9ff@gmail.com>
In-Reply-To: <a674d357-c917-413a-a4fb-1ee22f43d9ff@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <E769770C287EEF478E645BD623C26934@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTAzLTE0IGF0IDAwOjQ3ICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gT24gMTMvMDMvMjAyNCAwNTo0NiwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IE9u
IFdlZCwgMjAyNC0wMy0xMyBhdCAwMDoyMCArMDIwMCwgQml0dGVyYmx1ZSBTbWl0aCB3cm90ZToN
Cj4gPiA+IA0KPiA+ID4gQEAgLTk2NiwxMiArOTgwLDE3IEBAIHN0YXRpYyB2b2lkIHJ0bDkyZGVf
dXBkYXRlX2hhbF9yYXRlX21hc2soc3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQo+ID4gPiAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiAgICAgICAgIH0NCj4gPiA+IA0KPiA+ID4gLSAgICAg
ICB2YWx1ZVswXSA9IChyYXRyX2JpdG1hcCAmIDB4MGZmZmZmZmYpIHwgKHJhdHJfaW5kZXggPDwg
MjgpOw0KPiA+ID4gLSAgICAgICB2YWx1ZVsxXSA9IG1hY2lkIHwgKHNob3J0Z2kgPyAweDIwIDog
MHgwMCkgfCAweDgwOw0KPiA+ID4gKyAgICAgICAqKHUzMiAqKSZyYXRlX21hc2sgPSAocmF0cl9i
aXRtYXAgJiAweDBmZmZmZmZmKSB8DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKHJhdHJfaW5kZXggPDwgMjgpOw0KPiA+IA0KPiA+ICd1MzInIGlzIHdlaXJkIHRv
IG1lLiBTaG91bGRuJ3QgaXQgYmUgX19sZTMyPw0KPiA+IEJ1dCBJIHByZWZlciBhIHN0cnVjdCBv
ZiByYXRlX21hc2suDQo+ID4gDQo+IA0KPiBJIGRvbid0IGxpa2UgdGhpcyBlaXRoZXIsIGJ1dCBp
dCB3YXMgZWFzeSB0byBjb3B5IGZyb20gcnRsODE5MmN1Lg0KPiANCj4gU29tZXRoaW5nIGxpa2Ug
dGhpcz8NCj4gDQo+ICNkZWZpbmUgUkFJRF9NQVNLICAgICAgICAgICAgICAgR0VOTUFTSygzMSwg
MjgpDQo+ICNkZWZpbmUgUkFURV9NQVNLX01BU0sgICAgICAgICAgR0VOTUFTSygyNywgMCkNCj4g
I2RlZmluZSBTSE9SVF9HSV9NQVNLICAgICAgICAgICBCSVQoNSkNCj4gI2RlZmluZSBNQUNJRF9N
QVNLICAgICAgICAgICAgICBHRU5NQVNLKDQsIDApDQo+IA0KPiBzdHJ1Y3QgcnRsOTJkX3JhdGVf
bWFzayB7DQo+ICAgICAgICAgX19sZTMyIHJhdGVfbWFza19hbmRfcmFpZDsNCj4gICAgICAgICB1
OCBtYWNpZF9hbmRfc2hvcnRfZ2k7DQo+IH0gX19wYWNrZWQ7DQoNClllcywgc29tZXRoaW5nIGxp
a2UgdGhhdCwgYnV0IHN0cnVjdCBzaXplIHNob3VsZCBiZSA1Lg0KDQo+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkL3BoeV9jb21t
b24uYw0KPiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5
MmQvcGh5X2NvbW1vbi5jDQo+ID4gPiBpbmRleCA0ODc2MjhhYzQ5MWIuLjFlMzk5NDBhM2JhNyAx
MDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9y
dGw4MTkyZC9waHlfY29tbW9uLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnRsd2lmaS9ydGw4MTkyZC9waHlfY29tbW9uLmMNCj4gPiA+IEBAIC04MSwxMSArODEs
MTMgQEAgdTMyIHJ0bDkyZF9waHlfcXVlcnlfcmZfcmVnKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
LCBlbnVtIHJhZGlvX3BhdGgNCj4gPiA+IHJmcGF0aCwNCj4gPiA+ICAgICAgICAgcnRsX2RiZyhy
dGxwcml2LCBDT01QX1JGLCBEQkdfVFJBQ0UsDQo+ID4gPiAgICAgICAgICAgICAgICAgInJlZ2Fk
ZHIoJSN4KSwgcmZwYXRoKCUjeCksIGJpdG1hc2soJSN4KVxuIiwNCj4gPiA+ICAgICAgICAgICAg
ICAgICByZWdhZGRyLCByZnBhdGgsIGJpdG1hc2spOw0KPiA+ID4gLSAgICAgICBzcGluX2xvY2so
JnJ0bHByaXYtPmxvY2tzLnJmX2xvY2spOw0KPiA+ID4gKyAgICAgICBpZiAocnRscHJpdi0+cnRs
aGFsLmludGVyZmFjZSA9PSBJTlRGX1BDSSkNCj4gPiA+ICsgICAgICAgICAgICAgICBzcGluX2xv
Y2soJnJ0bHByaXYtPmxvY2tzLnJmX2xvY2spOw0KPiA+IA0KPiA+IERvZXMgaXQgbWVhbiBVU0Ig
bmV2ZXIgcmVhZC93cml0ZSBSRiByZWdpc3RlcnMgc2ltdWx0YW5lb3VzbHk/IEhvdyBjYW4geW91
DQo+ID4gZW5zdXJlIHRoYXQ/DQo+ID4gDQo+IA0KPiBJIGRvbid0IGtub3cuIEl0IHNlZW1zIHRv
IHdvcmsgZmluZS4gVGhlIG91dC1vZi10cmVlIGRyaXZlcg0KPiBkb2Vzbid0IGhhdmUgbG9ja3Mg
aGVyZToNCj4gaHR0cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0bDgxOTJkdS9ibG9iLzJjNTQ1
MGRkMzc4M2UxMDg1ZjA5YThjN2E2MzIzMThjN2QwZjFkMzkvaGFsL3J0bDgxOTJkX3BoeWNmZy5j
I0w2MzcNCj4gDQo+IHJ0bDh4eHh1IGFuZCBydGw4MTkyY3UgZG9uJ3QgaGF2ZSBsb2NrcyBlaXRo
ZXIuDQoNCk5vdCBzdXJlIGlmIHJhY2UgY29uZGl0aW9uIGlzIGV4aXN0aW5nIHRvIHJlYWQvd3Jp
dGUgUkYgcmVnaXN0ZXJzLCBidXQNCm5vIGlkZWEgdG8gZGlnIHRoZSBwcm9ibGVtLiBNYXliZSwg
Y3VycmVudCBjb2RlIGhhcyBubyBwcm9ibGVtIHRob3VnaC4NCkF0IGxlYXN0LCB5b3VyIG5ld2x5
IGNoYW5nZXMgZG9uJ3QgYWZmZWN0IG9yaWdpbmFsIFBDSSBiZWhhdmlvciwgcmlnaHQ/DQoNCg0K
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS91
c2IuYw0KPiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvdXNiLmMN
Cj4gPiA+IGluZGV4IDZlOGM4N2EyZmFlNC4uMmVhNzJkOWUzOTU3IDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3VzYi5jDQo+ID4gPiArKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvdXNiLmMNCj4gPiA+IEBAIC05
NzksNiArOTc5LDkgQEAgaW50IHJ0bF91c2JfcHJvYmUoc3RydWN0IHVzYl9pbnRlcmZhY2UgKmlu
dGYsDQo+ID4gPiAgICAgICAgIHVzYl9wcml2LT5kZXYuaW50ZiA9IGludGY7DQo+ID4gPiAgICAg
ICAgIHVzYl9wcml2LT5kZXYudWRldiA9IHVkZXY7DQo+ID4gPiAgICAgICAgIHVzYl9zZXRfaW50
ZmRhdGEoaW50ZiwgaHcpOw0KPiA+ID4gKyAgICAgICAvKiBGb3IgZHVhbCBNQUMgUlRMODE5MkRV
LCB3aGljaCBoYXMgdHdvIGludGVyZmFjZXMuICovDQo+ID4gPiArICAgICAgIHJ0bHByaXYtPnJ0
bGhhbC5pbnRlcmZhY2VpbmRleCA9DQo+ID4gPiArICAgICAgICAgICAgICAgaW50Zi0+YWx0c2V0
dGluZ1swXS5kZXNjLmJJbnRlcmZhY2VOdW1iZXI7DQo+ID4gDQo+ID4gU28sIHlvdSB3aWxsIHNl
ZSB0d28gVVNCIGFkYXB0ZXJzIHdoZW4geW91IHBsdWcgODE5MkRVPw0KPiA+IA0KPiANCj4gV2hl
biB5b3UgcGx1ZyB0aGUgZHVhbCBNQUMgdmVyc2lvbiwgbHN1c2Igd2lsbCBzaG93IG9uZSBkZXZp
Y2UsDQo+IHdpdGggdHdvIGludGVyZmFjZXMuIHJ0bF91c2JfcHJvYmUoKSBpcyBjYWxsZWQgdHdp
Y2UuIFRoaXMgaXMNCj4gY29waWVkIGZyb20gbGludXgtaGFyZHdhcmUub3JnOg0KPiANCj4gTWlu
ZSBpcyB0aGUgc2luZ2xlIE1BQyB2ZXJzaW9uOg0KPiANCg0KRG9lcyBpdCBtZWFuIHlvdSBvbmx5
IHRlc3RlZCBzaW5nbGUgTUFDIHZlcnNpb24/IEJ1dCwgeW91ciBjb2RlIHdpbGwgc3VwcG9ydA0K
dHdvIE1BQyB2ZXJzaW9uLCByaWdodD8NCg0KDQo=

