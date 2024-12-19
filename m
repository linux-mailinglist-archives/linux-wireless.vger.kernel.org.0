Return-Path: <linux-wireless+bounces-16583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DD09F7539
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 08:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B391885B69
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D37082A;
	Thu, 19 Dec 2024 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wtPu2kzX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A032566
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734592705; cv=none; b=tjquYMRkrG9LR0ZOma9VkmTbn7vOvcEJmFUPhf/YMT9qHgHooRURbKdEGO6+GhayDAnH3goksn1h53y7bVneyfoHibcMbGUjEe1j1URapO73yevsvJZBzbqGqXwZE/rpQx1lixvwgwH32dtfAd4nvWvtFlI8LAjMhGPEJw2G9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734592705; c=relaxed/simple;
	bh=dNWwWU25geRZmEFo/8r1T9U1/yB9WnCMbYGIx7o595A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k4w11UEhv67W2PqdWMIHM1lSgGcODt8RipLWoTrOnojUeYqIuum3RhqgUmIV/1Wz+JEbw31mlAPb8I0YgxKKLhc7CgK4NyqotdaOoFDnx5b3Swq1M+vX2XKVG8/3nqjqECGtn6aaimcrMU3i7V21jZT+FnhR+HatBjaBlbyWvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wtPu2kzX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BJ7I78j83624712, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1734592688; bh=dNWwWU25geRZmEFo/8r1T9U1/yB9WnCMbYGIx7o595A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wtPu2kzX5/o7FukyBgleI0ta5neeG6NAwq9SIn+aA/yK6d6739qASHryQ4CBgZjcQ
	 dlin1EDcQevzQ0bt5GnqOurDOWXNId0CGX0tx23bgKrkIbaGFa7TQ+DGsvdixXtqEA
	 wevNgAm5hBM+KNn5Srg0Wv/kIYwBJ3CkgXuYp8yqnjv5D0EurDROJwaoQP5gnhv4Hz
	 xqqTiCfGGUeI4Ah0lHQu9UzriAOHBfLCekxPudkFF8aNr/vFd2X3oCPFHWFYSVUkjj
	 nZ4e4W5B91SL6VtcGzVaoNvOeV1WV3zy4INvo/SZbUAXpEGnfxqxu0hEvPzYV+27z/
	 RypcAJgUP6fvw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BJ7I78j83624712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 15:18:07 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Dec 2024 15:18:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Dec 2024 15:18:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 19 Dec 2024 15:18:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2 3/3] wifi: rtw88: usb: Preallocate and reuse the RX skbs
Thread-Topic: [PATCH v2 3/3] wifi: rtw88: usb: Preallocate and reuse the RX
 skbs
Thread-Index: AQHbUZ001FX1trdaAk2mIPU23RYTG7LtJ3wQ
Date: Thu, 19 Dec 2024 07:18:07 +0000
Message-ID: <bcc4baa8e91445348dfe896cc7d2cae4@realtek.com>
References: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
 <9cee7a34-c38d-4128-824d-0ec139ca5a4e@gmail.com>
In-Reply-To: <9cee7a34-c38d-4128-824d-0ec139ca5a4e@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
VVNCIGRyaXZlciB1c2VzIGZvdXIgVVNCIFJlcXVlc3QgQmxvY2tzIGZvciBSWC4gQmVmb3JlIHN1
Ym1pdHRpbmcNCj4gb25lLCBpdCBhbGxvY2F0ZXMgYSAzMjc2OCBieXRlIHNrYiBmb3IgdGhlIFJY
IGRhdGEuIFRoaXMgYWxsb2NhdGlvbiBjYW4NCj4gZmFpbCwgbWF5YmUgZHVlIHRvIHRlbXBvcmFy
eSBtZW1vcnkgZnJhZ21lbnRhdGlvbi4gV2hlbiB0aGUgYWxsb2NhdGlvbg0KPiBmYWlscywgdGhl
IGNvcnJlc3BvbmRpbmcgVVJCIGlzIG5ldmVyIHN1Ym1pdHRlZCBhZ2Fpbi4gQWZ0ZXIgZm91ciBz
dWNoDQo+IGFsbG9jYXRpb24gZmFpbHVyZXMsIGFsbCBSWCBzdG9wcyBiZWNhdXNlIHRoZSBkcml2
ZXIgaXMgbm90IHJlcXVlc3RpbmcNCj4gZGF0YSBmcm9tIHRoZSBkZXZpY2UgYW55bW9yZS4NCj4g
DQo+IERvbid0IGFsbG9jYXRlIGEgMzI3NjggYnl0ZSBza2Igd2hlbiBzdWJtaXR0aW5nIGEgVVNC
IFJlcXVlc3QgQmxvY2sNCj4gKHdoaWNoIGhhcHBlbnMgdmVyeSBvZnRlbikuIEluc3RlYWQgcHJl
YWxsb2NhdGUgOCBzdWNoIHNrYnMsIGFuZCByZXVzZQ0KPiB0aGVtIG92ZXIgYW5kIG92ZXIuIElm
IGFsbCA4IGFyZSBidXN5LCBhbGxvY2F0ZSBhIG5ldyBvbmUuIFRoaXMgaXMNCj4gcHJldHR5IHJh
cmUuIElmIHRoZSBhbGxvY2F0aW9uIGZhaWxzLCB1c2UgYSB3b3JrIHRvIHRyeSBhZ2FpbiBsYXRl
ci4NCj4gV2hlbiB0aGVyZSBhcmUgZW5vdWdoIGZyZWUgc2ticyBhZ2FpbiwgZnJlZSB0aGUgZXhj
ZXNzIHNrYnMuDQo+IA0KPiBBbHNvLCB1c2UgV1FfQkggZm9yIHRoZSBSWCB3b3JrcXVldWUuIFdp
dGggYSBub3JtYWwgb3IgaGlnaCBwcmlvcml0eQ0KPiB3b3JrcXVldWUgdGhlIHNrYnMgYXJlIHBy
b2Nlc3NlZCB0b28gc2xvd2x5IHdoZW4gdGhlIHN5c3RlbSBpcyBldmVuIGENCj4gbGl0dGxlIGJ1
c3ksIGxpa2Ugd2hlbiBvcGVuaW5nIGEgbmV3IHBhZ2UgaW4gYSBicm93c2VyLCBhbmQgdGhlIGRy
aXZlcg0KPiBydW5zIG91dCBvZiBmcmVlIHNrYnMgYW5kIGFsbG9jYXRlcyBhIGxvdCBvZiBuZXcg
b25lcy4NCj4gDQo+IFRoaXMgaXMgbW9yZSBvciBsZXNzIHdoYXQgdGhlIG91dC1vZi10cmVlIFJl
YWx0ZWsgZHJpdmVycyBkbywgZXhjZXB0DQo+IHRoZXkgdXNlIGEgdGFza2xldCBpbnN0ZWFkIG9m
IGEgQkggd29ya3F1ZXVlLg0KPiANCj4gVGVzdGVkIHdpdGggUlRMODcyM0RVLCBSVEw4ODIxQVUs
IFJUTDg4MTJBVSwgUlRMODgxMkJVLCBSVEw4ODIyQ1UsDQo+IFJUTDg4MTFDVS4NCj4gDQo+IENs
b3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvNmU3ZWNiNDctN2Vh
MC00MzNhLWExOWYtMDVmODhhMmVkZjZiQGdtYWlsLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogQml0
dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5n
LUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo+IA0KPiAtICAgICAgIGVycm9yID0g
dXNiX3N1Ym1pdF91cmIocnhjYi0+cnhfdXJiLCBHRlBfQVRPTUlDKTsNCj4gKyAgICAgICBlcnJv
ciA9IHVzYl9zdWJtaXRfdXJiKHJ4Y2ItPnJ4X3VyYiwgZ2ZwKTsNCj4gICAgICAgICBpZiAoZXJy
b3IpIHsNCj4gLSAgICAgICAgICAgICAgIGtmcmVlX3NrYihyeGNiLT5yeF9za2IpOw0KPiArICAg
ICAgICAgICAgICAgc2tiX3F1ZXVlX3RhaWwoJnJ0d3VzYi0+cnhfZnJlZV9xdWV1ZSwgcnhjYi0+
cnhfc2tiKTsNCj4gKw0KPiAgICAgICAgICAgICAgICAgaWYgKGVycm9yICE9IC1FTk9ERVYpDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHJ0d19lcnIocnR3ZGV2LCAiRXJyIHNlbmRpbmcgcngg
ZGF0YSB1cmIgJWRcbiIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJyb3Ip
Ow0KDQpMb29raW5nIGludG8gdXNiX3N1Ym1pdF91cmIoKSwgSSB0aGluayBFTk9ERVYgbWVhbnMg
VVNCIGRldmljZSBiZWNvbWVzDQp1bmF2YWlsYWJsZS4gRm9yIHRoaXMgY2FzZSwgaXQgc2VlbXMg
d2VsbCBmb3IgcnhjYiBtaXNzZWQgdG8gYXR0YWNoIFJYIFVSQg0KYW55bW9yZSwgbm90ICdnb3Rv
IHRyeV9sYXRlcicuDQoNCj4gKw0KPiArICAgICAgICAgICAgICAgaWYgKGVycm9yID09IC1FTk9N
RU0pDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdHJ5X2xhdGVyOw0KPiArICAgICAg
IH0NCj4gKw0KPiArICAgICAgIHJldHVybjsNCj4gKw0KPiArdHJ5X2xhdGVyOg0KPiArICAgICAg
IHJ4Y2ItPnJ4X3NrYiA9IE5VTEw7DQo+ICsgICAgICAgcXVldWVfd29yayhydHd1c2ItPnJ4d3Es
ICZydHd1c2ItPnJ4X3VyYl93b3JrKTsNCj4gK30NCg0KDQo=

