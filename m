Return-Path: <linux-wireless+bounces-11048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3A8949D14
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 02:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9A3B23A6F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 00:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA6A17756;
	Wed,  7 Aug 2024 00:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nnbpMjyL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688614293
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991090; cv=none; b=TFt6n7VtRQwpmXIYU42wskbrbkITYnvcSLRES5kXrMmr2ZJaarVLUGjR0wpRxvOEw2ChwMN5mcVRxnJ7J0S1+3eSq+XJJIEgl4xQP3WaJi96SFcsJ8tUdO+uknkr/fgzieEXfV6wW7v/aREfybfEPTmXIq89c1V2OWTEtC1fjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991090; c=relaxed/simple;
	bh=PSTOdkPC8ivtG9hJrk1SakQERw6IbG6yiSs/Dq90LMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JdZBp17Ve57QcsBbzAmayvqkTN8QEZiQr3a/1EKDnwPFOw9nmze0BvCGIkYo68S7UAU2wx7kRa5BICZqcmR91AFVqmhIgZ7bcqTckGLMj6gVDtt77r1Bfng18kGvXW95lDRzq9BRTQ6VqqI2jouQfxWb80fcwVWu69l0yj/g0GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nnbpMjyL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4770broT71701144, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722991073; bh=PSTOdkPC8ivtG9hJrk1SakQERw6IbG6yiSs/Dq90LMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nnbpMjyLVbBMp2AbzBkqxp4JVcSrHKkXoczxs4cqNAL47/tVdqiR7qCmdmcDO4dX+
	 dZ/ig4jLBsE6CT29DsxZgUZs6/f2WCYz0G3jPJKnDU9IPRgVhlZQIIZLJs+MtHcUxN
	 z5vQD696Lrt5RDBneUAer4nHwo00ju57oLfRYWt/wY2wEw5Rih4PEO9HPsDZYnTx2V
	 e1QUElGxKUHrYzI7387p7vnxah+TH+i2T9rMr59IE8kRP3ARjuKY9MjAmTONw23Dks
	 u7uCUqeYZ9qvN5wDidevZ6B75RPPjsmwXReHKkW/iYqA3R4oViNKirofBmRf8j/Hym
	 1lUECo8zLNM2Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4770broT71701144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 08:37:53 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 08:37:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Aug 2024 08:37:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 7 Aug 2024 08:37:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v3 4/4] wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c
Thread-Topic: [PATCH v3 4/4] wifi: rtw88: Enable USB RX aggregation for
 8822c/8822b/8821c
Thread-Index: AQHa6Ci8MN8iAA94B0GIGPvahJU6orIa8nCA
Date: Wed, 7 Aug 2024 00:37:53 +0000
Message-ID: <8218e3aeb62b463d9562ae02213e29ee@realtek.com>
References: <acc5ccc7-e573-472f-96d2-582716046aa6@gmail.com>
 <3b7b3655-9ec5-4277-b0ff-5535b1fdf281@gmail.com>
In-Reply-To: <3b7b3655-9ec5-4277-b0ff-5535b1fdf281@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBAQCAt
MjM2LDEzICsyMzcsMTcgQEAgc3RhdGljIHZvaWQgcnR3X3dhdGNoX2RvZ193b3JrKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykNCj4gICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICBwc19h
Y3RpdmUgPSBmYWxzZTsNCj4gDQo+IC0gICAgICAgZXdtYV90cF9hZGQoJnN0YXRzLT50eF9ld21h
X3RwLA0KPiAtICAgICAgICAgICAgICAgICAgICh1MzIpKHN0YXRzLT50eF91bmljYXN0ID4+IFJU
V19UUF9TSElGVCkpOw0KPiAtICAgICAgIGV3bWFfdHBfYWRkKCZzdGF0cy0+cnhfZXdtYV90cCwN
Cj4gLSAgICAgICAgICAgICAgICAgICAodTMyKShzdGF0cy0+cnhfdW5pY2FzdCA+PiBSVFdfVFBf
U0hJRlQpKTsNCj4gKyAgICAgICB0eF91bmljYXN0X21icHMgPSBzdGF0cy0+dHhfdW5pY2FzdCA+
PiBSVFdfVFBfU0hJRlQ7DQo+ICsgICAgICAgcnhfdW5pY2FzdF9tYnBzID0gc3RhdHMtPnJ4X3Vu
aWNhc3QgPj4gUlRXX1RQX1NISUZUOw0KPiArDQo+ICsgICAgICAgZXdtYV90cF9hZGQoJnN0YXRz
LT50eF9ld21hX3RwLCB0eF91bmljYXN0X21icHMpOw0KPiArICAgICAgIGV3bWFfdHBfYWRkKCZz
dGF0cy0+cnhfZXdtYV90cCwgcnhfdW5pY2FzdF9tYnBzKTsNCj4gICAgICAgICBzdGF0cy0+dHhf
dGhyb3VnaHB1dCA9IGV3bWFfdHBfcmVhZCgmc3RhdHMtPnR4X2V3bWFfdHApOw0KPiAgICAgICAg
IHN0YXRzLT5yeF90aHJvdWdocHV0ID0gZXdtYV90cF9yZWFkKCZzdGF0cy0+cnhfZXdtYV90cCk7
DQo+IA0KPiArICAgICAgIHJ0d19oY2lfZHluYW1pY19yeF9hZ2cocnR3ZGV2LA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdHhfdW5pY2FzdF9tYnBzID49IDEgfHwgcnhfdW5pY2Fz
dF9tYnBzID49IDEpOw0KPiArDQoNCk5vdCBzdXJlIGlmIHlvdSBoYXZlIHRyaWVkIFJUTDg4MjJD
VSB3aXRoIHRoaXMgZHluYW1pY19yeF9hZ2c/IA0KSSBzdXNwZWN0IFJUTDg4MjJDVSBjYW4ndCBh
Y2Nlc3MgSU8gYmVmb3JlIHJ0d19sZWF2ZV9scHMoKSwgYXQgbGVhc3QgUlRMODgyMkNFIGNhbid0
Lg0KTGV0J3MgbW92ZSBydHdfaGNpX2R5bmFtaWNfcnhfYWdnKCkgcmlnaHQgYWZ0ZXIgcnR3X3Bo
eV9keW5hbWljX21lY2hhbmlzbSgpIGJlbG93Lg0KDQpTb3JyeSB0byBmb3JnZXQgdGhpcyBwb2lu
dCBvbiB2MiByZXZpZXcuIA0KDQo+ICAgICAgICAgLyogcmVzZXQgdHgvcnggc3RhdGljdGljcyAq
Lw0KPiAgICAgICAgIHN0YXRzLT50eF91bmljYXN0ID0gMDsNCj4gICAgICAgICBzdGF0cy0+cnhf
dW5pY2FzdCA9IDA7DQoNCg0KDQo=

