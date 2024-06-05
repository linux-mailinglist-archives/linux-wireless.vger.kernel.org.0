Return-Path: <linux-wireless+bounces-8506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3932D8FC207
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 04:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738EB1F2266C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 02:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884F761FE5;
	Wed,  5 Jun 2024 02:53:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F16F4F5
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717556011; cv=none; b=iMhFwiuNJcyLA8qhhLudwBqndoZm2cUzDaaldOtFnnzQyfxrGsSRwONfYqsMLSHz9oKqeYqOT4jLZiuN2QwkmS1NgHE0BLdLQUzQCLuzF/mSsP/KA+7/iQSVyGDvAkBLYtjdqwRec/1ViadV94JYXysMqfn6IQBnw9TDjrS2f1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717556011; c=relaxed/simple;
	bh=BlNmjukrqT6mHa5m0Kj6K3NhG8y+2SgsyZqujadCKbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDvG5D61QPejAEDkDzjHDIIjMgd+Cwef6ZRuC1Rx9jdyG0tAIDJEcuL+kOz4fDFBJ093IgF4CuAQtKCUd5XqWNy/mbFBKpCBN/hi8ceeiWntjaolvdOa6T++BHbN26x/KeH50x5cgLbNzK5fYMKT3+iSebs7OMkScmURWrfmj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4552qsljF965692, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4552qsljF965692
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Jun 2024 10:52:54 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 10:52:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 5 Jun 2024 10:52:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 5 Jun 2024 10:52:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "wens@kernel.org" <wens@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "wireless-regdb@lists.infradead.org" <wireless-regdb@lists.infradead.org>
Subject: RE: [PATCH 4/4] wireless-regdb: Update regulatory info for Mexico (MX) on 6GHz
Thread-Topic: [PATCH 4/4] wireless-regdb: Update regulatory info for Mexico
 (MX) on 6GHz
Thread-Index: AQHatXy5KFLFp8BRMkWnU/XO3MXPerG25FkAgAGVq3A=
Date: Wed, 5 Jun 2024 02:52:54 +0000
Message-ID: <a97fcc8d9dfd4f9784dace38d0c01351@realtek.com>
References: <20240603060558.98791-1-pkshih@realtek.com>
 <20240603060948.99147-1-pkshih@realtek.com>
 <CAGb2v65j604KUiVDiXSAbpJQQetGagFj53E8zuk6JqwaDdBk3w@mail.gmail.com>
In-Reply-To: <CAGb2v65j604KUiVDiXSAbpJQQetGagFj53E8zuk6JqwaDdBk3w@mail.gmail.com>
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

Q2hlbi1ZdSBUc2FpIDx3ZW5zQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiBPbiBNb24sIEp1biAzLCAy
MDI0IGF0IDI6MTDigK9QTSBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiBUaGUgUGxlbmFyeSBTZXNzaW9uIG9mIHRoZSBGZWRlcmFsIFRlbGVjb21tdW5p
Y2F0aW9ucyBJbnN0aXR1dGUgKElGVCkNCj4gPiBkZXRlcm1pbmVkLCBpbiBpdHMgSVYgb3JkaW5h
cnkgc2Vzc2lvbiBvZiAyMDIzLCB0byBjbGFzc2lmeSB0aGUNCj4gPiA1OTI1IC0gNjQyNSBNSHog
ZnJlcXVlbmN5IHNlZ21lbnQgYXMgZnJlZSBzcGVjdHJ1bSBhbmQgaXNzdWVkIHRoZQ0KPiA+IHRl
Y2huaWNhbCBvcGVyYXRpbmcgY29uZGl0aW9ucyB0aGF0IGFsbG93IGNvZXhpc3RlbmNlIHdpdGgg
dGhlIGV4aXN0aW5nDQo+ID4gc2VydmljZXMgaW4gdGhlIGNvdW50cnkgWzJdLg0KPiA+DQo+ID4g
V2l0aGluIHRoZSBvcGVyYXRpbmcgY29uZGl0aW9ucyBvZiB0aGlzIGJhbmQgYXMgZnJlZSBzcGVj
dHJ1bSwgaXRzIHVzZSB3YXMNCj4gPiBkZXRlcm1pbmVkIGZvciBsb3cgcG93ZXIgaW5kb29yIGFu
ZCB2ZXJ5IGxvdyBwb3dlciBpbmRvb3IgYW5kIG91dGRvb3INCj4gPiBzeXN0ZW1zLg0KPiA+DQo+
ID4gQWNjb3JkaW5nIHRvIFdCQSBSZXNwb25zZSB0byB0aGUgTWV4aWNvIElGVCA2IEdIeiBDb25z
dWx0YXRpb24gWzNdLiBUaGUNCj4gPiBMb3cgUG93ZXIgSW5kb29yIGlzDQo+ID4gICAgICAgICAz
MyBkQm0gTWF4IFR4IFBvd2VyIChFSVJQKSAmIDhkQm0vTUh6IFBTRCAoRUlSUCkgZm9yIEFjY2Vz
cyBQb2ludHMNCj4gPiBhbmQNCj4gPiAgICAgICAgIDI3IGRCbSBNYXggVHggUG93ZXIgKEVJUlAp
ICYgMmRCbS9NSHogUFNEIChFSVJQKSBmb3IgQ2xpZW50cw0KPiA+DQo+ID4gVGhlIFZlcnkgTG93
IFBvd2VyIGlzIDQgZEJtIE1heCBUeCBQb3dlciAoRUlSUCkNCj4gPg0KPiA+IFsxXQ0KPiBodHRw
czovL3d3dy5pZnQub3JnLm14L2NvbXVuaWNhY2lvbi15LW1lZGlvcy9jb211bmljYWRvcy1pZnQv
ZXMvZWwtcGxlbm8tZGVsLWlmdC1jbGFzaWZpY2EtbGEtYmFuZGEtZGUNCj4gLTU5MjUtNjQyNS1t
aHotY29tby1lc3BlY3Ryby1saWJyZS1jb211bmljYWRvLTEzMjAyMy0xNi1kZQ0KPiANCj4gTm90
IHN1cmUgd2hhdCB0aGlzIHJlZmVyZW5jZSBpcyBmb3I/DQoNClRoaXMgaXMgZW50cnkgcGFnZSBv
ZiBbMl0uIEkgd2lsbCByZW1vdmUgaXQgb3IgYWRkIGRlc2NyaXB0aW9uIGFib3V0IGl0LiANCg0K
PiANCj4gPiBbMl0NCj4gaHR0cHM6Ly93d3cuaWZ0Lm9yZy5teC9zaXRlcy9kZWZhdWx0L2ZpbGVz
L2NvbXVuaWNhY2lvbi15LW1lZGlvcy9jb211bmljYWRvcy1pZnQvY29tdW5pY2FkbzEzaWZ0XzEu
cGRmDQo+ID4gWzNdDQo+IGh0dHBzOi8vd3d3LmlmdC5vcmcubXgvc2l0ZXMvZGVmYXVsdC9maWxl
cy9pbmR1c3RyaWEvdGVtYXNyZWxldmFudGVzL2NvbnN1bHRhc3B1YmxpY2FzL2RvY3VtZW50b3Mv
MjAyMQ0KPiAwMTE5LWNwaTZnaHoyMDIwLTE2Mi5wZGYNCj4gDQo+IFsyXSBkb2VzIG5vdCBzYXkg
d2hhdCBsaW1pdHMgd2VyZSBhZG9wdGVkLCBub3IgdGhhdCB0aGUgV0JBJ3MNCj4gcmVjb21tZW5k
YXRpb25zIFszXSB3ZXJlIGFkb3B0ZWQgaW4gaXRzIGVudGlyZXR5LiBXaXRob3V0IHN1Y2gNCj4g
d29yZGluZywgWzNdIGlzIGp1c3QgYSByZWNvbW1lbmRhdGlvbiwgbm90IHRoZSBmaW5hbCBydWxl
LiBUaGlzDQo+IG5lZWRzIHNvbWUgbW9yZSBpbmZvcm1hdGlvbi4NCg0KSSB3aWxsIHRyeSB0byBz
ZWFyY2ggZm9yIHRoZSBhZG9wdGVkIHBvd2VyIGxpbWl0cy4gSWYgSSBjYW4ndCBnZXQgdGhhdCBz
aG9ydGx5LA0KSSB3aWxsIG9ubHkgc3VibWl0IDMgcGF0Y2hlcyBieSB2Mi4NCg0KQSBxdWVzdGlv
biBhYm91dCBUWCBwb3dlciB2YWx1ZS4gSXMgYSBzcGVjaWFsIHZhbHVlIGV4aXN0aW5nIHRvIGlu
ZGljYXRlIHRoZQ0KdmFsdWUgaXMgdW5jZXJ0YWluPyANCg0KVGhhbmtzDQpQaW5nLUtlDQoNCg==

