Return-Path: <linux-wireless+bounces-6143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD648A071C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 06:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77ADB2881C4
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 04:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF813B5A6;
	Thu, 11 Apr 2024 04:26:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3E13C3CF;
	Thu, 11 Apr 2024 04:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809588; cv=none; b=i76y9j65I7NDGX950UKckFgMQ9thm9YWlYM34eP0OvdUGoQ7Q8Bw0tzMDMqaaIx2H7EU9k/5DFceocdVsXAX3aaxjePOlhQ666lM8o02NLHCOTLgq1HPgn8p2ZeAoosFt+SwnRu5669sYCVhY9VbIXH7//6+7N7Gy4/V9HJ0jCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809588; c=relaxed/simple;
	bh=INoedeS1YRLb5NbBpuZ52sHt3SaQF4hIpOGhFzrppes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rQxsnKY+Yzah6MOzvRVO9b7yWER/gAtWD7QRNIRmNxmNM2vR19qaDZ8wCklnbdj5CwKMu7nN0KPF6NXMW1ArPvB5slNJGNyB2KIU4jzHeqojaI7YbeFw+aRXGh7m+dniHRZW0fL5afz33xuk0ZT4fAfhmiGt/2BcB1oPIg9/ouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43B4Ps2E2589410, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43B4Ps2E2589410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 12:25:55 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 12:25:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 12:25:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 11 Apr 2024 12:25:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Larry Finger <Larry.Finger@lwfinger.net>,
        Larry Finger
	<Larry.Finger@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART Bluetooth
Thread-Topic: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART
 Bluetooth
Thread-Index: AQHai6+3Zq0VJBVgFk2i9wweb2CUxrFiTTdQ//+KnwCAAKCeUA==
Date: Thu, 11 Apr 2024 04:25:54 +0000
Message-ID: <2afb5edcf8bf4173ab339e54707ada0b@realtek.com>
References: <4umro86wvv84.MjDfYvt4P5uZryt8boBK8Q2@1EHFQ.trk.elasticemail.com>
 <5af71338f3904aac9d2c237637c851e7@realtek.com>
 <287e9d4e-316a-4579-961e-58e75abea534@lwfinger.net>
In-Reply-To: <287e9d4e-316a-4579-961e-58e75abea534@lwfinger.net>
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

DQoNCkxhcnJ5IEZpbmdlciA8bGFycnkuZmluZ2VyQGdtYWlsLmNvbT4gd3JvdGU6DQoNCj4gDQo+
IE9uIDQvMTAvMjQgOToxMyBQTSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+DQo+ID4gTGFycnkg
RmluZ2VyIDxMYXJyeS5GaW5nZXJAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+PiArICAgICAg
IG1kZWxheSg1MDApOw0KPiA+DQo+ID4gV2lsbCBpdCBiZXR0ZXIgdG8gdXNlIHNsZWVwIGZ1bmN0
aW9uPw0KPiANCj4gTXkgdGhvdWdodHMgd2VyZSB0aGF0IGEgc2xlZXAgZnVuY3Rpb24gd291bGQg
dGllIHVwIGEgQ1BVLCB3aGVyZWFzIHRoZSBkZWxheQ0KPiB3b3VsZCBub3QuIEluaXRpYWxseSwg
d2UgdGVzdGVkIGFuIG1zbGVlcCgxNTApIHN0YXRlbWVudCwgYnV0IHRoYXQgb25seSBnYXZlIGEN
Cj4gNjAlIHN1Y2Nlc3MgcmF0ZSwgd2hlcmVhcyBtZGVsYXkoNTAwKSB3b3JrZWQgMjAgc3RyYWln
aHQgdHJpZXMuDQo+IA0KDQpTb3JyeSwgSSBkaWRuJ3QgY29uc2lkZXIgdGhlIGV4cGVyaW1lbnRh
bCByZXN1bHRzIG9mIG1zbGVlcCgxNTApIGFuZCBtZGVsYXkoNTAwKS4NCg0KTXkgcG9pbnQgd2Fz
IGJ1c3kgd2FpdGluZyBvZiBtZGVsYXkoKS4gSSBqdXN0IHdhbnQgdG8gc2F5IGlmIG1zbGVlcCg1
MDApIGlzIA0KYmV0dGVyIHRoYW4gbWRlbGF5KDUwMCkuIA0KDQoNCg==

