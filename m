Return-Path: <linux-wireless+bounces-6417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0EF8A7D05
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A843282CF9
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 07:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146766AFAE;
	Wed, 17 Apr 2024 07:24:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D06BB56
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338669; cv=none; b=cUKTLPKi+7mF7PJFPuUgZONghyQi25f4pg8UMu4xJ60bt/8K6fQEFiw+ZCilsV0XD2OZA4QALZfGxhKNZOTI2ADqe+oifv6aW1xAgZJcZTh0pZRtYhtZVY1174i6S+vvctorQwODsy0+NYj7AWIlrrhEOBHzJkb33KguoO8dpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338669; c=relaxed/simple;
	bh=NODGHGmktc48JO6ywV8v1NF3FeUpd9wSyNU+LQ7a41U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aYy0bgwaQpjZNOn3gbDdY4nAZrhVeE5SXdPUwJ3iPwG9x5xQFjXOhDYcUAZ4413CEIlYj9HO2/crSy5WO8ArIRSQ9RFvHBmP6HyTmnjgD1etyC2WyDFr5z5olo7jiD3v4rBJpyNrRtepT2NqMQ3j4byjXHCmAGNqZHxBteegyio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43H7NwghE3128677, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43H7NwghE3128677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 15:23:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 15:23:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 15:23:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 17 Apr 2024 15:23:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>,
        Martin Kaistra
	<martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: enable MFP support
Thread-Topic: [PATCH] wifi: rtl8xxxu: enable MFP support
Thread-Index: AQHadi+EaQT0NSwYfk2FMY1mPLyqGrFnTGAAgAFDQoCAANBHAIACUp6AgACPcHA=
Date: Wed, 17 Apr 2024 07:23:57 +0000
Message-ID: <55d21b23c729465a9c5116cb2a9dc9f5@realtek.com>
References: <20240314164850.86432-1-martin.kaistra@linutronix.de>
 <fa903f58-2362-49a1-9880-2b3fcbe1869e@gmail.com>
 <5b3af47c-7efb-4ca3-93bd-06c682dfc84f@linutronix.de>
 <1cbb57c2-3d8f-4932-9132-d46a871c944b@gmail.com>
 <1e600703-1208-4adb-a486-2a770cff55ed@linutronix.de>
In-Reply-To: <1e600703-1208-4adb-a486-2a770cff55ed@linutronix.de>
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

SGkgS2FsbGUsDQoNCk1hcnRpbiBLYWlzdHJhIDxtYXJ0aW4ua2Fpc3RyYUBsaW51dHJvbml4LmRl
PiB3cm90ZToNCg0KPiBIaSBQaW5nLUtlLA0KPiANCj4gQW0gMTUuMDQuMjQgdW0gMjE6MTQgc2No
cmllYiBCaXR0ZXJibHVlIFNtaXRoOg0KPiA+IE9uIDE1LzA0LzIwMjQgMDk6NDksIE1hcnRpbiBL
YWlzdHJhIHdyb3RlOg0KPiA+PiBBbSAxNC4wNC4yNCB1bSAxMzozMiBzY2hyaWViIEJpdHRlcmJs
dWUgU21pdGg6DQo+ID4+PiBPbiAxNC8wMy8yMDI0IDE4OjQ4LCBNYXJ0aW4gS2Fpc3RyYSB3cm90
ZToNCj4gPj4+DQo+ID4+PiBBbHNvLCB3b24ndCB5b3Ugc2VuZCB0aGUgcGF0Y2ggdG8gdGhlIHN0
YWJsZSB0cmVlPw0KPiA+Pg0KPiA+PiBUaGUgcnRsOHh4eHUgZHJpdmVyIHByZXZpb3VzbHkgZGlk
IG5vdCBoYXZlIHRoZSBNRlBfQ0FQQUJMRSBmbGFnIHNldC4gQXMgSSBhbSBhZGRpbmcgbmV3IGZ1
bmN0aW9uYWxpdHkNCj4gKHN1cHBvcnQgZm9yIFdQQTMpLCBJIGRvbid0IHRoaW5rIHRoaXMgc2hv
dWxkIGdvIHRvIHN0YWJsZS4NCj4gPg0KPiA+IFdpdGhvdXQgeW91ciBwYXRjaCBJIGNhbid0IGNv
bm5lY3QgdG8gbXkgcGhvbmUncyBob3RzcG90DQo+ID4gd2hlbiBpdCB1c2VzIFdQQTM6DQo+ID4N
Cj4gPiBBcHIgMDggMTI6NTA6NTcgaWRlYXBhZDIgd3BhX3N1cHBsaWNhbnRbMTIzMV06IG5sODAy
MTE6IGtlcm5lbCByZXBvcnRzOiBrZXkgc2V0dGluZyB2YWxpZGF0aW9uIGZhaWxlZA0KPiA+IEFw
ciAwOCAxMjo1MDo1NyBpZGVhcGFkMiB3cGFfc3VwcGxpY2FudFsxMjMxXTogd2xwM3MwZjN1Mjog
V1BBOiBGYWlsZWQgdG8gY29uZmlndXJlIElHVEsgdG8gdGhlIGRyaXZlcg0KPiA+IEFwciAwOCAx
Mjo1MDo1NyBpZGVhcGFkMiB3cGFfc3VwcGxpY2FudFsxMjMxXTogd2xwM3MwZjN1MjogUlNOOiBG
YWlsZWQgdG8gY29uZmlndXJlIElHVEsNCj4gPg0KPiA+IEl0IGRvZXNuJ3Qgc2F5IGFueXRoaW5n
IGFib3V0IFdQQTMgb3IgbWFuYWdlbWVudCBmcmFtZQ0KPiA+IHByb3RlY3Rpb24sIGp1c3QgcHJp
bnRzIHRob3NlIHVuaGVscGZ1bCBlcnJvcnMgYW5kIHRyaWVzDQo+ID4gdG8gY29ubmVjdCBvdmVy
IGFuZCBvdmVyIGFnYWluLiBUbyBtZSB0aGF0IGxvb2tzIG1vcmUgbGlrZQ0KPiA+IGZpeGluZyBh
IGJ1ZyB0aGFuIGFkZGluZyBuZXcgZnVuY3Rpb25hbGl0eS4gSXQncyBqdXN0IHNhZA0KPiA+IHRo
YXQgcGVvcGxlIG5lZWQgdG8gaW5zdGFsbCBrZXJuZWwgNi4xMCsgaW4gb3JkZXIgdG8gc3VwcG9y
dA0KPiA+IFdQQTMsIHdoZW4gdGhlIHBhdGNoIGlzIHNvIHNtYWxsLg0KPiANCj4gSSB3b3VsZCBs
aWtlIHRvIGtub3cgeW91ciBvcGluaW9uIG9uIHRoaXMuIGltaG8gdGhpcyBwYXRjaCBzaG91bGQg
bm90IGdvIHRvDQo+IHN0YWJsZSBhbmQgSSB3b3VsZCB0aGVyZWZvcmUgcHJvcG9zZSB0byBqdXN0
IHNlbmQgYSBwYXRjaCB0byBpbXByb3ZlIHRoZSBjaGVja3MuDQo+IElmIHlvdSBhcyBhIG1haW50
YWluZXIgaG93ZXZlciBzYXksIHlvdSB3b3VsZCBsaWtlIHRvIHNlZSB0aGlzIGluIHN0YWJsZSwg
dGhlbiBJDQo+IHdpbGwgc2VuZCBhIHJldmVydCBhbmQgYSBuZXcgcGF0Y2guDQo+IA0KDQpXZSBo
YXZlIGEgcXVlc3Rpb24gYWJvdXQgTUZQIHN1cHBvcnQgdG8gc3RhYmxlIHRyZWUuIHJ0bDh4eHh1
IG5ldmVyIHN1cHBvcnRzIE1GUCwNCmFuZCByZWNlbnRseSB3ZSBoYXZlIGEgc21hbGwgcGF0Y2gg
KDEwKyBMT0MpIHRvIGVuYWJsZSB0aGF0LiBJIGZlZWwgd2Ugc2hvdWxkDQp0cmVhdCBpdCBhcyBu
ZXcgZmVhdHVyZSwgbm90IGFkZCB0byBzdGFibGUgdHJlZS4gQnV0IGFzIEJpdHRlcmJsdWUgbWVu
dGlvbmVkLA0KaXQgbG9va3MgbGlrZSBhIGJ1Zy4gTmVlZCB5b3VyIG9waW5pb24uDQoNClBpbmct
S2UNCg0K

