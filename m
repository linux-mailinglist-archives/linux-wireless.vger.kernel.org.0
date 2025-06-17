Return-Path: <linux-wireless+bounces-24163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E3FADBE0A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 02:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D467C3B718B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106F71DA53;
	Tue, 17 Jun 2025 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ADeEFFYm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE015B0EC
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750119582; cv=none; b=eJDW9qUGV7Ki518jlUHOixzwMN+AffiYnC/0Y/nQn7f+CgYBAeqO4boeB0PoEtEeYCn3Kev0TcVQg0wjLTac2yYl2dClTdyiEcGhuW70pFnVaXWtqUP9gk6bIGTnJ98rpl1bYLwvg4qgofzpIhhtXj1AHHaBIJYPdPtGPiXue3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750119582; c=relaxed/simple;
	bh=1m2Ajf6Rw3irsOX6euATZlAn/834bqGsxVF6tUVb+kQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dmOH1sgNhR9Etl3v4rr5A3Rd1CD9nKfmMwCKlN4kR2VSddSxpGG283dcAG0EWNw/h+6kURv9cEhaFtY4FCT3YupyM4yt9VKZtoGkQ1r+btfEWiNWaA5VVP7cxvcoc7cPFVykuGKBXcX88d2HPeXwC1dfzlY5qsgjJr2aXl5+9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ADeEFFYm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55H0JUpQ41287079, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750119570; bh=1m2Ajf6Rw3irsOX6euATZlAn/834bqGsxVF6tUVb+kQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ADeEFFYmBsZ81qkAu4i62mdQHz4jLrEGnLeS//Ps58g8Bi5gNWCzh8LLqW19ftyuN
	 8pIgtyhU2deKYcd4BWbDqr/CxpqTAvufR283zZOl0f5L+3pfobTh1lnF6dMS9OXsWQ
	 QULqXWlPR/YUM6ndZ/O6uwrt8WoA/pnoDTHi+VgUXHrPpbmBQSxu7P81fdB4bK+Ke6
	 e428s0oolSu4DwVqz92Tq+jr5BOl+pekAK/+yBS9peIHkV5O41/tZZpNo02V31uaR7
	 bL6PN2gMvOAEm6nLqeKsi2OyCFas7ijaKpjgk+miL9qnRcR/9WtOc8D6KNG8QEvRID
	 RnNlliBEcehxQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55H0JUpQ41287079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 08:19:30 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Jun 2025 08:19:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 17 Jun 2025 08:19:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 17 Jun 2025 08:19:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 03/14] wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
Thread-Topic: [PATCH rtw-next v2 03/14] wifi: rtw89: Make hfc_param_ini in
 rtw89_chip_info an array
Thread-Index: AQHb2XRJk1S/xhBh70aY2evTrQI6trQFBhRAgAB/s4CAAQA/wA==
Date: Tue, 17 Jun 2025 00:19:32 +0000
Message-ID: <d3d87e77cca24babb6293ba498c4cff0@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <7e05e8a7-d7cd-4cc2-87c5-143ba30e8c54@gmail.com>
 <646f0e43faad458493a3f060e623232d@realtek.com>
 <90b1df9c-4cd1-41e5-8d39-d4d9e70ac4d5@gmail.com>
In-Reply-To: <90b1df9c-4cd1-41e5-8d39-d4d9e70ac4d5@gmail.com>
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
Ni8wNi8yMDI1IDA0OjI2LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBVU0IgYW5kIFNESU8gd2ls
bCBuZWVkIGRpZmZlcmVudCBzZXRzIG9mIHZhbHVlcywgc28gbWFrZSBoZmNfcGFyYW1faW5pDQo+
ID4+IGluIHN0cnVjdCBydHc4OV9jaGlwX2luZm8gYW4gYXJyYXkuDQo+ID4+DQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+
DQo+ID4gWy4uLl0NCj4gPg0KPiA+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9tYWMuYw0KPiA+PiBpbmRleCAyZWU3NjZlMzczMjIuLjBhMzYwM2YyZTZiZiAxMDA2NDQN
Cj4gPj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KPiA+
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jDQo+ID4+IEBA
IC04ODEsMTMgKzg4MSwxNCBAQCBzdGF0aWMgaW50IGhmY19yZXNldF9wYXJhbShzdHJ1Y3QgcnR3
ODlfZGV2ICpydHdkZXYpDQo+ID4NCj4gPiBCeSB0aGUgd2F5LCBwbGVhc2UgaGVscCB0byByZW1v
dmUgdGhlIGluaXRpYWxpemVyIG9mIHBhcmFtX2luaSwgd2hpY2ggaXMgd2VpcmQNCj4gPiBhbmQg
dW5uZWNlc3Nhcnk6DQo+ID4NCj4gPiAgICBzdHJ1Y3QgcnR3ODlfaGZjX3BhcmFtX2luaSBwYXJh
bV9pbmkgPSB7TlVMTH07DQo+ID4NCj4gPj4NCj4gPj4gICAgICAgICBzd2l0Y2ggKHJ0d2Rldi0+
aGNpLnR5cGUpIHsNCj4gPj4gICAgICAgICBjYXNlIFJUVzg5X0hDSV9UWVBFX1BDSUU6DQo+ID4+
IC0gICAgICAgICAgICAgICBwYXJhbV9pbmkgPSBydHdkZXYtPmNoaXAtPmhmY19wYXJhbV9pbmlb
cXRhX21vZGVdOw0KPiA+PiAtICAgICAgICAgICAgICAgcGFyYW0tPmVuID0gMDsNCj4gPj4gICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiA+PiAgICAgICAgIGRlZmF1bHQ6DQo+ID4+ICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPj4gICAgICAgICB9DQo+ID4+DQo+ID4+ICsgICAg
ICAgcGFyYW1faW5pID0gcnR3ZGV2LT5jaGlwLT5oZmNfcGFyYW1faW5pW3J0d2Rldi0+aGNpLnR5
cGVdW3F0YV9tb2RlXTsNCj4gPg0KPiA+IExpa2UgcGF0Y2ggMDIvMTQsIHdlIGNhbiByZW1vdmUg
c3dpdGNoLi4uY2FzZSBhYm92ZSwgYW5kIGNoZWNrDQo+ID4gcnR3ZGV2LT5jaGlwLT5oZmNfcGFy
YW1faW5pW3J0d2Rldi0+aGNpLnR5cGVdIHRvIGtub3cgaWYgd2UgY2FuIHN1cHBvcnQNCj4gPiBj
ZXJ0YWluIEhDSSwgbGlrZQ0KPiA+DQo+ID4gcGFyYW1faW5pcyA9IHJ0d2Rldi0+Y2hpcC0+aGZj
X3BhcmFtX2luaVtydHdkZXYtPmhjaS50eXBlXTsNCj4gPiBpZiAoIXBhcmFtX2luaXMpDQo+ID4g
ICAgIHJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gcGFyYW1faW5pID0gcGFyYW1faW5pc1txdGFf
bW9kZV07DQo+ID4NCj4gPg0KPiANCj4gVGhhdCByZW1pbmRzIG1lLCB3aHkgbWFrZSBhIGNvcHk/
IHBhcmFtX2luaSBjb3VsZCBiZSBhIHBvaW50ZXIgaW5zdGVhZC4NCg0KSSBndWVzcyB0aGlzIGlz
IGJlY2F1c2UgdmVuZG9yIGRyaXZlciBkb2VzLCBhbmQgcG9pbnRlciBpcyByZWFzb25hYmxlLg0K
DQo+IA0KPiA+PiArICAgICAgIHBhcmFtLT5lbiA9IDA7DQo+ID4+ICsNCj4gPj4gICAgICAgICBp
ZiAocGFyYW1faW5pLnB1Yl9jZmcpDQo+ID4+ICAgICAgICAgICAgICAgICBwYXJhbS0+cHViX2Nm
ZyA9ICpwYXJhbV9pbmkucHViX2NmZzsNCj4gPj4NCj4gPg0KPiA+DQo+IA0KDQo=

