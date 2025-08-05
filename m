Return-Path: <linux-wireless+bounces-26156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EA8B1ABC7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 02:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2675176CA1
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Aug 2025 00:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78A13633F;
	Tue,  5 Aug 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kX9Iyr5+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3913A3F2
	for <linux-wireless@vger.kernel.org>; Tue,  5 Aug 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754354415; cv=none; b=YTylnF1SwPkbWngfiLdJcv8s28zJPhdP5Ia7RY8Lk6Mud0gOAhtltxoG+rBIsnoiaYI0c+LjrOf6ltfa4X9w0OgdsuIAybCTEkgCq/rvTR/W6hq7MVIp/PMewUG67fk1dRh6oGAs41s4iJIZAyOHWC3DD4lELDdg7gb8/4FFI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754354415; c=relaxed/simple;
	bh=XKTQJqTXfZ0JOt5xKcDyWTlqzoo3kgAaTJyxzcLmha4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XB7SvTjxYNKl+19KkzfQm6U3dSp2r3RVc77fIrWOuTGOLE/DJwkvcGJSGy+mzvPEawf1Ixsmh6GFHuO+tEN6kqQvzV7jHffRpBLvROZ5aizo2k2yCgub/vG6MaGi04v2Guju4h+tGsEDTXFrMhgz5Hf3uQa3KuQL83TfTqWQMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kX9Iyr5+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5750e7Hn9939193, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754354407; bh=XKTQJqTXfZ0JOt5xKcDyWTlqzoo3kgAaTJyxzcLmha4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kX9Iyr5+FjXSyQ0md793Hv3tAdax8GC2r/bwKv9+yYMNJKNF4mAzStuKhfwJM3Mmy
	 L5g6ZA+s0WC9H0TNRJTUaJha2vSXPl5qSNZ8NIXrok9Xlw4RFPu1U9/wP4lumSvAJG
	 W8NTQ/HrmFxZY+1qFNytfyrkW77rdA2KCRB5L6EI0HJ9+ezLgE7NqtB22miVaKqUmr
	 rVxJ628FKmWTd/MyRzd3UYUWMrYADsYXcZgHpxz7ZM20niPAy7FAUmWOASbjAr1RWA
	 NjtOumr6gfh0NXvruxi5dC/3uNUO4ruAfwUd6rNcYjZO00QvCPcTgEpuHuRkkzJgDP
	 Zefb7ybhPW5QQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5750e7Hn9939193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 08:40:07 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 08:40:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 08:40:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Tue, 5 Aug 2025 08:40:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 01/11] wifi: rtw89: Fix rtw89_core_get_ch_dma() for RTL8852CU
Thread-Topic: [PATCH rtw-next v2 01/11] wifi: rtw89: Fix
 rtw89_core_get_ch_dma() for RTL8852CU
Thread-Index: AQHcAyYgFh0777fe60moSIXGnadVn7RSUziAgADjWSA=
Date: Tue, 5 Aug 2025 00:40:07 +0000
Message-ID: <4203c4ab09df4975be85e341f5e24264@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <5b1210f3-499d-44d8-9433-7beac2a2800d@gmail.com>
 <11f3e864-7509-4e5f-86ed-997f8a9b63e9@gmail.com>
In-Reply-To: <11f3e864-7509-4e5f-86ed-997f8a9b63e9@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAw
MS8wOC8yMDI1IDIzOjUxLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3RlOg0KPiA+IEl0IHNlZW1zIFJU
TDg4NTJDVSBjYW4gb25seSB1c2UgVFggY2hhbm5lbHMgMCwgMiwgYW5kIDggKGZvciBiYW5kIDAp
LA0KPiA+IG90aGVyd2lzZSB0aGUgY2hpcCBzdG9wcyB3b3JraW5nIGFmdGVyIGRvd25sb2FkaW5n
IGF0IG1heGltdW0gc3BlZWQNCj4gPiBmb3IgYSBmZXcgc2Vjb25kcy4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+
IC0tLQ0KPiA+IHYyOg0KPiA+ICAtIE5vIGNoYW5nZSwgbWVzc2VkIHVwIHNlbmRpbmcgdjEuDQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvdHhyeC5oIHwg
MTkgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvdHhyeC5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS90eHJ4LmgN
Cj4gPiBpbmRleCBlYzAxYmZjMzYzZGEuLjMxOGZkMGFjODcyNiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3R4cnguaA0KPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvdHhyeC5oDQo+ID4gQEAgLTczNCw2ICs3MzQs
MjUgQEAgcnR3ODlfY29yZV9nZXRfcXNlbF9tZ210KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rldiwg
c3RydWN0IHJ0dzg5X2NvcmVfdHhfcmVxdWVzdA0KPiA+DQo+ID4gIHN0YXRpYyBpbmxpbmUgdTgg
cnR3ODlfY29yZV9nZXRfY2hfZG1hKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTggcXNlbCkN
Cj4gPiAgew0KPiA+ICsgICAgIGlmIChydHdkZXYtPmhjaS50eXBlID09IFJUVzg5X0hDSV9UWVBF
X1VTQiAmJg0KPiA+ICsgICAgICAgICBydHdkZXYtPmNoaXAtPmNoaXBfaWQgPT0gUlRMODg1MkMp
IHsNCj4gPiArICAgICAgICAgICAgIHN3aXRjaCAocXNlbCkgew0KPiA+ICsgICAgICAgICAgICAg
ZGVmYXVsdDoNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcnR3ODlfd2FybihydHdkZXYsICJD
YW5ub3QgbWFwIHFzZWwgdG8gZG1hOiAlZFxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBxc2VsKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgZmFsbHRocm91Z2g7
DQo+ID4gKyAgICAgICAgICAgICBjYXNlIFJUVzg5X1RYX1FTRUxfQkVfMDoNCj4gPiArICAgICAg
ICAgICAgIGNhc2UgUlRXODlfVFhfUVNFTF9WT18wOg0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gUlRXODlfVFhDSF9BQ0gwOw0KPiA+ICsgICAgICAgICAgICAgY2FzZSBSVFc4OV9U
WF9RU0VMX0JLXzA6DQo+ID4gKyAgICAgICAgICAgICBjYXNlIFJUVzg5X1RYX1FTRUxfVklfMDoN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFJUVzg5X1RYQ0hfQUNIMjsNCj4gPiAr
ICAgICAgICAgICAgIGNhc2UgUlRXODlfVFhfUVNFTF9CMF9NR01UOg0KPiA+ICsgICAgICAgICAg
ICAgY2FzZSBSVFc4OV9UWF9RU0VMX0IwX0hJOg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gUlRXODlfVFhDSF9DSDg7DQo+ID4gKyAgICAgICAgICAgICB9DQo+ID4gKyAgICAgfQ0K
PiA+ICsNCj4gPiAgICAgICBzd2l0Y2ggKHFzZWwpIHsNCj4gPiAgICAgICBkZWZhdWx0Og0KPiA+
ICAgICAgICAgICAgICAgcnR3ODlfd2FybihydHdkZXYsICJDYW5ub3QgbWFwIHFzZWwgdG8gZG1h
OiAlZFxuIiwgcXNlbCk7DQo+IA0KPiBJIHNlZSBub3cgdGhhdCBSVEw4OTIyQVUgbmVlZHMgdGhl
IHNhbWUgY2hhbmdlLiBBbmQgc2FtZSBpbiBwYXRjaCAyLzExDQo+IGFzIHdlbGwuDQoNClRoZSBj
b21pbmcgY2hpcCBSVEw4OTIyREUgdXNlcyBkaWZmZXJlbnQgbWFwcGluZyBydWxlLCBzbyBJIGFk
ZCBhIG5ldw0KY2hpcF9vcHM6DQogDQotLS0gYS9jb3JlLmgNCisrKyBiL2NvcmUuaA0KQEAgLTQw
NzIsNiArNDA3Miw3IEBAIHN0cnVjdCBydHc4OV9jaGlwX29wcyB7DQogICAgICAgIHZvaWQgKCpm
aWxsX3R4ZGVzY19md2NtZCkoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBydHc4OV90eF9kZXNjX2luZm8gKmRlc2NfaW5m
bywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICp0eGRlc2MpOw0KKyAg
ICAgICB1OCAoKmdldF9jaF9kbWEpKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTggcXNlbCk7
DQogICAgICAgIGludCAoKmNmZ19jdHJsX3BhdGgpKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rldiwg
Ym9vbCB3bCk7DQogICAgICAgIGludCAoKm1hY19jZmdfZ250KShzdHJ1Y3QgcnR3ODlfZGV2ICpy
dHdkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgcnR3ODlfbWFj
X2F4X2NvZXhfZ250ICpnbnRfY2ZnKTsNCkBAIC03NDI4LDYgKzc0MjksMTQgQEAgdm9pZCBydHc4
OV9jaGlwX2ZpbGxfdHhkZXNjX2Z3Y21kKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCiAgICAg
ICAgY2hpcC0+b3BzLT5maWxsX3R4ZGVzY19md2NtZChydHdkZXYsIGRlc2NfaW5mbywgdHhkZXNj
KTsNCiB9DQoNCitzdGF0aWMgaW5saW5lDQordTggcnR3ODlfY2hpcF9nZXRfY2hfZG1hKHN0cnVj
dCBydHc4OV9kZXYgKnJ0d2RldiwgdTggcXNlbCkNCit7DQorICAgICAgIGNvbnN0IHN0cnVjdCBy
dHc4OV9jaGlwX2luZm8gKmNoaXAgPSBydHdkZXYtPmNoaXA7DQorDQorICAgICAgIHJldHVybiBj
aGlwLT5vcHMtPmdldF9jaF9kbWEocnR3ZGV2LCBxc2VsKTsNCit9DQorDQogc3RhdGljIGlubGlu
ZQ0KIHZvaWQgcnR3ODlfY2hpcF9tYWNfY2ZnX2dudChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYs
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHJ0dzg5X21hY19heF9j
b2V4X2dudCAqZ250X2NmZykNCg0KQWxzbyB0aGUgcnR3ODlfY29yZV9nZXRfY2hfZG1hKCkgaXMg
bW92ZWQgdG8gY29yZS5jLCBhbmQgYWRkDQpydHc4OV9jb3JlX2dldF9jaF9kbWFfdjEoKSBmb3Ig
UlRMODkyMkRFLiANCg0KSG93ZXZlciwgVVNCIGNhbiB1c2UgZGlmZmVyZW50IG1hcHBpbmcgcnVs
ZSwgc28gd2Ugc2hvdWxkIGV4dGVuZCB0aGUgc2l6ZQ0KdG8gUlRXODlfSENJX1RZUEVfTlVNLiBU
aGVuLCANCg0KICByZXR1cm4gY2hpcC0+b3BzLT5nZXRfY2hfZG1hW3J0d2Rldi0+aGNpLnR5cGVd
KHJ0d2RldiwgcXNlbCk7DQoNCklmIHlvdSB3YW50IG15IHBhdGNoIGFzIGZpcnN0IHBhdGNoIG9m
IHRoaXMgcGF0Y2hzZXQsIEkgY2FuIHNoYXJlIGl0IGFzIFJGQy4NCg0KDQpTaW5jZSB0aGlzIGlz
IGNhbGxlZCBpbiBkYXRhIHBhdGgsIEknZCBsaWtlIHRvIGF2b2lkIGlmLWNvbmRpdGlvbiB0byBz
YXZlDQphIGxpdHRsZSBleGVjdXRpb24gdGltZS4NCg0K

