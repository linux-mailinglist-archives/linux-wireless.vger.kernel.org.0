Return-Path: <linux-wireless+bounces-7128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F0A8BA49B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 02:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F047C1C20CDC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 00:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1B36B;
	Fri,  3 May 2024 00:38:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395938BEF
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696733; cv=none; b=dsvDOZLqLXQy+nh8aWzQJn7xOi3otGOKE2TF9xMmrx8g+1GkLgt7vS68/GbYjC3PgsQNKc9GwXgjahm7P2Hw1zjizHZGob+9nxmKZL8A46/CVzrMnDiKY94/erw1YRyQEX0tYjWFFQqmGIZAgDNltCQcm76xyLyAE6pRespxK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696733; c=relaxed/simple;
	bh=bQE0ABLhBkZ6jTR9pLIWFcuimaNBU3piI/s5WqBWxcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VC9QVCyjb8dlxmB9yuIKE0zkZ2b3av/p7rvkThUBO63ZvSFTW5957YSxzUfogX6yKuHcEOXB+dRJ0vv7TPTGUPQngpBuM7afZeVXvce7rkmfQ3KmYpfqL+cVreYtuSNaf42gL3h1WVpTYRzYbzprBOGJQWICkSXLqq5e5C5TD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4430cZUo93005918, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4430cZUo93005918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 May 2024 08:38:36 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 08:38:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 08:38:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 3 May 2024 08:38:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Larry Finger <Larry.Finger@lwfinger.net>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH] wifi: rtw88: usb: Simplify rtw_usb_write_data
Thread-Topic: [PATCH] wifi: rtw88: usb: Simplify rtw_usb_write_data
Thread-Index: AQHanNb1VkiF4IiuNkOiHUQ2TvchpbGD/ZIAgACqo0A=
Date: Fri, 3 May 2024 00:38:34 +0000
Message-ID: <83295823271d4b3a8381e42d94a0c5d6@realtek.com>
References: <681e03c1-d19e-44de-bc45-e71ce14c5ed2@gmail.com>
 <a4307823-f834-4cea-8206-6e966bb091ff@lwfinger.net>
In-Reply-To: <a4307823-f834-4cea-8206-6e966bb091ff@lwfinger.net>
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

TGFycnkgRmluZ2VyIDxsYXJyeS5maW5nZXJAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDUv
Mi8yNCA0OjIzIFBNLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3RlOg0KPiA+IFRoZSBza2IgY3JlYXRl
ZCBpbiB0aGlzIGZ1bmN0aW9uIGFsd2F5cyBoYXMgdGhlIHNhbWUgaGVhZHJvb20sDQo+ID4gdGhl
IGNoaXAncyBUWCBkZXNjcmlwdG9yIHNpemUuIFVzZSBjaGlwLT50eF9wa3RfZGVzY19zeiBkaXJl
Y3RseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFj
ZXJmZTJAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+IFRoaXMgaXMgdGhlIHBhdGNoIEkgcHJvbWlz
ZWQgZWFybGllcjoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy9j
YWUyZDMzMC1hNGZiLTQ1NzAtOWRkZS0wOTY4NGFmMjNmZmRAZ21haWwuY29tLw0KPiA+IC0tLQ0K
PiA+ICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYyB8IDE0ICsrKysr
LS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3VzYi5jIGIvdXNiLmMNCj4gPiBpbmRleCAx
ZGZlN2M2YWU0YmEuLmZmNTc5NzZiOWQzYiAxMDA2NDQNCj4gPiAtLS0gYS91c2IuYw0KPiA+ICsr
KyBiL3VzYi5jDQo+ID4gQEAgLTQ0MCwyMyArNDQwLDIxIEBAIHN0YXRpYyBpbnQgcnR3X3VzYl93
cml0ZV9kYXRhKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsDQo+ID4gICB7DQo+ID4gICAgICAgY29u
c3Qgc3RydWN0IHJ0d19jaGlwX2luZm8gKmNoaXAgPSBydHdkZXYtPmNoaXA7DQo+ID4gICAgICAg
c3RydWN0IHNrX2J1ZmYgKnNrYjsNCj4gPiAtICAgICB1bnNpZ25lZCBpbnQgZGVzY2xlbiwgaGVh
ZHNpemUsIHNpemU7DQo+ID4gKyAgICAgdW5zaWduZWQgaW50IHNpemU7DQo+ID4gICAgICAgdTgg
cXNlbDsNCj4gPiAgICAgICBpbnQgcmV0ID0gMDsNCj4gPg0KPiA+ICAgICAgIHNpemUgPXBrdF9p
bmZvLT50eF9wa3Rfc2l6ZTsNCj4gPiAgICAgICBxc2VsID0gcGt0X2luZm8tPnFzZWw7DQo+ID4g
LSAgICAgZGVzY2xlbiA9IGNoaXAtPnR4X3BrdF9kZXNjX3N6Ow0KPiA+IC0gICAgIGhlYWRzaXpl
ID0gcGt0X2luZm8tPm9mZnNldCA/IHBrdF9pbmZvLT5vZmZzZXQgOiBkZXNjbGVuOw0KPiA+DQo+
ID4gLSAgICAgc2tiID0gZGV2X2FsbG9jX3NrYihoZWFkc2l6ZSArIHNpemUpOw0KPiA+ICsgICAg
IHNrYiA9IGRldl9hbGxvY19za2IoY2hpcC0+dHhfcGt0X2Rlc2Nfc3ogKyBzaXplKTsNCj4gDQo+
IFdoZW4gSSBhZGRlZCBjb2RlIHRvIHRlc3QgaWYgY2hpcC0+dHhfcGt0X2Rlc2Nfc3ogd2FzIGVx
dWFsIHRvDQo+IHBrdF9pbmZvLT50eF9wa3Rfc2l6ZSBhdCBlbnRyeSwgaXQgcmVwb3J0ZWQgdGhh
dCB0aGVyZSB3YXMgYSBkaWZmZXJlbmNlLg0KDQpUaGlzIHBhdGNoIGRpZG4ndCB0b3VjaCBwa3Rf
aW5mby0+dHhfcGt0X3NpemUuIEluc3RlYWQsIEkgZXhwZWN0ZWQNCnBrdF9pbmZvLT5vZmZzZXQg
d2FzIGVxdWFsIHRvIGNoaXAtPnR4X3BrdF9kZXNjX3N6IG9yIDAuDQooSSByZXBsaWVkIHRoZSBy
ZWFzb24gd2h5IGl0IGRvZXNuJ3Qgd29yayBieSBhbm90aGVyIG1haWwgaW4gdGhlIHNhbWUgdGhy
ZWFkLikNCg0KDQo=

