Return-Path: <linux-wireless+bounces-22726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AAFAAF1AE
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 05:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DF5188F1F6
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 03:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5FE1EDA16;
	Thu,  8 May 2025 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rRlGZEjn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F5E1AA786
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746674976; cv=none; b=gzpIQ8W7anCJPkXO2B2QK8RfTEPnO80oVJEkmP4NQEvrxR3dnX0ZIAsd4d0yDFwIx+Y0h+918AidRO2f4oSp/DzuWBXhNw55cVktyH6pT9dLvphaZnGTFftU6unBLxSeGHFQTekxbyDWWJSnGnArZmOzCpTS+Nha85qLCHuMMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746674976; c=relaxed/simple;
	bh=0lcVPI6uV131UId+1O2YVo4qADvMsZIEGBGU/fDWUNQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SWRLvK2Y1OVj7WsMgfQV4EpHHK8RGuti7GdihINmc2JClMKeyxmlYSg0EcESfV8/JNh2EcAFlEF/+xwdWgFO58yb3G8lUe7y2X2WJvd/yWouQFKGwmxAlFVegFi575qG9MOm22DCqbRTRNUh6WhTNksCnuO3VpCpmZwKU5TeyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rRlGZEjn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5483TSZ301474001, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746674968; bh=0lcVPI6uV131UId+1O2YVo4qADvMsZIEGBGU/fDWUNQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rRlGZEjnGBAAZ5oLKQdcmCWvi+hvC8lRONCvHTuad9PrcYD858Q9G+KEHNfMepfEt
	 bIi2m0c1/XPUyhfn7wvf4SpmStWHgtEyfZTU72wxM5NIvvVOoZ4W4KLAfsTebgrsVa
	 OBABBxNvgVcTAP3ygH2QSs7c3FuMyG2PhMyLk5fwAt2YS+qlkePS/56gJ8RiHwGEMD
	 s3OfamNYij4aOAyJnIQk4O24JhRKriqZo22JLNwrazJMOxWDzUU5tr5sBdfeQnr3A/
	 Nj0AsVLsHumyndEmAZrTMPKKZ7LB0uCwwc/r+Dp1Fx/LH61n64fzelAOP2o6nbVy+R
	 Q/kznLRbCNuQg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5483TSZ301474001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 11:29:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 May 2025 11:29:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 May 2025 11:29:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 8 May 2025 11:29:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 2/2] wifi: rtw88: usb: Upload the firmware in bigger chunks
Thread-Topic: [PATCH rtw-next 2/2] wifi: rtw88: usb: Upload the firmware in
 bigger chunks
Thread-Index: AQHbv1CyImz0neihfUW5/jPo1pGLVLPID6gQ
Date: Thu, 8 May 2025 03:29:28 +0000
Message-ID: <670259643afc42f581632c7383fa7f3f@realtek.com>
References: <af4d2d58-f567-4bdf-841b-8345d21f7035@gmail.com>
 <9faaa45f-9ba8-46dc-b507-f97b3b6f52d3@gmail.com>
In-Reply-To: <9faaa45f-9ba8-46dc-b507-f97b3b6f52d3@gmail.com>
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

OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+IFJU
TDg4MTFBVSBzdG9wcyByZXNwb25kaW5nIGR1cmluZyB0aGUgZmlybXdhcmUgZG93bmxvYWQgb24g
c29tZSBzeXN0ZW1zOg0KPiANCj4gWyAgODA5LjI1NjQ0MF0gcnR3Xzg4MjFhdSA1LTIuMToxLjA6
IEZpcm13YXJlIHZlcnNpb24gNDIuNC4wLCBIMkMgdmVyc2lvbiAwDQo+IFsgIDgxMi43NTkxNDJd
IHJ0d184ODIxYXUgNS0yLjE6MS4wIHdscDQ4czBmNHUydTE6IHJlbmFtZWQgZnJvbSB3bGFuMA0K
PiBbICA4MzcuMzE1Mzg4XSBydHdfODgyMWF1IDEtNDoxLjA6IHdyaXRlIHJlZ2lzdGVyIDB4MWVm
NCBmYWlsZWQgd2l0aCAtMTEwDQo+IFsgIDg2Ny41MjQyNTldIHJ0d184ODIxYXUgMS00OjEuMDog
d3JpdGUgcmVnaXN0ZXIgMHgxZWY4IGZhaWxlZCB3aXRoIC0xMTANCj4gWyAgODY4LjkzMDk3Nl0g
cnR3Xzg4MjFhdSA1LTIuMToxLjAgd2xwNDhzMGY0dTJ1MTogZW50ZXJlZCBwcm9taXNjdW91cyBt
b2RlDQo+IFsgIDg5Ny43MzA5NTJdIHJ0d184ODIxYXUgMS00OjEuMDogd3JpdGUgcmVnaXN0ZXIg
MHgxZWZjIGZhaWxlZCB3aXRoIC0xMTANCj4gDQo+IE1heWJlIGl0IHRha2VzIHRvbyBsb25nIHdo
ZW4gd3JpdGluZyB0aGUgZmlybXdhcmUgNCBieXRlcyBhdCBhIHRpbWUuDQo+IA0KPiBXcml0ZSAx
OTYgYnl0ZXMgYXQgYSB0aW1lIGZvciBSVEw4ODIxQVUsIFJUTDg4MTFBVSwgYW5kIFJUTDg4MTJB
VSwNCj4gYW5kIDI1NCBieXRlcyBhdCBhIHRpbWUgZm9yIFJUTDg3MjNEVS4gVGhlc2UgYXJlIHRo
ZSBzaXplcyB1c2VkIGluDQo+IHRoZWlyIG9mZmljaWFsIGRyaXZlcnMuIFRlc3RlZCB3aXRoIGFs
bCB0aGVzZSBjaGlwcy4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IExpbms6
IGh0dHBzOi8vZ2l0aHViLmNvbS9sd2Zpbmdlci9ydHc4OC9pc3N1ZXMvMzQ0DQo+IFNpZ25lZC1v
ZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNClsuLl0NCg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMNCj4gaW5kZXggYjE2ZGI1NzlmZGNl
Li5hZDE1Y2UxMmFiN2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvdXNiLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC91c2IuYw0KPiBAQCAtMTY1LDYgKzE2NSw2MCBAQCBzdGF0aWMgdm9pZCBydHdfdXNiX3dyaXRl
MzIoc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwgdTMyIGFkZHIsIHUzMiB2YWwpDQo+ICAgICAgICAg
cnR3X3VzYl93cml0ZShydHdkZXYsIGFkZHIsIHZhbCwgNCk7DQo+ICB9DQo+IA0KPiArc3RhdGlj
IHZvaWQgcnR3X3VzYl93cml0ZV9maXJtd2FyZV9wYWdlKHN0cnVjdCBydHdfZGV2ICpydHdkZXYs
IHUzMiBwYWdlLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3QgdTggKmRhdGEsIHUzMiBzaXplKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBydHdfdXNiICpy
dHd1c2IgPSBydHdfZ2V0X3VzYl9wcml2KHJ0d2Rldik7DQo+ICsgICAgICAgc3RydWN0IHVzYl9k
ZXZpY2UgKnVkZXYgPSBydHd1c2ItPnVkZXY7DQo+ICsgICAgICAgdTMyIGFkZHIgPSBGV184MTky
Q19TVEFSVF9BRERSRVNTOw0KDQpGV184MTkyQ19TVEFSVF9BRERSRVNTIGlzIGV4aXN0aW5nIGFs
cmVhZHkuIEJ1dCBzb21ldGhpbmcgbGlrZQ0KUlRXX1VTQl9GV19TVEFSVF9BRERSRVNTIHdvdWxk
IGJlIGJldHRlci4gDQoNCj4gKyAgICAgICB1OCAqZGF0YV9kdXAsICpidWY7DQo+ICsgICAgICAg
dTMyIG4sIGJsb2NrX3NpemU7DQo+ICsgICAgICAgaW50IHJldDsNCj4gKw0KPiArICAgICAgIHN3
aXRjaCAocnR3ZGV2LT5jaGlwLT5pZCkgew0KPiArICAgICAgIGNhc2UgUlRXX0NISVBfVFlQRV84
NzIzRDoNCj4gKyAgICAgICAgICAgICAgIGJsb2NrX3NpemUgPSAyNTQ7DQo+ICsgICAgICAgICAg
ICAgICBicmVhazsNCj4gKyAgICAgICBkZWZhdWx0Og0KPiArICAgICAgICAgICAgICAgYmxvY2tf
c2l6ZSA9IDE5NjsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArICAgICAgIH0NCj4gKw0K
PiArICAgICAgIGRhdGFfZHVwID0ga21lbWR1cChkYXRhLCBzaXplLCBHRlBfS0VSTkVMKTsNCg0K
VGhpcyBpcyBiZWNhdXNlIHR5cGUgb2YgYXJndW1lbnQgYGRhdGFgIG9mIHVzYl9jb250cm9sX21z
ZygpIGlzIG5vdCBjb25zdCwgcmlnaHQ/DQpEbyB5b3Uga25vdyBpZiB1c2JfY29udHJvbF9tc2co
KSB3aWxsIGFjdHVhbGx5IG1vZGlmeSB0aGUgZGF0YT8NCg0KDQo=

