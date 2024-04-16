Return-Path: <linux-wireless+bounces-6355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD738A5F4B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 02:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57FC7B21358
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 00:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734B80C;
	Tue, 16 Apr 2024 00:31:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3718D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227519; cv=none; b=rmjI6by6c+BQLZnw65QQKQB0BWdV/LhJQVVHPtyNFt0vis30jdHEFs4U/eSlNoUH15S6e6qp+8B3j+0aZ0cfpqFxY+uSMgSTM6fOZD5Du0rgXZ4K8eZxtNukdQS3dWuvutxPjyB3ekQbc8ElmS13lX6cLLwMgIHoYB8exN+bM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227519; c=relaxed/simple;
	bh=ohAFuRuQmHUgaZaaTlFr8ol+h4O6MQbtsPCnO3MkmpA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qr1PGow6YbBjEve+UwE9iIH6ziYIOCkePXMranuNhhyPnfhHAqBUY5HFCE/3LNeFSAAJqPvm8oZd0lYnakGbRHNGyssYpHR+NXRvUUFy85u9pbxFeewH+LDVSTBJWHt26LKiMYXJJkmwJHZt+HJW7znEr9XCaLq3kKKg6J95zdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43G0VYOH01618108, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43G0VYOH01618108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 08:31:39 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 08:31:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 08:31:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 16 Apr 2024 08:31:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Plamen Dimitrov <plamen.dimitrov@pevogam.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller and Linux kernel 6.7.7-100.fc38.x86_64
Thread-Topic: Problems with RTL8852BE PCIe 802.11ax Wireless Network
 Controller and Linux kernel 6.7.7-100.fc38.x86_64
Thread-Index: AQHajxBK3TMYBDJJU02LKax8Cy6TM7FphqBQ
Date: Tue, 16 Apr 2024 00:31:34 +0000
Message-ID: <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
In-Reply-To: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

UGxhbWVuIERpbWl0cm92IDxwbGFtZW4uZGltaXRyb3ZAcGV2b2dhbS5jb20+IHdyb3RlOg0KDQo+
IEhpIGFsbCwNCj4gDQo+IEkgaGFkIHNvbWUgcHJvYmxlbXMgd2l0aCBSVEw4ODUyQkUgYW5kIHRy
aWVkIGEgY29tbW9ubHkgc3VnZ2VzdGVkIGZpeA0KPiANCj4gJCBzdWRvIGNhdCAvZXRjL21vZHBy
b2JlLmQvMjAtd2lmaS5jb25mDQo+IG9wdGlvbnMgcnR3ODlfcGNpIGRpc2FibGVfYXNwbV9sMXNz
PXkgZGlzYWJsZV9hc3BtX2wxPXkgZGlzYWJsZV9jbGtyZXE9eQ0KPiBvcHRpb25zIHJ0dzg5X2Nv
cmUgZGlzYWJsZV9wc19tb2RlPXkNCj4gDQo+IGFzDQo+IA0KPiAkIGxzbW9kIHwgZ3JlcCBydHcN
Cj4gcnR3ODlfODg1MmJlICAgICAgICAgICAxMjI4OCAgMA0KPiBydHc4OV84ODUyYiAgICAgICAg
ICAgMzY0NTQ0ICAxIHJ0dzg5Xzg4NTJiZQ0KPiBydHc4OV9wY2kgICAgICAgICAgICAgIDgxOTIw
ICAxIHJ0dzg5Xzg4NTJiZQ0KPiBydHc4OV9jb3JlICAgICAgICAgICAgNTc3NTM2ICAyIHJ0dzg5
Xzg4NTJiLHJ0dzg5X3BjaQ0KPiBtYWM4MDIxMSAgICAgICAgICAgICAxNTY4NzY4ICAyIHJ0dzg5
X2NvcmUscnR3ODlfcGNpDQo+IGNmZzgwMjExICAgICAgICAgICAgIDEzMzUyOTYgIDMgcnR3ODlf
ODg1MmIscnR3ODlfY29yZSxtYWM4MDIxMQ0KPiANCj4gYnV0IHRoaXMgZG9lc24ndCBmaXggbXkg
aXNzdWUgd2hpY2ggbG9va3MgbGlrZQ0KPiANCj4gWyAxNzk0LjU0MjI2Nl0gcnR3ODlfODg1MmJl
IDAwMDA6MDI6MDAuMDogRlcgZG9lcyBub3QgcHJvY2VzcyBoMmMgcmVnaXN0ZXJzDQo+IFsgMTc5
NC41NDIyNjldIHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAwLjA6IEhXIHNjYW4gZmFpbGVkIHdpdGgg
c3RhdHVzOiAtMTEwDQo+IFsgMTc5NC45MzUzMjhdIHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAwLjA6
IHh0YWwgc2kgbm90IHJlYWR5KFcpOiBvZmZzZXQ9OTAgdmFsPTEwIG1hc2s9MTANCj4gWyAxNzk1
LjAwNjMyM10gcnR3ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogeHRhbCBzaSBub3QgcmVhZHkoVyk6
IG9mZnNldD05MCB2YWw9MTAgbWFzaz0xMA0KPiBbIDE3OTUuMDA2MzMwXSBydHc4OV84ODUyYmUg
MDAwMDowMjowMC4wOiBtYWMgaW5pdCBmYWlsLCByZXQ6LTExMA0KDQpUaGVzZSBsb2dzIHNhaWQg
dGhhdCBpdCBjYW4gZG93bmxvYWQgZmlybXdhcmUgc3VjY2Vzc2Z1bGx5LCBidXQgdGltZWQgb3V0
IHRvDQphc2sgZmlybXdhcmUgdG8gZG8gc2Nhbi4gSSB3b3VsZCB0cnkgbW9kdWxlIHBhcmFtZXRl
cnMgbGlrZSB5b3UgZGlkLCBidXQNCnBsZWFzZSBkbyAiY29sZCByZWJvb3QiIHRvIHRha2UgZWZm
ZWN0IHRoZSBwYXJhbWV0ZXJzLCBiZWNhdXNlIGhhcmR3YXJlDQpoYXMgYmVlbiBnb3R0ZW4gaW50
byBhYm5vcm1hbCBzdGF0ZS4gDQoNCj4gSG93ZXZlciwgdGhlIGB4dGFsIGlzIG5vdCByZWFkeWAg
c3RpbGwgYXBwZWFycyBhZnRlciByZWxvYWRpbmcgYW5kIHRoZSBkZXZpY2UgaXMgbGlrZWx5IGlu
IGEgYmFkIHN0YXRlIG9uY2UNCj4gdGhlIGVycm9yIGlzIGFscmVhZHkgZW5jb3VudGVyZWQ6DQo+
IA0KPiBbMTI4NzYuNDc4MTM5XSBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiBsb2FkZWQgZmly
bXdhcmUgcnR3ODkvcnR3ODg1MmJfZnctMS5iaW4NCj4gWzEyODc2LjQ3ODI0OV0gcnR3ODlfODg1
MmJlIDAwMDA6MDI6MDAuMDogVW5hYmxlIHRvIGNoYW5nZSBwb3dlciBzdGF0ZSBmcm9tIEQzY29s
ZCB0byBEMCwgZGV2aWNlDQo+IGluYWNjZXNzaWJsZQ0KPiBbMTI4NzYuNTI5MzI3XSBydHc4OV84
ODUyYmUgMDAwMDowMjowMC4wOiB4dGFsIHNpIG5vdCByZWFkeShSKTogb2Zmc2V0PTQxDQoNClRo
aXMgaXMgc2Vjb25kIElPIGRyaXZlciBkb2VzIHRvIHJlYWQgaGFyZHdhcmUgcmV2aXNpb24sIGJ1
dCBpbmFjY2Vzc2libGUuIA0KWW91IHNob3VsZCByZWJvb3QgdG8gcmVjb3ZlciBoYXJkd2FyZSBz
dGF0ZS4gDQoNCj4gWzEyODc2LjUyOTMzNl0gcnR3ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogbm8g
c3VpdGFibGUgZmlybXdhcmUgZm91bmQNCj4gWzEyODc2LjUyOTMzOV0gcnR3ODlfODg1MmJlIDAw
MDA6MDI6MDAuMDogZmFpbGVkIHRvIHJlY29nbml6ZSBmaXJtd2FyZQ0KPiBbMTI4NzYuNTI5MzQy
XSBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiBmYWlsZWQgdG8gc2V0dXAgY2hpcCBpbmZvcm1h
dGlvbg0KPiBbMTI4NzYuNTMwMDc0XSBydHc4OV84ODUyYmU6IHByb2JlIG9mIDAwMDA6MDI6MDAu
MCBmYWlsZWQgd2l0aCBlcnJvciAtMg0KDQoNCg0K

