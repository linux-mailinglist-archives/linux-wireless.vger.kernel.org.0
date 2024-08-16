Return-Path: <linux-wireless+bounces-11502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E25953ED4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 03:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29310285438
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF3A8472;
	Fri, 16 Aug 2024 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ofPHINNw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E161DFCF
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723771201; cv=none; b=oIcSTAKE/6nqnSjVRPhBnfVXLuAOoYTKesgNnECYq375qisfrKsBkVHgjfhWndckIdsioc2oIwexybxlZMkG5BEFx5qHZb8wm1Zu+rG7PQJ4ekC++FGwCi1SpjXIJTRhPmpgw0pfPGISbat8iNwTOLO8RaJ5AG904kZfxPH6T3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723771201; c=relaxed/simple;
	bh=un4G+JD1oE1TEyFM7ZOZi0p/y3pQo6tVAi7zHlw9qwc=;
	h=From:To:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=epr50Hqo+UzUw/Qc3qVRweSya5PKUlJe46VfagVETbooah6savqJNfBV4CpsPu73LclCEWgXfhxrMiqofzruIX9RiBl/GCPIH6FYJ9ptoKln2mtmmhHBSCR9LCK78IYjC7R0y4io+fSc89GEtyDZh7SJF2CRDx5d6sKifK450i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ofPHINNw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47G1JqzrE474544, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723771192; bh=un4G+JD1oE1TEyFM7ZOZi0p/y3pQo6tVAi7zHlw9qwc=;
	h=From:To:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=ofPHINNwcoWkKMy/BGCfOqvpt5Uxrz+mOob7dLyUwu5RfgQklrWLqkz5SMwtyF5Ad
	 L4R3FA/qZS8X+QrcbF1EUkrnibi4rF61Yxdz+ahdeUrjXkwkPQUy0riPO/dQ0nBn6/
	 kB1L0E/iTTXJneKnlGA4VHml+TxVqbHDu4ckgvscMIjZrlSdd+Uorii6Iqj+9oGs24
	 0/4dShhwL0KoFGPgwuabetWusWNxupi4ylE7ssllzpR70Ba1CBboSPNmu+Mfg3ikz3
	 cdqKV+WUw29J4quNG7+9CWT0GdAVd5HwZsZKz9+vNZwLl/9aB/A1fZgsbK6oXqMcQR
	 jBB49RSAnvVBQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47G1JqzrE474544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 09:19:52 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 09:19:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Aug 2024 09:19:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 16 Aug 2024 09:19:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 16/20] wifi: rtw88: Add rtw8812a_table.{c,h}
Thread-Topic: [PATCH 16/20] wifi: rtw88: Add rtw8812a_table.{c,h}
Thread-Index: AQHa7DJLjT3E6wqwR0qhx7joU+N4ObIn9yAQgAEksJA=
Date: Fri, 16 Aug 2024 01:19:51 +0000
Message-ID: <4fc4af6a0ef14987841f159bf74ce765@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <e1ee4325-0878-46d5-bd51-8c994fa104a9@gmail.com> 
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

UGluZy1LZSBTaGloIHdyb3RlOg0KPiANCj4gPiArDQo+ID4gK2NvbnN0IHN0cnVjdCBydHdfcHdy
X3NlcV9jbWQgKmNhcmRfZW5hYmxlX2Zsb3dfODgxMmFbXSA9IHsNCj4gPiArICAgICAgIHRyYW5z
X2NhcmRkaXNfdG9fY2FyZGVtdV84ODEyYSwNCj4gPiArICAgICAgIHRyYW5zX2NhcmRlbXVfdG9f
YWN0Xzg4MTJhLA0KPiA+ICsgICAgICAgTlVMTA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArY29uc3Qg
c3RydWN0IHJ0d19wd3Jfc2VxX2NtZCAqZW50ZXJfbHBzX2Zsb3dfODgxMmFbXSA9IHsNCj4gPiAr
ICAgICAgIHRyYW5zX2FjdF90b19scHNfODgxMmEsDQo+ID4gKyAgICAgICBOVUxMDQo+ID4gK307
DQo+ID4gKw0KPiA+ICtjb25zdCBzdHJ1Y3QgcnR3X3B3cl9zZXFfY21kICpjYXJkX2Rpc2FibGVf
Zmxvd184ODEyYVtdID0gew0KPiA+ICsgICAgICAgdHJhbnNfYWN0X3RvX2NhcmRlbXVfODgxMmEs
DQo+ID4gKyAgICAgICB0cmFuc19jYXJkZW11X3RvX2NhcmRkaXNfODgxMmEsDQo+ID4gKyAgICAg
ICBOVUxMDQo+ID4gK307DQo+ID4gKw0KPiANCj4gVGhlc2UgdGhyZWUgYXJyYXkgc2hvdWxkIGJl
ICdjb25zdCBzdHJ1Y3QgcnR3X3B3cl9zZXFfY21kICogY29uc3QgLi4uJy4NCj4gDQo+IEkgZG9u
J3QgZXhwZWN0IHRoaW5ncyBpbiAiLmRhdGEiIHNlY3Rpb24uDQo+IA0KPiAkIG9iamR1bXAgIC10
IHJ0dzg4MTJhX3RhYmxlLm8gfCBncmVwICJcLmRhdGEiDQo+IDAwMDAwMDAwMDAwMDAwMDAgZyAg
ICAgTyAuZGF0YSAgMDAwMDAwMDAwMDAwMDAxOCBjYXJkX2Rpc2FibGVfZmxvd184ODEyYQ0KPiAw
MDAwMDAwMDAwMDAwMDIwIGcgICAgIE8gLmRhdGEgIDAwMDAwMDAwMDAwMDAwMTAgZW50ZXJfbHBz
X2Zsb3dfODgxMmENCj4gMDAwMDAwMDAwMDAwMDAzMCBnICAgICBPIC5kYXRhICAwMDAwMDAwMDAw
MDAwMDE4IGNhcmRfZW5hYmxlX2Zsb3dfODgxMmENCj4gDQoNClRoZSBleGlzdGluZyBjaGlwcyBo
YXZlIHRoaXMgc3R5bGUgYWxyZWFkeSwgc28gd2UgbmVlZCBhZGRpdGlvbmFsIG9uZSBwYXRjaA0K
dG8gY29udmVydCB0aGVtIGludG8gY29uc3QgZmlyc3QuDQoNCg0K

