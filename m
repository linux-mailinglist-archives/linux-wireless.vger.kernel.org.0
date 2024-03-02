Return-Path: <linux-wireless+bounces-4311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B3786ED79
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 01:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843FA1C20BC0
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 00:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0976780C;
	Sat,  2 Mar 2024 00:35:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E1801;
	Sat,  2 Mar 2024 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709339732; cv=none; b=jHTfnb6D0uitzWuVqkZ9eyPopGFj+Tgwe6C3AOBzhupnq+XYi9WhD2chaz2AMLUWTvsZ987uTFnr9sqEbAjynM8kkyCxYp2NDnJ/zvH1vDtbgwttdLV2e/SXb54QxQkti2rBgHQlED/QJ7G1s8voImEnk77Rlj2qaQtxqnJXQao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709339732; c=relaxed/simple;
	bh=X/ZCjMzy4+3lIVT/PRrj8btA/rIw437YDC6pZ23BQdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g+tuz5b0VXiXLt53PrkN6tRFpJ6WcQrZaBbZPmlr5duAibadF0dfUt4/TzGyEH+k8uqlHvWFj1d0upGLw3YDzk69CmLi7rSc7axMWVfhEZPal01+2hNCgC9ZvoeD706gRrr5Q+/CADe5AF+HrnnASmqPGIAr0sc73GBoyqcDKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4220ZB8W02363179, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4220ZB8W02363179
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 2 Mar 2024 08:35:11 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sat, 2 Mar 2024 08:35:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 08:35:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Sat, 2 Mar 2024 08:35:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "fiona.klute@gmx.de" <fiona.klute@gmx.de>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "megi@xff.cz"
	<megi@xff.cz>
Subject: Re: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
Thread-Topic: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
Thread-Index: AQHaadiMK/BK89PGSkKvgAdLkkf/lLEiJPZAgABuMQCAAAs1gIAAepWA
Date: Sat, 2 Mar 2024 00:35:11 +0000
Message-ID: <9ddefe40defef4ea2e2db0e2c2950d5f816bd2c6.camel@realtek.com>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
	 <20240227235507.781615-5-fiona.klute@gmx.de>
	 <368ebc04c2ec436791a27b5661189783@realtek.com>
	 <db9e7f0d-a60f-467b-82df-da6170d02151@gmx.de>
	 <5f505604-7bf1-471d-9e36-d9712daa9064@gmx.de>
In-Reply-To: <5f505604-7bf1-471d-9e36-d9712daa9064@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <841752C34BB7F945B8430322EAFB5F9D@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI0LTAzLTAxIGF0IDE4OjE1ICswMTAwLCBGaW9uYSBLbHV0ZSB3cm90ZToNCj4g
DQo+IEFtIDAxLjAzLjI0IHVtIDE3OjM1IHNjaHJpZWIgRmlvbmEgS2x1dGU6DQo+ID4gDQo+ID4g
SWYgSSByZW1vdmUgdGhlbSB3aGV0aGVyIHRoZSBjb2RlIGNvbXBpbGVzIGRlcGVuZHMgb24gdGhl
IG9yZGVyIG9mDQo+ID4gI2luY2x1ZGVzLiBJZiBzb21lIG90aGVyIGhlYWRlciB0aGF0IGluY2x1
ZGVzIHRob3NlIHR3byBpcyBpbmNsdWRlZA0KPiA+IGJlZm9yZSBydHc4NzAzYi5oIGl0IHdvcmtz
LCBvdGhlcndpc2UgaXQgd2lsbCBicmVhay4gSSBkb24ndCB0aGluaw0KPiA+IHRoYXQncyBkZXNp
cmFibGUsIHRob3VnaCBvdGhlciBydHc4OCBoZWFkZXJzIGFscmVhZHkgYmVoYXZlIHRoYXQgd2F5
DQo+ID4gKGUuZy4gbWFpbi5oIG11c3QgYmUgaW5jbHVkZWQgYmVmb3JlIHRoZSBvdGhlcnMpLiBB
bHNvLCBjbGFuZ2Qgd2lsbA0KPiA+IGNvbXBsYWluIGFib3V0IHVuZGVmaW5lZCB0eXBlcyAodTgs
IHM4KSwgd2hpY2ggaXMgbGVzcyBpbXBvcnRhbnQgYnV0DQo+ID4gc3RpbGwgYW5ub3lpbmcgd2hl
biB3b3JraW5nIG9uIHRoZSBjb2RlLiBTbyBJJ2QgcHJlZmVyIHRvIGtlZXAgdGhlDQo+ID4gaW5j
bHVkZXMuDQo+IA0KPiBDb3JyZWN0aW9uOiBPbmx5IHRoZSBsaW51eC90eXBlcy5oIGlzIG5lZWRl
ZCBmb3IgdGhhdCwgSSBjYW4gZGVmaW5pdGVseQ0KPiByZW1vdmUgdGhlIGxpbnV4L2NvbXBpbGVy
X2F0dHJpYnV0ZXMuaCBvbmUuDQo+IA0KDQpQbGVhc2UgY2hlY2sgbWFpbCB0aGF0IGV4cGxhaW5z
IHdoYXQgSSBtZWFudC4gDQoNCg==

