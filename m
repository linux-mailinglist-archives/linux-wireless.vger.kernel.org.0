Return-Path: <linux-wireless+bounces-9031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 321E690A1AE
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 03:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA11C20F23
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 01:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47933E7;
	Mon, 17 Jun 2024 01:21:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81279F3
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587276; cv=none; b=Jvm9Jfcgp2zpUZTRIQ0pEEDbJWJDfIowz3G3aMm3O7LhHMwsPPcu/6i6S6h439jR+Ob5NL4F42TtI0qDJ4ADLguzAXZI74yWMWcMBPByvdTXBUInr4hrKe2XlyLe5P5IoJ8HSOPFxs3XhGHm6OVNogVNdf9XHZgD3ytoAwqadn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587276; c=relaxed/simple;
	bh=nMaAfIqIfS6Csp9EhYSELXc0mGMz6dRT8wplR5CQ2QY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YGtzw3tu0CvSFpK4euaBneKsDqCpweeWOFAEnouqs6Zo5rpG8p21g1CETR/8204ICGUaSep07cBCQaQDhJAZBFO0QiiQilIoL6rwixbD1jL9JptEJ6YSYhNb3HZQxFXY8hxeue1XWRY3Z/+F8JPPV4eoIhbIkXUTQpJ45iyG0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H1KojzE2502422, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H1KojzE2502422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 09:20:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 09:20:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Jun 2024 09:20:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 17 Jun 2024 09:20:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>,
        Bernie Huang
	<phhuang@realtek.com>, Kalle Valo <kvalo@kernel.org>
Subject: RE: [PATCH] wifi: rtw88: usb: unbreak multicast
Thread-Topic: [PATCH] wifi: rtw88: usb: unbreak multicast
Thread-Index: AQHavkWmcY2ok7kSBEaFEC4N+O1dg7HLKttQ
Date: Mon, 17 Jun 2024 01:20:48 +0000
Message-ID: <44061283fd014cbc898a382ed5c3c26b@realtek.com>
References: <CA+GA0_vcUneM4Uo8fg0=4sCK049uhjv+NskotRbNg9Em0cnyUQ@mail.gmail.com>
 <20240614102835.518348-1-mslusarz@renau.com>
In-Reply-To: <20240614102835.518348-1-mslusarz@renau.com>
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

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
SGlnaCBxdWV1ZSBpcyBub3QgZnVuY3Rpb25pbmcsIGZvciBzb21lIHJlYXNvbi4NCj4gQnJva2Vu
IGJ5IDA3NmY3ODZhMGFlMTRhODFmNDAzMTRiOTZhMmQ4MTVlMjY0YmMyMTMNCg0KUG9pbnRpbmcg
b3V0IDA3NmY3ODZhMGFlMSAoIndpZmk6IHJ0dzg4OiBGaXggQVAgbW9kZSBpbmNvcnJlY3QgRFRJ
TSBiZWhhdmlvciIpDQp3b3VsZCBiZSBjbGVhcmVyLiBQbGVhc2UgYWxzbyBtZW50aW9uZWQgdGhl
IGNoaXAgeW91IGFyZSB1c2luZy4gDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNpbiDFmmx1
c2FyeiA8bXNsdXNhcnpAcmVuYXUuY29tPg0KPiBDYzogUG8tSGFvIEh1YW5nIDxwaGh1YW5nQHJl
YWx0ZWsuY29tPg0KPiBDYzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENj
OiBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMgfCAzIC0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC91c2IuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNi
LmMNCj4gaW5kZXggYzI1ZmQ0YjE5M2E3Li5hYWNjNWExMDViMTUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYw0KPiBAQCAtNDkyLDkgKzQ5Miw2IEBAIHN0
YXRpYyB1OCBydHdfdXNiX3R4X3F1ZXVlX21hcHBpbmdfdG9fcXNlbChzdHJ1Y3Qgc2tfYnVmZiAq
c2tiKQ0KPiANCj4gICAgICAgICBpZiAodW5saWtlbHkoaWVlZTgwMjExX2lzX21nbXQoZmMpIHx8
IGllZWU4MDIxMV9pc19jdGwoZmMpKSkNCj4gICAgICAgICAgICAgICAgIHFzZWwgPSBUWF9ERVND
X1FTRUxfTUdNVDsNCj4gLSAgICAgICBlbHNlIGlmIChpc19icm9hZGNhc3RfZXRoZXJfYWRkciho
ZHItPmFkZHIxKSB8fA0KPiAtICAgICAgICAgICAgICAgIGlzX211bHRpY2FzdF9ldGhlcl9hZGRy
KGhkci0+YWRkcjEpKQ0KPiAtICAgICAgICAgICAgICAgcXNlbCA9IFRYX0RFU0NfUVNFTF9ISUdI
Ow0KDQpJIHRoaW5rIGJyb2FkY2FzdC9tdWx0aWNhc3QgcGFja2V0cyBzaG91bGQgZ28gdmlhIEhJ
R0ggcXVldWUgaXMgY29ycmVjdCwgYnV0DQpzb21laG93IHJlZ2lzdGVycyBhcmVuJ3QgY29uZmln
dXJlZCBjb3JyZWN0bHkuIEJlcm5pZSAoeW91IGhhdmUgQ0MnZWQpIHdpbGwNCmhlbHAgdG8gY2hl
Y2sgcmVnaXN0ZXJzLiANCg0KDQo+ICAgICAgICAgZWxzZSBpZiAoc2tiX2dldF9xdWV1ZV9tYXBw
aW5nKHNrYikgPD0gSUVFRTgwMjExX0FDX0JLKQ0KPiAgICAgICAgICAgICAgICAgcXNlbCA9IHNr
Yi0+cHJpb3JpdHk7DQo+ICAgICAgICAgZWxzZQ0KPiAtLQ0KPiAyLjI1LjENCg0K

