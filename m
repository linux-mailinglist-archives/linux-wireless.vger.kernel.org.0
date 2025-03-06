Return-Path: <linux-wireless+bounces-19828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC2A53F41
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 01:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDD13AF4C2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 00:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EAB18EA2;
	Thu,  6 Mar 2025 00:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eqdt6Ffz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E817C98
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221732; cv=none; b=PK2GF86Yf7XFCOuwnTSkt/r+L1AwWGArH7jevm1pRjl0alS0cqCfDogJ8mekHkjAegkb8MpkG5c6bLI95DpLBxbn5q7Th0sGPhYaYnmuLjcgdHOmThP2tDYQWIN86fLpV+ioe2ChyLJTbUGCK1KuNumzT6jLoX+vf3DEPUeEFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221732; c=relaxed/simple;
	bh=IuI09OMl7qYytov0R6+S3bynrBaNhGhBv/qniGs8940=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oMiKkKAy1pZDfQmceEwwQlz+IKsH+mpvdwCvekb9Bz2yregkKenZ4n7DzOfszWknTTEvQFKFKHQUcYMaHwNkbPMzD8GCoZKyHCMBZ8ZI6JhR/hnAbY8pPoHAFHRehvnZJLnuCxqKkzxoKesGwSdtonYJXVfOpOM5rQZV1GlKYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eqdt6Ffz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5260fMV312356498, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741221682; bh=IuI09OMl7qYytov0R6+S3bynrBaNhGhBv/qniGs8940=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=eqdt6FfzHwDWmDDiMJvOAso8sL6zt8lbmmP9dkzBoIPzvkBZgKuTMy8NzaGg0fipb
	 vVFF5fxfPp30IKMuaOAt2B4MOqh3G41nlxneKBDLxl9ssXcjUV8+2z0Wu354OWQwoe
	 TUfjWsFnmZ7xDF9JuJcYcJENxZhcNewy4HTNdQvIYT2kaIglRUjHW/f06hQ6PLKAy3
	 Ic62sfJkkm786iwvC58q7NxcKfzjecXn8Fnd7LlAu+0AQJRivlML53aRa8gJKEflWL
	 0i2Ry1rNsPsrQCnz63IIVvR5ewe1XeZbT1Y7/qGkvTyvmi2v0Y98sl0zegpVEFzTjx
	 OxOVSdgaTeCWw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5260fMV312356498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 08:41:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 08:41:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 6 Mar 2025 08:41:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 6 Mar 2025 08:41:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>,
        =?utf-8?B?RXJpYy1TWSBDaGFuZyAo5by15pu45rqQKQ==?=
	<Eric-SY.Chang@mediatek.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?UXVhbiBaaG91ICjlkajlhagp?= <Quan.Zhou@mediatek.com>,
        =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
        =?utf-8?B?TWljaGFlbCBMbyAo576F55Kn56ugKQ==?= <Michael.Lo@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Sean Wang
	<Sean.Wang@mediatek.com>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJr+WEkik=?=
	<Leon.Yen@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?=
	<km.lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v2 2/6] wifi: mt76: mt7925: add EHT control support based on the CLC data
Thread-Topic: [PATCH v2 2/6] wifi: mt76: mt7925: add EHT control support based
 on the CLC data
Thread-Index: AQHbjM7PI/j8mJkHIkCfOgfmxs+AIbNir+DQ//+Bj4CAAYj1gIAACNiAgAGBRoA=
Date: Thu, 6 Mar 2025 00:41:22 +0000
Message-ID: <4743bb0a6eff4d2f8f8397222af1f00b@realtek.com>
References: <20250304062854.829194-1-mingyen.hsieh@mediatek.com>
	 <20250304062854.829194-2-mingyen.hsieh@mediatek.com>
	 <3c240deaec6e4a4887a8e144f558158d@realtek.com>
	 <b519659950744937075e823ed1a29ff345fa61e6.camel@mediatek.com>
	 <d9cb9f51be984407b2f684b64400faed@realtek.com>
 <2afd81616aed2ae71404d5b4e9b82991a4ebe283.camel@mediatek.com>
In-Reply-To: <2afd81616aed2ae71404d5b4e9b82991a4ebe283.camel@mediatek.com>
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

TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KSA8TWluZ3llbi5Ic2llaEBtZWRpYXRlay5jb20+IHdy
b3RlOg0KPiBPbiBXZWQsIDIwMjUtMDMtMDUgYXQgMDE6MjEgKzAwMDAsIFBpbmctS2UgU2hpaCB3
cm90ZToNCj4gPiANCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBz
ZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gDQo+ID4gDQo+ID4gTWluZ3llbiBIc2llaCAo6Kyd
5piO6Ku6KSA8bWFpbHRvOk1pbmd5ZW4uSHNpZWhAbWVkaWF0ZWsuY29tPiAgd3JvdGU6DQo+ID4g
PiBPbiBUdWUsIDIwMjUtMDMtMDQgYXQgMDk6MTAgKzAwMDAsIFBpbmctS2UgU2hpaCB3cm90ZToN
Cj4gPiA+ID4gTWluZ3llbiBIc2llaCA8bWFpbHRvOm1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29t
PiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IFsuLi5dDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ICt2b2lkIG10NzkyNV9yZWdkX2JlX2N0cmwoc3RydWN0IG10NzkyeF9kZXYgKmRl
diwgdTggKmFscGhhMikNCj4gPiA+ID4gPiArew0KPiA+ID4gPiA+ICsgICAgICAgc3RydWN0IG10
NzkyeF9waHkgKnBoeSA9ICZkZXYtPnBoeTsNCj4gPiA+ID4gPiArICAgICAgIHN0cnVjdCBtdDc5
MjVfY2xjX3J1bGVfdjIgKnJ1bGU7DQo+ID4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgbXQ3OTI1X2Ns
YyAqY2xjOw0KPiA+ID4gPiA+ICsgICAgICAgYm9vbCBvbGQgPSBkZXYtPmhhc19laHQsIG5ldyA9
IHRydWU7DQo+ID4gPiA+ID4gKyAgICAgICB1OCAqcG9zOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiArICAgICAgIGlmICghcGh5LT5jbGNbTVQ3OTJ4X0NMQ19CRV9DVFJMXSkNCj4gPiA+ID4gPiAr
ICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAg
Y2xjID0gKHN0cnVjdCBtdDc5MjVfY2xjICopcGh5LQ0KPiA+ID4gPiA+ID5jbGNbTVQ3OTJ4X0NM
Q19CRV9DVFJMXTsNCj4gPiA+ID4gPiArICAgICAgIHBvcyA9IGNsYy0+ZGF0YTsNCj4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gKyAgICAgICB3aGlsZSAoMSkgew0KPiA+ID4gPiANCj4gPiA+ID4gd2hp
bGUgKDEpIGNvdWxkIGxlYWQgaW5maW5pdGUgbG9vcCB1bmV4cGVjdGVkbHkuDQo+ID4gPiA+IEFk
ZGluZyBhIGNoZWNraW5nIG9mIGNsYy0+bGVuIHdvdWxkIGJlIHNhZmVyLg0KPiA+ID4gPiANCj4g
PiA+ID4gPiArICAgICAgICAgICAgICAgcnVsZSA9IChzdHJ1Y3QgbXQ3OTI1X2NsY19ydWxlX3Yy
ICopcG9zOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgaWYgKHJ1bGUt
PmFscGhhMlswXSA9PSBhbHBoYTJbMF0gJiYNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
IHJ1bGUtPmFscGhhMlsxXSA9PSBhbHBoYTJbMV0pIHsNCj4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBuZXcgPSBmYWxzZTsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ID4gPiA+ICsNCj4gPiA+
ID4gPiArICAgICAgICAgICAgICAgLyogQ2hlY2sgdGhlIGxhc3Qgb25lICovDQo+ID4gPiA+ID4g
KyAgICAgICAgICAgICAgIGlmIChydWxlLT5mbGFnICYmIEJJVCgwKSkNCj4gPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ID4gPiArDQo+ID4gPiANCj4gPiA+IEhp
IFBpbmctS2UsDQo+ID4gPiANCj4gPiA+IEkgZGVzaWduZWQgYSBmbGFnIHRvIHByZXZlbnQgdGhl
IGluZmluaXRlIGxvb3AuDQo+ID4gDQo+ID4gSSBrbmV3Lg0KPiA+IA0KPiA+IFBlb3BsZSBiZWxp
ZXZlIHRoZWlyIGNvZGUgaXMgc2FmZSwgYnV0IHNvbWVob3cgYHdoaWxlICgxKWAgZ2V0DQo+ID4g
dW5leHBlY3RlZA0KPiA+IHJlc3VsdC4gQW4gYWx0ZXJuYXRpdmUgd2F5IGlzIHRvIHVzZSBmb3It
bG9vcCB3aXRoIGxpbWl0IHJhbmdlLCBsaWtlDQo+ID4gDQo+ID4gY2xjX2VuZCA9ICZjbGMtPmRh
dGFbY2xjLT5sZW5dOw0KPiA+IA0KPiA+IGZvciAocG9zID0gY2xjLT5kYXRhOyBwb3MgPCBjbGNf
ZW5kOyBwb3MgKz0gc2l6ZW9mKCpydWxlKSkNCj4gPiANCj4gPiBKdXN0IEZZUi4NCj4gPiANCj4g
DQo+IE9rLiBJIGdvdCBpdC4gVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbnMuDQo+IFBlcmhhcHMg
aSB3aWxsIG1vZGlmeSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiANCg0KR29vZC4gOi0pDQoN
CkJ5IHRoZSB3YXksIGNvdWxkIHlvdSBjaGVjayBpZiB5b3UgcmVwbGllZCBpbiBwbGFpbiB0ZXh0
IG1vZGU/DQpGcm9tIG15IG91dGxvb2ssIGl0IGxvb2tzIGxpa2UgaW4gaHRtbCBtb2RlLCBidXQg
cGF0Y2h3b3JrIGNhbg0KcmVjb2duaXplIGl0IHdlbGwgWzFdLg0KDQpbMV0gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXdpcmVsZXNzL3BhdGNoLzIwMjUwMzA0MDYy
ODU0LjgyOTE5NC0yLW1pbmd5ZW4uaHNpZWhAbWVkaWF0ZWsuY29tLw0KDQo+ID4gPiANCj4gPiA+
ID4gPiArICAgICAgICAgICAgICAgcG9zICs9IHNpemVvZigqcnVsZSk7DQo+ID4gPiA+ID4gKyAg
ICAgICB9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtvdXQ6DQo+ID4gPiA+ID4gKyAgICAgICBp
ZiAob2xkID09IG5ldykNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4g
PiA+ICsNCj4gPiA+ID4gPiArICAgICAgIGRldi0+aGFzX2VodCA9IG5ldzsNCj4gPiA+ID4gPiAr
ICAgICAgIG10NzkyNV9zZXRfc3RyZWFtX2hlX2VodF9jYXBzKHBoeSk7DQo+ID4gPiA+ID4gK30N
Cj4gPiA+ID4gPiArDQo+ID4gPiA+IA0KPiA+ID4gPiBbLi4uXQ0KPiA+ID4gPiANCj4gPiA+IA0K
PiANCg0K

