Return-Path: <linux-wireless+bounces-30110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B91CDE336
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 02:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 024B93006A72
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 01:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC44155C97;
	Fri, 26 Dec 2025 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CBeEoNlr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5661C862E
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766713076; cv=none; b=hCwscsDI8kxx8Go0MLWnKTxgHCHRltIAaB7wHfTmnUZuVLrzVYKYvUi1UREUNsMRhZzasQv2XBhcejVaXhcFZQ0A2DtIUqyFAshlRda60Ly4v7fQv/Y3B5nFr9eCdhMYYiGqx23WEhAeAdrBSEsORTdaFE0N3QRjHkx8G2Go/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766713076; c=relaxed/simple;
	bh=0hCZV0viRWGyRJbvey9qJjt88juel0rCK7NMa6h3bUw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=txejHcekW/fDs1ICNJfmxx57/rsfQiE1Hy9FeNDarBa8mDZq0zf+jlOixuq/U9OjJ3LZgjD467wmnujahXpc7/ZefV6JW39K2yfb+aMzRry+m0Cb6JEVDi5Ww2mBWcGZz6FhiE0GGBRDMZw0rv5TB57T4CDCN98dDdfaNxAJHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CBeEoNlr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ1bobY72659349, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766713070; bh=0hCZV0viRWGyRJbvey9qJjt88juel0rCK7NMa6h3bUw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CBeEoNlrmjrdNsXO2aV0OzdnFqZ5hfHsQhbQiUeDaB23DObM9sI8nUNKbwo6UPz6X
	 cyb6/G74ItPIP0jHg5LbJvG07dnnypivVIP6yLwCkojtZYD6jj2LN3ZlXDTldHykMC
	 oDTTsF/xxFUO8nU9mTx1KOZjlaTUWKBZ9RTAujf9/eavcjoNxUIxFVSuwndk19vDZy
	 M9BuTGUOqYGuZ8H251bltlM82lT3B81JM+FPKd3ZxhjH6qbYkoBgeYOvG/RDr0YYIJ
	 wxqshXESwo1fFvcobxZN3qHWTaXf5U84J6TPyrKts+qzccRR4WI6goZEO5/B0h3vYY
	 g1SI/KVL9Kcow==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ1bobY72659349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Dec 2025 09:37:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 09:37:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 09:37:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 26 Dec 2025 09:37:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/3] wifi: rtw88: Fix alignment fault in
 rtw_core_enable_beacon()
Thread-Topic: [PATCH rtw-next 1/3] wifi: rtw88: Fix alignment fault in
 rtw_core_enable_beacon()
Thread-Index: AQHcdGNIBa8KiU+GHkKeNQSwOLw8RLUzJ43Q
Date: Fri, 26 Dec 2025 01:37:49 +0000
Message-ID: <13771f1cdeea49679af1fbc7c12f0246@realtek.com>
References: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
In-Reply-To: <6345300d-8c93-464c-9b05-d0d9af3c97ad@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBydHdf
Y29yZV9lbmFibGVfYmVhY29uKCkgcmVhZHMgNCBieXRlcyBmcm9tIGFuIGFkZHJlc3MgdGhhdCBp
cyBub3QgYQ0KPiBtdWx0aXBsZSBvZiA0LiBUaGlzIHJlc3VsdHMgaW4gYSBjcmFzaCBvbiBzb21l
IHN5c3RlbXMuDQo+IA0KPiBEbyAxIGJ5dGUgcmVhZHMvd3JpdGVzIGluc3RlYWQuDQo+IA0KPiBV
bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3Mg
ZmZmZjgwMDA4MjdlMDUyMg0KPiBNZW0gYWJvcnQgaW5mbzoNCj4gICBFU1IgPSAweDAwMDAwMDAw
OTYwMDAwMjENCj4gICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJpdHMN
Cj4gICBTRVQgPSAwLCBGblYgPSAwDQo+ICAgRUEgPSAwLCBTMVBUVyA9IDANCj4gICBGU0MgPSAw
eDIxOiBhbGlnbm1lbnQgZmF1bHQNCj4gRGF0YSBhYm9ydCBpbmZvOg0KPiAgIElTViA9IDAsIElT
UyA9IDB4MDAwMDAwMjEsIElTUzIgPSAweDAwMDAwMDAwDQo+ICAgQ00gPSAwLCBXblIgPSAwLCBU
bkQgPSAwLCBUYWdBY2Nlc3MgPSAwDQo+ICAgR0NTID0gMCwgT3ZlcmxheSA9IDAsIERpcnR5Qml0
ID0gMCwgWHMgPSAwDQo+IHN3YXBwZXIgcGd0YWJsZTogNGsgcGFnZXMsIDQ4LWJpdCBWQXMsIHBn
ZHA9MDAwMDAwMDAwNTQ5MjAwMA0KPiBbZmZmZjgwMDA4MjdlMDUyMl0gcGdkPTAwMDAwMDAwMDAw
MDAwMDAsIHA0ZD0xMDAwMDAwMTAyMWQ5NDAzLCBwdWQ9MTAwMDAwMDEwMjFkYTQwMywNCj4gcG1k
PTEwMDAwMDAxMTA2MWM0MDMsIHB0ZT0wMDc4MDAwMGYzMjAwZjEzDQo+IEludGVybmFsIGVycm9y
OiBPb3BzOiAwMDAwMDAwMDk2MDAwMDIxIFsjMV0gIFNNUA0KPiBNb2R1bGVzIGxpbmtlZCBpbjog
Wy4uLl0gcnR3ODhfODgyMmNlIHJ0dzg4Xzg4MjJjIHJ0dzg4X3BjaSBydHc4OF9jb3JlIFsuLi5d
DQo+IENQVTogMCBVSUQ6IDAgUElEOiA3MyBDb21tOiBrd29ya2VyL3UzMjoyIFRhaW50ZWQ6IEcg
ICAgICAgIFcgICAgICAgICAgIDYuMTcuOSAjMS1OaXhPUyBWT0xVTlRBUlkNCj4gVGFpbnRlZDog
W1ddPVdBUk4NCj4gSGFyZHdhcmUgbmFtZTogRnJpZW5kbHlFbGVjIE5hbm9QQy1UNiBMVFMgKERU
KQ0KPiBXb3JrcXVldWU6IHBoeTAgcnR3X2MyaF93b3JrIFtydHc4OF9jb3JlXQ0KPiBwc3RhdGU6
IDYwNDAwMDA5IChuWkN2IGRhaWYgK1BBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBCVFlQRT0tLSkN
Cj4gcGMgOiBydHdfcGNpX3JlYWQzMisweDE4LzB4NDAgW3J0dzg4X3BjaV0NCj4gbHIgOiBydHdf
Y29yZV9lbmFibGVfYmVhY29uKzB4ZTAvMHgxNDggW3J0dzg4X2NvcmVdDQo+IHNwIDogZmZmZjgw
MDA4MGNjM2NhMA0KPiB4Mjk6IGZmZmY4MDAwODBjYzNjYTAgeDI4OiBmZmZmMDAwMTAzMWZjMjQw
IHgyNzogZmZmZjAwMDEwMjEwMDgyOA0KPiB4MjY6IGZmZmZkMmNiN2M5YjQwODggeDI1OiBmZmZm
MDAwMTAzMWZjMmMwIHgyNDogZmZmZjAwMDExMmZkZWYwMA0KPiB4MjM6IGZmZmYwMDAxMTJmZGVm
MTggeDIyOiBmZmZmMDAwMTExYzI5OTcwIHgyMTogMDAwMDAwMDAwMDAwMDAwMQ0KPiB4MjA6IDAw
MDAwMDAwMDAwMDAwMDEgeDE5OiBmZmZmMDAwMTExYzIyMDQwIHgxODogMDAwMDAwMDAwMDAwMDAw
MA0KPiB4MTc6IDAwMDAwMDAwMDAwMDAwMDAgeDE2OiAwMDAwMDAwMDAwMDAwMDAwIHgxNTogMDAw
MDAwMDAwMDAwMDAwMA0KPiB4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiAwMDAwMDAwMDAwMDAw
MDAwIHgxMjogMDAwMDAwMDAwMDAwMDAwMA0KPiB4MTE6IDAwMDAwMDAwMDAwMDAwMDAgeDEwOiAw
MDAwMDAwMDAwMDAwMDAwIHg5IDogZmZmZmQyY2I2NTA3YzA5MA0KPiB4OCA6IDAwMDAwMDAwMDAw
MDAwMDAgeDcgOiAwMDAwMDAwMDAwMDAwMDAwIHg2IDogMDAwMDAwMDAwMDAwMDAwMA0KPiB4NSA6
IDAwMDAwMDAwMDAwMDAwMDAgeDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDogMDAwMDAwMDAwMDAw
MDAwMA0KPiB4MiA6IDAwMDAwMDAwMDAwMDdmMTAgeDEgOiAwMDAwMDAwMDAwMDAwNTIyIHgwIDog
ZmZmZjgwMDA4MjdlMDUyMg0KPiBDYWxsIHRyYWNlOg0KPiAgcnR3X3BjaV9yZWFkMzIrMHgxOC8w
eDQwIFtydHc4OF9wY2ldIChQKQ0KPiAgcnR3X2h3X3NjYW5fY2hhbl9zd2l0Y2grMHgxMjQvMHgx
YTggW3J0dzg4X2NvcmVdDQo+ICBydHdfZndfYzJoX2NtZF9oYW5kbGUrMHgyNTQvMHgyOTAgW3J0
dzg4X2NvcmVdDQo+ICBydHdfYzJoX3dvcmsrMHg1MC8weDk4IFtydHc4OF9jb3JlXQ0KPiAgcHJv
Y2Vzc19vbmVfd29yaysweDE3OC8weDNmOA0KPiAgd29ya2VyX3RocmVhZCsweDIwOC8weDQxOA0K
PiAga3RocmVhZCsweDEyMC8weDIyMA0KPiAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANCj4gQ29k
ZTogZDI4ZmUyMDIgOGIwMjAwMDAgZjk1MjQ0MDAgOGIyMTQwMDAgKGI5NDAwMDAwKQ0KPiAtLS1b
IGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCj4gDQo+IEZpeGVzOiBhZDY3NDFiMWUw
NDQgKCJ3aWZpOiBydHc4ODogU3RvcCBoaWdoIHF1ZXVlIGR1cmluZyBzY2FuIikNCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2xvc2VzOiBodHRwczovL2dpdGh1Yi5jb20vbHdmaW5n
ZXIvcnR3ODgvaXNzdWVzLzQxOA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxy
dGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGlo
QHJlYWx0ZWsuY29tPg0KDQoNCg==

