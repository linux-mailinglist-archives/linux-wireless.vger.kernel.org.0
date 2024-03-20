Return-Path: <linux-wireless+bounces-4933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505108808D3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 01:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE7D1F23D3F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 00:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823CDEBE;
	Wed, 20 Mar 2024 00:58:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419AB15C3
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 00:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896289; cv=none; b=N9v73CFyYlvCnHT5bpfyJGejQktyjn4sxZaOg3bz1vzGxnJzYRTFZYz388CZnTNqwzM0L78V27TAW4k1IjBKV3Rqif8MSOVAzy5K4jAbm9RKpcw97ZwDNYZjHi2vqGaMK1wc+K8BhD9g055JK1nZtPGbO9fQNOpquFUYYMXflBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896289; c=relaxed/simple;
	bh=He6XHQs8bps0rk8eSi1AISNnrXhL/kNa9fwrt/LKutw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qh+7eRFh2XK1l2kj8+NAiM8ed8z35FbjVn91Ov20p8oUjPaWF3rU1Sm3HmoGwK9eKYksN/P9oh9m2PIW7r33D4eRejX1YjrvrG/5aga71U1z2iTH33pO8Ismq5gcjFUh1RvvNefxxw6+MIwIFaWytBiNoXtHw0i4DB3jNNKzpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42K0vZRl9106730, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42K0vZRl9106730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Mar 2024 08:57:35 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 08:57:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 08:57:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Wed, 20 Mar 2024 08:57:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: RE: [PATCH v2 00/12] wifi: rtlwifi: Add new rtl8192du driver
Thread-Topic: [PATCH v2 00/12] wifi: rtlwifi: Add new rtl8192du driver
Thread-Index: AQHaeJsdV0Mc7ABuwkCCsraXqw2IdLE+RVaAgAB4WYCAARKesA==
Date: Wed, 20 Mar 2024 00:57:36 +0000
Message-ID: <45b98bd53119455fa727d67640211fab@realtek.com>
References: <5c23149c-1487-438d-bb37-69e2dd8173dc@gmail.com>
 <2280b6c991fa09e66506088441f63790d092e343.camel@realtek.com>
 <f19a1e6c-fd56-45b7-9936-a1a72d1988ad@gmail.com>
In-Reply-To: <f19a1e6c-fd56-45b7-9936-a1a72d1988ad@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

DQo+ID4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmQvcGh5
X2NvbW1vbi5oOjYwOjM5OiB3YXJuaW5nOiBjb250ZXh0IGltYmFsYW5jZSBpbg0KPiA+ICdydGw5
MmRfYmFuZHR5cGVfMl80RycgLSB1bmV4cGVjdGVkIHVubG9jaw0KPiA+ICAgZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkL3BoeV9jb21tb24uaDo2MDozOTogd2Fy
bmluZzogY29udGV4dCBpbWJhbGFuY2UgaW4NCj4gPiAncnRsOTJkX2RtX2ZhbHNlX2FsYXJtX2Nv
dW50ZXJfc3RhdGlzdGljcycgLSB1bmV4cGVjdGVkIHVubG9jaw0KPiA+ICAgZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkL3BoeV9jb21tb24uaDo2MDozOTogd2Fy
bmluZzogY29udGV4dCBpbWJhbGFuY2UgaW4NCj4gPiAncnRsOTJkX2RtX2Nja19wYWNrZXRfZGV0
ZWN0aW9uX3RocmVzaCcgLSB1bmV4cGVjdGVkIHVubG9jaw0KPiANCj4gVGhlc2UgbG9vayBsaWtl
IGZhbHNlIHBvc2l0aXZlcy4gRXZlcnkgdW5sb2NrIGlzIHByZWNlZGVkIGJ5DQo+IGEgbG9jay4g
SSBmb3VuZCBhIHN1Z2dlc3Rpb24gdG8gYW5ub3RhdGUgdGhlIGZ1bmN0aW9ucyB3aXRoDQo+ICJf
X2FjcXVpcmVzKC4uLikiIGFuZCAiX19yZWxlYXNlcyguLi4pIiB0byBxdWlldCB0aGVzZSB3YXJu
aW5ncywNCj4gYnV0IHRoYXQgZGlkbid0IGRvIGFueXRoaW5nLiBJIGNhbiBvbmx5IGZpeCBpdCBi
eSBjb3B5aW5nIHRoZQ0KPiBjb250ZW50cyBvZiBydGw5MmRfYWNxdWlyZV9jY2thbmRyd19wYWdl
YV9jdGwoKSBhbmQNCj4gcnRsOTJkX3JlbGVhc2VfY2NrYW5kcndfcGFnZWFfY3RsKCkgdG8gdGhl
IGVpZ2h0IHBsYWNlcyB3aGVyZQ0KPiB0aGV5IGFyZSBjYWxsZWQsIGFuZCBkdXBsaWNhdGluZyB0
aGUgY29kZSB0aGF0IG5lZWRzIGxvY2tpbmc6DQo+IA0KPiAgICAgICAgIGlmIChydGxwcml2LT5y
dGxoYWwuaW50ZXJmYWNlaW5kZXggPT0gMSAmJg0KPiAgICAgICAgICAgICBydGxwcml2LT5ydGxo
YWwuaW50ZXJmYWNlID09IElOVEZfUENJKSB7DQo+ICAgICAgICAgICAgICAgICBzcGluX2xvY2tf
aXJxc2F2ZSgmcnRscHJpdi0+bG9ja3MuY2NrX2FuZF9yd19wYWdlYV9sb2NrLCBmbGFnKTsNCj4g
ICAgICAgICAgICAgICAgIHRlbXBfY2NrID0gcnRsX2dldF9iYnJlZyhodywgUkNDSzBfVFhGSUxU
RVIyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1BU0tEV09S
RCkgJiBNQVNLQ0NLOw0KPiAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
cnRscHJpdi0+bG9ja3MuY2NrX2FuZF9yd19wYWdlYV9sb2NrLCBmbGFnKTsNCj4gICAgICAgICB9
IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgdGVtcF9jY2sgPSBydGxfZ2V0X2JicmVnKGh3LCBS
Q0NLMF9UWEZJTFRFUjIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTUFTS0RXT1JEKSAmIE1BU0tDQ0s7DQo+ICAgICAgICAgfQ0KPiANCg0KRHVwbGljYXRlIG9m
IG1haW4gc3RhdGVtZW50cyAndGVtcF9jY2sgPSAuLi4uJyBpc24ndCBnb29kLiBJIHByZWZlcg0K
DQpib29sIG5lZWRfbG9jayA9IHJ0bHByaXYtPnJ0bGhhbC5pbnRlcmZhY2VpbmRleCA9PSAxICYm
DQogICAgICAgICAgICAgICAgIHJ0bHByaXYtPnJ0bGhhbC5pbnRlcmZhY2UgPT0gSU5URl9QQ0k7
DQoNCmlmIChuZWVkX2xvY2spDQoJc3Bpbl9sb2NrX2lycXNhdmUoJnJ0bHByaXYtPmxvY2tzLmNj
a19hbmRfcndfcGFnZWFfbG9jaywgZmxhZyk7DQoNCgl0ZW1wX2NjayA9IHJ0bF9nZXRfYmJyZWco
aHcsIFJDQ0swX1RYRklMVEVSMiwgTUFTS0RXT1JEKSAmIE1BU0tDQ0s7DQoNCmlmIChuZWVkX2xv
Y2spDQoJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcnRscHJpdi0+bG9ja3MuY2NrX2FuZF9yd19w
YWdlYV9sb2NrLCBmbGFnKTsNCg0KDQpCdXQsIEkgd29uZGVyIHdoeSBzcGFyc2UgZG9lc24ndCBj
b21wbGFpbiBvcmlnaW5hbCBjb2RlIChiZWZvcmUgeW91ciBwYXRjaHNldCkNCnRoYXQgdXNlZCBz
dGF0aWMgaW5saW5lIGFscmVhZHkuIENhbiB3ZSBrZWVwIG9yaWdpbmFsIHN0eWxlPw0KDQpQaW5n
LUtlIA0KDQo=

