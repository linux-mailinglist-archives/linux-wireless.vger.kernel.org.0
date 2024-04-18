Return-Path: <linux-wireless+bounces-6473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78C8A9019
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933071C21181
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 00:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2CCA40;
	Thu, 18 Apr 2024 00:43:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C6811
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401013; cv=none; b=cGWg+6/OBrbfVQjPb0u/rwPiaHgQfgEMHEa3nwQJl4J+5S4D8Nl6ibTNkNN80ZBFWrrnUS7G1/CWa8Sg7u3Z0h4U+Prk8e9VrxAqe6TcOdWMwb/k0viaatvbXG2pf5g2Wb7cSjdVGM9XEgajQis5xsgUyi6kacBktSoBeP5UK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401013; c=relaxed/simple;
	bh=1fcvqKmaLHbbYec++6Pk6L547tuV2yWMOny/9R/Y0JE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TMmI5VFCix6hri/0LED1IjZIju8p/iwpKwitgcCihEg+/2rUCiKzb+ZgbA8tIoAZBXGxcnC11iuFyqepg+S19Q1L9WFTIRwqa1A1FmmjY6wW1oDiAeTN4sFMndNI4P4nBQ3EfSdJ6PtA55qoc6tO4Lb88I7xY/qYW1gjboyQ4Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I0gwfV73901812, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I0gwfV73901812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 08:42:58 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 08:42:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 08:42:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 18 Apr 2024 08:42:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 4/6] wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
Thread-Topic: [PATCH v5 4/6] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Thread-Index: AQHaj3NVaoRcNWiOCkuEgyRUHzdMS7Frx8LQgABf4gCAAQqpwA==
Date: Thu, 18 Apr 2024 00:42:58 +0000
Message-ID: <36d691bf126d41fbbec3278918cd0498@realtek.com>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
 <bc799ce8-f73d-475e-9858-5b2c9fee0fe3@gmail.com>
 <3bab3540ac644c879624ac200730fbee@realtek.com>
 <c7015899-da29-4357-9bab-6d1f68e43420@gmail.com>
In-Reply-To: <c7015899-da29-4357-9bab-6d1f68e43420@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
T24gMTcvMDQvMjAyNCAwNzowNCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEJpdHRlcmJsdWUg
U21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCj4gPj4NCj4gDQo+IFsuLi5d
DQo+IA0KPiA+PiArc3RhdGljIHZvaWQgX3J0bDkyZGVfcmVhZF9hZGFwdGVyX2luZm8oc3RydWN0
IGllZWU4MDIxMV9odyAqaHcpDQo+ID4+ICt7DQo+ID4+ICsgICAgICAgc3RydWN0IHJ0bF9wcml2
ICpydGxwcml2ID0gcnRsX3ByaXYoaHcpOw0KPiA+PiArICAgICAgIHN0cnVjdCBydGxfZWZ1c2Ug
KnJ0bGVmdXNlID0gcnRsX2VmdXNlKHJ0bF9wcml2KGh3KSk7DQo+ID4+ICsgICAgICAgc3RydWN0
IHJ0bF9oYWwgKnJ0bGhhbCA9IHJ0bF9oYWwocnRsX3ByaXYoaHcpKTsNCj4gPj4gKyAgICAgICBp
bnQgcGFyYW1zW10gPSB7UlRMODE5MF9FRVBST01fSUQsIEVFUFJPTV9WSUQsIEVFUFJPTV9ESUQs
DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIEVFUFJPTV9TVklELCBFRVBST01fU01JRCwg
RUVQUk9NX01BQ19BRERSX01BQzBfOTJELA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICBF
RVBST01fQ0hBTk5FTF9QTEFOLCBFRVBST01fVkVSU0lPTiwgRUVQUk9NX0NVU1RPTUVSX0lELA0K
PiA+PiArICAgICAgICAgICAgICAgICAgICAgICBDT1VOVFJZX0NPREVfV09STERfV0lERV8xM307
DQo+ID4+ICsgICAgICAgaW50IGk7DQo+ID4+ICsgICAgICAgdTE2IHVzdmFsdWU7DQo+ID4+ICsg
ICAgICAgdTggKmh3aW5mbzsNCj4gPj4gKw0KPiA+PiArICAgICAgIGh3aW5mbyA9IGt6YWxsb2Mo
SFdTRVRfTUFYX1NJWkUsIEdGUF9LRVJORUwpOw0KPiA+PiArICAgICAgIGlmICghaHdpbmZvKQ0K
PiA+PiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+PiArDQo+ID4+ICsgICAgICAgaWYgKHJ0
bF9nZXRfaHdpbmZvKGh3LCBydGxwcml2LCBIV1NFVF9NQVhfU0laRSwgaHdpbmZvLCBwYXJhbXMp
KQ0KPiA+PiArICAgICAgICAgICAgICAgZ290byBleGl0Ow0KPiA+PiArDQo+ID4+ICsgICAgICAg
X3J0bDkyZGVfZWZ1c2VfdXBkYXRlX2NoaXBfdmVyc2lvbihodyk7DQo+ID4+ICsgICAgICAgX3J0
bDkyZGVfcmVhZF9tYWNwaHltb2RlX2FuZF9iYW5kdHlwZShodywgaHdpbmZvKTsNCj4gPj4gKw0K
PiA+PiArICAgICAgIC8qIFJlYWQgUGVybWFuZW50IE1BQyBhZGRyZXNzIGZvciAybmQgaW50ZXJm
YWNlICovDQo+ID4+ICsgICAgICAgaWYgKHJ0bGhhbC0+aW50ZXJmYWNlaW5kZXggIT0gMCkgew0K
PiA+PiArICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IDY7IGkgKz0gMikgew0KPiA+PiAr
ICAgICAgICAgICAgICAgICAgICAgICB1c3ZhbHVlID0gKih1MTYgKikmaHdpbmZvW0VFUFJPTV9N
QUNfQUREUl9NQUMxXzkyRCArIGldOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAqKCh1
MTYgKikoJnJ0bGVmdXNlLT5kZXZfYWRkcltpXSkpID0gdXN2YWx1ZTsNCj4gPg0KPiA+IENvcHlp
bmcgdTE2IGxvb2tzIHdlaXJkLiBJIGd1ZXNzIGl0IHdvdWxkIGxpa2UgdG8gc3dhcCBieXRlcyAo
ZW5kaWFuIHByb2JsZW0pLg0KPiA+IEF0IGxlYXN0IGl0IHNob3VsZCBiZSAnX19sZTE2JyBvciAn
X19iZTE2JyBiZWNhdXNlIGh3aW5mb1tdIGlzIGZyb20gZWZ1c2UuDQo+ID4NCj4gDQo+IEl0IGlz
IHdlaXJkLiBydGxfZ2V0X2h3aW5mbygpIGluIGVmdXNlLmMgZG9lcyB0aGUgc2FtZSB0aGluZy4N
Cj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBjb2RlIGlzIHN3YXBwaW5nIHRoZSBieXRlcy4gV2hh
dCByZWFzb24gY2FuDQo+IGl0IGhhdmUgdG8gc3dhcCB0aGVtIGFueXdheT8NCj4gDQo+IE1heWJl
IGl0J3MgYSAocXVlc3Rpb25hYmxlKSBvcHRpbWlzYXRpb24sIG9ubHkgdGhyZWUgY29waWVzDQo+
IGluc3RlYWQgb2Ygc2l4Lg0KPiANCg0KSWYgdGhhdCBqdXN0IHdhbnQgdG8gY29weSBhZGRyZXNz
LCB3ZSBjYW4gdXNlIGV0aGVyX2FkZHJfY29weSgpIGluc3RlYWQuDQpJIHdhcyBhZnJhaWQgdGhl
IG9yZGVyIG9mIGVmdXNlIGlzIGRpZmZlcmVudCBmcm9tIGRldl9hZGRyW10sIGJ1dCBsb29rIGFn
YWluLg0KVGhlIGJ5dGUgb3JkZXIgc2VlbXMgdGhlIHNhbWUsIHJpZ2h0Pw0KDQoNCg==

