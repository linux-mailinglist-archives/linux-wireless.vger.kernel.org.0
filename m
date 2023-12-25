Return-Path: <linux-wireless+bounces-1276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669F181DE2C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Dec 2023 06:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FEF1C20BF7
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Dec 2023 05:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340A10FE;
	Mon, 25 Dec 2023 05:22:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E810F1
	for <linux-wireless@vger.kernel.org>; Mon, 25 Dec 2023 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BP5MPaT43730312, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BP5MPaT43730312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Dec 2023 13:22:25 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 25 Dec 2023 13:22:25 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 25 Dec 2023 13:22:25 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Mon, 25 Dec 2023 13:22:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH v3 13/21] wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
Thread-Topic: [PATCH v3 13/21] wifi: rtl8xxxu: support multiple interfaces in
 watchdog_callback()
Thread-Index: AQHaNvFrni44/4/UyEWgJXevFrqmCrC5dQlg
Date: Mon, 25 Dec 2023 05:22:24 +0000
Message-ID: <9b9f18d7528b46eaa3dc459cca745de9@realtek.com>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
 <20231222101442.626837-14-martin.kaistra@linutronix.de>
 <CAKFoaw3gz+kQMJJUEdDFvOCxQwqYZ0ijTNT2Z-YHiwC_Rv6puw@mail.gmail.com>
In-Reply-To: <CAKFoaw3gz+kQMJJUEdDFvOCxQwqYZ0ijTNT2Z-YHiwC_Rv6puw@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
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

DQpPbiBGcmksIERlYyAyMiwgMjAyMyBhdCA2OjE24oCvUE0gTWFydGluIEthaXN0cmENCjxtYXJ0
aW4ua2Fpc3RyYUBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4NCj4gQ2hlY2sgZmlyc3Qgd2hldGhl
ciBwcml2LT52aWZzWzBdIGV4aXN0cyBhbmQgaXMgb2YgdHlwZSBTVEFUSU9OLCB0aGVuIGdvDQo+
IHRvIHByaXYtPnZpZnNbMV0uIE1ha2Ugc3VyZSB0byBjYWxsIHJlZnJlc2hfcmF0ZV9tYXNrIGZv
ciBib3RoDQo+IGludGVyZmFjZXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBLYWlzdHJh
IDxtYXJ0aW4ua2Fpc3RyYUBsaW51dHJvbml4LmRlPg0KDQpSZXZpZXdlZC1ieTogUGluZy1LZSBT
aGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCkxvZ2ljYWxseSwgdGhpcyBwYXRjaCBpcyBmaW5l
IHRvIG1lLCBidXQgSSB3b3VsZCBsaWtlIHRvIGtub3cgaWYgeW91IGhhdmUNCnRlc3RlZCB0d28g
U1RBVElPTiBpbnRlcmZhY2VzIGNvbm5lY3QgdHdvIGRpZmZlcmVudCBBUD8gRXNwZWNpYWxseSwg
b25lIEFQDQppcyA4MDIuMTFnIG1vZGUgYW5kIHRoZSBvdGhlciBpcyA4MDIuMTFuIG1vZGUsIHNv
IHdlIGNhbiBjbGVhcmx5IGtub3cgdGhpcw0KcGF0Y2ggaXMgZXhwZWN0ZWQuIA0KDQpQaW5nLUtl
DQoNCg==

