Return-Path: <linux-wireless+bounces-528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C287A80838F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 09:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48BC1C21CF3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CF1400F;
	Thu,  7 Dec 2023 08:52:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6487126
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 00:52:31 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B78qNMo9039408, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B78qNMo9039408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Dec 2023 16:52:23 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 7 Dec 2023 16:52:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 7 Dec 2023 16:52:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 7 Dec 2023 16:52:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: ZeroBeat <ZeroBeat@gmx.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Thread-Topic: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Thread-Index: AQHaKOnSMO77xna6akOZJq4x2zvwerCc/XEg
Date: Thu, 7 Dec 2023 08:52:22 +0000
Message-ID: <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>
References: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
In-Reply-To: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFplcm9CZWF0IDxaZXJvQmVh
dEBnbXguZGU+DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciA3LCAyMDIzIDQ6NDYgUE0NCj4g
VG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnOyBKZXMuU29yZW5zZW5AZ21haWwuY29tDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIHdpZml3aWZpOiBSZWFsdGVrOiBydGw4eHh4dSBBZGQgbmV3IGRldmljZSBJRA0K
PiANCj4gQmV0dGVyIG5vdz8NCj4gDQoNCllvdXIgcGF0Y2ggaXNuJ3QgbXVjaCBsaWtlIG90aGVy
cy4gUGxlYXNlIGNoZWNrIHBhdGNoZXMgWzFdIG1hZGUgYnkgb3RoZXJzLiANCg0KWzFdIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLw0KDQoNCg==

