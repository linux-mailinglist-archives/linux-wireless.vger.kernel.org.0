Return-Path: <linux-wireless+bounces-26192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1846B1D0B3
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 03:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820627E0199
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Aug 2025 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A25211460;
	Thu,  7 Aug 2025 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mAtxx71W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC414D2B7
	for <linux-wireless@vger.kernel.org>; Thu,  7 Aug 2025 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531305; cv=none; b=Tr1kbAxvTBdlF+ttmarnodzasetwznV61U90EpIU4Fu2fFcRgp7YBD8sd5PvJi9U8WZ7s+O0YjUbltAQI9J58FLARnj6XQRojqKFY2FTfLkQXFLz7TsKAwjJlUifuixoX9LIzyh7A5L/nB9t0MhZfDT6Mx8X5lWDMy8TOoXjySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531305; c=relaxed/simple;
	bh=1tfX+XdEj6bNY0b8mVNDCiS2Hx45o9ziJ/1vFZWdymE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dArc5rKYY7oWydZcpgPmh0uV/P1yNNJGwW1O9QhtbngyfJ5wYQ4xDCCsem+RJ+qjDn+ZAVDuhfxZbbNnmYR1pvrNagbxbLw0llkQYEdbrw39bGphghRTFobrZJ8QrDuyNnw39juanNcyM0gXnrRbnnKmY0xmwkbPImMowRO0ObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mAtxx71W; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5771hvIU3625424, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754531037; bh=1tfX+XdEj6bNY0b8mVNDCiS2Hx45o9ziJ/1vFZWdymE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mAtxx71WA8SHwJQHcihsoA22ma1QDDEMe3wl5qxh7GTswCNUzxwXea5qqbg9xBnY2
	 l1hOfCnwCiZANA5mimFucjkMxFN0g5L5kD9FgYWSTV3SpPpHbGR1Q8J0OkJaQlYWdb
	 UxzTfXWFJNE4H0WbmlPj8VLgSePO+Du96yED/FZ1f8lwREdFu3juwNSgF4uHFcAzmb
	 vZKu5Vv1EgkJI46s4g9PcrOSQB9+R28YsKwbWTVkI9dwL8NAsqvcPFSrM9lrjogzpf
	 IdTEJV4i9cMgbnMKeZZwqHmAK7ZLgv2orXYVdaBzJfCyTKB+j63EQAluER+yUhV4Cw
	 ZRSYSn+Y1ku6w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5771hvIU3625424
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 09:43:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Aug 2025 09:43:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Thu, 7 Aug 2025 09:43:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Avalon Vargas Centeno <avalon.vargas.centeno@est.una.ac.cr>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "jouni@qca.qualcomm.com" <jouni@qca.qualcomm.com>
Subject: RE: [REGDB] Update for Costa Rica (CR) regulatory domain
Thread-Topic: [REGDB] Update for Costa Rica (CR) regulatory domain
Thread-Index: AQHcByZCbws2Kb9R6kGpEGyNvUi/s7RWacYA
Date: Thu, 7 Aug 2025 01:43:57 +0000
Message-ID: <66d6f06bc2c24d188bc4a85582c59870@realtek.com>
References: <CAGXpr56=x-2P+dkq+k4s7NUbDXdYsxhzsZvGYpM+o-eh4WcHwQ@mail.gmail.com>
In-Reply-To: <CAGXpr56=x-2P+dkq+k4s7NUbDXdYsxhzsZvGYpM+o-eh4WcHwQ@mail.gmail.com>
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

DQoNCkF2YWxvbiBWYXJnYXMgQ2VudGVubyA8YXZhbG9uLnZhcmdhcy5jZW50ZW5vQGVzdC51bmEu
YWMuY3I+IHdyb3RlOg0KPiBJIGFtIHJlcG9ydGluZyBhbiBpc3N1ZSB3aXRoIHRoZSB3aXJlbGVz
cyByZWd1bGF0b3J5IGRvbWFpbiBmb3IgQ29zdGEgUmljYSAoQ1IpDQo+ICBpbiB0aGUgd2lyZWxl
c3MgLSByZWdkYi4gVGhlIGN1cnJlbnQgcnVsZXMgYXBwZWFyIHRvIGJlIG92ZXJseSByZXN0cmlj
dGl2ZSwNCj4gIGNhdXNpbmcgc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gb24g
bW9kZXJuIFdpLUZpIDYgaGFyZHdhcmUgYW5kDQo+ICBkZXZpY2VzIHVzaW5nIHRoZSA1R2h6IGJh
bmQuDQo+IA0KPiBUaGUgaXNzdWU6DQo+IFdoZW4gdGhlIHJlZ3VsYXRvcnkgZG9tYWluIGlzIHNl
dCB0byBteSBjb3VudHJ5IChDUiksIG15IFdpLUZpIHRocm91Z2hwdXQNCj4gIGlzIGNhcHBlZCBh
dCBhcHByb3hpbWF0ZWx5IDEwMCBNYnBzLiBXaGVuIEkgbWFudWFsbHkgc2V0IHRoZSBkb21haW4g
dG8gVVMNCj4gIG9yIG90aGVyIGNvdW50cmllcywgSSBhY2hpZXZlIG15IGNvbm5lY3Rpb24ncyBm
dWxsIHNwZWVkIG9mIH42MDAgTWJwcy4NCj4gIFRoZSBpbmZvcm1hdGlvbiBvYnRhaW5lZCBmcm9t
IHRoZSBjb21tYW5kOiBpdyByZWcgZ2V0LCBkaXNwbGF5cyBob3cgdGhlDQo+ICA1R2h6IGJhbmRz
IGFyZSBnZXR0aW5nIGJvdHRsZW5lY2tlZCBieSB0aGVpciBtYXggYmFuZHdpZHRoIG9mIDIwTWh6
IHdoaWxlDQo+ICBhcHBhcmVudGx5IHdpZmkgNyA2R2h6IGhhcyBiZWVuIHVwZGF0ZWQuDQo+IA0K
PiBIYXJkd2FyZSBpbmZvOg0KPiDigKdEZXZpY2U6IExpbnV4IGRlc2t0b3AgcnVubmluZyBGZWRv
cmEgNDIsIGFsc28gdGVzdGVkIG9uIHRoZSBsYXRlc3QgcHVibGljDQo+ICBzdGFibGUobm9uIGx0
cyApa2VybmVsIHVzaW5nIEFyY2ggbGludXgNCj4g4oCnV2ktRmkgQWRhcHRlcjogVFAtTGluayBB
cmNoZXIgVDJPRSAoUmVhbHRlayBSVEw4ODUyQUUpDQo+IOKAp0tlcm5lbCB2ZXJzaW9uOiA2LjE1
LjktMjAxLmZjNDIueDg2XzY0DQo+IA0KPiBBdHRhY2htZW50czoNCj4gQmVsb3cgSSBhdHRhY2hl
ZCBhcHByb3ByaWF0ZSBzY3JlZW5zaG90cyBzaG93Y2FzaW5nIHRoZSBkaWZmZXJlbmNlIGluIHRo
ZQ0KPiAgaW50ZXJmYWNlIGluZm9ybWF0aW9uIGJldHdlZW4gcmVndWxhdG9yeSBkb21haW5zLg0K
Pg0KDQpCeSBbMV0sIDQwIGFuZCA4ME1IeiBjaGFubmVscyBhcmUgbm90IGFsbG93ZWQgb24gNUdI
eiBmb3IgQ1IsIGJ1dCB0aGVyZSBpcw0Kbm8gcmVmZXJlbmNlIHRvIGtub3cgaWYgdGhlIGxpbWl0
YXRpb24gaXMgcmVtb3ZlZCBub3cuIA0KDQpOb3Qgc3VyZSBpZiBKb3VuaSAoQ2MnZCkgY2FuIHJl
bWVtYmVyIHRoaXMuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy93aXJlbGVzcy1yZWdk
Yi8xNDIyMDEzODcyLTk3MzItMS1naXQtc2VuZC1lbWFpbC1qb3VuaUBxY2EucXVhbGNvbW0uY29t
Lw0KDQoNCg==

