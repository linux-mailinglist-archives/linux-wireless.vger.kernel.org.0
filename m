Return-Path: <linux-wireless+bounces-26576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F77BB33614
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 07:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBED3B7EBF
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 05:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E425A2BB;
	Mon, 25 Aug 2025 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="F6kTq608"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF221F5619
	for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101456; cv=none; b=cUu4ZuoSn+bbyD2597WZ/cEEzdvta0zCGG6SUaVfdJXNdOK6XpP3HuboCRBVKlAwAuiJxKGNzmZcGtsEvBYTgbMS3V4CkIK6+CZQgHlFES/r8Kt2xbiHXcaylZoce/Osnje0yYPGG/+Mrs3hiq7iaMURjYjsgwEbBheyfvejRJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101456; c=relaxed/simple;
	bh=OXDZoy11eJY1VMKdj291/lOt82THrHoXBflJybSdv/c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SmPp4uLi4MnboRnfR9Y2dmlxm402wQaXvJICIe8l6Zdp+wuqDWGMs5H3cVdVmI0qt73FsLgodC9i8oIDY+LoRF5wcfGUtHgRkwk5KuUMyGAP7D4mRK33LWa+k7a4fpKotnMVI3P5A+R74i1hSZSaBWOlAolc0VrzJwxA1WvCdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=F6kTq608; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57P5vTdyD2233824, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756101449; bh=OXDZoy11eJY1VMKdj291/lOt82THrHoXBflJybSdv/c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=F6kTq608yhUpXLrF4P2aiSar2t3ELq66RBSjqG9KRZ6iBc3kJACxSO/vQNOAfvq5G
	 PbdijSpivK3HXltR1TD1XhYo2HJD0s43hz79AbybS569Fjh9xWQr7eOe+RWwsP1ozm
	 cAX2wVdoqaLDlU4NjU9xr0rgxSgHBw37Eax+/abuJL456930FNBqB2Nwv1yPWbeFkK
	 0UrUzfutD5W9rZ9dF2PYEgI3HuDqJm8+MwG8xBSWoBrs/DuSnP5wGcDCWKAoB082z4
	 FF1AWPj3A76tsGNA0uk4ZZkA6mRWafTSCkzeujr3w1f6yL7Vs3gngmM/xwFHT8BRpd
	 glTMlsQ9HRWRQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57P5vTdyD2233824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 13:57:29 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 25 Aug 2025 13:57:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 25 Aug 2025 13:57:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Mon, 25 Aug 2025 13:57:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KHQvNC40YDQvdC+0LI=?=
	<debugger94@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: Remove TL-WN722N V2 from untested devices
Thread-Topic: Remove TL-WN722N V2 from untested devices
Thread-Index: AQHcE0qp+1KL1vhWdkOEst7MHC1MGrRy4ccg
Date: Mon, 25 Aug 2025 05:57:28 +0000
Message-ID: <6851d6d86fb84b2d8f5a787906bc58cd@realtek.com>
References: <CAAN7eZ7QKEeQgNHEBuZKy4Gqg3oqpGi6BUdOVBOxPN7dedhVJQ@mail.gmail.com>
In-Reply-To: <CAAN7eZ7QKEeQgNHEBuZKy4Gqg3oqpGi6BUdOVBOxPN7dedhVJQ@mail.gmail.com>
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

0JDQu9C10LrRgdC10Lkg0KHQvNC40YDQvdC+0LIgPGRlYnVnZ2VyOTRAZ21haWwuY29tPiB3cm90
ZToNCj4gSSBoYXZlIGJlZW4gdXNpbmcgdGhpcyBXaS1GaSBkb25nbGUgZm9yIG1hbnkgeWVhcnMg
bm93IGFuZCBoYXZlIGhhZCBubw0KPiBwcm9ibGVtcyB3aXRoIGl0LiBUaGUgZGV2aWNlIGlzIHF1
aXRlIG9sZCBhbmQga25vd24sIGR1bXBpbmcgaXRzIGVmdXNlIHRvDQo+IHRoZSBsb2cgYW5kIGFz
a2luZyB0aGUgdXNlciB0byBzZW5kIHRoZSByZXN1bHRzIHRvIEplcy5Tb3JlbnNlbkBnbWFpbC5j
b20NCj4gb24gZXZlcnkgYm9vdCBtYWtlcyBsaXR0bGUgc2Vuc2UuIFBsZWFzZSBhcHBseToNCg0K
SSdsbCByZXBocmFzZSBjb21taXQgbWVzc2FnZSB3aGVuIEkgbWVyZ2UgdGhpczoNCg0Kd2lmaTog
cnRsOHh4eHU6IFJlbW92ZSBUTC1XTjcyMk4gVjIgKDB4MjM1NzogMHgwMTBjKSBmcm9tIHVudGVz
dGVkIGRldmljZXMNCg0KVGhpcyBXaS1GaSBkb25nbGUgaGFzIGJlZW4gdXNlZCBmb3IgbWFueSB5
ZWFycyBub3cgYW5kIGhhdmUgaGFkIG5vIHByb2JsZW1zDQp3aXRoIGl0LiBUaGUgZGV2aWNlIGlz
IHF1aXRlIG9sZCBhbmQga25vd24sIGR1bXBpbmcgaXRzIGVmdXNlIHRvIHRoZSBsb2cgYW5kDQph
c2tpbmcgdGhlIHVzZXIgdG8gc2VuZCB0aGUgcmVzdWx0cyB0byBKZXMuU29yZW5zZW5AZ21haWwu
Y29tIG9uIGV2ZXJ5IGJvb3QNCm1ha2VzIGxpdHRsZSBzZW5zZS4NCg0KU2lnbmVkLW9mZi1ieTog
0JDQu9C10LrRgdC10Lkg0KHQvNC40YDQvdC+0LIgPGRlYnVnZ2VyOTRAZ21haWwuY29tPg0KUmV2
aWV3ZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9jb3JlLmMNCj4g
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L2NvcmUuYw0KPiBpbmRleCA4
MzFiNTAyNWM2MzQuLjExM2UwMWRmMDkwMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGw4eHh4dS9jb3JlLmMNCj4gQEAgLTc4MTUsNyArNzgxNSw3IEBAIHN0YXRp
YyBpbnQgcnRsOHh4eHVfcHJvYmUoc3RydWN0IHVzYl9pbnRlcmZhY2UgKmludGVyZmFjZSwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgdW50ZXN0ZWQgPSAwOw0KPiAgICAgICAgICAgICAgICAg
YnJlYWs7DQo+ICAgICAgICAgY2FzZSAweDIzNTc6DQo+IC0gICAgICAgICAgICAgICBpZiAoaWQt
PmlkUHJvZHVjdCA9PSAweDAxMDkgfHwgaWQtPmlkUHJvZHVjdCA9PSAweDAxMzUpDQo+ICsgICAg
ICAgICAgICAgICBpZiAoaWQtPmlkUHJvZHVjdCA9PSAweDAxMDkgfHwgaWQtPmlkUHJvZHVjdCA9
PSAweDAxMGMNCj4gfHwgaWQtPmlkUHJvZHVjdCA9PSAweDAxMzUpDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHVudGVzdGVkID0gMDsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAg
ICAgIGNhc2UgMHgwYjA1Og0KDQo=

