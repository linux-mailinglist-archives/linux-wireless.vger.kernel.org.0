Return-Path: <linux-wireless+bounces-3095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE8848A37
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 02:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09FA280FC0
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 01:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47EE7E1;
	Sun,  4 Feb 2024 01:32:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA2610F1;
	Sun,  4 Feb 2024 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010322; cv=none; b=eei2gq8LGRmq2HtoWJa/IGk4qnYgltOEJfvPQlCn5lJAKTt8RSqwcoUz5DoEH1VLhE1dyTXd+D4actkzoAtVSrpf6CdxW15rG4rs9vjcSPpqvalVECpIwUll6pQPUdj3JW7mj+ig5xcOxxjBy4l3OCjWK3QT3QvEd85dVKVhvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010322; c=relaxed/simple;
	bh=LAtoXISJxeafujJzD5Nr1eEj2NPuDf37Hxk5B9t2c78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UsRxDFNV0kMRQTxaOcNOBbpteFeypKBbK79tfNAxGQOkPHCtnedvMMBAZdKYpqjckb4H1uq0t6CPaLcWCJX1HTbTuvZQdwcSzlm/9TjyVYXvdRo7CKPK5dMAR1aXrko8LXSoTi2VZzHCpdvdFMki9IvTdekHdqy01ynnIilGXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4141VjAO22615386, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4141VjAO22615386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Feb 2024 09:31:45 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sun, 4 Feb 2024 09:31:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 4 Feb 2024 09:31:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Sun, 4 Feb 2024 09:31:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "kvalo@kernel.org" <kvalo@kernel.org>, "lkp@intel.com" <lkp@intel.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 3/4] wifi: rtw89: fw: parse secure section from firmware file
Thread-Topic: [PATCH 3/4] wifi: rtw89: fw: parse secure section from firmware
 file
Thread-Index: AQHaVjiuZCYGjpZVQ0eMXVSiurUcQ7D4ejGAgABm9oA=
Date: Sun, 4 Feb 2024 01:31:45 +0000
Message-ID: <e645b875c771216f688ae106abd5be86aff59b42.camel@realtek.com>
References: <20240203003251.10641-4-pkshih@realtek.com>
	 <202402040350.rRpOepoU-lkp@intel.com>
In-Reply-To: <202402040350.rRpOepoU-lkp@intel.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9F344B0556AD6479EE0CC8FC753B7F3@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gU3VuLCAyMDI0LTAyLTA0IGF0IDAzOjIyICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gDQo+ICAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYzogSW4g
ZnVuY3Rpb24gJ3J0dzg5X2Z3X2hkcl9wYXJzZXJfdjEnOg0KPiA+ID4gZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jOjM4NDo4ODogd2FybmluZzogZm9ybWF0ICclbHgnIGV4
cGVjdHMgYXJndW1lbnQgb2YgdHlwZQ0KPiA+ID4gJ2xvbmcgdW5zaWduZWQgaW50JywgYnV0IGFy
Z3VtZW50IDkgaGFzIHR5cGUgJ2ludCcgWy1XZm9ybWF0PV0NCj4gICAgICAzODQgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgInNlY3Rpb25bJWRdIHR5cGU9JWQgbGVuPTB4JS02eCBtc3Nj
PSVkIG1zc2NfbGVuPSVkDQo+IGFkZHI9JWx4XG4iLA0KPiAgICAgICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB+fg0KPiBeDQo+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgDQo+IHwNCj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCj4gbG9uZyB1bnNpZ25lZCBpbnQNCj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJXgNCj4gICAgICAzODUgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aSwgc2VjdGlvbl9pbmZvLT50eXBlLCBzZWN0aW9uX2luZm8tPmxlbiwNCj4gICAgICAzODYgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VjdGlvbl9pbmZvLT5tc3NjLCBtc3NjX2xlbiwg
YmluIC0gZncpOw0KPiAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fg0KPiAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0K
PiAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW50DQoNCkkgbG9va2VkIGZvciBob3cgdG8gcHJpbnQgb3V0IGRp
ZmZlcmVuY2VzIChzdWJ0cmFjdGlvbikgb2YgcG9pbnRzLCBhbmQNCiIldHgiIGlzIHRoZSBkZXNp
cmVkIGZvcm1hdCBbMV0uIEkgY29ycmVjdGVkIHRoaXMgYnkgdjIuDQoNClsxXSBodHRwczovL2Rv
Y3Mua2VybmVsLm9yZy9jb3JlLWFwaS9wcmludGstZm9ybWF0cy5odG1sI3BvaW50ZXItZGlmZmVy
ZW5jZXMNCg0KUGluZy1LZSANCg0K

