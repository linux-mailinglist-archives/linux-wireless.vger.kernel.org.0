Return-Path: <linux-wireless+bounces-5417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A9188F4DE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 02:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF591C27C66
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 01:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901FF1804A;
	Thu, 28 Mar 2024 01:47:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F72599
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 01:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590435; cv=none; b=bLB5OeGTI0M6wSVtLst9rGDoykyjrEqKY9roDu3oSFsKpwMOr3GEo8wsqpPeSwwKhz0yB2eNwRQEzS6iKXCVP0Gy9GEqR/SVklWnGgb2EkbJb+WKbG57fE8ZGWwvQbKA2OQqsYDWhXej7LIeYDUVpK2wfK9IY/mjfYJ6uI7GpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590435; c=relaxed/simple;
	bh=8FG+fxIpvzOEAb3K6SzjRz4n+UR3cIWonxSIFfpdhcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZD8NHQoWgRv0LpCMmz8w9j7t2+4Of5sk8siLYEqJE1Ct2rD7OTLCYK68ABGO2G0N8QSF/ZtIwZxferXpjeZpWtDRqia/ABO+Tlx6ZQXU6hL4VaG611+MhRFsPk8bqBbhAr4nLlw+5CZK4iIasLKNUCjKXqu1Z98dLTfJGO1tenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42S1kbZV31704150, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42S1kbZV31704150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 09:46:37 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 09:46:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 09:46:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Thu, 28 Mar 2024 09:46:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Topic: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Index: AQHaev7lVhGGoQ4nQ0GxbEPAiHfc3rFCwUMAgAhizQCAANTTI///vigAgAAwEwA=
Date: Thu, 28 Mar 2024 01:46:37 +0000
Message-ID: <4672072ef782ae1200886a190c740e0f3ccec2c8.camel@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
	 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
	 <66565618-3638-47e5-afe5-3530214da0c9@gmail.com>
	 <87ttkrzf1m.fsf@kernel.org>
	 <5696990a-4450-4d92-bbda-1d9ca3a9a619@gmail.com>
In-Reply-To: <5696990a-4450-4d92-bbda-1d9ca3a9a619@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C3E24EB811D8547BAB2B8159B09C956@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gVGh1LCAyMDI0LTAzLTI4IGF0IDAwOjUzICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gT24gMjcvMDMvMjAyNCAyMDo0OCwgS2FsbGUgVmFsbyB3cm90ZToNCj4gPiBCaXR0
ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JpdGVzOg0KPiA+IA0KPiA+
ID4gT24gMjIvMDMvMjAyNCAwODowNCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+ID4gPiBPbiBX
ZWQsIDIwMjQtMDMtMjAgYXQgMjE6NDMgKzAyMDAsIEJpdHRlcmJsdWUgU21pdGggd3JvdGU6DQo+
ID4gPiANCj4gPiA+IFsuLi5dDQo+ID4gPiANCj4gPiA+ID4gPiArREVGSU5FX01VVEVYKGdsb2Jh
bG11dGV4X3Bvd2VyKTsNCj4gPiA+ID4gPiArREVGSU5FX01VVEVYKGdsb2JhbG11dGV4X2Zvcl9m
d2Rvd25sb2FkKTsNCj4gPiA+ID4gPiArREVGSU5FX01VVEVYKGdsb2JhbG11dGV4X2Zvcl9wb3dl
cl9hbmRfZWZ1c2UpOw0KPiA+ID4gPiA+ICtERUZJTkVfTVVURVgoZ2xvYmFsbXV0ZXhfZm9yX21h
YzBfMmdfbWFjMV81Zyk7DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgY29uc3VtZXJzIG9mIGdsb2Jh
bG11dGV4X2Zvcl9tYWMwXzJnX21hYzFfNWcgYXJlIGNvbXBsZXguIFdoeSBkbyB0aGV5DQo+ID4g
PiA+IGNoZWNrIG11dGV4X2lzX2xvY2tlZCgpPyBSYWNlIGNvbmRpdGlvbnMgYmV0d2VlbiB0d28g
aW5zdGFuY2VzPw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gSSBjb3VsZG4ndCB0aGluayBvZiBh
IHN1ZmZpY2llbnRseSBzaG9ydCBuYW1lLCBsaWtlDQo+ID4gPiAibG9ja19tYWMwXzJnX21hYzFf
NWciLCBzbyBJIHVzZWQgbXV0ZXhfaXNfbG9ja2VkKCkuIFRoYXQncyBwcm9iYWJseQ0KPiA+ID4g
YSBiYWQgaWRlYS4gSXQgc2hvdWxkIGJlIGxpa2UgdGhpczoNCj4gPiA+IA0KPiA+ID4gICAgICAv
KiBMZXQgdGhlIGZpcnN0IHN0YXJ0aW5nIG1hYyBsb2FkIFJGIHBhcmFtZXRlcnMgYW5kIGRvIExD
SyAqLw0KPiA+ID4gICAgICBpZiAocnRsaGFsLT5tYWNwaHltb2RlID09IERVQUxNQUNfRFVBTFBI
WSAmJg0KPiA+ID4gICAgICAgICAgKChydGxoYWwtPmludGVyZmFjZWluZGV4ID09IDAgJiYgcnRs
aGFsLT5iYW5kc2V0ID09IEJBTkRfT05fMl80RykgfHwNCj4gPiA+ICAgICAgICAgICAocnRsaGFs
LT5pbnRlcmZhY2VpbmRleCA9PSAxICYmIHJ0bGhhbC0+YmFuZHNldCA9PSBCQU5EX09OXzVHKSkp
IHsNCj4gPiA+ICAgICAgICAgICAgICBtdXRleF9sb2NrKCZnbG9iYWxtdXRleF9mb3JfbWFjMF8y
Z19tYWMxXzVnKTsNCj4gPiA+ICAgICAgICAgICAgICBsb2NrX21hYzBfMmdfbWFjMV81ZyA9IHRy
dWU7DQo+ID4gPiAgICAgIH0NCg0KZ2xvYmFsbXV0ZXhfZm9yX21hYzBfMmdfbWFjMV81ZyBpcyBv
bmx5IHVzZWQgaW4gcnRsOTJkdV9od19pbml0KCksIGFuZA0KZ2xvYmFsbXV0ZXhfZm9yX3Bvd2Vy
X2FuZF9lZnVzZSBkb2VzIHZlcnkgc2ltaWxhciB0aGluZy4gQ2FuIHdlIGNvbWJpbmUgdGhlbQ0K
aW50byBvbmU/IFNpbmNlIGJvdGggYXJlIG9ubHkgdXNlZCBpbiBydGw5MmR1X2h3X2luaXQoKSwg
aXQgd291bGQgbm90IGJlIGENCnByb2JsZW0gdG8gZW5sYXJnZSB0aGVpciBjcml0aWNhbCBzZWN0
aW9uLiAgDQoNCg0KPiANCj4gKiBEdWFsIE1BQyBkdWFsIFBIWTogdGhpcyBJIGNhbid0IGZpbmQg
dG8gYnV5IGFueW1vcmUuIFRoaXMNCj4gYXBwZWFycyBpbiB0aGUgc3lzdGVtIGFzIHR3byBXaWZp
IGRldmljZXMsIGVhY2ggd29ya2luZyBvbg0KPiBhIGRpZmZlcmVudCBiYW5kLiBJdCBoYXMgdHdv
IFVTQiBpbnRlcmZhY2VzLiBUd28gaW5zdGFuY2VzDQo+IG9mIHRoZSBkcml2ZXIgYWNjZXNzIHRo
ZSBzYW1lIGRldmljZS4gVGhpcyBpcyB3aGF0IHRoZQ0KPiBtdXRleGVzIGFyZSBmb3IuDQoNCkkg
dHJhY2VkIHRoZSBjb2RlLCBhbmQgZm91bmQgcnVsZXMgb2YgdHdvIE1BQy9QSFkgYXJlOg0KMS4g
cmVhZCBlZnVzZSB0byBkZWNpZGUgc2luZ2xlIG9yIHR3byBNQUMvUEhZDQoyLjEuIGlmIHNpbmds
ZSBNQUMvUEhZLCByZWdpc3Rlcl9odyBhcyAyVDJSIChkb25lKQ0KMi4yLiBpZiBkdWFsIE1BQy9Q
SFkgKHRvIHN0ZXAgMykNCjMuIHJlYWQgaW50ZXJmYWNlIGluZGV4IChVU0I6IGZyb20gYkludGVy
ZmFjZU51bWJlcjsgUENJOiBmcm9tIFBDSSBvbmZpZ3VyZSBzcGFjZSkNCjQuIHJlZ2lzdGVyIGlu
dGVyZmFjZSBpbmRleCAwIGFzIDFUMVIgb24gNSBHSHogYmFuZCBvbmx5Lg0KICAgcmVnaXN0ZXIg
aW50ZXJmYWNlIGluZGV4IDEgYXMgMVQxUiBvbiAyIEdIeiBiYW5kIG9ubHkuDQoNClRoaXMgaXMg
dGhlIGNhc2UgdHdvIGluc3RhbmNlcyAobmV0ZGV2KSBhY2Nlc3Mgc2luZ2xlIG9uZSBoYXJkd2Fy
ZSBkZXZpY2UsDQpzbyBzZWVtaW5nbHkgaXQgaXMgaGFyZCB0byBhdm9pZCBnbG9iYWwgbG9ja3Mg
dG8gcHJldmVudCByYWNpbmcgYmV0d2VlbiB0aGVtLg0KQW4gYWx0ZXJuYXRpdmUgdGhvdWdodCBp
cyB0byBzdXBwb3J0IG9ubHkgc2luZ2xlIE1BQy9QSFksIGJ1dCBub3Qgc3VyZSBpZg0KZHJpdmVy
IGNhbiBvdmVycmlkZSBzZXR0aW5nIG9mIGVmdXNlIHRoYXQgcHJvZ3JhbW1lZCB0aGUgY2FyZCBh
cyB0d28gTUFDL1BIWS4NCg0KPiANCj4gSSBzYWlkIGVhcmxpZXIgdGhhdCBJIHRoaW5rIHR3byBk
ZXZpY2VzIGNhbiB3b3JrIGF0IHRoZSBzYW1lDQo+IHRpbWUsIGV2ZW4gd2l0aCB0aGUgZ2xvYmFs
IG11dGV4ZXMsIGJ1dCBub3cgSSByZW1lbWJlcmVkIHRoZXJlDQo+IGFyZSB0d28gbW9yZSBnbG9i
YWwgdmFyaWFibGVzOiBjdXJ2ZWluZGV4XzVnW10gYW5kDQo+IGN1cnZlaW5kZXhfMmdbXSBpbiBw
aHkuYy4gT25lIGRyaXZlciBpbnN0YW5jZSBmaWxscyBvbmUgYXJyYXkNCj4gZHVyaW5nIExDIGNh
bGlicmF0aW9uLCBidXQgdGhlIG90aGVyIGRyaXZlciBpbnN0YW5jZSByZWFkcw0KPiBmcm9tIHRo
ZSBhcnJheSB3aGVuIHN3aXRjaGluZyB0aGUgY2hhbm5lbC4gSWYgSSdtIHJlYWRpbmcgdGhpcw0K
PiByaWdodC4gU28gdHdvIGRldmljZXMgcGx1Z2dlZCBpbiBhdCB0aGUgc2FtZSB0aW1lIHByb2Jh
Ymx5DQo+IHdvbid0IHdvcmsgY29ycmVjdGx5Lg0KDQpUaGF0IHNob3VsZCBiZSBhIHByb2JsZW0u
IA0KDQo+IA0KPiBIb3cgY2FuIHlvdSBhdm9pZCB0aGlzIHdoZW4gdGhlIGhhcmR3YXJlIGlzIHRo
ZSB3YXkgaXQgaXM/DQo+IE15IG9uZSBpZGVhIGlzIHRvIGFkZCBhIGdsb2JhbCBtYXAgdG8gaG9s
ZCB0aGUgbXV0ZXhlcyBhbmQNCj4gYXJyYXlzLCB1c2luZyB0aGUgVVNCIHBvcnQgbnVtYmVyLCBl
dGMgYXMgdGhlIGtleS4NCg0KU2VlbWluZ2x5IHdlIG5lZWQgc29tZXRoaW5nIGxpa2UgcGVyIGRl
dmljZSBkYXRhLiANCg0KPiANCj4gPiBJJ20gc3RhcnRpbmcgdG8gd29uZGVyIGlmIGV4dGVuZGlu
ZyBydGx3aWZpIGlzIGFjdHVhbGx5IHRoZSByaWdodA0KPiA+IGFwcHJvYWNoLiBXZSBoYXZlIG1v
ZGVybiBkcml2ZXJzIGxpa2UgcnRsOHh4eHUsIHJ0dzg4IGV0Yy4gd2l0aCBiZXR0ZXINCj4gPiBk
ZXNpZ24uDQo+ID4gDQo+IA0KPiBJIHRoaW5rIGV4dGVuZGluZyBydGx3aWZpIGlzIHRoZSByaWdo
dCBhcHByb2FjaCB3aGVuIGl0IGFscmVhZHkNCj4gaGFzIG1vc3Qgb2YgdGhlIGNvZGUgbmVlZGVk
LiBJIHJlYWxseSBkb24ndCB3YW50IHRvIHJlaW52ZW50IHRoaXMNCj4gcGFydGljdWxhciB3aGVl
bC4gDQoNClJpZ2h0LCBidXQgaG9uZXN0bHkgcnRsd2lmaSBkaWQgYSBsb3Qgb2YgdHJpY2t5IHRo
aW5ncyB3ZSBjYW4ndCB1bmRlcnN0YW5kDQp0aGUgd2hvbGUgcGljdHVyZS4uLg0KDQoNCj4gSSBk
b24ndCB3YW50IHRvIGFkZCB0aGUgZHVhbCBNQUMgc3R1ZmYgdG8gcnRsOHh4eHUgb3IgcnR3ODgu
IA0KDQpJIGRvbid0IHdhbnQgdGhhdCBuZWl0aGVyLiANCg0KDQoNCg==

