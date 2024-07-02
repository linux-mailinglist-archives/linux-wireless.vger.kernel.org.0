Return-Path: <linux-wireless+bounces-9809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2111A91ED63
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 05:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A0F1F22CCE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 03:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E33514A90;
	Tue,  2 Jul 2024 03:15:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468C28EB;
	Tue,  2 Jul 2024 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719890153; cv=none; b=lrDMrzunK4PxVumRQl8tte8vkIb2v8/dWaYMg5PECSQuPBQHI0jZg8fx/NMAxa0Sbu2IrntyizzU3gnzkgbk0LxM+zDA03oQfyy3/8suraxLeojqd24JbzuIw/08vZdAiY36EjS5Inwav6etwH4O+O7LUuY1ALY6Q+XKF8Xl5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719890153; c=relaxed/simple;
	bh=c/qHlFObPOsYyzuA4ISXh6mz5iwsHv247KF28/H+rIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=NIfNxqMPHkcuG/NxeXaEhdnpVbq5RrXAkMd765VNeV4+bzg+XpK/sEy+IAJww0ganepAmt3xzWIeJOkmQn6vPy152PxFr/28VgX9Jmm+lX+vwbf5RRvBo8U02vzBEZvfDW6xqOU3Z63kEHaDpl88ZwkLGjaS/2BGRGIMriTk7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4623FP1T0380239, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4623FP1T0380239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jul 2024 11:15:25 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 11:15:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jul 2024 11:15:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 2 Jul 2024 11:15:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Tim K <tpkuester@gmail.com>
CC: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Topic: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Index: AQHasFekMjDEF5R7/k+0650S2/2b8bGrUuCQgACfb4CAAAQJAIABdicQgAHpfgCAAS0NwIAyeBig
Date: Tue, 2 Jul 2024 03:15:24 +0000
Message-ID: <2c4974e113474cea87ff276eff09c882@realtek.com>
References: <13e848c1544245e6aef4b89c3f38daf0@realtek.com>
 <20240528110246.477321-1-marcin.slusarz@gmail.com>
 <801bd77995184b1fa35bf4a32ab3a036@realtek.com>
 <CA+shoWSt44WxS6s=z8wR3AMRYFj9tuxWdkwVLG5i2mU34jn4Xw@mail.gmail.com> 
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

SGkgVGltLA0KDQpQaW5nLUtlIFNoaWggd3JvdGU6DQo+IFRpbSBLIDx0cGt1ZXN0ZXJAZ21haWwu
Y29tPiB3cm90ZToNCj4gPg0KPiA+ID4gSSBnYXZlIHRoaXMgc3VnZ2VzdGlvbnMgdG9vIGVhcmx5
LCBzaW5jZSB3ZSBoYXZlIG5vdCBnb3R0ZW4gdGVzdCByZXN1bHQgZnJvbSBUaW0uDQo+ID4gPiBJ
IHdpbGwgY2hhbmdlIHRoZW0gdG8gIkxpbms6IiBpZiBubyBBQ0sgZnJvbSBUaW0gd2hpbGUgbWVy
Z2luZy4NCj4gPg0KPiA+IEhleSBhbGwsIHRoYW5rcyBmb3IgcmVhY2hpbmcgb3V0IQ0KPiA+DQo+
ID4gU2FkbHkgSSdtIG5vdCBhYmxlIHRvIHdvcmsgb24gdGhpcyBwcm9qZWN0IHJpZ2h0IG5vdywg
YnV0IEkndmUNCj4gPiBmb3J3YXJkZWQgdGhpcyBlbWFpbCB0byBhIGZldyBjb2xsZWFndWVzIHRv
IGJyaW5nIHRoZW0gaW4gdGhlIGxvb3AuDQo+ID4gRGlkIHlvdSBoYXZlIGEgdGltZWxpbmUgeW91
IHdlcmUgbG9va2luZyBhdCB0byBjbG9zZSB0aGlzIG9mZj8NCj4gDQo+IFRoYW5rcyBmb3IgeW91
ciByZXBseS4gSSB3b3VsZCB0YWtlIHRoaXMgcGF0Y2ggdG8gNi4xMSwgc28geW91IGhhdmUgYWJv
dXQNCj4gNC01IHdlZWtzLiBJcyBpdCBlbm91Z2ggdG8geW91Pw0KDQpEbyB5b3UgaGF2ZSBhbnkg
dXBkYXRlIG9uIHRoaXMgcGF0Y2g/IA0KDQpQaW5nLUtlDQoNCg==

