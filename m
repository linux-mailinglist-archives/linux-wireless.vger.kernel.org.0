Return-Path: <linux-wireless+bounces-7858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E78CA625
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 04:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF771F21F18
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 02:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AF7C8D7;
	Tue, 21 May 2024 02:28:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1046C2E9
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258512; cv=none; b=GFCv9lFD4OSX6mjO0MDhyBs7rnsZSUZtQ8KgWSoBtN6DwjZIlBbbAx5D77MJ8DZ4WXwlg34s4PcNGb8RQssWQOE2+p7e6zDqPYkqTnaGF+KjYNUjlYtCsRrsrD53VyQTtM3HSKtankSdR4arv8pKCOexYTpjcJTVpvbf9C3Kzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258512; c=relaxed/simple;
	bh=5XwRaECIDr5AToPXj0kYS6NQJ9+7rnGQpN1a7Qq+w6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OZTWQlGPXaXkpYiWc51DXfZuUeaxgqBQH18+ThkUFs7aDeJ5e+Evp08xiSGDmde/GpMbY8JmiqFGgZdc4ocsxwNufXLvU3PW3jHQKqeKtOvYfnC8OZ8zaelXI/gUym1oxBbf2xfbrZR0unodXRv9mbJX/5gxYigz0xU8Fc5UaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44L2S7p342066393, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44L2S7p342066393
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 10:28:07 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 10:28:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 21 May 2024 10:28:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 21 May 2024 10:28:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v6 04/11] wifi: rtlwifi: Add rtl8192du/phy.{c,h}
Thread-Topic: [PATCH v6 04/11] wifi: rtlwifi: Add rtl8192du/phy.{c,h}
Thread-Index: AQHaqJ+JSmlc8wfM40i0b3hZyc+fILGg+qUg
Date: Tue, 21 May 2024 02:28:06 +0000
Message-ID: <f45fc3ce328544e8b5a8168036718315@realtek.com>
References: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
 <3a2d1e10-95b6-4e33-a679-5ae527f89c12@gmail.com>
In-Reply-To: <3a2d1e10-95b6-4e33-a679-5ae527f89c12@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBjb250YWluIG1vc3RseSB0aGUgY2FsaWJyYXRpb24gYW5kIGNoYW5uZWwgc3dpdGNoaW5nIHJv
dXRpbmVzDQo+IGZvciBSVEw4MTkyRFUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVl
IFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KWy4uLl0NCg0KPiArdm9pZCBydGw5
MmR1X3BoeV9pcV9jYWxpYnJhdGUoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQo+ICt7DQo+ICsg
ICAgICAgbG9uZyByZWdlOTQsIHJlZ2U5YywgcmVnZWE0LCByZWdlYWMsIHJlZ2ViNDsNCj4gKyAg
ICAgICBib29sIGlzMTJzaW11bGFyLCBpczEzc2ltdWxhciwgaXMyM3NpbXVsYXI7DQo+ICsgICAg
ICAgc3RydWN0IHJ0bF9wcml2ICpydGxwcml2ID0gcnRsX3ByaXYoaHcpOw0KPiArICAgICAgIHN0
cnVjdCBydGxfaGFsICpydGxoYWwgPSAmcnRscHJpdi0+cnRsaGFsOw0KPiArICAgICAgIGxvbmcg
cmVnZWJjLCByZWdlYzQsIHJlZ2VjYywgcmVndG1wID0gMDsNCj4gKyAgICAgICBzdHJ1Y3QgcnRs
X3BoeSAqcnRscGh5ID0gJnJ0bHByaXYtPnBoeTsNCj4gKyAgICAgICB1OCBpLCBmaW5hbF9jYW5k
aWRhdGUsIGluZGV4Zm9yY2hhbm5lbDsNCj4gKyAgICAgICBib29sIHBhdGhhX29rLCBwYXRoYl9v
azsNCj4gKyAgICAgICBsb25nIHJlc3VsdFs0XVs4XTsNCj4gKw0KPiArICAgICAgIFJUUFJJTlQo
cnRscHJpdiwgRklOSVQsIElOSVRfSVFLLA0KPiArICAgICAgICAgICAgICAgIklRSzpTdGFydCEh
IWNoYW5uZWwgJWRcbiIsIHJ0bHBoeS0+Y3VycmVudF9jaGFubmVsKTsNCj4gKyAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgODsgaSsrKSB7DQo+ICsgICAgICAgICAgICAgICByZXN1bHRbMF1baV0gPSAw
Ow0KPiArICAgICAgICAgICAgICAgcmVzdWx0WzFdW2ldID0gMDsNCj4gKyAgICAgICAgICAgICAg
IHJlc3VsdFsyXVtpXSA9IDA7DQo+ICsgICAgICAgICAgICAgICByZXN1bHRbM11baV0gPSAwOw0K
PiArICAgICAgIH0NCg0Kbml0OiANCg0KRGVjbGFyZSByZXN1bHRbXVtdIGFzIA0KCWxvbmcgcmVz
dWx0WzRdWzhdID0ge307DQoNClRoZW4sIG5vIG5lZWQgb2YgdGhpcyBsb29wLg0KDQoNCg==

