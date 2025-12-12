Return-Path: <linux-wireless+bounces-29686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D25E8CB7A1A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E04B301AE04
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 02:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3C8229B1F;
	Fri, 12 Dec 2025 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="N6vjA771"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20756233723
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505361; cv=none; b=aBAkFMIp9r1xfCyZajvWbbU5j3jqSzbNSNOvRg7horcM5ola2ngRMre0Fb3H76ckJcybFhKFjoV4A+MJQ9jfmzEfGcuG8WKQFK7mYX9aCfoIXpmbBHYuIJcISoSwSkxolqYe9h29Z4V8tFqt5OZ1AVGMerMVv7UBDMo0AjGhjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505361; c=relaxed/simple;
	bh=84WmljKr5Jd/6c3pmVH7ZaTXZpBhBjjGCaajpml8EXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8nk8bIwhdAuqh4F607Dr6sFXJeUYxvFLwuoE27BoiTkv9OfyRbkvV4tL5HD7PYD2jDbGSmSc4a2fGp/c4d5f1PoqPcZYLEIwXpOiXHwVCCbdQSmSRKauVJvf19cXn06wPqd4nDgjy2TiqUq3rJK+XX4GAGJCyVQAPNu9b2Zy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=N6vjA771; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC296dxC3396058, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765505346; bh=84WmljKr5Jd/6c3pmVH7ZaTXZpBhBjjGCaajpml8EXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=N6vjA7713Gd7aEAw37w53yTOS8KvT9OjSV/8yDPlM+TAalCOLMUeDD9US8/EYafOz
	 k3B/9lOoMICF3Nkvs5voQEA6YVlP5EUQtT9+mbLSh9U2xuSC5YiBDNzZmwzOUVsFB8
	 inJzD8u4SBs8hcvccSFt4IvDgRTejNxSkVU3oBwToAdcL0O3cNc6uM6zYspxEn5O4E
	 NZlO3XyXuyBeRVUgcX2wJxl4jaXl5b0HDxzNeVFay9nqerJwKgr7B0urKCoeV0LoKF
	 dWKH0iOyxuvrAIYZVCfkG8KZl3O4UkpaEajThdCE6VkpchsPJQT1+hxzCvvGta68uE
	 Guwsk4LN0WHTA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC296dxC3396058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 10:09:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 12 Dec 2025 10:09:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Fri, 12 Dec 2025 10:09:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/2] wifi: rtw89: avoid to use not consecutive
 mask in __write_ctrl()
Thread-Topic: [PATCH rtw-next 2/2] wifi: rtw89: avoid to use not consecutive
 mask in __write_ctrl()
Thread-Index: AQHcV3KBvgjpTd8EgUGsgARAAsxhxbT3upqAgAF1nJD///pwgIAAiZbQgCO0MvA=
Date: Fri, 12 Dec 2025 02:09:06 +0000
Message-ID: <a24c93afc2ee42c1b3d616dd35cde5cb@realtek.com>
References: <20251117032910.11224-1-pkshih@realtek.com>
 <20251117032910.11224-3-pkshih@realtek.com>
 <CAMuHMdUx6qY66bCcGsm1YHK3=H+=Td6YM_gsXJ=UgjAYJpGo0Q@mail.gmail.com>
 <c19306a1d41f4946801cf1c5b70c8528@realtek.com>
 <CAMuHMdUu9=4ypfR69_hQpVAuh-mciwtpLsVv0eBa5KX4KTYjxw@mail.gmail.com>
 <575ad4ca8f0b4409ab78ffc63e34a49b@realtek.com>
In-Reply-To: <575ad4ca8f0b4409ab78ffc63e34a49b@realtek.com>
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

SGkgR2VlcnQsDQoNClBpbmctS2UgU2hpaCB3cm90ZToNCj4gR2VlcnQgVXl0dGVyaG9ldmVuIDxn
ZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+ID4gSGkgUGluZy1LZSwNCj4gPg0KPiA+IE9u
IFdlZCwgMTkgTm92IDIwMjUgYXQgMDI6MTUsIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPiB3cm90ZToNCj4gPiA+IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5v
cmc+IHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIDE3IE5vdiAyMDI1IGF0IDA0OjMwLCBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gVGhlIHBvd2VyIHZh
bHVlIGFuZCBlbmFibGUgYml0IGZpZWxkcyBjYW4gYmUgbm90IGNvbnNlY3V0aXZlIG1hc2ssIGJ1
dA0KPiA+ID4gPiA+IG5vcm1hbGx5IHdlIGV4cGVjdCBtYXNrIGFyZ3VtZW50IG9mIHJ0dzg5X21h
Y190eHB3cl93cml0ZTMyX21hc2soKSBpcw0KPiA+ID4gPiA+IGNvbnNlY3V0aXZlIGJpdCBtYXNr
LiBUaGVyZWZvcmUsIGNoYW5nZSB0aGUgY29kZSBhY2NvcmRpbmdseS4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IENjOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
PiA+ID4gPg0KPiA+ID4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+ID4gPiA+DQo+ID4gPiA+
IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJl
Pg0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODkvbWFjLmgNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg5L21hYy5oDQo+ID4gPiA+ID4gQEAgLTE0NTYsNiArMTQ1NiwyNiBAQCBzdGF0aWMgaW5s
aW5lIGludCBydHc4OV9tYWNfdHhwd3Jfd3JpdGUzMl9tYXNrKHN0cnVjdCBydHc4OV9kZXYgKnJ0
d2RldiwNCj4gPiA+ID4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiA+ICB9DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiArc3RhdGljIGlubGluZQ0KPiA+ID4gPiA+ICt2b2lkIHJ0dzg5X21hY193
cml0ZV90eHB3cl9jdHJsKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTMyIHJlZywgdTMyIG1h
c2ssIHUzMiB2YWwsDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
MzIgbWFza19lbiwgYm9vbCBjb25kKQ0KPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gKyAgICAgICB1
MzIgd3J0ID0gdTMyX2VuY29kZV9iaXRzKHZhbCwgbWFzayk7DQo+ID4gPiA+DQo+ID4gPiA+IE5p
dDogeW91IGNvdWxkIGRvIHdpdGhvdXQgdGhpcyB2YXJpYWJsZS4uLg0KDQpDYW4geW91IGNoYW5n
ZSB1MzJfZW5jb2RlX2JpdHMoKSB0byBmaWVsZF9wcmVwKCkgeW91IGFyZSBnb2luZyB0byBhZGQ/
DQpBbmQgdGFrZSB0aGlzIHBhdGNoICh2MSkgd2l0aCB5b3VyIHN1Z2dlc3Rpb24gaW50byB5b3Vy
IHBhdGNoc2V0Lg0KVGhlbiB0aGUgY29kZSBsb29rcyBiZXR0ZXIgYW5kIHRoaW5nIGNhbiBiZSBz
bW9vdGguDQoNCkkgd2lsbCBkcm9wIG15IHYyIHRoYXQgbG9va3Mgbm90IGdvb2QuIA0KDQo+ID4g
PiA+DQo+ID4gPiA+ID4gKyAgICAgICB1MzIgdmFsMzI7DQo+ID4gPiA+ID4gKyAgICAgICBpbnQg
cmV0Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgIGlmIChjb25kKQ0KPiA+ID4gPiA+
ICsgICAgICAgICAgICAgICB3cnQgfD0gbWFza19lbjsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
KyAgICAgICByZXQgPSBydHc4OV9tYWNfdHhwd3JfcmVhZDMyKHJ0d2RldiwgUlRXODlfUEhZXzAs
IHJlZywgJnZhbDMyKTsNCj4gPiA+ID4gPiArICAgICAgIGlmIChyZXQpDQo+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgICB2YWwz
MiAmPSB+KG1hc2sgfCBtYXNrX2VuKTsNCj4gPiA+ID4gPiArICAgICAgIHZhbDMyIHw9IHdydDsN
Cj4gPiA+ID4NCj4gPiA+ID4gdmFsMzIgfD0gdTMyX2VuY29kZV9iaXRzKHZhbCwgbWFzayk7DQo+
ID4gPiA+IGlmIChjb25kKQ0KPiA+ID4gPiAgICAgICAgIGNhbDMyIHw9IG1hc2tfZW47DQo+ID4g
Pg0KPiA+ID4gV2l0aCB0aGlzIGNoYW5nZSwgQVJDSCBhcm0gaXMgZmFpbGVkIHRvIGJ1aWxkICh4
ODYgaXMgd2VsbCk6DQo+ID4gPg0KPiA+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC9idWlsZC9y
dHc4OS9jb3JlLmg6OSwNCj4gPiA+ICAgICAgICAgICAgICAgICAgZnJvbSAvYnVpbGQvcnR3ODkv
Y29leC5oOjgsDQo+ID4gPiAgICAgICAgICAgICAgICAgIGZyb20gL2J1aWxkL3J0dzg5L3J0dzg4
NTFiLmM6NToNCj4gPiA+IEluIGZ1bmN0aW9uICdmaWVsZF9tdWx0aXBsaWVyJywNCj4gPiA+ICAg
ICBpbmxpbmVkIGZyb20gJ2ZpZWxkX21hc2snIGF0IC4vaW5jbHVkZS9saW51eC9iaXRmaWVsZC5o
OjE3MDoxNywNCj4gPiA+ICAgICBpbmxpbmVkIGZyb20gJ3UzMl9lbmNvZGVfYml0cycgYXQgLi9p
bmNsdWRlL2xpbnV4L2JpdGZpZWxkLmg6MjAwOjEsDQo+ID4gPiAgICAgaW5saW5lZCBmcm9tICdy
dHc4OV9tYWNfd3JpdGVfdHhwd3JfY3RybCcgYXQgL2J1aWxkL3J0dzg5L21hYy5oOjE0Njg6MTE6
DQo+ID4gPiAuL2luY2x1ZGUvbGludXgvYml0ZmllbGQuaDoxNjU6MTc6IGVycm9yOiBjYWxsIHRv
ICdfX2JhZF9tYXNrJyBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSBlcnJvcjogYmFkDQo+ID4gYml0
ZmllbGQgbWFzaw0KPiA+ID4gICAxNjUgfCAgICAgICAgICAgICAgICAgX19iYWRfbWFzaygpOw0K
PiA+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+DQo+ID4gPiBJbiBmdW5j
dGlvbiAnZmllbGRfbXVsdGlwbGllcicsDQo+ID4NCj4gPiBIbW0uLi4NCj4gPg0KPiA+IE5vdGUg
dGhhdCB1MzJfZW5jb2RlX2JpdHMoKSByZWFsbHkgcmVxdWlyZXMgYSBjb25zdGFudCBtYXNrLCBq
dXN0DQo+ID4gbGlrZSBGSUVMRF9QUkVQKCkuICBTbyBwcm9iYWJseSB0aGUgY29tcGlsZXIgY2Fu
IG5vIGxvbmdlciBkZWR1Y2UgaXQNCj4gPiBpcyBjYWxsZWQgd2l0aCBhIGNvbnN0YW50IGFmdGVy
IHJlc3RydWN0dXJpbmcgdGhlIGNvZGUuLi4NCj4gDQo+IERvIHlvdSB0aGluayBJIG5lZWQgdG8g
YWRkIGEgbWFjcm8gdG8gZ2VuZXJhdGUgbWFzayB3aXRoIHUzMl9lbmNvZGVfYml0cygpDQo+IGFu
ZCB0aGVuIGNhbGwgdGhpcyBpbmxpbmUgZnVuY3Rpb24/DQo+IA0KPiBPciwgY29tcGlsZXIgY2Fu
IGFsd2F5cyBkZWR1Y2UgaXQgaW4gdGhlIGlubGluZSBmdW5jdGlvbiwgYW5kIGN1cnJlbnQgdmVy
c2lvbg0KPiBpcyBva2F5Pw0KPiANCg0K

