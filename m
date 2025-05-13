Return-Path: <linux-wireless+bounces-22885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A42AB49DC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 05:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDFA4A0C89
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D9522F;
	Tue, 13 May 2025 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nPyD3Rlg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C34C6C
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105609; cv=none; b=ESpd4av4MYu2vJsX5fkyyTR91EiRvPc1lGVEk1iGCxuxQCXDOUQDwbqbJ3HU8mxRMdPa7sDqozvb209/5ATDmnRVHk/B3M5TbxRFH367Uv5XIimT+SzY/rn92L4OD6V6pk5rRDRwl8yXhA9jmua1JCkVgSbljFOk9eWyTkPNodk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105609; c=relaxed/simple;
	bh=bMkdNk5Kn0NPYs5ZOSIMwomzS1emWh9Us+eb2OhGdzs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mU0hF0YbeC9Z0wj/UggWtCxi4NreTmarr1HA7LO+0EYOKbU1Xp6NWc1KeH/0LZ1zJ7PQidqEOU72LoFuGbW4gLT4TP1JNmKbuvbo8b03FBSd3AtGe42lfiZlHCI9eAMDY4SJTc6OCg6C+SuRVcCxmKIbx98J5mWO3ruuAY9V4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nPyD3Rlg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D36gssE3569965, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747105603; bh=bMkdNk5Kn0NPYs5ZOSIMwomzS1emWh9Us+eb2OhGdzs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nPyD3RlgbcoJb5O83GB6QkvRaKywUyrywJ8Raegg/M8DAPpVMo9Ne85pN+yHvIW5J
	 rkrgq+giXqmdeFc1tnDeWQKGfvRz/ZeSEwTPjNrDIPfdvmPxBSt4/uxCCwPHJEjhYz
	 nCpi61S+tqFfxCamfsXjLgcsR63bJJ2bu2bI0X7p6P1dJq3GoMx8EyRNEaZ0b/+Y5Z
	 PN2iGaHHpQaRicViR2YI0DUFvShdWo0EtlPUiQKX7nPWioHR6A2NQ2Yped4974OydT
	 ch1yPId75eI1UABFVVjBffiJqGGGrRY6bfx+yiIB8hF97hanitm3pHrENucdGI1/2q
	 rjHQlwszv15+A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D36gssE3569965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 11:06:43 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 11:06:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 11:06:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 11:06:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 04/13] wifi: rtw89: Add dle_mem_usb2 and dle_mem_usb3
Thread-Topic: [PATCH rtw-next v1 04/13] wifi: rtw89: Add dle_mem_usb2 and
 dle_mem_usb3
Thread-Index: AQHbvTYvGaJBiR/poUKYMyU1gr/tobPP7SLA
Date: Tue, 13 May 2025 03:06:42 +0000
Message-ID: <8545bf51dffe4679ae7323694510fcf4@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <5ab76c63-f605-4d42-b116-f141610cdae6@gmail.com>
In-Reply-To: <5ab76c63-f605-4d42-b116-f141610cdae6@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
bmV3IG1lbWJlcnMgZGxlX21lbV91c2IyIGFuZCBkbGVfbWVtX3VzYjMgdG8gc3RydWN0IHJ0dzg5
X2NoaXBfaW5mby4NCj4gRm9yIG5vdyBpbml0aWFsaXNlIHRoZW0gb25seSBmb3IgUlRMODg1MUIu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdt
YWlsLmNvbT4NCj4gLS0tDQoNClsuLl0NCg0KPiBAQCAtMTY2MSw2ICsxNjYzLDEwIEBAIGNvbnN0
IHN0cnVjdCBydHc4OV9tYWNfc2l6ZV9zZXQgcnR3ODlfbWFjX3NpemUgPSB7DQo+ICAgICAgICAg
LnBsZV9zaXplMTggPSB7UlRXODlfUExFX1BHXzEyOCwgMjU0NCwgMTYsfSwNCj4gICAgICAgICAv
KiA4ODUyQyBQQ0lFIFNDQyAqLw0KPiAgICAgICAgIC5wbGVfc2l6ZTE5ID0ge1JUVzg5X1BMRV9Q
R18xMjgsIDE5MDQsIDE2LH0sDQo+ICsgICAgICAgLyogODg1MkIgVVNCMi4wIFNDQyovDQo+ICsg
ICAgICAgLnBsZV9zaXplMzIgPSB7UlRXODlfUExFX1BHXzEyOCwgNjIwLCAyMCx9LA0KPiArICAg
ICAgIC8qIDg4NTJCIFVTQjMuMCBTQ0MqLw0KDQpuaXQ6IHNwYWNlIGJldHdlZW4gIlNDQyIgYW5k
ICIqLyIuIFBsZWFzZSBhbHNvIHRoaXMgcnVsZSBhcHBseSB0byBvdGhlcnMgaW4NCnRoaXMgY29t
bWl0Lg0KDQo+ICsgICAgICAgLnBsZV9zaXplMzMgPSB7UlRXODlfUExFX1BHXzEyOCwgNjMyLCA4
LH0sDQo+ICAgICAgICAgLyogUENJRSA2NCAqLw0KPiAgICAgICAgIC53ZGVfcXQwID0gezM3OTIs
IDE5NiwgMCwgMTA3LH0sDQo+ICAgICAgICAgLndkZV9xdDBfdjEgPSB7MzMwMiwgNiwgMCwgMjAs
fSwNCg0KWy4uLl0NCg0K

