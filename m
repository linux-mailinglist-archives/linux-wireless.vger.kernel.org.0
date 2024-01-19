Return-Path: <linux-wireless+bounces-2218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F883229D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 01:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CE61C22DD8
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 00:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79135389;
	Fri, 19 Jan 2024 00:23:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8FB383
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 00:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705623811; cv=none; b=VDpB0qclcAaRWxsfP3PIamzpGHtDllMUSU7Lfd8bXNpXNhEZjA/BnrIpvQB/YS9l6Ap9pKSbbipvAOR5fK7RgHiHZDrniPz2mntk2TwoMg+Qc9NO3hePmctIUnCChsiprG0a0IWUDS6mi1WciTNpcUHaSu3pWopDgyeiAWWF5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705623811; c=relaxed/simple;
	bh=/No3arMse3wpnRSirRDEw6OYQskvcnagaiJHfi8yyGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ya/vnSiaqBw7XYLhsFq2bqQI41m8aC8YhzJeRSGTzMc6G57pIV/RCqZQxVtFWjcf5VGAo/GTOXSdStsmtvoyOyqM4dnY9P9xVGOkA34g03Vbgp24tMRwTYkNfZVTKZb0y3dTKtFTKLUgcZPoZca9HfuYCs4Nrv8e8SYKrX8NeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40J0NDpvC1960110, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40J0NDpvC1960110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 08:23:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 19 Jan 2024 08:23:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 08:23:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Fri, 19 Jan 2024 08:23:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH v2] wifi: rtlwifi: Speed up firmware loading for USB
Thread-Topic: [PATCH v2] wifi: rtlwifi: Speed up firmware loading for USB
Thread-Index: AQHaSYFrQa8WDirFr0+YumezfZVwHrDeuEZAgAB8YoCAARLVAA==
Date: Fri, 19 Jan 2024 00:23:13 +0000
Message-ID: <531c906cc1d949ab959f28225605b6e7@realtek.com>
References: <d9bd4949-6e92-4f35-8b60-3b45f9ad74ab@gmail.com>
 <69d5e71d354b48ef839fb3d3c47f09c7@realtek.com>
 <1314347a-a7a7-4021-bcd5-58ff7cfa0fba@gmail.com>
In-Reply-To: <1314347a-a7a7-4021-bcd5-58ff7cfa0fba@gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDE4
LCAyMDI0IDExOjU2IFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTGFycnkgRmluZ2VyIDxMYXJy
eS5GaW5nZXJAbHdmaW5nZXIubmV0Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSB3aWZpOiBy
dGx3aWZpOiBTcGVlZCB1cCBmaXJtd2FyZSBsb2FkaW5nIGZvciBVU0INCj4gDQo+IA0KPiBPbiAx
OC8wMS8yMDI0IDAyOjM3LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4
ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMTgsIDIw
MjQgNDoxMiBBTQ0KPiA+PiBUbzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+ID4+
IENjOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47IExhcnJ5IEZpbmdlciA8TGFy
cnkuRmluZ2VyQGx3ZmluZ2VyLm5ldD4NCj4gPj4gU3ViamVjdDogW1BBVENIIHYyXSB3aWZpOiBy
dGx3aWZpOiBTcGVlZCB1cCBmaXJtd2FyZSBsb2FkaW5nIGZvciBVU0INCj4gPj4NCj4gPj4gK3N0
YXRpYyB2b2lkIF91c2Jfd3JpdGVfY2h1bmtfc3luYyhzdHJ1Y3QgcnRsX3ByaXYgKnJ0bHByaXYs
IHUzMiBhZGRyLA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTMyIGxl
bmd0aCwgdTggKmRhdGEpDQo+ID4+ICt7DQo+ID4+ICsgICAgICAgc3RydWN0IHVzYl9kZXZpY2Ug
KnVkZXYgPSB0b191c2JfZGV2aWNlKHJ0bHByaXYtPmlvLmRldik7DQo+ID4+ICsNCj4gPj4gKyAg
ICAgICBfdXNiY3RybF92ZW5kb3JyZXFfc3luYyh1ZGV2LCBSRUFMVEVLX1VTQl9WRU5RVF9XUklU
RSwgYWRkciwgZGF0YSwgbGVuZ3RoKTsNCj4gPg0KPiA+IEp1c3QgY3VyaW91cy4gT3JpZ2luYWxs
eSwgaXQgdXNlcyAxLzIvNCBhcyBsZW5ndGggZm9yIHdyaXRlOC8xNi8zMiwgYW5kIHRoaXMNCj4g
PiBwYXRjaCBhZGRpdGlvbmFsbHkgdXNlcyA4LzY0IGFzIGxlbmd0aC4gQW55IGxpbWl0YXRpb24g
b2YgYXJndW1lbnQgJ2xlbmd0aCcgb2YNCj4gPiB0aGlzIGZ1bmN0aW9uPyBJcyBhcmJpdHJhcnkg
bnVtYmVyIGRpc2FsbG93ZWQ/DQo+ID4NCj4gDQo+IEkgZGlkbid0IGZpbmQgYW55dGhpbmcgaW4g
dGhlIHVzYl9jb250cm9sX21zZygpIGRvY3VtZW50YXRpb24uDQo+IEkgb25seSBmb3VuZCB0aGlz
IGlzc3VlLCB3aGVyZSBzb21lIHBlb3BsZSBzYXkgMHhmZmZmIGlzIGZpbmUsDQo+IGJ1dCBvbGRl
ciBoYXJkd2FyZSBtYXkgaGF2ZSBhIGxpbWl0IG9mIDQwOTY6DQo+IGh0dHBzOi8vZ2l0aHViLmNv
bS9saWJ1c2IvbGlidXNiL2lzc3Vlcy8xMjUNCj4gDQo+IHJ0bDh4eHh1IHVzZXMgbGVuZ3RocyBv
ZiAzMiwgOTQsIDEyNCwgMTI2LCAxMjgsIDE1NiwgMjU0IGJ5dGVzLg0KPiBTb21lIG90aGVyIFJl
YWx0ZWsgd2lmaSBkcml2ZXJzIHVzZSAxOTYgYnl0ZXMuDQoNCkdvdCBpdC4gVGhhbmtzIGZvciB0
aGUgaW5mb3JtYXRpb24uIA0KDQo=

