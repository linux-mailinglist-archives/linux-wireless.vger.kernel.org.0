Return-Path: <linux-wireless+bounces-1974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B98882EE52
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 12:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8A31C20FB6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 11:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9411B940;
	Tue, 16 Jan 2024 11:49:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA21B7F7
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40GBnJQO1233158, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40GBnJQO1233158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 19:49:19 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 16 Jan 2024 19:49:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 19:49:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Tue, 16 Jan 2024 19:49:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "zenmchen@gmail.com" <zenmchen@gmail.com>,
        "martin.kaistra@linutronix.de"
	<martin.kaistra@linutronix.de>
CC: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: [PATCH] wifi: rtl8xxxu: add missing number of sec cam entries for all variants
Thread-Topic: [PATCH] wifi: rtl8xxxu: add missing number of sec cam entries
 for all variants
Thread-Index: AQHaSGF5KTD8y6z8zEGHZ3zLWD9Q17DbzSaA
Date: Tue, 16 Jan 2024 11:49:18 +0000
Message-ID: <72e1babe6cf31256d8e18b471d8583658c78636d.camel@realtek.com>
References: <20240116095001.399500-1-martin.kaistra@linutronix.de>
In-Reply-To: <20240116095001.399500-1-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <17340991D5434042A23AF3915C66DD11@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

KyBaZW5tDQoNCkhpIFplbm0sDQoNCk9uIFR1ZSwgMjAyNC0wMS0xNiBhdCAxMDo1MCArMDEwMCwg
TWFydGluIEthaXN0cmEgd3JvdGU6DQo+IA0KPiBDb21taXQgYjgzN2Y3OGZiZmZhICgid2lmaTog
cnRsOHh4eHU6IGFkZCBodyBjcnlwdG8gc3VwcG9ydCBmb3IgQVANCj4gbW9kZSIpIGludHJvZHVj
ZWQgbWF4X3NlY19jYW1fbnVtIGFzIGEgbWVtYmVyIG9mIHJ0bDh4eHh1X2ZpbGVvcHMuDQo+IEl0
IHdhcyBtaXNzZWQgdG8gc2V0IHRoaXMgbnVtYmVyIGZvciBhbGwgdmFyaWFudHMgZXhjZXB0IDgx
ODhmLCB3aGljaA0KPiBjYXVzZWQgcnRsOHh4eHVfZ2V0X2ZyZWVfc2VjX2NhbSgpIHRvIGFsd2F5
cyByZXR1cm4gMC4NCj4gDQo+IEZpeCBpdCBieSBhZGRpbmcgdGhlIG51bWJlcnMgZm9yIGFsbCB2
YXJpYW50cy4gVGhlIHZhbHVlcyBhcmUgdGFrZW4gZnJvbQ0KPiB0aGUgdmVuZG9yIGRyaXZlcnMg
YW5kIHJ0bHdpZmkuDQo+IA0KPiBGaXhlczogYjgzN2Y3OGZiZmZhICgid2lmaTogcnRsOHh4eHU6
IGFkZCBodyBjcnlwdG8gc3VwcG9ydCBmb3IgQVAgbW9kZSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1h
cnRpbiBLYWlzdHJhIDxtYXJ0aW4ua2Fpc3RyYUBsaW51dHJvbml4LmRlPg0KPiANCg0KQ291bGQg
eW91IHBsZWFzZSB0cnkgaWYgdGhpcyBwYXRjaCBjYW4gZml4IHlvdXIgcHJvYmxlbT8gDQoNClRo
YW5rcw0KUGluZy1LZQ0KDQoNCg==

