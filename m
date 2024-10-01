Return-Path: <linux-wireless+bounces-13345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4898B1C1
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 03:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A11F24052
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 01:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04698827;
	Tue,  1 Oct 2024 01:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="w4BqhS0d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F3746E
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745979; cv=none; b=DVhkB6958lHK87vptxB8oV/iT0smhJ8GgcwLjNGC9gNWfKblfMGDsxXxdIGbUfnYNZvRZH1oPN0cX2oWQC3mBqQyavd8heRaoEF/9SdkkAYf6gthd/DZYiVfdqTT9AgChFgVqtqlJJfBd3+79JmBfIWQmgCV5ueiFoW7GxS+SeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745979; c=relaxed/simple;
	bh=WDbldPkkVBhdrTJgdhYde+hUMmceZEASQyDM8/P8Rzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MRbhxLs+WEcC2/xH1AWIl+2OrZniIIae9A08Jbtn/RAp/2rCrYyyGvEpdLElcaXzPIPDQrFlm2ORhVSdeelykuW2L8FBlxLZIePvQQiZzIFoOSEsnw5NczLTGbzCj39GI+5t5hk+PrXpVrup1AEII3R93DJbZNBPv5si+pIXAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=w4BqhS0d; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4911PxwL6298860, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727745959; bh=WDbldPkkVBhdrTJgdhYde+hUMmceZEASQyDM8/P8Rzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=w4BqhS0dR08kApNdrgxuPn5RYcTYd/d40Rsxwsg319Y5hpg4zczG6MwGTnQkZnJth
	 xaMnYoiy0J4njX0krepmckNU6EsuFO/L0BlYQhL5Ih44Gbwon7sVcS49iLT/kK0EoF
	 gvTr/2Eyu0JjRlZ2jh1OkiTg6oFeplGnTYWPMbBrJorodGI6voONnuJdvERlzPqvcE
	 MlhhHY5K7d6kM46w2JEiAPefX4rc5CHm/kqUgcpGtDQg7YqdsUqZu9cNPdJCap9ur8
	 GQSJ4c1UeKtWhyeta6rAUovKf943heOCtS3wlHkANApYeLQsMK6YjcnR/fAYO9BQg7
	 kUvzVWGcx/4rw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 4911PxwL6298860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 09:25:59 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 09:26:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 1 Oct 2024 09:25:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 1 Oct 2024 09:25:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: rtw88: alloc_skb(32768, GFP_ATOMIC) fails, driver gets stuck
Thread-Topic: rtw88: alloc_skb(32768, GFP_ATOMIC) fails, driver gets stuck
Thread-Index: AQHbE3sze1NKG9K1hEinqRz3ygF0uLJxDRuQ
Date: Tue, 1 Oct 2024 01:25:59 +0000
Message-ID: <ff98c33e797c4df3aee29a46229ee7ee@realtek.com>
References: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
 <baca0d5d-072e-4003-ab4a-ecc524d6b89b@gmail.com>
In-Reply-To: <baca0d5d-072e-4003-ab4a-ecc524d6b89b@gmail.com>
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
YWxsb2Nfc2tiIGZhaWxzIChzaWxlbnRseSkgdGhlcmVmb3JlIHRoZSBSWCBVUkIgaXMgbm90IHN1
Ym1pdHRlZA0KPiBldmVyIGFnYWluLiBUaGVyZSBhcmUgb25seSA0IFJYIFVSQnMuDQoNClRob3Vn
aCBvbmx5IDQgUlggVVJCLCBpdCBtaWdodCBiZSBwb3NzaWJsZSBtb3JlIHRoYW4gNCBSWCBza2Iu
IA0KSW4gcnR3X3VzYl9yZWFkX3BvcnRfY29tcGxldGUoKSwgcXVldWUgUlggc2tiIGludG8gcnR3
dXNiLT5yeF9xdWV1ZSwgYW5kIGtpY2sNCm9mZiByeF93b3JrLiBJdCBtZWFucyBzb21lIFJYIHNr
YiBhcmUgaW5mbGlnaHQsIGJ1dCBub3Qgc3VyZSBob3cgbWFueS4NCg0KPiANCj4gc3RhdGljIHZv
aWQgcnR3X3VzYl9yeF9yZXN1Ym1pdChzdHJ1Y3QgcnR3X3VzYiAqcnR3dXNiLCBzdHJ1Y3Qgcnhf
dXNiX2N0cmxfYmxvY2sgKnJ4Y2IpDQo+IHsNCj4gICAgICAgICBzdHJ1Y3QgcnR3X2RldiAqcnR3
ZGV2ID0gcnR3dXNiLT5ydHdkZXY7DQo+ICAgICAgICAgaW50IGVycm9yOw0KPiANCj4gICAgICAg
ICByeGNiLT5yeF9za2IgPSBhbGxvY19za2IoUlRXX1VTQl9NQVhfUkVDVkJVRl9TWiwgR0ZQX0FU
T01JQyk7DQo+ICAgICAgICAgaWYgKCFyeGNiLT5yeF9za2IpDQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm47DQo+IA0KPiAgICAgICAgIHVzYl9maWxsX2J1bGtfdXJiKHJ4Y2ItPnJ4X3VyYiwgcnR3
dXNiLT51ZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHVzYl9yY3ZidWxrcGlwZShy
dHd1c2ItPnVkZXYsIHJ0d3VzYi0+cGlwZV9pbiksDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcnhjYi0+cnhfc2tiLT5kYXRhLCBSVFdfVVNCX01BWF9SRUNWQlVGX1NaLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJ0d191c2JfcmVhZF9wb3J0X2NvbXBsZXRlLCByeGNiKTsNCj4g
DQo+ICAgICAgICAgZXJyb3IgPSB1c2Jfc3VibWl0X3VyYihyeGNiLT5yeF91cmIsIEdGUF9BVE9N
SUMpOw0KPiANCj4gSSBhZGRlZCBhbiBlcnJvciBtZXNzYWdlIHRoZXJlOg0KPiANCj4gICAgICAg
ICByeGNiLT5yeF9za2IgPSBhbGxvY19za2IoUlRXX1VTQl9NQVhfUkVDVkJVRl9TWiwgR0ZQX0FU
T01JQyk7DQo+ICAgICAgICAgaWYgKCFyeGNiLT5yeF9za2IpIHsNCj4gICAgICAgICAgICAgICAg
IHJ0d19lcnIocnR3ZGV2LCAiZmFpbGVkIHRvIGFsbG9jYXRlIHJ4X3NrYlxuIik7DQo+ICAgICAg
ICAgICAgICAgICByZXR1cm47DQo+ICAgICAgICAgfQ0KDQpNeSBmaXJzdCB0aG91Z2h0IGlzIHRv
IGNoYW5nZSBHRlBfQVRPTUlDIHRvIEdGUF9LRVJORUwsIGJ1dCBrZXJuZWwgZG9jdW1lbnRhdGlv
bg0Kbm90ZXMgdGhhdCANCiJORVZFUiBTTEVFUCBJTiBBIENPTVBMRVRJT04gSEFORExFUi4gVGhl
c2UgYXJlIG9mdGVuIGNhbGxlZCBpbiBhdG9taWMgY29udGV4dC4iDQpIb3dldmVyLCBJIGZlZWwg
aXQgaXMgcG9zc2libGUgdG8gZG8gcnR3X3VzYl9yeF9yZXN1Ym1pdCgpIGluIGEgd29yay4NCg0K
QW5vdGhlciB0aG91Z2h0IGlzIHRvIGFsbG9jYXRlIGEgbmV3IHNrYiB3aXRoIHNpemUgdXJiLT5h
Y3R1YWxfbGVuZ3RoLCBhbmQNCmNvcHkgcmVjZWl2ZWQgZGF0YSB0byB0aGUgbmV3IHNrYiwgYW5k
IHF1ZXVlIHRvIHJ0d3VzYi0+cnhfcXVldWUuIFRoZW4gcmV1c2UNCnRoZSBvcmlnaW5hbCByeF9z
a2IuIFRoaXMgdGhvdWdodCBpcyBiYXNlZCBvbiB3aGF0IHVyYi0+YWN0dWFsX2xlbmd0aCB3b3Vs
ZA0KYmUgc21hbGxlciB0aGFuIFJUV19VU0JfTUFYX1JFQ1ZCVUZfU1osIGJ1dCBub3QgdmVyeSBz
dXJlIGlmIHRoaXMgaXMgZmFjdC4gDQoNCg0K

