Return-Path: <linux-wireless+bounces-5507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555F5890F99
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B6BB2537C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7A4AEDB;
	Fri, 29 Mar 2024 00:25:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645834AEC5
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 00:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671905; cv=none; b=JCIow/MOhkBDtng3eydHIiP87mHbHOn3nKRiZtKrfhi1yYPYgjwDvH9Bj/XFHeFuS70LEDhK5ECnBuOIMwdyMZiYDzTT7KVv3Ym1AVgD7hQy6I/B4dpbJwuU3fklrtyLiFqacDVlE3wzBxNoiE+fATLekmjtFV5jJRSiviDwbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671905; c=relaxed/simple;
	bh=kI+ag4L2h10z7duxcOSHhA1YsIkBrFb+SjrRSie01L0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=We+YvAtLOiHWP4vRL/P9300+HpWDpoH9DN8EELOc5SNVITkjPzLYyQ1N/v5B+J0oA5N0FxXSCB2KJ/SVJllzR9RS5prRQY/D2j84KkbXfTUbhRdvhFbVpnJ08AJVB0tOVhz/Za+L4hOI5+mYIgaeL4txiB2NZUnT+508R2VMeA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42T0Ox3H23081430, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42T0Ox3H23081430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 08:24:59 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 08:25:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 08:24:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 29 Mar 2024 08:24:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?5pa95bCP5LiwKOWMu+eUqOWItuWTgeS6p+S4mumbhuWboi3ljLvnlKjliLY=?=
 =?utf-8?B?5ZOB6ZuG5Zui5pys6YOoKQ==?= <shixiaofeng@weigaogroup.com>
CC: linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Is RTL8822CE with Kernel 6.1 for imx6
Thread-Topic: Is RTL8822CE with Kernel 6.1 for imx6
Thread-Index: AQHae6GreAtxLBDbLkylo+A0KBQKpbFDXUwggAmbqQCAAAOXgIAA6T/Q
Date: Fri, 29 Mar 2024 00:24:59 +0000
Message-ID: <28a3b031b06f46c5b10e100392a33286@realtek.com>
References: <AHYA5ACwHqi71yYpWUIbQ4qs.3.1711649408218.Hmail.shixiaofeng@weigaogroup.com>
 <AFkA2ADXHpG7WCaaWed4PapF.3.1711650179911.Hmail.shixiaofeng@weigaogroup.com>
In-Reply-To: <AFkA2ADXHpG7WCaaWed4PapF.3.1711650179911.Hmail.shixiaofeng@weigaogroup.com>
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

DQo+IFNoYWxsIHdlIHRyeSBzb21lIG90aGVyIGZpcm13YXJlIGZvciB0aGUgODgyMkNFPw0KPiBJ
cyBpdCBwb3NzaWJsZSB0aGF0IHNvbWUgY29uZmxpY3Rpb24gYmV0d2VlbiA4ODIyQ0UgZHJpdmVy
IGFuZCBmaXJtd2FyZT/CoA0KDQpOby4gQXMgeW91ciBsb2csIGl0IGhhcyBub3QgeWV0IHRyaWVk
IHRvIGRvd25sb2FkIGZpcm13YXJlLiANCg0KPiBbIMKgIDU1LjE4NDM1MF0gcjEwOiA4M2M3OTdh
MCDCoHI5IDogODNjN2Y4OTAgwqByOCA6IDAwMDAwMjAwDQo+IFsgwqAgNTUuMTg5NTc4XSByNyA6
IDAwMDAwM2RhIMKgcjYgOiAwMDAwMDNkOSDCoHI1IDogN2YwNDg0MTggwqByNCA6IDgzYzc5N2Ew
DQo+IFsgwqAgNTUuMTk2MTA5XSByMyA6IGMwOTIwMGYwIMKgcjIgOiAwMDAwMDAwMCDCoHIxIDog
MDAwMDAwZjAgwqByMCA6IDAwMDAwMDAwDQoNClNpbmNlIGZpcnN0IHJ0d19wY2lfcmVhZDMyKCkg
ZnJvbSBydHdfY2hpcF9pbmZvX3NldHVwKCkgaXMgDQogICBoYWwtPmNoaXBfdmVyc2lvbiA9IHJ0
d19yZWFkMzIocnR3ZGV2LCBSRUdfU1lTX0NGRzEpOyAvLyBSRUdfU1lTX0NGRzEgaXMgMHhmMA0K
DQpTbywgSSBndWVzcyByMSBpcyB0byBzdG9yZSBhcmcyIChSRUdfU1lTX0NGRzEpLCBhbmQgcjMg
aXMgcnR3cGNpLT5tbWFwICsgYWRkci4NCg0KPiBbIMKgIDU1LjIzMDAxM10gUmVnaXN0ZXIgcjMg
aW5mb3JtYXRpb246IDAtcGFnZSB2bWFsbG9jIHJlZ2lvbiBzdGFydGluZyBhdCAweGMwOTIwMDAw
IGFsbG9jYXRlZCBhdCBydHdfcGNpX3Byb2JlKzB4MTY0LzB4ZjFjIFtydHc4OF9wY2ldDQoNCkJ1
dCB3ZWlyZC4gSXQgc2F5cyB0aGF0IGlzIGEgdm1hbGxvYyByZWdpb24uIA0KDQpJJ20gbm90IGZh
bWlsaWFyIHdpdGggdGhlIHRyYWNlLiBKdXN0IHBvaW50IG91dCBzb21lIHN1c3BpY2lvdXMgcG9p
bnRzIGZvcg0KcmVmZXJlbmNlLiANCg0KDQo=

