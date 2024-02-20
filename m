Return-Path: <linux-wireless+bounces-3799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE53185B12F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 04:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761F51F23C28
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 03:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64712405EC;
	Tue, 20 Feb 2024 03:11:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104753EA88
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398710; cv=none; b=Y2t1Vk7TmgwJA10kEr+zFNTrP38pPXzhZ1RXnrvdedfDuzTCffOMV0QomOobyYIVEauVqPQ62osMooduQH/cFxq5R7ppia4QFl+b4dxxn6jsbX+nSdNnWbN7WkI3yrJoMmrEdZ25sIaZwc07U9RB+pD74FNrnkLfhmcOmTIBfGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398710; c=relaxed/simple;
	bh=DA0/tfiL8I9A9gvsPhHRsJ1ybfj29D2IeyrAaBX5Y6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t5BmBC9feUzjsaKwqebbpR1qOf5Qm56D07U6nXlDML6D2JPmpwxAMH7hfAe4m1xR7y/txIe7+aSC4ETYbCWmp52wWEIzZvBvjItQyx4OdhT5fvIS7O0qbk0bD71ubWnsaM8paUQh+GyjFbnOczC4yq7RPqUDqb8IiugmLHpgp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41K3BRMn8171635, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41K3BRMn8171635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 11:11:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Tue, 20 Feb 2024 11:11:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 11:11:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 20 Feb 2024 11:11:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: Fix setting the basic rates
Thread-Topic: [PATCH] wifi: rtlwifi: Fix setting the basic rates
Thread-Index: AQHaYd6p9MFJopYdqEyEhDzoYDfrTLERRPeQ//+nGgCAAaHr0A==
Date: Tue, 20 Feb 2024 03:11:26 +0000
Message-ID: <ff0bd1f2e3724933bf943d3b79b2ab2d@realtek.com>
References: <35165caf-337c-4da0-b55c-c1a7081a1456@gmail.com>
	 <afded3d1768247cca613f55943a013aa@realtek.com>
 <f69f27acb8171cea5fdf6ceedb92efbced909300.camel@sipsolutions.net>
In-Reply-To: <f69f27acb8171cea5fdf6ceedb92efbced909300.camel@sipsolutions.net>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgQmVyZyA8
am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxOSwg
MjAyNCA2OjA0IFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IEJp
dHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPjsNCj4gbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBMYXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBsd2Zp
bmdlci5uZXQ+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdpZmk6IHJ0bHdpZmk6IEZpeCBzZXR0
aW5nIHRoZSBiYXNpYyByYXRlcw0KPiANCj4gSSBhbHNvIGhhdmUgYSBidW5jaCBvZiBleHBsYW5h
dGlvbnMgYWJvdXQgdGhhdCBpbiB0aGUgaXdsbXZtIGRyaXZlciBpbg0KPiBkcml2ZXJzL25ldC93
aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS9tYWMtY3R4dC5jIGFyb3VuZCBsaW5lIDM2MC4NCg0K
VGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb25zLiBJZiBubyBPRkRNIHJhdGVzIGNvbnRhaW5lZCBp
biBiYXNpYyByYXRlLCBtYW5kYXRvcnkNCnJhdGUgKDZNLCAxMk0gYW5kIDI0TSkgd2lsbCBiZSBh
ZGRlZC4gVGhpcyBpcyB0aGUgcG9pbnQgSSBhbHNvIG1pc3NlZC4NCg0KQml0dGVyYmx1ZSwgcGxl
YXNlIHVzZSB0aGUgc2FtZSBsb2dpYyBhcyBpd2x3aWZpIHRvIHNlZSBpZiBpdCB3b3JrcyBhcyBl
eHBlY3RlZC4gDQoNClBpbmctS2UgDQoNCg==

