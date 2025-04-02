Return-Path: <linux-wireless+bounces-21044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99392A78623
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 03:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0977E1886C67
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E9A20EB;
	Wed,  2 Apr 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wwuzJECw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF31FC3
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743557433; cv=none; b=kxq+TcL/lZVClyPWkqifHaWFUM3zlJJZnvfLOJyiZGyxmdjIpZdnutYNQWcFTdO0frIuQcjhkz2UWRkxGP5U1V6ufdmba7mxbrma8q9K9LV8hbiz4RiAwVXJ/scaS4ELXDDQa+B162TO56Wp4p+4AY5n80YhA9ikzLyN/0+cZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743557433; c=relaxed/simple;
	bh=Bac0agy59FiXRNo2LG7rtd1dfx6A8U7Q1vv3/pyDWmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FneQXyRHXLjHtN7lpEDIF+MorVlDiPddJMjGrzp+koA3wflSUCO1YsLDMU0bDrZDgrMyRcCt9rVijV0hTOp4ANiEu1yQqYoGAIBrNWVpm2p1xoomTbyUx9hsdILNCggL1UZ8bhKQZItI4M/NMiIaqxFPH/3j0CmXgkJ3Z43E7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wwuzJECw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5321U7nsC3313599, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743557407; bh=Bac0agy59FiXRNo2LG7rtd1dfx6A8U7Q1vv3/pyDWmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wwuzJECwi5+Md89zQUQ3HaQZUthQRhNqdYsh2EmnArthPssFDAXFH80sBtux1yej4
	 TmRZnDytsikqpc6E0sYm5rubQ0JlTgHYAibOCx4s0QSsNq9aEcW8eP58YcqwO8EJ2w
	 +X85kQCpoWcrrdpUKZqpCh0B7Y8hoMBuw+ZjQmn0iAUhFVHcOyvoJaORaSt7u8jPD8
	 gjsrtUG/ZURA7RqNqr3svQmA6VfgXUqgWgUb3+ywOrQKtp4u711Zq/OLgFFMGcK8jj
	 S7kQJ8z0MxXt43hmeMeFY1scIoEwLktwRD6heCKoZJfp8GUk941K7NBBFq5tMTMWcM
	 7MVivBMGwDJlg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5321U7nsC3313599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 09:30:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Apr 2025 09:30:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 2 Apr 2025 09:30:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 2 Apr 2025 09:30:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shayne Chen <shayne.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai
	<evelyn.tsai@mediatek.com>,
        linux-mediatek
	<linux-mediatek@lists.infradead.org>,
        StanleyYP Wang
	<StanleyYP.Wang@mediatek.com>
Subject: RE: [PATCH 09/10] wifi: mt76: mt7996: rework background radar check for mt7990
Thread-Topic: [PATCH 09/10] wifi: mt76: mt7996: rework background radar check
 for mt7990
Thread-Index: AQHbn6XvD6dY9NzS8E2HfbUbQJUEZrOMwhhggAGRpICAAUkWMA==
Date: Wed, 2 Apr 2025 01:30:08 +0000
Message-ID: <44832c3d3a74429aaa095bdba4573391@realtek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
	 <20250328055058.1648755-10-shayne.chen@mediatek.com>
	 <59abf964667144b0ab10220e41b6b821@realtek.com>
 <29344a3f054368ae948415d6183365a09d1fe6d5.camel@mediatek.com>
In-Reply-To: <29344a3f054368ae948415d6183365a09d1fe6d5.camel@mediatek.com>
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

U2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQoNCj4gT24gTW9u
LCAyMDI1LTAzLTMxIGF0IDA1OjU1ICswMDAwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gDQo+
ID4gDQo+ID4gU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+
ID4gDQo+ID4gWy4uLl0NCj4gPiANCj4gPiA+ICsNCj4gPiA+ICtib29sIG10Nzk5Nl9lZXByb21f
aGFzX2JhY2tncm91bmRfcmFkYXIoc3RydWN0IG10Nzk5Nl9kZXYgKmRldikNCj4gPiA+ICt7DQo+
ID4gPiArICAgICAgIHN3aXRjaCAobXQ3Nl9jaGlwKCZkZXYtPm10NzYpKSB7DQo+ID4gPiArICAg
ICAgIGNhc2UgTVQ3OTk2X0RFVklDRV9JRDoNCj4gPiA+ICsgICAgICAgICAgICAgICBpZiAoZGV2
LT52YXIudHlwZSA9PSBNVDc5OTZfVkFSX1RZUEVfMjMzKQ0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+
ID4gKyAgICAgICBjYXNlIE1UNzk5Ml9ERVZJQ0VfSUQ6DQo+ID4gPiArICAgICAgICAgICAgICAg
aWYgKGRldi0+dmFyLnR5cGUgPT0gTVQ3OTkyX1ZBUl9UWVBFXzIzKQ0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gKyAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiA+ID4gKyAgICAgICBjYXNlIE1UNzk5MF9ERVZJQ0VfSUQ6IHsNCj4gPiA+ICsgICAgICAg
ICAgICAgICB1OCBwYXRoLCByeF9wYXRoLCBuc3MsICplZXByb20gPSBkZXYtDQo+ID4gPiA+bXQ3
Ni5lZXByb20uZGF0YTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgICAgICAgICBtdDc5OTZfZWVw
cm9tX3BhcnNlX3N0cmVhbShlZXByb20sIE1UX0JBTkQxLCAmcGF0aCwNCj4gPiA+ICZyeF9wYXRo
LCAmbnNzKTsNCj4gPiA+ICsgICAgICAgICAgICAgICAvKiBEaXNhYmxlIGJhY2tncm91bmQgcmFk
YXIgY2FwYWJpbGl0eSBpbiAzVDNSICovDQo+ID4gPiArICAgICAgICAgICAgICAgaWYgKHBhdGgg
PT0gMyB8fCByeF9wYXRoID09IDMpDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gZmFsc2U7DQo+ID4gPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gPiArICAgICAgIH0N
Cj4gPiANCj4gPiBUaGUgaW5kZW50YXRpb24gb2YgY2xvc2UgYnJhY2UgbG9va3Mgd2VpcmQuDQo+
IA0KPiBXaWxsIGZpeCBpdCwgdGhhbmtzLg0KPiA+IA0KPiA+IFNpbmNlIC1XZGVjbGFyYXRpb24t
YWZ0ZXItc3RhdGVtZW50IGlzIGRyb3BwZWQsIEkgdGhpbmsgY29tcGlsZXJzDQo+ID4gd2lsbCBu
b3QNCj4gPiB3YXJuIHdpdGhvdXQgdGhlIGJyYWNlcy4gQnV0IG5vdGUgdGhhdCBpdCBpcyBzdGls
bCBub3QgcmVjb21tZW5kZWQgdG8NCj4gPiBwdXQgZGVjbGFyYXRpb25zIGluIHRoZSBtaWRkbGUu
DQo+ID4gDQo+IFNpbmNlIHRob3NlIHZhcmlhYmxlcyBhcmUgY3VycmVudGx5IG9ubHkgdXNlZCBi
eSBtdDc5OTAgY2FzZSwgSSB0aGluaw0KPiB0aGV5IGNhbiBiZSBwdXR0aW5nIHRoZXJlIGZvciB0
aGUgbW9tZW50Lg0KDQpUaGF0IGxvb2tzIG5vdCB2ZXJ5IG5hdHVyYWwgdGhvdWdoLi4uIA0KDQpJ
biBmYWN0LCB0aGUgZGVjbGFyYXRpb25zIGVpdGhlciBpbiBiZWdpbm5pbmcgb2YgdGhpcyBmdW5j
dGlvbiBvciBhdCB0aGUNCm10Nzk5MCBjYXNlLCB0aGUgZnJhbWUgc2l6ZSAoc3RhY2spIGFyZSB0
aGUgc2FtZS4gDQoNCj4gDQo+ID4gPiArICAgICAgIGRlZmF1bHQ6DQo+ID4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gKyAgICAgICB9DQo+ID4gPiArDQo+ID4gPiArICAg
ICAgIHJldHVybiB0cnVlOw0KPiA+ID4gK30NCj4gPiANCj4gPiANCj4gPg0K

