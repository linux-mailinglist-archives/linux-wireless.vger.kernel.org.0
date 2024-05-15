Return-Path: <linux-wireless+bounces-7662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA18C5F80
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 05:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66221C21CE0
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 03:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7275D381B9;
	Wed, 15 May 2024 03:48:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E2F381B8
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 03:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715744899; cv=none; b=eNJJ35O613LvvptpD8kaT9ONvBlsYPr+NpyABmqDf8u/CCC/DkMXbwxRwBtBQ2qIAptJfffMmoMSl/Me64h8alAl6ishX0/naiBKomAXnyGSy3h3AFRuQwi55qsDZSyIWYiXomEqHdFfDchZUp5MddGMz+bmLpkDpXwzfILxUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715744899; c=relaxed/simple;
	bh=C4QdPb1GVIZ2rN2ZsbH93LZIU5qRyX/0Jj0sdZlpmYk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uUB2T7hOj/uU9hWXvRHiGM3jQL2xQUAZJdGdcosz4S2TDtic54OvQTmmePNY8ElB1NIGJUkxIcF5R+h6wdZGwFAt6VSxo3hLT9EqLJId7xZKxqida7FQ49U4ILl3CFSzecGxt97qrZEDQGeKxIfeVm9AUp0M+W2ITgCwF367gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44F3lrweF3633524, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (mapi.realtek.com[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44F3lrweF3633524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 11:47:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 15 May 2024 11:47:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 11:47:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 15 May 2024 11:47:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Plamen Dimitrov <plamen.dimitrov@pevogam.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller and Linux kernel 6.7.7-100.fc38.x86_64
Thread-Topic: Problems with RTL8852BE PCIe 802.11ax Wireless Network
 Controller and Linux kernel 6.7.7-100.fc38.x86_64
Thread-Index: AQHajxBK3TMYBDJJU02LKax8Cy6TM7FphqBQgAAfJYCAAAJakIALACyAgAAFKQCAAzAiAIAAJJ1AgAaECoCAATS34IAUbceAgAGQLoCAAZgtoA==
Date: Wed, 15 May 2024 03:47:53 +0000
Message-ID: <1be6ea15441542719b573cdad1ccf008@realtek.com>
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
 <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
 <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
 <efc3e8306e1b417cbb779109a4a5ff54@realtek.com>
 <94f3355c-b247-4215-a046-a39293c8d03e@pevogam.com>
 <8fa0fcfccfe14377ba053130f95b8917@realtek.com>
 <89fccaa8-af18-4192-8186-f76577694b97@pevogam.com>
 <4e6da84a3a274fcebaae86c42f80458f@realtek.com>
 <c26272e9-069a-44b0-aee5-49530c084365@pevogam.com>
 <d69ab1ccd3fd456a82ae954d25d056ba@realtek.com>
 <25c629d5-f356-4eeb-a2e2-e184f024fad0@pevogam.com>
 <23d3e142-125a-4b3f-99f6-1f85d47541f7@pevogam.com>
In-Reply-To: <23d3e142-125a-4b3f-99f6-1f85d47541f7@pevogam.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

UGxhbWVuIERpbWl0cm92IDxwbGFtZW4uZGltaXRyb3ZAcGV2b2dhbS5jb20+IHdyb3RlOg0KPiBX
aXRoIHRoZSBuZXdlc3QgRmVkb3JhIGtlcm5lbCBhbmQgZmlybXdhcmUgdmVyc2lvbiBJIHNlZSBk
aWZmZXJlbnQgZXJyb3JzOg0KPiANCj4g4pSMTWF5IDE0IDEwOjIwOjI4IHZhZ3JhbnQud2hpdGV0
cmVlIGtlcm5lbDogcnR3ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogbG9hZGVkIGZpcm13YXJlDQo+
IHJ0dzg5L3J0dzg4NTJiX2Z3LTEuYmluDQo+IOKUgg0KPiDilIJNYXkgMTQgMTA6MjA6MjggdmFn
cmFudC53aGl0ZXRyZWUga2VybmVsOiBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiBlbmFibGlu
ZyBkZXZpY2UgKDAwMDAgLT4gMDAwMykNCj4g4pSCDQo+IOKUgk1heSAxNCAxMDoyMDoyOCB2YWdy
YW50LndoaXRldHJlZSBrZXJuZWw6IHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAwLjA6IEZpcm13YXJl
IHZlcnNpb24gMC4yOS4yOS41DQo+IChkYTg3Y2NjZCksIGNtZCB2ZXJzaW9uIDAsIHR5cGUgNQ0K
PiDilIINCj4g4pSCTWF5IDE0IDEwOjIwOjI4IHZhZ3JhbnQud2hpdGV0cmVlIGtlcm5lbDogcnR3
ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogRmlybXdhcmUgdmVyc2lvbiAwLjI5LjI5LjUNCj4gKGRh
ODdjY2NkKSwgY21kIHZlcnNpb24gMCwgdHlwZSAzDQo+IOKUgg0KPiDilIJNYXkgMTQgMTA6MjA6
MjggdmFncmFudC53aGl0ZXRyZWUga2VybmVsOiBydHc4OV84ODUyYmUgMDAwMDowMjowMC4wOiBj
aGlwIHJmZV90eXBlIGlzIDENCj4g4pSCDQo+IOKUgk1heSAxNCAxMDoyMDoyOCB2YWdyYW50Lndo
aXRldHJlZSBrZXJuZWw6IHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAwLjAgd2xwMnMwOiByZW5hbWVk
IGZyb20gd2xhbjANCj4g4pSCDQo+IOKUgk1heSAxNCAxMDoyMjo0MiB2YWdyYW50LndoaXRldHJl
ZSBrZXJuZWw6IHJ0dzg5Xzg4NTJiZSAwMDAwOjAyOjAwLjA6IGZhaWxlZCB0byBwcmUtcmVsZWFz
ZSBmd2NtZA0KPiDilIINCj4g4pSCTWF5IDE0IDEwOjIyOjQyIHZhZ3JhbnQud2hpdGV0cmVlIGtl
cm5lbDogcnR3ODlfODg1MmJlIDAwMDA6MDI6MDAuMDogdGltZWQgb3V0IHRvIGZsdXNoIHBjaSB0
eGNoOiAwDQo+IOKUgg0KPiANCj4gQW55IGlkZWEgd2hhdCBjb3VsZCBnbyB3cm9uZyBoZXJlPyBJ
IGhhdmUgdHJpZWQgZGlzYWJsaW5nIHZpYSBhbGwgYmVmb3JlLW1lbnRpb25lZCBtZXRob2RzIGFu
ZCB0aGUgbmV0d29yaw0KPiBjYXJkIGNyYXNoZXMgb24gYm90aCBvbGRlcg0KPiBhbmQgbmV3ZXIg
a2VybmVscyBkZXNwaXRlIGFsbCBteSBlZmZvcnRzLg0KDQpXaGF0IGlzIHRoZSBrZXJuZWwgdmVy
c2lvbiBvZiB0aGUgbmV3ZXN0IEZlZG9yYT8gSSBjYW4gdHJ5IGl0IGluIG15IHNpZGUuDQoNCkl0
IGxvb2tzIGxpa2UgZmlybXdhcmUgZW50ZXJzIGFibm9ybWFsIHN0YXRlLCBzbyBteSBzdWdnZXN0
aW9uIGlzIHRvIGRpc2FibGUNCmFsbCBwb3dlciBzYXZlIGZ1bmN0aW9ucyB0byBjbGFyaWZ5IHRo
ZSBwcm9ibGVtcywgYnV0IGl0IHNlZW1zIGxpa2UgeW91DQpoYXZlIGRvbmUgYWxsIG9mIHRoZW0u
IA0KDQpJcyBpdCBwb3NzaWJsZSB0byByZW1vdmUgbW9kdWxlcyBmcm9tIC9saWIvbW9kdWxlcy8g
PyBUaGVuIGluc21vZCBtYW51YWxseQ0Kd2l0aCBtb2R1bGUgcGFyYW1ldGVycyB0byBkaXNhYmxl
IHBvd2VyIHNhdmUgZnVuY3Rpb25zIG9uZS1ieS1vbmU/IA0KDQpQaW5nLUtlDQoNCg0K

