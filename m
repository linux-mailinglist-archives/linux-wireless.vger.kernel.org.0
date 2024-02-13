Return-Path: <linux-wireless+bounces-3542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065EA853295
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 15:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833561F2469F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 14:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32025732B;
	Tue, 13 Feb 2024 14:05:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F756B68
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833127; cv=none; b=JJXG7KGzXwF0MJyYt856DGCFTyDI40JA0FWYgKYifbyhfc7OI3cR1G12PtjKcvenT8eZK8RL5CO9abmB5j38waTKuRA17XQO41Rfk7NFyF6VU4niuOgJV15+/BvH0JZSc95NNWikNNUgJHWs01QmosgtonkfJFnnwf5y8c8jSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833127; c=relaxed/simple;
	bh=4+VoJb4u/Jra0qfn34qWXu4RA2x4KYekIg9dKnhdCEM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VpYmxT7A1Hy0pMiaFFnj2X1cb+x8H+iOoFtgFglj6wOjfazeVqJMa1blsBEfXJOlmb5rrOdxaXPiig1wXZ1bC/pVlRZlg8edtH2PkjMkKeR98GftaVxZAPZeVqxgXBdaYisldLN8VVbizokigvsV3cLI2x6nHgvMRqmMVU1eY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41DE5ECK01748652, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41DE5ECK01748652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 22:05:14 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 13 Feb 2024 22:05:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 22:05:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 13 Feb 2024 22:05:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into chandef
Thread-Topic: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
Thread-Index: AQHaUuQAKtICccJuvkyOo86/O7KcarEHdDiAgAAVK4CAADaQAIAACDkAgAAXGwA=
Date: Tue, 13 Feb 2024 14:05:13 +0000
Message-ID: <d2b42434af3c81e467b0b2f24feb1b142686d35f.camel@realtek.com>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
	 <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
	 <f489a916f416cb37b527868c4be0c59547bdeb4d.camel@realtek.com>
	 <94bd67a6f261d945917067334b633c78be665c6b.camel@sipsolutions.net>
	 <a17862ae423422b636c76f116e712e7ebed51c09.camel@realtek.com>
	 <e50e2336dd2717e7271e7e6f341437637192f717.camel@sipsolutions.net>
In-Reply-To: <e50e2336dd2717e7271e7e6f341437637192f717.camel@sipsolutions.net>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <C68195B3C78AD244891D5FC8C9B890EE@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gVHVlLCAyMDI0LTAyLTEzIGF0IDEzOjQxICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiANCj4gPiA+IFRoZSBvdGhlciB0aGluZyBoZXJlIGlzIHRoYXQgSSdtIG5vdCBlbnRpcmVseSBz
dXJlIGhvdyB0aGUgZHJpdmVyIHdvcmtzLA0KPiA+ID4gY2hhbmNlcyBhcmUgdGhhdCB0aGlzIHdh
cyBwcmV2aW91c2x5IGEgYnVnLCBhbmQgbm93IGlzIHN0aWxsIGEgYnVnLA0KPiA+ID4gdW5sZXNz
IHRoZSBkcml2ZXIgZG9lc24ndCByZWFsbHkgc3VwcG9ydCBjaGFubmVsIGNvbnRleHRzLCBvciBh
bnkgZm9ybQ0KPiA+ID4gb2YgY29uY3VycmVuY3kuDQo+ID4gDQo+ID4gVGhpcyBmdW5jdGlvbiBp
cyB0byBpbml0aWFsaXplIGEgc3RhdGlvbiBpbnN0YW5jZSBpbiBmaXJtd2FyZSB3aGlsZQ0KPiA+
IGFzc29jaWF0aW5nLCBhbmQgdGhlIGZpZWxkIG9mIGZpcm13YXJlIGNvbW1hbmQgaXMgdG8gdGVs
bCBNQUMgaGFyZHdhcmUNCj4gPiB0aGUgc3ViLWNoYW5uZWxzIGl0IGNhbiB1c2UgdG8gdHJhbnNt
aXQsIHdoaWNoIHNob3VsZCByZWx5IG9uDQo+ID4gYml0bWFwIG9mIHB1bmN0dXJpbmcuIEluaXRp
YWxseSwgd2UganVzdCB3YW50ZWQgdGhlIGZpZWxkIHZhbHVlIHRvDQo+ID4gYmUgfjAgKDB4RkZG
RikgdG8gcHJldmVudCBUWCBzdHVjaywgYnV0IG5vdCBmdWxseSBpbXBsZW1lbnRlZCBwdW5jdHVy
aW5nDQo+ID4gZmVhdHVyZS4NCj4gPiANCj4gPiBJIHRoaW5rIHRoaXMgaXMgdGhlIHJlYXNvbiB5
b3UgYXJlIGNvbmZ1c2VkLg0KPiANCj4gTm90IHN1cmUgdGhhdCBleHBsYW5hdGlvbnMgaGVscHMg
Oy0pDQoNCk9vcHMuIEkgYXNzdW1lZCB5b3Ugd2FudCB0byBrbm93ICJob3cgZGlkIGl0IHdvcmsg
dG8geW91PyIsIGFuZCBteSBhbnN3ZXINCndhcyB0aGF0IHdlIGp1c3Qgd2FudGVkIHRvIGZpeCBU
WCBzdHVjayBwcm9ibGVtLiBCdXQgdGhpcyBzdG9yeSBpc24ndCANCmludGVyZXN0aW5nIGF0IGFs
bC4gWEQNCg0KPiANCj4gSWYgeW91IGhhdmUgdGhpcyBwZXIgc3RhdGlvbiBob3cgZG8geW91IGhh
bmRsZSBDQ0E/IFdoaWNoIHdhcyBraW5kIG9mDQo+IHRoZSByZWFzb24gSSBtb3ZlZCBpdCBhbGwg
YmFjayB0byB0aGUgY2hhbmRlZj8gTm90IHRoYXQgdGhpcyBkaWRuJ3QgbWFrZQ0KPiB0aGUgY29k
ZSBzaW1wbGVyIChpbiBtYWM4MDIxMSkgZWl0aGVyIGFzIGEgbmljZSBzaWRlIGVmZmVjdCA6LSkN
Cg0KRG8geW91IG1lYW4gQ0NBIHNob3VsZCBjb25zaWRlciBwdW5jdHVyZWQgc3ViLWNoYW5uZWxz
PyAoQ0NBIGRvZXNuJ3QNCm5lZWQgdG8gY29uc2lkZXIgZW5lcmd5IG9mIHB1bmN0dXJlZCBvbmVz
KQ0KDQpUaGUgZmlybXdhcmUgY29tbWFuZCBtZW50aW9uZWQgaW4gdGhpcyBwYXRjaCBpcyB1c2Vk
IHRvIGNvbnRyb2wNClRYIHN1Yi1jaGFubmVscyBmcm9tIE1BQyB0byBCQiBsYXllcnMsIGFuZCBJ
IHRoaW5rIEJCIGxheWVyIGhhcyBhbm90aGVyDQpjb250cm9sIHJlZ2lzdGVycyByZWxhdGVkIEND
QSBJIG1pc3NlZC4gVGhhbmtzIGZvciBwb2ludGluZyB0aGlzLCBJIA0Kd2lsbCBjaGVjayBvdXIg
QkIgdGVhbS4NCg0KPiA+ID4gVGhvdWdoIGl0IF9sb29rc18gbGlrZSB5b3Ugb25seSBzdXBwb3J0
IG9uZSBjaGFubmVsIGNvbnRleHQgdGhlcmUsIHNvDQo+ID4gPiBtYXliZSBhbHNvIG9ubHkgb25l
IHZpZiwgYW5kIGl0IGRvZXNuJ3QgbWF0dGVyPyBJJ2QgcHJvYmFibHkgc3RpbGwgbW92ZQ0KPiA+
ID4gaXQgb3ZlciB0byB0aGUgY2hhbi5jIGNvZGUgdGhvdWdoLCBpdCByZWFsbHkgZG9lcyBiZWxv
bmcgdGhlcmUgbW9yZSBhcw0KPiA+ID4gZGlzY3Vzc2VkIGluIHRoZSBjb21taXQgbWVzc2FnZSBv
ZiB0aGlzIGNoYW5nZS4NCj4gPiA+IA0KPiA+ID4gQnV0IEkgZGlkbid0IHdhbnQgdG8gbWFrZSB0
aG9zZSBtb3JlIHNlbWFudGljIGNoYW5nZXMgYmVjYXVzZSBJIGRvbid0DQo+ID4gPiBrbm93IHdo
YXQgbG9naWMgeW91ciBkZXZpY2UgYXBwbGllcyBoZXJlLg0KPiA+IA0KPiA+IFdlIGFyZSBnb2lu
ZyB0byBzdXBwb3J0IE1DQyBhbmQgTUxPLCBzbyB3ZSB3aWxsL211c3QgY29uc2lkZXIgbW9yZSB0
aGFuDQo+ID4gb25lIGNoYW5uZWwgY29udGV4dC4gQ3VycmVudGx5LCBydHc4OSBqdXN0IGNvbnNp
ZGVyICdkZWZsaW5rJyBub3QgYWN0dWFsbHkNCj4gPiAnbGlua3MnIHRoYXQgaXMgdGhlIG5leHQg
bWFpbiB3b3JrIHdlIGFyZSBkb2luZy4NCj4gDQo+IEZvciBNTE8geW91IGhhdmUganVzdCBvbmUg
dmlmIHN0aWxsLCBzbyBpdCBkb2Vzbid0IG1hdHRlci4NCg0KSSBmZWVsIHRoZW9yZXRpY2FsbHkg
b25lIE1MTyB2aWYgY2FuIGNvbnNpc3Qgb2YgdHdvIGxpbmtzIHRoYXQgdXNlDQp0d28gY2hhbm5l
bCBjb250ZXh0cy4gUGxlYXNlIGNvcnJlY3QgbWUgaWYgdGhpcyBpcyB3cm9uZy4gDQoNCkJ1dCwg
eWVzIGN1cnJlbnRseSB3ZSBqdXN0IGhhdmUgb25lIHZpZi4gV2Ugd2lsbCBoYXZlIHR3byBsYXRl
ci4gDQoNCj4gDQo+IExvb2tzIGxpa2UgTUNDIGlzIHNvbWV0aGluZyB3aXRoIG11bHRpLXZpZiAo
bG9va2luZyBhdCB5b3VyIG90aGVyDQo+IHBhdGNoc2V0KSBzbyB0aGVyZSB0aGF0IG1ha2VzIHNl
bnNlLiBOb3QgdGhhdCBJIGtub3cgd2hhdCAiTUNDIiBtZWFucyA6KQ0KDQpNQ0MgaXMgc2hvcnQg
Zm9yIG11bHRpLWNoYW5uZWwgY29uY3VycmVuY3kgdGhhdCBpcyBhIFRETUEgYmFzZWQgY29uY3Vy
cmVuY3kNCm9mIFNUQSArIFAyUCB1c2luZyBzdGFuZGFyZCBpZWVlODAyLjExIHBvd2VyIHNhdmlu
ZyBwcm90b2NvbCBhbmQgUDJQIEdPIE5vQS4NCg0KDQpQaW5nLUtlDQoNCg==

