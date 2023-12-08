Return-Path: <linux-wireless+bounces-567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAB780976F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 01:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3721C20BE8
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 00:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF85A32;
	Fri,  8 Dec 2023 00:43:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7A61729
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 16:43:50 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B80hcD53449017, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B80hcD53449017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Dec 2023 08:43:38 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 8 Dec 2023 08:43:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 8 Dec 2023 08:43:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 8 Dec 2023 08:43:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: ZeroBeat <ZeroBeat@gmx.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Thread-Topic: [PATCH] wifiwifi: Realtek: rtl8xxxu Add new device ID
Thread-Index: AQHaKOnSMO77xna6akOZJq4x2zvwerCc/XEggAANBYCAAYDaQA==
Date: Fri, 8 Dec 2023 00:43:37 +0000
Message-ID: <d654be3682e545d09bc7ca7a91e1b58a@realtek.com>
References: <415ecdaf-eebc-4a9e-9053-4cc999711ad7@gmx.de>
 <c81f09d43fab416ba7233dd9d5cfcd2d@realtek.com>
 <09b41f73-33c9-4c82-82ad-09c51840149f@gmx.de>
In-Reply-To: <09b41f73-33c9-4c82-82ad-09c51840149f@gmx.de>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmVyb0JlYXQgPFplcm9C
ZWF0QGdteC5kZT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDcsIDIwMjMgNTozOSBQTQ0K
PiBUbzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENjOiBsaW51eC13aXJl
bGVzc0B2Z2VyLmtlcm5lbC5vcmc7IEplcy5Tb3JlbnNlbkBnbWFpbC5jb20NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gd2lmaXdpZmk6IFJlYWx0ZWs6IHJ0bDh4eHh1IEFkZCBuZXcgZGV2aWNlIElE
DQo+IA0KPiBJcyB0aGlzIGNvcnJlY3QgdG8gY29tbWl0IGlubGluZSBwYXRjaGVzPw0KPiBMb29r
cyBmb3IgbWUgc2ltaWxhciB0byB0aGlzIG9uZQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC13aXJlbGVzcy8yMDIzMTEyNzE2MjAyMi41MTg4MzQtMi1rdmFsb0BrZXJuZWwub3JnL1Qv
I3UNCj4gDQoNClRoZSBiYXNpYyBzdGVwcyB0byBzdWJtaXQgYSBwYXRjaCBhcmU6DQoxLiBhZGQg
dGhpcyBwYXRjaCB0byB3aXJlbGVzcy1uZXh0IHRyZWUgbG9jYWxseQ0KMi4gZ2l0IGZvcm1hdC1w
YXRjaCAtMQ0KMy4gcnVuIC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIHdpdGggeW91ciBwYXRjaCBh
bmQgZml4IHdhcm5pbmdzDQo0LiBnaXQgc2VuZC1lbWFpbCB0byBzZW5kIG91dCB0aGUgcGF0Y2gu
DQoNCldpdGggYWJvdmUgc3RlcHMsIHlvdXIgcGF0Y2ggd291bGQgYmUgbXVjaCBzaW1pbGFyIHRv
IG90aGVycy4gDQoNCk1vcmUgZGV0YWlsIGNhbiByZWZlcmVuY2UgRG9jdW1lbnRhdGlvbi9wcm9j
ZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QgYW5kDQpodHRwczovL3dpcmVsZXNzLndpa2kua2Vy
bmVsLm9yZy9lbi9kZXZlbG9wZXJzL2RvY3VtZW50YXRpb24vc3VibWl0dGluZ3BhdGNoZXMNCg0K
DQoNCg==

