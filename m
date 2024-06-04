Return-Path: <linux-wireless+bounces-8451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A21728FA737
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 02:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB221F2221B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2D8F45;
	Tue,  4 Jun 2024 00:50:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4968BEE
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462235; cv=none; b=YiNVNJZEcxidzFis73BZLaaL3If2saeq28wjOfBgeFhV8yHbmxRAY+iyY5L0uOSAONpy9bEIc14gjGViEEgunBBO08h2eMiHqy3wHpwQRBEC5h+qSPUwj+AM9DBBvW2RrC+xHwLldoLXa0JLn49AKYW/ATKaox3cWIAmfh7Y9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462235; c=relaxed/simple;
	bh=iC23JCVsliuJa5FErAX1Uf8E/2uooU+iBHRtQVuRq8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cz0iplsLgpu+6zRORY+R6UrtVyJHtz0IspFU0rD2fgtxDiw37ma3evsdrlsr5O2p40wiBmTkox8sU+jQmvch//rBXGmIhYLUxtMXRdDEKebKvKz7OAhaRG3pGVAQaeF+KDjEbnZLe5S3qCJ+8mEH4cy+TtydbHxqEdOtTzd52x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4540oNcmD3583941, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4540oNcmD3583941
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 08:50:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 08:50:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 4 Jun 2024 08:50:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 4 Jun 2024 08:50:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>
Subject: RE: wifi: rtw88: 8821CU hangs after some number of power-off/on cycles
Thread-Topic: wifi: rtw88: 8821CU hangs after some number of power-off/on
 cycles
Thread-Index: AQHasFw+pvHPaxxLgUK305GcfZdkyrGsA2eA///v6wCAAX/iEIAAZrWAgAE7nYCABo8AgIABKjKw
Date: Tue, 4 Jun 2024 00:50:23 +0000
Message-ID: <6267f0999f34475ab21d0c42707f1bd9@realtek.com>
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
 <9bfc8f01e99b43e485b2afc6ae4fd661@realtek.com>
 <CA+GA0_sQ_Bnp8CUq1Pmxf7zut1Kocaxbw4iXT4hYC5_ceXb7WQ@mail.gmail.com>
 <3cc9cc75468d487c988dbacd8dfc5f57@realtek.com>
 <CA+GA0_tUy0EuXm0CGYa8SsS78oRNHUanBNwRf_BLXERa1=MYdg@mail.gmail.com>
 <b9c85972ab634364bf8a705a4f4513fd@realtek.com>
 <CA+GA0_v1rpoFrRVxpKpYqOrjdxEecn_m3+RKwxYc9H761dpMvw@mail.gmail.com>
In-Reply-To: <CA+GA0_v1rpoFrRVxpKpYqOrjdxEecn_m3+RKwxYc9H761dpMvw@mail.gmail.com>
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

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4N
Cj4gPiA+IEknbSBhc2tpbmcgYmVjYXVzZSBpZiB3ZSBhcmUgZ29pbmcgaW4gdGhpcyBkaXJlY3Rp
b24sIHRoZXJlJ3Mgc29tZXRoaW5nDQo+ID4gPiBtb3JlIHRvIGZpeC4uLiBXaXRoIHlvdXIgdjIs
IHZlcnkgZnJlcXVlbnRseSwgSSBoaXQgV0FSTl9PTighbG9jYWwtPnN0YXJ0ZWQpIGluDQo+ID4g
PiBpZWVlODAyMTFfcnhfbmFwaSAoaW4gd2lyZWxlc3MtbmV4dCwgdGhlIGNvZGUgd2FzIG1vdmVk
IHRvIGllZWU4MDIxMV9yeF9saXN0KS4NCj4gPiA+DQo+ID4gPiBXaXRoIG15IHBhdGNoLCBJIGNo
ZWNrZWQgYW5kIGhpdCB0aGF0IFdBUk5fT04sIHRvbywgYnV0IHZlcnkgb2NjYXNpb25hbGx5Lg0K
PiA+ID4NCj4gPiA+IEkgdGhpbmsgdGhlIGRpZmZlcmVuY2UgaXMgaW4gd2hhdCBoYXBwZW5zIGlu
IHJ0d19pcHNfZW50ZXIgLSBJIGRpc2FibGVkIG9ubHkNCj4gPiA+IHRoZSBwb3dlcl9vZmYsIGJ1
dCB5b3UgYWxzbyBkaXNhYmxlZCBldmVyeXRoaW5nIGVsc2UsIGluY2x1ZGluZyB0aGUgY2FuY2Vs
YXRpb24NCj4gPiA+IG9mIHdvcmtfc3RydWN0cy4NCj4gPiA+DQo+ID4gPiBUaGUgd2FybmluZyBp
dHNlbGYgc291bmRzIGhhcm1sZXNzLCBidXQgSSB0aGluayB1c2VycyBzaG91bGQgbmV2ZXIgc2Vl
IHN1Y2gNCj4gPiA+IHdhcm5pbmdzLCBzbyB0aGlzIG5lZWRzIHRvIGJlIGZpeGVkIHNvbWVob3cu
IFByb2JhYmx5IHNvbWUgYWRkaXRpb25hbA0KPiA+ID4gd29ya19zdHJ1Y3QocykgbmVlZCB0byBi
ZSBjYW5jZWxlZD8NCj4gPiA+DQo+ID4NCj4gPiBJIGZvcmdvdCB0byBzYXkgbXkgcGF0Y2ggaXMg
Y29tcGlsZWQgdGVzdCBvbmx5LCBhbmQgSSBkaWRuJ3QgY29uc2lkZXIgZmxvdw0KPiA+IHRvbyBt
dWNoLCBqdXN0IHRvIGNsb3NlIHRoZSBiZWhhdmlvciBvZiB5b3VyIHBhdGNoZXMuIFlvdSBjYW4g
aW1wcm92ZSBteSBwYXRjaA0KPiA+IHRvIGJlIG1vcmUgcmVsaWFibGUgdG8gYXZvaWQgV0FSTl9P
TigpLg0KPiANCj4gVHdvIHZhcmlhbnRzIG9mIHRoZSBwYXRjaCB0aGF0IGZpeCB0aGlzIGlzc3Vl
IHdpbGwgZm9sbG93LiBUaGV5IGFyZQ0KPiBidWlsdCBvbiB0b3Agb2YgeW91cnMNCj4gdjIgYW5k
IG15ICJ3aWZpOiBydHc4ODogc2NoZWR1bGUgcnggd29yayBhZnRlciBldmVyeXRoaW5nIGlzIHNl
dCB1cCINCj4gZnJvbSB0aGUgb3RoZXIgdGhyZWFkLg0KPiBQbGVhc2UgY2hvb3NlIHRoZSBvbmUg
eW91IGxpa2UgbW9yZSA6KS4NCg0KVGhlIHBhdGNoICJ3aWZpOiBydHc4ODogdXNiOiBkcm9wIHJ4
IHNrYnMgd2hlbiBkZXZpY2UgaXMgbm90IHJ1bm5pbmciIGlzDQp0byBkcm9wIGFsbCBza2IgaXQg
cmVjZWl2ZXMuIFVTQiBpcyBzdGlsbCB3b3JraW5nLCBzbyBJIGRvbid0IHByZWZlciB0aGlzLg0K
DQoid2lmaTogcnR3ODgvdXNiOiBzdG9wIHJ4IHdvcmsgYmVmb3JlIHBvdGVudGlhbCBwb3dlciBv
ZmYiIHNlZW1zIHRvIHN0b3ANClJYLiBCdXQgaG93IHJ0d191c2JfY2FuY2VsX3J4X2J1ZnMoKSBj
YW4gc3RvcCBSWD8gUmVtb3ZlIFJYIHVyYiB0byBzdG9wIGl0Pw0KTm90IHN1cmUgaWYgdGhpcyBp
cyByZWd1bGFyIG1ldGhvZCBmb3IgVVNCIGRldmljZXM/DQoNCkJ5IHRoZSB3YXksIHBsZWFzZSB0
YWtlIGFuZCByZWZpbmUgbXkgdjIgcGF0Y2ggaW50byB5b3VyIHBhdGNoc2V0LiBUaGF0IHdpbGwN
CmJlIGVhc2llciB0byBtZSB0byBtZXJnZSBwYXRjaGVzIGZpbmFsbHkuDQoNClBpbmctS2UNCg0K

