Return-Path: <linux-wireless+bounces-1412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E62E28225DD
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 01:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A78E1F222EB
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 00:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCDE110D;
	Wed,  3 Jan 2024 00:13:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4F10FE
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4030DVmiC578069, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4030DVmiC578069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 08:13:31 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 3 Jan 2024 08:13:31 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 3 Jan 2024 08:13:31 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Wed, 3 Jan 2024 08:13:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ali Ghandour <gandour.ali@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Lenovo LOQ rtw_8852be
Thread-Topic: Lenovo LOQ rtw_8852be
Thread-Index: AQHaH+dudVZVMpW7Qk6t1f3PxKDyKLCNY6tQ///EsACAAAT0AIAAh+ZQgAeHaQCABKhgsP//2SiAgAHUHECABgrNAIABysFggAFMj4CAAIfLEIAV3eZQgAttm4CAAOraUA==
Date: Wed, 3 Jan 2024 00:13:30 +0000
Message-ID: <79fe81b7db7148b9a7da2353c16d70fb@realtek.com>
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
 <5abfc98859504795b50f7f343784c886@realtek.com>
 <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
 <CAOE0c97fDaLTfsMJVmEh4HxOAPY19kD60qsV5AKJbWW5nnqWzw@mail.gmail.com>
 <b4cfd676c0b24d98b82302aefac7f379@realtek.com>
 <CAOE0c97NvXFhttfNNm3+NsXw9SKV7sC-nJriwF43pujvJugvSg@mail.gmail.com>
 <1ad457d646ba4d9d99dc2f5cb8a1b590@realtek.com>
 <CAOE0c97cFjF=LGD8-nb95ihQhE0YRRqM=4PKud4nccQa06MVxw@mail.gmail.com>
 <f5e03fd6c26544b48cb493ec428338fb@realtek.com>
 <CAOE0c94UMKymy8mV2unbNo9CRe9n0pUmg6dGQ-xnRRKZvMxNJA@mail.gmail.com>
 <973fe7f5ec2c474c8a88f8933c7dde83@realtek.com>
 <CAOE0c94tf8y2hv0QHKEiuo5a7Ly=oJAw+g4Uh6BktHOMdbWY1Q@mail.gmail.com>
 <ec85daec1dd64b2ca731078cd0dd95d3@realtek.com>
 <CAOE0c95hkCdoKksAO5KhfVPuH1r8bpWXyM4Q_B+R2N-mJFz4yA@mail.gmail.com>
In-Reply-To: <CAOE0c95hkCdoKksAO5KhfVPuH1r8bpWXyM4Q_B+R2N-mJFz4yA@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpIEdoYW5kb3VyIDxn
YW5kb3VyLmFsaUBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAzLCAyMDI0
IDI6MDkgQU0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBTdWJq
ZWN0OiBSZTogTGVub3ZvIExPUSBydHdfODg1MmJlDQo+IA0KPiBIZWxsbyBQaW5nLUtlLA0KPiAN
Cj4gPiBBZnRlciBpbnRlcm5hbCBkaXNjdXNzaW9uLCBwZW9wbGUgc3VnZ2VzdCB0byBpbXBsZW1l
bnQgREJJIHRvIGFjY2VzcyBQQ0kgY29uZmlnDQo+ID4gc3BhY2UgYXMgYXR0YWNoZWQgcGF0Y2gu
IFBsZWFzZSBoZWxwIHRvIHJldmVydCB3b3JrYXJvdW5kIGFuZCBhcHBseSB0aGlzIG9uZSwNCj4g
PiBhbmQgZ2l2ZSB1cyBrZXJuZWwgbG9nIHRvIHNlZSBpZiBpdCB3b3JrcyBhcyBleHBlY3RlZC4N
Cj4gDQo+IDEuIEkgdHJpZWQgZmlyc3QgdG8gcGF0Y2ggdXNpbmcgYmVsb3cgY29tbWFuZHMgYnV0
IGl0IGZhaWxlZDoNCj4gJCBwYXRjaCAtcCAyIC1vIHBjaS5jIHBjaS5oIDwNCj4gLi4vMDAwMS13
aWZpLXJ0dzg5LXBjaS11c2UtREJJLWZ1bmN0aW9uLWZvci04ODUyQUUtODg1MkJFLTg4LnBhdGNo
DQo+IFdoYXQgc2hvdWxkIEkgdXNlIGluc3RlYWQ/DQoNCk5vcm1hbGx5LCBJIHVzZSBiZWxvdyBj
b21tYW5kDQoNCiQgcGF0Y2ggLXAgMSAtbSAtZCBwYXRoX3RvX3J0dzg5IDwgeHh4LnBhdGNoDQoN
Cj4gDQo+IDIuIFNvIEkgbWFudWFsbHkgYXBwbGllZCB0aGUgY2hhbmdlcyBhbmQgbG9hZCB0aGUg
a2VybmVsOg0KPiBbIDI0MjguNTY2MDI2XSBydHc4OV84ODUyYmUgMDAwMDowOTowMC4wOiBsb2Fk
ZWQgZmlybXdhcmUNCj4gcnR3ODkvcnR3ODg1MmJfZnctMS5iaW4NCj4gWyAyNDI4LjU2ODAyM10g
cnR3ODlfODg1MmJlIDAwMDA6MDk6MDAuMDogRmlybXdhcmUgdmVyc2lvbiAwLjI5LjI5LjUNCj4g
KGRhODdjY2NkKSwgY21kIHZlcnNpb24gMCwgdHlwZSA1DQo+IFsgMjQyOC41NjgwMjddIHJ0dzg5
Xzg4NTJiZSAwMDAwOjA5OjAwLjA6IEZpcm13YXJlIHZlcnNpb24gMC4yOS4yOS41DQo+IChkYTg3
Y2NjZCksIGNtZCB2ZXJzaW9uIDAsIHR5cGUgMw0KPiBbIDI0MjguODQ3ODIwXSBydHc4OV84ODUy
YmUgMDAwMDowOTowMC4wOiBjaGlwIHJmZV90eXBlIGlzIDENCj4gWyAyNDI4Ljg3ODg0MF0gcnR3
ODlfODg1MmJlIDAwMDA6MDk6MDAuMCB3bHA5czA6IHJlbmFtZWQgZnJvbSB3bGFuMA0KPiANCj4g
cmVib290ZWQgYW5kIGNoZWNrZWQgYWdhaW4gYW5kIHN0aWxsIHdvcmtpbmcgZmluZToNCj4gWyAg
ICAzLjIyNzYwNl0gcnR3ODlfODg1MmJlIDAwMDA6MDk6MDAuMDogbG9hZGVkIGZpcm13YXJlDQo+
IHJ0dzg5L3J0dzg4NTJiX2Z3LTEuYmluDQo+IFsgICAgMy4yMjc4NzBdIHJ0dzg5Xzg4NTJiZSAw
MDAwOjA5OjAwLjA6IGVuYWJsaW5nIGRldmljZSAoMDAwMCAtPiAwMDAzKQ0KPiBbICAgIDMuMjI5
NjgyXSBydHc4OV84ODUyYmUgMDAwMDowOTowMC4wOiBGaXJtd2FyZSB2ZXJzaW9uIDAuMjkuMjku
NQ0KPiAoZGE4N2NjY2QpLCBjbWQgdmVyc2lvbiAwLCB0eXBlIDUNCj4gWyAgICAzLjIyOTY4NF0g
cnR3ODlfODg1MmJlIDAwMDA6MDk6MDAuMDogRmlybXdhcmUgdmVyc2lvbiAwLjI5LjI5LjUNCj4g
KGRhODdjY2NkKSwgY21kIHZlcnNpb24gMCwgdHlwZSAzDQo+IFsgICAgMy41NDI1NzldIHJ0dzg5
Xzg4NTJiZSAwMDAwOjA5OjAwLjA6IGNoaXAgcmZlX3R5cGUgaXMgMQ0KPiBbICAgIDMuNTc0NDA2
XSBydHc4OV84ODUyYmUgMDAwMDowOTowMC4wIHdscDlzMDogcmVuYW1lZCBmcm9tIHdsYW4wDQo+
IA0KDQpUaGFua3MgZm9yIHRoZSBoZWxwLiBJIHdpbGwgc3VibWl0IHRoaXMgcGF0Y2ggdG8gdXBz
dHJlYW0uIA0KDQpQaW5nLUtlDQoNCg==

