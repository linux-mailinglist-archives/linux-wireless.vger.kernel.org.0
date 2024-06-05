Return-Path: <linux-wireless+bounces-8505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E2A8FC203
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 04:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E277B2241B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 02:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28CB6BFAA;
	Wed,  5 Jun 2024 02:49:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176410E5
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555774; cv=none; b=ioXegY2D50ARsOLJYykvVOvrUwhEF3QpQqxg9b/Y7vMWZrm+9izuqLLyveTZVV5TEekGIQCgspPWPqzWGKGm+lhFX5B0nM29SHeMF5Esj6LK8chYTWFrMsOiXBkM5SGTQqRIz5YjMvHlSqUmTh3kfmeJJpT29XQsPoIMaXG/4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555774; c=relaxed/simple;
	bh=juVlL3LzWDS51MQPIifu9lyP9C3If1SUp9C9sGwvfHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R+SHgl4J7fq9m6nfDNo12MMTrOMw/gRHCWXM7w5A3L02hC73SWba7qAPcZSODwuLFgOM2afkdyw/b47FH6c0j8WfQTTTao+DEiWveBfdN57vjrTt3mDQ7EMjHusmXqEeTXJSaqO2syx+q4Ig96Zs8rH42bGX/K09/Bn0bh/ZvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4552jkOB3959387, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4552jkOB3959387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Jun 2024 10:45:46 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 10:45:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 5 Jun 2024 10:45:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 5 Jun 2024 10:45:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "wens@kernel.org" <wens@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "wireless-regdb@lists.infradead.org" <wireless-regdb@lists.infradead.org>
Subject: RE: [PATCH 1/4] wireless-regdb: Update regulatory info for Malaysia (MY) on 6GHz
Thread-Topic: [PATCH 1/4] wireless-regdb: Update regulatory info for Malaysia
 (MY) on 6GHz
Thread-Index: AQHatXw94si8FVU9RkeM9DjvIf9y+7G21t0AgAGZUXA=
Date: Wed, 5 Jun 2024 02:45:45 +0000
Message-ID: <4e1b94e1ed9c47f09c3b6696961096b4@realtek.com>
References: <20240603060558.98791-1-pkshih@realtek.com>
 <CAGb2v64YQ4nxHV0Dk8UGTYZt88pen__bf6Y-uRi5APZTE=sFVg@mail.gmail.com>
In-Reply-To: <CAGb2v64YQ4nxHV0Dk8UGTYZt88pen__bf6Y-uRi5APZTE=sFVg@mail.gmail.com>
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

Q2hlbi1ZdSBUc2FpIDx3ZW5zQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBKdW4g
MywgMjAyNCBhdCAyOjA24oCvUE0gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdy
b3RlOg0KPiANCj4gPiAgICAgICAgICg1MjUwIC0gNTMzMCBAIDgwKSwgKDI0KSwgREZTLCBBVVRP
LUJXDQo+IA0KPiBSZWd1bGF0aW9ucyBzYXkgNTI1MCAtIDUzNTAgYXQgMVcgd2l0aCBERlMgYW5k
IFRQQyByZXF1aXJlZC4NCj4gU2luY2UgTGludXggZG9lc24ndCBoYXZlIFRQQyBzdXBwb3J0IFsx
XSwgdGhpcyBydWxlIHNob3VsZCBiZSByZW1vdmVkLg0KDQpXb3VsZCB5b3UgbGlrZSB0byBhZGQg
YW4gYXR0cmlidXRlICdUUEMnPyBCZWZvcmUgTGludXggb3IgZHJpdmVyIGRvZXNuJ3QgaGF2ZQ0K
VFBDIHN1cHBvcnQsIHdlIGRvbid0IGNvbnZlcnQgdGhpcyBlbnRyeSBpbnRvIHJlZ3VsYXRvcnku
YmluLiBBZnRlcndhcmQNCkxpbnV4IGNhbiBzdXBwb3J0IHRoaXMsIHdlIG9ubHkgbmVlZCB0byBj
aGFuZ2UgY29udmVyc2lvbiB0b29sIGluc3RlYWQgb2YNCnJlLWFkZGluZyB0aGVzZSBlbnRyaWVz
Lg0KDQo+IA0KPiA+ICAgICAgICAgKDU0OTAgLSA1NjUwIEAgMTYwKSwgKDI0KSwgREZTDQo+IA0K
PiBSZWd1bGF0aW9ucyBzYXkgNTQ3MCAtIDU2NTAgYXQgMVcgd2l0aCBERlMgYW5kIFRQQyByZXF1
aXJlZC4NCj4gU2luY2UgTGludXggZG9lc24ndCBoYXZlIFRQQyBzdXBwb3J0IFsxXSwgdGhpcyBy
dWxlIHNob3VsZCBiZSByZW1vdmVkLg0KPiANCj4gPiAgICAgICAgICg1NzM1IC0gNTgzNSBAIDgw
KSwgKDI0KQ0KPiANCj4gUmVndWxhdGlvbnMgc2F5IDU3MzUgLSA1ODc1IGF0IDFXLg0KPiANCj4g
PiArICAgICAgICg1OTI1IC0gNjQyNSBAIDMyMCksICgyMDAgbVcpLCBOTy1PVVRET09SDQo+IA0K
PiBUaGlzIHBhcnQgbG9va3MgY29ycmVjdC4NCj4gDQo+IENvdWxkIHlvdSB1cGRhdGUgeW91ciBw
YXRjaCB0byBpbmNsdWRlIHRoZXNlIGNoYW5nZXM/DQo+IE9yIHNlbmQgYSBzZXBhcmF0ZSBwYXRj
aCBmb2xsb3dpbmcgdGhpcyBvbmUgdG8gdXBkYXRlIHRoZSBleGlzdGluZyBydWxlcz8NCg0KSSBj
YW4uIEkgcGxhbiB0byBjb21iaW5lIGNoYW5nZXMgaW50byB0aGlzIHBhdGNoLiANCg0KVGhhbmtz
DQpQaW5nLUtlIA0KDQo=

