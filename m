Return-Path: <linux-wireless+bounces-17092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DF3A01CD9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 01:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834231624FD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 00:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51BE3C0B;
	Mon,  6 Jan 2025 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VAOAr/Oi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5B801;
	Mon,  6 Jan 2025 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736123529; cv=none; b=Q0amfpC+7WKwLdrov/xTAB2ZL2cTsTOiMG1Kjm5GJhJ960g3q5tkCteAWWJytmCMiZVHweLDOI8vj7Hntmz7XO9dJqa0a5s3iA+bbOfxbY7yfLRB2fOlQ2SNbW01vP0Cmc7E8b2PP7GLtEyk9JHQ9x2ujkUChMOqX1cFxYqmWY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736123529; c=relaxed/simple;
	bh=V3UTuYhclvbXxZKV2s+HWHr0xBUKhwf0k1fKROO06lE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eWOrtc9GV5dIf6boR/8T5LNoxNfnS7juZAOLo9gXjJhDmaNiLRi3euMDg35CwlrvFYFrGtjZM+aIOucf7yx6rdihXt5vEJyUkQ7Heki4B5Qp233W2Xuf+XuQ7Yz8+t59bwbHrH5VHOoVZSY65k60Z975LhPBKX7CeCtLZXE1xq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VAOAr/Oi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5060VfYZ21294895, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736123501; bh=V3UTuYhclvbXxZKV2s+HWHr0xBUKhwf0k1fKROO06lE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VAOAr/OiB+IzIAHnj4vlV//24ezTBKBz/P+QIOaAwhtdV6GUPkbXzUFbiod9r7gPt
	 OPdNyJuvimBzTMMHvqyQZAXVi5UmNs5jRD7NX/hkMPeYdGxOtOS6wbJ0ashyMjv6Vb
	 wpxeQLJNHBsARCsN6JBywnpUfxdbHbCZfBKOpe89srfWagpRxsT4I96Plx0emDj1pb
	 mSdgc9aJjJ+iKNs5dqA6qGjLMTomfd5+3qj2f7WXDT1wfTVS013Ij8iyqO/GVfTKgb
	 HimOuNcdPffpCYUKg4n/InzdX1VlL1S4deClmhtyTgJaKIR64RByMntBmNnW/XKhZ9
	 OJc80RR4bwPxQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5060VfYZ21294895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 08:31:41 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 6 Jan 2025 08:31:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 Jan 2025 08:31:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 6 Jan 2025 08:31:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
CC: Kalle Valo <kvalo@kernel.org>, Fiona Klute <fiona.klute@gmx.de>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
Thread-Topic: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
Thread-Index: AQHbXbRT6Xomx6m3pUytS3VuSE/MqbMEwvoAgAAF6oCABB9WQA==
Date: Mon, 6 Jan 2025 00:31:41 +0000
Message-ID: <01c7887bce5a4c3fade980464c155b27@realtek.com>
References: <20250103075107.1337533-1-anarsoul@gmail.com>
 <f69874f3c11f4c7b8b0e3026796bb452@realtek.com>
 <CA+E=qVfsHw_YqwVNPjhp9QydC9RUo=9U6ddA6StrmDNzgrUCxQ@mail.gmail.com>
In-Reply-To: <CA+E=qVfsHw_YqwVNPjhp9QydC9RUo=9U6ddA6StrmDNzgrUCxQ@mail.gmail.com>
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

VmFzaWx5IEtob3J1emhpY2sgPGFuYXJzb3VsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBG
cmksIEphbiAzLCAyMDI1IGF0IDE6MTPigK9BTSBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVr
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBWYXNpbHkgS2hvcnV6aGljayA8YW5hcnNvdWxAZ21haWwu
Y29tPiB3cm90ZToNCj4gPiA+IEZpeCAzIHR5cG9zIGluIDg3MDNiIGRyaXZlci4gMiB0eXBvcyBp
biBjYWxpYnJhdGlvbiByb3V0aW5lcyBhcmUgbm90DQo+ID4gPiBmYXRhbCBhbmQgZG8gbm90IHNl
ZW0gdG8gaGF2ZSBhbnkgaW1wYWN0LCBqdXN0IGZpeCB0aGVtIHRvIG1hdGNoIHZlbmRvcg0KPiA+
ID4gZHJpdmVyLg0KPiA+DQo+ID4gSnVzdCBjdXJpb3VzIGhvdyB5b3UgY2FuIGZpbmQgdGhlc2Ug
dHlwb3M/DQo+IA0KPiBJIGFkZGVkIHRyYWNlcyB0byBzZGlvXyogZnVuY3Rpb25zIGluIGxpbnV4
IChzZWUgWzFdKSwgc28gSSBjYW4NCj4gY2FwdHVyZSByZWdpc3RlciBhY2Nlc3MgdHJhY2VzLiBJ
IGNhcHR1cmVkIHRoZSB0cmFjZXMgZnJvbSBib3RoIHJ0dzg4DQo+IGFuZCB0aGUgdmVuZG9yIGRy
aXZlciBhbmQgd3JvdGUgYSBzaW1wbGUgcGFyc2VyIHRoYXQgZGVjb2RlcyB0aGUNCj4gdHJhY2Vz
LCBzZWUgWzJdLiBJIGd1ZXNzIGl0IHdvdWxkIGJlIGVhc2llciB3aXRoIGFuIFVTQiBkZXZpY2Us
IHdoZXJlDQo+IHdlIGhhdmUgdXNibW9uLiBJIHJlYWxseSB3aXNoIHRoZXJlIHdhcyBzb21ldGhp
bmcgbGlrZSB1c2Jtb24gZm9yDQo+IFNESU8uDQo+IA0KPiBJIGFsc28gYWRkZWQgdHJhY2VzIGZv
ciBDMkggbWVzc2FnZXMgdG8gYm90aCBkcml2ZXJzLCBzaW5jZSB0aGV5IGdvDQo+IHRocm91Z2gg
c2Rpb19tZW1jcHlfZnJvbWlvKCkgdGhhdCBJIGRvbid0IHRyYWNlLg0KPiANCj4gT25jZSBJIGhh
ZCB0aGUgdHJhY2VzLCBJIG1hbnVhbGx5IGNvbXBhcmVkIHRoZW0gKGFsb25nIHdpdGggcmVnaXN0
ZXINCj4gZHVtcHMsIHJ0dzg4IGhhcyBpdCBpbiBkZWJ1Z2ZzLCB2ZW5kb3IgZHJpdmVyIGluIHBy
b2MpIHRyeWluZyB0byBmaW5kDQo+IHRoZSB3cml0ZXMgdGhhdCBkbyBub3QgbWF0Y2guIFVuZm9y
dHVuYXRlbHksIHJ0dzg4IGFuZCB2ZW5kb3IgZHJpdmVyDQo+IGZsb3dzIGFyZSBkaWZmZXJlbnQg
ZW5vdWdoLCBzbyBJIGNvdWxkbid0IGNvbWUgdXAgd2l0aCBhIHdheSB0bw0KPiBjb21wYXJlIGl0
IGF1dG9tYXRpY2FsbHkNCj4gDQo+IEFkcmlhbiBhbmQgQml0dGVyYmx1ZSBzdXBwb3J0ZWQgbWUg
b24gI2xpbnV4LXdpcmVsZXNzIG9uIElSQywgYW5kIG9uZQ0KPiBvZiB0aGUgdHlwb3MgaW4gSVFL
IGNhbGlicmF0aW9uIHdhcyBhY3R1YWxseSBmb3VuZCBieSBCaXR0ZXJibHVlLg0KPiANCj4gSXQg
dG9vayB+NSBldmVuaW5ncyBhbmQgMSB3ZWVrZW5kIHRvIGdldCB0byBSRUdfT0ZETTBfVFhfUFNE
X05PSVNFDQo+ICgweGNlNCkuIE9uY2UgSSBjaGFuZ2VkIGl0IGZyb20gMCB0byAweDEwMDAwMDAw
IHZpYSByZWdfd3JpdGUgb3Zlcg0KPiBkZWJ1Z2ZzLCBpdCBtYWdpY2FsbHkgZml4ZWQgdGhlIGlz
c3VlLiBJIGNoYW5nZWQgaXQgYmFjayB0byAwIHRvDQo+IGNvbmZpcm0gdGhhdCBpdCBicmVha3Mg
aXQgYWdhaW4sIGFuZCB0aGVuIGJhY2sgdG8gMHgxMDAwMDAwMCB0byBzZWUgaXQNCj4gd29ya2lu
Zy4gVGhlbiBpdCB3YXMganVzdCBhIG1hdHRlciBvZiBncmVwIHRvIGZpbmQgd2hlcmUgdGhpcyBy
ZWdpc3Rlcg0KPiBpcyB3cml0dGVuIGluIHJ0dzg4IGFuZCBjb21wYXJlIHRoZSBjb3JyZXNwb25k
aW5nIGNvZGUgdG8gdGhlIHZlbmRvcg0KPiBkcml2ZXIuDQo+IA0KPiBbMV0gaHR0cHM6Ly9naXRo
dWIuY29tL2FuYXJzb3VsL3J0bDg3MjNjcy1yZS9ibG9iL21hc3Rlci9zZGlvX3RyYWNlcy5wYXRj
aA0KPiBbMl0gaHR0cHM6Ly9naXRodWIuY29tL2FuYXJzb3VsL3J0bDg3MjNjcy1yZQ0KPiANCg0K
Q29vbC4gSSBkaWQgc2ltaWxhciB3b3JrcyB3aGVuIHdlIHJld3JpdGUgcnR3ODkgZnJvbSB2ZW5k
b3IgZHJpdmVycy4NClNvbWV0aW1lcyB3ZSBhbHNvIGZvdW5kIGZsYXdzIG9mIHZlbmRvciBkcml2
ZXIgYnkgdGhlaXIgZGlmZmVyZW5jZS4gDQoNClBpbmctS2UNCg0K

