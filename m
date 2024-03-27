Return-Path: <linux-wireless+bounces-5311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5C688D3AD
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 02:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9A02E1651
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 01:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF73F182B5;
	Wed, 27 Mar 2024 01:20:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAA17FF
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502407; cv=none; b=TzX967OjkhU3Zqs/Neka7GN8p+CxBb1SUYkyyag1jWetUOce1GO4xSgaROot6S6maIsSMJVThTtqEXzCOr0u3N28oMoIZrQMQNp8QMVU5HnVg2u2b/29WLA+7hvu1/2o+9VzQUB2MYFUcQ7UGYEM32JLAAhKNCa1FNoEDJ6Tff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502407; c=relaxed/simple;
	bh=NrMUzzp/Dfz5Mn9FryLodjU2vwEiFGdy+3j7SwHN3a8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O7eCzBrnM1A/f/lb6rCGJ2ubVAp9iHjTOjR/jk3X9OvQilk7FnhNqy78jfo2XbsfEiWUvN+s5rYXQlWJVlgsZmJGl99haeKTBypZf/swywuNwCK/DaR6VCffOTC1cpiDg57qskwQh1Xj4/nMJ+IFxm2yAG2cbuv6G8dCSlK/qTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42R1JX3c8211615, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42R1JX3c8211615
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 09:19:33 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 09:19:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 09:19:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Wed, 27 Mar 2024 09:19:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 06/12] wifi: rtlwifi: Add rtl8192du/phy.{c,h}
Thread-Topic: [PATCH v3 06/12] wifi: rtlwifi: Add rtl8192du/phy.{c,h}
Thread-Index: AQHaev4zJcEdGzXhVESOip6vGkfV17FCtX+AgAdkDgCAADOvgA==
Date: Wed, 27 Mar 2024 01:19:33 +0000
Message-ID: <6348dcc1f8deb7eba6b97aec8ca6e629c70f4908.camel@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	 <367ae147-3f2d-4ecc-989f-62fd7d82ebfc@gmail.com>
	 <59596a57735c713a135ec64b05b8031ad9149421.camel@realtek.com>
	 <387fa334-cc78-44fb-a638-0da9d104250c@gmail.com>
In-Reply-To: <387fa334-cc78-44fb-a638-0da9d104250c@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <9732A74E5518CC4AA9791CCA78FF7B1D@realtek.com>
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

T24gV2VkLCAyMDI0LTAzLTI3IGF0IDAwOjEzICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gT24gMjIvMDMvMjAyNCAwNzoyMiwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IE9u
IFdlZCwgMjAyNC0wMy0yMCBhdCAyMTozOCArMDIwMCwgQml0dGVyYmx1ZSBTbWl0aCB3cm90ZToN
Cj4gPiBbLi4uXQ0KPiA+IA0KPiA+ID4gK3ZvaWQgcnRsOTJkX3BoeV9sY19jYWxpYnJhdGUoc3Ry
dWN0IGllZWU4MDIxMV9odyAqaHcsIGJvb2wgaXMydCkNCj4gPiA+ICt7DQo+ID4gPiArICAgICAg
IHN0cnVjdCBydGxfcHJpdiAqcnRscHJpdiA9IHJ0bF9wcml2KGh3KTsNCj4gPiA+ICsgICAgICAg
c3RydWN0IHJ0bF9oYWwgKnJ0bGhhbCA9ICZydGxwcml2LT5ydGxoYWw7DQo+ID4gPiArICAgICAg
IHN0cnVjdCBydGxfcGh5ICpydGxwaHkgPSAmcnRscHJpdi0+cGh5Ow0KPiA+ID4gKyAgICAgICB1
MzIgdGltZW91dCA9IDIwMDAsIHRpbWVjb3VudCA9IDA7DQo+ID4gPiArDQo+ID4gPiArICAgICAg
IHdoaWxlIChydGxwcml2LT5tYWM4MDIxMS5hY3Rfc2Nhbm5pbmcgJiYgdGltZWNvdW50IDwgdGlt
ZW91dCkgew0KPiA+ID4gKyAgICAgICAgICAgICAgIHVkZWxheSg1MCk7DQo+ID4gPiArICAgICAg
ICAgICAgICAgdGltZWNvdW50ICs9IDUwOw0KPiA+IA0KPiA+IFdoYXQgaXMgdGhlIHB1cnBvc2U/
DQo+ID4gDQo+ID4gRXZlbiBpZiB5b3UgcmVhbGx5IG5lZWQgaXQsIGp1c3QgbWRlbGF5KDIpIG9y
IHNvbWV0aGluZyBsaWtlIHRoYXQ/ID4NCj4gDQo+IFRoaXMgY29tZXMgZnJvbSBydGw4MTkyZGUu
IFRoZSBUWCBwb3dlciB0cmFja2luZyBjYW4gcmUtZG8gTEMNCj4gY2FsaWJyYXRpb24uIFNvbWVv
bmUgZGVjaWRlZCB0aGF0IHNob3VsZG4ndCBoYXBwZW4gd2hpbGUNCj4gc2Nhbm5pbmcuIEkgZG9u
J3Qga25vdyB3aHkuDQoNCkkgdGhpbmsgeW91IGFyZSByaWdodC4gV2hpbGUgc2Nhbm5pbmcsIGl0
IHdpbGwgc3dpdGNoIGNoYW5uZWxzIG9uZSBieSBvbmUsDQpidXQgTEMgY2FsaWJyYXRpb24gaXMg
b25seSBmb3IgYSBjZXJ0YWluIGNoYW5uZWwgKG1vc3RseSBvcGVyYXRpbmcgY2hhbm5lbCksDQpz
byBoZXJlIGlzIHRvIHdhaXQgZm9yIHNjYW5uaW5nIGNvbXBsZXRpb24gd2l0aCAyMDAwICogNTB1
cyAoMTAwbXMpIHRpbWVvdXQNCnRvIHByZXZlbnQgaW50ZXJydXB0aW5nIExDIGNhbGlicmF0aW9u
Lg0KDQoNCj4gPiA+ICsgICAgICAgd2hpbGUgKHJ0bHBoeS0+bGNrX2lucHJvZ3Jlc3MgJiYgdGlt
ZWNvdW50IDwgdGltZW91dCkgew0KPiA+ID4gKyAgICAgICAgICAgICAgIG1kZWxheSg1MCk7DQo+
ID4gPiArICAgICAgICAgICAgICAgdGltZWNvdW50ICs9IDUwOw0KPiA+ID4gKyAgICAgICB9DQo+
ID4gDQo+ID4gQ291bGQgTENLIGFuZCBzd2l0Y2ggY2hhbm5lbCBoYXBwZW4gc2ltdWx0YW5lb3Vz
bHk/DQo+ID4gQ2FuIHlvdSBwb2ludCBvdXQgdGhlIGNhc2U/DQo+ID4gDQo+IA0KPiBXaGVuIGEg
c2NhbiBjb2luY2lkZXMgd2l0aCB0aGUgVFggcG93ZXIgdHJhY2tpbmcgZGVjaWRpbmcgdG8NCj4g
cmUtZG8gTEMgY2FsaWJyYXRpb24sIEkgZ3Vlc3MuDQoNCllvdSBhcmUgYWxzbyByaWdodCBoZXJl
LiBBZnRlciBsb29raW5nIGRlZXBlciwgVFggcG93ZXIgdHJhY2tpbmcgYW5kIHNjYW4NCmFyZSBy
dW5uaW5nIG9uIGRpZmZlcmVudCB3b3JrIHF1ZXVlcywgYW5kIHNlZW1pbmdseSBpdCB3b3VsZCBj
YXVzZSBwb3NzaWJseQ0KcmFjZSBjb25kaXRpb24sIHdoaWNoIHBvc3NpYmx5IGdldHMgbG93ZXIg
UkYgcGVyZm9ybWFuY2UuIA0KDQoNCg==

