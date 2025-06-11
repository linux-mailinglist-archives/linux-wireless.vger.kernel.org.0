Return-Path: <linux-wireless+bounces-23944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0419AD477D
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 02:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C423C3A8948
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 00:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C8617597;
	Wed, 11 Jun 2025 00:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dAwK/OYJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DE1758B;
	Wed, 11 Jun 2025 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749602040; cv=none; b=NRt3fe0vh6Q+YZ9y9RkixdxYUzhl/GQKpHoKe2nPYcciiZZqbQI0Y3BrPDHwT8r/aJ+wY3AnlQ+yNKpAH4yqtYLsdI37b9kNrskVve98v9sWsdyWIZ2fokj40kfDGGOSu9k+MNxhI3W7Vsvq3pdr+cKXmvVuuTaPOyoGAYOeruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749602040; c=relaxed/simple;
	bh=oaKkbhT73ApHql1iPynccEV1QkZXUpEUCeV9JURA17U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXSMqOnYO+SaNS3HYn3gwUDi9S29YwRurmrISN5s4KwF9xC9bDb1LeMxXhLHG1IyMIkEwq2G1899AcFc6KxDRwBCWkYyVfmdrR8EL3u/emnHxfZEqD2SliGi6c3Bws9UTU6BR1SBniQNas2kDj1SxDHOyAMYbiNC5Pg67hgUF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dAwK/OYJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B0XoRS23866937, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749602030; bh=oaKkbhT73ApHql1iPynccEV1QkZXUpEUCeV9JURA17U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dAwK/OYJcPOKdD6w15hNAD/dhVL+bGcfn7FXp56HNDEXqKZYyAEDYFaqRE8hxKdFQ
	 A2L7NopIlEVXaJjsIT36dfGiHicK15Cx74Wk2JM7VgP+idKBwwhOuCvaNt7uxVFIhW
	 fi+Qjx5a8d2WwQhS+ItElJpXP4B3o3q+KfsulFt3GhH38NRlVeenJ/d+Dn26WbzaC3
	 bApVc3imo+XCDfX0VnbM0hO3JVUrnd0qpmZdIcbHV2dVrMn7Xc6DGJ43LZXHvQurdy
	 Ph5u05io1vUxAR4l/a3OHSBAVJzAVN/A/4UNDZ+moU1upcvly63PxiZAfup7wkRK8Q
	 q1Ts+VfLwWuYw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B0XoRS23866937
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 08:33:50 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 08:33:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 11 Jun 2025 08:33:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 11 Jun 2025 08:33:50 +0800
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
Thread-Index: AQHb2XV4UvlgvG5pOESwpZNcSugO9rP7xDMAgAAbN4CAATzvcIAAAZ3A
Date: Wed, 11 Jun 2025 00:33:50 +0000
Message-ID: <8773d4161a714a99b626cf7d146f387c@realtek.com>
References: <663044d3-0816-4b1b-874d-776835e774e9@gmail.com>
 <202506101956.cNXM2Qvb-lkp@intel.com>
 <b8690413-059d-4330-992b-36a7af10aa30@gmail.com>
 <01eb10716bdb4241a012d378d1f7b67d@realtek.com>
In-Reply-To: <01eb10716bdb4241a012d378d1f7b67d@realtek.com>
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

PiA+ID4NCj4gPiA+Pj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9ydHc4ODUx
Yi5jOjUyMzo0NzogZXJyb3I6IHVzZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXINCj4gPiAnQl9B
WF9TT1BfRURTV1InDQo+ID4gPiAgICAgIDUyMyB8ICAgICAgICAgICAgICAgICBydHc4OV93cml0
ZTMyX2NscihydHdkZXYsIFJfQVhfU1lTX1BXX0NUUkwsIEJfQVhfU09QX0VEU1dSKTsNCj4gPiA+
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXg0KPiA+ID4gICAgMSBlcnJvciBnZW5lcmF0ZWQuDQo+ID4gPg0KPiA+
IE9vcHMsIEknbGwgYWRkIHRoYXQgdG8gcmVnLmggaW4gdjMuDQo+IA0KPiBUaGUgTkFQSSBhbHNv
IHJlcG9ydGVkIHRoZSBzYW1lIHRoaW5ncyBbMV0gWzJdLg0KDQpTb3JyeS4gSSBtZWFudCBOSVBB
IGluc3RlYWQuIA0KDQo+IA0KPiBOb3Qgc3VyZSBpZiB5b3Ugd2lsbCBzZW5kIHYzIHJpZ2h0IGF3
YXkuIElmIHNvLCBJIHdpbGwgaWdub3JlIHYyLg0KPiANCj4gWzFdIGh0dHA6Ly93aWZpYm90LnNp
cHNvbHV0aW9ucy5uZXQvcmVzdWx0cy85Njk5ODAvMTQxMTExODcvYnVpbGRfMzJiaXQvc3RkZXJy
DQo+IFsyXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxl
c3MvbGlzdC8/c2VyaWVzPTk2OTk4MA0KDQo=

