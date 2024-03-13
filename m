Return-Path: <linux-wireless+bounces-4659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47987A18C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 03:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87289282806
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 02:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3BFBE5D;
	Wed, 13 Mar 2024 02:16:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A652BA37
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710296192; cv=none; b=Icea79v6hok2cCSadVrUr3NtElyHAFYF588a7jPzX6Xjmtr4Eb/I7TthLhOBSQ0Fw5V0PLXzhFF9wHNKkqryKYKEVn0aICJDWKVbDAOIhr47YCrZRAT2IPR/NGVGXozaErRXpV4lmQ03nt1Gx34PQyhE5BlySh2fEk0bALDXLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710296192; c=relaxed/simple;
	bh=UAhJMC2wIiBSyqK/Qsj0UATcOaIRvNn5oABRd2kJbQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ktb4yta5f24IUBXa0L3wV2u+I8aGKxj/wSMKX3WLXTpGv3Txo72L3YZfXvBK1v3NmBSHMKukh/awct4fWxP96Nl8cT+i9w9fWNBpz2EpANXR5b3D2DzCXt6GL8a4vb/VN5hn1OkFhieuKyusoSd/EOhfOwwtofyZafI3UEC7kUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42D2G7ofC424948, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42D2G7ofC424948
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 10:16:07 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 10:16:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 10:16:07 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 13 Mar 2024 10:16:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
Thread-Topic: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Thread-Index: AQHadMtD5PbM3LC0pEyBntnmuPy2drE0aNkA
Date: Wed, 13 Mar 2024 02:16:07 +0000
Message-ID: <27f2a0a588ed2f6c3c89fb0b60eab7d2f60f65b6.camel@realtek.com>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
In-Reply-To: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDDB2A42986BC9489D161D34397D2E95@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDAwOjE4ICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gQ3JlYXRlIHRoZSBuZXcgbW9kdWxlIHJ0bDgxOTJkLWNvbW1vbiBhbmQgbW92ZSBz
b21lIGNvZGUgaW50byBpdCBmcm9tDQo+IHJ0bDgxOTJkZS4gTm93IHRoZSBydGw4MTkyZGUgZHJp
dmVyIChQQ0kpIGFuZCB0aGUgbmV3IHJ0bDgxOTJkdSBkcml2ZXINCj4gKFVTQikgY2FuIHNoYXJl
IHNvbWUgb2YgdGhlIGNvZGUuDQo+IA0KPiBUaGlzIGlzIG1vc3RseSB0aGUgY29kZSB0aGF0IHJl
cXVpcmVkIGxpdHRsZSBlZmZvcnQgdG8gbWFrZSBpdA0KPiBzaGFyZWFibGUuIFRoZXJlIGFyZSBh
IGZldyBtb3JlIGZ1bmN0aW9ucyB3aGljaCB0aGV5IGNvdWxkIHNoYXJlLCB3aXRoDQo+IHNvbWUg
Y2hhbmdlcy4NCj4gDQo+IFRoZSBvbmx5IG90aGVyIGNoYW5nZXMgaW4gdGhpcyBwYXRjaCBzaG91
bGQgYmUgYWRqdXN0aW5nIHdoaXRlc3BhY2UgYW5kDQo+IHJlbmFtaW5nIHNvbWUgZnVuY3Rpb25z
Lg0KDQpQbGVhc2UgcnVuIGNoZWNrcGF0Y2gucGwgdGhhdCByZXBvcnRzIA0KICAgInRvdGFsOiA1
IGVycm9ycywgMjAgd2FybmluZ3MsIDY3IGNoZWNrcywgOTM4OCBsaW5lcyBjaGVja2VkIg0KDQpJ
IGtub3cgeW91IGp1c3QgbW92ZSB0aGVtIGZyb20gYSBwbGFjZSB0byBhbm90aGVyLCBidXQgbGV0
J3MgZml4IHRoZW0NCndoZW4gdG91Y2hpbmcuIA0KDQoNClR3byB1bnVzZWQgd2FybmluZ3Mgb24g
Y2hhbm5lbF9hbGwgYW5kIA0KcnRsOTJkX2RtX2NoZWNrX3R4cG93ZXJfdHJhY2tpbmdfdGhlcm1h
bF9tZXRlciAoeW91IGFsc28gcG9pbnRlZCBpdCBvdXQpDQoNClBpbmctS2UgDQoNCg0K

