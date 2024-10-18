Return-Path: <linux-wireless+bounces-14202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C09A35CB
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 08:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658DA1C211C5
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 06:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7328F190470;
	Fri, 18 Oct 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LcB6ubVh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA35189BAF
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233672; cv=none; b=jI6homrLtleecN9jT0prpDON6VE2CQODhMn5GToOpINqed/mxQ49SpXo/OpY2EWX0mF6o5rzCxyDRn8JBV6LJEnpkNOUI9kyq2pOZP33os7bxElJqvNUhc20XNDx/dmZfxK87tqbKqmCLlfVlxbJbt8ABDXP3GiOYGWmEdoOamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233672; c=relaxed/simple;
	bh=0/C70EpFcZPIe7lPCUbs9bX1Moy481JQiQ+Wyvcvpt4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rf5BLwP7f/KbMqOvIOk+Z/Hkh4NnLKixJHtJTKqWi49DHikzQNwmSlnjSpLZ/9pW2AGU6so+i9L5Qk6ymEJjscEoDmSpEkUqOAnRk+RiRx+399VvqRnTeNOPb3UFikKZtHkVTciJKuwZU1/1FVFxa4mjh6r3NMh1oOTgwsuSLqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LcB6ubVh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I6f5tD51633045, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729233665; bh=0/C70EpFcZPIe7lPCUbs9bX1Moy481JQiQ+Wyvcvpt4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LcB6ubVh7OdzRYnFN9utLFRAMAQLAbNVfBmamgqsgl/CAOE1mKaMiJzW/0JVZw/6S
	 Z+HnosAqXIRdKqSLPb4cGcmU32p7agCPX9v4dL+42zqrwihpGdnUKTtxApuYi2qGk7
	 anFIu0vNSBwMUstM52Zph7Tq2rq6RgE8qTXZhpT27Txt+xKB0jvZG5ZedC1vTUjxzy
	 mo7hiNF2Szzek2MufD6lpzDuKdF8J3Ki/gJjUaW+Mzu7BNJLCE4S1TAWVchtSqM4sk
	 afMharzsCbnHkfIc00Q6RwTDmlTbPY+lSR2BLZdS5NnfrMBxxdULXpAJRLYnkhdXXM
	 0hsY6h4Zrt56A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I6f5tD51633045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:41:05 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 14:41:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Oct 2024 14:41:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 18 Oct 2024 14:41:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 10/22] wifi: rtw88: Move pwr_track_tbl to struct rtw_rfe_def
Thread-Topic: [PATCH v2 10/22] wifi: rtw88: Move pwr_track_tbl to struct
 rtw_rfe_def
Thread-Index: AQHbHB9Oz4o5jrKllUCAROxJKJEbAbKMF5CA
Date: Fri, 18 Oct 2024 06:41:05 +0000
Message-ID: <2429b39cb60941bca351455e1eed7a24@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <46e4f978-7dc3-447b-a744-a4ea7654ab5b@gmail.com>
In-Reply-To: <46e4f978-7dc3-447b-a744-a4ea7654ab5b@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmggYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uaA0KPiBpbmRleCBlZjgyZTYwZDVj
MTkuLjA3MmQwOWE3ZDMxMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC9tYWluLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC9tYWluLmgNCj4gQEAgLTExMDAsMTYgKzExMDAsMTkgQEAgc3RydWN0IHJ0d19yZmVfZGVm
IHsNCj4gICAgICAgICBjb25zdCBzdHJ1Y3QgcnR3X3RhYmxlICpwaHlfcGdfdGJsOw0KPiAgICAg
ICAgIGNvbnN0IHN0cnVjdCBydHdfdGFibGUgKnR4cHdyX2xtdF90Ymw7DQo+ICAgICAgICAgY29u
c3Qgc3RydWN0IHJ0d190YWJsZSAqYWdjX2J0Z190Ymw7DQo+ICsgICAgICAgY29uc3Qgc3RydWN0
IHJ0d19wd3JfdHJhY2tfdGJsICpwd3JfdHJhY2tfdGJsOw0KPiAgfTsNCj4gDQo+IC0jZGVmaW5l
IFJUV19ERUZfUkZFKGNoaXAsIGJiX3BnLCBwd3JsbXQpIHsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXA0KPiArI2RlZmluZSBSVFdfREVGX1JGRShjaGlwLCBiYl9wZywgcHdybG10LCB0
cmFjaykgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgIC5waHlf
cGdfdGJsID0gJnJ0dyAjIyBjaGlwICMjIF9iYl9wZ190eXBlICMjIGJiX3BnICMjIF90YmwsICAg
ICAgIFwNCj4gICAgICAgICAudHhwd3JfbG10X3RibCA9ICZydHcgIyMgY2hpcCAjIyBfdHhwd3Jf
bG10X3R5cGUgIyMgcHdybG10ICMjIF90YmwsIFwNCj4gKyAgICAgICAucHdyX3RyYWNrX3RibCA9
ICZydHcgIyMgY2hpcCAjIyBfcHdyX3RyYWNrX3R5cGUgIyMgdHJhY2sgIyMgX3RibCwgXA0KPiAg
ICAgICAgIH0NCj4gDQo+IC0jZGVmaW5lIFJUV19ERUZfUkZFX0VYVChjaGlwLCBiYl9wZywgcHdy
bG10LCBidGcpIHsgICAgICAgICAgICAgICAgICAgICAgXA0KPiArI2RlZmluZSBSVFdfREVGX1JG
RV9FWFQoY2hpcCwgYmJfcGcsIHB3cmxtdCwgdHJhY2ssIGJ0ZykgeyAgICAgICAgICAgICAgICAg
ICAgICAgXA0KDQpXaHkgbm90IGtlZXAgdGhlIHNhbWUgb3JkZXIgb2Ygc3RydWN0IGRlY2xhcmF0
aW9uPyANCg0KSSBndWVzcyB5b3Ugd2FudCBmaXJzdCB0aHJlZSBhcmd1bWVudHMgb2YgUlRXX0RF
Rl9SRkUoKSBhbmQgUlRXX0RFRl9SRkVfRVhUKCkNCmFyZSB0aGUgc2FtZSwgcmlnaHQ/IE1vdmUg
JyBwd3JfdHJhY2tfdGJsJyBlbnRyeSBpbiBzdHJ1Y3QgdXB3YXJkIG9uZSBsaW5lIGFzDQpiZWxv
dyBvcmRlcj8NCg0KPiAgICAgICAgIC5waHlfcGdfdGJsID0gJnJ0dyAjIyBjaGlwICMjIF9iYl9w
Z190eXBlICMjIGJiX3BnICMjIF90YmwsICAgICAgIFwNCj4gICAgICAgICAudHhwd3JfbG10X3Ri
bCA9ICZydHcgIyMgY2hpcCAjIyBfdHhwd3JfbG10X3R5cGUgIyMgcHdybG10ICMjIF90YmwsIFwN
Cj4gKyAgICAgICAucHdyX3RyYWNrX3RibCA9ICZydHcgIyMgY2hpcCAjIyBfcHdyX3RyYWNrX3R5
cGUgIyMgdHJhY2sgIyMgX3RibCwgXA0KPiAgICAgICAgIC5hZ2NfYnRnX3RibCA9ICZydHcgIyMg
Y2hpcCAjIyBfYWdjX2J0Z190eXBlICMjIGJ0ZyAjIyBfdGJsLCBcDQo+ICAgICAgICAgfQ0KPiAN
Cg0K

