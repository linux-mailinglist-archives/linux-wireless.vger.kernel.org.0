Return-Path: <linux-wireless+bounces-7727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E54F8C6FF4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 03:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB16528422B
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 01:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1710E3;
	Thu, 16 May 2024 01:16:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F2A47
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822175; cv=none; b=l75srvnYIGiM8cddGsoz+NyLdYUyAdIkZfpLDv8k/dkXp1cd8ZvQEDP40/GqWJFC8BoL1xSDwm3Glmh4yOpcI5ksMJg4dC2/fenNcboqj0syLYkVQK9y8dRvetTv0UVTRbp+Px6vtapH66W7Dt8oeTgBXnhtB9ZeIjZ/tR2utls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822175; c=relaxed/simple;
	bh=Wqd7INg1Mict2fx9yLMCpM/aJae9EvHkjgr8Yh/rRJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sO9kxGi/rOquBdkSQ+zVqE0jfZ9TJJ2K93LPqZy13FDovSA3zibY3cb4NEzG/BmmhnCwnt6lVAGKZJSa0ralvMoqJuLiH6THvZHZRAiDuyAFPEoeoL2lLMFoOvSVEy+TlVQ/MZLsyO7hzxbDIl2VEiwe08tlyx+RhtYMR6q+8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44G1G5Wy8586861, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44G1G5Wy8586861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 09:16:05 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 16 May 2024 09:16:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 09:16:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 16 May 2024 09:16:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
CC: linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Problem with 8922ae
Thread-Topic: Problem with 8922ae
Thread-Index: AQHapvySFjuIGFw1t0ytdSVFqyYk5rGZA7uA//+AvACAAInFUA==
Date: Thu, 16 May 2024 01:16:05 +0000
Message-ID: <a321afd48004484cb1a598fc4f54556c@realtek.com>
References: <898f027b-bf08-4f6b-b0c7-623ca5c5f23c@lwfinger.net>
 <fec7536d76cd469e8fbc375219205d1b@realtek.com>
 <723e1eed-e706-4533-b33b-a880b9a46fd8@lwfinger.net>
In-Reply-To: <723e1eed-e706-4533-b33b-a880b9a46fd8@lwfinger.net>
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

TGFycnkgRmluZ2VyIDxsYXJyeS5maW5nZXJAZ21haWwuY29tPiB3cm90ZToNCj4gT24gNS8xNS8y
NCA3OjQwIFBNLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gTGFycnkgRmluZ2VyIDxsYXJyeS5m
aW5nZXJAZ21haWwuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4gSSBoYXZlIGJlZW4gYnVzeSB3aXRo
IHRoZSA4ODIxYXUgZHJpdmVyIGFuZCBoYWQgbm90IGRvbmUgYW55dGhpbmcgd2l0aCB0aGUNCj4g
Pj4gODkyMmFlIGRyaXZlciBpbiB0aGUgbWVhbnRpbWUuIE5vdywgSSBhbSBnZXR0aW5nIHNvbWUg
d2FyaGluZ3MgaW4gdGhlIGxvZ3M6DQo+ID4+DQo+ID4+IFRoaXMgd2FybmluZyBjYW1lIHdoaWxl
IHJ1bm5pbmcgYSBrZXJuZWwgZ2VuZXJhdGVkIGZyb20gcnR3LW5leHQgd2l0aCBjb21taXQNCj4g
Pj4gMjg4MThiNGQ4NzFiYzkzLg0KPiA+Pg0KPiA+DQo+ID4gVGhlIGxvZyBzYWlkIFNFUiBvY2N1
cnMuIEkgd2lsbCBjaGVjayB0aGlzIGludGVybmFsbHkuDQo+ID4NCj4gPiBRdWVzdGlvbjogSG93
IGZyZXF1ZW50IHlvdSBtZXQgdGhpcyB3YXJuaW5nPyBhbmQgaXMgdGhlcmUgYSBtZXRob2QgeW91
IGNhbg0KPiA+IGFsd2F5cyByZXByb2R1Y2UgdGhpcyBzeW1wdG9tPw0KPiANCj4gSSBoYXZlIGhh
ZCA0MyBvZiB0aGVtIGluIGFib3V0IDcgaG91cnMgb2YgcnVubmluZyB0aW1lLiBVbmZvcnR1bmF0
ZWx5LCBJIGRvIG5vdA0KPiBrbm93IGhvdyB0byByZXByb2R1Y2UgdGhlbS4NCj4gDQo+IEkgd2ls
bCB0cnkgdG8gYmlzZWN0IHRoZSBwcm9ibGVtIGFzIHRoZXkgd2VyZSBub3QgcHJlc2VudCBlYXJs
aWVyLg0KDQpSZWNlbnRseSB3ZSBhZGRlZCBXb1dMQU4gYW5kIEJULWNvZXhpc3RlbmNlIGZvciA4
OTIyQUUuIEkgdGhpbmsgeW91IGRpZG4ndCB1c2UNCldvV0xBTiBmZWF0dXJlcywgc28gY2F1c2Ug
bWlnaHQgYmUgQlQtY29leGlzdGVuY2UuIE1heWJlIGFub3RoZXIgdHJ5IGlzIHRvIHR1cm4NCm9m
ZiBCVCBpZiB5b3UgYXJlIHVzaW5nLiANCg0KSSB3aWxsIHNldHVwIGEgUEMgdG8gc2VlIGlmIEkg
Y2FuIHJlcHJvZHVjZSB0aGlzIHByb2JsZW0uDQoNClBpbmctS2UgDQoNCg==

