Return-Path: <linux-wireless+bounces-1896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6057882D2F5
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 02:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD26281580
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 01:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2E4186A;
	Mon, 15 Jan 2024 01:30:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9815AC
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F1UcqwE3456220, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F1UcqwE3456220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 09:30:38 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 15 Jan 2024 09:30:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 09:30:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Mon, 15 Jan 2024 09:30:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192de: Don't read register in _rtl92de_query_rxphystatus
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192de: Don't read register in
 _rtl92de_query_rxphystatus
Thread-Index: AQHaRbEHTEKDg/ZBSEWgQ/MsFIkMLbDaF9yg
Date: Mon, 15 Jan 2024 01:30:19 +0000
Message-ID: <31d3e1eca91c4ad88ab5dcac2090f15d@realtek.com>
References: <19a3e023-0eaa-4096-9f78-a2c8e909cb54@gmail.com>
In-Reply-To: <19a3e023-0eaa-4096-9f78-a2c8e909cb54@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKYW51YXJ5IDEz
LCAyMDI0IDc6NDIgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBMYXJyeSBGaW5nZXIgPExhcnJ5
LkZpbmdlckBsd2Zpbmdlci5uZXQ+DQo+IFN1YmplY3Q6IFtQQVRDSF0gd2lmaTogcnRsd2lmaTog
cnRsODE5MmRlOiBEb24ndCByZWFkIHJlZ2lzdGVyIGluIF9ydGw5MmRlX3F1ZXJ5X3J4cGh5c3Rh
dHVzDQo+IA0KPiBJbnN0ZWFkIG9mIHJlYWRpbmcgYml0IDkgb2YgUkZQR0EwX1hBX0hTU0lQQVJB
TUVURVIyIGV2ZXJ5IHRpbWUgYSBmcmFtZQ0KPiBpcyByZWNlaXZlZCwganVzdCB1c2UgcnRscGh5
LT5jY2tfaGlnaF9wb3dlciwgd2hpY2ggaXMgaW5pdGlhbGlzZWQgaW4NCj4gX3J0bDkyZF9waHlf
YmJfY29uZmlnKCkuIFRoYXQgYml0IG5ldmVyIGNoYW5nZXMgYW55d2F5Lg0KPiANCj4gV2l0aCB0
aGlzIGNoYW5nZSBfcnRsOTJkZV9xdWVyeV9yeHBoeXN0YXR1cygpIGNhbiBiZSBzaGFyZWQgd2l0
aCB0aGUNCj4gdXBjb21pbmcgVVNCIGRyaXZlci4gVGhlIFVTQiBkcml2ZXIgY2FuJ3QgcmVhZCBy
ZWdpc3RlcnMgaW4gdGhpcw0KPiBmdW5jdGlvbiBiZWNhdXNlIHJlZ2lzdGVyIHJlYWRpbmcgY2Fu
IHNsZWVwLg0KPiANCj4gQ29tcGlsZSB0ZXN0ZWQgb25seS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTog
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+ICJUaGF0IGJpdCBu
ZXZlciBjaGFuZ2VzIGFueXdheS4iIDwtIEknbSA5OSUgc3VyZSB0aGlzIGlzIHRydWUuDQoNCkkg
Y2FuJ3QgZmluZCBhIFJUTDgxOTJERSwgYnV0IGFmdGVyIGNoZWNraW5nIFJGUEdBMF9YQV9IU1NJ
UEFSQU1FVEVSMiBhbmQNCml0cyBhZGRyZXNzIDB4ODI0LCBJIGJlbGlldmUgeW91IGFyZSByaWdo
dC4gDQoNClsuLi5dDQoNCg==

