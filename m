Return-Path: <linux-wireless+bounces-18902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000CEA33942
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 08:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EDD163699
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 07:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D1420A5CE;
	Thu, 13 Feb 2025 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HjyosoIS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE420ADEE
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433179; cv=none; b=FzJriotI127+F6gn42BAGRiXwVk6739vp2MTSJPJEZeEtLE/+J9UiwQNwRabA6gXm4O69unF+uXoMkP5h3QhPZfSMJ21Vrg/XVeiQ1jVlkFqKI0VUIdxA2KOfssCzhQoNTi7lBg8tCso77v0wMDsP/9Gd19t1iNERpL96rrifco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433179; c=relaxed/simple;
	bh=Trw9eLRK1xX9EabdLkAseEkY41QFbZzQSPr7tBqLrlw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KE7+FiR2e/gF9hNjLbL7snA5EbId5Ng1r3EhkyLpup2v837MibTjbbpo531PDosdscJtfD2IXfGDdgNlEtG+SN0T83d2xaeCFFi8EyDoqs9AmJkSQVKRl+5/WerAK9HggHN4s5bX33SjcP/LR98VkMSc0M5h7m5aUFkDzvy8d5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HjyosoIS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D7qrCK3606770, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739433173; bh=Trw9eLRK1xX9EabdLkAseEkY41QFbZzQSPr7tBqLrlw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HjyosoIS1MoylSh3NLN6SiomjjqhNctQ10kDgQ9UtyxSJj8pSNwZvUZ/3Wer0KvW+
	 hM4VW9YbvKpntkLrJRQ+yGNm/ilxdw8S3mldHqAd7caLNrwd77Bg0zhNpHzCs4bUG3
	 w9rGNViw+Bu/maO/DCU9GYPKS8ZPY3PpxSvT/IQPWGZjlqBDTr3NbaDjZQjMbibskV
	 zhIddRhbDPfdHC4e6RzQrIqsLVy/sLaAUJYfmsxe6B1ss9OrDH9Y4EB1rh8Kw9QKfb
	 daQtIjT8c/00nmccOS9/92CVOtxEdVaLYMOJ04puDhONYFY10d6+ssbr5uha+ZIfHq
	 e7qxxS82wM76w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D7qrCK3606770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:52:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 15:52:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 15:52:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 15:52:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 8/8] wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for RTL8814AU
Thread-Topic: [PATCH 8/8] wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for
 RTL8814AU
Thread-Index: AQHbfNP5mEqFMJ6V6UiVannJwDhUzrNE3jdA
Date: Thu, 13 Feb 2025 07:52:52 +0000
Message-ID: <b4001e93119b4f9cafa9b02dd328ff71@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <6bb6443a-3e2a-4cd4-83b9-34d2eb235654@gmail.com>
In-Reply-To: <6bb6443a-3e2a-4cd4-83b9-34d2eb235654@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBNYWtl
IGl0IHByaW50IHRoZSBUWCBwb3dlciBkZXRhaWxzIGZvciBSRiBwYXRocyBDIGFuZCBELCBhbmQg
Zm9yIDNTUyBhbmQNCj4gNFNTIHJhdGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1
ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OC9kZWJ1Zy5jIHwgMTAgKystLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2RlYnVnLmMgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L2RlYnVnLmMNCj4gaW5kZXggMWFkYjAzZDEyMTBh
Li4wZWZiNWMxOWI5MGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvZGVidWcuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L2RlYnVnLmMNCj4gQEAgLTcwOCwyMCArNzA4LDE0IEBAIHN0YXRpYyBpbnQgcnR3X2RlYnVn
ZnNfZ2V0X3R4X3B3cl90Ymwoc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KQ0KPiAgICAgICAg
ICAgICAgICAgICAgInBhdGgiLCAicmF0ZSIsICJwd3IiLCAiYmFzZSIsICJieXIiLCAibG10Iiwg
InNhciIsICJyZW0iKTsNCj4gDQo+ICAgICAgICAgbXV0ZXhfbG9jaygmaGFsLT50eF9wb3dlcl9t
dXRleCk7DQo+IC0gICAgICAgZm9yIChwYXRoID0gUkZfUEFUSF9BOyBwYXRoIDw9IFJGX1BBVEhf
QjsgcGF0aCsrKSB7DQo+ICsgICAgICAgZm9yIChwYXRoID0gUkZfUEFUSF9BOyBwYXRoIDw9IFJG
X1BBVEhfRDsgcGF0aCsrKSB7DQoNCkNhbiB3ZSBsaW1pdCBwYXRoIGFuZCByYXRlIGJ5IGVmdXNl
LT5od19jYXAubnNzIG9yIHJmX3BhdGg/DQpPbmx5IHNob3dpbmcgdHdvIHBhdGhzIGFuZCAyU1Mg
cmF0ZSBmb3IgMlNTIGNoaXBzIHdvdWxkIGF2b2lkIGNvbmZ1c2luZy4gDQoNCj4gICAgICAgICAg
ICAgICAgIC8qIHRoZXJlIGlzIG5vIENDSyByYXRlcyB1c2VkIGluIDVHICovDQo+ICAgICAgICAg
ICAgICAgICBpZiAoaGFsLT5jdXJyZW50X2JhbmRfdHlwZSA9PSBSVFdfQkFORF81RykNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgcmF0ZSA9IERFU0NfUkFURTZNOw0KPiAgICAgICAgICAgICAg
ICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICByYXRlID0gREVTQ19SQVRFMU07DQo+
IA0KPiAtICAgICAgICAgICAgICAgLyogbm93LCBub3Qgc3VwcG9ydCB2aHQgM3NzIGFuZCB2aHQg
NHNzKi8NCj4gLSAgICAgICAgICAgICAgIGZvciAoOyByYXRlIDw9IERFU0NfUkFURVZIVDJTU19N
Q1M5OyByYXRlKyspIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgLyogbm93LCBub3Qgc3Vw
cG9ydCBodCAzc3MgYW5kIGh0IDRzcyovDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmIChy
YXRlID4gREVTQ19SQVRFTUNTMTUgJiYNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIHJh
dGUgPCBERVNDX1JBVEVWSFQxU1NfTUNTMCkNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb250aW51ZTsNCj4gLQ0KPiArICAgICAgICAgICAgICAgZm9yICg7IHJhdGUgPD0gREVT
Q19SQVRFVkhUNFNTX01DUzk7IHJhdGUrKykgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBy
dHdfZ2V0X3R4X3Bvd2VyX3BhcmFtcyhydHdkZXYsIHBhdGgsIHJhdGUsIGJ3LA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaCwgcmVnZCwgJnB3cl9w
YXJhbSk7DQo+IA0KPiAtLQ0KPiAyLjQ4LjENCg0K

