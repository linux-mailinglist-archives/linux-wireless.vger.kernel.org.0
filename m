Return-Path: <linux-wireless+bounces-3513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C82F852A32
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 08:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEA11C20A0E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 07:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FCE17983;
	Tue, 13 Feb 2024 07:42:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154017980
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810141; cv=none; b=mmEB0gor4DTIOPDzxxWPVlQ+09On6PNhvLGfMrO3oIMK0mjqCEbRyOUSyXF2WuJYdG6ilAR1OEfQtWZe9Z+wkZVLLVZctux75KZLSvVwBVlibshVsuKh2tDmXMfsYVlK4X7h465+wAhLgXNT80ZkVAIxKmaWaBzMttEX1NGr2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810141; c=relaxed/simple;
	bh=GMS0Ng+CaZd5kHsSIRnw+ZdX0VmQDRCYbCzUfLR7DBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X2JZzAFmA3shNA/JDDENum7icFYLllSJXhEjidwJy6sfJBpWs2zAUdrCtFy7YSDLfzyDzMrnIQIUOHvo3cmxsiQS1uKXj0qPhOGNCoeWcAkThgKaCDQv9w4IQLfL118EXnK8zwzTRyy3UmO/2Fcy9rTTWyR7PY3ygQf0PB+F3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41D7g3qZ51672163, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41D7g3qZ51672163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 15:42:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 13 Feb 2024 15:42:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 15:42:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 13 Feb 2024 15:42:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
CC: "johannes.berg@intel.com" <johannes.berg@intel.com>
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into chandef
Thread-Topic: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
Thread-Index: AQHaUuQAKtICccJuvkyOo86/O7KcarEHdDiA
Date: Tue, 13 Feb 2024 07:42:02 +0000
Message-ID: <f489a916f416cb37b527868c4be0c59547bdeb4d.camel@realtek.com>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
	 <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
In-Reply-To: <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <334FAB19E8D24B429AE971004A24F6BF@realtek.com>
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

T24gTW9uLCAyMDI0LTAxLTI5IGF0IDE5OjM0ICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gDQo+IEFs
b2thIG9yaWdpbmFsbHkgc3VnZ2VzdGVkIHRoYXQgcHVuY3R1cmluZyBzaG91bGQgYmUgcGFydCBv
Zg0KPiB0aGUgY2hhbmRlZiwgc28gdGhhdCBpdCdzIHRyZWF0ZWQgY29ycmVjdGx5LiBBdCB0aGUg
dGltZSwgSQ0KPiBkaXNhZ3JlZWQgYW5kIGl0IGVuZGVkIHVwIG5vdCBwYXJ0IG9mIHRoZSBjaGFu
ZGVmLCBidXQgSSd2ZQ0KPiBub3cgcmVhbGl6ZWQgdGhhdCB0aGlzIHdhcyB3cm9uZy4gRXZlbiBm
b3IgY2xpZW50cywgdGhlIFJYLA0KPiBhbmQgcGVyaGFwcyBtb3JlIGltcG9ydGFudGx5LCBDQ0Eg
Y29uZmlndXJhdGlvbiBuZWVkcyB0byB0YWtlDQo+IHB1bmN0dXJpbmcgaW50byBhY2NvdW50Lg0K
PiANCj4gTW92ZSBwdW5jdHVyaW5nIGludG8gdGhlIGNoYW5kZWYsIGFuZCBhZGp1c3QgYWxsIHRo
ZSBjb2RlDQo+IGFjY29yZGluZ2x5LiBBbHNvIGFkZCBhIGZldyB0ZXN0cyBmb3IgcHVuY3R1cmlu
ZyBpbiBjaGFuZGVmDQo+IGNvbXBhdGliaWxpdHkgY2hlY2tpbmcuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gLS0tDQoNClsu
Li5dDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
ZncuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYw0KPiBpbmRleCBl
NDkzNjBlMjlmYWYuLjg3NmM4ZDU4MTc1OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODkvZncuYw0KPiBAQCAtMjQ5NSw4ICsyNDk1LDExIEBAIGludCBydHc4OV9md19o
MmNfYXNzb2NfY21hY190YmxfZzcoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0KPiAgCX0NCj4g
IA0KPiAgCWlmICh2aWYtPmJzc19jb25mLmVodF9zdXBwb3J0KSB7DQo+IC0JCWgyYy0+dzQgfD0g
bGUzMl9lbmNvZGVfYml0cyh+dmlmLT5ic3NfY29uZi5laHRfcHVuY3R1cmluZywNCj4gKwkJdTE2
IHB1bmN0ID0gdmlmLT5ic3NfY29uZi5jaGFucmVxLm9wZXIucHVuY3R1cmVkOw0KPiArDQo+ICsJ
CWgyYy0+dzQgfD0gbGUzMl9lbmNvZGVfYml0cyh+cHVuY3QsDQo+ICAJCQkJCSAgICBDQ1RMSU5G
T19HN19XNF9BQ1RfU1VCQ0hfQ0JXKTsNCj4gKwkJcmN1X3JlYWRfdW5sb2NrKCk7DQoNCldlIGRv
bid0IGRlZmVyZW5jZSBjaGFuY3R4IHRvIHJlZmVyZW5jZSBwdW5jdHVyZSB2YWx1ZS4gSW5zdGVh
ZCB1c2UgdGhlDQp2YWx1ZSBmcm9tIHZpZi0+YnNzX2NvbmYuY2hhbnJlcSwgc28gSSB0aGluayB3
ZSBkb24ndCBuZWVkIFJDVSBsb2NrcywgcmlnaHQ/DQoNCkkgY2FuIHByZXBhcmUgYSBmaXggZm9y
IHRoaXMsIGJ1dCB3YW50IHRvIGNvbmZpcm0gaWYgbXkgdGhpbmtpbmcgaXMgY29ycmVjdC4NCg0K
DQo+ICAJCWgyYy0+bTQgfD0gY3B1X3RvX2xlMzIoQ0NUTElORk9fRzdfVzRfQUNUX1NVQkNIX0NC
Vyk7DQo+ICAJfQ0KPiAgDQo+IA0KDQoNCg0K

