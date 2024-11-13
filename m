Return-Path: <linux-wireless+bounces-15224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287C99C6680
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 02:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36E61F23A85
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 01:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057BD2582;
	Wed, 13 Nov 2024 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wey9I4kE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630113AC1
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460504; cv=none; b=OD3wLqMHXYs5ZEXqh8QyhGOXMy3AMiUOXU9FTECizXkQDVnT3keOEIzpqGLNttHRS2lXWe0hCV27vIXwVkF1na7LaxbE+kQt4yNXcb63+okko20T2a34jGRKykgADFVjPhxxxflbS0teFQ4TWlacAzYJmcTrHSywwgd4jIvEFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460504; c=relaxed/simple;
	bh=CjEGDtgAbUV/Ripd0Hk9gwOJq0TExuDvt/8DQOoHoco=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FQqfz7p57MCn8wP+7ja1YIZT7t2mnE+Y55KqNFVAsz7SiOufCSOhh6bJJdms5IhReCEizY6xJ/cktbWuWKKLM67I0c266ufurqny7rOCgdSPlZ2s3fZOCulQVSfk1U/DNygrBLkvh/hr91poKrnMGlQdjnwVHYA1rVuc4zvVKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wey9I4kE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AD1Ej6Y2450685, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731460485; bh=CjEGDtgAbUV/Ripd0Hk9gwOJq0TExuDvt/8DQOoHoco=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wey9I4kEQX1+siC+mbMbX8k7nn7VaOSWKJVjBlS/NRvAwr6YfcSORdYyQpUNn52jJ
	 i0pEze6j2wgCX1LxkhT12JyviB6WJssjhb2NcQVi6GLlG35SCsyWYs64rNSSl+tzKP
	 SfaaTxbkNFvftrH/qqIAMa0Bt/LrUdftQjmI/8p7WEptZgCfBUaD4jor2Ikuvt+kOX
	 2cpoQ/m2VLnBuPdXBmtuiCsLVLFg/xAGFPJO/cgmNPRiylNlU2hK9SlfmvbwaJUZTv
	 1+BuWxJQDP2rnesbjRJgHYcZR2KQoiL/LBhz9bNlMqdAP/9n+blVQI4ujaBixgU3EO
	 KaPncHNZWA4Rg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AD1Ej6Y2450685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 09:14:45 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 09:14:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Nov 2024 09:14:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 13 Nov 2024 09:14:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kees Bakker <kees@ijzerbout.nl>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v4 3/7] wifi: rtw88: Add rtw88xxa.{c,h}
Thread-Topic: [PATCH v4 3/7] wifi: rtw88: Add rtw88xxa.{c,h}
Thread-Index: AQHbKvlrKyf/Z69aEEaCT7OoWVNnl7Kzn/2AgADb1bA=
Date: Wed, 13 Nov 2024 01:14:44 +0000
Message-ID: <c368f9060bae4da78acdff6657a26a7d@realtek.com>
References: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com>
 <b8590382-a954-412d-a96b-63e360b97acc@gmail.com>
 <9f95ac78-ed69-4554-825e-3ad294f49057@ijzerbout.nl>
In-Reply-To: <9f95ac78-ed69-4554-825e-3ad294f49057@ijzerbout.nl>
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

PiA+ICtzdGF0aWMgdm9pZCBydHc4OHh4YXVfaW5pdF9xdWV1ZV9yZXNlcnZlZF9wYWdlKHN0cnVj
dCBydHdfZGV2ICpydHdkZXYpDQo+ID4gK3sNCj4gPiArICAgICBjb25zdCBzdHJ1Y3QgcnR3X2No
aXBfaW5mbyAqY2hpcCA9IHJ0d2Rldi0+Y2hpcDsNCj4gPiArICAgICBzdHJ1Y3QgcnR3X2ZpZm9f
Y29uZiAqZmlmbyA9ICZydHdkZXYtPmZpZm87DQo+ID4gKyAgICAgY29uc3Qgc3RydWN0IHJ0d19w
YWdlX3RhYmxlICpwZ190YmwgPSBOVUxMOw0KPiA+ICsgICAgIHUxNiBwdWJxX251bTsNCj4gPiAr
ICAgICB1MzIgdmFsMzI7DQo+ID4gKw0KPiA+ICsgICAgIHN3aXRjaCAocnR3X2hjaV90eXBlKHJ0
d2RldikpIHsNCj4gPiArICAgICBjYXNlIFJUV19IQ0lfVFlQRV9QQ0lFOg0KPiA+ICsgICAgICAg
ICAgICAgcGdfdGJsID0gJmNoaXAtPnBhZ2VfdGFibGVbMV07DQo+ID4gKyAgICAgICAgICAgICBi
cmVhazsNCj4gPiArICAgICBjYXNlIFJUV19IQ0lfVFlQRV9VU0I6DQo+ID4gKyAgICAgICAgICAg
ICBpZiAocnR3ZGV2LT5oY2kuYnVsa291dF9udW0gPT0gMikNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgcGdfdGJsID0gJmNoaXAtPnBhZ2VfdGFibGVbMl07DQo+ID4gKyAgICAgICAgICAgICBl
bHNlIGlmIChydHdkZXYtPmhjaS5idWxrb3V0X251bSA9PSAzKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBwZ190YmwgPSAmY2hpcC0+cGFnZV90YWJsZVszXTsNCj4gPiArICAgICAgICAgICAg
IGVsc2UgaWYgKHJ0d2Rldi0+aGNpLmJ1bGtvdXRfbnVtID09IDQpDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIHBnX3RibCA9ICZjaGlwLT5wYWdlX3RhYmxlWzRdOw0KPiA+ICsgICAgICAgICAg
ICAgYnJlYWs7DQo+ID4gKyAgICAgY2FzZSBSVFdfSENJX1RZUEVfU0RJTzoNCj4gPiArICAgICAg
ICAgICAgIHBnX3RibCA9ICZjaGlwLT5wYWdlX3RhYmxlWzBdOw0KPiA+ICsgICAgICAgICAgICAg
YnJlYWs7DQo+ID4gKyAgICAgZGVmYXVsdDoNCj4gQWxsIG90aGVyIHN3aXRjaCAocnR3X2hjaV90
eXBlKHJ0d2RldikpIGluIHRoaXMgbW9kdWxlIGhhbmRsZQ0KPiB0aGUgZGVmYXVsdCB3aXRoIGFu
IGVycm9yLiBTaG91bGRuJ3QgeW91IGJlIGRvaW5nIHRoYXQgaGVyZSB0b28/DQo+IEluIHRoZSBk
ZWZhdWx0IGNhc2UgdGhlIGNvZGUgY29udGludWVzIHdpdGggcGdfdGJsID09IE5VTEwNCj4gYW5k
IHRodXMgaXQgd2lsbCBjcmFzaC4NCg0KQWN0dWFsbHkgdGhyZWUgc3VwcG9ydGVkIEhDSSB0eXBl
cyBhcmUgbGlzdGVkLCBzbyBpdCB3aWxsIG5ldmVyIGZhbGwgaW50bw0KdGhlIGRlZmF1bHQgY2Fz
ZSwgd2hpY2ggSSB0aGluayB0aGlzIGlzIGp1c3QgdG8gYXZvaWQgc3RhdGljIGNoZWNrZXJzIGNv
bXBsYWluLiANCkhvd2V2ZXIsICdyZXR1cm4nIHdvdWxkIGJlIG1vcmUgc3VpdGFibGUgdGhhbiAn
YnJlYWsnIGZvciBkZWZhdWx0IGNhc2UuIA0KDQo+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ICsg
ICAgIH0NCg0KDQo=

