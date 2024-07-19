Return-Path: <linux-wireless+bounces-10367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F68937188
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 02:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38677281B9F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 00:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF64210F1;
	Fri, 19 Jul 2024 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rkf1Kh5Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE210E6
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721349268; cv=none; b=Kt+71TJDqbZFpC5H3lEUKM3efdzZmVKPEYIbpuBPZo3GdIMYAHOjPSNOZS1pHYLDyA7rebj3W+GdkPUKRIQH/6r7uzgWrCWhUcsMa0IEYpolJ6Sz8meCNdc+hAjbWdNdTaAzF8C1yyaK8leaQTfrprsEEkifxotkAdgQu5xscME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721349268; c=relaxed/simple;
	bh=2Mz6zdLp7YXFZT/3ZLEyoSfJlnNJEgmZHqgHZLW+cRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AyIutRY3Yh6XOyN1vnsmYaMQzwnnc6uepUfyLfIgz1QvX0IGPB2UBvMNzS1TTvZ6UlW8QMsmrWde45F9uyiSRnYoclX5gvri4lxmwrnJ20oOjd6O/UE8IOK/txof9hF86TLn4xj9wJR20x6ud/mRl1EbKA1F96xbwp8fYFFvC7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rkf1Kh5Z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46J0YDAy84045834, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721349253; bh=2Mz6zdLp7YXFZT/3ZLEyoSfJlnNJEgmZHqgHZLW+cRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rkf1Kh5Z9NCZMMTt1V+xTmKhQHa0PTV+qq2pPwHVZiAony9CzkRLVgbm2OJRbjX1H
	 prtuWr8z164h4nRVKncP5cwtGpqRKzs9YBlo8t6J+0IGKuqVXxRIMpRROat8dfQVh3
	 FER3raya14Jl/xJuzsIHN1YqLdOXyU6Cn5ps5M3f7AVNi7KbW2xqUiOtL4wcZWp1lk
	 YKG2ezDGkFluRZ+Y5hGChKCe4fi0sv5DTwxG/O+zUBgwI5X24JBXbG5v4E66e3LuUs
	 xKMUKjitsCJagsBFMiHjfV1+6znC3a4fzKcjoRzUv0+ArOlzai7VI6tzbHmHAsto6e
	 s5OxS3tcploRw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46J0YDAy84045834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 08:34:13 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 08:34:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jul 2024 08:34:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 19 Jul 2024 08:34:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Jesuiter, Henry" <henry.jesuiter@softing.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Le Suire, Michael" <Michael.Suire@Softing.com>,
        "Sperling, Tobias"
	<Tobias.Sperling@Softing.com>
Subject: RE: Performance of Reassociation 
Thread-Topic: Performance of Reassociation 
Thread-Index: AQHa2EeueyCxNvdWakyDpuL0/ysvurH8K4CQgAAv1i+AANfq8A==
Date: Fri, 19 Jul 2024 00:34:13 +0000
Message-ID: <d28a43de3a2c43a4882696b6fc87747f@realtek.com>
References: <BE1P281MB22104B386701ADEEE1E741269EA32@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
 <ef8f3c47b3264aedad776ff248fa635d@realtek.com>
 <BE1P281MB22102E859A8EFF4475843FB89EAC2@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <BE1P281MB22102E859A8EFF4475843FB89EAC2@BE1P281MB2210.DEUP281.PROD.OUTLOOK.COM>
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

SmVzdWl0ZXIsIEhlbnJ5IDxoZW5yeS5qZXN1aXRlckBzb2Z0aW5nLmNvbT4gd3JvdGU6DQo+IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPsKgd3JvdGU6DQo+ID4gRG9lcyBpdCBtZWFu
IDQ1MG1zIG9uIGtlcm5lbCA1LjE1LCBidXQgOTAwbXMgb24ga2VybmVsIDUuNCBmb3IgUlRMODgy
MmNlPw0KPiBbSmVzdWl0ZXIsIEhlbnJ5XQ0KPiBBY3R1YWxseSBpdCdzIHRoZSBmb2xsb3dpbmc6
DQo+ICAgKiBhYm91dCA0NTBtcyBmb3IgS2VybmVsIDYuOCAoVWJ1bnR1IDI0LjA0KSwgaTUtNzMw
MFUNCj4gICAqIGFib3V0IDYwMG1zIGZvciBLZXJuZWwgNi42IChCdWlsZHJvb3QpLCBDT01pLk1Y
IDYNCj4gICAqIGFib3V0IDYwMG1zIGZvciBLZXJuZWwgNS4xNSAoVWJ1bnR1IDIwLjA0KSwgaTUt
NzMwMFUNCj4gICAqIGFib3V0IDcwMG1zIC0gOTAwbXMgZm9yIEtlcm5lbCA1LjQgKFlvY3RvIDMu
My42KSwgQ09NaS5NWCA2DQoNCk5vIGlkZWEgd2h5IHRoZXkgYXJlIGRpZmZlcmVudCBzaW5jZSBS
VEw4ODIyQ0UgZG9lc24ndCBoYXZlIG11Y2ggY2hhbmdlIGZvciBhIGxvbmcgdGltZS4NCg0KPiA+
IEkgbWVhc3VyZSBydHdfY2hpcF9wcmVwYXJlX3R4KCkgd2hpY2ggaXMgdG8gZG8gcGh5IGNhbGli
cmF0aW9uLiBUaGUgY29zdCBpcyBhYm91dCAxOTBtcyBvbiAyR0h6IGFuZCA1R0h6DQo+IGNoYW5u
ZWxzLg0KPiBbSmVzdWl0ZXIsIEhlbnJ5XQ0KPiBUaGlzIGlzIHRoZSBzYW1lIGZ1bmN0aW9uIHRo
YXQgaXMgY2FsbGVkIG9uIHJvYW1pbmcsIGFuZCB3ZSBhcmUgZXhwZXJpZW5jaW5nIHNpbWlsYXIg
cmVzdWx0cyBoZXJlLiBUaGFua3MNCj4gZm9yIHRoZSBlZmZvcnQuDQo+IA0KPiA+IFRoZSBjb3N0
cyBJIHBvc3RlZCBhcmUgaGFyZHdhcmUtcmVsYXRlZC4gSWdub3JlIElFRUU4MDIxMV9DT05GX0lE
TEUgdG8gYXZvaWQgY2FsbGluZw0KPiBydHdfZW50ZXJfaXBzKCkvcnR3X2xlYXZlX2lwcygpLCBz
YXZpbmcgMjAwbXMgdG8gcG93ZXIgb24gaGFyZHdhcmUuDQo+IFtKZXN1aXRlciwgSGVucnldDQo+
IFdlIHRob3VnaHQgYWJvdXQgdGhhdCB0b28sIGJ1dCB3ZSBzZWUgbm8gZWFzeSB3YXkgdG8gYXZv
aWQgdGhlIHBvd2VyIGRvd24gYmVmb3JlaGFuZCwgc2luY2Ugd2UgYXJlIG5vdCBhYmxlDQo+IHRv
IGRpc3Rpbmd1aXNoIGEgcG93ZXIgZG93biBkdWUgdG8gcm9hbWluZyBmcm9tIGEgcG93ZXIgZG93
biBkdWUgdG8gb3RoZXIgcmVhc29ucy4gU28gLSBzaW5jZSB0aGUgY2hpcCBpcw0KPiBwb3dlcmVk
IGRvd24gLSB3ZSBjYW4ndCAganVzdCBza2lwIHRoZSBwb3dlciB1cCBoZXJlLiBBbnkgaWRlYXMg
YXJlIHdlbGNvbWUg8J+YiS4NCg0KTWF5YmUgeW91IGNhbiBzdGFydCBhIGRlbHllZF93b3JrIHdp
dGggMSBzZWNvbmQgZGVsYXkgd2hlbiBlbnRlcmluZyB0bw0KcnR3X2VudGVyX2lwcygpIGJ1dCBu
b3QgYWN0dWFsbHkgZW50ZXIuIEZvciBub3JtYWwgdXNlIGNhc2UsIGFmdGVyIDENCnNlY29uZCwg
Y2FsbCBydHdfZW50ZXJfaXBzKCkgdG8gcG93ZXIgZG93bi4gRm9yIHJvYW1pbmcgY2FzZSwgaXQg
bXVzdA0KYXNrIHRvIHBvd2VyIG9uIGJ5IHJ0d19sZWF2ZV9pcHMoKSBpbW1lZGlhdGVseSwgc28g
Y2FuY2VsIHRoZSBkZWxheWVkX3dvcmsNCmFuZCBubyBhY3R1YWxseSBwb3dlciBvZmYvb24gaW4g
dGhpcyBjYXNlLg0KDQoxIHNlY29uZCBpcyBhbiBleGFtcGxlLCBtYXliZSBuZWVkIG1vcmUgdGlt
ZS4gRmluZSB0dW5lIHRoZSB2YWx1ZSBieQ0KeW91ciBleHBlcmltZW50IHJlc3VsdC4NCg0KPiAN
Cj4gT25lIG1vcmUgcXVlc3Rpb24uIElzIHRoZXJlIGEgd2F5IHRvIHVzZSA4MDIuMTFyIChmYXN0
IHJvYW1pbmcpIHdpdGggdGhlIG1haW5saW5lIGRyaXZlcj8NCg0KQXMgSSBrbm93LCA4MDIuMTFy
IGlzIG1haW5seSBpbXBsZW1lbnRlZCBpbiB3cGFfc3VwcGxpY2FudC4gSSBkb24ndCByZW1lbWJl
ciANCmRyaXZlcnMgbmVlZCB0byBpbXBsZW1lbnQgc3BlY2lhbCBoYW5kbGVzIGZvciB0aGF0LiAN
Cg0KDQo=

