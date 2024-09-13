Return-Path: <linux-wireless+bounces-12821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35058977686
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 03:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4F81C241F1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126FBA37;
	Fri, 13 Sep 2024 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jpZWlYnf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ACBBA33
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192233; cv=none; b=QMuExTxMtUicHIpOxaVAf9YKkJ94KEMnPMF1GANwd8rykwftGssitsRRvuRlGb7uj9tkzaGqAur6Tdd+Nwsl5nN8Zyo4j8TVHgxHwKlHzWJdo01DiyzyNCa4IkwiO//OcSRBRQCUM/twXKSUj0Nmc5MkopF3DytH6YrXq39mXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192233; c=relaxed/simple;
	bh=12TbmWAZkJm4nN+F3CwqwSbpsZz7xY9AhPn7eyW/dIY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=to8QHOgTFBvY5EMxY9COwmCkF1YvgoOIriRQd2fOXriVvC7oH5BaRkJadJraIiJIzVZo/pZVm98+tOPn82tF3oTEr+Btyta1u7CJslLXT64icpCAtyMF4F0M8sGittnGZsHPEgi/TLyd1ERfwp9vFYx15NAwtwWjYBmMxmyuRoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jpZWlYnf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48D1oNYn92135781, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726192223; bh=12TbmWAZkJm4nN+F3CwqwSbpsZz7xY9AhPn7eyW/dIY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jpZWlYnfEZ2ckoh0KsVU5mvi1qM21O/2r6LXY1TMTf/sg9FyUxCa9txjuTcGICzgU
	 MW1a5+10/E6Mde8clIB/8gE3MZo4DnGVOt8PuAUF0fkh4JTLQqbSKlceHhJDAHtpRG
	 1xGDMMmr+TvJy/9SlGIcid3nfHBmbyBLzBFWzaN5yT/LNPwcB0q+DZRSx4/M76nbPk
	 ZWN58DCqvdrsDzF46BAnvcz7vdyuVEZXNL9LKqbJQ6MYe/pu582gNUgO6XpJ3DhgQv
	 WPrAhRoBkn4jkCEBBCoue1qBl2+8u8geWPEGCLT9A2+O242sRgcDsBVhPFaR9/bTnZ
	 FlzrOacbHMtSw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48D1oNYn92135781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 09:50:23 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 09:50:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 13 Sep 2024 09:50:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 13 Sep 2024 09:50:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
Thread-Topic: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
Thread-Index: AQHa7DKP0miyRAHIW0qWSqezSXaH97IpJM5AgBHQWoCAFW7yIIADltQAgAEjSvA=
Date: Fri, 13 Sep 2024 01:50:22 +0000
Message-ID: <f583e9470ca84234ad2e00f3a0371664@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <f25d00ab-4481-4540-956b-bc1028a501e1@gmail.com>
 <e365c61d730d4f49915b543dcb0063d5@realtek.com>
 <dafaac0c-fb55-4406-b8ff-69aa66d3fd06@gmail.com>
 <1aca96c68f914f90b6d1baf8780e6ce4@realtek.com>
 <bebaa40a-1c7a-4b1e-99cd-7c7aac7c76f4@gmail.com>
In-Reply-To: <bebaa40a-1c7a-4b1e-99cd-7c7aac7c76f4@gmail.com>
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

PiA+DQo+ID4gI2RlZmluZSBSRUdfM1dJUkVfU1dBIDB4YzAwDQo+ID4gI2RlZmluZSBSRUdfM1dJ
UkVfU1dCIDB4ZTAwDQo+ID4NCj4gPiAoMHhjMDAgcGFnZSBmb3IgcGF0aCBBLCAweGUwMCBwYWdl
IGZvciBwYXRoIEIpDQo+ID4NCj4gDQo+IFByZXZpb3VzbHksIHlvdSBjYWxsZWQgMHhlMDAgUkVH
X0hTU0lfV1JJVEVfQi4gQXJlIGJvdGggbmFtZXMgY29ycmVjdD8NCj4gKEknbSBub3Qgc3VyZSB3
aHkgSSBwdXQgMHhjMDAgYW5kIDB4ZTAwIG9uIHRoZSBsaXN0IGlmIHlvdSBhbHJlYWR5IGdhdmUN
Cj4gdGhlbSBhIG5hbWUuKQ0KDQpJbiBmYWN0LCB0aGVyZSBpcyBubyBfZm9ybWFsXyBuYW1lcyBm
b3IgUEhZIHJlZ2lzdGVycywgc28gSSBnYXZlIG5hbWVzIGJ5DQphYmJyZXZpYXRpb24gbmFtZSBm
cm9tIFJUTCBjb2RlLiBQcmV2aW91c2x5IEkgbWF5IHJlZmVyZW5jZSB0byB2ZW5kb3INCmRyaXZl
cnMgaW5zdGVhZC4gSnVzdCBjaG9vc2Ugb25lIHlvdSBsaWtlLiANCg0KPiA+PiAweGU5MA0KPiA+
DQo+ID4gI2RlZmluZSBSRUdfUFJFRElTVEIgMHhlOTANCj4gPg0KPiANCj4gSSBwdXQgMHhlOTAg
b24gdGhlIGxpc3QgYnkgbWlzdGFrZS4gV2UgYWxyZWFkeSBoYXZlIGEgbmFtZSBmb3IgaXQNCj4g
aW4gdGhlIG9mZmljaWFsIGRyaXZlcjoNCj4gDQo+IC4vaW5jbHVkZS9IYWw4ODEyUGh5UmVnLmg6
NjY6I2RlZmluZSByQl9MU1NJV3JpdGVfSmFndWFyICAgICAgICAgICAgICAgICAgICAgICAgMHhl
OTAgLyogUkYgd3JpdGUgYWRkciAqLw0KPiANCj4gSSB0cmFuc2xhdGVkIHRoYXQgYXMgUkVHX0xT
U0lfV1JJVEVfQi4gSXMgUkVHX1BSRURJU1RCIGFsc28gYSB2YWxpZA0KPiBuYW1lPyBEbyB3ZSBu
ZWVkIGJvdGggbmFtZXM/DQoNCkZvciB0aGUgdXNlIGNhc2Ugb2YgMHhlOTAgaW4gcnR3ODgxMmFf
aXFrX3R4X2ZpbGwoKToNCg0KICAgcnR3X3dyaXRlMzJfbWFzayhydHdkZXYsIDB4YzkwLCBCSVQo
NyksIDB4MSk7DQoNCiJSRiB3cml0ZSBhZGRyIiBzZWVtcyBub3QgcmVhc29uYWJsZS4gSSBzdWdn
ZXN0IHRvIGRlZmluZSBib3RoIGZvciB0aGlzIGNhc2UuIA0KDQoNCj4gU29tZSBvZiB0aGVzZSBu
YW1lcyBhcmUgdmVyeSBkaWZmZXJlbnQgZnJvbSB0aGVpciBjb3VudGVycGFydHMNCj4gZnJvbSBw
YWdlIEMuIEluIHlvdXIgcHJldmlvdXMgZW1haWwgeW91IHNhaWQ6DQo+IA0KPiA+IEkgdGhpbmsg
d2UgY2FuIHJldXNlIGV4aXN0aW5nIGRlZmluaXRpb25zOg0KPiA+DQo+ID4gcnR3ODcyM3guaDoj
ZGVmaW5lIFJFR19PRkRNXzBfWEFfVFhfSVFfSU1CQUxBTkNFICAgICAgICAweDBjODANCj4gPiBy
dHc4NzAzYi5oOiNkZWZpbmUgUkVHX09GRE0wX0FfVFhfQUZFIDB4MGM4NA0KPiA+IHJ0dzg3MjN4
Lmg6I2RlZmluZSBSRUdfT0ZETV8wX1hCX1RYX0lRX0lNQkFMQU5DRSAgICAgICAgMHgwYzg4DQo+
ID4NCj4gPiAjZGVmaW5lIFJFR19UU1NJX1RSS19TVyAweGM4Yw0KPiA+DQo+ID4gcnR3ODgyMWEu
aDojZGVmaW5lIFJFR19UWEFHQ0lEWCAgICAgICAgICAgICAgICAgICAgICAgICAweGM5NA0KPiAN
Cj4gQ2FuIHdlIHJldXNlIHRoZXNlIGRlZmluaXRpb25zPw0KDQpZZXMuIFlvdSBjYW4gcmV1c2Ug
ZXhpc3RpbmcgZmlyc3QuIEZvciBub24tZXhpc3RpbmcgZGVmaW5pdGlvbiwgdXNlIHRoZSBuYW1l
cw0KSSBnYXZlIGluIHRoaXMgdGhyZWFkLiANCg0KQmFzaWNhbGx5IHdlIGNhbiBoYXZlIHR3byB3
YXlzIHRvIGhhdmUgbmFtZXMuIE9uZSBpcyBmcm9tIHZlbmRvciBkcml2ZXJzLCBhbmQNCnRoZSBv
dGhlciBpcyBmcm9tIGFiYnJldmlhdGlvbiBuYW1lIG9mIFJUTCBjb2RlLCB3aGljaCBiaXQgbmFt
ZSBpbnN0ZWFkIG9mDQp3aG9sZSByZWdpc3RlciBuYW1lIGlzIGdpdmVuLiBBbHNvIEknbSBub3Qg
dmVyeSBmYW1pbGlhciB3aXRoIHRoZSBmdW5jdGlvbmFsaXR5LA0Kc28gSSBkaWQganVzdCBwYXN0
ZSByZWFzb25hYmxlIG5hbWVzIGZvciB1bmRlZmluZWQgbWFnaWMgbnVtYmVycy4NCg0KPiA+Pj4+
ICsNCj4gPj4+PiArY29uc3Qgc3RydWN0IHJ0d19jaGlwX2luZm8gcnR3ODgxMmFfaHdfc3BlYyA9
IHsNCj4gPj4+DQo+ID4+PiBJcyBpdCBwb3NzaWJsZSBtb3ZpbmcgODgxMmEgdG8gaW5kaXZpZHVh
bCBmaWxlPw0KPiA+Pj4gU2luY2UgeW91IGhhdmUgcnR3ODgxMmF1LmMgYW5kIHJ0dzg4MjFhdS5j
Lg0KPiA+Pj4NCj4gPj4NCj4gPj4gSSB0aGluayBpdCBpcyBwb3NzaWJsZS4gQnV0IG1vc3Qgb2Yg
dGhlIGNvZGUgaXMgY29tbW9uIHRvIGJvdGggY2hpcHMuDQo+ID4+IE9ubHkgdGhlIElRIGNhbGli
cmF0aW9uIGNvdWxkIGJlIG1vdmVkLg0KPiA+DQo+ID4gWWVwLCBkZXBlbmQgb24gaG93IG11Y2gg
SVFLIGNvZGUgZWNobyBjaGlwIGhhcy4NCj4gPg0KPiANCj4gVGhlIElRIGNhbGlicmF0aW9uIGZv
ciBSVEw4ODEyQVUgaXMgYWJvdXQgNzAwIGxpbmVzLg0KDQpydHc4ODEyYXUgIC0tLS0tPiAoYSkg
cnR3ODgxMmEgDQogICAgICAgICAgICAgICAgICAgICAgICB8DQogICAgICAgICAgICAgICAgICAg
ICAgICB2DQogICAgICAgICAgICAgICAgICAoYikgcnR3ODgyMWFfY29tbW9uICAoaGFyZCB0byBn
aXZlIGEgbmFtZSkNCiAgICAgICAgICAgICAgICAgICAgICAgIF4NCiAgICAgICAgICAgICAgICAg
ICAgICAgIHwNCnJ0dzg4MjFhdSAgLS0tLS0+IChjKSBydHc4ODIxYQ0KDQpQdXQgYWxsIGNvbW1v
biBjb2RlIHRvIChiKS4gSVFLIGNvZGUgaW4gKGEpIG9yIChjKS4gDQoNCkkgZmVlbCB5b3UgaGF2
ZSB0aG91Z2h0IGFib3ZlIHBpY3R1cmUgYWxyZWFkeS4gV2hhdCBhcmUgcHJvYmxlbXMgd2Ugd2ls
bCBlbmNvdW50ZXI/DQpNYW55IGV4cG9ydCBzeW1ib2xzPyBJZiBzbywgaG93IGFib3V0IGJlbG93
Pw0KDQpydHc4ODEyYXUgIC0tLS0tPiAoMSkgcnR3ODgxMmEgDQogICAgKy0tLS0tLS0tLSsNCiAg
ICAgICAgICAgICAgKy0+ICgyKSBydHc4ODIxYV9jb21tb24gIChoYXJkIHRvIGdpdmUgYSBuYW1l
KQ0KICAgICstLS0tLS0tLS0rDQpydHc4ODIxYXUgIC0tLS0tPiAoMykgcnR3ODgyMWENCg0KUHV0
IHJ0dzg4MTJhX2h3X3NwZWMgYW5kIHJ0dzg4MjFhX2h3X3NwZWMgaW4gKDIpLiBPbmx5IElRSyBj
b2RlIGluICgxKSBhbmQgKDMpDQpyZXNwZWN0aXZlbHksIGFuZCBleHBvcnQgSVFLIGVudHJ5IG9u
bHkuIERvZXMgaXQgd29yaz8NCg0KDQo=

