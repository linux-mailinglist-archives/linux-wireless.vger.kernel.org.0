Return-Path: <linux-wireless+bounces-575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9050F809CD6
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 08:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447E91F210A3
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 07:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDF67483;
	Fri,  8 Dec 2023 07:02:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C8384F
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 23:01:51 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B871awD6700850, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B871awD6700850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Dec 2023 15:01:36 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 8 Dec 2023 15:01:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 8 Dec 2023 15:01:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 8 Dec 2023 15:01:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: ZeroBeat <ZeroBeat@gmx.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Thread-Topic: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Thread-Index: AQHaKOnSMO77xna6akOZJq4x2zvwerCc/XEggAANBYCAAYDaQP//4AmAgACJjXA=
Date: Fri, 8 Dec 2023 07:01:34 +0000
Message-ID: <05c047080464492b8701f4e6a45c7cc2@realtek.com>
References: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
 <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>
 <09b41f73-33c9-4c82-82ad-09c51840149f@gmx.de>
 <d654be3682e545d09bc7ca7a91e1b58a@realtek.com>
 <a6a23ccf-b571-49bf-855b-4fba3501f09b@gmx.de>
In-Reply-To: <a6a23ccf-b571-49bf-855b-4fba3501f09b@gmx.de>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmVyb0JlYXQgPFplcm9C
ZWF0QGdteC5kZT4NCj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciA4LCAyMDIzIDI6NDIgUE0NCj4g
VG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnOyBKZXMuU29yZW5zZW5AZ21haWwuY29tDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIHdpZml3aWZpOiBSZWFsdGVrOiBydGw4eHh4dSBBZGQgbmV3IGRldmljZSBJRA0K
PiANCj4gVGhhbmtzIGZvciB0aGlzIHZlcnkgaGVscGZ1bCBpbmZvcm1hdGlvbi4NCj4gSXQgaXMg
bXVjaCBiZXR0ZXIgdG8gdW5kZXJzdGFuZCB0aGFuIHRoaXMgb25lczoNCj4gaHR0cHM6Ly93d3cu
a2VybmVsLm9yZy9kb2MvaHRtbC92NC4xMS9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1s
DQo+IGh0dHBzOi8vd2lyZWxlc3Mud2lraS5rZXJuZWwub3JnL2VuL2RldmVsb3BlcnMvRG9jdW1l
bnRhdGlvbi9TdWJtaXR0aW5nUGF0Y2hlcw0KDQpUaGUgbGlua3MgZGVzY3JpYmUgbW9yZSBkZXRh
aWwgdGhpbmdzLCBhbmQgSSB0aGluayB5b3Ugd2lsbCBuZWVkIHRoZW0gaWYgeW91DQprZWVwIHN1
Ym1pdHRpbmcgbW9yZSBhbmQgbW9yZSBwYXRjaGVzLiANCg0KPiANCj4gQXQgdGhlIG1vbWVudCBJ
IHN0aWxsIGhhdmUgbm8gaWRlYSB3aHkgdGhlIFRQLUxpbmsgVEwtV044MjAwTkQoVU4pIHYzLjAg
c29tZXRpbWVzIHdvcmsgYW5kDQo+IHNvbWV0aW1lcyBub3QgKGFmdGVyIGl0cyBkZXZpY2UgaWRl
YSBoYXMgYmVlbiBhZGRlZCkuDQo+IEJ1dCBJIGhhdmUgc2VlbiB0aGlzIGJlaGF2aW9yIChydGw4
MTg4ZXUpLCBiZWZvcmU6DQo+IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5j
Z2k/aWQ9MjE3MjA1DQo+IENvbmZpcm1lZCBhbmQgZml4ZWQsIG5vdy4NCg0KU29ycnksIEkgZG9u
J3QgaGF2ZSBtdWNoIHRpbWUgdG8gbG9vayBpbnRvIHRoZSB0aHJlYWQsIGJ1dCBhcyB0aGUgdGl0
bGUgbWVudGlvbmVkIElRSywNCkkgd291bGQgc2F5IElRSyBjYW4gYWZmZWN0IF9wZXJmb3JtYW5j
ZV8sIHNvIGtlZXAgZGlzdGFuY2Ugb2YgeW91ciB1c2IgV2lGaSBzdGljaw0KYWJvdXQgNTBjbSBm
YXIgZnJvbSBBUCwgYW5kIGNoZWNrIGl0IGNhbiB3b3JrIHN0YWJsZS4gDQoNCj4gDQo+IE1heWJl
IHRoZSBwcm9ibGVtIG9mIHRoZSBydGw4MTkyZXUgaXMgc2ltaWxhciB0byB0aGlzIC0gYnV0IEkn
bSBub3Qgc3VyZSwgYmVjYXVzZQ0KPiBJIGhhdmVuJ3QgZnVsbHkgdW5kZXJzdG9vZCB0aGUgZW50
aXJlIGRyaXZlciBjb2RlIChyZWxhdGlvbnNoaXAgZHJpdmVyIGNvZGUgYW5kDQo+IGZpcm13YXJl
KSB5ZXQuDQo+IA0KDQpZb3UgY2FuIHNlYXJjaCBmb3IgYSB2ZW5kb3IgZHJpdmVyIHNvbWV3aGVy
ZSBsaWtlIGdpdGh1YiwgYW5kIHRoZW4gdHJ5IGlmIHRoZQ0Kb3V0LW9mLXRyZWUgZHJpdmVyIHdv
cmtzIHRvIHlvdS4gSWYgc28sIGNvbXBhcmUgdGhlaXIgaW5pdGlhbGl6YXRpb24gYW5kDQpzZXQg
Y2hhbm5lbCBmdW5jdGlvbiBiYXNpY2FsbHkuIA0KDQoNCg==

