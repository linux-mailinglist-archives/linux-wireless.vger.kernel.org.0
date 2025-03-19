Return-Path: <linux-wireless+bounces-20524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C37A6817D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 01:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981483BD9E1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 00:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4F514F70;
	Wed, 19 Mar 2025 00:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LC3MrbFw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E008F6D
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344129; cv=none; b=mg845CSA4QfBbayMcboIk8ATmx6BtPEKypTTqz8LqnFc62KZvuV57j942AFkaa8zNZv7tdsN45Y8yITxFq2wjO5yTTWa86OvzfgxtxdI6iFcovFy4MB6yvJu7unlMfpWjWXrFBZ982XH28epM8rhVY4gA93SkNNmWOTGQfnbVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344129; c=relaxed/simple;
	bh=ItGqurRi4G7UXl4mQd6Ktkc+b7m/l/3Ja6iLstVrIL4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8yz02g2xWM0CuS7ywq+DWz4bSaxds+IrrnE12YTC9xhUS1l6qFzJEUtrzxlYmU9BYEmQ7iJBDh6Q8EQ3aPnblXtkCAEnh8n49/P2ENWNd1Unt5+arB0CENY6YWkL6s5LuXhIWBrjha8WIBi7XP+KREp3qFLPLco/QYObVy9lQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LC3MrbFw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52J0SejU63873093, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742344120; bh=ItGqurRi4G7UXl4mQd6Ktkc+b7m/l/3Ja6iLstVrIL4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LC3MrbFwIRsblkl0ozwyvzgvtRWx8IxDdQtvu6YIX581/fHDKBfBNacKZViGyX0dw
	 SMhZfH+7z/5pV8lWXxGlG0Dux/xOU2JTFYANFwa/vp5NwFXcHlF7O5bsEgobHH3Cmj
	 WB0mFTrScTC1VOoaAsT8AdJCnuzjQME4AElEteweWtLsxy4pAqdLvdnSwMBgf+h4r5
	 5QL5TiDzc4Fe2f8MGq2PAIJYjJJ6fv7fnzAxIsiIlbDBzcyHnsdQb4cX3DDqBIF+L6
	 BNujWlpaNS6eBagyj6zKxbxlazDCkEoZruJtUK6qYMRuLbAsFRPayZpJ9JikO/a6hx
	 7ZTriSHfysN8A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52J0SejU63873093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 08:28:40 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Mar 2025 08:28:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 19 Mar 2025 08:28:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 19 Mar 2025 08:28:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
Thread-Topic: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
Thread-Index: AQHblFUnF3FHtd8BUESRxvtJE6hCX7N2ps5ggAAqRgCAAVhLgIAAknmAgADkWLA=
Date: Wed, 19 Mar 2025 00:28:40 +0000
Message-ID: <95da11e5ec6f43babaedc6dfc25c3cbf@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <289795d5-49ae-4789-8f14-b2d016843a53@gmail.com>
 <b972a60bb0b04b5f817047027970d896@realtek.com>
 <0ac48cfe-dc7a-442f-b893-41416cd3017d@gmail.com>
 <095328518444426887e039202fa8c609@realtek.com>
 <aa278922-5fac-4f47-acc2-25cc2c133365@gmail.com>
In-Reply-To: <aa278922-5fac-4f47-acc2-25cc2c133365@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
OC8wMy8yMDI1IDA0OjA2LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiAxNy8wMy8yMDI1IDA1
OjAxLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4NCj4gPj4+PiBUZWxsIHRoZSBjaGlwIHRo
ZSBtYXhpbXVtIEFNUERVIHNpemUgc3VwcG9ydGVkIGJ5IHRoZSBBUC4gVGhpcyBncmVhdGx5DQo+
ID4+Pj4gaW1wcm92ZXMgdGhlIFRYIHNwZWVkIG9mIFJUTDg4MTRBVSBpbiB0aGUgMi40IEdIeiBi
YW5kLiBCZWZvcmU6IH45MA0KPiA+Pj4+IE1icHMuIEFmdGVyOiB+MzAwIE1icHMuDQo+ID4+Pj4N
Cj4gPj4+PiBBZGQgdGhpcyBjb25maWd1cmF0aW9uIGZvciBhbGwgdGhlIGNoaXBzLCBldmVuIGlm
IGl0IG9ubHkgaGFzIGFuIGVmZmVjdA0KPiA+Pj4+IG9uIFJUTDg4MTRBVSBpbiBteSB0ZXN0cy4g
U3VyZWx5IHRoZXkgYWxsIG5lZWQgdGhpcy4NCj4gPj4+DQo+ID4+PiBUaGUgaGFyZHdhcmUgZGVm
YXVsdCB2YWx1ZSBvZiBSRUdfQU1QRFVfTUFYX0xFTkdUSCBpcyAweGZmZmYgKHVubGltaXRlZCkN
Cj4gPj4+IGZvciBtb3N0IGNoaXBzLiBJdCBzZWVtcyBsaWtlIFJUTDg4MTJBL1JUTDg4MjFBIGFy
ZSBhbHNvIGV4Y2VwdGlvbnMsIHNvDQo+ID4+PiBhdCBwb3dlciBvbiBmdW5jdGlvbiB0aGV5IGRv
DQo+ID4+PiAgICAgcnR3X3dyaXRlMzIocnR3ZGV2LCBSRUdfQU1QRFVfTUFYX0xFTkdUSCwgMHhm
ZmZmZmZmZik7DQo+ID4+Pg0KPiA+Pj4gSSBmZWVsIFJUTDg4MTRBIGhhcyBzaW1pbGFyIHNldHRp
bmcsIHNvIG1heWJlIHlvdSBjYW4ganVzdCBhZGQgc2ltaWxhcg0KPiA+Pj4gc3R1ZmYuDQo+ID4+
Pg0KPiA+Pj4gQnkgdGhlIHdheSwgdGhlIEFNUERVIGlzIGNvbnRyb2xsZWQgYnkgVFggZGVzY3Jp
cHRvciBiYXNpY2FsbHk6DQo+ID4+PiAgICAgICBwa3RfaW5mby0+YW1wZHVfZmFjdG9yID0gYW1w
ZHVfZmFjdG9yOw0KPiA+Pj4gICAgICAgcGt0X2luZm8tPmFtcGR1X2RlbnNpdHkgPSBhbXBkdV9k
ZW5zaXR5Ow0KPiA+Pj4gICAgICAgcGt0X2luZm8tPmFtcGR1X2VuID0gYW1wZHVfZW47DQo+ID4+
Pg0KPiA+Pj4gU2luY2UgeW91IGRpZG4ndCBjaGFuZ2UgdGhpcyBwYXJ0IGF0IGFsbCwgSSBzdGls
bCBmZWVsIHNldHRpbmcNCj4gPj4+IFJFR19BTVBEVV9NQVhfTEVOR1RIIHRvIDB4ZmZmZmZmZmYg
Y2FuIGZpeCBsb3cgdGhyb3VnaHB1dCBwcm9ibGVtLg0KPiA+Pj4NCj4gPj4NCj4gPj4gSSB0cmll
ZCAweGZmZmZmZmZmIGp1c3Qgbm93IGFuZCBpdCBkb2Vzbid0IHdvcmsuIEl0J3MgdGhlIHNhbWUg
d2l0aA0KPiA+PiBib3RoIG9mIG15IHJvdXRlcnMuIFRoZXkgYWR2ZXJ0aXNlIGEgbWF4aW11bSBB
TVBEVSBzaXplIG9mIDY0IEsuDQo+ID4+IEkgY2FuJ3QganVzdCBzZXQgaXQgdG8gMHhmZmZmIGVp
dGhlciwgYmVjYXVzZSB0aGVuIHRoZSB1cGxvYWQgc3BlZWQNCj4gPj4gaW4gdGhlIDUgR0h6IGJh
bmQgc3VmZmVycyBhIGxvdC4gVGhlIGR1YWwgYmFuZCByb3V0ZXIgYWR2ZXJ0aXNlcyBhDQo+ID4+
IG1heGltdW0gQU1QRFUgc2l6ZSBvZiAyNTYgSyBpbiB0aGUgNSBHSHogYmFuZCBzbyBpdCBnZXRz
IGEgdmFsdWUgb2YNCj4gPj4gMHgzZmZmZi4NCj4gPg0KPiA+IE5vdCBzdXJlIGlmIDB4ZmZmZmZm
ZmYgaXMgYSBzcGVjaWFsIHZhbHVlLiBTaW5jZSB0aGlzIGlzIGEgbGltaXQgb2YNCj4gPiBBTVBE
VSBsZW5ndGgsIHlvdSBjYW4gc2V0IGEgY29uc3RhbnQgbGFyZ2UgdmFsdWUgc3VjaCBhcyAweDNm
ZmZmIHlvdQ0KPiA+IGhhdmUgdGVzdGVkLiBJcyB0aGVyZSBzcGVjaWFsIGNhc2UgaXQgY2FuJ3Qg
aGFuZGxlPw0KPiA+DQo+ID4NCj4gDQo+IDB4M2ZmZmYgaXMgbm90IGdvb2QgZm9yIHRoZSAyLjQg
R0h6IGJhbmQuIFRoZSB1cGxvYWQgaXMgb25seSB+OTAgTWJwcw0KPiB3aXRoIGJvdGggb2YgdGhl
IHJvdXRlcnMgSSB0ZXN0ZWQuIFNhbWUgd2l0aCAweDFmZmZmLiBPbmx5IDB4ZmZmZg0KPiB3b3Jr
cyB3ZWxsIGZvciB0aGVtLg0KDQpIYXZlIHlvdSBjaGVja2VkIHRoZSBwYWNrZXRzIGluIHRoZSBh
aXI/IEhvdyBhYm91dCB0aGVpciBkaWZmZXJlbmNlPw0KSW50dWl0aXZlbHkgbGFyZ2VyIFJFR19B
TVBEVV9NQVhfTEVOR1RIIHdvdWxkIGJlIGJldHRlci4NCg0KPiANCj4gMHhmZmZmIGlzIHRvbyBs
aXR0bGUgZm9yIHRoZSA1IEdIeiBiYW5kLiBUaGUgdXBsb2FkIHNwZWVkIGlzIH4yMDAgTWJwcw0K
PiBsZXNzIHRoYW4gd2l0aCAweDNmZmZmLg0KPiANCj4gSSBndWVzcyBpZiB5b3UgcmVhbGx5IGRv
bid0IHdhbnQgdGhpcyBwYXRjaCBJIGNhbiBoYXJkY29kZSAweGZmZmYgYW5kDQo+IDB4M2ZmZmYg
aW4gcnR3ODgxNGFfc3dpdGNoX2JhbmQoKS4gSSBqdXN0IGRvbid0IGtub3cgaWYgYWxsIGFjY2Vz
cw0KPiBwb2ludHMgd2lsbCBiZSBoYXBweSB3aXRoIHRoYXQuDQoNCkluaXRpYWxseSBJIHdhbnRl
ZCB0byBzaW1wbHkgdGhpcyBwYXRjaCwgYmVjYXVzZSBjaGFuZ2luZyBSRUdfQU1QRFVfTUFYX0xF
TkdUSA0KZm9yIG90aGVyIGNoaXBzIHdpdGhvdXQgdGVzdGluZyBpcyByaXNreS4gV2l0aCB5b3Vy
IHRlc3RzLCB0aGUgYmVoYXZpb3Igb2YNClJFR19BTVBEVV9NQVhfTEVOR1RIIHdvcmtzIG5vdCBm
dWxseSBleHBlY3RlZCwgc28gSSBzdXNwZWN0IHRoZSByaXNrDQppcyBldmVuIGhpZ2hlci4gDQoN
ClRoZXJlZm9yZSwgSSB3b3VsZCBsaWtlIGxpbWl0IHRoaXMgY2hhbmdlIHRvIFJUTDg4MTRBLiBU
aG91Z2ggaGFyZGNvZGUgcHJvcG9zYWwNCmlzIG5vdCBzdXJlIHdvcmthYmxlIGZvciBhbGwgQVAs
IHdlIGFsc28gZG9uJ3Qga25vdyB0aGlzIHBhdGNoIHdvcmtzIGZvciBhbGwNCkFQLiBBbnl3YXkg
dGhpcyBwcm9wb3NhbCBpcyBmaW5lIHRvIG1lIGlmIHdlIGRvbid0IGhhdmUgb3RoZXIgaWRlYXMu
DQoNCg0K

