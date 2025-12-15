Return-Path: <linux-wireless+bounces-29737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46382CBC2EF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 02:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D8B53007AB1
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA9026E175;
	Mon, 15 Dec 2025 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Co3ZwOR9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1497EEAB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765761868; cv=none; b=k+NvIkgyvhlFTBU4ScvZces4kQLdsRykNwTuzHeITNdnaue7BYqiJUNB3MdUgKr5wGfid9qCbnXM5BkJ/yfHlQ+SFbfNb4id6xTHks1e36e19tYJrpRxU35ejzVRJi65ddFZBlpWezYT0vuzfqcFp8eQhEXl9o6knoLe/wx1n1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765761868; c=relaxed/simple;
	bh=BiOqj2DZzPhJhdevlWsbdiPfE/N5fPTzrlin6pTWY9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TC638+LwSyDt4SWbPf+2ecAkIoRGiA4e6EC/Ap2rzDN7TPMBeR3YhJjE/bbzp79vsPvHaHktF31A4dq69iCqms7uT6HtIna3M4xILdb9UHFJTCsiSY9Ywgl8HG2YX+oOzFa5G7VpjQESMRM+VI392XGr/Oem9ahTvAKlPpqd/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Co3ZwOR9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BF1OLEp8780227, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765761861; bh=BiOqj2DZzPhJhdevlWsbdiPfE/N5fPTzrlin6pTWY9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Co3ZwOR9erzcu35LAdtYuoFoZ8iou8cocB3wmnO+9TfSnwNSLMBcx8v1vtQZB6J7e
	 xe7kjKQ2KCNy7zEh6ViUe31ylmnxXWhBWRgVrCoLJMRRsu+vezK3+F2L+9/3gQArLl
	 ttiz5cGnDrlq9C9qfitXIMPh3bSAxPhJ0GV139vwtoYv0V+Urr/gXCL8xNyaNeKbnr
	 G/jgtNwmLP8DBg/EQ4qzbVDXmAw/TY9k4nRe5lm6zhFHNCyhJHWj0fd7T2aeMpmGhn
	 DtcWigHLZrIPrpn1wPbZOPXdKRCUuZC72QhV2rMbaH2G47Q1gzdWp2m7rfy3nhFJHJ
	 OQ4M42DL2tTbg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BF1OLEp8780227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 09:24:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 15 Dec 2025 09:24:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Mon, 15 Dec 2025 09:24:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Gary Chang <gary.chang@realtek.com>, Damon Chen <damon.chen@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>
Subject: RE: [PATCH rtw-next 10/12] wifi: rtw89: warn unexpected polling value
 of XTAL SI
Thread-Topic: [PATCH rtw-next 10/12] wifi: rtw89: warn unexpected polling
 value of XTAL SI
Thread-Index: AQHcaxWAgztgMSLCWEKtOs/EGPvJcbUhNqoAgACxpqA=
Date: Mon, 15 Dec 2025 01:24:22 +0000
Message-ID: <37be87bfd5c64af1b0631071d09bf297@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
 <20251212031303.19882-11-pkshih@realtek.com>
 <fffdce20-1cc0-4e51-babf-2a759ed37444@gmail.com>
In-Reply-To: <fffdce20-1cc0-4e51-babf-2a759ed37444@gmail.com>
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
Mi8xMi8yMDI1IDA1OjEzLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gWFRBTCBTSSBpcyBhbiBp
bmRpcmVjdCBzZXJpYWwgaW50ZXJmYWNlIHRvIGFjY2VzcyByZWdpc3RlcnMgaW4gYW5vdGhlcg0K
PiA+IGhhcmR3YXJlIGRvbWFpbi4gV2hlbiBCVCBkcml2ZXIgaW5pdGlhbGl6ZXMgVUFSVCBpbnRl
cmZhY2UsIGZpcm13YXJlIG1pZ2h0DQo+ID4gcmFyZWx5IGNvbnRyb2wgWFRBTCBTSSBhdCB0aGUg
c2FtZSB0aW1lIGNhdXNpbmcgYWNjZXNzIHJhY2luZy4NCj4gPg0KPiA+IEN1cnJlbnQgaXMgdG8g
YWRqdXN0IGluaXRpYWxpemF0aW9uIGZsb3cgdG8gYXZvaWQgdGhlIHJhY2luZy4gVG8gbWFrZQ0K
PiA+IHRoZSByYWNpbmcgdmlzaWJsZSBpZiBpdCBzdGlsbCBwcmVzZW50cywgYWRkIGEgbWVzc2Fn
ZSB0byBhZGRyZXNzIHRoaXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OS9tYWMuYyAgICB8IDExICsrKysrKysrKystDQo+ID4gIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjX2JlLmMgfCAxMSArKysrKysrKysrLQ0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gPiBpbmRleCBjZjM2
YmUxNjcxNjIuLjA2NmM5OWYzZTUzYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OS9tYWMuYw0KPiA+IEBAIC03MDIzLDYgKzcwMjMsMTEgQEAgaW50IHJ0dzg5
X21hY193cml0ZV94dGFsX3NpX2F4KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTggb2Zmc2V0
LCB1OCB2YWwsIHU4DQo+IG0NCj4gPiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gICAg
ICAgfQ0KPiA+DQo+ID4gKyAgICAgaWYgKHUzMl9nZXRfYml0cyh2YWwzMiwgQl9BWF9XTF9YVEFM
X1NJX0FERFJfTUFTSykgIT0gb2Zmc2V0IHx8DQo+ID4gKyAgICAgICAgIHUzMl9nZXRfYml0cyh2
YWwzMiwgQl9BWF9XTF9YVEFMX1NJX0RBVEFfTUFTSykgIT0gdmFsKQ0KPiA+ICsgICAgICAgICAg
ICAgcnR3ODlfd2FybihydHdkZXYsICJ4dGFsIHNpIHdyaXRlOiBvZmZzZXQ9JXggdmFsPSV4IHBv
bGw9JXhcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIG9mZnNldCwgdmFsLCB2YWwz
Mik7DQo+ID4gKw0KPiANCj4gVGhpcyBtZXNzYWdlIGFwcGVhcnMgc2V2ZXJhbCB0aW1lcyBhZnRl
ciBJIHVucGx1ZyBhIFVTQiBhZGFwdGVyOg0KPiANCj4gWyAgKzAuODM0NDQ1XSBydHc4OV84ODUx
YnUgMS0yOjEuMjogeHRhbCBzaSB3cml0ZTogb2Zmc2V0PTkwIHZhbD0xMCBwb2xsPTANCj4gWyAg
KzAuMDAwMDE1XSBydHc4OV84ODUxYnUgMS0yOjEuMjogeHRhbCBzaSB3cml0ZTogb2Zmc2V0PTkw
IHZhbD0wIHBvbGw9MA0KPiBbICArMC4wMDAwMDddIHJ0dzg5Xzg4NTFidSAxLTI6MS4yOiB4dGFs
IHNpIHdyaXRlOiBvZmZzZXQ9OTAgdmFsPTAgcG9sbD0wDQo+IFsgICswLjAwMDAwNF0gcnR3ODlf
ODg1MWJ1IDEtMjoxLjI6IHh0YWwgc2kgd3JpdGU6IG9mZnNldD04MCB2YWw9MCBwb2xsPTANCj4g
WyAgKzAuMDAwMDA1XSBydHc4OV84ODUxYnUgMS0yOjEuMjogeHRhbCBzaSB3cml0ZTogb2Zmc2V0
PTkwIHZhbD04MCBwb2xsPTANCj4gWyAgKzAuMDAwMDA1XSBydHc4OV84ODUxYnUgMS0yOjEuMjog
eHRhbCBzaSB3cml0ZTogb2Zmc2V0PTkwIHZhbD0wIHBvbGw9MA0KPiBbICArMC4wMDAwMDRdIHJ0
dzg5Xzg4NTFidSAxLTI6MS4yOiB4dGFsIHNpIHdyaXRlOiBvZmZzZXQ9OTAgdmFsPTAgcG9sbD0w
DQo+IA0KDQpJIHRoaW5rIHRoaXMgaXMgYmVjYXVzZSBpdCBjYWxscyB0aGlzIGZ1bmN0aW9uIGR1
cmluZyBwb3dlci1vZmYuDQoNCldpdGggYWRkaXRpb25hbCBjaGFuZ2VzIGJlbG93LCB3aWxsIGl0
IGF2b2lkIHdhcm5pbmcgaW4geW91ciBzaWRlPw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODkvbWFjLmMNCmluZGV4IDdmZmIwMzllN2QxYi4uOTExM2VmZTAwYTk0IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KQEAgLTE0ODMsNiArMTQ4Mywx
MSBAQCBzdGF0aWMgdm9pZCBydHc4OV9tYWNfcG93ZXJfc3dpdGNoX2Jvb3RfbW9kZShzdHJ1Y3Qg
cnR3ODlfZGV2ICpydHdkZXYpDQogICAgICAgIHJ0dzg5X3dyaXRlMzJfY2xyKHJ0d2RldiwgUl9B
WF9SU1ZfQ1RSTCwgQl9BWF9SX0RJU19QUlNUKTsNCiB9DQoNCitzdGF0aWMgaW50IHJ0dzg5X21h
Y19wd3Jfb2ZmX2Z1bmNfZm9yX3VucGx1Z2dlZChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpDQor
ew0KKyAgICAgICByZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGludCBydHc4OV9tYWNfcG93ZXJf
c3dpdGNoKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgYm9vbCBvbikNCiB7DQogICAgICAgIGNv
bnN0IHN0cnVjdCBydHc4OV9tYWNfZ2VuX2RlZiAqbWFjID0gcnR3ZGV2LT5jaGlwLT5tYWNfZGVm
Ow0KQEAgLTE0OTcsOCArMTUwMiwxMyBAQCBzdGF0aWMgaW50IHJ0dzg5X21hY19wb3dlcl9zd2l0
Y2goc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBib29sIG9uKQ0KICAgICAgICAgICAgICAgIGNm
Z19zZXEgPSBjaGlwLT5wd3Jfb25fc2VxOw0KICAgICAgICAgICAgICAgIGNmZ19mdW5jID0gY2hp
cC0+b3BzLT5wd3Jfb25fZnVuYzsNCiAgICAgICAgfSBlbHNlIHsNCi0gICAgICAgICAgICAgICBj
Zmdfc2VxID0gY2hpcC0+cHdyX29mZl9zZXE7DQotICAgICAgICAgICAgICAgY2ZnX2Z1bmMgPSBj
aGlwLT5vcHMtPnB3cl9vZmZfZnVuYzsNCisgICAgICAgICAgICAgICBpZiAodGVzdF9iaXQoUlRX
ODlfRkxBR19VTlBMVUdHRUQsIHJ0d2Rldi0+ZmxhZ3MpKSB7DQorICAgICAgICAgICAgICAgICAg
ICAgICBjZmdfc2VxID0gTlVMTDsNCisgICAgICAgICAgICAgICAgICAgICAgIGNmZ19mdW5jID0g
cnR3ODlfbWFjX3B3cl9vZmZfZnVuY19mb3JfdW5wbHVnZ2VkOw0KKyAgICAgICAgICAgICAgIH0g
ZWxzZSB7DQorICAgICAgICAgICAgICAgICAgICAgICBjZmdfc2VxID0gY2hpcC0+cHdyX29mZl9z
ZXE7DQorICAgICAgICAgICAgICAgICAgICAgICBjZmdfZnVuYyA9IGNoaXAtPm9wcy0+cHdyX29m
Zl9mdW5jOw0KKyAgICAgICAgICAgICAgIH0NCiAgICAgICAgfQ0KDQogICAgICAgIGlmICh0ZXN0
X2JpdChSVFc4OV9GTEFHX0ZXX1JEWSwgcnR3ZGV2LT5mbGFncykpDQoNCg0KDQoNCg==

