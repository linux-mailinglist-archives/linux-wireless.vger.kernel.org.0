Return-Path: <linux-wireless+bounces-13079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AAE97E5BA
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 07:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321A21C20D4B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 05:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C85F11185;
	Mon, 23 Sep 2024 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gWwPApxn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957D1C3D
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727070601; cv=none; b=d9eXblShmIkvizXf67CAEmlAhAPJ4x39o9rXsHTYvfIrnVrklGJspxm8T2rHpNWZpilmGy66NrSPvdOLZJu51u77t4SUXhdaQEu3ZegNIw3NWx+irNf6fwZ+GUilH1pYAKqDnrNeP2Po5qNoUvINtH+QWhiAse/sGFf5danza5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727070601; c=relaxed/simple;
	bh=oojEHt9sNJvnYRiziJIs4r5eWM3Hgk/2DBNG8w3mAyA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sI9X3XILGXAaMcGtGLv9xE3gFGEoM6r86VfTl8I5TlDCEAxqtX5mVqWSvsZOccdn2tNwPgc6ovz9p7pZ37y56JAqykKGPNc2SoL1cw55eK6Cb6ku+bT3tPiP545eKz9puEFywFb6mPcpjOr1dJS8USDLuSFFIaYfJ7Tp6rSx96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gWwPApxn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48N5nspuF855511, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727070594; bh=oojEHt9sNJvnYRiziJIs4r5eWM3Hgk/2DBNG8w3mAyA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gWwPApxnVlwQYBXfKo9om25u15rK9ZLla5v05lQH9GLgs1Ri0XYIWP9GeMMRmwBMv
	 LRw5miaxTM/EMk0EEMVq3Wnj9uJ6X5gkTlOXNIfs57Qo4pteARH8K1MCJX5mfbGycH
	 Naa2qM+mK4mSMWxGTDz61z+cdV/CzKYF6DOk0tcDu7f9dzW85Bd3sMq3L8QpYDsGlN
	 lTamqjTPOBnElkQEnE2l4x8Nbvh4gslmmuCXEMT4diMMnenOcMCgJyEzL87cnN7ZmN
	 sTCWoHdFD4N1s9P+yKPd9smWnp4ya+1ORB+uD0yFqptemRBOazcTevskerXRytVH66
	 o54t+U8sarj9Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48N5nspuF855511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 13:49:54 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 13:49:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 23 Sep 2024 13:49:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 23 Sep 2024 13:49:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw88: Parse the RX descriptor with a single function
Thread-Topic: [PATCH v2] wifi: rtw88: Parse the RX descriptor with a single
 function
Thread-Index: AQHbC5Mnpcjl+kJu0UaMLI5NjVnRa7Jk4U0Q
Date: Mon, 23 Sep 2024 05:49:54 +0000
Message-ID: <21a239b103d7457eb84d31106f9580cb@realtek.com>
References: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com>
 <913f1747-38fc-4409-85a4-57bb9cee506b@gmail.com>
In-Reply-To: <913f1747-38fc-4409-85a4-57bb9cee506b@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBydHc4
NzAzYl9xdWVyeV9yeF9kZXNjKCksIHJ0dzg3MjNkX3F1ZXJ5X3J4X2Rlc2MoKSwNCj4gcnR3ODgy
MWNfcXVlcnlfcnhfZGVzYygpLCBydHc4ODIyYl9xdWVyeV9yeF9kZXNjKCksIGFuZA0KPiBydHc4
ODIyY19xdWVyeV9yeF9kZXNjKCkgYXJlIGFsbW9zdCBpZGVudGljYWwsIHNvIHJlcGxhY2UgdGhl
bSBhbGwgd2l0aA0KPiBhIHNpbmdsZSBmdW5jdGlvbiwgcnR3X3J4X3F1ZXJ5X3J4X2Rlc2MoKS4N
Cj4gDQo+IEFsc28sIGFjY2VzcyB0aGUgUlggZGVzY3JpcHRvciB1c2luZyBhIHN0cnVjdCB3aXRo
IF9fbGUzMiBtZW1iZXJzIGFuZA0KPiBsZTMyX2dldF9iaXRzKCkuDQo+IA0KPiBUZXN0ZWQgd2l0
aCBSVEw4ODExQ1UsIFJUTDg4MTFBVSwgYW5kIFJUTDg4MTJBVS4NCg0KSSBhbHNvIHRlc3RlZCB3
aXRoIFJUTDg3MjNERSBhbmQgUlRMODgyMkNFLCBzbw0KDQpUZXN0ZWQtYnk6IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPiAjIFJUTDg3MjNERSBhbmQgUlRMODgyMkNFDQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29t
Pg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K

