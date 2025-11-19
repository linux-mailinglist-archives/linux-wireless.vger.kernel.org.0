Return-Path: <linux-wireless+bounces-29113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C5FC6C38C
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 02:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6DA94E28D1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 01:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DB418E1F;
	Wed, 19 Nov 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hbuF+FDr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA83702E0
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763514961; cv=none; b=IXBHL735wNmKJI8+GkIQTKcz6sohDajNwYqEaHmQnwI43QmsTjbWSZHQZp7UNHiRibjLTpJpnpz0nmDipvEuwAYRnGtexbpSCn+Kn7zVs8/druW2gcIpvoawtvcE5kLANJqYg7HXtwqb5HE5vJg0faFtJl2YVmPHhLytmUfNoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763514961; c=relaxed/simple;
	bh=63qxGBFRLR/i1k8+g62tD1ASXKuVpv2pcZUibhXEn6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E34/kvFMOWIQVQojD8SPVnMVkCnG27bNLm/tvFvExGwTYJi7ytxKBrunf8kr9DHDSRMSa6xdnOLzkIWGbzeqn5hdhf1mY4wprUD60M/A21z/GP0naX2n4YB0FEr7uzMwS0uPKdNYIhvEIIA8tLSMTtBMReP0fa4hHmfvQYSCg9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hbuF+FDr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AJ1FnGwA2555330, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763514949; bh=63qxGBFRLR/i1k8+g62tD1ASXKuVpv2pcZUibhXEn6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hbuF+FDrU95KK5eqobof5Zg+hexpYLuR6SffxL8JvdGkmE0HB4Hjv0FPnODbGBGPi
	 lIyHR+mmy0ecywyaM2ubZgWiZe/KA+xxGW/+R6vC9Dlx2w4lxXlbfhUaNlIniB/WOI
	 X8OHpseX6KAMxalxuaQJ7yWmKHcGQDg07jNHz+xv53ulPzoIFfhzAoy2amEOi5HDGv
	 ao2URtBI+7YHoVANQn7qlqYKIOeZJuUdbn4ma8Tnc25uczzqYHwu42hmujyotwnoak
	 ThQYcMCUCOeWb+xI1rhSFTk0IKx5B/gBKtHLOUT//8NWZN9wlgDqG7xLL5zBikXp9J
	 WOFgxp3bVq5Rg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AJ1FnGwA2555330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:15:49 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 19 Nov 2025 09:15:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 19 Nov 2025 09:15:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 19 Nov 2025 09:15:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/2] wifi: rtw89: avoid to use not consecutive
 mask in __write_ctrl()
Thread-Topic: [PATCH rtw-next 2/2] wifi: rtw89: avoid to use not consecutive
 mask in __write_ctrl()
Thread-Index: AQHcV3KBvgjpTd8EgUGsgARAAsxhxbT3upqAgAF1nJA=
Date: Wed, 19 Nov 2025 01:15:50 +0000
Message-ID: <c19306a1d41f4946801cf1c5b70c8528@realtek.com>
References: <20251117032910.11224-1-pkshih@realtek.com>
 <20251117032910.11224-3-pkshih@realtek.com>
 <CAMuHMdUx6qY66bCcGsm1YHK3=H+=Td6YM_gsXJ=UgjAYJpGo0Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUx6qY66bCcGsm1YHK3=H+=Td6YM_gsXJ=UgjAYJpGo0Q@mail.gmail.com>
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

R2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+IEhpIFBp
bmctS2UsDQo+IA0KPiBPbiBNb24sIDE3IE5vdiAyMDI1IGF0IDA0OjMwLCBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gVGhlIHBvd2VyIHZhbHVlIGFuZCBlbmFi
bGUgYml0IGZpZWxkcyBjYW4gYmUgbm90IGNvbnNlY3V0aXZlIG1hc2ssIGJ1dA0KPiA+IG5vcm1h
bGx5IHdlIGV4cGVjdCBtYXNrIGFyZ3VtZW50IG9mIHJ0dzg5X21hY190eHB3cl93cml0ZTMyX21h
c2soKSBpcw0KPiA+IGNvbnNlY3V0aXZlIGJpdCBtYXNrLiBUaGVyZWZvcmUsIGNoYW5nZSB0aGUg
Y29kZSBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IENjOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
QGxpbnV4LW02OGsub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGlo
QHJlYWx0ZWsuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gUmV2aWV3
ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQo+IA0K
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmgNCj4gPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5oDQo+ID4gQEAgLTE0
NTYsNiArMTQ1NiwyNiBAQCBzdGF0aWMgaW5saW5lIGludCBydHc4OV9tYWNfdHhwd3Jfd3JpdGUz
Ml9tYXNrKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCj4gPiAgICAgICAgIHJldHVybiAwOw0K
PiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGlubGluZQ0KPiA+ICt2b2lkIHJ0dzg5X21hY193cml0
ZV90eHB3cl9jdHJsKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTMyIHJlZywgdTMyIG1hc2ss
IHUzMiB2YWwsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgbWFza19l
biwgYm9vbCBjb25kKQ0KPiA+ICt7DQo+ID4gKyAgICAgICB1MzIgd3J0ID0gdTMyX2VuY29kZV9i
aXRzKHZhbCwgbWFzayk7DQo+IA0KPiBOaXQ6IHlvdSBjb3VsZCBkbyB3aXRob3V0IHRoaXMgdmFy
aWFibGUuLi4NCj4gDQo+ID4gKyAgICAgICB1MzIgdmFsMzI7DQo+ID4gKyAgICAgICBpbnQgcmV0
Ow0KPiA+ICsNCj4gPiArICAgICAgIGlmIChjb25kKQ0KPiA+ICsgICAgICAgICAgICAgICB3cnQg
fD0gbWFza19lbjsNCj4gPiArDQo+ID4gKyAgICAgICByZXQgPSBydHc4OV9tYWNfdHhwd3JfcmVh
ZDMyKHJ0d2RldiwgUlRXODlfUEhZXzAsIHJlZywgJnZhbDMyKTsNCj4gPiArICAgICAgIGlmIChy
ZXQpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiArDQo+ID4gKyAgICAgICB2YWwz
MiAmPSB+KG1hc2sgfCBtYXNrX2VuKTsNCj4gPiArICAgICAgIHZhbDMyIHw9IHdydDsNCj4gDQo+
IHZhbDMyIHw9IHUzMl9lbmNvZGVfYml0cyh2YWwsIG1hc2spOw0KPiBpZiAoY29uZCkNCj4gICAg
ICAgICBjYWwzMiB8PSBtYXNrX2VuOw0KDQpXaXRoIHRoaXMgY2hhbmdlLCBBUkNIIGFybSBpcyBm
YWlsZWQgdG8gYnVpbGQgKHg4NiBpcyB3ZWxsKToNCg0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC9i
dWlsZC9ydHc4OS9jb3JlLmg6OSwNCiAgICAgICAgICAgICAgICAgZnJvbSAvYnVpbGQvcnR3ODkv
Y29leC5oOjgsDQogICAgICAgICAgICAgICAgIGZyb20gL2J1aWxkL3J0dzg5L3J0dzg4NTFiLmM6
NToNCkluIGZ1bmN0aW9uICdmaWVsZF9tdWx0aXBsaWVyJywNCiAgICBpbmxpbmVkIGZyb20gJ2Zp
ZWxkX21hc2snIGF0IC4vaW5jbHVkZS9saW51eC9iaXRmaWVsZC5oOjE3MDoxNywNCiAgICBpbmxp
bmVkIGZyb20gJ3UzMl9lbmNvZGVfYml0cycgYXQgLi9pbmNsdWRlL2xpbnV4L2JpdGZpZWxkLmg6
MjAwOjEsDQogICAgaW5saW5lZCBmcm9tICdydHc4OV9tYWNfd3JpdGVfdHhwd3JfY3RybCcgYXQg
L2J1aWxkL3J0dzg5L21hYy5oOjE0Njg6MTE6DQouL2luY2x1ZGUvbGludXgvYml0ZmllbGQuaDox
NjU6MTc6IGVycm9yOiBjYWxsIHRvICdfX2JhZF9tYXNrJyBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0
ZSBlcnJvcjogYmFkIGJpdGZpZWxkIG1hc2sNCiAgMTY1IHwgICAgICAgICAgICAgICAgIF9fYmFk
X21hc2soKTsNCiAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fg0KSW4gZnVuY3Rp
b24gJ2ZpZWxkX211bHRpcGxpZXInLA0KDQo+IA0KPiA+ICsgICAgICAgcnR3ODlfbWFjX3R4cHdy
X3dyaXRlMzIocnR3ZGV2LCBSVFc4OV9QSFlfMCwgcmVnLCB2YWwzMik7DQo+IA0KPiBBcyB0aGlz
IGNhbGxzIG1hYy0+Z2V0X3R4cHdyX2NyKCkgYSBzZWNvbmQgdGltZSwgcGVyaGFwcyBpdCBpcyBi
ZXR0ZXIgdG8NCj4gb3Blbi1jb2RlIHJ0dzg5X21hY190eHB3cl9yZWFkMzIoKSBhbmQgcnR3ODlf
bWFjX3R4cHdyX3dyaXRlMzIoKQ0KPiBpbiB0aGlzIGZ1bmN0aW9uPw0KDQpUaGlzIGZ1bmN0aW9u
IGlzbid0IGluIGhvdCBwYXRoLCBhbmQgdXNpbmcgcnR3ODlfbWFjX3R4cHdyX3JlYWQzMigpIGFu
ZA0KcnR3ODlfbWFjX3R4cHdyX3dyaXRlMzIoKSBpcyBjbGVhcmVyIHRoYW4gb3Blbi1jb2RlLCBz
byBJJ2Qga2VlcCBpdCBhcyB3YXMuDQoNClRoZW4gSSBkb24ndCBwbGFuIHRvIHNlbmQgdjIuIA0K
DQoNCg==

