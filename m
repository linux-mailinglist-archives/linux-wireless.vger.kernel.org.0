Return-Path: <linux-wireless+bounces-26113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD638B19A01
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 03:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CA917744F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 01:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E91CD215;
	Mon,  4 Aug 2025 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GsBB5FSm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9D17736
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754272284; cv=none; b=rrleYktxKlRm7f6AiriUIZ9z2+azag/7jdcSKdPJEg06kK74pHXIz4zaEyr0eL/XM8FeMterOUWtzu5pbhssP1x/RHrSNQd1FxJv+YZccSND6dNkrlvjuPqLhOZRi5GF9o7/Obdd/RrFFlAMOmmU3VqKb7RdtHeQiCLrdxpI9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754272284; c=relaxed/simple;
	bh=RkaNaoBzb7vzSwleJavf2TfgbfWBwBh/KpDUHE6wfNA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DdeOuDCPKImRbIzgFfbNOylg4Ty2lKb65bZ3yG1ZRQ9iTQg+h80adcR8Jtdz7JQm1SQYGhrX9q1H7cEuZRqoG+8H83gkADsjBdgtziqZq3Vs18V07+Y4e8noBQs7ghrdetHS3qIVlCZqnPDiRXOWsY9a+d3/JayZGifejoZVFsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GsBB5FSm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5741pIevD3215378, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754272278; bh=RkaNaoBzb7vzSwleJavf2TfgbfWBwBh/KpDUHE6wfNA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GsBB5FSmTtB3HtYjayBbwbHQWxJ2WdyayjE4fIw07br2AWjfA+4x2O21qtI8Elfgi
	 /VXrawFx4VJ8CI+4KidthiPOYnL83Bew5mUKfBa1JX9xG5Hf4WsDJbX68TM79vpb2U
	 R2c0/DjYquLG7CkHV4lTpyP2b8J9+/G2cmehOM8R8JY4UNMVJ3Y3solOh8X2nQ9Nj6
	 UU4m3RzBlYjJJ+eNxvikiuxeiny7Rh+Ksqgn82y+pqT59y0a+q0e49gWGViPLNaWhP
	 fnkn4rDPPbaSvOdtsBX9mei7iKs6nOa4h8OCpojL+k5CXgsj8ferUYnQgodRLUKi0h
	 865WtUvtRVIZg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5741pIevD3215378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 09:51:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 09:51:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 09:51:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Mon, 4 Aug 2025 09:51:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Lock rtwdev->mutex before setting the LED
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Lock rtwdev->mutex before setting
 the LED
Thread-Index: AQHcAyAOIzGthPvGd0+8M1c1qb+RjLRRvaMQ
Date: Mon, 4 Aug 2025 01:51:17 +0000
Message-ID: <a8bc1e18ccec418b9fe64b14b5f5c23f@realtek.com>
References: <ed69fa07-8678-4a40-af44-65e7b1862197@gmail.com>
In-Reply-To: <ed69fa07-8678-4a40-af44-65e7b1862197@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTb21l
IHVzZXJzIHJlcG9ydCB0aGF0IHRoZSBMRUQgYmxpbmtpbmcgYnJlYWtzIEFQIG1vZGUgc29tZWhv
dy4gTW9zdA0KPiBsaWtlbHkgdGhlIExFRCBjb2RlIGFuZCB0aGUgZHluYW1pYyBtZWNoYW5pc20g
YXJlIHRyeWluZyB0byBhY2Nlc3MgdGhlDQo+IGhhcmR3YXJlIHJlZ2lzdGVycyBhdCB0aGUgc2Ft
ZSB0aW1lLiBGaXggaXQgYnkgbG9ja2luZyBydHdkZXYtPm11dGV4DQo+IGJlZm9yZSBzZXR0aW5n
IHRoZSBMRUQgYW5kIHVubG9ja2luZyBpdCBhZnRlci4NCj4gDQo+IEZpeGVzOiA0YjY2NTJiYzZk
OGQgKCJ3aWZpOiBydHc4ODogQWRkIHN1cHBvcnQgZm9yIExFRCBibGlua2luZyIpDQo+IExpbms6
IGh0dHBzOi8vZ2l0aHViLmNvbS9sd2Zpbmdlci9ydHc4OC9pc3N1ZXMvMzA1DQoNCkknZCBjaGFu
Z2UgTGluayB0byAiQ2xvc2VzOiIgZHVyaW5nIG1lcmdpbmcgdGhpcyBwYXRjaC4NCg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0K
QWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

