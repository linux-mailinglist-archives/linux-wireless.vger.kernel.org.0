Return-Path: <linux-wireless+bounces-10701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B06419423F1
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 02:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04416B234A5
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 00:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A604C76;
	Wed, 31 Jul 2024 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SHSag/+Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3C4A31
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386877; cv=none; b=a7A+rphuDkRY91AGLJepQO8LeYQKLcZDilu6MfZWecdp/sOHwlF2BXJ2Xxu67YFcYXWytf0UY7zTusfl7PQhIFDElG04C9yhh1Nalw5mW+8RVFueP3OfVzC/6D0gOYBRu0a+oDVC7B0l2t4BXPZp0JvKbbHiUOzXQ1FzvIcE8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386877; c=relaxed/simple;
	bh=49RV1q/m3zSrAOUf/0lJ9R1hkl3yOGCWqJbxHxs5VSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Up8XNq4OySOiNbZ1khGbdZifXJzzOH3/XixpZ60bBf/Ab/kHltSiyNuSFK8eBihl2i7Sgc0/VrEIukkMwWgn4iW9KqyVmSAfkA3wqlC0qZaapcrDqMJOOp7K07PHUe5dWqlmq2KC7Yb8yK1XkOmnyshkn5kgb8E5sBWpNdgUoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SHSag/+Q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V0ldk571734700, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722386859; bh=49RV1q/m3zSrAOUf/0lJ9R1hkl3yOGCWqJbxHxs5VSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SHSag/+QpewE3NcfutWWGhAaNSZxxzsG3HCJebKbDhh8eeMWQcakv5lGX83Duay/u
	 L/7GeToJQAx+cOuQIl1Rsq9i3X+sXIjsHqTiVmhY6+kfsJ/tHVh9HqBxOOwiEM3RRg
	 b9b08ZA9IkPqxOZUi0PZOW71wCAIH7A7jRatCPd1b7/fvt98jzczSF0/yIzeIANjAw
	 zI1CXNzRmibmvXQKLHo0yEwkRLbJI+dGHUDXvA0kAWd8HMDVBppW5g4qTSbnwVZS8s
	 gh/dHA3Aj+zuHfrCKXLsqWn/MHiSGdrRp/MndGl1tz79JFUrCIAg/rmRBNEBJrjvTz
	 ZLbMB5vvb8RVA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V0ldk571734700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 08:47:39 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 08:47:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jul 2024 08:47:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 31 Jul 2024 08:47:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
Thread-Topic: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
Thread-Index: AQHa4UC4lZ9xsp59ME2YErnRO2fzALIO0JLQ///mdQCAAUpa0A==
Date: Wed, 31 Jul 2024 00:47:39 +0000
Message-ID: <d21bc7a0fac8413b9cc443288924ec7b@realtek.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
 <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
 <9356af89520243ccacc0be72b8b03252@realtek.com>
 <4f052989-5fb9-4c5c-950e-a3d34e6499ab@gmail.com>
In-Reply-To: <4f052989-5fb9-4c5c-950e-a3d34e6499ab@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAz
MC8wNy8yMDI0IDA5OjMzLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBJbiBBUCBtb2Rl
LCB0aGUgZmlybXdhcmUgc3RvcHMgdHJhbnNtaXR0aW5nIGJlYWNvbnMgaWYgaXQgcmVjZWl2ZXMN
Cj4gPj4gSDJDX0NNRF9SQV9JTkZPIGZvciBtYWNpZCAwLg0KPiA+Pg0KPiA+PiBMZWF2ZSBtYWNp
ZCAwIHVudXNlZCBpbiBBUCBtb2RlLiBNYWNpZCAxIGlzIGFscmVhZHkgcmVzZXJ2ZWQgZm9yDQo+
ID4+IGJyb2FkY2FzdC9tdWx0aWNhc3QuIEFzc2lnbiBtYWNpZCAyIHRvIHRoZSBmaXJzdCBjb25u
ZWN0ZWQgY2xpZW50Lg0KPiA+DQo+ID4gU2VlbWluZ2x5IHdlIG1pc3NlZCB0byBzZXQgbWFjX2lk
IGluIFRYIGRlc2MgZm9yIGEgbG9uZyB0aW1lLg0KPiA+DQo+ID4gKyNkZWZpbmUgUlRXX1RYX0RF
U0NfVzFfTUFDSUQgR0VOTUFTSyg3LCAwKQ0KPiA+ICAjZGVmaW5lIFJUV19UWF9ERVNDX1cxX1FT
RUwgR0VOTUFTSygxMiwgOCkNCj4gPiAgI2RlZmluZSBSVFdfVFhfREVTQ19XMV9SQVRFX0lEIEdF
Tk1BU0soMjAsIDE2KQ0KPiA+DQo+ID4gVGhlIG1hY19pZCBzaG91bGQgYmUgZnJvbSBydHd2aWYt
Pm1hY19pZCBvciBzaS0+bWFjX2lkIGFjY29yZGluZyB0bw0KPiA+IG9wZXJhdGluZyBtb2RlIGFu
ZCByb2xlLg0KPiA+DQo+ID4gQW5kIEkgc3VwcG9zZSBtYWNfaWQgYXNzaWdubWVudCBmb3IgQVAg
aXMgbWFjX2lkIDAgZm9yIGJyb2FkY2FzdC9tdWx0aWNhc3QsIGFuZA0KPiA+IG90aGVyIG1hY19p
ZCBjYW4gYmUgdXNlZCBieSBjb25uZWN0ZWQgc3RhdGlvbnMgcmVndWxhcmx5Lg0KPiA+DQo+IA0K
PiBXaGF0IGFib3V0IHRoZSBjb25jdXJyZW50IEFQICsgc3RhdGlvbiBzY2VuYXJpbz8gV2lsbCB0
aGUNCj4gc3RhdGlvbiB2aWYgdXNlIHRoZSBuZXh0IGF2YWlsYWJsZSBtYWNpZCwgd2hhdGV2ZXIg
dGhhdCBpcz8NCj4gSnVzdCB3b25kZXJpbmcsIEkgZG9uJ3QgdXNlIGNvbmN1cnJlbnQgbW9kZS4N
Cg0KTXkgYmFzaWMgaWRlYSBpcyB0byBhc3NpZ24gbWFjX2lkIHRvIGVhY2ggdmlmIHdoZW4gYWRk
aW5nIHZpZi4gRm9yIHN0YXRpb24gbW9kZSwNCnN0YS0+bWFjX2lkIHdpbGwgcmV1c2UgdmlmLT5t
YWNfaWQuIEZvciBBUCBtb2RlLCBJIHdpbGwgZHluYW1pY2FsbHkgYWxsb2NhdGUgYW4NCnN0YS0+
bWFjX2lkIHRvIGEgc3RhdGlvbiwgYW5kIHZpZi0+bWFjX2lkIGlzIHRvIHNlbmQgYnJvYWRjYXN0
L211bHRpY2FzdCBwYWNrZXRzDQp0aGF0IGFyZSBub3QgYmVsb25nIHRvIGEgc3RhLiBGb3IgZXhh
bXBsZSwNCg0KICAgICAgICAgICAgICAgICAgdmlmLT5tYWNfaWQgICAgICBzdGEtPm1hY19pZA0K
dmlmMCAoU1RBIG1vZGUpICAgICAgICAwICAgICAgICAgICAgICAgMA0KdmlmMSAoQVAgbW9kZSkg
ICAgICAgICAxICAgICAgICAgICAgICAgMi4uLg0KDQoNCj4gDQo+IEFsc28sIGRvIHlvdSBtZWFu
IHRoYXQgeW91IHdpbGwgZG8gYWxsIHRoaXM/IEl0J3Mgbm90IGNsZWFyIHRvIG1lLg0KDQpJIGNh
biBkbyBpdC4gT3IgYXJlIHlvdSBpbnRlcmVzdGVkIGluIHRoaXM/DQoNCg0K

