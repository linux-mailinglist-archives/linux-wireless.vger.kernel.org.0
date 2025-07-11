Return-Path: <linux-wireless+bounces-25254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F6B015C7
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 10:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E074A4C60
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7789D23645D;
	Fri, 11 Jul 2025 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BwBcU3nY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF9236457
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221737; cv=none; b=WpYV5qJNSIvcF/g12Gxhmu65rIkUzmXClgIgz2bo6c3v6NJ511kcKboElkct4C84DAYgeh9LHROhPS4Pi95w+dRkTqUHeOS8BdmwNRp2XMYLKceh7KcwgAT1dci1BsUqVPsut4tOj0jbX9PH2wg+HrUGDZENXg4LkLKD6Ln44yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221737; c=relaxed/simple;
	bh=DmnOA7/OEt/LBII566oYepew39ik18GbMM5NMMV1L+0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tPgnYZ2cATbeujYdZ4lu8AYu4Anz6lYFdv0C1w9Rz4dBCSHREci4k+k2atOvykCgrN2T6tgxmdDajz/snN9QLqDEDbyObnLWsSAcb04C1h9y8QmOxxNczbX/ky/OIjQmwprhEAa3w6qfzEFeJH0pdh+1Lc00rb88vFj88qLX/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BwBcU3nY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56B8FOb24700275, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752221724; bh=DmnOA7/OEt/LBII566oYepew39ik18GbMM5NMMV1L+0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BwBcU3nYT3LtgO0NuzpWN6q5IqhBAaUtepeo5HKyhnfvyNGCH85ffT9DjpOM60fgt
	 S1zKEwmOOk8J93ghAvQWaPMq1hGppPFgrNXgiE9PzilebVFEawR5MqSLobJGuRLNNd
	 qNooudUvwlTL9FWZhD6lGsSWEqqnFDagKYGNDhylCkdXkfE5AuFYTEJcU9+6XOzW4Y
	 ZPBO+MmEsnqTKEw6cuwNp6+HKYlxu5hWivtVDuGc+LM5V9LcjdwLXS9q/X9Llv+ETS
	 n3nSH4VandjSotb4AvWU1ICCuPxFII0VpFeh0+cDXRyRrtcvCnvcHD6V1X13ZaIYub
	 BrGTSqxQMe2uQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56B8FOb24700275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 16:15:24 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Jul 2025 16:15:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 11 Jul 2025 16:15:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 11 Jul 2025 16:15:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ansh Gupta <anshgupta1941@outlook.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: rtw89: RTL8852BE Frequent Bluetooth disconnections and occasional Wi-Fi dropouts
Thread-Topic: rtw89: RTL8852BE Frequent Bluetooth disconnections and
 occasional Wi-Fi dropouts
Thread-Index: AQHb6mPDvLIql/k04UqqEVq5M618M7QeMTtQgABOS4CADh7AMA==
Date: Fri, 11 Jul 2025 08:15:22 +0000
Message-ID: <2eb3a7fb50184ab3afd86260db2d99ce@realtek.com>
References: <KL1PR01MB5322B34FA3997A94C6F12A3BB241A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
 <1293cd1841414523ac2d159e69db482f@realtek.com>
 <KL1PR01MB5322C6C207221EED26EE92DCB240A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
In-Reply-To: <KL1PR01MB5322C6C207221EED26EE92DCB240A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
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

QW5zaCBHdXB0YSA8YW5zaGd1cHRhMTk0MUBvdXRsb29rLmNvbT4gd3JvdGU6DQo+IEhlbGxvLA0K
PiANCj4gDQo+ID4gSWYgeW91IHBsYXkgYSBsb2NhbCBtdXNpYyB3aXRob3V0IFdpRmkgY29ubmVj
dGlvbiwgZG9lcyBpdCB3b3JrIHdlbGw/DQo+IA0KPiBXb3JrcyBhIGxvdCBiZXR0ZXIsIG5vIGRp
c2Nvbm5lY3Rpb25zIGV2ZW4gYWZ0ZXIgZ29pbmcgdG8gaWRsZSBtb2RlLg0KPiBUaGVyZSBpcyBz
dGlsbCBhIGRlbGF5IGluIHByb3ZpZGluZyBhdWRpbyBvdXRwdXQsIGJ1dCB0aGUgZGVsYXkgaGFz
DQo+IHJlZHVjZWQgdG8gMSB0byAyIHNlY29uZHMsIGFmdGVyIHdoaWNoIEkgY2FuIGhlYXIuDQo+
IA0KPiANCj4gPiBJZiBvbmx5IFdpRmkgY29ubmVjdGlvbiAod2l0aG91dCBCbHVldG9vdGgpLCBk
b2VzIGNvbm5lY3Rpb24gZHJvcD8NCj4gTm8uDQo+IA0KPiANCj4gPiBCbHVldG9vdGggb3BlcmF0
ZXMgb24gMi40R0h6IGJhbmQsIHNvIGlzIGl0IHBvc3NpYmxlIHRvIGNvbm5lY3QgQVAgb24NCj4g
PiA1IEdIeiBiYW5kPw0KPiANCj4gVGhlIDVHSHogYmFuZCBTU0lEIGRvZXMgbm90IHNob3cgdXAg
aW4gdGhlIGF2YWlsYWJsZSBuZXR3b3JrIGxpc3QgdW50aWwNCj4gSSBhbSAxIHRvIDIgZmVldCBh
d2F5IGZyb20gQVAuIFRoaXMgaGFwcGVucyByZWdhcmRsZXNzIG9mIHdoZXRoZXINCj4gYmx1ZXRv
b3RoIGlzIG9uIG9yIG9mZi4gV2hlbiBjb25uZWN0ZWQsIEkgY2FuIHVzZSB0aGF0IG5ldHdvcmsg
YXQgbm9ybWFsDQo+IHNwZWVkcyBldmVuIGlmIEkgYW0gYWJvdXQgMyBtZXRlcnMgYXdheSBmcm9t
IEFQIHdpdGggYSB3YWxsIGluDQo+IGJldHdlZW4uIEkgaGF2ZSBhIHNlcGFyYXRlIFNTSUQgc2V0
dXAgZm9yIGJvdGggdGhlIDIuNCBhbmQgNUdIeiBiYW5kcy4gSQ0KPiBkaWQgY3Jvc3MgY2hlY2sg
d2l0aCBvdGhlciBkZXZpY2VzLCBhbmQgdGhleSBjb3VsZCBjb25uZWN0IHRvIHRoZSA1R0h6DQo+
IFNTSUQgZnJvbSBhIDMgbWV0ZXIgZGlzdGFuY2UuDQo+IA0KPiBQbGVhc2Ugbm90ZSB0aGF0IEkg
ZG8gbm90IGhhdmUgYWNjZXNzIHRvIHRoaXMgcGFydGljdWxhciBBUCBhbnltb3JlIHRoYW4NCj4g
OSBkYXlzLCBzbyBJIHdvdWxkIG5vdCBiZSBhYmxlIHRvIHByb3ZpZGUgaW5mb3JtYXRpb24gcmVn
YXJkaW5nIGl0IGFmdGVyDQo+IHRoYXQuIFRoZSBpc3N1ZSB3aXRoIGJsdWV0b290aCBhbmQgMi40
R0h6IGJhbmQgaXMgbm90IHVuaXF1ZSB0byB0aGlzIEFQLg0KPiBJIHRyaWVkIHRoaXMgd2l0aCBt
eSBwaG9uZSBob3RzcG90IHVzaW5nIDVHSHogYmFuZCwgYnV0IHRoZSByZXN1bHRzIGFyZQ0KPiBz
YW1lIGZvciBldmVyeSBkZXZpY2UgLSBpdCB3b3VsZCBjb25uZWN0IG9ubHkgd2l0aGluIGEgMSBm
b290IHJhZGl1cy4NCg0KVGhpcyBpcyB2ZXJ5IHdlaXJkLiBBY3R1YWxseSwgU1RBIGNhbiBmaW5k
IEFQIHBhc3NpdmVseSBieSBsaXN0ZW5pbmcgYmVhY29ucy4NCklzIGl0IHBvc3NpYmxlIHRha2Ug
eW91ciBwaG9uZSB3aXRoIGhvdHNwb3Qgb24gNUdIeiBhdCBhIGNsZWFyIHBsYWNlPw0KDQo+IA0K
PiBCZXNpZGVzLCBibHVldG9vdGggd29ya3MgZmluZSBvbiA1R0h6IGJhbmQsIGFsdGhvdWdoIGRl
bGF5IGluIGF1ZGlvDQo+IG91dHB1dCBieSAxIHRvIDIgc2Vjb25kcyBpcyBwcmVzZW50Lg0KPiAN
Cj4gPiBUdXJuIG9mZiBwb3dlciBzYXZlaW5nIGVudGlyZWx5IGJ5DQo+ID4gICAgc3VkbyBpdyB3
bGFuMCBzZXQgcG93ZXJfc2F2ZSBvZmYNCj4gPg0KPiA+IHRvIHNlZSBpZiBlYXNlIHN5bXB0b20u
DQo+IE5vIGltcHJvdmVtZW50cyBub3RpY2VkIGluIGJsdWV0b290aCBhbmQgNUdIeiB3aWZpIGRl
dGVjdGlvbi4NCj4gDQo+IA0KPiBBZGRpdGlvbmFsIGRldGFpbHMgSSB0aG91Z2h0IHdvdWxkIGJl
IHVzZWZ1bDoNCj4gDQo+IA0KPiBJIGhhdmUgYSB3aXJlbGVzcyB1c2IgbW91c2UgYXR0YWNoZWQg
dG8gbXkgbGFwdG9wLA0KPiANCj4gJCBsc3VzYiAtZCAzOTM4OjEwMzENCj4gDQo+IEJ1cyAwMDMg
RGV2aWNlIDAwMzogSUQgMzkzODoxMDMxIE1PU0FSVCBTZW1pLiAyLjRHIFdpcmVsZXNzIE1vdXNl
DQo+IA0KPiBIb3dldmVyLCBkaXNjb25uZWN0aW5nIHRoZSBtb3VzZSBkaWQgbm90IG1ha2UgYSBu
b3RpY2VhYmxlIGRpZmZlcmVuY2UuDQo+IA0KPiANCj4gT2NjYXNpb25hbGx5LCB0aGUgZWFycGhv
bmVzIGRpc2Nvbm5lY3Qgd2hlbiBhdWRpbyBwcm9maWxlcyBhcmUgc3dpdGNoZWQsDQo+IGZyb20g
QTJEUCB0byBIU1AvSEZQIGFuZCB2aWNlIHZlcnNhLg0KPiANCj4gVGhpcyBvbmx5IG9jY3VycmVk
IHdpdGggdGhlIDIuNEdIeiBiYW5kIGFuZCBub3QgdGhlIDVHSHogYmFuZC4gU29mdHdhcmUNCj4g
d2hpY2ggcmVjb3JkcyB2b2ljZSBkb2VzIHRoaXMgcHJvZmlsZSBzd2l0Y2hpbmcuDQoNClRvIGRp
YWdub3NlIEJUIGRpc2Nvbm5lY3Rpb24gcHJvYmxlbSwgcGxlYXNlIGNhcHR1cmUgbG9nIGJ5Og0K
ICAgDQogICB3aGlsZSBbIDEgXTsgZG8gZWNobyAiIjsgZGF0ZSAtUjsgY2F0IC9zeXMva2VybmVs
L2RlYnVnL2llZWU4MDIxMS9waHkwL3J0dzg5L2J0Y19pbmZvIDsgc2xlZXAgMjsgZG9uZSB8IHRl
ZSB4eHh4eC5sb2cNCg0KQXMgSSBhZGQgJ2RhdGUnIGluIGxvZywgcGxlYXNlIG1hbnVhbGx5IHJl
Y29yZCB0aGUgdGltZSBCVCBnZXRzIGRpc2Nvbm5lY3QNCm9yIGFibm9ybWFsLg0KDQpBbHNvLCBy
ZXByb2R1Y2Ugc3ltcHRvbXMgYXQgbGVhc3QgdGhyZWUgdGltZXMuIChtb3JlIGlzIGJldHRlcikN
Cg0KDQpTdW1tYXJpemUgd2hhdCB3ZSBuZWVkOg0KMS4gYnRjX2luZm8gbG9nIChtZW50aW9uZWQg
YWJvdmUpDQoyLiBrZXJuZWwgYW5kIHN5c2xvZyBsb2cgKHdpdGggZGF0ZSB0byBhbGlnbiBidGNf
aW5mbyBsb2cpDQozLiByZXBlYXQgZXhwZXJpbWVudHMgYXQgbGVhc3QgdGhyZWUgdGltZXMsIGFu
ZCByZWNvcmQvc2hhcmUgdGhlDQogICBkaXNjb25uZWN0aW9uL2Fibm9ybWFsIHRpbWUvc3ltcHRv
bSB0byB1cy4NCg0KDQo=

