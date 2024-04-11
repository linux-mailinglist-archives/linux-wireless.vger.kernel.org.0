Return-Path: <linux-wireless+bounces-6137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DFA8A05C0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 04:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847291C22359
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 02:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E13C627E2;
	Thu, 11 Apr 2024 02:14:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7E9449;
	Thu, 11 Apr 2024 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712801648; cv=none; b=o/AlB9o4eIT0BEG9urfM4i24hEaDVFtTuQbRCpWvJmqfXHA9uecVIrZLu/IGTBVVZvNeOj7FaO2JLye/Tb8hm/5Oo+1kKCM2X2Cze9z5G7UmbNe6IcMRzt3sSyaVd2i5ZV1B9d9xcA0t9zUDFlqRoH3cj7jL7krWOU2yMlJ+jzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712801648; c=relaxed/simple;
	bh=oWW23wyAcY2Bs8ZA40RWyKbmkxTtK8oCZ29GSJrboE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YPmoqaBcluY25+MkFmUY01g99PWgcm1rXen644jcA5ptvtUnCnwPMAkX0ZQcKthQN69+eKlswkqiWhVB9lvmHLMiERoB8s0vLBBDIbjAS2i0KS+6IGuJfM2hb0Yx13IXf3TTObzW/jMJBAS9fSWGq8tRunPS1GHv5poNuWeGMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43B2DgG72471602, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43B2DgG72471602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 10:13:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:13:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:13:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 11 Apr 2024 10:13:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Larry Finger <Larry.Finger@gmail.com>, Kalle Valo <kvalo@kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART Bluetooth
Thread-Topic: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART
 Bluetooth
Thread-Index: AQHai6+3Zq0VJBVgFk2i9wweb2CUxrFiTTdQ
Date: Thu, 11 Apr 2024 02:13:42 +0000
Message-ID: <5af71338f3904aac9d2c237637c851e7@realtek.com>
References: <4umro86wvv84.MjDfYvt4P5uZryt8boBK8Q2@1EHFQ.trk.elasticemail.com>
In-Reply-To: <4umro86wvv84.MjDfYvt4P5uZryt8boBK8Q2@1EHFQ.trk.elasticemail.com>
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

DQpMYXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBnbWFpbC5jb20+IHdyb3RlOg0KDQo+IEFzIGRp
c2N1c3NlZCBpbiB0aGUgbGlua3MgYmVsb3csIHRoZSBTRElPIHBhcnQgb2YgUlRXODgyMUNTIGZh
aWxzIHRvDQo+IHN0YXJ0IGNvcnJlY3RseSBpZiBzdWNoIHN0YXJ0dXAgaGFwcGVucyB3aGlsZSB0
aGUgVUFSVCBwb3J0aW9uIG9mDQo+IHRoZSBjaGlwIGlzIGluaXRpYWxpemluZy4gDQoNCkkgY2hl
Y2tlZCB3aXRoIFNESU8gdGVhbSBpbnRlcm5hbGx5LCBidXQgdGhleSBkaWRuJ3QgbWVldCB0aGlz
IGNhc2UsIHNvIHdlIG1heQ0KdGFrZSB0aGlzIHdvcmthcm91bmQuDQoNClNESU8gdGVhbSB3b25k
ZXIgaWYgc29tZXRoaW5nIG90aGVyIHRoYW4gQlQgY2F1c2UgdGhpcyBmYWlsdXJlLCBhbmQgYWZ0
ZXINCnN5c3RlbSBib290cyBldmVyeXRoaW5nIHdpbGwgYmUgd2VsbC4gQ291bGQgeW91IGJvb3Qg
dGhlIHN5c3RlbSB3aXRob3V0IFdpRmkvQlQNCmRyaXZlcnMsIGJ1dCBpbnNtb2QgZHJpdmVycyBt
YW51YWxseSBhZnRlciBib290aW5nPw0KDQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3NkaW8uYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC9zZGlvLmMNCj4gaW5kZXggMGNhZTU3NDZmNTQwLi5lZWMwYWQ4NWJl
NzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rp
by5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jDQo+
IEBAIC0xMzI1LDYgKzEzMjUsMzQgQEAgaW50IHJ0d19zZGlvX3Byb2JlKHN0cnVjdCBzZGlvX2Z1
bmMgKnNkaW9fZnVuYywNCg0KWy4uLl0NCg0KPiArICAgICAgIG1kZWxheSg1MDApOw0KDQpXaWxs
IGl0IGJldHRlciB0byB1c2Ugc2xlZXAgZnVuY3Rpb24/IA0KDQoNCg==

