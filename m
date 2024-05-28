Return-Path: <linux-wireless+bounces-8155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467218D131A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 05:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8B91F230BA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 03:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED64310A35;
	Tue, 28 May 2024 03:56:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AF62905
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868590; cv=none; b=tjspvM+95I3xeToreMdzaZGxJdX7agNuyl5tnwIM0ChSD2Kuvo+2W+W5iQzapuc5IwuSDWpVgURmXulNWEECTM8/hXrodiWmIWVXSg987lfNA+IU+GNDChW7MO8Lh9aKPGDpeuiBBElG/ReLRLB1b8Jo3LME8gfP2G9DR2Cjdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868590; c=relaxed/simple;
	bh=aDC0Z8Pa3dcCrF3E0JxnGAdo2wfXrRpM5iLZuGO/njE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSfMmMyYHe3t1Q01yRoQb8MLJw700fvt8KtcWaRjUr4yF/RVvrr8FAmdu4DhKLmhzXu9IStL38JDdBRYH008WnqXbi16lRrIICFSchNWcoD9XOiOVQuaZ/PU+EwcNFmmlaZuwP+G2MqnnLaktO5Zkbja5eTM74kKzRcQUzj0edc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44S3u6W911941955, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44S3u6W911941955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 11:56:06 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 11:56:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 May 2024 11:56:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 28 May 2024 11:56:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtw88: use RTW_FLAG_RUNNING for deciding whether to enter/leave IPS
Thread-Topic: [PATCH 1/2] wifi: rtw88: use RTW_FLAG_RUNNING for deciding
 whether to enter/leave IPS
Thread-Index: AQHasFxCrK4foviClUaRROae15ov4rGsBFLg
Date: Tue, 28 May 2024 03:56:06 +0000
Message-ID: <7427b534f5e64abf8a31a80082d4b6e1@realtek.com>
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
 <20240527173454.459264-2-marcin.slusarz@gmail.com>
In-Reply-To: <20240527173454.459264-2-marcin.slusarz@gmail.com>
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

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOg0KPiBGcm9t
OiBNYXJjaW4gxZpsdXNhcnogPG1zbHVzYXJ6QHJlbmF1LmNvbT4NCj4gDQo+IE5lZWRlZCBieSB0
aGUgbmV4dCBwYXRjaCB0aGF0IGRpc2FibGVzIHBvd2VyIG9mZiBvcGVyYXRpb24gZm9yIG9uZSBj
aGlwLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFyY2luIMWabHVzYXJ6IDxtc2x1c2FyekByZW5h
dS5jb20+DQo+IENjOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gQ2M6IExh
cnJ5IEZpbmdlciA8TGFycnkuRmluZ2VyQGx3ZmluZ2VyLm5ldD4NCj4gQ2M6IEthbGxlIFZhbG8g
PGt2YWxvQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcN
Cj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BzLmMgfCA0ICsr
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9wcy5j
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9wcy5jDQo+IGluZGV4IGFkZDVh
MjBiODQzMi4uZjlmYmM5YjMxNzRiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3BzLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OC9wcy5jDQo+IEBAIC0yNiw3ICsyNiw3IEBAIHN0YXRpYyBpbnQgcnR3X2lwc19wd3Jf
dXAoc3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCj4gDQo+ICBpbnQgcnR3X2VudGVyX2lwcyhzdHJ1
Y3QgcnR3X2RldiAqcnR3ZGV2KQ0KPiAgew0KPiAtICAgICAgIGlmICghdGVzdF9iaXQoUlRXX0ZM
QUdfUE9XRVJPTiwgcnR3ZGV2LT5mbGFncykpDQo+ICsgICAgICAgaWYgKCF0ZXN0X2JpdChSVFdf
RkxBR19SVU5OSU5HLCBydHdkZXYtPmZsYWdzKSkNCg0KUlRXX0ZMQUdfUE9XRVJPTiBpcyB0byBt
YWludGFpbiBwb3dlciBzdGF0ZSAoaS5lLiBpcHMpIG9mIFdpRmkgY2FyZCwgYW5kDQpwcmV2ZW50
IGVudGVyaW5nL2xlYXZpbmcgSVBTIHR3aWNlIHN1ZGRlbmx5LiBDaGFuZ2luZyB0aGlzIGlzIGNv
bmZ1c2VkIHRvIG1lLiANCg0KDQo=

