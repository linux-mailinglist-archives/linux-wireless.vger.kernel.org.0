Return-Path: <linux-wireless+bounces-3611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0917D855BA6
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 08:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9C21C21283
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBC4BA3F;
	Thu, 15 Feb 2024 07:28:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4C5D536
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982103; cv=none; b=NJlnHDzcXyQaf1uMLkVRO2KAlZPgH9sEvIFPm4qFzoQcQm7MP7usCV/zHfmNrAnIbcGRIuVg7UiGuqCWplukvgDo8dAnSHYx613SQYiuG2iP1qn9tPqN6JxjZQknQ46bbjsKliC4xXqQS+SzgynnG4TiID2zhq0JvBZAt34JRjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982103; c=relaxed/simple;
	bh=1Lhie39EjH0M+a62bkMYD1a8ACsuhYVLswcsOzihoCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MwssEHxdfQEdF1XIv4MaDqT3xi5ORJ+qG7DV2X5Ws0tgrNZU4Hdh6IfKZNw9259u6fB1X2Kd3lrZi9UbO6pEtLAHnBlbBH6mh4lUFUJJinR5nyd3kFVBmo4SkUanoSP0BgiK0e+gqgBso91efGjW1a1VYs/IyDpWD4Aeu6qxJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41F7S9Ee82417544, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41F7S9Ee82417544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 15:28:09 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 15 Feb 2024 15:28:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 15:28:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 15 Feb 2024 15:28:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8192cu: Fix 2T2R chip type detection
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8192cu: Fix 2T2R chip type detection
Thread-Index: AQHaXomPuhTxoLxdO0i/PyhWN7aGYrELA91A
Date: Thu, 15 Feb 2024 07:28:09 +0000
Message-ID: <d6f1ee01536648dc91183e0d3003fb7d@realtek.com>
References: <ed960059-5c77-422d-ac4e-fe9fc9d0d296@gmail.com>
In-Reply-To: <ed960059-5c77-422d-ac4e-fe9fc9d0d296@gmail.com>
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
IHJ0bDgxOTJjdTogRml4IDJUMlIgY2hpcCB0eXBlIGRldGVjdGlvbg0KPiANCj4gcnRsODE5MmN1
IGhhbmRsZXMgMVQxUiBkZXZpY2VzIChSVEw4MTg4Q1VTKSwgMVQyUiBkZXZpY2VzIChSVEw4MTkx
Q1UpLA0KPiBhbmQgMlQyUiBkZXZpY2VzIChSVEw4MTkyQ1UpLiBUaGUgMlQyUiBkZXZpY2VzIHdl
cmUgaW5jb3JyZWN0bHkgZGV0ZWN0ZWQNCj4gYXMgMVQyUiBiZWNhdXNlIG9mIGEgbWlzdGFrZSBp
biB0aGUgSVNfOTJDXzFUMlIgbWFjcm8uDQo+IA0KPiBUaGUgdmlzaWJsZSBlZmZlY3Qgb2YgdGhp
cyBpcyB0aGF0IHRoZSBmaXJtd2FyZSB3YXMgYWxsb3dlZCB0byB1c2UNCj4gVFggcmF0ZXMgb25s
eSB1cCB0byBNQ1M3Lg0KPiANCj4gRml4IHRoZSBJU185MkNfMVQyUiBtYWNyby4NCj4gDQo+IE5v
dyBteSAyVDJSIGRldmljZSBoYXMgbXVjaCBiZXR0ZXIgdXBsb2FkIHNwZWVkLg0KPiBCZWZvcmU6
IDQ2IE1icHMuDQo+IEFmdGVyOiAgODIgTWJwcy4NCj4gDQo+IEFsc28gZml4IGEgZGVidWcgbWVz
c2FnZSB3aGljaCB3YXMgcHJpbnRpbmcgIlJGXzFUMVIiIGV2ZW4gZm9yIDFUMlINCj4gY2hpcHMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdt
YWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0K
DQoNCg==

