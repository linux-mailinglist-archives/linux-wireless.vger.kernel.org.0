Return-Path: <linux-wireless+bounces-9034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE490A1F4
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 03:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7573C1C20FC2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 01:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C52B176FD8;
	Mon, 17 Jun 2024 01:47:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC4176AB9
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 01:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588867; cv=none; b=T4r+SL37hGtbocb1IWW8H1xizMX1I+gLodeI2fpbD4eCUI665t6NFtL9ieRE/e+D8uxGWkkxsSw1g4ClFrOJmXtbwfDz7souoFlsUu4GtbKe8tEXmRBuGok0KXkdVWBwi9KHzzf9gHahBrGo/iSaU60seTZNMWLo6Qx270g9foI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588867; c=relaxed/simple;
	bh=jl995WOYtVMkFGybQr2HBqScnUoUXIVj0M+0heP91a4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=obxS4MAi20VpNPDNlZ6ZCU5cf8ENrFPgxIfCHECVF3MLC1Xuz2GRbIiteVq7k8EIf0kKXdYEJBbXrhyJQzB6S/pxrjFH0IoDq9amX8ZVyscR9gLi4sFEohTSEplr7KY/3l3OydmnToORNoC9h8DrF+FAIATAMZ9EP3yYMLP7OHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45H1la4iB2540171, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45H1la4iB2540171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 09:47:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 09:47:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Jun 2024 09:47:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 17 Jun 2024 09:47:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <marcin.slusarz@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>
Subject: RE: [PATCH] wifi: rtw88/usb: stop rx work before potential power off
Thread-Topic: [PATCH] wifi: rtw88/usb: stop rx work before potential power off
Thread-Index: AQHatcY9cRA6JA7pWkmRMPi3BJ9Af7G2xtwggA/lWACABJc/YA==
Date: Mon, 17 Jun 2024 01:47:35 +0000
Message-ID: <097ff1363057466ca61aa4f88cc91f9e@realtek.com>
References: <CA+GA0_v1rpoFrRVxpKpYqOrjdxEecn_m3+RKwxYc9H761dpMvw@mail.gmail.com>
 <20240603145535.1858856-1-marcin.slusarz@gmail.com>
 <0063cfc3468f4203a2e5db43d949b10b@realtek.com>
 <CA+GA0_tK_+Rsj0FAxO-_VXBLLFMoxW9FHsWhL6gEoWaOMKwWrA@mail.gmail.com>
In-Reply-To: <CA+GA0_tK_+Rsj0FAxO-_VXBLLFMoxW9FHsWhL6gEoWaOMKwWrA@mail.gmail.com>
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

TWFyY2luIMWabHVzYXJ6IDxtYXJjaW4uc2x1c2FyekBnbWFpbC5jb20+IHdyb3RlOg0KPiB3dC4s
IDQgY3plIDIwMjQgbyAwMjo1NyBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4gbmFw
aXNhxYIoYSk6DQo+ID4NCj4gPiBNYXJjaW4gxZpsdXNhcnogPG1hcmNpbi5zbHVzYXJ6QGdtYWls
LmNvbT4gd3JvdGU6DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L21haW4uYw0KPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC9tYWluLmMNCj4gPiA+IEBAIC0xMzU3LDcgKzEzNTcsNyBAQCBzdGF0aWMgaW50IHJ0d19wb3dl
cl9vbihzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KQ0KPiA+ID4gICAgICAgICBpbnQgcmV0Ow0KPiA+
ID4NCj4gPiA+ICAgICAgICAgaWYgKHJ0d2Rldi0+YWx3YXlzX3Bvd2VyX29uICYmIHRlc3RfYml0
KFJUV19GTEFHX1BPV0VST04sIHJ0d2Rldi0+ZmxhZ3MpKQ0KPiA+ID4gLSAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiA+ID4gKyAgICAgICAgICAgICAgIGdvdG8gc3VjY2VzczsNCj4gPg0KPiA+
IHJ0d19oY2lfc3RhcnRfcngocnR3ZGV2KSBpcyBvbmx5IG5lZWRlZCBieSB0aGlzIGNhc2UsIHNv
DQo+ID4NCj4gPiBpZiAocnR3ZGV2LT5hbHdheXNfcG93ZXJfb24gJiYgdGVzdF9iaXQoUlRXX0ZM
QUdfUE9XRVJPTiwgcnR3ZGV2LT5mbGFncykpIHsNCj4gPiAgICAgICAgIHJ0d19oY2lfc3RhcnRf
cngocnR3ZGV2KTsNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+IH0NCj4gDQo+IFllcywgc3Ry
aWN0bHkgc3BlYWtpbmcsIGl0J3MgbmVlZGVkIG9ubHkgaW4gdGhlIGFsd2F5c19wb3dlcl9vbiBj
YXNlLA0KPiBidXQgZG9pbmcgdGhhdCBpbiB0aGUgY29tbW9uIGNvZGUgcGF0aCBlbnN1cmVzIHRo
YXQgaXQncyB0ZXN0ZWQgYW5kDQo+IHN0aWxsIHdvcmtzLg0KDQpGb3IgdGhlIG5vbi0gYWx3YXlz
X3Bvd2VyX29uIGNhc2UsIGl0IGNhbGxzIHJ0d19oY2lfc3RhcnQoKS9ydHdfaGNpX3N0b3AoKSBh
bHJlYWR5DQpzbyBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBjYWxsIHRoZXNlIGR1cGxpY2F0ZXMu
IA0KDQoNCg==

