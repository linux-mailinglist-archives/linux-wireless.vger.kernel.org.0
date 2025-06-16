Return-Path: <linux-wireless+bounces-24119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC402ADA6BA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 05:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338C31890713
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E423D1BF58;
	Mon, 16 Jun 2025 03:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FHKx3r7U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9123AD;
	Mon, 16 Jun 2025 03:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750043734; cv=none; b=QUEPTsS5xztlA8labfbEk64MNd7rLjVdCiQLefgoLiFWdn1pqHH595wd0Zpa89K6RJgF62Lj73aqbTXnAPPL+nb6Q06fG7H7kUOeLHzQcIuBtnP3jrUDsXZSUbI88t/4WETdIGlZKIWHXLGT2qXHZ4Fb0fYVpMvBxuI+qJPoXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750043734; c=relaxed/simple;
	bh=CIyx7VX7YmCDH72YDO15TMeBcEFZy898ChQKfe1Zb8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UaXlRR5k1GaFm0gaSRqe845L+Ay8oEgLzewrwnrwyUz11hNg5dMKXpznekkePvAwIDFbQ07UYe04HoWhlPxNAKPbEstDuYUnuAQ454xwY2457Y7DGhjD7gjy3z0lTWPVJyRWfzob8M5+UKoD1xMuPk+z8tEH1bAO7w5Lu/5PRZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FHKx3r7U; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G3FPyU43967896, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750043725; bh=CIyx7VX7YmCDH72YDO15TMeBcEFZy898ChQKfe1Zb8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FHKx3r7UfSbMnvb/XpUPNDwoUZrx0ro2sjfN4+c92a33xJSExhg5PVvnLaikfBmhz
	 16kmyWFMMS3dpz53+revPcdnTxnoes54czLhfLv/62I7tOZIjhQEz2Wgs6UA9wSiDx
	 8MrlkjAiMFX/Sc2CrNM5F1H0fMjyOfsIu8DsmwBNFBE+I2UFeIl4wHDeW4gVnVRJxn
	 oXSK+DZkGsabxjAIGotH6ExGyA4IN2+5sOgzmZIHr3FNZIso63Cq0tvEDzKKIolCc5
	 2qxbdkSirtQhOUWubIby1aoR1yxubDxX6tS+tv6FjLgxsy8qn6SyBzS6HttpRU8w2S
	 LQIAUzttYC7Og==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G3FPyU43967896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 11:15:25 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 11:15:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 11:15:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 16 Jun 2025 11:15:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        kernel test robot
	<lkp@intel.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: RE: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB modules
Thread-Topic: [PATCH rtw-next v2 14/14] wifi: rtw89: Enable the new USB
 modules
Thread-Index: AQHb2XV4UvlgvG5pOESwpZNcSugO9rP7xDMAgAAbN4CAATzvcIAARemAgAFSCLCABnHasA==
Date: Mon, 16 Jun 2025 03:15:08 +0000
Message-ID: <568e73b06b2246b3ad0182ae2ce6591d@realtek.com>
References: <663044d3-0816-4b1b-874d-776835e774e9@gmail.com>
 <202506101956.cNXM2Qvb-lkp@intel.com>
 <b8690413-059d-4330-992b-36a7af10aa30@gmail.com>
 <01eb10716bdb4241a012d378d1f7b67d@realtek.com>
 <0d712ef0-ea93-4825-8a4c-45f9d7f9e8d9@gmail.com>
 <b34d246be15849a99310bf326a66b07c@realtek.com>
In-Reply-To: <b34d246be15849a99310bf326a66b07c@realtek.com>
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

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gT24gMTEvMDYvMjAyNSAw
MzozMiwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+ID4+Pg0KPiA+ID4+Pj4+IGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MWIuYzo1MjM6NDc6IGVycm9yOiB1c2Ugb2Yg
dW5kZWNsYXJlZCBpZGVudGlmaWVyDQo+ID4gPj4gJ0JfQVhfU09QX0VEU1dSJw0KPiA+ID4+PiAg
ICAgIDUyMyB8ICAgICAgICAgICAgICAgICBydHc4OV93cml0ZTMyX2NscihydHdkZXYsIFJfQVhf
U1lTX1BXX0NUUkwsIEJfQVhfU09QX0VEU1dSKTsNCj4gPiA+Pj4gICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+
ID4gPj4+ICAgIDEgZXJyb3IgZ2VuZXJhdGVkLg0KPiA+ID4+Pg0KPiA+ID4+IE9vcHMsIEknbGwg
YWRkIHRoYXQgdG8gcmVnLmggaW4gdjMuDQo+ID4gPg0KPiA+ID4gVGhlIE5BUEkgYWxzbyByZXBv
cnRlZCB0aGUgc2FtZSB0aGluZ3MgWzFdIFsyXS4NCj4gPiA+DQo+ID4gPiBOb3Qgc3VyZSBpZiB5
b3Ugd2lsbCBzZW5kIHYzIHJpZ2h0IGF3YXkuIElmIHNvLCBJIHdpbGwgaWdub3JlIHYyLg0KPiA+
ID4NCj4gPiA+IFsxXSBodHRwOi8vd2lmaWJvdC5zaXBzb2x1dGlvbnMubmV0L3Jlc3VsdHMvOTY5
OTgwLzE0MTExMTg3L2J1aWxkXzMyYml0L3N0ZGVycg0KPiA+ID4gWzJdIGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC13aXJlbGVzcy9saXN0Lz9zZXJpZXM9OTY5OTgw
DQo+ID4gPg0KPiA+DQo+ID4gSSB3b3VsZCBwcmVmZXIgdG8gd2FpdCBmb3IgeW91ciByZXZpZXcu
IElzIHRoYXQgb2theT8NCj4gDQo+IFllcy4gSSB3aWxsIHJldmlldyB2Mi4NCg0KSSBoYXZlIHJl
dmlld2VkIHYyLiBTaW5jZSBjb21waWxlciBlcnJvcnMgZXhpc3QsIEkgY2FuJ3QgYnVpbGQgdGhp
cyBwYXRjaHNldA0Kd2l0aCAgc3BhcnNlL3NtYXRjaCBsb2NhbGx5LiBQbGVhc2UgZG8gaXQgeW91
cnNlbGYgYmVmb3JlIHNlbmRpbmcgdjMuDQoNCg0K

