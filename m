Return-Path: <linux-wireless+bounces-6701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC808ADC06
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 04:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797A11F21B6A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 02:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49317BD2;
	Tue, 23 Apr 2024 02:49:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D01095B
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 02:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713840582; cv=none; b=czwLWCfEKimV92wjOMHrIHhcyc2NruIrPPF1ZiVXfwfKrMgvyZnNlS0Wyu+kOVC4JY35n0NCYOJUXBGQCTwAUWLNDRCUSya8T8EBZi5PBd+aFSD8YpjLNHQn+W3zJywPIHiHeyr8OqrpUV+khCMIPWUnO38nmqPSGoYKimPVWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713840582; c=relaxed/simple;
	bh=v4XjahJMgFqcIg9VBQOImzczC8A4iHwriJZVnT9RzYs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MckCC9fwdXfFHcsoJAlbPf+uZFJmcPZ1Y2QoQp82iMZx98OaPP/80Z35I6nu+0KSKHWduvzRT/T3ReJy4bznFryxqJrkmaV9dAHTqTjOe8kurx+jZ5WoVSdLQjSiW+3EOXuphwiHprZuJ+Xie0sHp4dhIzhGmzBhvYAp2eOBXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43N2nOY71749488, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43N2nOY71749488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 10:49:25 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 10:49:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 10:49:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 23 Apr 2024 10:49:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Plamen Dimitrov <plamen.dimitrov@pevogam.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Problems with RTL8852BE PCIe 802.11ax Wireless Network Controller and Linux kernel 6.7.7-100.fc38.x86_64
Thread-Topic: Problems with RTL8852BE PCIe 802.11ax Wireless Network
 Controller and Linux kernel 6.7.7-100.fc38.x86_64
Thread-Index: AQHajxBK3TMYBDJJU02LKax8Cy6TM7FphqBQgAAfJYCAAAJakIALACyAgAAFKQA=
Date: Tue, 23 Apr 2024 02:49:24 +0000
Message-ID: <8fa0fcfccfe14377ba053130f95b8917@realtek.com>
References: <7833fd15-5875-40b8-a20b-a68fa92f814f@pevogam.com>
 <2e67ec1dfc8b420bab05dc025c7c59cf@realtek.com>
 <f8e3d8c6-11ef-4dff-8c4e-d10e8a4006aa@pevogam.com>
 <efc3e8306e1b417cbb779109a4a5ff54@realtek.com>
 <94f3355c-b247-4215-a046-a39293c8d03e@pevogam.com>
In-Reply-To: <94f3355c-b247-4215-a046-a39293c8d03e@pevogam.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

UGxhbWVuIERpbWl0cm92IDxwbGFtZW4uZGltaXRyb3ZAcGV2b2dhbS5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gQW5vdGhlciB0cnkgaXMgdG8gZGlzYWJsZSBwb3dlciBzYXZlIGJ5ICdpdycgY29tbWFu
ZCByaWdodCBhZnRlciBib290aW5nLCBsaWtlDQo+ID4gICAgc3VkbyBpdyB3bGFuMCBzZXQgcG93
ZXJfc2F2ZSBvZmYNCj4gDQo+IEkgaGFkIHRvIHRha2UgYSB3aGlsZSB0byBtYWtlIHN1cmUgdGhh
dCB0aGlzIGluZGVlZCB3b3JrZWQgYW5kIHNvIGZhciBpdCB0b29rIHNvbWUgZGF5cyB3aXRob3V0
IGFueSBmYWlsdXJlDQo+IHdoaWNoIG1ha2VzIG1lIGd1ZXNzIHRoYXQgdGhpcyBoYXMgYWN0dWFs
bHkgaGVscGVkLiBJIGV2ZW4gdHJpZWQgcmVib290aW5nIGFnYWluIGFuZCB0aGUgcHJvYmxlbSBp
cyBzdGlsbA0KPiBsaWtlbHkgZml4ZWQuIEkgd2lsbCBtb25pdG9yIHRoZSBzaXR1YXRpb24gYnV0
IGZvciB0aGUgc2FrZSBvZiBzdXN0YWluYWJsZSBzb2x1dGlvbiwgSSBndWVzcyB0aGUgYWJvdmUN
Cj4gZG9lcyBzZXQgYSBzZXR0aW5nIHRoYXQgd2UgY291bGQgbm90IHNldCBpbiBhbnkgb3RoZXIg
d2F5PyBJdCBzZWVtcyB0byB3b3JrIGFuZCB0aGF0J3MgZ3JlYXQsIEkganVzdCB3b25kZXINCj4g
aWYgcnVubmluZyBgc3VkbyBpdyB3bGFuMCBzZXQgcG93ZXJfc2F2ZSBvZmZgIHVwb24gZWFjaCBy
ZWJvb3Qgb3Iga2VybmVsIHVwZGF0ZSBjYW4gYmUgcmVwbGFjZWQgd2l0aCBzb21ldGhpbmcNCj4g
bW9yZSBsb25nIGxhc3RpbmcuDQo+IA0KDQpJZiB5b3UgdXNlIG5ldHdvcmsgbWFuYWdlciBhcyBX
aUZpIGNvbnRyb2xsZXIsIHNldCAnd2lmaS5wb3dlcnNhdmUgPSAyJyBpbiBjb25maWcgZmlsZSBb
MV0uDQoNClsxXSBodHRwczovL2dpc3QuZ2l0aHViLmNvbS9qY2JlcnRob24vZWE4Y2ZlMjc4OTk4
OTY4YmE3YzVhOTUzNDRiYzhiNTUNCg0K

