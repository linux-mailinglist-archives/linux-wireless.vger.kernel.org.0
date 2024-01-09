Return-Path: <linux-wireless+bounces-1608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB4827D16
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 03:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FCA28531A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 02:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE566FA9;
	Tue,  9 Jan 2024 02:55:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA7B6111
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4092t3Yz9150181, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4092t3Yz9150181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 10:55:04 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 9 Jan 2024 10:55:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 9 Jan 2024 10:55:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Tue, 9 Jan 2024 10:55:03 +0800
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
Thread-Index: AQHaNvFrni44/4/UyEWgJXevFrqmCrC5dQlggBXE+ACAAaY5UA==
Date: Tue, 9 Jan 2024 02:55:03 +0000
Message-ID: <7d033fb8c3194ac9841e61642c30c17a@realtek.com>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
 <20231222101442.626837-14-martin.kaistra@linutronix.de>
 <CAKFoaw3gz+kQMJJUEdDFvOCxQwqYZ0ijTNT2Z-YHiwC_Rv6puw@mail.gmail.com>
 <9b9f18d7528b46eaa3dc459cca745de9@realtek.com>
 <7b9bab65-c588-469e-a17e-cae6426694be@linutronix.de>
In-Reply-To: <7b9bab65-c588-469e-a17e-cae6426694be@linutronix.de>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEthaXN0cmEg
PG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSA4
LCAyMDI0IDU6NDMgUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsg
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBKZXMgU29yZW5zZW4gPEplcy5T
b3JlbnNlbkBnbWFpbC5jb20+OyBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPjsgQml0dGVy
Ymx1ZSBTbWl0aA0KPiA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+OyBTZWJhc3RpYW4gQW5kcnpl
aiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djMgMTMvMjFdIHdpZmk6IHJ0bDh4eHh1OiBzdXBwb3J0IG11bHRpcGxlIGludGVyZmFjZXMgaW4g
d2F0Y2hkb2dfY2FsbGJhY2soKQ0KPiANCj4gWWVzLCBJIGRpZCB0cnkgdG8gY29ubmVjdCB0aGUg
dHdvIGludGVyZmFjZXMgdG8gdHdvIGRpZmZlcmVudCBBUCAob24gdGhlIHNhbWUNCj4gY2hhbm5l
bCkgYXQgdGhlIHNhbWUgdGltZSwgYW5kIGl0IHNlZW1zIHRvIGJlaGF2ZSBmaW5lLg0KDQpOaWNl
ISBUaGFua3MgZm9yIHlvdXIgd29yay4gOi0pDQoNClBpbmctS2UgDQoNCg==

