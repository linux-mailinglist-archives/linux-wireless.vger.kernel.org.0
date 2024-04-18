Return-Path: <linux-wireless+bounces-6474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D88A902C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 02:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318191F221C1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 00:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5BB6FD5;
	Thu, 18 Apr 2024 00:49:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACFC6FCB
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401379; cv=none; b=QQOuC0rikpOrQE9UCF4ZxrC7r1ff7Jd7pbvha8YOw+zOvthMsLV7B9GJYlLwCYz5Pu7Xlc/DlHDk0cHDgcFt7ui9U8CK5LAYGKVI4An3rZ4CbzicIUwxka4p1D6wuVs559sGl8JlHRMJVNIqJzzAF8Xg+RiajLCtzZyqMnQUCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401379; c=relaxed/simple;
	bh=qeplc9o84q36lLiCVpeaHu3Gart+W+5jNK+lSzfiPdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H+iMRKXtHEsX2JdWJeBkxdx2DRF1IYtOXJDxXdK3ObtAmfEZm6kBCaXPBKcFGR7w5sn3dUXTpo/sRWnCaqHrleVBZTiCL80ohjJWRBRhu5V6rd6r1szNRQhagr7XoNdbIhBgA75uAiAWRxI1ftraXdnQTRs1zHaob05JdtrGAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43I0nGEK13905430, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43I0nGEK13905430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 08:49:16 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 08:49:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 08:49:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 18 Apr 2024 08:49:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 5/6] wifi: rtlwifi: Clean up rtl8192d-common a bit
Thread-Topic: [PATCH v5 5/6] wifi: rtlwifi: Clean up rtl8192d-common a bit
Thread-Index: AQHaj3OR2Cu1t3yVw02tbAbaTVD7B7FrxRgQgABrIICAAQRbIA==
Date: Thu, 18 Apr 2024 00:49:16 +0000
Message-ID: <42113d0a089d4096aa1b5cc3861ac297@realtek.com>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
 <4e47c56c-4b7f-4ae6-84b9-05f0cac97dac@gmail.com>
 <72bd1a7172154d4e9a79678e5151cdf3@realtek.com>
 <ad6057a1-9d3b-4b2c-ac47-5df688f5bed5@gmail.com>
In-Reply-To: <ad6057a1-9d3b-4b2c-ac47-5df688f5bed5@gmail.com>
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
T24gMTcvMDQvMjAyNCAwOTo0OCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEJpdHRlcmJsdWUg
U21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+PiBAQCAtMjI4
LDM1ICsyMzgsMjUgQEAgc3RhdGljIHZvaWQgX3J0bDkyZF9maWxsX2gyY19jb21tYW5kKHN0cnVj
dCBpZWVlODAyMTFfaHcgKmh3LA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gPj4gICAgICAgICAgICAgICAgIH0NCj4gPj4gICAgICAgICB9DQo+ID4+ICsNCj4gPj4gICAg
ICAgICB3aGlsZSAoIWJ3cml0ZV9zdWNjZXNzKSB7DQo+ID4+ICAgICAgICAgICAgICAgICB3YWl0
X3dyaXRlaDJjX2xpbW1pdC0tOw0KPiA+PiAgICAgICAgICAgICAgICAgaWYgKHdhaXRfd3JpdGVo
MmNfbGltbWl0ID09IDApIHsNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJX
cml0ZSBIMkMgZmFpbCBiZWNhdXNlIG5vIHRyaWdnZXIgZm9yIEZXIElOVCFcbiIpOw0KPiA+PiAg
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPj4gICAgICAgICAgICAgICAgIH0NCj4g
Pj4gKw0KPiA+PiAgICAgICAgICAgICAgICAgYm94bnVtID0gcnRsaGFsLT5sYXN0X2htZWJveG51
bTsNCj4gPj4gICAgICAgICAgICAgICAgIHN3aXRjaCAoYm94bnVtKSB7DQo+ID4+IC0gICAgICAg
ICAgICAgICBjYXNlIDA6DQo+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgIGJveF9yZWcgPSBS
RUdfSE1FQk9YXzA7DQo+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgIGJveF9leHRyZWcgPSBS
RUdfSE1FQk9YX0VYVF8wOw0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4g
Pj4gLSAgICAgICAgICAgICAgIGNhc2UgMToNCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
Ym94X3JlZyA9IFJFR19ITUVCT1hfMTsNCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAgYm94
X2V4dHJlZyA9IFJFR19ITUVCT1hfRVhUXzE7DQo+ID4+IC0gICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiA+PiAtICAgICAgICAgICAgICAgY2FzZSAyOg0KPiA+PiAtICAgICAgICAgICAg
ICAgICAgICAgICBib3hfcmVnID0gUkVHX0hNRUJPWF8yOw0KPiA+PiAtICAgICAgICAgICAgICAg
ICAgICAgICBib3hfZXh0cmVnID0gUkVHX0hNRUJPWF9FWFRfMjsNCj4gPj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4+IC0gICAgICAgICAgICAgICBjYXNlIDM6DQo+ID4+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGJveF9yZWcgPSBSRUdfSE1FQk9YXzM7DQo+ID4+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGJveF9leHRyZWcgPSBSRUdfSE1FQk9YX0VYVF8zOw0KPiA+PiAr
ICAgICAgICAgICAgICAgY2FzZSAwIC4uLiAzOg0KPiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICBib3hfcmVnID0gUkVHX0hNRUJPWF8wICsgYm94bnVtICogNDsNCj4gPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgYm94X2V4dHJlZyA9IFJFR19ITUVCT1hfRVhUXzAgKyBib3hudW0gKiAyOw0K
PiA+DQo+ID4gU2hvdWxkIGJlICIqIDQiIGFzIHdlbGw/DQo+ID4NCj4gPiBib3hfZXh0cmVnID0g
UkVHX0hNRUJPWF9FWFRfMCArIGJveG51bSAqIDQ7DQo+ID4NCj4gDQo+IE5vLCBiZWNhdXNlIHRo
ZXkgYXJlIG9ubHkgdHdvIGJ5dGVzIGFwYXJ0IGluIHRoaXMgb2xkIGNoaXA6DQo+IA0KPiAjZGVm
aW5lIFJFR19ITUVCT1hfRVhUXzAgICAgICAgICAgICAgICAgMHgwMDg4DQo+ICNkZWZpbmUgUkVH
X0hNRUJPWF9FWFRfMSAgICAgICAgICAgICAgICAweDAwOEENCj4gI2RlZmluZSBSRUdfSE1FQk9Y
X0VYVF8yICAgICAgICAgICAgICAgIDB4MDA4Qw0KPiAjZGVmaW5lIFJFR19ITUVCT1hfRVhUXzMg
ICAgICAgICAgICAgICAgMHgwMDhFDQo+IA0KDQpTb3JyeSwgSSBtaXNyZWFkIHRoZW0gaW4gcnRs
ODE4OGVlL3JlZy5oLiANCg0KVG8gY2xlYXJseSBrbm93IHdoYXQgNCBhbmQgMiBhcmUsIGhvdyBh
Ym91dCB0byBkZWZpbmU6DQoNCiNkZWZpbmUgU0laRV9PRl9SRUdfSE1FQk9YIDQNCiNkZWZpbmUg
U0laRV9PRl9SRUdfSE1FQk9YX0VYVCAyDQoNCg0K

