Return-Path: <linux-wireless+bounces-16974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE69FF571
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 02:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DCA1881C5D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 01:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E739128F3;
	Thu,  2 Jan 2025 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JHh7Zg5v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189FB7E9
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735781015; cv=none; b=ZHGw9RiGvdgjywSHWtyF07Viq/e+KJ5EDElniwUXUQEAjUgPKdRY2d5PNRJ3oo/9Gljcg9xFvPoPjnYnBuKc2JE9LQIITLoio31Nf1EmyIznBlDrT45NGVgaNA7GXKKBK+tJWnIGvxlgOPnGedP2blzE+AOJBMcE8zeNniYybKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735781015; c=relaxed/simple;
	bh=bq5AqqnX70kTVBIUwBSTnQW5PyQD+mDmg0CTPPaMMLw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qygYPfSr7Qo6PCKlnDAzvP9Gcix23fggFIGz43pARUZ0mT4sG4ewD0VAuI5lLEOJ/tr6+tbQQx/iHnFTCOMPSbHKZuSEHbbL53Q2rS5OE5nsfOj4j4bPQox97q12WksOEwTA6HajHr/9Axa8hc2H648UmIojXTFI4bg7rjg805U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JHh7Zg5v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5021NSwaC3810340, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735781008; bh=bq5AqqnX70kTVBIUwBSTnQW5PyQD+mDmg0CTPPaMMLw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=JHh7Zg5vSNVvkr11ulDNBbX+r8w6+59C4w/YY2F7KeEkPtLC65UZhV+3UwnLqztu5
	 PayKJgDc/1Q1pT3GETrp/whmgc3NlFR3+/3A/LBzzAtVliAcsTKenP/kuE4Zhf5zpf
	 3uawtXu/FGYfv0U9xgNacA9M9/cOXrLUI1BDVV0/9fMB4AUN4c9CmTNZ8EpYa0qGQT
	 L97JDOQ7pC++hlCQSLBYi5xWgMIDVlDVlSK2lzhQ2PpUd2StG0C4TGshXtCfPI45Rb
	 Pz37OcpG5+xDz5UmXrKJfr9FgN9ZahAzKAcpWwSLc5bQ4kg/IjC6WAqs/5dh4JQrAE
	 lEK/fYnWDVyQA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5021NSwaC3810340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jan 2025 09:23:28 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 2 Jan 2025 09:23:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 Jan 2025 09:23:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 2 Jan 2025 09:23:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: Delete rf_type member of struct rtw_sta_info
Thread-Topic: [PATCH] wifi: rtw88: Delete rf_type member of struct
 rtw_sta_info
Thread-Index: AQHbXGoV+OnICe7Y1EenZk0rPwFhdLMCsASQ
Date: Thu, 2 Jan 2025 01:23:28 +0000
Message-ID: <d3dbb6212c8f4d529be91fc453186e35@realtek.com>
References: <b80f7904-c6b4-4d12-a5f9-69ab9b965732@gmail.com>
In-Reply-To: <b80f7904-c6b4-4d12-a5f9-69ab9b965732@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
SXQncyBub3QgdXNlZCBmb3IgYW55dGhpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJi
bHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2Ug
U2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYyB8IDkgKystLS0tLS0tDQo+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uaCB8IDEgLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L21haW4uYw0KPiBpbmRleCBlOTE1MzBlZDA1YTAuLjY5OTNmOTNjOGYw
NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWlu
LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMNCj4g
QEAgLTEyMTcsNyArMTIxNyw2IEBAIHZvaWQgcnR3X3VwZGF0ZV9zdGFfaW5mbyhzdHJ1Y3QgcnR3
X2RldiAqcnR3ZGV2LCBzdHJ1Y3QgcnR3X3N0YV9pbmZvICpzaSwNCj4gICAgICAgICB1OCB3aXJl
bGVzc19zZXQ7DQo+ICAgICAgICAgdTggYndfbW9kZTsNCj4gICAgICAgICB1OCByYXRlX2lkOw0K
PiAtICAgICAgIHU4IHJmX3R5cGUgPSBSRl8xVDFSOw0KPiAgICAgICAgIHU4IHN0YmNfZW4gPSAw
Ow0KPiAgICAgICAgIHU4IGxkcGNfZW4gPSAwOw0KPiAgICAgICAgIHU4IHR4X251bSA9IDE7DQo+
IEBAIC0xMzAyLDEzICsxMzAxLDEwIEBAIHZvaWQgcnR3X3VwZGF0ZV9zdGFfaW5mbyhzdHJ1Y3Qg
cnR3X2RldiAqcnR3ZGV2LCBzdHJ1Y3QgcnR3X3N0YV9pbmZvICpzaSwNCj4gICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgaWYgKHN0YS0+ZGVmbGluay52
aHRfY2FwLnZodF9zdXBwb3J0ZWQgJiYgcmFfbWFzayAmIDB4ZmZjMDAwMDApIHsNCj4gKyAgICAg
ICBpZiAoc3RhLT5kZWZsaW5rLnZodF9jYXAudmh0X3N1cHBvcnRlZCAmJiByYV9tYXNrICYgMHhm
ZmMwMDAwMCkNCj4gICAgICAgICAgICAgICAgIHR4X251bSA9IDI7DQo+IC0gICAgICAgICAgICAg
ICByZl90eXBlID0gUkZfMlQyUjsNCg0KSSBndWVzcyB0aGlzIGlzIHRvIHN1cHBvcnQgU01QUyBk
eW5hbWljYWxseSBhdCBpbml0aWFsIHRob3VnaHQsIGJ1dCBmaW5hbGx5DQppdCBpcyBub3QgbmVj
ZXNzYXJ5LiANCg0KDQo=

