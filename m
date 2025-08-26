Return-Path: <linux-wireless+bounces-26627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB43B357C5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 11:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F116820464F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 09:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94DC2356B9;
	Tue, 26 Aug 2025 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mrnXkfOI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2778122E406
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198837; cv=none; b=YxnRQH7BIRL4CZMy5u1ieKMlt1oBkwsGC/6CXdm9nYrS8/Q8dcZtSHN6PjiG7Po/Gvee3BKmp/s73HOKV+Fe/Bi0u2WQGWbKLmKAHtV4691NwwvGbSBRxdST0cCcjXtc3EKQjT1AlwNdJ2Aun4fc4v5aTN1jWzV6DYl58rZx5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198837; c=relaxed/simple;
	bh=OP6X2mwp6Ki0VhRbI4xSpTNI5SzIs2DxLmREL4P2Doc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jOtIrgyEbjz72+4Ndbs09UtOTlfRYlAW/Axnoo4Dd4qU6D0jfrMwCqquFbOeh4G01at7OnltnfjfB7AA7zIF1N/jIo7YiZ3CHm2FvWRyNDxTXrHDYM0obYkWmUEk9CPHZiKssBKLX1bMZY5Rm2HSiH042ZHH3DUAbozS6EvUPp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mrnXkfOI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q90UJS01269590, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198831; bh=OP6X2mwp6Ki0VhRbI4xSpTNI5SzIs2DxLmREL4P2Doc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mrnXkfOIzcIFK4480vkITiiI5bJQZfv2K027io7kpTUQI/eXGdq7mXaoGPODlwWNI
	 iqYk1raCYyh800Hji2jiRxWVN/1D2eMHSV1uzcGzsHoygFExAfGod8oSnR/TMUfptM
	 bpGW0VNoBsT9/P3BSU0cx+KnnN/z40r+PtfXCeAngOjBU1S5u29XFxzNYanXhYN/5/
	 AgMq72J9VEyCit7QcxByhqlkCIrUN4VltDCi1sXiKDY+pqe5BR9rOenSSviDN8Vz0b
	 ZVBtp85t+mZMbQwRsJIyN9stwxPvJERqQo725fYq4jfk116DbyocqWNym3L4y89Z7h
	 kFdbIZEgHam8g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q90UJS01269590
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 17:00:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 17:00:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 26 Aug 2025 17:00:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 01/11] wifi: rtw89: Fix rtw89_core_get_ch_dma() for RTL8852CU
Thread-Topic: [PATCH rtw-next v2 01/11] wifi: rtw89: Fix
 rtw89_core_get_ch_dma() for RTL8852CU
Thread-Index: AQHcAyYgFh0777fe60moSIXGnadVn7RSUziAgADjWSCACLr7AIAY1yRg
Date: Tue, 26 Aug 2025 09:00:30 +0000
Message-ID: <3ae0e8e7efbc4b6189ce9416c3a890eb@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <5b1210f3-499d-44d8-9433-7beac2a2800d@gmail.com>
 <11f3e864-7509-4e5f-86ed-997f8a9b63e9@gmail.com>
 <4203c4ab09df4975be85e341f5e24264@realtek.com>
 <de899380-fe3c-4b9e-86cf-3677fb0b4f92@gmail.com>
In-Reply-To: <de899380-fe3c-4b9e-86cf-3677fb0b4f92@gmail.com>
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

PiA+DQo+ID4gK3N0YXRpYyBpbmxpbmUNCj4gPiArdTggcnR3ODlfY2hpcF9nZXRfY2hfZG1hKHN0
cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTggcXNlbCkNCj4gPiArew0KPiA+ICsgICAgICAgY29u
c3Qgc3RydWN0IHJ0dzg5X2NoaXBfaW5mbyAqY2hpcCA9IHJ0d2Rldi0+Y2hpcDsNCj4gPiArDQo+
ID4gKyAgICAgICByZXR1cm4gY2hpcC0+b3BzLT5nZXRfY2hfZG1hKHJ0d2RldiwgcXNlbCk7DQo+
ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbmxpbmUNCj4gPiAgdm9pZCBydHc4OV9jaGlwX21h
Y19jZmdfZ250KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3Qgc3RydWN0IHJ0dzg5X21hY19heF9jb2V4X2dudCAqZ250X2NmZykN
Cj4gPg0KPiA+IEFsc28gdGhlIHJ0dzg5X2NvcmVfZ2V0X2NoX2RtYSgpIGlzIG1vdmVkIHRvIGNv
cmUuYywgYW5kIGFkZA0KPiA+IHJ0dzg5X2NvcmVfZ2V0X2NoX2RtYV92MSgpIGZvciBSVEw4OTIy
REUuDQo+ID4NCj4gPiBIb3dldmVyLCBVU0IgY2FuIHVzZSBkaWZmZXJlbnQgbWFwcGluZyBydWxl
LCBzbyB3ZSBzaG91bGQgZXh0ZW5kIHRoZSBzaXplDQo+ID4gdG8gUlRXODlfSENJX1RZUEVfTlVN
LiBUaGVuLA0KPiA+DQo+ID4gICByZXR1cm4gY2hpcC0+b3BzLT5nZXRfY2hfZG1hW3J0d2Rldi0+
aGNpLnR5cGVdKHJ0d2RldiwgcXNlbCk7DQo+ID4NCj4gPiBJZiB5b3Ugd2FudCBteSBwYXRjaCBh
cyBmaXJzdCBwYXRjaCBvZiB0aGlzIHBhdGNoc2V0LCBJIGNhbiBzaGFyZSBpdCBhcyBSRkMuDQo+
ID4NCj4gDQo+IFllcywgdGhhdCB3b3VsZCBiZSBnb29kLg0KDQpGaW5hbGx5LCBJIGRlY2lkZSB0
byBzZW5kIGEgZm9ybWFsIHBhdGNoIHdpdGhpbiBwYXRjaHNldCBmb3IgY29taW5nIFdpRmkgNyBj
aGlwLg0KIltQQVRDSCBydHctbmV4dCAwOS8xMF0gd2lmaTogcnR3ODk6IGFic3RyYWN0IGdldHRp
bmcgZnVuY3Rpb24gb2YgRE1BIGNoYW5uZWwiDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC13aXJlbGVzcy8yMDI1MDgyNjA4NTMzOS4yODUxMi0xLXBrc2hpaEByZWFsdGVrLmNv
bS9ULyN1DQoNCg0K

