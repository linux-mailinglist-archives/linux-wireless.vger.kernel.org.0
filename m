Return-Path: <linux-wireless+bounces-7857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D828CA61D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 04:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C119282796
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 02:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096ABCA40;
	Tue, 21 May 2024 02:19:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D3C8D7
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716257961; cv=none; b=XzSpSGHchuVcRBXVKceklm/dOAJPT3GhjEEgMbTp3FUvSGH0XI86jSWWb5ZA5h3LFnjQ5tafj49uRw+U37ZecMv9GR1dj9UoRBAP/pMRLdOHBNIM5G/haBOczIUDAmK8EIt8s/RpHAaO8eOieaqtMsg2HSXpWhlIntPbrRMIQLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716257961; c=relaxed/simple;
	bh=+EVBU7YkSJxw8r+RY8Co6QWBJ7GLVIKYewH9wZEs97Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fXmgJz1QekQmea4Oej7cENgxcgOG7IkcMOjDED3OhSg6SQ8vcps1KsXF+4pwQbQ6kOSzSLcWUBFRC6XcRiktcO48gDLwir08jkaizaSBatlXNctyaCaXPMi3fHtbWMkE3hZW/m8pkWpU7WLUF4Nn/f1Qo1ttM1cjfUrS5T0woOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44L2IpqvE2059861, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44L2IpqvE2059861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 10:18:51 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 10:18:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 21 May 2024 10:18:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 21 May 2024 10:18:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v6 03/11] wifi: rtlwifi: Add rtl8192du/hw.{c,h}
Thread-Topic: [PATCH v6 03/11] wifi: rtlwifi: Add rtl8192du/hw.{c,h}
Thread-Index: AQHaqJ9yDauRqpZnYkmqypfDXguzILGg9qBA
Date: Tue, 21 May 2024 02:18:51 +0000
Message-ID: <b21b15b482e54d359bde965df3f33e45@realtek.com>
References: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
 <44fe73c4-a852-4de8-8f3a-081749ac5709@gmail.com>
In-Reply-To: <44fe73c4-a852-4de8-8f3a-081749ac5709@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBjb250YWluIG1vc3RseSBoYXJkd2FyZSBpbml0L2RlaW5pdCByb3V0aW5lcyBmb3IgUlRMODE5
MkRVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQo+IC0tLQ0KPiB2NjoNCj4gIC0gRG9uJ3QgY2FsbCBsb2NhbF9pcnFfZW5h
YmxlIGluIHJ0bDkyZHVfaHdfaW5pdC4gSXQgc2VlbXMgdG8gYmUNCj4gICAgcG9pbnRsZXNzLg0K
PiAgLSBVcGRhdGUgY29weXJpZ2h0IHllYXIuDQo+ICAtIFJlbW92ZSBzb21lIHVudXNlZCBpbmNs
dWRlcy4NCj4gIC0gTWFrZSBhbGwgZnVuY3Rpb25zIHVzZSB0aGUgcHJlZml4ICJydGw5MmR1Ii4N
Cg0KU29tZXRoaW5nIGxpa2UgcnRsOTJkZV9zdG9wX3R4X2JlYWNvbigpIGNhbGxlZCBieSB0aGlz
IGZpbGUgc2hvdWxkIGJlDQpwcmVmaXggInJ0bDkyZCIgYmVjYXVzZSB0aGV5IGFyZSBzaGFyZWQg
d2l0aCA4MTkyRFUgYW5kIDgxOTJERS4gDQpJIG1pc3NlZCB0aGlzIHBvaW50IHdoaWxlIG1vdmlu
ZyA4MTkyZGUgY29kZSB0byBjb21tb24gcGFydC4gDQoNCkkgdGhpbmsgd2Ugc2hvdWxkIGFkZCBh
IHBhdGNoIGFzIGZpcnN0IG9uZSBwYXRjaCB0byBjaGFuZ2UgdGhlIG5hbWluZy4gDQoNCg0KDQo=

