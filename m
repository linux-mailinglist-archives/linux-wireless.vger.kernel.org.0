Return-Path: <linux-wireless+bounces-10166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0948C92DDA5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 03:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC3CB215D3
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 01:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8F1383;
	Thu, 11 Jul 2024 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TiJrRX5/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3436C
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660015; cv=none; b=rYaLKKOTr0MX0EleLMhI/HBzVhuYOhIbjQnVUMTZvZxGW7Q8qksE3BcKC8d+mdqPnS+e6gva/ZZ9zzB1W9zH9JHao2c27G6LHi8AlI1tCj1X3vWZdLKaeR/sIXPDIKpU73qpa1LB5rZRjTuMRFcVVbyGyts9CFyb3Rb7hTxJzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660015; c=relaxed/simple;
	bh=0lzE+6j2psl+j8Qy4ARLi2ybnb0Gkai27kGvY8nr3DM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+Dxbejq872YQJ2aHzFjm/Lf6SkahjhZw9tXa4VCO34B355+8+QLVgOpOcNGsCdtxwi/wLssXV2jHHDBuK8PuymRRN20wCJwiGaz38B+hY1QREXi33xMU8tDy7660wO5eo7ucuGs+nm+QCI6PhrxQqdLOaPFQ2E4F2tDYHllEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TiJrRX5/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46B16mqyE2704013, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720660008; bh=0lzE+6j2psl+j8Qy4ARLi2ybnb0Gkai27kGvY8nr3DM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=TiJrRX5/pVl9qQc31qAuuHrZBEBM7VyIxryF4rACHF6WNmv8vxheqPslFrY+/b+Op
	 3krv/+ZoCqVa4AkbIHt8+LOQ3u+8iCaKLdbgkFH+EovfZyyKzOFaQVzz/Q6s/152Wi
	 aK4OM69rjkgVxGGxHTiyWqg7rfqftJZe5Vg3pz6lBrsc4gurkUFHC7/gg/Cuk87vOy
	 cgaQweXfSFwZSaGxuvUkZETtGll9PKOw0B14VUs0YhrCSz/a4jOJrQicY5lm1hH/hp
	 Q3+YNlB17GCexrAdDPZej8WoW5b8yhM76dbJ2Iuv0BmipZSr/puDg8CDPD9ZHHPpeR
	 aLswiW47OXukQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46B16mqyE2704013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 09:06:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 09:06:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jul 2024 09:06:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 11 Jul 2024 09:06:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Nick Morrow <morrownr@gmail.com>
Subject: RE: [PATCH] wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c
Thread-Topic: [PATCH] wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c
Thread-Index: AQHa0xaJriJw8Pz+LU29WxMBivw6BbHwtqYA
Date: Thu, 11 Jul 2024 01:06:48 +0000
Message-ID: <f3664fcc4e5c4d249f572aac00457ab8@realtek.com>
References: <335d7fa1-0ba5-4b86-bba5-f98834ace1f8@gmail.com>
In-Reply-To: <335d7fa1-0ba5-4b86-bba5-f98834ace1f8@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
RnJvbTogTmljayBNb3Jyb3cgPG1vcnJvd25yQGdtYWlsLmNvbT4NCj4gDQo+IFJlbW92ZSBWSUQv
UElEIDBiZGE6YzgyYyBhcyBpdCB3YXMgaW5hZHZlcnRlbnRseSBhZGRlZCB0byB0aGUgZGV2aWNl
DQo+IGxpc3QgaW4gZHJpdmVyIHJ0dzg4MjFjdS4gVGhpcyBWSUQvUElEIGlzIGZvciB0aGUgcnR3
ODgyMmN1IGRldmljZQ0KPiBhbmQgaXQgaXMgYWxyZWFkeSBpbiB0aGUgYXBwcm9wcmlhdGUgcGxh
Y2UgZm9yIHRoYXQgZGV2aWNlLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U2lnbmVkLW9mZi1ieTogTmljayBNb3Jyb3cgPG1vcnJvd25yQGdtYWlsLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFj
a2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KPiAtLS0NCj4gIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgyMWN1LmMgfCAyIC0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFjdS5jDQo+IGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIxY3UuYw0KPiBpbmRleCBlMmM3ZDlmODc2ODMu
LmEwMTlmNDA4NWU3MyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OC9ydHc4ODIxY3UuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L3J0dzg4MjFjdS5jDQo+IEBAIC0zMSw4ICszMSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgdXNiX2RldmljZV9pZCBydHdfODgyMWN1X2lkX3RhYmxlW10gPSB7DQo+ICAgICAgICAgICAu
ZHJpdmVyX2luZm8gPSAoa2VybmVsX3Vsb25nX3QpJihydHc4ODIxY19od19zcGVjKSB9LA0KPiAg
ICAgICAgIHsgVVNCX0RFVklDRV9BTkRfSU5URVJGQUNFX0lORk8oUlRXX1VTQl9WRU5ET1JfSURf
UkVBTFRFSywgMHhjODJiLCAweGZmLCAweGZmLCAweGZmKSwNCj4gICAgICAgICAgIC5kcml2ZXJf
aW5mbyA9IChrZXJuZWxfdWxvbmdfdCkmKHJ0dzg4MjFjX2h3X3NwZWMpIH0sDQo+IC0gICAgICAg
eyBVU0JfREVWSUNFX0FORF9JTlRFUkZBQ0VfSU5GTyhSVFdfVVNCX1ZFTkRPUl9JRF9SRUFMVEVL
LCAweGM4MmMsIDB4ZmYsIDB4ZmYsIDB4ZmYpLA0KPiAtICAgICAgICAgLmRyaXZlcl9pbmZvID0g
KGtlcm5lbF91bG9uZ190KSYocnR3ODgyMWNfaHdfc3BlYykgfSwNCg0KQ2hlY2tlZCBpbnRlcm5h
bCBVU0IgSUQgdGFibGVzLiBJbmRlZWQgdGhpcyBpcyBSVEw4ODIyQ1UuDQoNCj4gICAgICAgICB7
IFVTQl9ERVZJQ0VfQU5EX0lOVEVSRkFDRV9JTkZPKDB4MjAwMSwgMHgzMzFkLCAweGZmLCAweGZm
LCAweGZmKSwNCj4gICAgICAgICAgIC5kcml2ZXJfaW5mbyA9IChrZXJuZWxfdWxvbmdfdCkmKHJ0
dzg4MjFjX2h3X3NwZWMpIH0sIC8qIEQtTGluayAqLw0KPiAgICAgICAgIHsgVVNCX0RFVklDRV9B
TkRfSU5URVJGQUNFX0lORk8oMHg3MzkyLCAweGM4MTEsIDB4ZmYsIDB4ZmYsIDB4ZmYpLA0KPiAt
LQ0KPiAyLjQ1LjINCg0K

