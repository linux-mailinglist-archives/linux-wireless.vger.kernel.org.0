Return-Path: <linux-wireless+bounces-10659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F590940689
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 06:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49396283C16
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 04:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B67B20ED;
	Tue, 30 Jul 2024 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Wx3/En/4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B241366
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 04:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722314035; cv=none; b=VfLWyzyw/APz1t/wF7wMJkY91cWhXCQhQGln+PTmbD3LUOezTD/LWwFMp+/V2cKndKki0Y3PrEIzOidO19pWG81svWWswaD7SnyMQDtz4UsWlMKnZ1YeSPdirpGdCz/cQNmQmu28aGnPONzODSZg5lENfFVFa0ZzH0Da/FmJ2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722314035; c=relaxed/simple;
	bh=rU1aoUPiKHPhBXaYVy0CKXK09fQ40cmymW2cnD8SEbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKtaEyA3BSkvBKhnPCgpBD2S5dvvWxL3HELEfad3gi0QpYalOmBiGkc958dlzQ8NIZyy9WtDnSYdNBp+yaFtRUSnjIHls8KZKv2QtyVCSpzos1KmNxGhlehSwkQ7NVHtqAoc5BbgfzzlLp8QQARegcC1yiPR3Qa6WGtGt96kfCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Wx3/En/4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46U4XhIuA670448, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722314023; bh=rU1aoUPiKHPhBXaYVy0CKXK09fQ40cmymW2cnD8SEbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Wx3/En/452kAO7GkU5dxj6y+cfUHcAIneTulHmazQX00fnumwa/sOmQB+19onr3HF
	 hIgjRzm4+jfjfcZ+/FKupcGg9DHk3DviQpHkif+45oKKyKr1hYGJxfMWB9kE1Li3hE
	 7z5WdwmOApP9FFXYv/J13gaZhX9M5SIXvJuiBsTfBmzSMv128sWHpvr8Dn87nA5oSl
	 w6h0k6Cp/lXth/tlFwGZz05rFYgRUs8gub+OKqIk14m7slES4gLlEOrHgVYhs6dwtL
	 lYlC/48H1bytzUJdWdRIU1BfJjlI79M09sh8niKj+J9ZO3CsEndfh5i8Gn+oqxkQ3C
	 12kk1KbPOkhjA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46U4XhIuA670448
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 12:33:43 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 12:33:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jul 2024 12:33:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 30 Jul 2024 12:33:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH 3/4] wifi: rtw88: usb: Support RX aggregation
Thread-Topic: [PATCH 3/4] wifi: rtw88: usb: Support RX aggregation
Thread-Index: AQHa4SZO589JbybvEEumOQGXNs+X17IOr1UQ
Date: Tue, 30 Jul 2024 04:33:43 +0000
Message-ID: <4722139b12d443a1a62927a408344a66@realtek.com>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
 <a549707a-09f4-4787-8111-65cc266675d6@gmail.com>
In-Reply-To: <a549707a-09f4-4787-8111-65cc266675d6@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
VGhlIGNoaXBzIGNhbiBiZSBjb25maWd1cmVkIHRvIGFnZ3JlZ2F0ZSBzZXZlcmFsIGZyYW1lcyBp
bnRvIGEgc2luZ2xlDQo+IFVTQiB0cmFuc2Zlci4gTW9kaWZ5IHJ0d191c2JfcnhfaGFuZGxlcigp
IHRvIHN1cHBvcnQgdGhpcyBjYXNlLg0KPiANCj4gUlggYWdncmVnYXRpb24gaW1wcm92ZXMgdGhl
IFJYIHNwZWVkIG9uIGNlcnRhaW4gQVJNIHN5c3RlbXMsIGxpa2UgdGhlDQo+IE5hbm9QaSBORU8g
Q29yZTIuDQo+IA0KPiBDdXJyZW50bHkgbm9uZSBvZiB0aGUgY2hpcHMgYXJlIGNvbmZpZ3VyZWQg
dG8gYWdncmVnYXRlIGZyYW1lcy4NCj4gDQo+IFRlc3RlZCB3aXRoIFJUTDg4MTFDVSBhbmQgUlRM
ODcyM0RVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNl
cmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC91c2IuYyB8IDU3ICsrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDM3IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jDQo+IGluZGV4IDczOTQ4MDc4MDY4Zi4uZDYxYmUx
MDI5YTdiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L3VzYi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMN
Cj4gQEAgLTU0NiwxMSArNTQ2LDEyIEBAIHN0YXRpYyB2b2lkIHJ0d191c2JfcnhfaGFuZGxlcihz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICAgICAgICAgc3RydWN0IHJ0d191c2IgKnJ0d3Vz
YiA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgcnR3X3VzYiwgcnhfd29yayk7DQo+ICAgICAg
ICAgc3RydWN0IHJ0d19kZXYgKnJ0d2RldiA9IHJ0d3VzYi0+cnR3ZGV2Ow0KPiAgICAgICAgIGNv
bnN0IHN0cnVjdCBydHdfY2hpcF9pbmZvICpjaGlwID0gcnR3ZGV2LT5jaGlwOw0KPiAtICAgICAg
IHN0cnVjdCBydHdfcnhfcGt0X3N0YXQgcGt0X3N0YXQ7DQo+ICsgICAgICAgdTMyIHBrdF9kZXNj
X3N6ID0gY2hpcC0+cnhfcGt0X2Rlc2Nfc3o7DQo+ICAgICAgICAgc3RydWN0IGllZWU4MDIxMV9y
eF9zdGF0dXMgcnhfc3RhdHVzOw0KPiArICAgICAgIHUzMiBwa3Rfb2Zmc2V0LCBuZXh0X3BrdCwg
dXJiX2xlbjsNCj4gKyAgICAgICBzdHJ1Y3QgcnR3X3J4X3BrdF9zdGF0IHBrdF9zdGF0Ow0KPiAr
ICAgICAgIHN0cnVjdCBza19idWZmICpuZXh0X3NrYiA9IE5VTEw7DQo+ICAgICAgICAgc3RydWN0
IHNrX2J1ZmYgKnNrYjsNCj4gLSAgICAgICB1MzIgcGt0X2Rlc2Nfc3ogPSBjaGlwLT5yeF9wa3Rf
ZGVzY19zejsNCj4gLSAgICAgICB1MzIgcGt0X29mZnNldDsNCj4gICAgICAgICB1OCAqcnhfZGVz
YzsNCj4gICAgICAgICBpbnQgbGltaXQ7DQo+IA0KPiBAQCAtNTU5LDI5ICs1NjAsNDQgQEAgc3Rh
dGljIHZvaWQgcnR3X3VzYl9yeF9oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4g
ICAgICAgICAgICAgICAgIGlmICghc2tiKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVh
azsNCj4gDQo+IC0gICAgICAgICAgICAgICByeF9kZXNjID0gc2tiLT5kYXRhOw0KPiAtICAgICAg
ICAgICAgICAgY2hpcC0+b3BzLT5xdWVyeV9yeF9kZXNjKHJ0d2RldiwgcnhfZGVzYywgJnBrdF9z
dGF0LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZyeF9zdGF0
dXMpOw0KPiAtICAgICAgICAgICAgICAgcGt0X29mZnNldCA9IHBrdF9kZXNjX3N6ICsgcGt0X3N0
YXQuZHJ2X2luZm9fc3ogKw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBrdF9zdGF0
LnNoaWZ0Ow0KPiAtDQo+IC0gICAgICAgICAgICAgICBpZiAocGt0X3N0YXQuaXNfYzJoKSB7DQo+
IC0gICAgICAgICAgICAgICAgICAgICAgIHNrYl9wdXQoc2tiLCBwa3Rfc3RhdC5wa3RfbGVuICsg
cGt0X29mZnNldCk7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJ0d19md19jMmhfY21kX3J4
X2lycXNhZmUocnR3ZGV2LCBwa3Rfb2Zmc2V0LCBza2IpOw0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICBjb250aW51ZTsNCj4gLSAgICAgICAgICAgICAgIH0NCj4gLQ0KPiAgICAgICAgICAgICAg
ICAgaWYgKHNrYl9xdWV1ZV9sZW4oJnJ0d3VzYi0+cnhfcXVldWUpID49IFJUV19VU0JfTUFYX1JY
UV9MRU4pIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2RiZ19yYXRlbGltaXRlZChy
dHdkZXYtPmRldiwgImZhaWxlZCB0byBnZXQgcnhfcXVldWUsIG92ZXJmbG93XG4iKTsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgZGV2X2tmcmVlX3NrYl9hbnkoc2tiKTsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgY29udGludWU7DQo+ICAgICAgICAgICAgICAgICB9DQo+IA0KPiAtICAg
ICAgICAgICAgICAgc2tiX3B1dChza2IsIHBrdF9zdGF0LnBrdF9sZW4pOw0KPiAtICAgICAgICAg
ICAgICAgc2tiX3Jlc2VydmUoc2tiLCBwa3Rfb2Zmc2V0KTsNCj4gLSAgICAgICAgICAgICAgIHJ0
d19yeF9zdGF0cyhydHdkZXYsIHBrdF9zdGF0LnZpZiwgc2tiKTsNCj4gLSAgICAgICAgICAgICAg
IG1lbWNweShza2ItPmNiLCAmcnhfc3RhdHVzLCBzaXplb2Yocnhfc3RhdHVzKSk7DQo+IC0gICAg
ICAgICAgICAgICBpZWVlODAyMTFfcnhfaXJxc2FmZShydHdkZXYtPmh3LCBza2IpOw0KPiArICAg
ICAgICAgICAgICAgdXJiX2xlbiA9IHNrYi0+bGVuOw0KPiArDQo+ICsgICAgICAgICAgICAgICBk
byB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJ4X2Rlc2MgPSBza2ItPmRhdGE7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGNoaXAtPm9wcy0+cXVlcnlfcnhfZGVzYyhydHdkZXYsIHJ4
X2Rlc2MsICZwa3Rfc3RhdCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZyeF9zdGF0dXMpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBwa3Rf
b2Zmc2V0ID0gcGt0X2Rlc2Nfc3ogKyBwa3Rfc3RhdC5kcnZfaW5mb19zeiArDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwa3Rfc3RhdC5zaGlmdDsNCj4gKw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBuZXh0X3BrdCA9IHJvdW5kX3VwKHBrdF9zdGF0LnBrdF9sZW4g
KyBwa3Rfb2Zmc2V0LCA4KTsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAodXJi
X2xlbiA+PSBuZXh0X3BrdCArIHBrdF9kZXNjX3N6KQ0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG5leHRfc2tiID0gc2tiX2Nsb25lKHNrYiwgR0ZQX0tFUk5FTCk7DQo+ICsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHBrdF9zdGF0LmlzX2MyaCkgew0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNrYl90cmltKHNrYiwgcGt0X3N0YXQucGt0X2xlbiAr
IHBrdF9vZmZzZXQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJ0d19md19j
MmhfY21kX3J4X2lycXNhZmUocnR3ZGV2LCBwa3Rfb2Zmc2V0LCBza2IpOw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICB9IGVsc2Ugew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNrYl9wdWxsKHNrYiwgcGt0X29mZnNldCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc2tiX3RyaW0oc2tiLCBwa3Rfc3RhdC5wa3RfbGVuKTsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBydHdfcnhfc3RhdHMocnR3ZGV2LCBwa3Rfc3RhdC52aWYsIHNrYik7
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtY3B5KHNrYi0+Y2IsICZyeF9z
dGF0dXMsIHNpemVvZihyeF9zdGF0dXMpKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpZWVlODAyMTFfcnhfaXJxc2FmZShydHdkZXYtPmh3LCBza2IpOw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2tiID0gbmV4
dF9za2I7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChza2IpDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc2tiX3B1bGwobmV4dF9za2IsIG5leHRfcGt0KTsNCj4gKw0K
PiArICAgICAgICAgICAgICAgICAgICAgICB1cmJfbGVuIC09IG5leHRfcGt0Ow0KDQpJIHdvdWxk
IGxpa2UgYSBjaGVja2luZyB0byBwcmV2ZW50IHVuZGVyZmxvdyBjYXVzZWQgYnkgdW5leHBlY3Rl
ZCBoYXJkd2FyZSBkYXRhLg0KDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG5leHRfc2tiID0g
TlVMTDsNCj4gKyAgICAgICAgICAgICAgIH0gd2hpbGUgKHNrYiAmJiB1cmJfbGVuID49IHBrdF9k
ZXNjX3N6KTsNCj4gICAgICAgICB9DQo+ICB9DQo+IA0KPiBAQCAtNjI1LDYgKzY0MSw3IEBAIHN0
YXRpYyB2b2lkIHJ0d191c2JfcmVhZF9wb3J0X2NvbXBsZXRlKHN0cnVjdCB1cmIgKnVyYikNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNrYikNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBkZXZfa2ZyZWVfc2tiX2FueShza2IpOw0KPiAgICAgICAgICAgICAgICAgfSBl
bHNlIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2tiX3B1dChza2IsIHVyYi0+YWN0dWFs
X2xlbmd0aCk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNrYl9xdWV1ZV90YWlsKCZydHd1
c2ItPnJ4X3F1ZXVlLCBza2IpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZV93b3Jr
KHJ0d3VzYi0+cnh3cSwgJnJ0d3VzYi0+cnhfd29yayk7DQo+ICAgICAgICAgICAgICAgICB9DQo+
IC0tDQo+IDIuNDUuMg0KDQo=

