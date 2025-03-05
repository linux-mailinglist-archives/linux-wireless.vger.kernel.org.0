Return-Path: <linux-wireless+bounces-19791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967EA4F37E
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 02:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9FE1890930
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB386324;
	Wed,  5 Mar 2025 01:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Sq9iRd2S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC68634F
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137709; cv=none; b=JTEuWTJel6R2toD5wZo1oVvlfxntrqdCwaR1c8nT9hLaSS7frfMlTA4jC67HqK7i6O6yL1Xmki/+OTIhApR2jaQrptn615EoR4NVkKNRRIOCoJlSTMW1Ro50glhj0Ta2UGnfjpPec5QqUsTW6bS+aD2sUCHk8JQhtsISyi4zpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137709; c=relaxed/simple;
	bh=uKslqY4h5THKlsa01W+Rmn2mtvKRMYpF/KwjcI8x9Sw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X4OqbRQ9ifE0NTxqr3MZTiXKzlHSR9Z4su7zBnkwVYlm57lQBsKodW75G3JjNm/0ISuKK1qRo4IpXBUfxBIj02yqOwwC8X++Fs+JRbXfSr6kxEjP1cNf2XcOWpkTWLdPmRYsSXqaHPSSkyEPwg30OkUHwlSa21WvxS6qlr1HQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Sq9iRd2S; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5251LElpC634359, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741137674; bh=uKslqY4h5THKlsa01W+Rmn2mtvKRMYpF/KwjcI8x9Sw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Sq9iRd2SzpvLNrZGNAbgWhvXQsJOoZsem65d0UlueAfk4LR58DAzFrykBXsd7y+wk
	 cFAuY5izsAhPYD8w3jHIhHcf8Qnu1yWcpk+hEAVq2sqPRRGE1dhIdvK9w9tR1mmuqY
	 4Aoj+Imbmieb4UWHD2wqzd6ebGPLsxl/7uywFTzwiE6V+Os6hxaJUPCUIDCOZaJqMp
	 6hRAzK7KilquAQMH+P0xfI5i7a2iCA2g5/pzt2kxfVCb9qKW3hj+CDvzGud4fQQaYe
	 jAZ8VamJYqxNKZ8kdbsaW/NChn9kffko4vDm84HSAkz4jcynlHbFsJv6VVhRyH/Ps1
	 YFYs4mckDgBDA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5251LElpC634359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 09:21:14 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 09:21:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 5 Mar 2025 09:21:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 5 Mar 2025 09:21:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
	<Deren.Wu@mediatek.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
        =?utf-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?= <Michael.Lo@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
        Sean
 Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?=
	<Leon.Yen@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 2/6] wifi: mt76: mt7925: add EHT control support based on the CLC data
Thread-Topic: [PATCH v2 2/6] wifi: mt76: mt7925: add EHT control support based
 on the CLC data
Thread-Index: AQHbjM7PI/j8mJkHIkCfOgfmxs+AIbNir+DQ//+Bj4CAAYj1gA==
Date: Wed, 5 Mar 2025 01:21:14 +0000
Message-ID: <d9cb9f51be984407b2f684b64400faed@realtek.com>
References: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
	 <20250304062854.829194-2-mingyen.hsieh@mediatek.com>
	 <3c240deaec6e4a4887a8e144f558158d@realtek.com>
 <b519659950744937075e823ed1a29ff345fa61e6.camel@mediatek.com>
In-Reply-To: <b519659950744937075e823ed1a29ff345fa61e6.camel@mediatek.com>
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

TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KSA8TWluZ3llbi5Ic2llaEBtZWRpYXRlay5jb20+ICB3
cm90ZToNCj4gT24gVHVlLCAyMDI1LTAzLTA0IGF0IDA5OjEwICswMDAwLCBQaW5nLUtlIFNoaWgg
d3JvdGU6DQo+ID4gTWluZ3llbiBIc2llaCA8bWFpbHRvOm1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsu
Y29tPiB3cm90ZToNCj4gPiANCj4gPiBbLi4uXQ0KPiA+IA0KPiA+ID4gDQo+ID4gPiArdm9pZCBt
dDc5MjVfcmVnZF9iZV9jdHJsKHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYsIHU4ICphbHBoYTIpDQo+
ID4gPiArew0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgbXQ3OTJ4X3BoeSAqcGh5ID0gJmRldi0+cGh5
Ow0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgbXQ3OTI1X2NsY19ydWxlX3YyICpydWxlOw0KPiA+ID4g
KyAgICAgICBzdHJ1Y3QgbXQ3OTI1X2NsYyAqY2xjOw0KPiA+ID4gKyAgICAgICBib29sIG9sZCA9
IGRldi0+aGFzX2VodCwgbmV3ID0gdHJ1ZTsNCj4gPiA+ICsgICAgICAgdTggKnBvczsNCj4gPiA+
ICsNCj4gPiA+ICsgICAgICAgaWYgKCFwaHktPmNsY1tNVDc5MnhfQ0xDX0JFX0NUUkxdKQ0KPiA+
ID4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICBjbGMg
PSAoc3RydWN0IG10NzkyNV9jbGMgKilwaHktPmNsY1tNVDc5MnhfQ0xDX0JFX0NUUkxdOw0KPiA+
ID4gKyAgICAgICBwb3MgPSBjbGMtPmRhdGE7DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHdoaWxl
ICgxKSB7DQo+ID4gDQo+ID4gd2hpbGUgKDEpIGNvdWxkIGxlYWQgaW5maW5pdGUgbG9vcCB1bmV4
cGVjdGVkbHkuDQo+ID4gQWRkaW5nIGEgY2hlY2tpbmcgb2YgY2xjLT5sZW4gd291bGQgYmUgc2Fm
ZXIuDQo+ID4gDQo+ID4gPiArICAgICAgICAgICAgICAgcnVsZSA9IChzdHJ1Y3QgbXQ3OTI1X2Ns
Y19ydWxlX3YyICopcG9zOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChydWxl
LT5hbHBoYTJbMF0gPT0gYWxwaGEyWzBdICYmDQo+ID4gPiArICAgICAgICAgICAgICAgICAgIHJ1
bGUtPmFscGhhMlsxXSA9PSBhbHBoYTJbMV0pIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIG5ldyA9IGZhbHNlOw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
ID4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgICAgIC8q
IENoZWNrIHRoZSBsYXN0IG9uZSAqLw0KPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChydWxlLT5m
bGFnICYmIEJJVCgwKSkNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+
ID4gKw0KPiANCj4gSGkgUGluZy1LZSwNCj4gDQo+IEkgZGVzaWduZWQgYSBmbGFnIHRvIHByZXZl
bnQgdGhlIGluZmluaXRlIGxvb3AuDQoNCkkga25ldy4gDQoNClBlb3BsZSBiZWxpZXZlIHRoZWly
IGNvZGUgaXMgc2FmZSwgYnV0IHNvbWVob3cgYHdoaWxlICgxKWAgZ2V0IHVuZXhwZWN0ZWQNCnJl
c3VsdC4gQW4gYWx0ZXJuYXRpdmUgd2F5IGlzIHRvIHVzZSBmb3ItbG9vcCB3aXRoIGxpbWl0IHJh
bmdlLCBsaWtlDQoNCmNsY19lbmQgPSAmY2xjLT5kYXRhW2NsYy0+bGVuXTsNCg0KZm9yIChwb3Mg
PSBjbGMtPmRhdGE7IHBvcyA8IGNsY19lbmQ7IHBvcyArPSBzaXplb2YoKnJ1bGUpKQ0KDQpKdXN0
IEZZUi4NCg0KPiANCj4gPiA+ICsgICAgICAgICAgICAgICBwb3MgKz0gc2l6ZW9mKCpydWxlKTsN
Cj4gPiA+ICsgICAgICAgfQ0KPiA+ID4gKw0KPiA+ID4gK291dDoNCj4gPiA+ICsgICAgICAgaWYg
KG9sZCA9PSBuZXcpDQo+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4gKw0KPiA+
ID4gKyAgICAgICBkZXYtPmhhc19laHQgPSBuZXc7DQo+ID4gPiArICAgICAgIG10NzkyNV9zZXRf
c3RyZWFtX2hlX2VodF9jYXBzKHBoeSk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+IA0KPiA+IFsu
Li5dDQo+ID4gDQo+IA0K

