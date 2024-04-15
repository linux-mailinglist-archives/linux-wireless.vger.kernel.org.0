Return-Path: <linux-wireless+bounces-6293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340DA8A4669
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 02:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED351F211A2
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 00:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20D81859;
	Mon, 15 Apr 2024 00:57:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B9639
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713142654; cv=none; b=DTKG2jKobKh4lLCmKIAQpfhGx/rcwWI1Muhl3J4WcDPACqTZfjcwXxpU963+fZ3k7+OvSo3WMlonm8Rn3ci/F8TzbrJYS2myIXcal1tkQzz1a+R16+UbBHDdJHEheCzDsGmnmVhvmezyEfv4o+hfuzmI+PWU0g7ojVLUyktNdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713142654; c=relaxed/simple;
	bh=v+5Ib0iMDPp/KE5L6SVr5+OOc41ZpAYsr4WiVIzpKao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hP/kJqeJvJx6JG/XSdP09c2XUbvdwK+2Z2OB3e3kTLo31DR2ht8DUubVBl2goqDsKvkGog7+caHt8hFhelMpzpMDib3cOnHcvowJGBxalr1YqMX5JL+2hpZqLhXv33mJ+mVcuTL11r71a0/3xF+8lGmH5dX5118dRfU596mw6YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43F0v8SB1344407, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43F0v8SB1344407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 08:57:08 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 08:57:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 08:57:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 15 Apr 2024 08:57:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Martin Kaistra
	<martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: RE: [PATCH] wifi: rtl8xxxu: enable MFP support
Thread-Topic: [PATCH] wifi: rtl8xxxu: enable MFP support
Thread-Index: AQHadi+EaQT0NSwYfk2FMY1mPLyqGrFnTGAAgAFloaA=
Date: Mon, 15 Apr 2024 00:57:08 +0000
Message-ID: <9ba097ae2db4418a9b95aa22f53f9367@realtek.com>
References: <20240314164850.86432-1-martin.kaistra@linutronix.de>
 <fa903f58-2362-49a1-9880-2b3fcbe1869e@gmail.com>
In-Reply-To: <fa903f58-2362-49a1-9880-2b3fcbe1869e@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KDQo+ID4g
QEAgLTc5OTgsNiArODAwMiw3IEBAIHN0YXRpYyBpbnQgcnRsOHh4eHVfcHJvYmUoc3RydWN0IHVz
Yl9pbnRlcmZhY2UgKmludGVyZmFjZSwNCj4gPiAgICAgICBpZWVlODAyMTFfaHdfc2V0KGh3LCBI
QVNfUkFURV9DT05UUk9MKTsNCj4gPiAgICAgICBpZWVlODAyMTFfaHdfc2V0KGh3LCBTVVBQT1JU
X0ZBU1RfWE1JVCk7DQo+ID4gICAgICAgaWVlZTgwMjExX2h3X3NldChodywgQU1QRFVfQUdHUkVH
QVRJT04pOw0KPiA+ICsgICAgIGllZWU4MDIxMV9od19zZXQoaHcsIE1GUF9DQVBBQkxFKTsNCj4g
Pg0KPiA+ICAgICAgIHdpcGh5X2V4dF9mZWF0dXJlX3NldChody0+d2lwaHksIE5MODAyMTFfRVhU
X0ZFQVRVUkVfQ1FNX1JTU0lfTElTVCk7DQo+ID4NCj4gDQo+IEkgcmFuIGludG8gdGhpcyBwcm9i
bGVtIHJlY2VudGx5IHdpdGggcnRsODE5MmR1Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC13aXJlbGVzcy9lZDEyZWMxNy1hZTZlLTQ1ZmEtYTcyZi0yM2UwYTM0NjU0ZGFAZ21haWwu
Y29tLw0KPiANCj4gRG9lcyB0aGUgc2FtZSBmaXggd29yayBmb3IgeW91IGluIHJ0bDh4eHh1PyBD
aGVja2luZyB0aGUgInNlY3VyaXR5Ig0KPiBmaWVsZCBvZiB0aGUgUlggZGVzY3JpcHRvciBpcyBz
aW1wbGVyIHRoYW4gY2FsbGluZyB0d28gZnVuY3Rpb25zLg0KPiBTb3JyeSB0byBib3RoZXIgeW91
IHdoZW4gdGhlIHBhdGNoIGlzIGFscmVhZHkgYXBwbGllZC4NCj4gDQo+IEFsc28sIHdvbid0IHlv
dSBzZW5kIHRoZSBwYXRjaCB0byB0aGUgc3RhYmxlIHRyZWU/DQoNCkknbSBub3QgYXdhcmUgb2Yg
dHdvIHBhdGNoZXMgZGlkIHRoZSBzaW1pbGFyIHRoaW5nLiBUaGFua3MgZm9yIHBvaW50aW5nIHRo
aXMuIA0KDQpNYXJ0aW4sIHBsZWFzZSBjaGVjayBpZiB5b3UgbWV0IHRoZSBzYW1lIHByb2JsZW0g
YXMgQml0dGVyYmx1ZSdzIG9uZS4gSWYgeW91DQp3YW50IHRvIGFkZCB0aGlzIGZpeCB0byBzdGFi
bGUgdHJlZSwgcGxlYXNlIHByb3ZpZGUgdHdvIHBhdGNoZXMgLS0gb25lIGlzIHRvDQpyZXZlcnQg
dGhpcyBwYXRjaCwgYW5kIGFuIG5ldyBvbmUgdG8gYWRkIEJpdHRlcmJsdWUncyBtZXRob2Qgd2l0
aCBDYyBzdGFibGUuDQoNClBpbmctS2UgDQoNCg0K

