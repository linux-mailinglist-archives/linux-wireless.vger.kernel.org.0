Return-Path: <linux-wireless+bounces-1951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED51682E7B9
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 02:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2961F23AFA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 01:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6D410A0A;
	Tue, 16 Jan 2024 01:26:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6A10A01
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40G1PNAX04099971, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40G1PNAX04099971
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 09:25:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 16 Jan 2024 09:25:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 09:25:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Tue, 16 Jan 2024 09:25:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?= <Leon.Yen@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
        =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
        Sean Wang
	<Sean.Wang@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>,
        =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?=
	<Soul.Huang@mediatek.com>,
        =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?=
	<posh.sun@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?=
	<ch.yeh@mediatek.com>,
        =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?=
	<robin.chiu@mediatek.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: mt76: mt7921e: fix use-after-free in free_irq()
Thread-Topic: [PATCH 1/2] wifi: mt76: mt7921e: fix use-after-free in
 free_irq()
Thread-Index: AQHaRf8Mfdr/M2DJQ0qJZHApLacQLbDaIV+wgAAmVwCAAVPGcA==
Date: Tue, 16 Jan 2024 01:25:22 +0000
Message-ID: <a55d89a195444b6c98df86607692a26d@realtek.com>
References: <572d6af305a09fc8bdd96a8ee57399039803a2bb.1705135817.git.deren.wu@mediatek.com>
	 <3a3fc58206ec436e8cdfd97d71350795@realtek.com>
 <d02b15d0f76a842970f241db5a557cd37d894562.camel@mediatek.com>
In-Reply-To: <d02b15d0f76a842970f241db5a557cd37d894562.camel@mediatek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCkZyb206IERlcmVuIFd1ICjmrablvrfku4EpIDxEZXJlbi5XdUBtZWRpYXRlay5jb20+IA0K
U2VudDogTW9uZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDg6MTggUE0NClRvOiBuYmRAbmJkLm5hbWU7
IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgbG9yZW56b0BrZXJuZWwub3JnDQpD
YzogTWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KSA8TWluZ3llbi5Ic2llaEBtZWRpYXRlay5jb20+
OyBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnOyBMZW9uIFllbiAo6aGP6Imv5YSS
KSA8TGVvbi5ZZW5AbWVkaWF0ZWsuY29tPjsgU2hheW5lIENoZW4gKOmZs+i7kuS4nikgPFNoYXlu
ZS5DaGVuQG1lZGlhdGVrLmNvbT47IFF1YW4gWmhvdSAo5ZGo5YWoKSA8UXVhbi5aaG91QG1lZGlh
dGVrLmNvbT47IFNlYW4gV2FuZyA8U2Vhbi5XYW5nQG1lZGlhdGVrLmNvbT47IEtNIExpbiAo5p6X
5piG5rCRKSA8a20ubGluQG1lZGlhdGVrLmNvbT47IFNvdWwgSHVhbmcgKOm7g+iHs+aYtikgPFNv
dWwuSHVhbmdAbWVkaWF0ZWsuY29tPjsgUG9zaCBTdW4gKOWtq+eRnuW7tykgPHBvc2guc3VuQG1l
ZGlhdGVrLmNvbT47IEVyaWMtU1kgQ2hhbmcgKOW8teabuOa6kCkgPEVyaWMtU1kuQ2hhbmdAbWVk
aWF0ZWsuY29tPjsgQ0ggWWVoICjokYnlv5fosaopIDxjaC55ZWhAbWVkaWF0ZWsuY29tPjsgUm9i
aW4gQ2hpdSAo6YKx5ZyL5r+xKSA8cm9iaW4uY2hpdUBtZWRpYXRlay5jb20+OyBSeWRlciBMZWUg
PFJ5ZGVyLkxlZUBtZWRpYXRlay5jb20+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcN
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSB3aWZpOiBtdDc2OiBtdDc5MjFlOiBmaXggdXNlLWFm
dGVyLWZyZWUgaW4gZnJlZV9pcnEoKQ0KDQo+IA0KPiBIZXJlIGlzIHRoZSBzbmFwc2hvdC4gVGhl
IGNvZGUgaXMgdHJ5aW5nIHRvIGRpcmVjdCBhY2Nlc3MgdGhpcyBpcnENCj4gaGFuZGxlciBhZnRl
ciBkZXJlZ2lzZXJpbmcsIGZvciBJUlFGX1NIQVJFRCBjYXNlLiBzeW5jaHJvbml6ZV9pcnEoKSBh
bmQNCj4gdGFza2xldF9raWxsKCkgYXJlIGFsbCBkb25lIGluIHByZXZpb3VzIHN0ZXBzLiBXZSBu
ZWVkIHRvIHN0b3AgdGhlDQo+IGV4dHJhIGNhbGwgaGVyZS4gSWYgdGhlcmUgYXJlIGFueSBhbHRl
cm5hdGl2ZSwgdGhhdCB3b3VsZCBiZQ0KPiBhcHByZWNpYXRlZC4NCj4gDQo+IC8qDQo+ICAqIEl0
J3MgYSBzaGFyZWQgSVJRIC0tIHRoZSBkcml2ZXIgb3VnaHQgdG8gYmUgcHJlcGFyZWQgZm9yIGFu
IElSUQ0KPiAgKiBldmVudCB0byBoYXBwZW4gZXZlbiBub3cgaXQncyBiZWluZyBmcmVlZCwgc28g
bGV0J3MgbWFrZSBzdXJlIHRoYXQNCj4gICogaXMgc28gYnkgZG9pbmcgYW4gZXh0cmEgY2FsbCB0
byB0aGUgaGFuZGxlciAuLi4uDQo+ICAqDQo+ICAqICggV2UgZG8gdGhpcyBhZnRlciBhY3R1YWxs
eSBkZXJlZ2lzdGVyaW5nIGl0LCB0byBtYWtlIHN1cmUgdGhhdCBhDQo+ICAqICAgJ3JlYWwnIElS
USBkb2Vzbid0IHJ1biBpbiBwYXJhbGxlbCB3aXRoIG91ciBmYWtlLiApDQo+ICAqLw0KPiBpZiAo
YWN0aW9uLT5mbGFncyAmIElSUUZfU0hBUkVEKSB7DQo+ICAgICAgICAgbG9jYWxfaXJxX3NhdmUo
ZmxhZ3MpOw0KPiAgICAgICAgIGFjdGlvbi0+aGFuZGxlcihpcnEsIGRldl9pZCk7DQo+ICAgICAg
ICAgbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOw0KPiB9DQo+IA0KDQpJIG1pc3NlZCB0aGlzIHBv
aW50LiBTb3JyeSBmb3IgdGhlIG5vaXNlLiANCg0KDQo=

