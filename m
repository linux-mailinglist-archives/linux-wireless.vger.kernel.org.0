Return-Path: <linux-wireless+bounces-27644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94224B9D630
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 06:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52BE67A4F3C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Sep 2025 04:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A861A9FA8;
	Thu, 25 Sep 2025 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Gjk4Q0S1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6132A14A8E;
	Thu, 25 Sep 2025 04:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758774530; cv=none; b=GJLfm98n/bfbL+ZefePF/BNZV7yjkVMUcFYWmxbvnMxoFIcIIWqestG4FSZNCohMEH0kzi8Kv/oXFvfUbUkg0B/3fop4Hqu1RIstmVZfpFZp34xrrR9ccupfW9tCbHQWI44DekbR8J2MMrzcKnshCeDh2Be32kCDV9OwQ1+NvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758774530; c=relaxed/simple;
	bh=YAo9hqlqfXSHrQotg+UymZ8AwzLy6GFaFquzDULIPT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ku0VuxYUL3Ej6+dM2Gtr1P6fzZYcisuMFAnKC954lpstosujrQPlxmnf9wO29D8WTdZBAwmnUX9D8Azi7WQVbZ8NiYWv5KHPnpOQHo3ITPl1et4OXwNh/1RpoBxRAYar5tDql2Ab9uDwSpdaw825kqa/ofKBNjx8vnFo8EY8+HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Gjk4Q0S1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58P4SeCT2646220, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758774520; bh=YAo9hqlqfXSHrQotg+UymZ8AwzLy6GFaFquzDULIPT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Gjk4Q0S1bQuU4CNAEPVpF6s8k41RLWc2frDRK2GuOYu5kHsPbKZowgHdCCAeMX3oG
	 BuwdBQfj0++b8URNtfAhKJnmJG0/VVF3bAojg6fpL1o5giz9ESiwTgYuKgDk3Fk54L
	 nwWLs9TOomSH/61z0W9zDSnbS1RhaeXGnqFankW0Quy1vRP/hnjKWOfZrqSt0hKAUH
	 VLuD7yMCJoFj0IrzgYEEL7oZXndu1AMZAtxZPvnGJERS8STqY/bAv0tfPsrH2niK2w
	 mgPPFxQtBmnasdIpOU84ynwEhrWDDV0du1V1FAD34k1kFUp5BTTZg/aCAnJeENKkRS
	 mLgO/Kz74aBIA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58P4SeCT2646220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 12:28:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 25 Sep 2025 12:28:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 25 Sep 2025 12:28:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yu-Chun Lin <eleanor15x@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?Q1lfSHVhbmdbtsDgsq7LXQ==?= <cy.huang@realtek.com>,
        =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>,
        "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
        "visitorckw@gmail.com"
	<visitorckw@gmail.com>
Subject: RE: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with helper functions
Thread-Topic: [PATCH rtw-next] wifi: rtw89: Replace hardcoded strings with
 helper functions
Thread-Index: AQHcKw6iw9xkJS2rJEiZoIdnDXLQ2rSesj7wgAG3LICAARhfEIABQ48AgACMkgA=
Date: Thu, 25 Sep 2025 04:28:40 +0000
Message-ID: <0990f8ee74574a30a585f2e0e3831837@realtek.com>
References: <20250921154410.1202074-1-eleanor15x@gmail.com>
 <715313b943d84cfeb3a337dc20be5f6a@realtek.com>
 <aNLDga29Wp1nwhem@visitorckw-System-Product-Name>
 <51518b935e7649e3b5413e3a119d549b@realtek.com>
 <aNS+Hk5QTzGq+AUO@visitorckw-System-Product-Name>
In-Reply-To: <aNS+Hk5QTzGq+AUO@visitorckw-System-Product-Name>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

WXUtQ2h1biBMaW4gPGVsZWFub3IxNXhAZ21haWwuY29tPiB3cm90ZToNCj4gT24gV2VkLCBTZXAg
MjQsIDIwMjUgYXQgMTI6NDM6NTZBTSArMDAwMCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IFl1
LUNodW4gTGluIDxlbGVhbm9yMTV4QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiBPbiBNb24sIFNl
cCAyMiwgMjAyNSBhdCAwNTo1MDo1MEFNICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4g
PiA+IFl1LUNodW4gTGluIDxlbGVhbm9yMTV4QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4g
UmVwbGFjZSBoYXJkY29kZWQgc3RyaW5ncyB3aXRoICdzdHJfb25fb2ZmKCknLCAnc3RyX2VuYWJs
ZV9kaXNhYmxlKCknLA0KPiA+ID4gPiA+IGFuZCAnc3RyX3JlYWRfd3JpdGUoKScuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBUaGUgY2hhbmdlIGltcHJvdmVzIHJlYWRhYmlsaXR5IGFuZCBlbmFibGVz
IHBvdGVudGlhbCBzdHJpbmcgZGVkdXBsaWNhdGlvbg0KPiA+ID4gPiA+IGJ5IHRoZSBsaW5rZXIs
IHdoaWNoIG1heSBzbGlnaHRseSByZWR1Y2UgYmluYXJ5IHNpemUuDQo+ID4gPiA+DQo+ID4gPiA+
IEhhdmUgeW91IG1lYXN1cmVkIHRoZSBjaGFuZ2Ugb2YgYmluYXJ5IHNpemU/IE1heWJlIHlvdSBj
YW4gc2hhcmUgdGhlIHJlc3VsdA0KPiA+ID4gPiBoZXJlLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+
IEkgdGVzdGVkIHRoZSBwYXRjaCBhbmQgZGlkIG5vdCBvYnNlcnZlIGFueSBtZWFzdXJhYmxlIGNo
YW5nZSBpbiB0aGUgYmluYXJ5IHNpemUuDQo+ID4gPiBUaGUgY29tbWl0IG1lc3NhZ2Ugd2FzIHJl
ZmVycyB0byB0aGUgZGVzY3JpcHRpb24gaW4gc3RyaW5nLWNob2ljZS5oOg0KPiA+ID4NCj4gPiA+
ICIzKSBEZWR1cGluZyBieSB0aGUgbGlua2VyLCB3aGljaCByZXN1bHRzIGluIGEgc21hbGxlciBi
aW5hcnkgZmlsZS4iDQo+ID4NCj4gPiBJdCBtaWdodCByZWx5IG9uIExUTyAobGluay10aW1lIG9w
dGltaXphdGlvbikuDQo+ID4NCj4gDQo+IEkgcmUtdGVzdGVkIHdpdGggJ0xUT19DTEFORz15Jywg
YW5kIHRoZSBjb2RlIHNpemUgcmVtYWlucyB1bmNoYW5nZWQgYmVmb3JlDQo+IGFuZCBhZnRlciB0
aGUgcGF0Y2guIEkgd2lsbCByZW1vdmUgdGhlIHN0YXRlbWVudA0KPiAoIm1heSBzbGlnaHRseSBy
ZWR1Y2UgYmluYXJ5IHNpemUiKSBmcm9tIHRoZSB2MiBjb21taXQgbWVzc2FnZS4NCj4gDQoNCldo
YXQgaXMgdGhlIC5vIHlvdSBjaGVja2VkPyBIYXZlIHlvdSBhbHNvIGNoZWNrZWQgc2l6ZSBvZiAu
a28/DQpJIGd1ZXNzIChzb3JyeSBJJ20gbm90IGZhbWlsaWFyIHdpdGggTFRPKSB0aGF0IExUTyBv
bmx5IHRha2VzIGVmZmVjdA0KYXQgbGVhc3QgZG9pbmcgcGFydGlhbCBsaW5rLiANCg0KQXMgdGhl
IGNoYW5nZXMgb2YgeW91ciBwYXRjaCwgbWF5YmUgeW91IGNhbiBjaGVjayBydHc4OV84ODUxYi5v
IG9yDQpydHc4OV84ODUxYi5rby4NCg0K

