Return-Path: <linux-wireless+bounces-18896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0500A338DB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 08:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88234162557
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF961FC0FD;
	Thu, 13 Feb 2025 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Imz8ytuR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AEF207E1D
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431866; cv=none; b=cAS8TPTpc+7A12q1eisNXj0D7RVKx/iKdzQpywWsjcqVrNISuZOINiGOdWJdpat2Zm7ExUcQJYyDzk40CXXK4M+OEVz7n8iAaZksyfhxJJyF3o/MwWDjy07KBXf3ObEczGiZ0VSx17pUE9YBHL+6fTYQGxyF/EQ75CkmNo41WI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431866; c=relaxed/simple;
	bh=OGNd+QLImZmgDjs+IMoc+gCS2k26WRzKqhX04cSH6wo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ujlpnu3VudkN9Hj3Qa4GVnsTR77JT1jA6L2fJYlMbuKnBBMNfkWC4DNn8lgWDOVmhU+yIqpp9s4dC42WlnwIyTAUDEC3KEZntuJ5t9gvlHZOmiUZLcocZn7ZkEnCbXTUNnwHTjYebx5wNjq4YGPqG+3eaJyXpr4xp50pUdfsUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Imz8ytuR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D7UxZA2570511, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739431859; bh=OGNd+QLImZmgDjs+IMoc+gCS2k26WRzKqhX04cSH6wo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Imz8ytuRPORNV5CFF1XMnyiDRvqNiyh5lb+F58ZmRCHdBgSLhnBEfFa3ucbEGNvyj
	 C9IbTmO3MJ1rsXZ4l7aQ3KWPgairgWZqKIYmsQiFGoNQ6Zf+xnZQNE65wslBsh7/3z
	 h8OwrTj4amrGnHaJr3uHIpfF80zpMhwjzOTYWCGcTfTfmh+3oht26UkRweltCGzSgd
	 IiGjQIqMAkEvI/L+9+hYhehZ/eNGTrC9v4d4CsZOh7VrNZnLNM4YUWGP+trQKVPCa8
	 7xeQXm/OyDi4evnDLY7GRhxF3kaju7mXCnwSDlgPXjMCcAA6xjxb5eo6SGSFEyezR5
	 bGcELH/hAH32A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D7UxZA2570511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:30:59 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 15:30:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 15:30:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 15:30:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
Thread-Topic: [PATCH 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle
 MCS16-31
Thread-Index: AQHbfNOEmVS3jazL6EKkriyCSkzaBLNE2FnA
Date: Thu, 13 Feb 2025 07:30:59 +0000
Message-ID: <48e6cdc3d0a240d8b7efee2523f95807@realtek.com>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <23d28222-8f83-43a8-b312-d5858cf355d8@gmail.com>
In-Reply-To: <23d28222-8f83-43a8-b312-d5858cf355d8@gmail.com>
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
bm9yaW5nIHRoZSAzU1MgYW5kIDRTUyBIVA0KPiByYXRlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXRpbC5jIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91dGlsLmMgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3V0aWwuYw0KPiBpbmRleCBlMjIyZDNjMDFhNzcuLmJh
MDJiYTcyZTEwNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC91dGlsLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91
dGlsLmMNCj4gQEAgLTEwMSw3ICsxMDEsNyBAQCB2b2lkIHJ0d19kZXNjX3RvX21jc3JhdGUodTE2
IHJhdGUsIHU4ICptY3MsIHU4ICpuc3MpDQo+ICAgICAgICAgICAgICAgICAqbnNzID0gNDsNCj4g
ICAgICAgICAgICAgICAgICptY3MgPSByYXRlIC0gREVTQ19SQVRFVkhUNFNTX01DUzA7DQo+ICAg
ICAgICAgfSBlbHNlIGlmIChyYXRlID49IERFU0NfUkFURU1DUzAgJiYNCj4gLSAgICAgICAgICAg
ICAgICAgIHJhdGUgPD0gREVTQ19SQVRFTUNTMTUpIHsNCj4gKyAgICAgICAgICAgICAgICAgIHJh
dGUgPD0gREVTQ19SQVRFTUNTMzEpIHsNCj4gICAgICAgICAgICAgICAgICptY3MgPSByYXRlIC0g
REVTQ19SQVRFTUNTMDsNCg0KU29tZWhvdywgd2UgZG9uJ3Qgc2V0ICpuc3MgaW4gdGhpcyBjYXNl
LiBUaGUgY2FsbGVyIHJ0d19md19yYV9yZXBvcnRfaXRlcigpDQpkb2Vzbid0IGluaXRpYWxpemUg
bnNzLCBzbyB0aGVyZSBpcyBwb3RlbnRpYWwgcHJvYmxlbS4NCg0KDQo=

