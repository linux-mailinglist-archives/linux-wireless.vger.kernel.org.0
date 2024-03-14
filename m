Return-Path: <linux-wireless+bounces-4717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F887B5C3
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 01:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF311F22926
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 00:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB382579;
	Thu, 14 Mar 2024 00:25:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3F0624
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710375942; cv=none; b=YztH5fh8HUvh1CKgox1Xz1jFYodfkDb2BkW91Q7rP/wrMuAY5zmzRkKnuO4oh2m3gtNUe7t9GKQ4KD1xlK282xBbP5zWLalI+SZ68kjFWajh9RQiD2zSOO8Bfjaj0J6phFkq6pls1C40fFP74pgVIVQvFWSQrC/XuKevRyqDcu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710375942; c=relaxed/simple;
	bh=3aAiuxGnkIuEJiH3b7aAn9bgJsMAB6XZNypW85vpjQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HqS9oT2Hc6qKpOU/Bld7Axc56zovEdblj9FpNoG+RKtouVfgG4QsU15xTb8w9o9sOYG18cbUzXiOs7fl01MSg7OIPU5fxg1OS124d3aPfrCGncLLEuCkKi5CKuz7gwuuspZk8t1XD8mqRJeaiNYnpAW9cobpaBPnTGyiEgsUGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42E0PUNX01048639, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42E0PUNX01048639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 08:25:30 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 08:25:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 08:25:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 14 Mar 2024 08:25:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Thread-Index: AQHadHc+y1p0wnFmpUaBbm9dm2gSZ7E05aGAgAAFZjCAANM6gIAAHq2A
Date: Thu, 14 Mar 2024 00:25:30 +0000
Message-ID: <4c601df104e882b559d2070815394f74d75975c5.camel@realtek.com>
References: <9995b805-ef8b-47c9-b176-ff540066039a@gmail.com>
	 <43c344357f564170872501e34490c851@realtek.com>
	 <a9a93e7bd7e94870be0f38dd6792ab29@realtek.com>
	 <f50424f4-c478-4d1e-898f-b2f9fc2bf14d@gmail.com>
In-Reply-To: <f50424f4-c478-4d1e-898f-b2f9fc2bf14d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B0D78442907DE49BC94974F01F21E26@realtek.com>
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

T24gVGh1LCAyMDI0LTAzLTE0IGF0IDAwOjM0ICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gT24gMTMvMDMvMjAyNCAwNDowMCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IA0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxMywg
MjAyNCA5OjU1IEFNDQo+ID4gPiBUbzogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+OyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IENjOiBMYXJy
eSBGaW5nZXIgPExhcnJ5LkZpbmdlckBsd2Zpbmdlci5uZXQ+DQo+ID4gPiBTdWJqZWN0OiBSRTog
W1BBVENIXSB3aWZpOiBydGx3aWZpOiBydGw4MTkyZGU6IEZpeCA1IEdIeiBUWCBwb3dlcg0KPiA+
ID4gDQo+ID4gPiA+IFRlc3RlZCBvbmx5IHdpdGggcnRsODE5MmR1LCB3aGljaCB3aWxsIHVzZSB0
aGUgc2FtZSBUWCBwb3dlciBjb2RlLg0KPiA+IA0KPiA+IEJlY2F1c2UgYW5vdGhlciBwYXRjaHNl
dCBhZGRpbmcgcnRsODE5MmR1IGlzIGJhc2VkIG9uIHRoaXMgcGF0Y2gsIEkgc3VnZ2VzdA0KPiA+
IHRvIHNlbmQgdGhlbSBhcyBzaW5nbGUgb25lIHBhdGNoc2V0Lg0KPiA+IA0KPiANCj4gSSBjYW4g
ZG8gdGhhdCwgYnV0IEthbGxlIHdpbGwgcHJvYmFibHkgYXBwbHkgdGhpcyBwYXRjaCBsb25nDQo+
IGJlZm9yZSB2MiBvZiB0aGF0IHBhdGNoc2V0IGlzIHJlYWR5Lg0KDQpSaWdodC4gQnV0IG5leHQg
dGltZSB5b3UgY2FuIHNlbmQgbXV0dWFsIGRlcGVuZGVudCBwYXRjaGVzIGluIGEgcGF0Y2hzZXQs
IG9yDQpkZXNjcmliZSB0aGVpciBkZXBlbmRlbmN5IGluIGNvdmVyIGxldHRlci4gQW5kLCBJIHBy
ZWZlciB0aGVtIGluIGEgcGF0Y2hzZXQuIA0KDQoNCg==

