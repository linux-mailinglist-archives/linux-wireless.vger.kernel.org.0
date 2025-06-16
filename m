Return-Path: <linux-wireless+bounces-24116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B0CADA648
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 04:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5603A9FEB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 02:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1B62E40E;
	Mon, 16 Jun 2025 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IdzspJ+i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C3723A6
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750040484; cv=none; b=p9l9UbNs+yV5K7i8yZmujafD0EmNieZDRuSZ8CALiz1aHNfiRWq5PJWAjp8KRU72KL/GXjWrMXCZCAWBDwaJ4tFPIYFHj4buvV7RSqqt5IG9voB5Ih3OqQt+j4BN2pNW/FjLnIXejjb2jjrNK+ZFgB2qXhJZZMAI2xEM2/z4ukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750040484; c=relaxed/simple;
	bh=nAcjZsHDnEwSCOZvxJB3bWF2GqQeUtzPG17gzhFiMY8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M4Z9JQvCV3PG9vzwC0kZjYbzLl2gMU5s4jIHdXlFk7QsdAZ8RzhPxZCm/3IALdUsEpBO834Vs5WHN92IHYBYafUFMKvvFOVi2pYRRzex/j1GeS9ktXoYtzbSkwrrudsIQ59PIRH9HoZHAwZSM8T8pVaTuL87LisUkF4xBK2fPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IdzspJ+i; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G2LI4N03901826, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750040478; bh=nAcjZsHDnEwSCOZvxJB3bWF2GqQeUtzPG17gzhFiMY8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IdzspJ+ipOCjnXCjU0AWZxgP0vgE0HdhNSEWVy7l9TB8/gx3r/s8jnGVRg7H4+kWg
	 GSW7QTRnJ95cB4JpnC1IND3IkHtEVsX3o6G1vYQJb1qA28hV4lTNjfuWphQKgaxlTs
	 dAghKYNUyon2Fn+CcXblZo6FKkcZ1Yhwa6Qn6B010aRPOZDMyYlsdLoy91RGrZHvHV
	 WgCA6wOEaTIW4NQ3JKzpTe7tj4mmW2v/XEwRKbJEuizrMCoR9yJE/6v29em7U733bV
	 JsOAHo3SAOCF2uj1WFSkRv+XutWxY123MpInYHIKloly9b0t4fJxshm5NeV0Tv9ND/
	 3XXdi2tg0gdnQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G2LI4N03901826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 10:21:18 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 10:21:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 10:21:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 16 Jun 2025 10:21:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 10/14] wifi: rtw89: Fix rtw89_mac_power_switch() for USB
Thread-Topic: [PATCH rtw-next v2 10/14] wifi: rtw89: Fix
 rtw89_mac_power_switch() for USB
Thread-Index: AQHb2XUJUFHxlychD0Giom8L3zftw7QFEI4g
Date: Mon, 16 Jun 2025 02:21:12 +0000
Message-ID: <efd3cb5f165748d6ba8429024ce2b03a@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <1faf699e-b40c-4408-8655-b5bc8a6776e1@gmail.com>
In-Reply-To: <1faf699e-b40c-4408-8655-b5bc8a6776e1@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBDbGVh
ciBzb21lIGJpdHMgaW4gc29tZSByZWdpc3RlcnMgaW4gb3JkZXIgdG8gYWxsb3cgUlRMODg1MUJV
IHRvIHBvd2VyDQo+IG9uLg0KDQpBcyB5b3VyIGRlc2NyaXB0aW9uLCBpdCBzaG91bGQgYmUgY2Fs
bGVkIHdoZW4gZ29pbmcgdG8gcG93ZXIgb24sIGJ1dCBjYWxsZWQNCmJ5IGJvdGggcG93ZXIgb24v
b2ZmLiANCg0KSG93ZXZlciB2ZW5kb3IgZHJpdmVyIGRpZCB0aGUgc2FtZSBhcyB5b3Vycy4gSSdk
IGtlZXAgaXQgYXMgd2FzLiBQbGVhc2UNCm1lbnRpb24gdGhpcyBiZWhhdmlvciBpcyBmcm9tIHZl
bmRvciBkcml2ZXIgaW4gY29tbWl0IG1lc3NhZ2UuIA0KDQo+IEFsc28gdGVzdGVkIHdpdGggUlRM
ODgzMkJVIGFuZCBSVEw4ODMyQ1UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAgLSBQdXQgdGhl
IG5ldyBjb2RlIGluIGEgZnVuY3Rpb24uDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OS9tYWMuYyB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3JlZy5oIHwgIDEgKw0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCAyMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvbWFjLmMNCj4gaW5kZXggODc1YzFhM2M1Y2E4Li5iY2NiNTA0OTE1ZjQgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KPiBAQCAtMTQ0OSw2ICsx
NDQ5LDI0IEBAIHZvaWQgcnR3ODlfbWFjX25vdGlmeV93YWtlKHN0cnVjdCBydHc4OV9kZXYgKnJ0
d2RldikNCj4gICAgICAgICBydHc4OV9tYWNfc2VuZF9ycHdtKHJ0d2Rldiwgc3RhdGUsIHRydWUp
Ow0KPiAgfQ0KPiANCj4gK3N0YXRpYyB2b2lkIHJ0dzg5X21hY19wb3dlcl9zd2l0Y2hfYm9vdF9t
b2RlKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldikNCj4gK3sNCj4gKyAgICAgICB1MzIgYm9vdF9t
b2RlOw0KPiArDQo+ICsgICAgICAgaWYgKHJ0d2Rldi0+aGNpLnR5cGUgIT0gUlRXODlfSENJX1RZ
UEVfVVNCKQ0KDQpJIGNoZWNrZWQgaW50ZXJuYWwgbG9nIHRoYXQgaW5pdGlhdG9yIG9mIHRoaXMg
Y2hhbmdlIGlzIGZvciBVU0IgZGV2aWNlcywgYnV0DQpub3QgY2hlY2sgdGhlIEhDSSB0eXBlIHRo
b3VnaC4gDQoNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKw0KPiArICAgICAgIGJvb3Rf
bW9kZSA9IHJ0dzg5X3JlYWQzMl9tYXNrKHJ0d2RldiwgUl9BWF9HUElPX01VWENGRywgQl9BWF9C
T09UX01PREUpOw0KPiArDQoNCk5vIGVtcHR5IGxpbmUgYmV0d2VlbiBhc3NpZ25tZW50IGFuZCBp
bW1lZGlhdGUgY2hlY2tpbmcuIA0KDQo+ICsgICAgICAgaWYgKCFib290X21vZGUpDQo+ICsgICAg
ICAgICAgICAgICByZXR1cm47DQo+ICsNCj4gKyAgICAgICBydHc4OV93cml0ZTMyX2NscihydHdk
ZXYsIFJfQVhfU1lTX1BXX0NUUkwsIEJfQVhfQVBGTl9PTk1BQyk7DQo+ICsgICAgICAgcnR3ODlf
d3JpdGUzMl9jbHIocnR3ZGV2LCBSX0FYX1NZU19TVEFUVVMxLCBCX0FYX0FVVE9fV0xQT04pOw0K
PiArICAgICAgIHJ0dzg5X3dyaXRlMzJfY2xyKHJ0d2RldiwgUl9BWF9HUElPX01VWENGRywgQl9B
WF9CT09UX01PREUpOw0KPiArICAgICAgIHJ0dzg5X3dyaXRlMzJfY2xyKHJ0d2RldiwgUl9BWF9S
U1ZfQ1RSTCwgQl9BWF9SX0RJU19QUlNUKTsNCj4gK30NCj4gKw0KDQoNCg==

