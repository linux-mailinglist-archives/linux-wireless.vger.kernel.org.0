Return-Path: <linux-wireless+bounces-1899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721AF82D311
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021041F2128D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 02:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347F17CD;
	Mon, 15 Jan 2024 02:18:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838E217CB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F2Hg8B23489355, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F2Hg8B23489355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 10:17:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 15 Jan 2024 10:17:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 10:17:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Mon, 15 Jan 2024 10:17:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: Viacheslav <adeep@lexina.in>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        =?utf-8?B?SmVybmVqIMWga3JhYmVj?=
	<jernej.skrabec@gmail.com>
Subject: RE: rtw88: rtl8822cs AP mode not working
Thread-Topic: rtw88: rtl8822cs AP mode not working
Thread-Index: AQHaQ5OsSQGQ9nw7J0iwO3LVKmuk7LDSwwJA//+ZagCAAWoEsP//2HAAgAG4OSCAAoFvAIACTpow
Date: Mon, 15 Jan 2024 02:17:39 +0000
Message-ID: <8192e59807e14525b821317a5f550ea4@realtek.com>
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com>
 <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
 <0969b1ca039e423dbcc41de18db023c6@realtek.com>
 <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
 <0be52db8941c4e609bfda6c69a14184e@realtek.com>
 <CAFBinCDT2Pj_BYqCtk+i7y8LPU2qwah-4Scdq29ONBqs3wt0pQ@mail.gmail.com>
In-Reply-To: <CAFBinCDT2Pj_BYqCtk+i7y8LPU2qwah-4Scdq29ONBqs3wt0pQ@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEJsdW1lbnN0
aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4NCj4gU2VudDogU3VuZGF5
LCBKYW51YXJ5IDE0LCAyMDI0IDY6NTAgQU0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPg0KPiBDYzogVmlhY2hlc2xhdiA8YWRlZXBAbGV4aW5hLmluPjsgbGludXgtd2ly
ZWxlc3NAdmdlci5rZXJuZWwub3JnOyBKZXJuZWogxaBrcmFiZWMNCj4gPGplcm5lai5za3JhYmVj
QGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IHJ0dzg4OiBydGw4ODIyY3MgQVAgbW9kZSBub3Qg
d29ya2luZw0KPiANCj4gSGkgUGluZy1LZSwNCj4gDQo+IE9uIEZyaSwgSmFuIDEyLCAyMDI0IGF0
IDE6NDDigK9BTSBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6DQo+IFsu
Li5dDQo+ID4gPiBkbWVzZy9qb3VybmFsY3RsIGlzIGNsZWFuLiBObyBtZXNzYWdlcyByZWxhdGVk
IHRvIHdpZmkuDQo+ID4gPg0KPiA+DQo+ID4gSGF2ZSB5b3UgZXZlciB0cmllZCBBUCBtb2RlIG9u
IFNESU8gaW50ZXJmYWNlIHdpZmkgY2FyZHMsIGxpa2UgUlRMODgyMkNTPw0KPiA+IEl0IHNlZW1z
IG5vIGJlYWNvbiBpc3N1ZXMgcHJvcGVybHksIGJ1dCBubyBvYnZpb3VzIGVycm9ycyBkdXJpbmcg
c3RhcnRpbmcNCj4gPiBBUCBtb2RlLg0KPiBJIGhhdmVuJ3QgdHJpZWQgQVAgbW9kZSBiZWZvcmUg
KGFuZCBJIHRoaW5rKiB0aGF0IEplcm5laiBhbHNvIGhhc24ndCB0cmllZCBpdCkuDQo+IA0KPiA+
IEkgZG9uJ3QgaGF2ZSB0aGlzIGtpbmQgb2Ygd2lmaSBjYXJkcywgY291bGQgeW91IGhlbHAgdG8g
Y2hlY2sgaWYgQVAgbW9kZQ0KPiA+IHdvcmtzIGluIHlvdXIgc2lkZT8NCj4gSSdsbCBjaGVjayB0
aGF0IGluIHRoZSBuZXh0IGZldyBkYXlzLg0KPiBBbHNvIEknbSB3b25kZXJpbmcgd2hlcmUgY29k
ZSBlbmFibGVzIGJlYWNvbnMgKGlzIGl0DQo+IHJ0d19jb3JlX2VuYWJsZV9iZWFjb24oKSBvciBp
cyB0aGVyZSBhbm90aGVyIHJlbGV2YW50IGZ1bmN0aW9uPykuDQo+IEtub3dpbmcgdGhhdCB3b3Vs
ZCBiZSBoZWxwZnVsIHRvIGFuYWx5emUgdGhpcyBmdXJ0aGVyLg0KPiANCg0KVGhlIG1haW4gZnVu
Y3Rpb24gdG8gZ2V0IGFuZCBzZXQgYmVhY29uIHRlbXBsYXRlIHRvIGZpcm13YXJlIGlzIA0KcnR3
X2Z3X2Rvd25sb2FkX3JzdmRfcGFnZSgpLiBUaGUgYmFzaWMgY29uY2VwdCBpcyB0byBwdXQgYmVh
Y29uIGZyYW1lIHZpYSANCnFzZWw9QkNOIHRvIGEgc3BlY2lhbCBUWCBGSUZPIGFyZWEgY2FsbGVk
ICJyZXNlcnZlIHBhZ2UiLCBhbmQgdGhlbg0KaGFyZHdhcmUvZmlybXdhcmUgd2lsbCBzZW5kIGJl
YWNvbiBpbiBpbnRlcnZhbCBvZiAxMDBtcy4gDQoNClRoZSBUWCBGSUZPIGxvb2sgbGlrZQ0KDQog
ICAgKy0tLS0tLS0tLSsNCiAgICB8ICAgICAgICAgfCAgICBeDQogICAgfCAgICAgICAgIHwgICAg
fA0KICAgIHwgICAgICAgICB8ICAgIHwNCiAgICB8ICAgICAgICAgfCAgICB8IG5vcm1hbCBUWCBG
SUZPIHBhZ2UgDQogICAgfCAgICAgICAgIHwgICAgfA0KICAgIHwgICAgICAgICB8ICAgIHwNCiAg
ICB8ICAgICAgICAgfCAgICB2IA0KICAgICstLS0tLS0tLS0rIDwtLS0tLS0tLS0tLSAgQkNOX0hF
QUQNCiAgICB8ICAgICAgICAgfCAgICBeDQogICAgfCAgICAgICAgIHwgICAgfCByZXNlcnZlIHBh
Z2UNCiAgICB8ICAgICAgICAgfCAgICB2DQogICAgKy0tLS0tLS0tLSsNCg0KVGhlIGluaXRpYWwg
cGFnZXMgb2YgcmVzZXJ2ZSBwYWdlIGlzIHRvIHN0b3JlIGJlYWNvbiwgYnV0IGxhdHRlciBvbmUg
Y291bGQgYmUNClBTIG51bGwgZnJhbWUgdGhhdCBmaXJtd2FyZSB1c2VzIGl0IHRvIG5vdGlmeSBB
UC4gDQoNClBpbmctS2UgDQoNCg==

