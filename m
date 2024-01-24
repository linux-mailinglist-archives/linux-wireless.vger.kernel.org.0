Return-Path: <linux-wireless+bounces-2421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B5839E7B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 02:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9261C2324B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 01:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E1D17CB;
	Wed, 24 Jan 2024 01:56:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E015D2
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061391; cv=none; b=pzIpuNF6pdrQuRF9T1pIa7gKoQZHfmFMQ9vFUZRPYWjNmbOCCrawEDfmr3fTDYd3YEL12wXhkBaiRz/EHAR21Y+PrrbajjBuBWeMHUcQxRsWlSTXsJ/z/plGvkftWAIwMbJ7fWYCiTI0MPHaWeckXdjPbfPMdwnMbw29j0qZXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061391; c=relaxed/simple;
	bh=Mo04dEGGJV/wvN6fxHnrUO/qOzo0F0fQGBcJ9NgusqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E9fnAW31MP4jgKbP8ZVvZ+n1qcxjrksJCyoNiIsjExkciu8AsTTBIqrIrzHgBdu1tYbSs665TwBJmruz8olqBrfCfZ6aylUcvyudMzGfKzE2Z5ll+0m5+N23lkvI5XCFrb2F4gQa7Zx3eRFq0232CHhhSQcUe5tc+XV8eGeVH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40O1ttrjF634491, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40O1ttrjF634491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 09:55:55 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Wed, 24 Jan 2024 09:55:56 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 09:55:56 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Wed, 24 Jan 2024 09:55:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH] wifi: rtl8xxxu: update rate mask per sta
Thread-Topic: [PATCH] wifi: rtl8xxxu: update rate mask per sta
Thread-Index: AQHaSVU1/kXlkXq/OEm3ZacX5mGlCLDevu1wgAZTiYCAAxgwQA==
Date: Wed, 24 Jan 2024 01:55:56 +0000
Message-ID: <46aea2f4feea4f00aba0e2335f30bf76@realtek.com>
References: <20240117145516.497966-1-martin.kaistra@linutronix.de>
 <4d5f06f2407042f2862af7559ed66eac@realtek.com>
 <9aadc704-48ec-4417-82fa-c5f7b19801ff@linutronix.de>
In-Reply-To: <9aadc704-48ec-4417-82fa-c5f7b19801ff@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEthaXN0cmEg
PG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAy
MiwgMjAyNCA1OjMwIFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVzIFNvcmVuc2VuIDxKZXMu
U29yZW5zZW5AZ21haWwuY29tPjsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IEJpdHRl
cmJsdWUgU21pdGgNCj4gPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPjsgU2ViYXN0aWFuIEFuZHJ6
ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSB3aWZpOiBydGw4eHh4dTogdXBkYXRlIHJhdGUgbWFzayBwZXIgc3RhDQo+IA0KPiBBbSAxOC4w
MS4yNCB1bSAwMjozNyBzY2hyaWViIFBpbmctS2UgU2hpaDoNCj4gPg0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1hcnRpbiBLYWlzdHJhIDxtYXJ0aW4u
a2Fpc3RyYUBsaW51dHJvbml4LmRlPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTcs
IDIwMjQgMTA6NTUgUE0NCj4gPj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0K
PiA+PiBDYzogSmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgS2FsbGUgVmFs
byA8a3ZhbG9Aa2VybmVsLm9yZz47IFBpbmctS2UgU2hpaA0KPiA+PiA8cGtzaGloQHJlYWx0ZWsu
Y29tPjsgQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+OyBTZWJhc3Rp
YW4gQW5kcnplaiBTaWV3aW9yDQo+ID4+IDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+DQo+ID4+ICsN
Cj4gPj4gKyAgICAgICBzdGEgPSBpZWVlODAyMTFfZmluZF9zdGFfYnlfaWZhZGRyKHByaXYtPmh3
LCBoZHItPmFkZHIyLA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdmlmLT5hZGRyKTsNCj4gPg0KPiA+IENhbid0IHdlIHNlYXJjaCBmb3IgJ3N0YScgYnkg
cnhfZGVzYy0+bWFjX2lkPyBUaGVuLCB5b3UgZG9uJ3QgbmVlZCBhIGxvdCBvZg0KPiA+IGNvZGUg
dG8gY2hlY2sgYWRkcmVzcy4NCj4gDQo+IEkgYXNzdW1lLCB5b3UgbWVhbiByeF9kZXNjLT5tYWNp
ZD8gV2hlbiBJIHRyeSB0byB0ZXN0IHRoaXMsIGl0IGxvb2tzIHRvIG1lIGFzIGlmDQo+IHRoZSBh
c3NpZ25tZW50IG9mIG1hY2lkIHRvIHN0YSBpbiByeCBkb2VzIG5vdCBtYXRjaCB0aGUgYXNzaWdu
bWVudCBpbiB0aGUgZHJpdmVyLg0KPiBGb3IgZXhhbXBsZSwgSSBleHBlY3QgdGhlIGZpcnN0IGNv
bm5lY3RlZCBzdGF0aW9uIHRvIGJlIG1hY2lkIDIsIHdoaWNoIGlzIGFsc28NCj4gc2VudCB0byB0
aGUgZmlybXdhcmUgYnkgcmVwb3J0X2Nvbm5lY3QsIGJ1dCBpbiByeGRlc2MgaXQgaXMgbWFjaWQg
MS4gQ2FuIHRoaXMNCj4gZXZlbiBiZSBpbmZsdWVuY2VkIGJ5IHRoZSBkcml2ZXI/DQoNClRoZSBy
eF9kZXNjLT5tYWNpZCBpcyBub3QgYWx3YXlzIHVzYWJsZSBmb3IgdGhpcyBnZW5lcmF0aW9uIGNo
aXBzLCBzbyBqdXN0IHlvdXINCm9yaWdpbmFsIGxvZ2ljLiANCg0KDQo=

