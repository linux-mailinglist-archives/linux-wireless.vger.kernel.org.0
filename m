Return-Path: <linux-wireless+bounces-1416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B98226B0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 02:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAF51C21CE7
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 01:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD8171C4;
	Wed,  3 Jan 2024 01:53:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CAD15AF4
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4031qwJG3649674, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4031qwJG3649674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 09:52:58 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Wed, 3 Jan 2024 09:52:58 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 09:52:56 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Wed, 3 Jan 2024 09:52:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: Fix off by one initial RTS rate
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: Fix off by one initial RTS rate
Thread-Index: AQHaPeZ6G86oOFz7hUCBf1oPMVe+KLDHUz0g
Date: Wed, 3 Jan 2024 01:52:56 +0000
Message-ID: <4e82c0b6dd02407389c8366dea68e284@realtek.com>
References: <761e6836-6cd6-4930-91b6-0446834655c5@gmail.com>
In-Reply-To: <761e6836-6cd6-4930-91b6-0446834655c5@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAz
LCAyMDI0IDM6MzMgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogSmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxw
a3NoaWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gd2lmaTogcnRsOHh4eHU6
IEZpeCBvZmYgYnkgb25lIGluaXRpYWwgUlRTIHJhdGUNCj4gDQo+IHJ0bDh4eHh1X3NldF9iYXNp
Y19yYXRlcygpIHNldHMgdGhlIHdyb25nIGluaXRpYWwgUlRTIHJhdGUuIEl0IHNldHMgdGhlDQo+
IG5leHQgaGlnaGVyIHJhdGUgdGhhbiB0aGUgb25lIGl0IHNob3VsZCBzZXQsIGUuZy4gMzZNIGlu
c3RlYWQgb2YgMjRNLg0KPiANCj4gVGhlIHdoaWxlIGxvb3Agd2FzIHN1cHBvc2VkIHRvIGZpbmQg
dGhlIGluZGV4IG9mIHRoZSBtb3N0IHNpZ25pZmljYW50DQo+IGJpdCB3aGljaCBpcyAxLCBidXQg
aXQgd2FzIGNvcGllZCBpbmNvcnJlY3RseSBmcm9tIHRoZSB2ZW5kb3IgZHJpdmVyLg0KPiBVc2Ug
X19mbHMoKSBpbnN0ZWFkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8
cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

