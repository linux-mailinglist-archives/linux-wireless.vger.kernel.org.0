Return-Path: <linux-wireless+bounces-8826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE16E904882
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 03:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE851C22DEC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 01:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55318443D;
	Wed, 12 Jun 2024 01:47:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C44411
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718156849; cv=none; b=qmmLl2YIpAtnr3YmSK1tUjyv7ZyBuK+JMUezcwHUOrQqfc07ktulleN3NQd/Rqbv9e1SDJ7RdVDcGxVya80YPEljZOSWV/79xzMKFkNeaE8D3gkTubJiTgryDFx19J+HRaE7S3cGahzpdLKuCFbVk/tB2xcuE9PBxnJzkglAzd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718156849; c=relaxed/simple;
	bh=H53/ziRtrxIGFZZPCjaopZ27gotUJXebw/amhgyHGV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JgP6sVCTmp4PvoC/uq1y2E/6E8GHhqNz+Bf7lbB3DJnudGpd/AHlko+vjKuejWmuxWSAoWb1j5VNaTJWH8OzDIYDJmNh6T0sHB5ssH4+t9h4wQv4BtR2lCu4Vc3qB4mMtNggNiGdi4NENHinyueYsqTaDi0jqEF2ixBtx/+QyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45C1l6gnD707451, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45C1l6gnD707451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 09:47:06 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 09:47:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Jun 2024 09:47:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 12 Jun 2024 09:47:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: ETIMEDOUT with rtl8xxxu
Thread-Topic: ETIMEDOUT with rtl8xxxu
Thread-Index: AQHavBeewfDAlF+mGE2BLrsEzZ8n8LHDWIfg
Date: Wed, 12 Jun 2024 01:47:06 +0000
Message-ID: <1385519564244924a1101770344544a0@realtek.com>
References: <ee08c815-9389-4277-be6d-197511636892@linutronix.de>
In-Reply-To: <ee08c815-9389-4277-be6d-197511636892@linutronix.de>
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

TWFydGluIEthaXN0cmEgPG1hcnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiBI
aSBQaW5nLUtlLCBoaSBCaXR0ZXJibHVlLA0KPiANCj4gSSBoYXZlIGEgcHJvYmxlbSB3aXRoIHRo
ZSBydGw4eHh4dSBkcml2ZXIgYW5kIDgxODhmLCBidXQgb25seSBvbiBzb21lIGJvYXJkcy4NCj4g
TW9yZSBzcGVjaWZpY2FsbHksIEkgY2FuIHNlZSB0aGF0IGR1cmluZyB0aGUgc2Vjb25kIGNoYW5u
ZWwgc3dpdGNoICh3aGljaA0KPiBoYXBwZW5zIHdoZW4gSSBkbyAiaXcgZGV2IHdsYW4wIHNjYW4i
KSwgIHRoZSBydGw4eHh4dV9yZWFkMzIoMGUwOCkgcmV0dXJucyAtMTEwDQo+IChFVElNRURPVVQp
IGFuZCBhZnRlciB0aGF0IG5vIHJlYWRzIG9yIHdyaXRlcyB3b3JrIGFueW1vcmUgdW50aWwgSSB1
bmxvYWQgYW5kDQo+IHJlbG9hZCB0aGUgZHJpdmVyLg0KDQpJZiB0aGlzIHN5bXB0b20gaXMgMTAw
JSByZXByb2R1Y2libGUsIEkgd291bGQgYWRkIG1hbnkgcnRsOHh4eHVfcmVhZDMyKDB4ZTA4KQ0K
c29tZXdoZXJlIHRvIGJpc2VjdCB0aGUgY2F1c2UgcmVzdWx0aW5nIGZyb20gd3JpdGluZyBJTyBv
ciBjZXJ0YWluIEgyQyBjb21tYW5kcy4NCg0KRXhhbXBsZSAxOg0KDQoJcnRsOHh4eHVfd3JpdGUz
MigweDEyMzQpCS8vIG9yaWdpbmFsIGNvZGUNCglydGw4eHh4dV9yZWFkMzIoMHhlMDgpCQkvLyBh
ZGQgdGhpcyB0byBzZWUgaWYgcHJvYmxlbSBlbmNvdW50ZXJzPw0KDQpFeGFtcGxlIDI6DQoJcnRs
OHh4eHVfZ2VuMl9oMmNfY21kKCkJCS8vIG9yaWdpbmFsIGNvZGUNCgltZGVsYXkoNTApCQkJCQkv
LyBhZGQgc29tZSBkZWxheSB0byB3YWl0IGZpcm13YXJlIGNvbXBsZXRlIHRoZSB3b3JrDQoJcnRs
OHh4eHVfcmVhZDMyKDB4ZTA4KQkJLy8gYWRkIHRoaXMgdG8gc2VlIGlmIHByb2JsZW0gZW5jb3Vu
dGVycz8NCg0KVGhlIGFkZHJlc3Mgb2YgMHhlMDggaXMgbm90IGFsd2F5cyBvbiwgc28geW91IHNo
b3VsZCByZWFkIGl0IGFmdGVyIHBvd2VyLW9uLg0KDQoNCg0KDQo=

