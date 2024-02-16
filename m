Return-Path: <linux-wireless+bounces-3652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483D857248
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 01:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4251C235D1
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 00:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34E0EC2;
	Fri, 16 Feb 2024 00:10:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671C647
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042212; cv=none; b=K/uu3InnhrvTTlGJO7vHKPbyjLLuTkCN/MvFC+qyBWK8yyb2cHIyspgeHizHOqDsjd6XLE52Mx6UmcNx2qSMzPIerYXQOKQUdboMi813eAAc5+1UweeZlyJbdx3X0Qo4XX+USjUMAOQ877khr3/7zi03BJ/DTjDAcTeZfNs4nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042212; c=relaxed/simple;
	bh=JOzQH+4uRZ3nL0UnH4qPEC7FAbNXkaLv/YQC/z3irBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+5Tj2CIRh3RG0WEjzs6KIt5AyZpAHACuPeS9Znm4Lg5h+Dnpx9tj1KyCid9ZLUJA6LgiLG68QmEMnFXIjmNN0j4stULT8m54SDpr6bsWQflKf3594skf0G9i0mPI2o4Q11oVNjyqRXSgQnqXiDhn2x4qtcfIz/6epD1atELrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41G09ufpE2664099, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41G09ufpE2664099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 08:09:56 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 16 Feb 2024 08:09:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 08:09:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 16 Feb 2024 08:09:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH v2] wifi: rtlwifi: rtl8192cu: Fix TX aggregation
Thread-Topic: [PATCH v2] wifi: rtlwifi: rtl8192cu: Fix TX aggregation
Thread-Index: AQHaYEDqMJnMGkfvokKfO2w1fdR96LEMGEjQ
Date: Fri, 16 Feb 2024 00:09:56 +0000
Message-ID: <a471a6c2b56242bba6b8f593533b1224@realtek.com>
References: <4e936334-5f81-403f-a495-0628ebfb6903@gmail.com>
In-Reply-To: <4e936334-5f81-403f-a495-0628ebfb6903@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMTYs
IDIwMjQgMjo1OCBBTQ0KPiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IExhcnJ5IEZpbmdlciA8TGFycnku
RmluZ2VyQGx3ZmluZ2VyLm5ldD4NCj4gU3ViamVjdDogW1BBVENIIHYyXSB3aWZpOiBydGx3aWZp
OiBydGw4MTkyY3U6IEZpeCBUWCBhZ2dyZWdhdGlvbg0KPiANCj4gcnRsODE5MmN1IGlzIGNoZWNr
aW5nIHJ0bF9tYWMudGlkcyB3aGVuIGRlY2lkaW5nIGlmIGl0IHNob3VsZCBlbmFibGUNCj4gYWdn
cmVnYXRpb24uIFRoaXMgaXMgd3JvbmcgYmVjYXVzZSBydGxfbWFjLnRpZHMgaXMgbm90IGluaXRp
YWxpc2VkDQo+IGFueXdoZXJlLiBDaGVjayBydGxfc3RhX2luZm8udGlkcyBpbnN0ZWFkLCB3aGlj
aCBpcyBpbml0aWFsaXNlZC4NCj4gDQo+IEFsc28sIHdoZW4gZW5hYmxpbmcgYWdncmVnYXRpb24g
YWxzbyBlbmFibGUgUlRTLiBUaGUgdmVuZG9yIGRyaXZlciBkb2VzDQo+IHRoaXMsIG15IHJvdXRl
ciBkb2VzIHRoaXMuIEl0IHNlZW1zIGxpa2UgdGhlIHRoaW5nIHRvIGRvLg0KPiANCj4gQWxzbyBh
bHNvLCBpdCBzZWVtcyByaWdodCB0byBzZXQgdGhlIEFNUERVIGRlbnNpdHkgb25seSB3aGVuIGVu
YWJsaW5nDQo+IGFnZ3JlZ2F0aW9uLg0KPiANCj4gQWxzbyBhbHNvIGFsc28sIGRlbGV0ZSB0aGUg
dW51c2VkIG1lbWJlciBydGxfbWFjLnRpZHMgYW5kIHRoZSB1bnVzZWQNCj4gbWFjcm9zIFJUTF9B
R0dfT04gYW5kIFJUTF9BR0dfT0ZGLg0KPiANCj4gTmF0dXJhbGx5LCB3aXRoIHdvcmtpbmcgQU1Q
RFUgdGhlIGRvd25sb2FkL3VwbG9hZCBzcGVlZHMgYXJlIGJldHRlci4NCj4gQmVmb3JlOiA1OS8z
MiBNYnBzLg0KPiBBZnRlcjogIDY4LzQ2IE1icHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0
ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmct
S2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQpUaGFua3MhIA0KDQo=

