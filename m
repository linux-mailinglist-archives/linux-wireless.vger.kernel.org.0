Return-Path: <linux-wireless+bounces-29129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D10EFC6D8C7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 10:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5D7C4F49B1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 08:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6A430AADC;
	Wed, 19 Nov 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ImeXJzQ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEC309EFD
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542430; cv=none; b=CdkLflMCMzd4RETK860CYLPTBYfzNgmEuBS+NjIFkC5vtMTiOSMaqFyQ5JeDMMotpq27kqVOzkpEcfYZm8QmitbtdMbTp7iTmq4UpX5ZtQZFFwssqQEfNwVBIoZsNLai2AETgMtGQtkPJu5TkqMH0Vc8wSSXE3MC7qFiZJ+G/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542430; c=relaxed/simple;
	bh=+FXE1bkzOT2s5neWHeR20yLhPj0a8mcMh/HHhThr2O0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ylua/zyY9VIwX7W+c4/M+n+pPBjnWEK/rnkFK5AFoM6fVmO+MZhXOZajutYQjfHNxtARqksQeXr1++ecDqfMqz3nvZxYiR4GxUHz7/4Td0mbx1EJ9pWboDBZdzPFiiOej6m1DxZZqE8V8tR46WKPHt+RiTpSVWQTH390pgPlakg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ImeXJzQ9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AJ8ranhF3208372, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763542416; bh=+FXE1bkzOT2s5neWHeR20yLhPj0a8mcMh/HHhThr2O0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ImeXJzQ9EfdEDniml52rNO2T2g/tcC2yX7YxaNsCuLxB1Rb2h79y9rDrZ61dbcyVg
	 RULnULWcYbzo7uhS+SuWWGs8pZwxIM0Fq/eR3SKVLBfWvK3clMmQeigU6AWyOedHR+
	 8jHj4YISDlkcy1o3TDNm+TwZmFCoTu7/IiKTxqNg4LM9VWFms9sPGXiJfyhQlqxw2R
	 aS3yKyQDP3lhWmzpQEju8qDC5HnAUVWA2FK2oamrGNZFPkHKQ7RH4JgMhRbl9pDchX
	 Nz5NRM7tdkbB2GJ4pAPoIS7BzLVPXwKSZPJ7ZF/EVoYpsOaXVEydqA0FlMMcjJQRTQ
	 dIOr0MOeUtzTA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AJ8ranhF3208372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 16:53:36 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 19 Nov 2025 16:53:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 19 Nov 2025 16:53:35 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 19 Nov 2025 16:53:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/2] wifi: rtw89: avoid to use not consecutive
 mask in __write_ctrl()
Thread-Topic: [PATCH rtw-next 2/2] wifi: rtw89: avoid to use not consecutive
 mask in __write_ctrl()
Thread-Index: AQHcV3KBvgjpTd8EgUGsgARAAsxhxbT3upqAgAF1nJD///pwgIAAiZbQ
Date: Wed, 19 Nov 2025 08:53:35 +0000
Message-ID: <575ad4ca8f0b4409ab78ffc63e34a49b@realtek.com>
References: <20251117032910.11224-1-pkshih@realtek.com>
 <20251117032910.11224-3-pkshih@realtek.com>
 <CAMuHMdUx6qY66bCcGsm1YHK3=H+=Td6YM_gsXJ=UgjAYJpGo0Q@mail.gmail.com>
 <c19306a1d41f4946801cf1c5b70c8528@realtek.com>
 <CAMuHMdUu9=4ypfR69_hQpVAuh-mciwtpLsVv0eBa5KX4KTYjxw@mail.gmail.com>
In-Reply-To: <CAMuHMdUu9=4ypfR69_hQpVAuh-mciwtpLsVv0eBa5KX4KTYjxw@mail.gmail.com>
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
bmctS2UsDQo+IA0KPiBPbiBXZWQsIDE5IE5vdiAyMDI1IGF0IDAyOjE1LCBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVy
dEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6DQo+ID4gPiBPbiBNb24sIDE3IE5vdiAyMDI1IGF0IDA0
OjMwLCBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiA+IFRo
ZSBwb3dlciB2YWx1ZSBhbmQgZW5hYmxlIGJpdCBmaWVsZHMgY2FuIGJlIG5vdCBjb25zZWN1dGl2
ZSBtYXNrLCBidXQNCj4gPiA+ID4gbm9ybWFsbHkgd2UgZXhwZWN0IG1hc2sgYXJndW1lbnQgb2Yg
cnR3ODlfbWFjX3R4cHdyX3dyaXRlMzJfbWFzaygpIGlzDQo+ID4gPiA+IGNvbnNlY3V0aXZlIGJp
dCBtYXNrLiBUaGVyZWZvcmUsIGNoYW5nZSB0aGUgY29kZSBhY2NvcmRpbmdseS4NCj4gPiA+ID4N
Cj4gPiA+ID4gQ2M6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
PiA+ID4NCj4gPiA+IFRoYW5rcyBmb3IgeW91ciBwYXRjaCENCj4gPiA+DQo+ID4gPiBSZXZpZXdl
ZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPiA+
DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmgN
Cj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuaA0K
PiA+ID4gPiBAQCAtMTQ1Niw2ICsxNDU2LDI2IEBAIHN0YXRpYyBpbmxpbmUgaW50IHJ0dzg5X21h
Y190eHB3cl93cml0ZTMyX21hc2soc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0KPiA+ID4gPiAg
ICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIGlu
bGluZQ0KPiA+ID4gPiArdm9pZCBydHc4OV9tYWNfd3JpdGVfdHhwd3JfY3RybChzdHJ1Y3QgcnR3
ODlfZGV2ICpydHdkZXYsIHUzMiByZWcsIHUzMiBtYXNrLCB1MzIgdmFsLA0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiBtYXNrX2VuLCBib29sIGNvbmQpDQo+ID4g
PiA+ICt7DQo+ID4gPiA+ICsgICAgICAgdTMyIHdydCA9IHUzMl9lbmNvZGVfYml0cyh2YWwsIG1h
c2spOw0KPiA+ID4NCj4gPiA+IE5pdDogeW91IGNvdWxkIGRvIHdpdGhvdXQgdGhpcyB2YXJpYWJs
ZS4uLg0KPiA+ID4NCj4gPiA+ID4gKyAgICAgICB1MzIgdmFsMzI7DQo+ID4gPiA+ICsgICAgICAg
aW50IHJldDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIGlmIChjb25kKQ0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAgd3J0IHw9IG1hc2tfZW47DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAg
ICByZXQgPSBydHc4OV9tYWNfdHhwd3JfcmVhZDMyKHJ0d2RldiwgUlRXODlfUEhZXzAsIHJlZywg
JnZhbDMyKTsNCj4gPiA+ID4gKyAgICAgICBpZiAocmV0KQ0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgcmV0dXJuOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgdmFsMzIgJj0gfihtYXNrIHwg
bWFza19lbik7DQo+ID4gPiA+ICsgICAgICAgdmFsMzIgfD0gd3J0Ow0KPiA+ID4NCj4gPiA+IHZh
bDMyIHw9IHUzMl9lbmNvZGVfYml0cyh2YWwsIG1hc2spOw0KPiA+ID4gaWYgKGNvbmQpDQo+ID4g
PiAgICAgICAgIGNhbDMyIHw9IG1hc2tfZW47DQo+ID4NCj4gPiBXaXRoIHRoaXMgY2hhbmdlLCBB
UkNIIGFybSBpcyBmYWlsZWQgdG8gYnVpbGQgKHg4NiBpcyB3ZWxsKToNCj4gPg0KPiA+IEluIGZp
bGUgaW5jbHVkZWQgZnJvbSAvYnVpbGQvcnR3ODkvY29yZS5oOjksDQo+ID4gICAgICAgICAgICAg
ICAgICBmcm9tIC9idWlsZC9ydHc4OS9jb2V4Lmg6OCwNCj4gPiAgICAgICAgICAgICAgICAgIGZy
b20gL2J1aWxkL3J0dzg5L3J0dzg4NTFiLmM6NToNCj4gPiBJbiBmdW5jdGlvbiAnZmllbGRfbXVs
dGlwbGllcicsDQo+ID4gICAgIGlubGluZWQgZnJvbSAnZmllbGRfbWFzaycgYXQgLi9pbmNsdWRl
L2xpbnV4L2JpdGZpZWxkLmg6MTcwOjE3LA0KPiA+ICAgICBpbmxpbmVkIGZyb20gJ3UzMl9lbmNv
ZGVfYml0cycgYXQgLi9pbmNsdWRlL2xpbnV4L2JpdGZpZWxkLmg6MjAwOjEsDQo+ID4gICAgIGlu
bGluZWQgZnJvbSAncnR3ODlfbWFjX3dyaXRlX3R4cHdyX2N0cmwnIGF0IC9idWlsZC9ydHc4OS9t
YWMuaDoxNDY4OjExOg0KPiA+IC4vaW5jbHVkZS9saW51eC9iaXRmaWVsZC5oOjE2NToxNzogZXJy
b3I6IGNhbGwgdG8gJ19fYmFkX21hc2snIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIGVycm9yOiBi
YWQNCj4gYml0ZmllbGQgbWFzaw0KPiA+ICAgMTY1IHwgICAgICAgICAgICAgICAgIF9fYmFkX21h
c2soKTsNCj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn4NCj4gPiBJbiBm
dW5jdGlvbiAnZmllbGRfbXVsdGlwbGllcicsDQo+IA0KPiBIbW0uLi4NCj4gDQo+IE5vdGUgdGhh
dCB1MzJfZW5jb2RlX2JpdHMoKSByZWFsbHkgcmVxdWlyZXMgYSBjb25zdGFudCBtYXNrLCBqdXN0
DQo+IGxpa2UgRklFTERfUFJFUCgpLiAgU28gcHJvYmFibHkgdGhlIGNvbXBpbGVyIGNhbiBubyBs
b25nZXIgZGVkdWNlIGl0DQo+IGlzIGNhbGxlZCB3aXRoIGEgY29uc3RhbnQgYWZ0ZXIgcmVzdHJ1
Y3R1cmluZyB0aGUgY29kZS4uLg0KDQpEbyB5b3UgdGhpbmsgSSBuZWVkIHRvIGFkZCBhIG1hY3Jv
IHRvIGdlbmVyYXRlIG1hc2sgd2l0aCB1MzJfZW5jb2RlX2JpdHMoKQ0KYW5kIHRoZW4gY2FsbCB0
aGlzIGlubGluZSBmdW5jdGlvbj8gIA0KDQpPciwgY29tcGlsZXIgY2FuIGFsd2F5cyBkZWR1Y2Ug
aXQgaW4gdGhlIGlubGluZSBmdW5jdGlvbiwgYW5kIGN1cnJlbnQgdmVyc2lvbg0KaXMgb2theT8N
Cg0KDQo=

