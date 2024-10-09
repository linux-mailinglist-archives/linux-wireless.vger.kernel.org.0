Return-Path: <linux-wireless+bounces-13738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F6995C3D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D18284456
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DC423BE;
	Wed,  9 Oct 2024 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="l51KK3U3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76CA47
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 00:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728433123; cv=none; b=RwTU5VERSEmVZl7K5clhPkvrslENfU6+tIX6udlYuyS64cNUg6WjRqa0m46z1tPx7WH4wbHK7u35Ca3ioU6FJD8di79ap+Q1duuwOrMTsPaWXY4A0bistdGprk/562A4b4upG/LE5jQCXk7u3vj3c1xPOwqH3lMOxtaeUrJwYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728433123; c=relaxed/simple;
	bh=HkQPc2FklXoeDr6NmNWGkQdSjI2zV4p5vQ1aWq+NaSM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M7DaJjCMcyB8/m5M/XfTu1J3ia0XfA9XYNIQF/ePg93fpGKW3VtKKApCKbK/+ctgs10z6VgtclNFOYwdIKWPoBPlMULi09AZMMrRnjAQm9fmVGSNP0mnEQ7tLOuRoMeqM8IO9Bl3y0kpooi2ufgkGbPu3WYG8KjlmUiqJ5FaKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=l51KK3U3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4990IUzcC4132718, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728433110; bh=HkQPc2FklXoeDr6NmNWGkQdSjI2zV4p5vQ1aWq+NaSM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=l51KK3U3ism7q4HvpqlcjAx7ofEecH617XYQGznju74FMmiipt6eFo9SqUY+6yxOR
	 K1rXuVTOvX7u76grA3W2pDCgZKpma6+Rk+tAZjgt6EGuw0SMm0HLSRrh/nZaztZ433
	 qyb5OCAZrkhmxqBmY8ndgmrTLc20rq3rVCz1QLMEjYPT14YDH8KM9017uW3UpCAB0e
	 x5MmgBVzvieLRoy1NeU8xreZT1FKxke8w7hZXMXuxvYTVwATJzIq5YNNPYLAuZmeUO
	 P5H/OMWwtWxFGdAi739z1CTIBfhNIvyFslmgVLtQiyRm1RDMXHxBOQLVQ4q/EYMrwm
	 Znd7zFF8qNeUw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4990IUzcC4132718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Oct 2024 08:18:30 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 08:18:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 9 Oct 2024 08:18:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 9 Oct 2024 08:18:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>
Subject: RE: [PATCH] wifi: rtw88: Fix the RX aggregation in USB 3 mode
Thread-Topic: [PATCH] wifi: rtw88: Fix the RX aggregation in USB 3 mode
Thread-Index: AQHbGbIPC7VnZnD73kWpzFtG8qPKSbJ9i+CA
Date: Wed, 9 Oct 2024 00:18:30 +0000
Message-ID: <3731c7452dbf48f8a35e982d08963ba8@realtek.com>
References: <afb94a82-3d18-459e-97fc-1a217608cdf0@gmail.com>
In-Reply-To: <afb94a82-3d18-459e-97fc-1a217608cdf0@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
ODIyQ1UsIFJUTDg4MjJCVSwgYW5kIFJUTDg4MjFDVSBkb24ndCBuZWVkIEJJVF9FTl9QUkVfQ0FM
Qy4NCj4gSW4gZmFjdCwgUlRMODgyMkJVIGluIFVTQiAzIG1vZGUgZG9lc24ndCBwYXNzIGFsbCB0
aGUgZnJhbWVzIHRvIHRoZQ0KPiBkcml2ZXIsIHJlc3VsdGluZyBpbiBtdWNoIGxvd2VyIGRvd25s
b2FkIHNwZWVkIHRoYW4gbm9ybWFsOg0KDQpIYXZlIHlvdSBhbHNvIHRlc3RlZCBpbiBVU0IgMiBt
b2RlPyBKdXN0IHdhbnQgdG8ga25vdyB0aGlzIHBhdGNoIHdvcmtzIG9uDQpib3RoIG1vZGVzLiAN
Cg0KPiBbICA1XSAgIDAuMDAtMTAuMDAgIHNlYyAgOTguNiBNQnl0ZXMgIDgyLjcgTWJpdHMvc2Vj
ICAgICAgICAgICAgICAgICAgcmVjZWl2ZXINCj4gDQo+IERvbid0IHNldCBCSVRfRU5fUFJFX0NB
TEMuIFRoZW4gdGhlIHNwZWVkIGlzIG11Y2ggYmV0dGVyOg0KPiANCj4gWyAgNV0gICAwLjAwLTEw
LjAwICBzZWMgICA3MTQgTUJ5dGVzICAgNTk5IE1iaXRzL3NlYyAgICAgICAgICAgICAgICAgIHJl
Y2VpdmVyDQoNCkdvb2Qgam9iLiBUaGF0IGltcHJvdmVzIHRlbiB0aW1lcyBvZiBSWCB0aHJvdWdo
cHV0IQ0KDQo+IA0KPiBGaXhlczogMDAyYTVkYjlhNTJhICgid2lmaTogcnR3ODg6IEVuYWJsZSBV
U0IgUlggYWdncmVnYXRpb24gZm9yIDg4MjJjLzg4MjJiLzg4MjFjIikNCj4gU2lnbmVkLW9mZi1i
eTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5
OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KPiAtLS0NCj4gVGhlIGNvZGUg
aW4gdGhlIG9mZmljaWFsIGRyaXZlcnMgaXMgYSBsaXR0bGUgYnJva2VuLiBJdCBzZXRzDQo+IEJJ
VF9FTl9QUkVfQ0FMQyBhbmQgdGhlbiBpbW1lZGlhdGVseSB1bnNldHMgaXQuIEkgZGlkbid0IG5v
dGljZSB0aGF0DQo+IGJlZm9yZS4NCj4gDQo+IE1heWJlIHRoaXMgc2hvdWxkIGdvIHRvIGtlcm5l
bCA2LjEyLCBpZiBpdCdzIG5vdCB0b28gbGF0ZS4gQ29tbWl0IDAwMmE1ZGI5YTUyYQ0KPiAoIndp
Zmk6IHJ0dzg4OiBFbmFibGUgVVNCIFJYIGFnZ3JlZ2F0aW9uIGZvciA4ODIyYy84ODIyYi84ODIx
YyIpIGZpcnN0IGFwcGVhcnMNCj4gaW4gNi4xMi4NCg0KS2FsbGUsIGNvdWxkIHlvdSBoZWxwIHRv
IHRha2UgdGhpcyBwYXRjaCB2aWEgd2lyZWxlc3MgdHJlZT8gSWYgeWVzLCBJIHdpbGwNCmFzc2ln
biB0aGlzIHRvIHlvdSBpbiBwYXRjaHdvcmsuIA0KDQoNCg==

