Return-Path: <linux-wireless+bounces-1382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814182160C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 01:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54DE1C209FD
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 00:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36C36A;
	Tue,  2 Jan 2024 00:45:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FE381
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4020jinyF4165770, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4020jinyF4165770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 08:45:44 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 2 Jan 2024 08:45:45 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 2 Jan 2024 08:45:45 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Tue, 2 Jan 2024 08:45:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Fix off by one initial RTS rate
Thread-Topic: [PATCH] wifi: rtl8xxxu: Fix off by one initial RTS rate
Thread-Index: AQHaPDdjupBY6pL+iE23nOgK8pqTD7DFsUTg
Date: Tue, 2 Jan 2024 00:45:44 +0000
Message-ID: <f8aaaf712d6940d48a05ae3d33aa25be@realtek.com>
References: <be0427a7-f85f-449e-a6c8-b1c8371c39b0@gmail.com>
In-Reply-To: <be0427a7-f85f-449e-a6c8-b1c8371c39b0@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAxLCAy
MDI0IDY6MTkgQU0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzog
SmVzIFNvcmVuc2VuIDxKZXMuU29yZW5zZW5AZ21haWwuY29tPjsgUGluZy1LZSBTaGloIDxwa3No
aWhAcmVhbHRlay5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gd2lmaTogcnRsOHh4eHU6IEZpeCBv
ZmYgYnkgb25lIGluaXRpYWwgUlRTIHJhdGUNCj4gDQo+IHJ0bDh4eHh1X3NldF9iYXNpY19yYXRl
cygpIHNldHMgdGhlIHdyb25nIGluaXRpYWwgUlRTIHJhdGUuIEl0IHNldHMgdGhlDQo+IG5leHQg
aGlnaGVyIHJhdGUgdGhhbiB0aGUgb25lIGl0IHNob3VsZCBzZXQsIGUuZy4gMzZNIGluc3RlYWQg
b2YgMjRNLg0KPiANCj4gVGhlIHdoaWxlIGxvb3AgaXMgc3VwcG9zZWQgdG8gZmluZCB0aGUgaW5k
ZXggb2YgdGhlIG1vc3Qgc2lnbmlmaWNhbnQNCj4gYml0IHdoaWNoIGlzIDEuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1L3J0bDh4eHh1X2Nv
cmUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRs
OHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGw4eHh4dS9ydGw4eHh4dV9jb3JlLmMNCj4gaW5kZXggMTgwOTA3MzE5ZThjLi5iOWYzMzgyYmQ2
N2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUv
cnRsOHh4eHVfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRs
OHh4eHUvcnRsOHh4eHVfY29yZS5jDQo+IEBAIC00ODM5LDcgKzQ4MzksNyBAQCBzdGF0aWMgdm9p
ZCBydGw4eHh4dV9zZXRfYmFzaWNfcmF0ZXMoc3RydWN0IHJ0bDh4eHh1X3ByaXYgKnByaXYsIHUz
MiByYXRlX2NmZykNCj4gDQo+ICAgICAgICAgZGV2X2RiZygmcHJpdi0+dWRldi0+ZGV2LCAiJXM6
IHJhdGVzICUwOHhcbiIsIF9fZnVuY19fLCByYXRlX2NmZyk7DQo+IA0KPiAtICAgICAgIHdoaWxl
IChyYXRlX2NmZykgew0KPiArICAgICAgIHdoaWxlIChyYXRlX2NmZyA+IDEpIHsNCj4gICAgICAg
ICAgICAgICAgIHJhdGVfY2ZnID0gKHJhdGVfY2ZnID4+IDEpOw0KPiAgICAgICAgICAgICAgICAg
cmF0ZV9pZHgrKzsNCj4gICAgICAgICB9DQoNCkhvdyBhYm91dCB1c2luZyBfX2ZscygpPyANCg0K
aWYgKHJhdGVfY2ZnKQ0KCXJhdGVfaWR4ID0gX19mbHMocmF0ZV9jZmcpOw0KDQo+IC0tDQo+IDIu
NDMuMA0K

