Return-Path: <linux-wireless+bounces-26111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB03B199DC
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 03:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AED13B36AF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 01:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3D83BBC9;
	Mon,  4 Aug 2025 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YEtBxdH/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559B2E36EB;
	Mon,  4 Aug 2025 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271102; cv=none; b=Xzic4PEj7DmukAXFCNvAAiJ4Kw4t10/j0I7BpyFbLIU3Jxz5yVhO6WPFcRHOhvSutRmuyAKo014I7US5KWnXqhe9IycNBPoY+hmAnJ3d/1C9ze3/7KJn1CocRSSWupnHauJSEbEADfvaZVAiOG8kgdEgoFjsEqW2eXnEJwJUEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271102; c=relaxed/simple;
	bh=2fJypLNpuBGCefgA+I2qla/IoTGIEsxZufI5buVScBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D1vt0LHZiY9lTVeyFBy8L6qcL1pbQ/khD1jx/ZNozaQSccc+IWRD/Y7jXl4afKLIn+vBVS1oiLZKbUkrmC5OxEUJ9FRIudQzSjMPBRrUMb9DNbOyqv6OQM6sTgktpJiQKREhebDR5p3b+l3HPO21LZKrF71PH3d0DAPpBrcll7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YEtBxdH/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5741VVFT03195138, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754271091; bh=2fJypLNpuBGCefgA+I2qla/IoTGIEsxZufI5buVScBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YEtBxdH/XLmguBMg5pZYUqGxjtsX+PK4pft7AU1GDctGJbUfGYrBfHlQKT5wW2ufV
	 Ke+XVmUpTi1/4j5QnM5g0Yb+/tNljd6tvM662jnOkGWUEkkPsyf/N/82ve9rKCCWvO
	 ou8PgSaUkw5cZzZGtKQ/K4hOX5hwAvmrev9SHN5ubzbYvRZH+nCFtYZfGfIKBEfy5E
	 kGECWs1tGq8Oh79MaEy24DvI/LSjQlyrpUmDDzXrQkX3DXzMimhkA3A6TU/PK4iBlZ
	 vXrkHSYTXGLf5zzqI66jVMSb4R1oW2m8K8VI3GkaCU6Jp91Y7tYHWb4JA4DS5ujxj2
	 0s+LYInl+G2vA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5741VVFT03195138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 09:31:31 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 09:31:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 09:31:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Mon, 4 Aug 2025 09:31:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sean Anderson <sean.anderson@linux.dev>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bitterblue
 Smith" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Thread-Topic: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Thread-Index: AQHcANxb3F/NWj2ltUS/9AXHQ44SQ7RJzkeggAJapQCAAMhRwIAAayaAgARfuIA=
Date: Mon, 4 Aug 2025 01:31:31 +0000
Message-ID: <639b56c577a0433cb49c85ce0abd5dca@realtek.com>
References: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
 <20250729204437.164320-1-sean.anderson@linux.dev>
 <c034d5cc40784bfa859f918806c567de@realtek.com>
 <7865d95f-a92e-405d-bc71-f1e1382ad24c@linux.dev>
 <d0f6162ab34440cab0c11667be092609@realtek.com>
 <198e2e23-5e75-4223-8d85-fba255bc7fd2@linux.dev>
In-Reply-To: <198e2e23-5e75-4223-8d85-fba255bc7fd2@linux.dev>
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

U2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+IHdyb3RlOg0KPiBPbiA3LzMx
LzI1IDIwOjMwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gU2VhbiBBbmRlcnNvbiA8c2Vhbi5h
bmRlcnNvbkBsaW51eC5kZXY+IHdyb3RlOg0KPiA+PiBPbiA3LzI5LzI1IDIwOjM2LCBQaW5nLUtl
IFNoaWggd3JvdGU6DQo+ID4+ID4gU2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5k
ZXY+IHdyb3RlOg0KPiA+PiA+PiBUaGVyZSBhcmUgbW9yZSB1bnN1cHBvcnRlZCBmdW5jdGlvbnMg
dGhhbiBqdXN0IExPV1JUX1JUWS4gSW1wcm92ZSBvbg0KPiA+PiA+PiBjb21taXQgM2I2NjUxOWIw
MjNiICgid2lmaTogcnR3ODk6IHBoeTogYWRkIGR1bW15IGMyaCBoYW5kbGVyIHRvIGF2b2lkDQo+
ID4+ID4+IHdhcm5pbmcgbWVzc2FnZSIpIGJ5IHByaW50aW5nIGEgbWVzc2FnZSBqdXN0IG9uY2Ug
d2hlbiB3ZSBmaXJzdA0KPiA+PiA+PiBlbmNvdW50ZXIgYW4gdW5zdXBwb3J0ZWQgY2xhc3MuDQo+
ID4+ID4NCj4gPj4gPiBPbmNlIEkgZW5jb3VudGVyIGFuIHVuc3VwcG9ydGVkIGNsYXNzL2Z1bmMs
IEknbGwgY2hlY2sgZmlybXdhcmUgdGVhbSBpZiB0aGUNCj4gPj4gPiBDMkggZXZlbnRzIGNhbiBi
ZSBpZ25vcmVkLiBJZiBzbywgSSBhZGQgYSBkdW1teSBmdW5jdGlvbiB0byBhdm9pZCB0aGUgbWVz
c2FnZS4NCj4gPj4gPiBJZiBub3QsIEkgc2hvdWxkIGFkZCBjb2RlIHRvIGhhbmRsZSB0aGUgZXZl
bnQuDQo+ID4+ID4NCj4gPj4gPiBEbyB5b3Ugd2FudCB0byBzZWUgdGhlIG1lc3NhZ2UgZXZlbiB0
aG91Z2ggaXQgb25seSBhcHBlYXJzIG9uY2U/DQo+ID4+DQo+ID4+IEkgbWVhbiwgbWF5YmUgaXQg
c2hvdWxkIGp1c3QgYmUgYSBkZWJ1Zz8gQXJlIHRoZXNlIG1lc3NhZ2VzIHVzZWZ1bCBmb3IgYW55
b25lDQo+ID4+IG90aGVyIHRoYW4gdGhlIGRldmVsb3BlcnM/DQo+ID4NCj4gPiBZZXMsIHRoaXMg
Y291bGQganVzdCBiZSBhIGRlYnVnLiBIb3dldmVyLCBkZXZlbG9wZXJzIG5vcm1hbGx5IGRvbid0
IHR1cm4gb24NCj4gPiBkZWJ1ZyBtYXNrLCBzbyB1c2luZyBydHc4OV9pbmZvIGlzIHRvIGNsZWFy
bHkgcmVtaW5kIGRldmVsb3BlcnMgdG8gcGF5DQo+ID4gYXR0ZW50aW9uIG9uIHRoaXMgbGFjayBv
ZiBDMkggaGFuZGxlci4gQW5kLCBJIHN1cHBvc2UgZGV2ZWxvcGVycyBtdXN0IGhhbmRsZQ0KPiA+
IHRoaXMgd2hlbiB0aGV5IHNlZSBmbG9vZGluZyBtZXNzYWdlcy4NCj4gDQo+IFdlbGwsIHJlZ3Vs
YXIgdXNlcnMgZ2V0IHRoaXMgdG9vLiBJdCBpcyByZWFsbHkgdW5uZWNlc3NhcnkgdG8gcHJpbnQN
Cj4gdGhvdXNhbmRzIG9mIG1lc3NhZ2VzIHdoZW4gdGhleSBhcmUgY29tcGxldGVseSBiZW5pZ24u
DQo+IA0KPiA+Pg0KPiA+PiBNYXliZSB3ZSBzaG91bGQganVzdCBwcmludCBvbmx5IHRoZSB2ZXJ5
IGZpcnN0IHVuc3VwcG9ydGVkIG1lc3NhZ2UgYXQgaW5mbyBsZXZlbA0KPiA+PiBhbmQgcHJpbnQg
dGhlIHJlc3QgYXQgZGVidWcuDQo+ID4NCj4gPiBJJ20gYWZyYWlkIGRldmVsb3BlcnMgd2lsbCBp
Z25vcmUgb3IgbWlzcyB0aGUgbWVzc2FnZXMuIFRvIHJlZHVjZSBtZXNzYWdlcw0KPiA+IGlzIGZp
bmUgdG8gbWUgLCBidXQgbW9yZSBpbXBvcnRhbnQgaXMgdG8gbG9vayB1cCB2ZW5kb3IgZHJpdmVy
IHRvIHNlZSBpZg0KPiA+IHRoZSBDMkggaGFuZGxlciBpcyBuZWNlc3NhcnkuDQo+IA0KPiBPSywg
c28gd2Ugc2hvdWxkIHByaW50IGV4YWN0bHkgb25jZSBmb3IgZWFjaCBjbGFzcy9mdW5jLg0KPiAN
Cg0KSSBzZW50IGEgcGF0Y2hzZXQgWzFdIHRvIHByaW50IGV4YWN0bHkgb25jZSwgYnV0IEkgZG9u
J3QgYWRkIGJpdG1hcCBmb3IgZXZlcnkNCnByaW50ZWQgY2xhc3MvZnVuYywgYmVjYXVzZSBpdCBz
ZWVtcyB0byBiZSB1bm5lY2Vzc2FyeSB0byBhZGQgbXVjaCBjb2RlIHRvIA0KaGFuZGxlIHRoZSBj
YXNlIHdoaWNoIHNob3VsZCBiZSBoYW5kbGVkIGR1cmluZyBkZXZlbG9wbWVudC4gDQoNClBsZWFz
ZSBoZWxwIHRvIHRyeSBpZiB0aGlzIHBhdGNoc2V0IGNhbiByZXNvbHZlIHRob3VzYW5kcyBvZiBt
ZXNzYWdlIGluIHlvdXINCnNpZGUuIA0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtd2lyZWxlc3MvMjAyNTA4MDQwMTIyMzQuODkxMy0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyN0
DQoNCg==

