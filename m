Return-Path: <linux-wireless+bounces-18895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E17A338D8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 08:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4319516282D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EE6209F25;
	Thu, 13 Feb 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SiE2m+an"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89480208990
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431768; cv=none; b=Wxo+iM0GHIxyy1AQwWKvskwaJWCRzFcmmRSV42hBfNDrd569issfSc6DilYd1oEyeRMXwOowOk01Mh14XDim+RpwtbwCXzeMVcm8be5LLvOQ8FBI2jSgzNieV3p/OLjyB3g0Bg6TR/vlPIYlJg/1K3AjBuKwNsLQlZLGfLipgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431768; c=relaxed/simple;
	bh=rKSogPBlo2hbgalDP27uPJmSBd1JgCxfQJ6Marg/MQQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DAO/aAhe/2LHBv49n6EctSwckKOOY3H1gF+Bz1Ys94RLuTf6qbqyeD+6HEqyrQCbZXA1fa2cM0a7oQ2vvlLUaQD3gheIJSGe+r1MEF6zcPMgAwpCmeQlGR2b1d0PNRMfP+i6c6TDvtBCzcJMvymRTmjoVJX0g8U5JaVA5ZrUDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SiE2m+an; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D7TJSY0568457, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739431759; bh=rKSogPBlo2hbgalDP27uPJmSBd1JgCxfQJ6Marg/MQQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SiE2m+annNb8hKQENlB/40ruu47dGaedZ9Pm9U6cvcEznjkeTuO/r5nvQOXesnUqf
	 bWL+o/IBlBoUMNpve2Ekd/zD8W1VvTyKEogBl9MjvG35Ryfc1ZBcrVO4hpsME//iQj
	 3G05sCG/CcHkE74LA4uR0w4QybfzCS5HGBjEUU3Y1S1TzPkUP9IwsOtOlm45FClOGm
	 1VRRyx2q++ewqxLayNNDquIIxWyR4rzBeUe+WXgtHpwJqX7QCmOPpKx24BkY1WTv8N
	 fmXH1AIFGEWxdSAGEJ9MwU8T0PYvye+1W2zpmmcARX1evyseoTUJgozwHwDPs3D7Vp
	 Waq9vr+sIyvSQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D7TJSY0568457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:29:19 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 15:29:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 15:29:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 15:29:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/8] wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
Thread-Topic: [PATCH 1/8] wifi: rtw88: Fix rtw_mac_power_switch() for
 RTL8814AU
Thread-Index: AQHbfNNsqIRe2Xd+mkek0+z3sTsGILNE1+0w
Date: Thu, 13 Feb 2025 07:29:19 +0000
Message-ID: <7d83f8070d214427828e93020e5a443f@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <83c8e281-0d25-4de6-a6c7-84d24b228888@gmail.com>
In-Reply-To: <83c8e281-0d25-4de6-a6c7-84d24b228888@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBydHdf
bWFjX3Bvd2VyX3N3aXRjaCgpIGNoZWNrcyBiaXQgOCBvZiBSRUdfU1lTX1NUQVRVUzEgdG8gc2Vl
IGlmIHRoZQ0KPiBjaGlwIGlzIHBvd2VyZWQgb24uIFRoaXMgYml0IGFwcGVhcnMgdG8gYmUgYWx3
YXlzIG9uIGluIHRoZSBSVEw4ODE0QVUsDQo+IHNvIGlnbm9yZSBpdC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFjLmMgfCAzICsrLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFjLmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21hYy5jDQo+IGluZGV4IDYzZWRmNjQ2MWRl
OC4uNWRlMTZjNzVhZGYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L21hYy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgvbWFjLmMNCj4gQEAgLTI5MSw3ICsyOTEsOCBAQCBzdGF0aWMgaW50IHJ0d19tYWNfcG93ZXJf
c3dpdGNoKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIGJvb2wgcHdyX29uKQ0KPiAgICAgICAgIGlm
IChydHdfcmVhZDgocnR3ZGV2LCBSRUdfQ1IpID09IDB4ZWEpDQo+ICAgICAgICAgICAgICAgICBj
dXJfcHdyID0gZmFsc2U7DQo+ICAgICAgICAgZWxzZSBpZiAocnR3X2hjaV90eXBlKHJ0d2Rldikg
PT0gUlRXX0hDSV9UWVBFX1VTQiAmJg0KPiAtICAgICAgICAgICAgICAgIChydHdfcmVhZDgocnR3
ZGV2LCBSRUdfU1lTX1NUQVRVUzEgKyAxKSAmIEJJVCgwKSkpDQo+ICsgICAgICAgICAgICAgICAg
ICBjaGlwLT5pZCAhPSBSVFdfQ0hJUF9UWVBFXzg4MTRBICYmDQo+ICsgICAgICAgICAgICAgICAg
ICAocnR3X3JlYWQ4KHJ0d2RldiwgUkVHX1NZU19TVEFUVVMxICsgMSkgJiBCSVQoMCkpKQ0KDQpU
aGUgbmV3bHkgYWRkZWQgY29kZXMgYXJlIG5vdCBhbGlnbmVkLCBhbmQgc2VlbWluZ2x5IG9ubHkg
bmVlZCB0byBhZGQgDQp0aGUgbGluZSBjaGVja2luZyA4ODE0QS4NCg0KPiAgICAgICAgICAgICAg
ICAgY3VyX3B3ciA9IGZhbHNlOw0KPiAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgIGN1
cl9wd3IgPSB0cnVlOw0KPiAtLQ0KPiAyLjQ4LjENCg0K

