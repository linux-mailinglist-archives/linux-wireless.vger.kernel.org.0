Return-Path: <linux-wireless+bounces-29073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6DAC67131
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 03:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D8C7629D16
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 02:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF6B20D4E9;
	Tue, 18 Nov 2025 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RQp5+YJA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13A3207
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434550; cv=none; b=a7MpG9jPYJXfi9ghjkeB6S4cjBeeBs14k7dhu+XvPSUAVOmcrG1bypsgDCM/OcWFmwaW4f6YY8bR2oKgE/GOwHCFvTo/0Le69My+FFT/UF6+h+MJuCMH3A3S+1XgwKpYsVxe87KLTsvEK+Sb6zgdodw8trgovSpa7sirEagV94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434550; c=relaxed/simple;
	bh=bgAg1d1J3tu6cexd9cyUrEGkJJ5cixYth/CP7lBdsRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oFjPSSVeMQ7mcJT7TGcaVF7g2Wjv+1UMSATFPGJcc4NcVcVeMsoRdFA9x/ESqDRIM7VHTZ4KiFCnmVxBDkceve2je0TCeNZEOJ5/A5EuxFlWUPB4uai0QK6GjK7MTSnUwp4F102RN4XpR5LKVpmXc6+n0xxskUdXmft4tbRb7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RQp5+YJA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI2tgwK7689236, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763434542; bh=bgAg1d1J3tu6cexd9cyUrEGkJJ5cixYth/CP7lBdsRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RQp5+YJAEM7ONpLJhiPitOg1q32wop/D9c5W4RIdJQABS4dj33IVs5NWAk1H+JTs8
	 gAorWtJpqezK0Ti2T71uHO/X2tQ2/pbUNZ9ddu16yyh2WS7/xBaLztcgRnKs2ZUQ57
	 yjGmmTmVxgdVxOkWWvqIxT0YbM43d9TbnhoInKnYj0RYue8RWuN1R3wgEcBgfrciQg
	 ELHCXvfh6GGkMQSrpLDWjbnygKaWlX1gX7WB0kActPgP7Am72sZzt1dFYjTBRP5/id
	 /LOyVOcns6OoQT1aYrCIf+hBIO0uIwveHvqrA+YDFZvk1MiJCRTrU3NzbTs5NC0AE1
	 QH5Oo/RJrKrnQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI2tgwK7689236
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:55:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:55:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 18 Nov 2025 10:55:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH rtw-next 3/5] wifi: rtl8xxxu: Fix the 40 MHz subchannel
 for RTL8192EU, RTL8723BU
Thread-Topic: [PATCH rtw-next 3/5] wifi: rtl8xxxu: Fix the 40 MHz subchannel
 for RTL8192EU, RTL8723BU
Thread-Index: AQHcVzezKFU1upN5oESRFrVkLL4mLbT3vp/A
Date: Tue, 18 Nov 2025 02:55:40 +0000
Message-ID: <55b178b47f2d4ab781045b0d744a9031@realtek.com>
References: <b735b9c6-f17f-405a-8972-a7c98f3c89e2@gmail.com>
 <150bf88d-9e12-412b-abc6-5313cb4d62d6@gmail.com>
In-Reply-To: <150bf88d-9e12-412b-abc6-5313cb4d62d6@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBydGw4
eHh4dV9nZW4yX2NvbmZpZ19jaGFubmVsKCkgd2FzIG1pc3NpbmcgdGhlIHN1YmNoYW5uZWwgc2V0
dGluZy4NCj4gVGhpcyBmdW5jdGlvbiBpcyB1c2VkIGJ5IFJUTDgxOTJFVSBhbmQgUlRMODcyM0JV
Lg0KPiANCj4gVGhpcyBjaGFuZ2Ugc2VlbXMgdG8gbWFrZSBubyBkaWZmZXJlbmNlIGluIG15IHRl
c3Rpbmcgb24gY2hhbm5lbCAxMw0KPiB3aXRoIGVpdGhlciBjaGlwLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmll
d2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo+IC0tLQ0KPiAg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9jb3JlLmMgfCAyICsrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9jb3JlLmMNCj4gYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L2NvcmUuYw0KPiBpbmRleCA3NzAwZTQwNzRkYzMuLjcz
OTQ1NjY0MGNhOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4
eHh4dS9jb3JlLmMNCj4gQEAgLTEzNzMsOSArMTM3MywxMSBAQCB2b2lkIHJ0bDh4eHh1X2dlbjJf
Y29uZmlnX2NoYW5uZWwoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQo+ICAgICAgICAgICAgICAg
ICAgICAgaHctPmNvbmYuY2hhbmRlZi5jaGFuLT5jZW50ZXJfZnJlcSkgew0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICBzZWNfY2hfYWJvdmUgPSAxOw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBjaGFubmVsICs9IDI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN1YmNoYW5uZWwgPSAy
Ow0KDQooRm9yIHJlY29yZCkNCkJ5IHZlbmRvciBkcml2ZXIsICdzdWJjaGFubmVsID0gMicgbWVh
bnMgcHJpbWFyeSBjaGFubmVsIGF0IGxvd2VyIDIwTUh6Lg0KDQo+ICAgICAgICAgICAgICAgICB9
IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzZWNfY2hfYWJvdmUgPSAwOw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBjaGFubmVsIC09IDI7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHN1YmNoYW5uZWwgPSAxOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiANCj4gICAgICAg
ICAgICAgICAgIHZhbDMyID0gcnRsOHh4eHVfcmVhZDMyKHByaXYsIFJFR19GUEdBMF9SRl9NT0RF
KTsNCj4gLS0NCj4gMi41MS4xDQoNCg==

