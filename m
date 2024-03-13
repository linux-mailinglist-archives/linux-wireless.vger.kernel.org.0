Return-Path: <linux-wireless+bounces-4664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6D287A2C8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 06:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337721F22259
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 05:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33043134AD;
	Wed, 13 Mar 2024 05:50:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC59B134A3
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710309011; cv=none; b=TvcHT85DuvH6mfCgmeXzNdPa3rCRT9+RorIX+TBhYApIcu2tyUA3MPkodXsThqgOy6i72hV7EmMug70Ea0VQ7CPsPRn6ISFulzef0FFx1ymF/LFGbZfgqkFBesCzUEuZiCdbrSTpCKAT2ZRhDv0Jkn9zs536ru9k91r8mAzNgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710309011; c=relaxed/simple;
	bh=OpodNgA7mirSQDDnA8zni2TEfcD9sB4edHBhrTZlzBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bYr3lW9ibngOdqR9gIpJdEFVnzldarzqzXaXIR/qMCmno3gwzg1DAqEAD8oJWEMOmhS8aP2mlf3h0Be4irqGZ2x722vv5xb1vEzrUk5tgDJe4pTSFYT+m09zj88nBWD5yWxBTeT925yOn7r0aucmcr6JplIDq4gjPnml7HD1z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42D5nfa97536471, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42D5nfa97536471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 13:49:41 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 13:49:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 13:49:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 13 Mar 2024 13:49:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH 3/3] wifi: rtlwifi: Add new rtl8192du driver
Thread-Topic: [PATCH 3/3] wifi: rtlwifi: Add new rtl8192du driver
Thread-Index: AQHadMv3uItg2xAbwU+uyVoTsONiULE0pIMA
Date: Wed, 13 Mar 2024 05:49:40 +0000
Message-ID: <9e5485592f792339593d0b03b86794e5e010337a.camel@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
	 <303a7402-43f0-4f98-9aa1-b4eb660eead0@gmail.com>
In-Reply-To: <303a7402-43f0-4f98-9aa1-b4eb660eead0@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <BED049A9E2C6044D9962E429BADC5AAD@realtek.com>
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

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDAwOjIzICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gVGhlIFJUTDgxOTJEVSBpcyBhbiBvbGRlciBXaWZpIDQgZHVhbCBiYW5kIGNoaXAu
IEl0IGNvbWVzIGluIHR3bw0KPiBmbGF2b3Vyczogc2luZ2xlIE1BQyBzaW5nbGUgUEhZIChsaWtl
IG1vc3QgUmVhbHRlayBXaWZpIDQgVVNCIGRldmljZXMpLA0KPiBhbmQgZHVhbCBNQUMgZHVhbCBQ
SFkuDQo+IA0KPiBUaGUgc2luZ2xlIE1BQyBzaW5nbGUgUEhZIHZlcnNpb24gaXMgMlQyUiBhbmQg
Y2FuIHdvcmsgZWl0aGVyIGluIHRoZQ0KPiAyLjQgR0h6IGJhbmQgb3IgdGhlIDUgR0h6IGJhbmQu
DQo+IA0KPiBUaGUgZHVhbCBNQUMgZHVhbCBQSFkgdmVyc2lvbiBoYXMgdHdvIFVTQiBpbnRlcmZh
Y2VzIGFuZCBhcHBlYXJzIHRvIHRoZQ0KPiBzeXN0ZW0gYXMgdHdvIHNlcGFyYXRlIDFUMVIgV2lm
aSBkZXZpY2VzLCBvbmUgd29ya2luZyBpbiB0aGUgMi40IEdIeg0KPiBiYW5kLCB0aGUgb3RoZXIg
aW4gdGhlIDUgR0h6IGJhbmQuDQo+IA0KPiBUaGlzIHdhcyB0ZXN0ZWQgb25seSB3aXRoIGEgc2lu
Z2xlIE1BQyBzaW5nbGUgUEhZIGRldmljZS4NCg0KDQpQbGVhc2UgcnVuIGNoZWNrcGF0Y2gucGwg
dGhhdCByZXBvcnRzOg0KICAidG90YWw6IDAgZXJyb3JzLCAxMSB3YXJuaW5ncywgMjcgY2hlY2tz
LCA4MDQ1IGxpbmVzIGNoZWNrZWQiDQoNCihTb3JyeSwgSSB3cm9uZ2x5IHBvc3RlZCBhYm92ZSBy
ZXN1bHQgb24gcGF0Y2ggMi8zKQ0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0KPiBTaG91bGQgSSBzcGxp
dCB0aGlzIGludG8gbXVsdGlwbGUgcGF0Y2hlcywgb25lIGZvciBlYWNoIG5ldyBmaWxlLA0KPiB0
byBtYWtlIHJldmlld2luZyBlYXNpZXI/DQo+IA0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnRsd2lmaS9LY29uZmlnICB8ICAgMTIgKw0KPiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydGx3aWZpL01ha2VmaWxlIHwgICAgMSArDQo+ICAuLi4vcmVhbHRlay9y
dGx3aWZpL3J0bDgxOTJkdS9NYWtlZmlsZSAgICAgICAgfCAgIDEzICsNCj4gIC4uLi93aXJlbGVz
cy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L2RtLmMgICB8ICA3ODggKysrKysNCj4gIC4uLi93
aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L2RtLmggICB8ICAgMTAgKw0KPiAgLi4u
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTkyZHUvZncuYyAgIHwgIDEwOSArDQo+ICAu
Li4vd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9mdy5oICAgfCAgICA5ICsNCj4g
IC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L2h3LmMgICB8IDEyMzggKysr
KysrKw0KPiAgLi4uL3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTkyZHUvaHcuaCAgIHwg
ICAyNCArDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9sZWQuYyAg
fCAgIDEwICsNCj4gIC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L2xlZC5o
ICB8ICAgIDkgKw0KPiAgLi4uL3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTkyZHUvcGh5
LmMgIHwgMzA2NCArKysrKysrKysrKysrKysrKw0KPiAgLi4uL3dpcmVsZXNzL3JlYWx0ZWsvcnRs
d2lmaS9ydGw4MTkyZHUvcGh5LmggIHwgICAzMiArDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9y
dGx3aWZpL3J0bDgxOTJkdS9yZi5jICAgfCAgMjM2ICsrDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRl
ay9ydGx3aWZpL3J0bDgxOTJkdS9yZi5oICAgfCAgIDExICsNCj4gIC4uLi93aXJlbGVzcy9yZWFs
dGVrL3J0bHdpZmkvcnRsODE5MmR1L3N3LmMgICB8ICAzMTAgKysNCj4gIC4uLi93aXJlbGVzcy9y
ZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L3N3LmggICB8ICAgMTIgKw0KPiAgLi4uL3JlYWx0ZWsv
cnRsd2lmaS9ydGw4MTkyZHUvdGFibGUuYyAgICAgICAgIHwgMTY3NSArKysrKysrKysNCj4gIC4u
Li9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L3RhYmxlLmggICAgICAgICB8ICAgMzAgKw0KPiAg
Li4uL3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTkyZHUvdHJ4LmMgIHwgIDM4MCArKw0K
PiAgLi4uL3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTkyZHUvdHJ4LmggIHwgICA2MCAr
DQo+ICAyMSBmaWxlcyBjaGFuZ2VkLCA4MDMzIGluc2VydGlvbnMoKykNCg0KUGxlYXNlIHNwbGl0
IHRoaXMgcGF0Y2ggdG8gc21hbGwgb25lcy4gTGlrZSBtYWtlIGRtLmMvZG0uaCBhcyBhIHBhdGNo
LA0KaHcuYy9ody5oIGFzIGFub3RoZXIgcGF0Y2ggYW5kIGV0Yy4gRm9yIHNtYWxsZXIgZmlsZXMg
c3VjaCBhcyBsZWQuYy9sZWQuaCwNCml0IGlzIGZpbmUgdG8gY29tYmluZSB3aXRoIG90aGVycy4g
DQoNCg0KVGhvdWdoIHlvdSBoYXZlIGRvbmUgODE5MkRVIGluIHJ0bHdpZmksIEkgc3RpbGwgd2Fu
dCB0byBrbm93IGhvdyB5b3UgZGVjaWRlDQp0byBzdXBwb3J0IDgxOTJEVSBpbiBydGx3aWZpIGlu
c3RlYWQgb2YgcnRsOHh4eHUuIElJUkMgbW9zdCBVU0IgdXNlcnMgb2YNClJlYWx0ZWsgV2lGaSB1
c2UgcnRsOHh4eHUuIA0KDQpQaW5nLUtlDQoNCg==

