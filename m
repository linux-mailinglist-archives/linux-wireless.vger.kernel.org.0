Return-Path: <linux-wireless+bounces-4791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D68787CE3C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 14:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271A61F22285
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Mar 2024 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E0326288;
	Fri, 15 Mar 2024 13:48:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BE14A98;
	Fri, 15 Mar 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510487; cv=none; b=Rm1Li7QzkvR/1IIjtE4i/Eyu5IIIQTSkW3fR66+sk70OvJB62dAxMFi2yIYSGvNAtu9lee/Zfmswxj1CVGcXO2UugaQbdnXE19EdWAF7by/WW6+HGrMS3lzse6KvTrXcIez9ZBl0StOKcuFMXD2eaI57RXylh8yTJEZ+gUPGfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510487; c=relaxed/simple;
	bh=/jaPVSWJL+HnKY3WqOkBwk9l8Qb2AuIP5j60mqDKN+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKjDuaBnZ50VbD6xX6V/t+aBIY0Zu3TV0vaKRmQ16C7PuknnEvDEWhE4Ah+p3COHGCAZcOmM0Wf+GZHjtk8JzRNZLjyvTly516YKUmleSNwMXBlrboQWNZ8hxOsaQw7Vls+WO9Qve/JMRsJfJ6gbxltSFh0BZhoRX2QfPLEDtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42FDlxgV71959737, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42FDlxgV71959737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 21:47:59 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 21:48:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 21:47:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 15 Mar 2024 21:47:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ryan@testtoast.com" <ryan@testtoast.com>
CC: "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
Subject: Re: [BUG] RTL8821CS panic on entering power-save mode
Thread-Topic: [BUG] RTL8821CS panic on entering power-save mode
Thread-Index: AQHadM7olU9bQwYCjEqmXTF3UHR0U7E1LQQggALaEYCAAEexgA==
Date: Fri, 15 Mar 2024 13:47:59 +0000
Message-ID: <902ff7d3d6221f28df21c2e5b3e743671355c874.camel@realtek.com>
References: <f3656995-b8fe-49c4-93b7-67612c685954@app.fastmail.com>
	 <2afd1590823740a2b6a8f7e485a33842@realtek.com>
	 <d5889133-4b8b-49bc-a26f-204ee9fcfdbb@app.fastmail.com>
In-Reply-To: <d5889133-4b8b-49bc-a26f-204ee9fcfdbb@app.fastmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FF2C271142C804F8DE9985BC61704C7@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI0LTAzLTE1IGF0IDIyOjMwICsxMzAwLCBSeWFuIFdhbGtsaW4gd3JvdGU6DQo+
IA0KPiBPbiBXZWQsIDEzIE1hciAyMDI0LCBhdCA3OjA1IFBNLCBQaW5nLUtlIFNoaWggd3JvdGU6
DQo+IA0KPiA+IFRyeSBtb2R1bGUgcGFyYW1ldGVyIHJ0d19kaXNhYmxlX2xwc19kZWVwX21vZGU9
MSB0byBzZWUgaWYgaXQgd29ya3Mgd2VsbC4NCj4gDQo+IEFkZGluZyAnb3B0aW9ucyBydHc4OF9j
b3JlIGRpc2FibGVfbHBzX2RlZXA9MScgZGlkIGhlbHAgc2lnbmlmaWNhbnRseSwgYW5kIGJsdWV0
b290aCBjb25uZWN0aW9ucw0KPiBub3cgc2VlbSBzdGFibGUuIEkgc3RpbGwgZ2V0IGEgbG90IG9m
DQo+IA0KPiBbICAyNjcuMDc0MjA5XSBydHdfODgyMWNzIG1tYzI6MDAwMToxOiB0aW1lZCBvdXQg
dG8gZmx1c2ggcXVldWUgMQ0KPiANCj4gKDEtMiBwZXIgc2Vjb25kIGV2ZXJ5IGZldyBzZWNvbmRz
KSBpbiBkbWVzZywgcGFydGljdWxhcmx5IGR1cmluZyBkb3dubG9hZHMgb3ZlciB3aWZpLg0KDQpU
aGlzIGlzIGJlY2F1c2UgaXQgaXMgdHJ5aW5nIHRvIGVudGVyIFBTIG1vZGUgYnV0IFRYIHF1ZXVl
IGlzIHN0aWxsIG5vdCBlbXB0eS4NCklmIHBvd2VyIGNvbnN1bXB0aW9uIGlzIG5vdCBiaWcgZGVh
bCB0byB5b3UsIHRyeSB0byB0dXJuIG9mZiBQUyBieQ0KICAgIGl3IHdsYW4wIHNldCBwb3dlcl9z
YXZlIG9mZg0KDQpJIHRoaW5rIG1lc3NhZ2VzIGNhbiBiZSBkaXNhcHBlYXIuIA0KDQo+IA0KPiA+
IFRoZSBJTyBvZiBTRElPIGlzIHNsb3dlciB0aGFuIFBDSUUsIHNvIG1heWJlIHdlIGNhbiB0cnkg
dG8gZW5sYXJnZSB0aW1lb3V0IHRpbWUNCj4gPiBpbiBydHdfcG93ZXJfbW9kZV9jaGFuZ2UoKToN
Cj4gDQo+IFRoaXMgZGlkbid0IG1ha2UgYW55IGNoYW5nZSB3aXRob3V0IGRpc2FibGluZyB0aGUg
cG93ZXItc2F2aW5nIG1vZGVzLCBJIGFsc28gdHJpZWQgaW5jcmVhc2luZyBzb21lDQo+IG9mIHRo
ZSBvdGhlciB0aW1lb3V0cyB3aXRob3V0IGFuIGVmZmVjdC4NCj4gDQoNCk5vIGlkZWEgZm9yIG5v
dy4gU0RJTyBsb29rcyBtdWNoIGRpZmZlcmVudCBmcm9tIFBDSUUuIA0KDQoNCg==

