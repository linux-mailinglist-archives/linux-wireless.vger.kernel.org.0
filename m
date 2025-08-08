Return-Path: <linux-wireless+bounces-26213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BB3B1E1DC
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 07:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17604563E2E
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 05:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFF6201033;
	Fri,  8 Aug 2025 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VMv1N4Vr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6961361
	for <linux-wireless@vger.kernel.org>; Fri,  8 Aug 2025 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632490; cv=none; b=L5d3uawepecIPJXCjTzdkuCVqUI6KteNXctsay7VzOL1/F7LY0j6n7Y2MOLakSvQxboLhjUtNWuJVwuJZOHQWDXQi6f3kJvGw0xH1oumeZ7zadASiVboGMsVMjluT6xk7rUTzDDqGtuxZs4PdL9YNziE/GV630MsnOhDH5BXobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632490; c=relaxed/simple;
	bh=WViiNF6E+8BEP6a2aMl4x8c5hvyghFtfEKeEDxDEWlQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cyP2matFY2ZVnf4xitmVgWpyhlb04zJ/Hv7RvmqoyG6kJ05N8BdcKhEINtAzWMsTBVJTt30UcYL0XpPflryRaet6x5Sqffymp4SBLwbXBo05Eu+wwa+7JgJoP1L2wm6/BLjwn9wqTmiRwaKbw1Swe9HvB2zPLwsylqdSmB1Q8b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VMv1N4Vr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5785shX732761209, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754632483; bh=WViiNF6E+8BEP6a2aMl4x8c5hvyghFtfEKeEDxDEWlQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VMv1N4Vrt8JYQ6ddHQ8Jv9d+16Tos4alLeFx5cqDpNbPFdNLtZrjlS4jpRTV2C9za
	 /4M0tW3AF0QgdZPnfT+48A/fx3w4t9lOlOX9FhTQ8DAasvEiArDFAVp4tLXEMcykTo
	 EmIKQ8P7ujNxNWtgg+lJ78wgpLdpYRRkwmT6OPG4DVh7vMm65QbmGZNDyPYP/Wd4Vw
	 DEDhE9yLEpyJAj66tX9UcsiLRIesHgdHpFCI51g9+M/KhpMmx+KFig5Np46prywDuU
	 wOXUMV28LKpVErsp8wdFNz9mh6RxXEyX0y8qfmP7jhKU1RCYaZsWD+8pbgBCf0tKJV
	 mymXeZP+vTFRQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5785shX732761209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 13:54:43 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 13:54:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 13:54:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Fri, 8 Aug 2025 13:54:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 02/11] wifi: rtw89: usb: Fix rtw89_usb_get_bulkout_id() for RTL8852CU
Thread-Topic: [PATCH rtw-next v2 02/11] wifi: rtw89: usb: Fix
 rtw89_usb_get_bulkout_id() for RTL8852CU
Thread-Index: AQHcAyY7W0HLM9gtq022c2iHA2nvzbRYSr7g
Date: Fri, 8 Aug 2025 05:54:43 +0000
Message-ID: <6e8f5326d25046fea5f2033bc6c9c5cb@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <3fcb3d66-4c01-4396-84b1-268bf4f0d2f6@gmail.com>
In-Reply-To: <3fcb3d66-4c01-4396-84b1-268bf4f0d2f6@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTZW50
OiBTYXR1cmRheSwgQXVndXN0IDIsIDIwMjUgNDo1MyBBTQ0KPiBSVEw4ODUyQ1UgY2FuIHdvcmsg
aW4gdHdvIGJhbmRzIGF0IHRoZSBzYW1lIHRpbWUsIHRodXMgc29tZSBVU0IgYnVsaw0KPiBvdXQg
ZW5kcG9pbnRzIGFyZSBkZWRpY2F0ZWQgdG8gb25lIGJhbmQsIG90aGVycyB0byB0aGUgb3RoZXIg
YmFuZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJm
ZTJAZ21haWwuY29tPg0KPiAtLS0NCj4gdjI6DQo+ICAtIE5vIGNoYW5nZSwgbWVzc2VkIHVwIHNl
bmRpbmcgdjEuDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS91
c2IuYyB8IDY0ICsrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQ2
IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvdXNiLmMgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg5L3VzYi5jDQo+IGluZGV4IDZjZjg5YWVlMjUyZS4uZWI5OTc4YTYwZDA0
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3VzYi5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvdXNiLmMNCj4gQEAg
LTE2NywyNCArMTY3LDUyIEBAIHJ0dzg5X3VzYl9vcHNfY2hlY2tfYW5kX3JlY2xhaW1fdHhfcmVz
b3VyY2Uoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0KPiAgICAgICAgIHJldHVybiA0MjsgLyog
VE9ETyBzb21lIGtpbmQgb2YgY2FsY3VsYXRpb24/ICovDQo+ICB9DQo+IA0KPiAtc3RhdGljIHU4
IHJ0dzg5X3VzYl9nZXRfYnVsa291dF9pZCh1OCBjaF9kbWEpDQo+ICtzdGF0aWMgdTggcnR3ODlf
dXNiX2dldF9idWxrb3V0X2lkKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTggY2hfZG1hKQ0K
PiAgew0KPiAtICAgICAgIHN3aXRjaCAoY2hfZG1hKSB7DQo+IC0gICAgICAgY2FzZSBSVFc4OV9E
TUFfQUNIMDoNCj4gLSAgICAgICAgICAgICAgIHJldHVybiAzOw0KPiAtICAgICAgIGNhc2UgUlRX
ODlfRE1BX0FDSDE6DQo+IC0gICAgICAgICAgICAgICByZXR1cm4gNDsNCj4gLSAgICAgICBjYXNl
IFJUVzg5X0RNQV9BQ0gyOg0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIDU7DQo+IC0gICAgICAg
Y2FzZSBSVFc4OV9ETUFfQUNIMzoNCj4gLSAgICAgICAgICAgICAgIHJldHVybiA2Ow0KPiAtICAg
ICAgIGRlZmF1bHQ6DQo+IC0gICAgICAgY2FzZSBSVFc4OV9ETUFfQjBNRzoNCj4gLSAgICAgICAg
ICAgICAgIHJldHVybiAwOw0KPiAtICAgICAgIGNhc2UgUlRXODlfRE1BX0IwSEk6DQo+IC0gICAg
ICAgICAgICAgICByZXR1cm4gMTsNCj4gLSAgICAgICBjYXNlIFJUVzg5X0RNQV9IMkM6DQo+IC0g
ICAgICAgICAgICAgICByZXR1cm4gMjsNCj4gKyAgICAgICBpZiAocnR3ZGV2LT5jaGlwLT5jaGlw
X2lkID09IFJUTDg4NTJDKSB7DQoNCk5vdCBzdXJlIGlmIHlvdSBsaWtlIGEgcnR3ODlfdXNiX2lu
Zm8gc2ltaWxhciB0byBydHc4OV9wY2lfaW5mbywgc28gdGhhdA0KdGhlIHlvdSBjYW4gZGVzY3Jp
YmUgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBjaGlwcy4gRXZlbiBtYWtlIGEgbWFwcGluZw0KdGFi
bGUuIA0KDQo+ICsgICAgICAgICAgICAgICBzd2l0Y2ggKGNoX2RtYSkgew0KPiArICAgICAgICAg
ICAgICAgY2FzZSBSVFc4OV9ETUFfQUNIMDoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIDM7DQo+ICsgICAgICAgICAgICAgICBjYXNlIFJUVzg5X0RNQV9BQ0gyOg0KPiArICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gNTsNCj4gKyAgICAgICAgICAgICAgIGNhc2UgUlRXODlf
RE1BX0FDSDQ6DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiA0Ow0KPiArICAgICAg
ICAgICAgICAgY2FzZSBSVFc4OV9ETUFfQUNINjoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIDY7DQo+ICsgICAgICAgICAgICAgICBkZWZhdWx0Og0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBydHc4OV93YXJuKHJ0d2RldiwgInVuZXhwZWN0ZWQgVFggY2hhbm5lbCAlZFxuIiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaF9kbWEpOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBmYWxsdGhyb3VnaDsNCj4gKyAgICAgICAgICAgICAgIGNhc2UgUlRX
ODlfRE1BX0IwTUc6DQo+ICsgICAgICAgICAgICAgICBjYXNlIFJUVzg5X0RNQV9CMEhJOg0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gKyAgICAgICAgICAgICAgIGNhc2Ug
UlRXODlfRE1BX0IxTUc6DQo+ICsgICAgICAgICAgICAgICBjYXNlIFJUVzg5X0RNQV9CMUhJOg0K
PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4gKyAgICAgICAgICAgICAgIGNh
c2UgUlRXODlfRE1BX0gyQzoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDI7DQo+
ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAg
IHN3aXRjaCAoY2hfZG1hKSB7DQo+ICsgICAgICAgICAgICAgICBjYXNlIFJUVzg5X0RNQV9BQ0gw
Og0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMzsNCj4gKyAgICAgICAgICAgICAg
IGNhc2UgUlRXODlfRE1BX0FDSDE6DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiA0
Ow0KPiArICAgICAgICAgICAgICAgY2FzZSBSVFc4OV9ETUFfQUNIMjoNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIDU7DQo+ICsgICAgICAgICAgICAgICBjYXNlIFJUVzg5X0RNQV9B
Q0gzOg0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gNjsNCj4gKyAgICAgICAgICAg
ICAgIGRlZmF1bHQ6DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJ0dzg5X3dhcm4ocnR3ZGV2
LCAidW5leHBlY3RlZCBUWCBjaGFubmVsICVkXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNoX2RtYSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGZhbGx0aHJv
dWdoOw0KPiArICAgICAgICAgICAgICAgY2FzZSBSVFc4OV9ETUFfQjBNRzoNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgICAgICAgICAgICBjYXNlIFJUVzg5X0RN
QV9CMEhJOg0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMTsNCj4gKyAgICAgICAg
ICAgICAgIGNhc2UgUlRXODlfRE1BX0gyQzoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIDI7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgfQ0KPiAgfQ0KPiANCj4gQEAg
LTI1MSw3ICsyNzksNyBAQCBzdGF0aWMgaW50IHJ0dzg5X3VzYl93cml0ZV9wb3J0KHN0cnVjdCBy
dHc4OV9kZXYgKnJ0d2RldiwgdTggY2hfZG1hLA0KPiAgICAgICAgIHN0cnVjdCBydHc4OV91c2Ig
KnJ0d3VzYiA9IHJ0dzg5X3VzYl9wcml2KHJ0d2Rldik7DQo+ICAgICAgICAgc3RydWN0IHVzYl9k
ZXZpY2UgKnVzYmQgPSBydHd1c2ItPnVkZXY7DQo+ICAgICAgICAgc3RydWN0IHVyYiAqdXJiOw0K
PiAtICAgICAgIHU4IGJ1bGtvdXRfaWQgPSBydHc4OV91c2JfZ2V0X2J1bGtvdXRfaWQoY2hfZG1h
KTsNCj4gKyAgICAgICB1OCBidWxrb3V0X2lkID0gcnR3ODlfdXNiX2dldF9idWxrb3V0X2lkKHJ0
d2RldiwgY2hfZG1hKTsNCj4gICAgICAgICB1bnNpZ25lZCBpbnQgcGlwZTsNCj4gICAgICAgICBp
bnQgcmV0Ow0KPiANCj4gLS0NCj4gMi41MC4wDQoNCg==

