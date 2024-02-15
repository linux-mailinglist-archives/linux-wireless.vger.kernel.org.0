Return-Path: <linux-wireless+bounces-3612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBE6855C61
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 09:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BB0292F31
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32822134B2;
	Thu, 15 Feb 2024 08:21:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C1D17585
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985316; cv=none; b=MKZqMxPIbfh/22QvMKGd80mzY6qMlUQjYXOatKnxcOGblVHudT24m6NJsJ1efhYMXsUVOvGFh9LdE3oB2Dx8r4DoqvHwhpNra0u8zwFQnBYXwoLJKd/XBxqQS+kmAmCCowegPuRji8iTPcsWMWjj5py2aL191e4nmW7k6QAyKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985316; c=relaxed/simple;
	bh=5cCcUxCILh7NH56NLCNn1SkQBUy5LLur1K6kJ2XKepE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftO6WAcv+3aO/HBx6a76xHelYUwev2tq2BpvyF+vlFxHWUOX65QWOjvsKqcH409Xx1iaNkaAOAeODT41eY6h+7yUeRivcIGoTbtaz67U48e/x/8zk2MaZ+D/jYq4sCISuMJ2RwiGv6whr+k0x066tfXBSWJbsfvjBXe0bzpuy2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41F8Lc3xA2429705, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41F8Lc3xA2429705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 16:21:38 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 15 Feb 2024 16:11:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 16:11:04 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 15 Feb 2024 16:11:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: rtl_usb: Store the endpoint addresses
Thread-Topic: [PATCH] wifi: rtlwifi: rtl_usb: Store the endpoint addresses
Thread-Index: AQHaXomVMtX/tQyetUa8+AQqBlkeILELDyQA
Date: Thu, 15 Feb 2024 08:11:04 +0000
Message-ID: <2fee4d0a62b24fb9af83df91c6eb4984@realtek.com>
References: <7b6a602a-6101-4bab-958d-bcff4d565b40@gmail.com>
In-Reply-To: <7b6a602a-6101-4bab-958d-bcff4d565b40@gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDEz
LCAyMDI0IDEwOjMzIFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
Q2M6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgTGFycnkgRmluZ2VyIDxMYXJy
eS5GaW5nZXJAbHdmaW5nZXIubmV0Pg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHdpZmk6IHJ0bHdpZmk6
IHJ0bF91c2I6IFN0b3JlIHRoZSBlbmRwb2ludCBhZGRyZXNzZXMNCj4gDQo+IEFuZCB1c2UgdGhl
IHN0b3JlZCBhZGRyZXNzZXMgaW4gcnRsODE5MmN1IGluc3RlYWQgb2YgaGFyZGNvZGluZyB0aGVt
Lg0KPiANCj4gVGhpcyBpcyB3aGF0IHRoZSB2ZW5kb3IgZHJpdmVycyBkby4NCj4gDQo+IFBlcmhh
cHMgdGhpcyBpcyBub3Qgc3RyaWN0bHkgbmVjZXNzYXJ5IGZvciBSVEw4MTkyQ1UgZGV2aWNlcy4g
SG93ZXZlciwNCj4gdGhlIGR1YWwgbWFjIHZlcnNpb24gb2YgUlRMODE5MkRVIGhhcyB0d28gVVNC
IGludGVyZmFjZXMsIGVhY2ggd2l0aCBpdHMNCj4gb3duIHNldCBvZiBlbmRwb2ludHMuIEhhcmRj
b2RpbmcgdGhlaXIgYWRkcmVzc2VzIGluIHRoZSB1cGNvbWluZw0KPiBydGw4MTkyZHUgZHJpdmVy
IHdvdWxkIHJlcXVpcmUgbWFraW5nIHNvbWUgYXNzdW1wdGlvbnMgd2hpY2ggSSdtIG5vdA0KPiBx
dWFsaWZpZWQgdG8gbWFrZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGgg
PHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpUaG91Z2ggSSdtIG5vdCBmYW1pbGlhciB3aXRo
IGVuZHBvaW50cyBvZiBVU0IsIHBhdGNoIG1ha2VzIHNlbnNlIHRvIG1lDQoNCkFja2VkLWJ5OiBQ
aW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=

