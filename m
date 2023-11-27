Return-Path: <linux-wireless+bounces-88-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93287F9741
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 02:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92281280D48
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 01:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42002A44;
	Mon, 27 Nov 2023 01:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C8CB
	for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 17:43:33 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AR1hT9c9927935, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AR1hT9c9927935
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 09:43:29 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 27 Nov 2023 09:42:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 27 Nov 2023 09:42:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 27 Nov 2023 09:42:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ali Ghandour <gandour.ali@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: Lenovo LOQ rtw_8852be
Thread-Topic: Lenovo LOQ rtw_8852be
Thread-Index: AQHaH+dudVZVMpW7Qk6t1f3PxKDyKLCNY6tQ
Date: Mon, 27 Nov 2023 01:42:52 +0000
Message-ID: <5abfc98859504795b50f7f343784c886@realtek.com>
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
In-Reply-To: <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpIEdoYW5kb3VyIDxn
YW5kb3VyLmFsaUBnbWFpbC5jb20+DQo+IFNlbnQ6IFN1bmRheSwgTm92ZW1iZXIgMjYsIDIwMjMg
NTozNiBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IExlbm92byBMT1EgcnR3Xzg4NTJiZQ0KPiANCj4gSGksDQo+IA0KPiBGb2xsb3dpbmcgYmVsb3cg
dGhyZWFkLCBydHdfODg1MmJlIGRyaXZlciBmYWlscyBmb3IgTGVub3ZvIExPUToNCj4gaHR0cHM6
Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0dzg5L2lzc3Vlcy8yMzUNCj4gDQo+IHJ0dzg5Xzg4NTJi
ZSAwMDAwOjA5OjAwLjA6IGxvYWRlZCBmaXJtd2FyZSBydHc4OS9ydHc4ODUyYl9mdy0xLmJpbg0K
PiBydHc4OV84ODUyYmUgMDAwMDowOTowMC4wOiBGaXJtd2FyZSB2ZXJzaW9uIDAuMjkuMjkuNSAo
ZGE4N2NjY2QpLCBjbWQNCj4gdmVyc2lvbiAwLCB0eXBlIDUNCj4gcnR3ODlfODg1MmJlIDAwMDA6
MDk6MDAuMDogRmlybXdhcmUgdmVyc2lvbiAwLjI5LjI5LjUgKGRhODdjY2NkKSwgY21kDQo+IHZl
cnNpb24gMCwgdHlwZSAzDQo+IHJ0dzg5Xzg4NTJiZSAwMDAwOjA5OjAwLjA6IE1BQyBoYXMgYWxy
ZWFkeSBwb3dlcmVkIG9uDQo+IHJ0dzg5Xzg4NTJiZSAwMDAwOjA5OjAwLjA6IFtFUlJdcGNpIGNv
bmZpZyByZWFkIDcxOQ0KPiBydHc4OV84ODUyYmUgMDAwMDowOTowMC4wOiBbRVJSXSBwY2llIGF1
dG9rIGZhaWwgLTIyDQo+IHJ0dzg5Xzg4NTJiZSAwMDAwOjA5OjAwLjA6IGZhaWxlZCB0byBzZXR1
cCBjaGlwIGluZm9ybWF0aW9uDQo+IHR3ODlfODg1MmJlOiBwcm9iZSBvZiAwMDAwOjA5OjAwLjAg
ZmFpbGVkIHdpdGggZXJyb3IgLTIyDQo+IA0KPiBJIGFtIHJ1bm5pbmcgVWJ1bnR1IDIyLjA0LjMg
YW5kIGtlcm5lbCA2LjIuMC0zNy1nZW5lcmljLg0KPiANCg0KTm90IHZlcnkgc3VyZSB3aHkgeW91
ciBob3N0IGNhbid0IHJlYWQgUENJIGNvbmZpZ3VyYXRpb24gc3BhY2UgMHg3MTkuIA0KUGxlYXNl
IHByb3ZpZGUgeW91ciBQQ0kgaG9zdCBjb250cm9sbGVyIGJ5ICdsc3BjaSAtdHYnLiANCg0KQW5k
LCBJIHdvbmRlciBpZiB1c2VyIHNwYWNlIHRvb2wgJ2xzcGNpJyBjYW4gZHVtcCB3aG9sZSBQQ0kg
Y29uZmlndXJhdGlvbg0Kc3BhY2Ugb24geW91ciBwbGF0Zm9ybSwgc28gcGxlYXNlIHByb3ZpZGUg
ZnVsbCBkdW1wIGJ5DQonc3VkbyBsc3BjaSAtcyB4eDp5eS56eiAteHh4eCcgDQoNCiAgKHlvdSBj
YW4gZ2V0IHRoZSBkZXZpY2UgbnVtYmVyIGZvbGxvd2VkICctcycgYnkgJ2xzcGNpJywgYW5kIGNv
cHkgdGhlIG51bWJlciwgbGlrZSkNCiAgMDM6MDAuMCBOZXR3b3JrIGNvbnRyb2xsZXI6IFJlYWx0
ZWsgU2VtaWNvbmR1Y3RvciBDby4sIEx0ZC4gRGV2aWNlIGI4NTINCg0KDQpBZnRlciBrZXJuZWwg
NS4xOCwgd2UgY2hhbmdlIHRvIHVzZSBzdGFuZGFyZCBwY2kgQVBJIHRvIHJlYWQvd3JpdGUgY29u
ZmlndXJhdGlvbg0Kc3BhY2UsIHNvIGlmIHBvc3NpYmxlIHBsZWFzZSBkb3duZ3JhZGUgdG8gNS4x
NyB0byBzZWUgaWYgdGhhdCB2ZXJzaW9uIHdvcmtzIHRvIHlvdS4NCg0KUGluZy1LZQ0KDQo=

