Return-Path: <linux-wireless+bounces-19066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13EEA37D6D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 09:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51C7188DC8C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7EA18A92D;
	Mon, 17 Feb 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qm/O0E+X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65E19ABD1
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781988; cv=none; b=H3xtsRPP5SDLQT42buj8yswlhHyPpjy43R1rkQG5HDJwnR9gQTrU6Yx2Px1SWVrXhbejgamBBVzShy3x7YWKc0Mxmrz4FHOmf9i5pUYN80ma4os/nPr4v2eYh3OYocOYZpLBK22bAro2kUu96Yw1nhntQyWehI708Ou0ljn3ZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781988; c=relaxed/simple;
	bh=ppW47I1xOewYKdBPVt8qiEsKO8IB6hXZr4XdJ90Fjrs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCtChntXNGna4xuYzZjw+ZfVFIM62IV3vJWhmVFJZk+xghZx9XAwfkpkFzqDP4pzHGZ87PkGh9nkUDsevdfxvnmasOdIPt/7QY3ErLmsrj39ZtsWMDPtrg9as04/JnM8cvTLGhSGfaayPZPaMH1Lf00c/Rv1ISCUN7FCccdG67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qm/O0E+X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H8kLufD2811789, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739781981; bh=ppW47I1xOewYKdBPVt8qiEsKO8IB6hXZr4XdJ90Fjrs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qm/O0E+XeRLuQRNg6pv2SLXhA6ka36Ni1M+nF8RYuOrXaDTtw6KUmR369jCEVtFfP
	 ApGTNgP5JfcAG2K4jtdSWbvtlFRiCwm0yg6NeS6sfalHjZb3F+myT78OwT86xUjQdn
	 o2/JAi4NtNih1fAwAT/ZtQ8pwy5gpCwSOcqzBj7wx4fZiPa/jsPuXwZF/rF9ctuC7s
	 +zBdUKIgVXU6Do/rJb+GJO1bsuI4zi6vtrEFtdYm0Uc6w2aSq8L/2H2TZPyXVW4qmj
	 KGSVFWWQRx5ZfbZU/k6IubZczMgiTN7qqEasQyCqn0wNfqeEvm0GW7Ql7k0hGgSZzr
	 NBtz7dUIcLZQw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H8kLufD2811789
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 16:46:21 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 16:46:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Feb 2025 16:46:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b]) by
 RTEXMBS04.realtek.com.tw ([fe80::f515:f604:42fb:a42b%5]) with mapi id
 15.01.2507.035; Mon, 17 Feb 2025 16:46:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Thread-Topic: [PATCH v2 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle
 MCS16-31
Thread-Index: AQHbf/Tiur/7012pMkOk1FQ7h/mBYLNLL/ag
Date: Mon, 17 Feb 2025 08:46:21 +0000
Message-ID: <27a9788ac9ef41c0a85bccab4b563131@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
 <9bb25bb0-ee46-4390-af6c-6bbd9edf3121@gmail.com>
In-Reply-To: <9bb25bb0-ee46-4390-af6c-6bbd9edf3121@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGlz
IGZ1bmN0aW9uIHRyYW5zbGF0ZXMgdGhlIHJhdGUgbnVtYmVyIHJlcG9ydGVkIGJ5IHRoZSBoYXJk
d2FyZSBpbnRvDQo+IHNvbWV0aGluZyBtYWM4MDIxMSBjYW4gdW5kZXJzdGFuZC4gSXQgd2FzIGln
bm9yaW5nIHRoZSAzU1MgYW5kIDRTUyBIVA0KPiByYXRlcy4gVHJhbnNsYXRlIHRoZW0gdG9vLg0K
PiANCj4gQWxzbyBzZXQgKm5zcyB0byAwIGZvciB0aGUgSFQgcmF0ZXMsIGp1c3QgdG8gbWFrZSBz
dXJlIGl0J3MNCj4gaW5pdGlhbGlzZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVl
IFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAgLSBTZXQg
Km5zcyBmb3IgdGhlIEhUIHJhdGVzLg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvdXRpbC5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L3V0aWwuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvdXRpbC5jDQo+IGluZGV4IGUyMjJkM2MwMWE3Ny4uOWJhYWZlYTY1ZDY0IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3V0aWwuYw0KPiArKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3V0aWwuYw0KPiBAQCAtMTAxLDgg
KzEwMSw5IEBAIHZvaWQgcnR3X2Rlc2NfdG9fbWNzcmF0ZSh1MTYgcmF0ZSwgdTggKm1jcywgdTgg
Km5zcykNCj4gICAgICAgICAgICAgICAgICpuc3MgPSA0Ow0KPiAgICAgICAgICAgICAgICAgKm1j
cyA9IHJhdGUgLSBERVNDX1JBVEVWSFQ0U1NfTUNTMDsNCj4gICAgICAgICB9IGVsc2UgaWYgKHJh
dGUgPj0gREVTQ19SQVRFTUNTMCAmJg0KPiAtICAgICAgICAgICAgICAgICAgcmF0ZSA8PSBERVND
X1JBVEVNQ1MxNSkgew0KPiArICAgICAgICAgICAgICAgICAgcmF0ZSA8PSBERVNDX1JBVEVNQ1Mz
MSkgew0KPiAgICAgICAgICAgICAgICAgKm1jcyA9IHJhdGUgLSBERVNDX1JBVEVNQ1MwOw0KPiAr
ICAgICAgICAgICAgICAgKm5zcyA9IDA7DQoNCm5pdDogSW4gb3RoZXIgYnJhbmNoZXMsIHNldCAq
bnNzIGZpcnN0IGFuZCB0aGVuICptY3MuDQpQbGVhc2UgaGVscCBrZWVwIHRoZSBzYW1lIG9yZGVy
Lg0KDQo+ICAgICAgICAgfQ0KPiAgfQ0KPiANCj4gLS0NCj4gMi40OC4xDQoNCg==

