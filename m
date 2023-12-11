Return-Path: <linux-wireless+bounces-611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE380BEC1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 02:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F5E1C203B7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A15D7497;
	Mon, 11 Dec 2023 01:30:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B1BBD
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 17:30:11 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB1TlW522301717, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB1TlW522301717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 09:29:48 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 11 Dec 2023 09:29:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 11 Dec 2023 09:29:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 11 Dec 2023 09:29:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "marco.rodolfi@tuta.io" <marco.rodolfi@tuta.io>,
        Larry Finger
	<Larry.Finger@lwfinger.net>
CC: Linux Wireless <linux-wireless@vger.kernel.org>,
        Jay Sweat
	<jjsweat@outlook.com>
Subject: RE: Wireless P2P support for rtw88 families cards
Thread-Topic: Wireless P2P support for rtw88 families cards
Thread-Index: AQHaKq9f3iW87W/4AEWfoZN5kY39sbCgwUIAgAAFwICAAnzSIA==
Date: Mon, 11 Dec 2023 01:29:48 +0000
Message-ID: <161bc4c6ffe14a36ad76f214fe533eef@realtek.com>
References: <NlE3B0K--3-9@tuta.io>
 <60d366ff-8145-4f9d-a9f3-e27b82da31c2@lwfinger.net> <NlEvkht--3-9@tuta.io>
In-Reply-To: <NlEvkht--3-9@tuta.io>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbWFyY28ucm9kb2xmaUB0
dXRhLmlvIDxtYXJjby5yb2RvbGZpQHR1dGEuaW8+DQo+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIg
MTAsIDIwMjMgMjo1NSBBTQ0KPiBUbzogTGFycnkgRmluZ2VyIDxMYXJyeS5GaW5nZXJAbHdmaW5n
ZXIubmV0Pg0KPiBDYzogTGludXggV2lyZWxlc3MgPGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVs
Lm9yZz47IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBSZTog
V2lyZWxlc3MgUDJQIHN1cHBvcnQgZm9yIHJ0dzg4IGZhbWlsaWVzIGNhcmRzDQo+IA0KPiBPaCwg
c28gdGhlcmUgaXMgYWxyZWFkeSBhIHRlc3QgaW4uIEl0J3Mgbm90IGluIHRoZSBtYWluIGRyaXZl
ciBzaW5jZSBpdCdzIG1pc3NpbmcgdGVzdGluZyBvciBpdCdzIG5vdCB0aGF0DQo+IG11Y2ggc3Rh
YmxlPw0KPiANCg0KSSBkb24ndCBoYXZlIHRpbWUgdG8gZGV2ZWxvcCBhbmQgdGVzdCBQMlAgb24g
cnR3ODggdGhhdCBjb250YWlucyBtYW55IGNoaXBzLg0KDQpBcyB0aHJlYWQgWzFdLCBJIGRpZCBz
dWdnZXN0IHNvbWUgdGVzdCBjYXNlcywgYW5kIEkgdGhpbmsgSmF5IGlzIHRlc3RpbmcuDQoNClsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8xZjZiMjU1ZThjOGE0ZDlj
OWQyYWY4MGM5M2I3YWNmMEByZWFsdGVrLmNvbS8NCg0K

