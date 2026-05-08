Return-Path: <linux-wireless+bounces-36108-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEIDOfR//WnnegAAu9opvQ
	(envelope-from <linux-wireless+bounces-36108-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 08:17:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4524D4F254E
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 08:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 333A2303D322
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 06:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C6D35E94E;
	Fri,  8 May 2026 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="iEZ8x5Wm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93E335091;
	Fri,  8 May 2026 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778221003; cv=none; b=O95PsWMMNG4a7+975wjh3MmjV3ffRuC2uGkNWtoL1d8+mA9K5CoeV6rCpbRsnPZ7dI0o9URTeHOsoqlxsmOArKA13SG8hhVQycb8DArRZmU7UJgj4hkIb6mz+r3ED93Wv/LtGgS4QvituefB9EW14MAJpHs8nB6cMd4WkU4DEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778221003; c=relaxed/simple;
	bh=njU0df4x2/SD5Lpv2ll03Aq096sdPexedEotJp3tmDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HawMa5mFYHr7tNMXoLKVIN2wNDzSSAZPLFUmMBB00cuee1xpGXDTN59OQsubq38YgICIRM0oaMV/cCgkv5PIIT1ILt63VMZOhCpj1wZsVUUutp8yZS2p8cD/fiJjYMG5ujVL62g6agoMe/XiAZi+/PrCeX6G5bWhwgppfYnWHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=iEZ8x5Wm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6486GEZG03369196, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778220974; bh=njU0df4x2/SD5Lpv2ll03Aq096sdPexedEotJp3tmDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=iEZ8x5WmzwMC4TTT/4MFn9E6oLWFPhYXfKh06M+4jBckCZTQnVI4ZV4btD6+yZ7Db
	 wIOb1AbS4PLKe7X/4aq/byeSGt4llzj0HlistKSs7an4PmOddDuN6dZYJUzNPBUUsA
	 u6R+jGUTJ6hl+8GcMw9dQQVzX+ggivvk4ygguuE5s2lBMA7qNaC/H81JHh5FXQjT0V
	 vzj8vNLZbV86ZmYdf0ntA359Ej+IzZte+ghSn5pQup9+x362jFqxLT1rZFdv5a2/x2
	 Z+Qb4EiRIVZorXgkZDlT69RKH2VJQ+jebRr7HFyOxbwOtianzz6kGVf3Buh6EA3Rh+
	 qjniKw2dzCmlg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6486GEZG03369196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 14:16:14 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 8 May 2026 14:16:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 8 May 2026 14:16:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 8 May 2026 14:16:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Luka Gejak <luka.gejak@linux.dev>, Kalle Valo <kvalo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw88: usb: fix memory leaks on USB write
 failures
Thread-Topic: [PATCH v2] wifi: rtw88: usb: fix memory leaks on USB write
 failures
Thread-Index: AQHc3j/OOu/4/utTZEaDbodmaqilHLYDe5ug//+JaACAAKIUEA==
Date: Fri, 8 May 2026 06:16:14 +0000
Message-ID: <7381bc07c1734fd9b2e5d2cb6071d957@realtek.com>
References: <20260507163709.73581-1-luka.gejak@linux.dev>
 <25a127932474456f862b0a20f7c60b65@realtek.com>
 <1C7E1191-635B-4806-946C-62DD1C82F79A@linux.dev>
In-Reply-To: <1C7E1191-635B-4806-946C-62DD1C82F79A@linux.dev>
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
X-Rspamd-Queue-Id: 4524D4F254E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36108-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:mid,realtek.com:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

THVrYSBHZWphayA8bHVrYS5nZWpha0BsaW51eC5kZXY+IHdyb3RlOg0KPiBPbiBNYXkgOCwgMjAy
NiA1OjQ3OjU1IEFNIEdNVCswMjowMCwgUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
IHdyb3RlOg0KPiA+bHVrYS5nZWpha0BsaW51eC5kZXYgPGx1a2EuZ2VqYWtAbGludXguZGV2PiB3
cm90ZToNCj4gPj4gRnJvbTogTHVrYSBHZWphayA8bHVrYS5nZWpha0BsaW51eC5kZXY+DQo+ID4+
DQo+ID4+IFdoZW4gcnR3X3VzYl93cml0ZV9wb3J0KCkgZmFpbHMgdG8gc3VibWl0IGEgVVNCIFJl
cXVlc3QgQmxvY2sgKFVSQikNCj4gPj4gKGUuZy4sIGR1ZSB0byBkZXZpY2UgZGlzY29ubmVjdCBv
ciBFTk9NRU0pLCB0aGUgY29tcGxldGlvbiBjYWxsYmFjayBpcw0KPiA+PiBuZXZlciBleGVjdXRl
ZC4NCj4gPj4NCj4gPj4gQ3VycmVudGx5LCB0aGUgZHJpdmVyIGlnbm9yZXMgdGhlIHJldHVybiB2
YWx1ZSBvZiBydHdfdXNiX3dyaXRlX3BvcnQoKQ0KPiA+PiBpbiBydHdfdXNiX3dyaXRlX2RhdGEo
KSBhbmQgcnR3X3VzYl90eF9hZ2dfc2tiKCkuIEJlY2F1c2UgdGhlc2UNCj4gPj4gZnVuY3Rpb25z
IHJlbHkgb24gdGhlIGNvbXBsZXRpb24gY2FsbGJhY2sgdG8gZnJlZSB0aGUgc29ja2V0IGJ1ZmZl
cnMNCj4gPj4gKHNrYnMpIGFuZCB0aGUgdHJhbnNhY3Rpb24gY29udHJvbCBibG9jayAodHhjYiks
IGEgc3VibWlzc2lvbiBmYWlsdXJlDQo+ID4+IHJlc3VsdHMgaW46DQo+ID4+IDEuIEEgbWVtb3J5
IGxlYWsgb2YgdGhlIGFsbG9jYXRlZCBza2IgaW4gcnR3X3VzYl93cml0ZV9kYXRhKCkuDQo+ID4+
IDIuIEEgbWVtb3J5IGxlYWsgb2YgdGhlIHR4Y2Igc3RydWN0dXJlIGFuZCBhbGwgYWdncmVnYXRl
ZCBza2JzIGluDQo+ID4+ICAgIHJ0d191c2JfdHhfYWdnX3NrYigpLg0KPiA+Pg0KPiA+PiBGaXgg
dGhpcyBieSBjaGVja2luZyB0aGUgcmV0dXJuIHZhbHVlIG9mIHJ0d191c2Jfd3JpdGVfcG9ydCgp
LiBJZiBpdA0KPiA+PiBmYWlscywgZXhwbGljaXRseSBmcmVlIHRoZSBza2IgaW4gcnR3X3VzYl93
cml0ZV9kYXRhKCksIGFuZCBwcm9wZXJseQ0KPiA+PiBwdXJnZSB0aGUgdHhfYWNrX3F1ZXVlIGFu
ZCBmcmVlIHRoZSB0eGNiIGluIHJ0d191c2JfdHhfYWdnX3NrYigpLg0KPiA+Pg0KPiA+PiBUaGUg
aXNzdWUgd2FzIGRpc2NvdmVyZWQgaW4gcHJhY3RpY2UgZHVyaW5nIGRldmljZSBkaXNjb25uZWN0
L3JlY29ubmVjdA0KPiA+PiBzY2VuYXJpb3MgYW5kIG1lbW9yeSBwcmVzc3VyZSBjb25kaXRpb25z
LiBUZXN0ZWQgYnkgdmVyaWZ5aW5nIG5vcm1hbCBUWA0KPiA+PiBvcGVyYXRpb24gY29udGludWVz
IGFmdGVyIHRoZSBmaXggd2l0aG91dCByZWdyZXNzaW9ucy4NCj4gPg0KPiA+RGlkIHRoZSBtZW1v
cnkgcHJlc3N1cmUgY29uZGl0aW9uIGhhcHBlbj8gYW5kIGZhbGxzIGludG8gdGhlIGNhc2VzIHlv
dSBhcmUNCj4gPmFkZGluZz8gVGhpcyBpcyBtYWluIHRoaW5nIEkgd2FudCB0byBrbm93Lg0KPiA+
DQo+ID4+DQo+ID4+IEZpeGVzOiA4N2NhZWVmMDMyZmMgKCJ3aWZpOiBydHc4ODogQWRkIHJ0dzg3
MjNkdSBjaGlwc2V0IHN1cHBvcnQiKQ0KPiA+DQo+ID5JIGRvbid0IGZpbmQgdGhpcyBjb21taXQg
dG91Y2hpbmcgdGhlIGNvZGUgcmVsYXRlZCB0byB0aGlzIHBhdGNoLg0KPiA+DQo+ID4+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4+IFRlc3RlZC1ieTogTHVrYSBHZWphayA8bHVrYS5n
ZWpha0BsaW51eC5kZXY+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEx1a2EgR2VqYWsgPGx1a2EuZ2Vq
YWtAbGludXguZGV2Pg0KPiA+PiAtLS0NCj4gPj4gQ2hhbmdlcyBpbiB2MjoNCj4gPj4gIC0gVXNl
IHJldCA9IHJ0d191c2Jfd3JpdGVfcG9ydCguLi4pOyBzdHlsZSwgYW5kIGNoZWNrIGJ5IG5leHQg
bGluZSAoaW4NCj4gPj4gICAgcnR3X3VzYl90eF9hZ2dfc2tiKQ0KPiA+PiAgLSBSZW1vdmUgdW5u
ZWNlc3NhcnkgY29tbWVudA0KPiA+PiAgLSBVc2UgaWVlZTgwMjExX3B1cmdlX3R4X3F1ZXVlKCkg
aW5zdGVhZCBvZiBza2JfcXVldWVfcHVyZ2UoKQ0KPiA+DQo+ID5JZiBpdCBmYWxscyBpbnRvIHRo
ZSBjYXNlLCB5b3Ugd2lsbCBzZWUgc29tZSB3YXJuaW5ncyB3aXRob3V0IHRoaXMgY2hhbmdlLg0K
PiA+DQo+ID5BZ2FpbiwgSSdkIGxpa2UgdG8ga25vdyBpZiBPT00gY2FuIGhhcHBlbiBpbiB5b3Vy
IHRlc3Q/IElmIG5vdCwgdGhlIHRlc3QNCj4gPnlvdSBhcmUgZG9pbmcgd2lsbCBwcm92ZSBub3Ro
aW5nLCBzaW5jZSB5b3VyIGNoYW5nZXMgYXJlIGV4ZWN1dGVkIG9ubHkgaWYgT09NLg0KPiA+DQo+
ID4+ICAtIEFkZCB0ZXN0aW5nIGRldGFpbHMgdG8gY29tbWl0IG1lc3NhZ2UNCj4gPj4NCj4gPg0K
PiBXaGlsZSB0cmlnZ2VyaW5nIGEgZ2VudWluZSBPT00gY29uZGl0aW9uICgtRU5PTUVNKSBkdXJp
bmcNCj4gdXNiX3N1Ym1pdF91cmIgaXMgYWRtaXR0ZWRseSBkaWZmaWN1bHQgdG8gZm9yY2UgYW5k
IHJhcmUgaW4gc3RhbmRhcmQNCj4gZW52aXJvbm1lbnRzLCBteSB0ZXN0aW5nIHByaW1hcmlseSBy
ZWxpZWQgb24gZGV2aWNlIGRpc2Nvbm5lY3RzLg0KPiBXaGVuIGEgVVNCIGFkYXB0ZXIgaXMgYWJy
dXB0bHkgdW5wbHVnZ2VkLCBydHdfdXNiX3dyaXRlX3BvcnQoKQ0KPiBuYXR1cmFsbHkgZmFpbHMg
dG8gc3VibWl0IHRoZSBVUkINCj4gKHJldHVybmluZyAtRU5PREVWLCAtRVNIVVRET1dOLCBldGMu
KS4gDQoNCkkgZ290IHRoZSBwb2ludCB0aGF0IHlvdSBkaWQgdW5wbHVnIHRoZSBkZXZpY2UuDQoN
Cj4gV2hlbiB0aGlzIGhhcHBlbnMsIHRoZSBVU0INCj4gc3Vic3lzdGVtIG5ldmVyIGV4ZWN1dGVz
IHRoZSBjb21wbGV0aW9uIGNhbGxiYWNrDQo+IChydHdfdXNiX3dyaXRlX3BvcnRfdHhfY29tcGxl
dGUgb3IgcnR3X3VzYl93cml0ZV9wb3J0X2NvbXBsZXRlKS4NCj4gQmVjYXVzZSB0aGUgb3JpZ2lu
YWwgY29kZSBpZ25vcmVkIHRoZSByZXR1cm4gdmFsdWUgb2YNCj4gcnR3X3VzYl93cml0ZV9wb3J0
KCksIGl0IGxlYWtlZCB0aGUgc2tiIGFuZCB0eGNiIHN0cnVjdHVyZXMgZXZlcnkgdGltZQ0KPiBh
IHdyaXRlIHdhcyBhdHRlbXB0ZWQgaW1tZWRpYXRlbHkgZm9sbG93aW5nIGEgZGlzY29ubmVjdC4g
Q2hlY2tpbmcgdGhlDQo+IHJldHVybiB2YWx1ZSBjYXRjaGVzIHRoaXMgZXhhY3Qgc3VibWlzc2lv
biBmYWlsdXJlIGFuZCBmcmVlcyB0aGUNCj4gc3RydWN0dXJlcyBvbiB0aGUgc3BvdC4NCj4gQW5k
IHNob3VsZCBJIHVzZSBjb21taXQgdGhhdCBpbnRyb2R1Y2VkIFVTQiBzdXBwb3J0IGZvciBGaXhl
cyB0YWc/DQoNCkkgdGhpbmsgaXQgc2hvdWxkIGJlLg0KDQpQaW5nLUtlIA0KDQo=

