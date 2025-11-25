Return-Path: <linux-wireless+bounces-29297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5660FC82F21
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 01:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0058C348012
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 00:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D901A3172;
	Tue, 25 Nov 2025 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uhLXqo5C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6E46BF;
	Tue, 25 Nov 2025 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764030971; cv=none; b=kKy/hs22m6DtgWjzezYTTdK1qbdiMl1hmtVQnN5rzgmyQKCOMKaFmJxkIkzgzOw8pBxIpOi4G24oahXS5fZ9QcYh/TYcLzbHjEC6Aj47EaBijsQjk33uCZOQ89cloEHAKDxkUnjtx6DhBH96WmIoICexG7Z8Yzuj8pXEkmxy7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764030971; c=relaxed/simple;
	bh=ZOpmgIq5eEWA4+2JZn9BErxGKT/jcw+a2PikbiGGlAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GYkBfGmyZQGvnBKdj0+z1/uvmAptklBqh8BIyIy/Er7LHNnztAdbog0u9nDO4FdQidBzLi22ruusgWhc7pqvntbWsY4dIQ/G5cUwmOz1gSwld6O7xjPQ7wxJbmrno61ISgu0RaDIJ+YmUvi3Z7r8tI0YnCZ34v1fdZFzRjKaocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uhLXqo5C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AP0a2Aw91927269, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764030962; bh=ZOpmgIq5eEWA4+2JZn9BErxGKT/jcw+a2PikbiGGlAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=uhLXqo5C6sppHnNgmIMf/WKkQ4ybiHmkA/R/7uRLz61XXwTfyqFvdzmHmwNLPbizs
	 Zr/8yGfgLtgOMgT/VZNA+w8Ujvgc317/DpIFez1fPXAlfbpW4UDT+gYW4/8dqLQ171
	 MZ8NNIxt6dUHSmFydTKY+ubYVmScfJgwypuPipUXMJLOYb1N8DiDuG1+rhSlhEA6Og
	 veJwwT7T+2/OkkrA9xb0UVwypk/Z7bUQJ/5xFt3A7zeyXBR2s2IkjIN7jme/15v2HM
	 qcReleOGdBOFTiMhMJ/ECap/KYS6CDQ3oaTkG23e0LEq8+SuaSTx5yHGQjTuVu7dwg
	 T0J/xBiRD+XRA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AP0a2Aw91927269
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 08:36:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 25 Nov 2025 08:36:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 25 Nov 2025 08:36:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "piotr.oniszczuk@gmail.com" <piotr.oniszczuk@gmail.com>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device
 registers before power-on
Thread-Topic: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device
 registers before power-on
Thread-Index: AQHb/DS8S6Z9LuNHSkqUfz4BHLn6GLT/I7SAgAL+B7CAAI4/gIAAnX3Q
Date: Tue, 25 Nov 2025 00:36:02 +0000
Message-ID: <07a32e2d6c764eb1bd9415b5a921a652@realtek.com>
References: <20250724004815.7043-1-pkshih@realtek.com>
 <aSHrhbt29k6GJB8e@skv.local> <4562797ed9514344b562f7a8e58e6988@realtek.com>
 <aSTlb1TEwNaFbdFf@skv.local>
In-Reply-To: <aSTlb1TEwNaFbdFf@skv.local>
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

QW5kcmV5IFNrdm9ydHNvdiA8YW5kcmVqLnNrdm9ydHpvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiBP
biAyNS0xMS0yNCAwODoxNiwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEFuZHJleSBTa3ZvcnRz
b3YgPGFuZHJlai5za3ZvcnR6b3ZAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4N
Cj4gPiA+IFRoaXMgcGF0Y2ggd2FzIHJlY2VudGx5IGJhY2twb3J0ZWQgdG8gc3RhYmxlIGtlcm5l
bHMgKHY2LjEyLjU4KSBhbmQgaXQgYnJva2UNCj4gPiA+IHdsYW4gb24gUGluZVBob25lLCB0aGF0
IHVzZXMgODcyM2NzIFNESU8gY2hpcC4gVGhlIHNhbWUgcHJvYmxlbQ0KPiA+ID4gYXBwZWFycyBv
ZiBjb3Vyc2Ugb24gbGF0ZXN0IDYuMTgtcmM2LiBSZXZlcnRpbmcgdGhpcyBjaGFuZ2UgcmVzb2x2
ZXMNCj4gPiA+IHRoZSBwcm9ibGVtLg0KPiA+ID4NCj4gPiA+IGBgYA0KPiA+ID4gJCBzdWRvIGRt
ZXNnIHwgZ3JlcCAtaSBydHc4OA0KPiA+ID4gWyAgIDI0Ljk0MDU1MV0gcnR3ODhfODcyM2NzIG1t
YzE6MDAwMToxOiBXT1cgRmlybXdhcmUgdmVyc2lvbiAxMS4wLjAsIEgyQyB2ZXJzaW9uIDANCj4g
PiA+IFsgICAyNC45NTMwODVdIHJ0dzg4Xzg3MjNjcyBtbWMxOjAwMDE6MTogRmlybXdhcmUgdmVy
c2lvbiAxMS4wLjAsIEgyQyB2ZXJzaW9uIDANCj4gPiA+IFsgICAyNC45NTU4OTJdIHJ0dzg4Xzg3
MjNjcyBtbWMxOjAwMDE6MTogc2RpbyByZWFkMzIgZmFpbGVkICgweGYwKTogLTExMA0KPiBJIHNl
ZSBpdCBmYWlscyB3aXRoIHRpbWVvdXQgb24gdGhlIGZpcnN0IG9wZXJhdGlvbiB0byByZWFkIGNo
aXAgdmVyc2lvbi4NCj4gDQo+ID4gPiBbICAgMjQuOTczMTM1XSBydHc4OF84NzIzY3MgbW1jMTow
MDAxOjE6IHNkaW8gd3JpdGU4IGZhaWxlZCAoMHgxYyk6IC0xMTANCj4gPiA+IFsgICAyNC45ODA2
NzNdIHJ0dzg4Xzg3MjNjcyBtbWMxOjAwMDE6MTogc2RpbyByZWFkMzIgZmFpbGVkICgweGYwKTog
LTExMA0KPiA+ID4gLi4uDQo+ID4gPiBbICAgMjUuNDQ2NjkxXSBydHc4OF84NzIzY3MgbW1jMTow
MDAxOjE6IHNkaW8gcmVhZDggZmFpbGVkICgweDEwMCk6IC0xMTANCj4gPiA+IFsgICAyNS40NTM1
NjldIHJ0dzg4Xzg3MjNjcyBtbWMxOjAwMDE6MTogbWFjIHBvd2VyIG9uIGZhaWxlZA0KPiA+ID4g
WyAgIDI1LjQ1OTA3N10gcnR3ODhfODcyM2NzIG1tYzE6MDAwMToxOiBmYWlsZWQgdG8gcG93ZXIg
b24gbWFjDQo+ID4gPiBbICAgMjUuNDY0ODQxXSBydHc4OF84NzIzY3MgbW1jMTowMDAxOjE6IGZh
aWxlZCB0byBzZXR1cCBjaGlwIGVmdXNlIGluZm8NCj4gPiA+IFsgICAyNS40NjQ4NTZdIHJ0dzg4
Xzg3MjNjcyBtbWMxOjAwMDE6MTogZmFpbGVkIHRvIHNldHVwIGNoaXAgaW5mb3JtYXRpb24NCj4g
PiA+IFsgICAyNS40NzgzNDFdIHJ0dzg4Xzg3MjNjcyBtbWMxOjAwMDE6MTogcHJvYmUgd2l0aCBk
cml2ZXIgcnR3ODhfODcyM2NzIGZhaWxlZCB3aXRoIGVycm9yIC0xMTQNCj4gPiA+IGBgYA0KPiA+
ID4NCj4gPg0KPiA+IENoZWNrIG9yaWdpbmFsIGxpbmsgb2YgdGhpcyBwYXRjaCBbMV0gdGhhdCA4
ODIyY3MgcmVhZCBpbmNvcnJlY3QgZnJvbSAweGYwDQo+ID4gcmVzdWx0aW5nIGluICJydHc4OF84
ODIyY3MgbW1jMTowMDAxOjE6IHVuc3VwcG9ydGVkIHJmIHBhdGggKDEpIi4NCj4gU29ycnksIEkg
aGF2ZW4ndCBtZWFudCwgdGhhdCB0aGlzIHBhdGNoIHNob3VsZCBiZSByZXZlcnRlZC4gSSBzZWUs
DQo+IHRoYXQgaXQgc29sdmVzIHJlYWwgcHJvYmxlbS4gSSd2ZSBtZWFudCwgdGhhdCBwYXRjaCBj
YXVzZWQgdGhpcw0KPiByZWdyZXNzaW9uIHdhcyBpZGVudGlmaWVkIGFuZCBpdCB3YXMgY29uZmly
bWVkIGJ5IHJldmVydGluZyBpdC4NCg0KSSBqdXN0IHdhbnQgdG8gcG9pbnQgb3V0IHRoZSBvcmln
aW5hbCBwcm9ibGVtIHdlIGVuY291bnRlcmVkLCBhbmQgdGhlIHVzZXINCndlaXJkbHkgZ2V0IHVu
ZXhwZWN0ZWQgdmFsdWUgZnJvbSAweEYwIHdpdGhvdXQgYW55IGVycm9yLiANCg0KPiANCj4gPiBJ
IHdvbmRlciBpZiB3ZSBjYW4gYWRkIGFkZGl0aW9uYWwgY2hlY2tpbmcgcnVsZSBvZiBjaGlwIElE
LCBsaWtlOg0KPiANCj4gSSd2ZSB0cmllZCBzdWdnZXN0ZWQgY2hhbmdlIGFuZCB3bGFuIGlzIHJl
Y29nbml6ZWQgYWdhaW4uDQo+IA0KDQpJIHdpbGwgY2hlY2sgaWYgdmVuZG9yIGRyaXZlciBkb2Vz
IHNpbWlsYXIgdGhpbmdzLCBhbmQgdGhlbiBJIGNhbiBtYWtlDQphIGZvcm1hbCBwYXRjaCBmb3Ig
ODcyM0NTLg0KDQoNCg==

