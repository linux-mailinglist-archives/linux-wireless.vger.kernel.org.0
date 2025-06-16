Return-Path: <linux-wireless+bounces-24110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5CADA579
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A047A529B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 01:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F19514A8E;
	Mon, 16 Jun 2025 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TiNhwRGF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA57E1
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750036587; cv=none; b=DulgNBdVcyBv3Tq0ixE/G/xXLperliLEAIY7SMRcC2YAO9R/Ou2VtoWBmpaWbX9Q45S01AtT+OA/xoTmrxq/UHKRCkQTa8mLI0YWrXPNMmWXa9//0USNg1u2fZmD61aPZn2aP/V2zVzIZEy14fiqvZF4lGcEgRpiOxX2FwAOd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750036587; c=relaxed/simple;
	bh=cJCOl2Jc3Tu6wh/Qii0dOXd0ruvmwjD90imRR9nn6pE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cVNInAgylN6ED3zqAYmFgp2ShaV4vvKKDi35ZK8UhjRs8YQ6nPivtPOTRSC8Ox2dUrTk+3US+wsuZvtbsAMLL6sMCKtUxxVA0yFEPzlB+TGi/PEkzDuoBg6xy0rWEvt7tnj3vG5J2GUp7Jdu9FDHAywOXZFvjyiOAGQofNbmPc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TiNhwRGF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G1GLc643786097, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750036581; bh=cJCOl2Jc3Tu6wh/Qii0dOXd0ruvmwjD90imRR9nn6pE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=TiNhwRGFeAdxi1AO0lOqIrTvQSIqsPWfUI/Mu/5dKs5Zu6H9aFhuOKSi6zS2RSyIv
	 kG7JJjC+CTcw88WNH2I2t6eZvNJRZhjnirLug/rXs5R/FkwkZwvBwAAEkSIm++74qv
	 R2Pdle6CRrWfdj5zaphhDMVAx/FHENgMCIgYY194GHg7rlwBcWRbP7ZgTi8mvdfnVl
	 Ff07gyemnqQD3jQa0vw2X8+sl0jRb+3lrS8jVTB1qp+vdS3roUMpTJd5Gqvv9XYlYq
	 pN3FUbBO/XGx5lGWvPg/QiSRmQWAN7S2ABUGoLNshDJ0GB6iqUNF4abKcYy/G2wB7G
	 i1W34cLIxRoGA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G1GLc643786097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 09:16:21 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 09:15:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 09:15:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 16 Jun 2025 09:15:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 02/14] wifi: rtw89: Make dle_mem in rtw89_chip_info an array
Thread-Topic: [PATCH rtw-next v2 02/14] wifi: rtw89: Make dle_mem in
 rtw89_chip_info an array
Thread-Index: AQHb2XQgqi9CjlDKp0Gn4xXI3R5B3LQFA5JQ
Date: Mon, 16 Jun 2025 01:15:18 +0000
Message-ID: <a4860f62c9e44552a9f232df90aa4cae@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <f8b2b59c-5da0-4287-8ff1-f24408fba4d8@gmail.com>
In-Reply-To: <f8b2b59c-5da0-4287-8ff1-f24408fba4d8@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBVU0Ig
MiwgVVNCIDMsIGFuZCBTRElPIHdpbGwgbmVlZCBkaWZmZXJlbnQgc2V0cyBvZiB2YWx1ZXMuDQo+
IA0KPiBBZGQgYSBuZXcgZGxlX3R5cGUgbWVtYmVyIGluIHN0cnVjdCBydHc4OV9oY2lfaW5mbyBh
bmQgbWFrZSBkbGVfbWVtIGluDQo+IHN0cnVjdCBydHc4OV9jaGlwX2luZm8gYW4gYXJyYXkgdG8g
aG9sZCB0aGUgZm91ciBkaWZmZXJlbnQgc2V0cyBvZg0KPiB2YWx1ZXMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KWy4u
Ll0NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9t
YWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gaW5kZXgg
OWYwZTMwZTc1MDA5Li4yZWU3NjZlMzczMjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OS9tYWMuYw0KPiBAQCAtMTcxOSw3ICsxNzE5LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBydHc4OV9kbGVfbWVtICpnZXRfZGxlX21lbV9jZmcoc3RydWN0IHJ0dzg5X2RldiAq
cnR3ZGV2LA0KPiAgICAgICAgIHN0cnVjdCBydHc4OV9tYWNfaW5mbyAqbWFjID0gJnJ0d2Rldi0+
bWFjOw0KPiAgICAgICAgIGNvbnN0IHN0cnVjdCBydHc4OV9kbGVfbWVtICpjZmc7DQo+IA0KPiAt
ICAgICAgIGNmZyA9ICZydHdkZXYtPmNoaXAtPmRsZV9tZW1bbW9kZV07DQo+ICsgICAgICAgY2Zn
ID0gJnJ0d2Rldi0+Y2hpcC0+ZGxlX21lbVtydHdkZXYtPmhjaS5kbGVfdHlwZV1bbW9kZV07DQo+
ICAgICAgICAgaWYgKCFjZmcpDQoNCkluIGZhY3QsIG9yaWdpbmFsIGNoZWNraW5nIGhlcmUgaXMg
dW5uZWNlc3NhcnksIGJlY2F1c2UgaXQgbXVzdCBub3QgYmUgYSBOVUxMLg0KSW5zdGVhZCwgY2hl
Y2tpbmcgY2ZnLT5tb2RlIGxhdGVyIGlzIGVub3VnaC4NCg0KQnV0IG5vdywgcnR3ZGV2LT5jaGlw
LT5kbGVfbWVtW3J0d2Rldi0+aGNpLmRsZV90eXBlXSBjb3VsZCBiZSBOVUxMIGZvciBzb21lDQpj
YXNlcywgc28gd2Ugc2hvdWxkIGNoZWNrIGl0IGJlZm9yZSBhY2Nlc3NpbmcgW21vZGVdLCBsaWtl
DQoNCmNvbnN0IHN0cnVjdCBydHc4OV9kbGVfbWVtICpjZmcsICpjZmdzOw0KDQpjZmdzID0gJnJ0
d2Rldi0+Y2hpcC0+ZGxlX21lbVtydHdkZXYtPmhjaS5kbGVfdHlwZV07DQppZiAoIWNmZ3MpDQog
ICAgcmV0dXJuIE5VTEw7DQoNCmNmZyA9ICZjZmdzW21vZGVdOw0KaWYgKGNmZy0+bW9kZSAhPSBt
b2RlKQ0KICAgIC4uLg0KDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gDQoNCg==

