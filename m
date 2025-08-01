Return-Path: <linux-wireless+bounces-26073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A74DB17AA1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 02:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4751C26DA7
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 00:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B3125B9;
	Fri,  1 Aug 2025 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OqUM4xzS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F13C17;
	Fri,  1 Aug 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008274; cv=none; b=FQnq96GJ5Dm2VCvDDlxnkDYJor+QHEqEUpqRJjZSHdXM/Axb3MjIJJEyrATadLgNpC6M8TdWK6tU96dMs3TSgYbp4Tii0QpwSh6M4e7JieT9RYkuMQmFr+yXKQsCMYsoMZS27DTy2x08GXrlcerO15vya3iz79Vaiibr6SP9qI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008274; c=relaxed/simple;
	bh=MAE9cI/aOaHi3yH0MZjhKnadnNPNOZC99udhYkmkq6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jULz9JEVK+h/ZCfe9cm4+JhXf7Oi/gUXoui5nvOG34191Q/vccWKXn1SErRlmg2AlARl1XDb8xz4fnOyZp6cN5qij/NLzIVKwdCfEKcwsUUpdC1Gm5nTtZgd0Z/yxVWUylA6SX7TFs6AP1mnIdT4HAjpVDksNDfMEP9SskrjlLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OqUM4xzS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5710UpxwE2040572, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754008251; bh=MAE9cI/aOaHi3yH0MZjhKnadnNPNOZC99udhYkmkq6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OqUM4xzSk+lBHzKOBRFzJfOEYKJ6VkBzteoV60BuuFqj2S+RHzP/H/fPh0Jh2+/Uy
	 DeuOFvgd5QSvVnSn7BIUQ/zlf49CGH14aJtQ+WntUTAJqtPVKAHiLOV0ZmhHAXOgZt
	 m5cw1y0Xa4qYQXTW6HKuzlyvGug3w7FQ55XmZ2E4ELKxdTRGKURruVslWlDdmtEAee
	 q0LOABfqNIlGQXW7tWBGx/fxLL5y166Znt9Lxn0QnSr0a/ujlKWBmBJ4JFxXntXmyk
	 jeBocuxSXCEPR0kA3+7oYyRVZgp4s8mlp2TzBtOIBdCl9KMt6Sh5uj4is8qrjsbEVT
	 vdPiYq0gnHMcg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5710UpxwE2040572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 08:30:51 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 08:30:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Aug 2025 08:30:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Fri, 1 Aug 2025 08:30:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sean Anderson <sean.anderson@linux.dev>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bitterblue
 Smith" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Thread-Topic: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
Thread-Index: AQHcANxb3F/NWj2ltUS/9AXHQ44SQ7RJzkeggAJapQCAAMhRwA==
Date: Fri, 1 Aug 2025 00:30:51 +0000
Message-ID: <d0f6162ab34440cab0c11667be092609@realtek.com>
References: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
 <20250729204437.164320-1-sean.anderson@linux.dev>
 <c034d5cc40784bfa859f918806c567de@realtek.com>
 <7865d95f-a92e-405d-bc71-f1e1382ad24c@linux.dev>
In-Reply-To: <7865d95f-a92e-405d-bc71-f1e1382ad24c@linux.dev>
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

U2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+IHdyb3RlOg0KPiBPbiA3LzI5
LzI1IDIwOjM2LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gU2VhbiBBbmRlcnNvbiA8c2Vhbi5h
bmRlcnNvbkBsaW51eC5kZXY+IHdyb3RlOg0KPiA+PiBUaGVyZSBhcmUgbW9yZSB1bnN1cHBvcnRl
ZCBmdW5jdGlvbnMgdGhhbiBqdXN0IExPV1JUX1JUWS4gSW1wcm92ZSBvbg0KPiA+PiBjb21taXQg
M2I2NjUxOWIwMjNiICgid2lmaTogcnR3ODk6IHBoeTogYWRkIGR1bW15IGMyaCBoYW5kbGVyIHRv
IGF2b2lkDQo+ID4+IHdhcm5pbmcgbWVzc2FnZSIpIGJ5IHByaW50aW5nIGEgbWVzc2FnZSBqdXN0
IG9uY2Ugd2hlbiB3ZSBmaXJzdA0KPiA+PiBlbmNvdW50ZXIgYW4gdW5zdXBwb3J0ZWQgY2xhc3Mu
DQo+ID4NCj4gPiBPbmNlIEkgZW5jb3VudGVyIGFuIHVuc3VwcG9ydGVkIGNsYXNzL2Z1bmMsIEkn
bGwgY2hlY2sgZmlybXdhcmUgdGVhbSBpZiB0aGUNCj4gPiBDMkggZXZlbnRzIGNhbiBiZSBpZ25v
cmVkLiBJZiBzbywgSSBhZGQgYSBkdW1teSBmdW5jdGlvbiB0byBhdm9pZCB0aGUgbWVzc2FnZS4N
Cj4gPiBJZiBub3QsIEkgc2hvdWxkIGFkZCBjb2RlIHRvIGhhbmRsZSB0aGUgZXZlbnQuDQo+ID4N
Cj4gPiBEbyB5b3Ugd2FudCB0byBzZWUgdGhlIG1lc3NhZ2UgZXZlbiB0aG91Z2ggaXQgb25seSBh
cHBlYXJzIG9uY2U/DQo+IA0KPiBJIG1lYW4sIG1heWJlIGl0IHNob3VsZCBqdXN0IGJlIGEgZGVi
dWc/IEFyZSB0aGVzZSBtZXNzYWdlcyB1c2VmdWwgZm9yIGFueW9uZQ0KPiBvdGhlciB0aGFuIHRo
ZSBkZXZlbG9wZXJzPw0KDQpZZXMsIHRoaXMgY291bGQganVzdCBiZSBhIGRlYnVnLiBIb3dldmVy
LCBkZXZlbG9wZXJzIG5vcm1hbGx5IGRvbid0IHR1cm4gb24NCmRlYnVnIG1hc2ssIHNvIHVzaW5n
IHJ0dzg5X2luZm8gaXMgdG8gY2xlYXJseSByZW1pbmQgZGV2ZWxvcGVycyB0byBwYXkNCmF0dGVu
dGlvbiBvbiB0aGlzIGxhY2sgb2YgQzJIIGhhbmRsZXIuIEFuZCwgSSBzdXBwb3NlIGRldmVsb3Bl
cnMgbXVzdCBoYW5kbGUNCnRoaXMgd2hlbiB0aGV5IHNlZSBmbG9vZGluZyBtZXNzYWdlcy4NCg0K
PiANCj4gTWF5YmUgd2Ugc2hvdWxkIGp1c3QgcHJpbnQgb25seSB0aGUgdmVyeSBmaXJzdCB1bnN1
cHBvcnRlZCBtZXNzYWdlIGF0IGluZm8gbGV2ZWwNCj4gYW5kIHByaW50IHRoZSByZXN0IGF0IGRl
YnVnLg0KDQpJJ20gYWZyYWlkIGRldmVsb3BlcnMgd2lsbCBpZ25vcmUgb3IgbWlzcyB0aGUgbWVz
c2FnZXMuIFRvIHJlZHVjZSBtZXNzYWdlcw0KaXMgZmluZSB0byBtZSAsIGJ1dCBtb3JlIGltcG9y
dGFudCBpcyB0byBsb29rIHVwIHZlbmRvciBkcml2ZXIgdG8gc2VlIGlmDQp0aGUgQzJIIGhhbmRs
ZXIgaXMgbmVjZXNzYXJ5LiANCg0KDQo=

