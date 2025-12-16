Return-Path: <linux-wireless+bounces-29765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FA4CC05A3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 01:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64CC3301E200
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24365252904;
	Tue, 16 Dec 2025 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Hpnue4tD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CBF1D63D8
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765845010; cv=none; b=IZTk8Idqtq7v9oMkgTcJpvWQKtAFdMOL3k547E2K8wjGKWwYN3lp6Wl7Dfnj3IGcy5tBMyVGL7u2KIJ9hIQodvrkBNCdMrHOVGQPSdn970rTtJYlcg+AkYKitoBz4MG+C923OVR7nDGRscpSm2cyfbTipW2tFopTnBR5ay9zhZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765845010; c=relaxed/simple;
	bh=RmQNlvxlWlvC858prKFDWZ+fkbCx09G9dlJH9eFVQA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V+BjcpUHhBmM1qUbQLvVI0wLyXFHpJOJyv72GMyQMdAjyoghj2f/bepNcASOWW32iDWPr+xc1yU10oxtM4MkH+isAwsHpCf4X94S+HyLJr5o/fBXEMLBZ83WNgqfrGZvAIxJjbrOGK6KrtktnfXuugAXa5p1pEesZEKbNBORe14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Hpnue4tD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BG0TtNZ22863491, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765844995; bh=RmQNlvxlWlvC858prKFDWZ+fkbCx09G9dlJH9eFVQA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Hpnue4tD9cjjv+I0+cwV7eHojVK9whMil6dFn116a9I27KkxPP7xHVmLKOLSGU7IU
	 WFi08ATD/1jGszeOe7aUp9OxcbOrWsLxmiYgnM2Vb7SGHyMAoLvZOnAQy4xuFr9/VB
	 OtGyjmz9KBYawsE4GI8iRnJPHAaSJ0NqRHSBSpiUKrq3lYTXuk5yR9/DCuxLhXrkqG
	 t3RP1HZRMfjeIHjwoMNyGJp/dbAiIkWiZh2bWRKBZ9puiXuIG9pYT3QSlFutKc4sP+
	 dL0/pSLX6ktrC4POXiMeCUf9CYDcLtuk+XBz/oT1bYks9hgshSSABFrfIhAXC3fXeF
	 oluqFLpYWp+bA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BG0TtNZ22863491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 08:29:55 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 16 Dec 2025 08:29:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 16 Dec 2025 08:29:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Tue, 16 Dec 2025 08:29:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Gary Chang <gary.chang@realtek.com>, Damon Chen <damon.chen@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH rtw-next 10/12] wifi: rtw89: warn unexpected polling value
 of XTAL SI
Thread-Topic: [PATCH rtw-next 10/12] wifi: rtw89: warn unexpected polling
 value of XTAL SI
Thread-Index: AQHcaxWAgztgMSLCWEKtOs/EGPvJcbUhNqoAgACxpqCAANuKAIAArAGQ
Date: Tue, 16 Dec 2025 00:29:55 +0000
Message-ID: <a47515441bf1441fbaf26386820a87f2@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
 <20251212031303.19882-11-pkshih@realtek.com>
 <fffdce20-1cc0-4e51-babf-2a759ed37444@gmail.com>
 <37be87bfd5c64af1b0631071d09bf297@realtek.com>
 <01840faf-b330-45ff-93c0-f7f094e5e75d@gmail.com>
In-Reply-To: <01840faf-b330-45ff-93c0-f7f094e5e75d@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
NS8xMi8yMDI1IDAzOjI0LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiAxMi8xMi8yMDI1IDA1
OjEzLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+PiBYVEFMIFNJIGlzIGFuIGluZGlyZWN0IHNl
cmlhbCBpbnRlcmZhY2UgdG8gYWNjZXNzIHJlZ2lzdGVycyBpbiBhbm90aGVyDQo+ID4+PiBoYXJk
d2FyZSBkb21haW4uIFdoZW4gQlQgZHJpdmVyIGluaXRpYWxpemVzIFVBUlQgaW50ZXJmYWNlLCBm
aXJtd2FyZSBtaWdodA0KPiA+Pj4gcmFyZWx5IGNvbnRyb2wgWFRBTCBTSSBhdCB0aGUgc2FtZSB0
aW1lIGNhdXNpbmcgYWNjZXNzIHJhY2luZy4NCj4gPj4+DQo+ID4+PiBDdXJyZW50IGlzIHRvIGFk
anVzdCBpbml0aWFsaXphdGlvbiBmbG93IHRvIGF2b2lkIHRoZSByYWNpbmcuIFRvIG1ha2UNCj4g
Pj4+IHRoZSByYWNpbmcgdmlzaWJsZSBpZiBpdCBzdGlsbCBwcmVzZW50cywgYWRkIGEgbWVzc2Fn
ZSB0byBhZGRyZXNzIHRoaXMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogUGluZy1LZSBT
aGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jICAgIHwgMTEgKysrKysrKysrKy0NCj4gPj4+ICBk
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hY19iZS5jIHwgMTEgKysrKysrKysr
Ky0NCj4gPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODkvbWFjLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5j
DQo+ID4+PiBpbmRleCBjZjM2YmUxNjcxNjIuLjA2NmM5OWYzZTUzYSAxMDA2NDQNCj4gPj4+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gPj4+ICsrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gPj4+IEBAIC03MDIz
LDYgKzcwMjMsMTEgQEAgaW50IHJ0dzg5X21hY193cml0ZV94dGFsX3NpX2F4KHN0cnVjdCBydHc4
OV9kZXYgKnJ0d2RldiwgdTggb2Zmc2V0LCB1OCB2YWwsIHU4DQo+ID4+IG0NCj4gPj4+ICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPj4+ICAgICAgIH0NCj4gPj4+DQo+ID4+PiArICAgICBp
ZiAodTMyX2dldF9iaXRzKHZhbDMyLCBCX0FYX1dMX1hUQUxfU0lfQUREUl9NQVNLKSAhPSBvZmZz
ZXQgfHwNCj4gPj4+ICsgICAgICAgICB1MzJfZ2V0X2JpdHModmFsMzIsIEJfQVhfV0xfWFRBTF9T
SV9EQVRBX01BU0spICE9IHZhbCkNCj4gPj4+ICsgICAgICAgICAgICAgcnR3ODlfd2FybihydHdk
ZXYsICJ4dGFsIHNpIHdyaXRlOiBvZmZzZXQ9JXggdmFsPSV4IHBvbGw9JXhcbiIsDQo+ID4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0LCB2YWwsIHZhbDMyKTsNCj4gPj4+ICsNCj4g
Pj4NCj4gPj4gVGhpcyBtZXNzYWdlIGFwcGVhcnMgc2V2ZXJhbCB0aW1lcyBhZnRlciBJIHVucGx1
ZyBhIFVTQiBhZGFwdGVyOg0KPiA+Pg0KPiA+PiBbICArMC44MzQ0NDVdIHJ0dzg5Xzg4NTFidSAx
LTI6MS4yOiB4dGFsIHNpIHdyaXRlOiBvZmZzZXQ9OTAgdmFsPTEwIHBvbGw9MA0KPiA+PiBbICAr
MC4wMDAwMTVdIHJ0dzg5Xzg4NTFidSAxLTI6MS4yOiB4dGFsIHNpIHdyaXRlOiBvZmZzZXQ9OTAg
dmFsPTAgcG9sbD0wDQo+ID4+IFsgICswLjAwMDAwN10gcnR3ODlfODg1MWJ1IDEtMjoxLjI6IHh0
YWwgc2kgd3JpdGU6IG9mZnNldD05MCB2YWw9MCBwb2xsPTANCj4gPj4gWyAgKzAuMDAwMDA0XSBy
dHc4OV84ODUxYnUgMS0yOjEuMjogeHRhbCBzaSB3cml0ZTogb2Zmc2V0PTgwIHZhbD0wIHBvbGw9
MA0KPiA+PiBbICArMC4wMDAwMDVdIHJ0dzg5Xzg4NTFidSAxLTI6MS4yOiB4dGFsIHNpIHdyaXRl
OiBvZmZzZXQ9OTAgdmFsPTgwIHBvbGw9MA0KPiA+PiBbICArMC4wMDAwMDVdIHJ0dzg5Xzg4NTFi
dSAxLTI6MS4yOiB4dGFsIHNpIHdyaXRlOiBvZmZzZXQ9OTAgdmFsPTAgcG9sbD0wDQo+ID4+IFsg
ICswLjAwMDAwNF0gcnR3ODlfODg1MWJ1IDEtMjoxLjI6IHh0YWwgc2kgd3JpdGU6IG9mZnNldD05
MCB2YWw9MCBwb2xsPTANCj4gPj4NCj4gPg0KPiA+IEkgdGhpbmsgdGhpcyBpcyBiZWNhdXNlIGl0
IGNhbGxzIHRoaXMgZnVuY3Rpb24gZHVyaW5nIHBvd2VyLW9mZi4NCj4gPg0KPiA+IFdpdGggYWRk
aXRpb25hbCBjaGFuZ2VzIGJlbG93LCB3aWxsIGl0IGF2b2lkIHdhcm5pbmcgaW4geW91ciBzaWRl
Pw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvbWFjLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jDQo+ID4g
aW5kZXggN2ZmYjAzOWU3ZDFiLi45MTEzZWZlMDBhOTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gPiBAQCAtMTQ4Myw2ICsxNDgzLDExIEBA
IHN0YXRpYyB2b2lkIHJ0dzg5X21hY19wb3dlcl9zd2l0Y2hfYm9vdF9tb2RlKHN0cnVjdCBydHc4
OV9kZXYgKnJ0d2RldikNCj4gPiAgICAgICAgIHJ0dzg5X3dyaXRlMzJfY2xyKHJ0d2RldiwgUl9B
WF9SU1ZfQ1RSTCwgQl9BWF9SX0RJU19QUlNUKTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBp
bnQgcnR3ODlfbWFjX3B3cl9vZmZfZnVuY19mb3JfdW5wbHVnZ2VkKHN0cnVjdCBydHc4OV9kZXYg
KnJ0d2RldikNCj4gPiArew0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+
ID4gIHN0YXRpYyBpbnQgcnR3ODlfbWFjX3Bvd2VyX3N3aXRjaChzdHJ1Y3QgcnR3ODlfZGV2ICpy
dHdkZXYsIGJvb2wgb24pDQo+ID4gIHsNCj4gPiAgICAgICAgIGNvbnN0IHN0cnVjdCBydHc4OV9t
YWNfZ2VuX2RlZiAqbWFjID0gcnR3ZGV2LT5jaGlwLT5tYWNfZGVmOw0KPiA+IEBAIC0xNDk3LDgg
KzE1MDIsMTMgQEAgc3RhdGljIGludCBydHc4OV9tYWNfcG93ZXJfc3dpdGNoKHN0cnVjdCBydHc4
OV9kZXYgKnJ0d2RldiwgYm9vbCBvbikNCj4gPiAgICAgICAgICAgICAgICAgY2ZnX3NlcSA9IGNo
aXAtPnB3cl9vbl9zZXE7DQo+ID4gICAgICAgICAgICAgICAgIGNmZ19mdW5jID0gY2hpcC0+b3Bz
LT5wd3Jfb25fZnVuYzsNCj4gPiAgICAgICAgIH0gZWxzZSB7DQo+ID4gLSAgICAgICAgICAgICAg
IGNmZ19zZXEgPSBjaGlwLT5wd3Jfb2ZmX3NlcTsNCj4gPiAtICAgICAgICAgICAgICAgY2ZnX2Z1
bmMgPSBjaGlwLT5vcHMtPnB3cl9vZmZfZnVuYzsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHRl
c3RfYml0KFJUVzg5X0ZMQUdfVU5QTFVHR0VELCBydHdkZXYtPmZsYWdzKSkgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGNmZ19zZXEgPSBOVUxMOw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGNmZ19mdW5jID0gcnR3ODlfbWFjX3B3cl9vZmZfZnVuY19mb3JfdW5wbHVnZ2VkOw0K
PiA+ICsgICAgICAgICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGNmZ19zZXEgPSBjaGlwLT5wd3Jfb2ZmX3NlcTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBjZmdfZnVuYyA9IGNoaXAtPm9wcy0+cHdyX29mZl9mdW5jOw0KPiA+ICsgICAgICAgICAgICAg
ICB9DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIGlmICh0ZXN0X2JpdChSVFc4OV9G
TEFHX0ZXX1JEWSwgcnR3ZGV2LT5mbGFncykpDQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gDQo+IFll
cywgd2l0aCB0aGlzIHRoZSB3YXJuaW5ncyBkb24ndCBhcHBlYXIgYW55bW9yZS4NCg0KVGhhbmtz
IGZvciB0aGUgZmVlZGJhY2suIEkgd2lsbCBzcXVhc2ggdGhpcyBjaGFuZ2UgaW50byBvcmlnaW5h
bCBwYXRjaCBieSB2Mi4NCg0K

