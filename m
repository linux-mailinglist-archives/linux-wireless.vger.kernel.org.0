Return-Path: <linux-wireless+bounces-29738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEAECBC39A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 03:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB0993010AE4
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85C21B9D2;
	Mon, 15 Dec 2025 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kpt1dWQK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8832080C1
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765764361; cv=none; b=lKm7+gJ65yP7Ri0zg/dcBpPJa8Z3Ck2qAqpI8hgecrkUb3Q1VCLBT3xHy8liHD1Eq71pkN4dJzkHymp9f+eesivvw/cP4ydJYFnyHiPs5q1n/irHyNImUyTsz0VOojH5XfZOon3wCQXj/euGJRlz/PfpalL9vb29Ly7FEmik1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765764361; c=relaxed/simple;
	bh=SPnSNWBKPU+tPkuC2ETAf3LlJX/TXuCGoYuvo/NWO7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DME1Lw7MzhmlnKsbOhFTxdJo8BTvSKTpWNqjbtlbJMBDOoAsmxgEmO0IwIX3HzBOvQaJtj1eQ9WcYzGtS8JnAnWnziDwZplF0wS418qM1J3zhbtAORlUhm2cVdis5A91TnvXhn81eQ5fnUyLgi5m+X/oDQdLZ8Q/HIiUlRNCtCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kpt1dWQK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BF25t4E2867943, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765764355; bh=SPnSNWBKPU+tPkuC2ETAf3LlJX/TXuCGoYuvo/NWO7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kpt1dWQKgWTnckgwzXVQa5I+nXw+2S0bb1ireQUCg1P4mMmNxzvoo4hqyygxCy3hX
	 dUlqU7o29VuwUDXcckCbJ03WLkNBQ82FU2pnlrckp+19tVQIz/8HJ0XbimYup940h1
	 uzC4GE9unupLKBnic/9RGjWQO/1M2uDdlF7JDmdw9ZnwUI38iyWVVMR4N1WiZogPfh
	 qkMG2rZDa2Z7W8u0Ue05qcHQSN8zQxjtdu4y2Uzc495tH//N1d2H0zo/SNNKnLACmB
	 zR1lPSIVx6CrCcemvjWpI9fLlSUc7pnZ+ngGoagfN68i9eJffLNplDeUhYRfCG6ctv
	 ukFvSmzbIRtAg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BF25t4E2867943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 10:05:55 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 15 Dec 2025 10:05:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 15 Dec 2025 10:05:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Mon, 15 Dec 2025 10:05:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Gary Chang <gary.chang@realtek.com>, Damon Chen <damon.chen@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH rtw-next 04/12] wifi: rtw89: mac: reset power state before
 switching to power on
Thread-Topic: [PATCH rtw-next 04/12] wifi: rtw89: mac: reset power state
 before switching to power on
Thread-Index: AQHcaxVmur7pnqZfok+x26+OvPpxc7UhNjMAgAC/s8A=
Date: Mon, 15 Dec 2025 02:05:54 +0000
Message-ID: <05f1a2bbc0d344ea8c37481f9e1d26d4@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
 <20251212031303.19882-5-pkshih@realtek.com>
 <efc58c87-d391-4970-b9af-abdef9861342@gmail.com>
In-Reply-To: <efc58c87-d391-4970-b9af-abdef9861342@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOw0KPiBPbiAx
Mi8xMi8yMDI1IDA1OjEyLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gVG8gcnVuIHBvd2VyIG9u
IGZ1bmN0aW9uIHByb3Blcmx5LCByZXNldCBwb3dlciBzdGF0ZXMgKG9mZi9vbi9QUykgdG8NCj4g
PiBpbml0aWFsIHN0YXRlLiBPdGhlcndpc2UsIGl0IG1pZ2h0IGJlIHVudXNhYmxlIGR1ZSB0byBm
YWlsIHRvIHBvd2VyIG9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODkvbWFjLmMgICAgfCAgODkgKysrKysrKysrKysrLS0NCj4gPiAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuaCAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjX2JlLmMgfCAxMzAgKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9yZWcuaCAgICB8
ICAyNyArKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjQwIGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OS9tYWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFj
LmMNCj4gPiBpbmRleCBkNzhmYmU3M2UzNjUuLmJhNDM0NGE2NDBmNSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KPiA+IEBAIC0xNDc4LDEzICsx
NDc4LDExIEBAIHN0YXRpYyB2b2lkIHJ0dzg5X21hY19wb3dlcl9zd2l0Y2hfYm9vdF9tb2RlKHN0
cnVjdCBydHc4OV9kZXYgKnJ0d2RldikNCj4gPg0KPiA+ICBzdGF0aWMgaW50IHJ0dzg5X21hY19w
b3dlcl9zd2l0Y2goc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBib29sIG9uKQ0KPiA+ICB7DQo+
ID4gLSNkZWZpbmUgUFdSX0FDVCAxDQo+ID4gICAgICAgY29uc3Qgc3RydWN0IHJ0dzg5X21hY19n
ZW5fZGVmICptYWMgPSBydHdkZXYtPmNoaXAtPm1hY19kZWY7DQo+ID4gICAgICAgY29uc3Qgc3Ry
dWN0IHJ0dzg5X2NoaXBfaW5mbyAqY2hpcCA9IHJ0d2Rldi0+Y2hpcDsNCj4gPiAgICAgICBjb25z
dCBzdHJ1Y3QgcnR3ODlfcHdyX2NmZyAqIGNvbnN0ICpjZmdfc2VxOw0KPiA+ICAgICAgIGludCAo
KmNmZ19mdW5jKShzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpOw0KPiA+ICAgICAgIGludCByZXQ7
DQo+ID4gLSAgICAgdTggdmFsOw0KPiA+DQo+ID4gICAgICAgcnR3ODlfbWFjX3Bvd2VyX3N3aXRj
aF9ib290X21vZGUocnR3ZGV2KTsNCj4gPg0KPiA+IEBAIC0xNDk5LDEwICsxNDk3LDEwIEBAIHN0
YXRpYyBpbnQgcnR3ODlfbWFjX3Bvd2VyX3N3aXRjaChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYs
IGJvb2wgb24pDQo+ID4gICAgICAgaWYgKHRlc3RfYml0KFJUVzg5X0ZMQUdfRldfUkRZLCBydHdk
ZXYtPmZsYWdzKSkNCj4gPiAgICAgICAgICAgICAgIF9fcnR3ODlfbGVhdmVfcHNfbW9kZShydHdk
ZXYpOw0KPiA+DQo+ID4gLSAgICAgdmFsID0gcnR3ODlfcmVhZDMyX21hc2socnR3ZGV2LCBSX0FY
X0lDX1BXUl9TVEFURSwgQl9BWF9XTE1BQ19QV1JfU1RFX01BU0spOw0KPiA+IC0gICAgIGlmIChv
biAmJiB2YWwgPT0gUFdSX0FDVCkgew0KPiA+IC0gICAgICAgICAgICAgcnR3ODlfZXJyKHJ0d2Rl
diwgIk1BQyBoYXMgYWxyZWFkeSBwb3dlcmVkIG9uXG4iKTsNCj4gPiAtICAgICAgICAgICAgIHJl
dHVybiAtRUJVU1k7DQo+ID4gKyAgICAgaWYgKG9uKSB7DQo+ID4gKyAgICAgICAgICAgICByZXQg
PSBtYWMtPnJlc2V0X3B3cl9zdGF0ZShydHdkZXYpOw0KPiA+ICsgICAgICAgICAgICAgaWYgKHJl
dCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgICAgICB9DQo+
ID4NCj4gPiAgICAgICByZXQgPSBjZmdfZnVuYyA/IGNmZ19mdW5jKHJ0d2RldikgOiBydHc4OV9t
YWNfcHdyX3NlcShydHdkZXYsIGNmZ19zZXEpOw0KPiA+IEBAIC0xNTI5LDcgKzE1MjcsNiBAQCBz
dGF0aWMgaW50IHJ0dzg5X21hY19wb3dlcl9zd2l0Y2goc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2
LCBib29sIG9uKQ0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIHJldHVybiAwOw0KPiA+IC0j
dW5kZWYgUFdSX0FDVA0KPiA+ICB9DQo+ID4NCj4gPiAgaW50IHJ0dzg5X21hY19wd3Jfb24oc3Ry
dWN0IHJ0dzg5X2RldiAqcnR3ZGV2KQ0KPiA+IEBAIC0zOTMxLDYgKzM5MjgsODMgQEAgc3RhdGlj
IGludCBydHc4OV9tYWNfZmVhdF9pbml0KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldikNCj4gPiAg
ICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgcnR3ODlfbWFjX3Jl
c2V0X3B3cl9zdGF0ZV9heChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpDQo+ID4gK3sNCj4gPiAr
ICAgICBlbnVtIHJ0dzg5X2NvcmVfY2hpcF9pZCBjaGlwX2lkID0gcnR3ZGV2LT5jaGlwLT5jaGlw
X2lkOw0KPiA+ICsgICAgIHUzMiB2YWwzMjsNCj4gPiArICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4g
PiArICAgICB2YWwzMiA9IHJ0dzg5X3JlYWQzMihydHdkZXYsIFJfQVhfU1lTT05fRlNNX01PTik7
DQo+ID4gKyAgICAgdmFsMzIgJj0gV0xBTl9GU01fTUFTSzsNCj4gPiArICAgICB2YWwzMiB8PSBX
TEFOX0ZTTV9TRVQ7DQo+ID4gKyAgICAgcnR3ODlfd3JpdGUzMihydHdkZXYsIFJfQVhfU1lTT05f
RlNNX01PTiwgdmFsMzIpOw0KPiA+ICsNCj4gPiArICAgICByZXQgPSByZWFkX3BvbGxfdGltZW91
dChydHc4OV9yZWFkMzJfbWFzaywgdmFsMzIsIHZhbDMyID09IFdMQU5fRlNNX0lETEUsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTAwMCwgMjAwMDAwMCwgZmFsc2UsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcnR3ZGV2LCBSX0FYX1NZU09OX0ZTTV9NT04s
IFdMQU5fRlNNX1NUQVRFX01BU0spOw0KPiA+ICsgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAg
ICAgICAgIHJ0dzg5X2VycihydHdkZXYsICJbRVJSXVBvbGxpbmcgV0xBTiBQTUMgdGltZW91dD0g
JVhcbiIsIHZhbDMyKTsNCj4gPiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAg
fQ0KPiANCj4gSSBnZXQgdGhpcyBlcnJvciBtZXNzYWdlIHdpdGggZXZlcnkgQVggY2hpcCB0aGUg
Zmlyc3QgdGltZQ0KPiBydHc4OV9tYWNfcHdyX29uKCkgaXMgY2FsbGVkOg0KPiANCj4gWyAgKzAu
MDA3Mjg2XSBydHc4OV84ODUyYnUgMi00OjEuMDogbG9hZGVkIGZpcm13YXJlIHJ0dzg5L3J0dzg4
NTJiX2Z3LTEuYmluDQo+IFsgICsyLjAwMTI2MF0gcnR3ODlfODg1MmJ1IDItNDoxLjA6IFtFUlJd
UG9sbGluZyBXTEFOIFBNQyB0aW1lb3V0PSAxMDANCj4gDQo+IFRoZXkgc3RpbGwgd29yaywgYmVj
YXVzZSB0aGUgc2Vjb25kIGF0dGVtcHQgaW4gcnR3ODlfbWFjX3B3cl9vbigpDQo+IHN1Y2NlZWRz
Lg0KPiANCj4gQmVmb3JlIHRoaXMgcGF0Y2gsIHRoZSBtZXNzYWdlIHdhcyAiTUFDIGhhcyBhbHJl
YWR5IHBvd2VyZWQgb24iLg0KPiBUaGUgbmV3IG1lc3NhZ2Ugc2F5cyBpdCdzIGFuIGVycm9yLCBz
byBpdCB3aWxsIGNvbmZ1c2UgcGVvcGxlLg0KDQpJIGJvcnJvdyBhIDg4NTJBVSBhbmQgYSA4ODUy
Q1UgdGhhdCBib3RoIGRvbid0IGhhdmUgZXJyb3IgbWVzc2FnZXMuDQpUaGUgImZpcnN0IHRpbWUi
IHlvdSBtZWFudCBpcyBqdXN0IHRvIHBsdWcgdGhlIFVTQiBhZGFwdGVyPw0KSWYgc28sIEkgaGF2
ZSBub3QgaWRlYSBhYm91dCB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHlvdXJzIGFuZCBtaW5lLg0K
DQo+IA0KPiBJcyBpdCBwb3NzaWJsZSB0aGlzIGNvZGUgcmVsYXRlZCB0byBSX0FYX1NZU09OX0ZT
TV9NT04gaXMgbm90DQo+IGFwcGxpY2FibGUgdG8gVVNCPyBNeSBhZGFwdGVycyBzdGlsbCB3b3Jr
IGlmIEkgZGVsZXRlIGl0Lg0KDQpJJ20gY2hlY2tpbmcgaW50ZXJuYWwgZXhwZXJ0cy4gUXVpY2ts
eSBjaGVja2luZyB2ZW5kb3IgZHJpdmVyLCBJIGRvbid0IHNlZQ0KaXQgYXZvaWRzIGNhbGxpbmcg
dGhpcyBiZWNhdXNlIG9mIFVTQiBkZXZpY2VzLiANCg0KSWYgeW91IGRlbGV0ZSBjb2RlIHJlbGF0
ZWQgdG8gUl9BWF9TWVNPTl9GU01fTU9OLCB3aWxsIGl0IHNob3cgYmVsb3cgbWVzc2FnZXMNCnVu
ZGVyIHRoZSBjYXNlICd2YWwzMiA9PSBNQUNfQVhfTUFDX09OJz8NCg0KICAgIltFUlJdUG9sbGlu
ZyBNQUMgc3RhdGUgdGltZW91dD0gJVhcbiINCg0KPiANCj4gKEkgZG9uJ3QgZ2V0IHRoZSBlcnJv
ciB3aXRoIFJUTDg5MTJBVS4pDQo+IA0KDQpJJ20gYWRkaW5nIHRoaXMgcGF0Y2ggZm9yIFdpRmkg
NyBjaGlwcyBtYWlubHksIGFuZCB0aGlzIHNlZW1zIHRvIGJlIGV4cGVjdGVkLg0KDQo=

