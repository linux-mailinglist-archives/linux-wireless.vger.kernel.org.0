Return-Path: <linux-wireless+bounces-25560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 099AAB0816B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 02:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4F71C40440
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 00:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CD11B960;
	Thu, 17 Jul 2025 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AlhwQTDI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A131799F
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752712607; cv=none; b=PvI9kMV5sAdFQkIapl5BrO1/w+2rHSi+AG30YLG0guvt+GdoH7l4V0azfk9jHKeC4Q97lFKwqlKhc+6WI92e9Y/XsxAvLPwQJNYWMEhsd49/qSNb/Si1WcMXiYuAQ6jFFL8Vj3ICjCOIsiA8eHSD6e/xCPhHfYq/d+7i/NrEhIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752712607; c=relaxed/simple;
	bh=+tceLEvUqnMxJOBKRkeOkyaC5UAFfNguwsocxEogqPw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BBGJrqSU7r9EWFzkrfOi0F+TR7QyIF2vOpBwYA8HtIn/e3mzW+eibzznP4uIUERw18XX4k93Xre6JStdHPfW8EE9JfR+IkExvjARdnYHBvR19YCBYXUjjaKA2Psfiv0FA90Uwe0W5Co8OSb+HVvtIDP7kvpDOh63zCLMTZuIgiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AlhwQTDI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56H0aa5sB3161944, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752712596; bh=+tceLEvUqnMxJOBKRkeOkyaC5UAFfNguwsocxEogqPw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=AlhwQTDILAvhsEqQdTjMka6nqn1o+MBrNj50r7I1yhKiRMrq/EK1QZj/xebm3DBvv
	 BduiRjm47zE/QbwBsFRihWCH6IEWKv+xCv2DAPIQzuHf3njVNTeVlAt0yfrJqJEb0D
	 Czrs/Om1klEPlycbJC+SGFh+ws+BH7+eKMbeyEbYfbYHPsbmX88iwUmcEFI/leu/Gn
	 WWc4JSOFo3hx5/2pbRLDZe3mCQAq7MerOkRRxYCMLESq8cCOzHoShUyhI8I/y5lGR4
	 2DNLnzATMU/af8iBENSoQy23QDUCUvnX4HYYUuIyMUnsnA55MXrC/q9TDiC3tLDVir
	 8dhj6sdzDfGLA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56H0aa5sB3161944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 08:36:36 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 08:36:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 17 Jul 2025 08:36:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Thu, 17 Jul 2025 08:36:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ansh Gupta <anshgupta1941@outlook.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: rtw89: RTL8852BE Frequent Bluetooth disconnections and occasional Wi-Fi dropouts
Thread-Topic: rtw89: RTL8852BE Frequent Bluetooth disconnections and
 occasional Wi-Fi dropouts
Thread-Index: AQHb6mPDvLIql/k04UqqEVq5M618M7QeMTtQgABOS4CADh7AMIAH4PqAgAEP+yA=
Date: Thu, 17 Jul 2025 00:36:36 +0000
Message-ID: <aa9ee67a760847489af2bd0ee4dd97bb@realtek.com>
References: <KL1PR01MB5322B34FA3997A94C6F12A3BB241A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
 <1293cd1841414523ac2d159e69db482f@realtek.com>
 <KL1PR01MB5322C6C207221EED26EE92DCB240A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
 <2eb3a7fb50184ab3afd86260db2d99ce@realtek.com>
 <KL1PR01MB5322194DAB6251979D1A3EC1B256A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
In-Reply-To: <KL1PR01MB5322194DAB6251979D1A3EC1B256A@KL1PR01MB5322.apcprd01.prod.exchangelabs.com>
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

QW5zaCBHdXB0YSA8YW5zaGd1cHRhMTk0MUBvdXRsb29rLmNvbT4gd3JvdGU6DQo+IE9uIDExLzA3
LzI1IDEzOjQ1LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gVGhpcyBpcyB2ZXJ5IHdlaXJkLiBB
Y3R1YWxseSwgU1RBIGNhbiBmaW5kIEFQIHBhc3NpdmVseSBieSBsaXN0ZW5pbmcgYmVhY29ucy4N
Cj4gPiBJcyBpdCBwb3NzaWJsZSB0YWtlIHlvdXIgcGhvbmUgd2l0aCBob3RzcG90IG9uIDVHSHog
YXQgYSBjbGVhciBwbGFjZT8NCj4gDQo+IEkgdGVzdGVkIG15IHBob25lIHdpdGggaG90c3BvdCBv
biA1R0h6IHdpdGggYW5vdGhlciBwaG9uZSBmb3IgYSAzIGZlZXQNCj4gZGlzdGFuY2UsIGFuZCB0
aGUgaG90c3BvdCBzaG93cyB1cCBvbiB0aGUgb3RoZXIgcGhvbmUuIEkgd2lsbCB0ZXN0IHRoaXMN
Cj4gZnVydGhlciwgc2luY2UgSSBkaWQgbm90IGhhdmUgZWFzeSBhY2Nlc3MgdG8gYSBjbGVhciBs
b2NhdGlvbiBlYXJsaWVyLg0KPiANCj4gPiBUbyBkaWFnbm9zZSBCVCBkaXNjb25uZWN0aW9uIHBy
b2JsZW0sIHBsZWFzZSBjYXB0dXJlIGxvZyBieToNCj4gPg0KPiA+ICAgICB3aGlsZSBbIDEgXTsg
ZG8gZWNobyAiIjsgZGF0ZSAtUjsgY2F0IC9zeXMva2VybmVsL2RlYnVnL2llZWU4MDIxMS9waHkw
L3J0dzg5L2J0Y19pbmZvIDsgc2xlZXAgMjsgZG9uZQ0KPiB8IHRlZSB4eHh4eC5sb2cNCj4gPg0K
PiA+IEFzIEkgYWRkICdkYXRlJyBpbiBsb2csIHBsZWFzZSBtYW51YWxseSByZWNvcmQgdGhlIHRp
bWUgQlQgZ2V0cyBkaXNjb25uZWN0DQo+ID4gb3IgYWJub3JtYWwuDQo+ID4NCj4gPiBBbHNvLCBy
ZXByb2R1Y2Ugc3ltcHRvbXMgYXQgbGVhc3QgdGhyZWUgdGltZXMuIChtb3JlIGlzIGJldHRlcikN
Cj4gPg0KPiA+DQo+ID4gU3VtbWFyaXplIHdoYXQgd2UgbmVlZDoNCj4gPiAxLiBidGNfaW5mbyBs
b2cgKG1lbnRpb25lZCBhYm92ZSkNCj4gPiAyLiBrZXJuZWwgYW5kIHN5c2xvZyBsb2cgKHdpdGgg
ZGF0ZSB0byBhbGlnbiBidGNfaW5mbyBsb2cpDQo+ID4gMy4gcmVwZWF0IGV4cGVyaW1lbnRzIGF0
IGxlYXN0IHRocmVlIHRpbWVzLCBhbmQgcmVjb3JkL3NoYXJlIHRoZQ0KPiA+ICAgICBkaXNjb25u
ZWN0aW9uL2Fibm9ybWFsIHRpbWUvc3ltcHRvbSB0byB1cy4NCj4gDQo+IEkgaGF2ZSBhdHRhY2hl
ZCB0aGUgbG9ncy56aXAgZmlsZSBmb3IgNSBzdWNoIGV4cGVyaW1lbnRzLCBmb2xsb3dpbmcgYXJl
DQo+IHRoZSBjb250ZW50cyBvZiB0aGUgcmVhZG1lIGZpbGUsIHByb3ZpZGluZyB0aW1lc3RhbXBz
IGF0IHdoaWNoIGFibm9ybWFsDQo+IGJlaGF2aW9yIHdhcyBub3RlZDoNCj4gDQo+IGluc3RhbmNl
czoNCj4gDQo+IFtCXSBmb3IgYmx1ZXRvb3RoIGRpc2Nvbm5lY3QgYW5kIHJlY29ubmVjdA0KPiBb
V10gZm9yIHdpZmkgZGlzY29ubmVjdCBhbmQgcmVjb25uZWN0DQo+IA0KPiAoMSkgYXQgMTUvNy8y
NSB0aW1lIDIxOjUwOjI2IFtCXQ0KPiAoMikgYXQgMTUvNy8yNSB0aW1lIDIyOjA1OjMwIFtXXSBh
bmQgMjI6MDY6MDAgW0JdDQo+ICgzKSBhdCAxNS83LzI1IHRpbWUgMjI6MTM6MzIgW0JdIGFuZCAy
MjoxNToxNiBbV10NCj4gKDQpIGF0IDE1LzcvMjUgdGltZSAyMjoyNToyNiBbQl0gYW5kIDIyOjI2
OjA5IFtXXQ0KPiAoNSkgYXQgMTUvNy8yNSB0aW1lIDIyOjQ3OjQxIFtCXSwgMjI6NDg6MTkgW1dd
LCAyMjo0OTozNiBbV10gYW5kDQo+IDIyOjUwOjQ3IFtXXQ0KPiANCj4gTW9zdCBvZiB0aGUgdGlt
ZXMsIGEgYmx1ZXRvb3RoIGRpc2Nvbm5lY3Rpb24gd2FzIGZvbGxvd2VkIGJ5IGEgd2lmaQ0KPiBk
aXNjb25uZWN0aW9uIGJ5IDEwLTIwIHNlY29uZHMuIERpc2Nvbm5lY3Rpb24gYW5kIHJlY29ubmVj
dGlvbiBmb3IgYm90aA0KPiBibHVldG9vdGggYW5kIHdpZmksIHRha2VzIDUtMTAgc2Vjb25kcy4g
RHJpdmVyIHZlcnNpb24gaXMgc2FtZSBhcyBiZWZvcmUuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBs
b2dzLiBJIGhhdmUgcHJvdmlkZWQgdGhlbSBmb3IgaW50ZXJuYWwgZXhwZXJ0cyBmb3IgYW5hbHlz
aXMuDQpQbGVhc2UgZ2l2ZSB0aGVtIHNvbWUgdGltZS4gSWYgdGhleSBuZWVkIG1vcmUgaW5mbywg
SSdsbCBsZXQgeW91IGtub3cuDQoNCg0K

