Return-Path: <linux-wireless+bounces-3849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F35B85D3AE
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 10:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC38B21E8C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EEB3D38E;
	Wed, 21 Feb 2024 09:29:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B63D39B
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507790; cv=none; b=mI80KVLnyxPZghcTEZq3jrsiIZzvBwSXk3hR5Iu4eW9POf+75YmBrZ1CFzrxpT/7JUlpbesZEBgVKHqjHdQLpuFGcQPov4+bjQj82zli4+Ec5pKxq+6Wj2sqtWAu/xmIu96S1w32JGfm0QBoqd1X7gT4YreRaZ8IewnM5hveT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507790; c=relaxed/simple;
	bh=yRbhSgtxX0cb52M2wvpW/Xz7JNWcQ10/v/5NIYaP8II=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QhQQwz2rvMzScrNwghn35+yaX5fM4A3Tv+8MyBdO6IpWGchQuhqpm5YPznOT8n3zZgPGXB0FW6E7KnCdH2sDutInvrUjHHv4ncxYXG65Z2O2Cr5olV1TRsrqOoeB1pX3JBaGq1rVwWCtC/3LzgYYL5XALtsYfEUGooGmUr3Smq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41L9TMmR4952996, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41L9TMmR4952996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 17:29:22 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Wed, 21 Feb 2024 17:29:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 17:29:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 21 Feb 2024 17:29:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>, "Jouni
 Malinen" <j@w1.fi>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Arend van Spriel
	<arend.vanspriel@broadcom.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: RE: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch on link basis
Thread-Topic: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Thread-Index: AQHaU4YW43ZUC/cFnUyW8JfF3/48hLD//cCAgAAEzoCABc0KgIAACpsAgAB9JYCAAPMbgIAAOXcAgAAazYCAAAqOAIAAHYkAgAACHICADMP6oP//gIoAgACISOD//3rHgIAAh5JA//98mIAAERIskP//fkyA//92ZaCAAI8dAP//d1cw
Date: Wed, 21 Feb 2024 09:29:22 +0000
Message-ID: <e0d5b3645f6d4ab79a723726f14d8bd6@realtek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
	 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
	 <5a89e63fb7644d12be72154c90c96199@realtek.com>
	 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
	 <00094ae0ca73461c88799c070ad9b55a@realtek.com>
	 <db8508eddbeb78bb59671b8c453588428e16f27b.camel@sipsolutions.net>
	 <9d3bea8152fe49278fe9804167ec8871@realtek.com>
	 <08a989730bbc456df481aee8ae278a5cd9b35f85.camel@sipsolutions.net>
	 <c0f3930196504d2080907c12864493d8@realtek.com>
	 <64d1af77e7392aa14a90273d4004dbc23a4ec8ed.camel@sipsolutions.net>
	 <abd0dbbc9d174ffbaae4e0b34d65aa06@realtek.com>
 <8c9ed8e11060274f723b88f1300b2948b889f22f.camel@sipsolutions.net>
In-Reply-To: <8c9ed8e11060274f723b88f1300b2948b889f22f.camel@sipsolutions.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgQmVyZyA8
am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAy
MSwgMjAyNCA1OjIwIFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IEFkaXR5YSBLdW1hciBTaW5naCA8cXVpY19hZGlzaUBxdWljaW5jLmNvbT4NCj4gQ2M6IGxpbnV4
LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgSmVmZiBKb2huc29uIDxxdWljX2pqb2huc29uQHF1
aWNpbmMuY29tPjsgSWxhbiBQZWVyDQo+IDxpbGFuLnBlZXJAaW50ZWwuY29tPjsgSm91bmkgTWFs
aW5lbiA8akB3MS5maT47IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT47IEFyZW5k
IHZhbiBTcHJpZWwNCj4gPGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20+OyBGZWxpeCBGaWV0
a2F1IDxuYmRAbmJkLm5hbWU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggNC81XSB3aWZpOiBt
YWM4MDIxMTogc3RhcnQgYW5kIGZpbmFsaXplIGNoYW5uZWwgc3dpdGNoIG9uIGxpbmsgYmFzaXMN
Cj4gDQo+IFlvdSBuZWVkIHRvIG5vdCBhbnN3ZXImZHJvcCBjZXJ0YWluIFAyUCBwcm9iZSByZXF1
ZXN0cyB0aG91Z2guIEJ1dCBzaW5jZQ0KPiB3ZSdyZSB0YWxraW5nIGFib3V0IHRoaXMgaW4gV2lG
aTcgQVAgY29udGV4dCwgeW91IGNvdWxkIGp1c3QgbWFrZSBpdA0KPiBkaWZmZXJlbnQgZGVwZW5k
aW5nIG9uIHRoYXQsIEkgdGhpbmsgd2UgZ2V0IHRoZSB0ZW1wbGF0ZXMgYWxsIHRoZSB0aW1lDQo+
IGluIHRoZSBrZXJuZWwgYW5kIGp1c3QgaWdub3JlIHRoZW0gaWYgbm90IGhhbmRsZWQuDQo+IA0K
DQpHb3QgaXQhIA0KDQo=

