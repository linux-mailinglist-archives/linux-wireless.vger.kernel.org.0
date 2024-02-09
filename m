Return-Path: <linux-wireless+bounces-3382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DAF84F097
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 08:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731991C218A9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 07:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070CF657A8;
	Fri,  9 Feb 2024 07:04:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38328DC0;
	Fri,  9 Feb 2024 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707462248; cv=none; b=gbSKJbnifsvxsgaNu++0tCNuDkI9rbWhU8NP6rJxyWkW5AIHjIL0BT90tr0kX3CV669C20briveiehzcBIvCNOSIfSF1hjso1JOQHepjWqzOWhuYkDB+2fkLRqjINNHphoj0TVaVR6tixVAZuPFxPdJ5zAGujiRGv8xZxgY0820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707462248; c=relaxed/simple;
	bh=ID6r5uLg88QSlNWzQ0Q0CTm3PFTfLres5/WxNG7rsjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m1LPPNtdOSJA1Jq86djbM6Gy16JEeEtZBXiMTmYzY2zsIedydYnfmKMRuXqfvhoXbLJf8ydnHhDMS+ENleLW2nPpP09NjcxHfcBKb7+m/aiCzPNQndoSjwOJBVvh1zuHx9onxVRT00gBhFAf5+LE9nvG1uYsuC0/WF8c6lsaPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41973sdG6549921, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41973sdG6549921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 15:03:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 9 Feb 2024 15:03:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 15:03:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 9 Feb 2024 15:03:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>, "lkp@intel.com" <lkp@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin
 Yang" <kevin_yang@realtek.com>,
        "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>,
        Bernie Huang <phhuang@realtek.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Gary Chang
	<gary.chang@realtek.com>
Subject: Re: [PATCH 02/11] wifi: rtw89: load BB parameters to PHY-1
Thread-Topic: [PATCH 02/11] wifi: rtw89: load BB parameters to PHY-1
Thread-Index: AQHaWja791ThhqIe+keGfQW9KJDaBbEAqXAAgABoJAA=
Date: Fri, 9 Feb 2024 07:03:49 +0000
Message-ID: <a3c4c6bbcb7282767883bfcb387ceaf48a0d359f.camel@realtek.com>
References: <20240208022857.14379-3-pkshih@realtek.com>
	 <202402090838.S5xcKIlg-lkp@intel.com>
In-Reply-To: <202402090838.S5xcKIlg-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <17EC0518B516064096A726FD5F0CD11B@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI0LTAyLTA5IGF0IDA4OjUwICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gDQo+IA0KPiA+ID4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9waHku
YzoxMDQ3Ojc6IHdhcm5pbmc6IGNhc3QgdG8gc21hbGxlciBpbnRlZ2VyIHR5cGUgJ2VudW0NCj4g
PiA+IHJ0dzg5X3BoeV9pZHgnIGZyb20gJ3ZvaWQgKicgWy1Xdm9pZC1wb2ludGVyLXRvLWVudW0t
Y2FzdF0NCj4gICAgIDEwNDcgfCAgICAgICAgICAgICAgICAgaWYgKChlbnVtIHJ0dzg5X3BoeV9p
ZHgpZXh0cmFfZGF0YSA9PSBSVFc4OV9QSFlfMSkNCj4gICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAgICAxIHdhcm5pbmcgZ2Vu
ZXJhdGVkLg0KPiANCj4gDQo+IHZpbSArMTA0NyBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg5L3BoeS5jDQo+IA0KPiAgIDEwMjINCj4gICAxMDIzICBzdGF0aWMgdm9pZCBydHc4OV9w
aHlfY29uZmlnX2JiX3JlZyhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsDQo+ICAgMTAyNCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHJ0dzg5X3JlZzJf
ZGVmICpyZWcsDQo+ICAgMTAyNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZW51bSBydHc4OV9yZl9wYXRoIHJmX3BhdGgsDQo+ICAgMTAyNiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdm9pZCAqZXh0cmFfZGF0YSkNCj4gICAxMDI3ICB7DQo+ICAgMTAy
OCAgICAgICAgICB1MzIgYWRkcjsNCj4gICAxMDI5DQo+ICAgMTAzMCAgICAgICAgICBpZiAocmVn
LT5hZGRyID09IDB4ZmUpIHsNCj4gICAxMDMxICAgICAgICAgICAgICAgICAgbWRlbGF5KDUwKTsN
Cj4gICAxMDMyICAgICAgICAgIH0gZWxzZSBpZiAocmVnLT5hZGRyID09IDB4ZmQpIHsNCj4gICAx
MDMzICAgICAgICAgICAgICAgICAgbWRlbGF5KDUpOw0KPiAgIDEwMzQgICAgICAgICAgfSBlbHNl
IGlmIChyZWctPmFkZHIgPT0gMHhmYykgew0KPiAgIDEwMzUgICAgICAgICAgICAgICAgICBtZGVs
YXkoMSk7DQo+ICAgMTAzNiAgICAgICAgICB9IGVsc2UgaWYgKHJlZy0+YWRkciA9PSAweGZiKSB7
DQo+ICAgMTAzNyAgICAgICAgICAgICAgICAgIHVkZWxheSg1MCk7DQo+ICAgMTAzOCAgICAgICAg
ICB9IGVsc2UgaWYgKHJlZy0+YWRkciA9PSAweGZhKSB7DQo+ICAgMTAzOSAgICAgICAgICAgICAg
ICAgIHVkZWxheSg1KTsNCj4gICAxMDQwICAgICAgICAgIH0gZWxzZSBpZiAocmVnLT5hZGRyID09
IDB4ZjkpIHsNCj4gICAxMDQxICAgICAgICAgICAgICAgICAgdWRlbGF5KDEpOw0KPiAgIDEwNDIg
ICAgICAgICAgfSBlbHNlIGlmIChyZWctPmRhdGEgPT0gQllQQVNTX0NSX0RBVEEpIHsNCj4gICAx
MDQzICAgICAgICAgICAgICAgICAgcnR3ODlfZGVidWcocnR3ZGV2LCBSVFc4OV9EQkdfUEhZX1RS
QUNLLCAiQnlwYXNzIENSIDB4JXhcbiIsIHJlZy0+YWRkcik7DQo+ICAgMTA0NCAgICAgICAgICB9
IGVsc2Ugew0KPiAgIDEwNDUgICAgICAgICAgICAgICAgICBhZGRyID0gcmVnLT5hZGRyOw0KPiAg
IDEwNDYNCj4gPiAxMDQ3ICAgICAgICAgICAgICAgICAgaWYgKChlbnVtIHJ0dzg5X3BoeV9pZHgp
ZXh0cmFfZGF0YSA9PSBSVFc4OV9QSFlfMSkNCj4gICAxMDQ4ICAgICAgICAgICAgICAgICAgICAg
ICAgICBhZGRyICs9IHJ0dzg5X3BoeTBfcGh5MV9vZmZzZXQocnR3ZGV2LCByZWctPmFkZHIpOw0K
PiAgIDEwNDkNCj4gICAxMDUwICAgICAgICAgICAgICAgICAgcnR3ODlfcGh5X3dyaXRlMzIocnR3
ZGV2LCBhZGRyLCByZWctPmRhdGEpOw0KPiAgIDEwNTEgICAgICAgICAgfQ0KPiAgIDEwNTIgIH0N
Cj4gDQoNClRoaXMgZnVuY3Rpb24gaXMgb25lIG9mIGNhbGxiYWNrIGZ1bmN0aW9uIG9mICdjb25m
aWcnIGFyZ3VtZW50IG9mIHJ0dzg5X3BoeV9pbml0X3JlZygpLg0KDQpzdGF0aWMgdm9pZCBydHc4
OV9waHlfaW5pdF9yZWcoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0KCQkJICAgICAgIGNvbnN0
IHN0cnVjdCBydHc4OV9waHlfdGFibGUgKnRhYmxlLA0KCQkJICAgICAgIHZvaWQgKCpjb25maWcp
KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCgkJCQkJICAgICAgY29uc3Qgc3RydWN0IHJ0dzg5
X3JlZzJfZGVmICpyZWcsDQoJCQkJCSAgICAgIGVudW0gcnR3ODlfcmZfcGF0aCByZl9wYXRoLA0K
CQkJCQkgICAgICB2b2lkICpkYXRhKSwNCgkJCSAgICAgICB2b2lkICpleHRyYV9kYXRhKQ0KDQpU
aGUgJ3ZvaWQgKmV4dHJhX2RhdGEnIGlzIGV4cGxhaW5lZCBieSBjYWxsYmFjayBmdW5jdGlvbiAn
Y29uZmlnJywgYW5kIHRoZXJlIGFyZQ0KbWFueSBleGlzdGluZyBjYWxsYmFjayBmdW5jdGlvbnMu
IFRvIHNpbXBseSBzdXBwcmVzcyB0aGlzIHdhcm5pbmcgLCBJIHBsYW4gdG8NCmNhc3QgJ2V4dHJh
X2RhdGEnIGZyb20gJ3ZvaWQgKicgYnkgJ3VpbnRwdHJfdCcgdG8gYXZvaWQgY2xhbmcgd2Fybmlu
ZywgYW5kIGdjYw0KY2FuIGFsc28gYWNjZXB0IHRoaXMuIEkgZGlkIHRoaXMgYnkgdjIuDQoNCg0K
UGluZy1LZQ0KDQo=

