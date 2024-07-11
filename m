Return-Path: <linux-wireless+bounces-10165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 560D292DD7C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 02:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D33F1F227B0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 00:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2755379DF;
	Thu, 11 Jul 2024 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WrVOiYsb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4B079CC
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720659020; cv=none; b=XWjXMhOzzQgipPvU+2pEwpWHmxcio2NCS+14MnOIZ+osSUT9AzYsprkEATRp2sqmRMq9rKrhVR0HifOdsoGeU2B45FuvbYPaYOObI3MyJX49juhRKz9+mg5WuDiiJEqQJ+M0AtbF9qbczMIGuuMA226Wurcedw/iXt0lEP9QNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720659020; c=relaxed/simple;
	bh=L8XD3ASW1xuylHgBjo2W1X8/Z6Jq3beY+99Y8aO072o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R1rA28pVUXKufAwsfLmwtsAeFWV0gbJzsk+U7VNOh1Ml8Q6AC6NH7TMeDdgp06q5gpHoBsgWFsSqkynKdusNuGR3s6DTzfizh+Gwa0fpMfEeXxk3y6yYw47vAUjELxGK0blhkL8mChiOAbzvxz9ynfHwXY51rx7pBB3Ax4U2eOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WrVOiYsb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46B0nrBnB2677954, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720658994; bh=L8XD3ASW1xuylHgBjo2W1X8/Z6Jq3beY+99Y8aO072o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WrVOiYsb2erhc8BEMwB5yNzTMSgJEQPt8ACMO1nqxZiLUzm4VTr2NfNWHNB2yGxop
	 /9Dx/Q71/dq21Z0KuuS1qxfscrZF5Tkgwn4l7ZllxunlkWd7tLiDgaXm3cNHOdXB90
	 YTui+sdkclVSAgk9jKFSlnvU+acfDBqUigh7V6ak+Gr4Bz99XPKatxe2TjyOSlXFxT
	 Fs86g7cfb1KkGYzqDJ0rSUtWXdhsNjJdGtwH1A5iuVct2RcTek4rumnPQgWFiAw2lR
	 Gw9wp4JKvsQV/sPp7kVUm44Sge3fXMwsTZPmNA5DsrLrEP1NRXPk3qnvaBT2/sVZOw
	 tPXlgwhhpyHnQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46B0nrBnB2677954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:49:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 08:49:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jul 2024 08:49:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 11 Jul 2024 08:49:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
Thread-Topic: [PATCH v2] wifi: rtw88: usb: Support USB 3 with
 RTL8822CU/RTL8822BU
Thread-Index: AQHa0xYkmDbiiE8zwECAKeoa0bjeHbHwsGUQ
Date: Thu, 11 Jul 2024 00:49:53 +0000
Message-ID: <f0540a9637d1476f827663f21c03ff32@realtek.com>
References: <77906c62-5674-426f-bde1-1b2a12a0339d@gmail.com>
In-Reply-To: <77906c62-5674-426f-bde1-1b2a12a0339d@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
UmVhbHRlayB3aWZpIDUgZGV2aWNlcyB3aGljaCBzdXBwb3J0IFVTQiAzIGFyZSB3ZWlyZDogd2hl
biBmaXJzdA0KPiBwbHVnZ2VkIGluLCB0aGV5IHByZXRlbmQgdG8gYmUgVVNCIDIuIFRoZSBkcml2
ZXIgbmVlZHMgdG8gc2VuZCBzb21lDQo+IGNvbW1hbmRzIHRvIHRoZSBkZXZpY2UsIHdoaWNoIG1h
a2UgaXQgZGlzYXBwZWFyIGFuZCBjb21lIGJhY2sgYXMgYQ0KPiBVU0IgMyBkZXZpY2UuDQo+IA0K
PiBJbXBsZW1lbnQgdGhlIHJlcXVpcmVkIGNvbW1hbmRzIGluIHJ0dzg4Lg0KPiANCj4gV2hlbiBh
IFVTQiAzIGRldmljZSBpcyBwbHVnZ2VkIGludG8gYSBVU0IgMiBwb3J0LCBydHc4OCB3aWxsIHRy
eSB0bw0KPiBzd2l0Y2ggaXQgdG8gVVNCIDMgbW9kZSBvbmx5IG9uY2UuIFRoZSBkZXZpY2Ugd2ls
bCBkaXNhcHBlYXIgYW5kIGNvbWUNCj4gYmFjayBzdGlsbCBpbiBVU0IgMiBtb2RlLCBvZiBjb3Vy
c2UuDQo+IA0KPiBTb21lIHBlb3BsZSBleHBlcmllbmNlIGhlYXZ5IGludGVyZmVyZW5jZSBpbiB0
aGUgMi40IEdIeiBiYW5kIGluDQo+IFVTQiAzIG1vZGUsIHNvIGFkZCBhIG1vZHVsZSBwYXJhbWV0
ZXIgc3dpdGNoX3VzYl9tb2RlIHdpdGggdGhlDQo+IGRlZmF1bHQgdmFsdWUgMSB0byBsZXQgcGVv
cGxlIGRpc2FibGUgdGhlIHN3aXRjaGluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJs
dWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogUGluZy1LZSBT
aGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0KDQo=

