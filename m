Return-Path: <linux-wireless+bounces-26846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2BDB3B149
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 05:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCB79806DB
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 03:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597061EF39F;
	Fri, 29 Aug 2025 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qMV+dOkE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A25D515;
	Fri, 29 Aug 2025 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436592; cv=none; b=JIV0EEc0Ru7NXFE9yLBu2Xcrs0KYX6FeTv5siUc6A/0H1XJBv8yGZ3zH+WAOnh2QQjOfQXsxaFosAcfG4npJJm65E7pW+QnWHGaQYPc9qfoMKNOE8baXQwk+XrtJ82X4MMpdvgJq2KjiNzhdsmC9IMnza8zs27R+VzSSI/TtceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436592; c=relaxed/simple;
	bh=kkasfrkELPKuOakCSboKuy0RiMRSQMgjog1NH65PKxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BOLArpDT8/Q4qjvOsxC6ZWvIvo2nHeFSQVpPVA7cApKmBFyiwvMIvtx7xAjJ2rD7InET4IAyo6urs08eG6iROg3i7ZS7BFVuWfEwxtq1EIhTMUE18I3ewQvcYFmuXOqyzs17FsCuHC7tdLUaLj/72NEuV6m6w5loQjMiwpnGir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qMV+dOkE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57T32ltR62929369, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756436567; bh=kkasfrkELPKuOakCSboKuy0RiMRSQMgjog1NH65PKxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qMV+dOkE7aTAgqj6pCa+XfGXLJoPSe+4tX54P1Y5FkIEtOiL/uaPEoecb7hfijRrn
	 Hv7pv/2La8+DjhpWdQRM7fYa7I9EpM674wW85pAhGuce3/ZPmAr7tMI/7qxID7TgtQ
	 GNLQlK5bWirNXtqWzmgfhdySTP+qB9TCjVYTylUphrXXfU2lmZLnPDgn7ElQ8EuD9e
	 mTvYnbIrlWRZuq9Np8y/uEN0CwDeYB5QtN78N5o/I9Esd1OismRLEVVDFSZBzJ3mCq
	 /7ZsozjGKxnL3zjAdEaDHre5XxTDPTXtlw6VVScEpIIHhu0Y2kjaoclOykEq1uZzah
	 SoaJdM+M9Rewg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57T32ltR62929369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 11:02:47 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 29 Aug 2025 11:02:47 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d]) by
 RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d%2]) with mapi id
 15.01.2507.035; Fri, 29 Aug 2025 11:02:47 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: "pchelkin@ispras.ru" <pchelkin@ispras.ru>
CC: Ping-Ke Shih <pkshih@realtek.com>, Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw v2 1/4] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Thread-Topic: [PATCH rtw v2 1/4] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Thread-Index: AQHcF8icTIlJtwQk2kOn9fej8NWkdbR3L+cQgAA6HQCAAX51UA==
Date: Fri, 29 Aug 2025 03:02:47 +0000
Message-ID: <da4e555fb0e6404386a5b18f17dbc296@realtek.com>
References: <20250827120603.723548-2-pchelkin@ispras.ru>
 <87693651fe394065b421d8d8fe171f89@realtek.com>
 <20250828140912-171fa800b314416241936137-pchelkin@ispras>
In-Reply-To: <20250828140912-171fa800b314416241936137-pchelkin@ispras>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RmVkb3IgUGNoZWxraW4gPHBjaGVsa2luQGlzcHJhcy5ydT4gd3JvdGU6DQo+IA0KPiBUaGFua3Mh
IEkgYWdyZWUgd2l0aCBhbGwgYWZvcmVtZW50aW9uZWQgY29tbWVudHMgYnV0IHdvbmRlciBhYm91
dCB0aGlzIG9uZToNCj4gDQo+IE9uIFRodSwgMjguIEF1ZyAwODowNywgWm9uZy1aaGUgWWFuZyB3
cm90ZToNCj4gPiBGZWRvciBQY2hlbGtpbiA8cGNoZWxraW5AaXNwcmFzLnJ1PiB3cm90ZToNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcGNpLmMNCj4gPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcGNpLmMNCj4gPiA+IEBA
IC00NjQsMTAgKzQ2NCw3IEBAIHN0YXRpYyB2b2lkIHJ0dzg5X3BjaV90eF9zdGF0dXMoc3RydWN0
IHJ0dzg5X2RldiAqcnR3ZGV2LA0KPiA+ID4gICAgIHN0cnVjdCBydHc4OV90eF9za2JfZGF0YSAq
c2tiX2RhdGEgPSBSVFc4OV9UWF9TS0JfQ0Ioc2tiKTsNCj4gPiA+ICAgICBzdHJ1Y3QgaWVlZTgw
MjExX3R4X2luZm8gKmluZm87DQo+ID4gPg0KPiA+ID4gLSAgIHJ0dzg5X2NvcmVfdHhfd2FpdF9j
b21wbGV0ZShydHdkZXYsIHNrYl9kYXRhLCB0eF9zdGF0dXMgPT0gUlRXODlfVFhfRE9ORSk7DQo+
ID4gPiAtDQo+ID4gPiAgICAgaW5mbyA9IElFRUU4MDIxMV9TS0JfQ0Ioc2tiKTsNCj4gPiA+IC0g
ICBpZWVlODAyMTFfdHhfaW5mb19jbGVhcl9zdGF0dXMoaW5mbyk7DQo+ID4gPg0KPiA+ID4gICAg
IGlmIChpbmZvLT5mbGFncyAmIElFRUU4MDIxMV9UWF9DVExfTk9fQUNLKQ0KPiA+ID4gICAgICAg
ICAgICAgaW5mby0+ZmxhZ3MgfD0gSUVFRTgwMjExX1RYX1NUQVRfTk9BQ0tfVFJBTlNNSVRURUQ7
DQo+ID4gPiBAQCAtNDk0LDYgKzQ5MSwxMCBAQCBzdGF0aWMgdm9pZCBydHc4OV9wY2lfdHhfc3Rh
dHVzKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCj4gPiA+ICAgICAgICAgICAgIH0NCj4gPiA+
ICAgICB9DQo+ID4gPg0KPiA+ID4gKyAgIGlmIChydHc4OV9jb3JlX3R4X3dhaXRfY29tcGxldGUo
cnR3ZGV2LCBza2JfZGF0YSwgdHhfc3RhdHVzID09IFJUVzg5X1RYX0RPTkUpKQ0KPiA+ID4gKyAg
ICAgICAgICAgcmV0dXJuOw0KPiA+ID4gKw0KPiA+ID4gKyAgIGllZWU4MDIxMV90eF9pbmZvX2Ns
ZWFyX3N0YXR1cyhpbmZvKTsNCj4gPg0KPiA+IERvbid0IGNoYW5nZSBvcmRlciBvZiB0aGVzZSBj
YWxscy4NCj4gPiAoaXQncyB3cm9uZyBmb3Igbm9ybWFsIHBrdCBiZWNhdXNlIHRoZWlyIHR4X2lu
Zm8gYXJlIGNsZWFyZWQgYWZ0ZXINCj4gPiBmaWxsZWQpDQo+ID4NCj4gDQo+IGllZWU4MDIxMV90
eF9pbmZvX2NsZWFyX3N0YXR1cygpIGNsZWFycyBvbmx5IFRYIHN0YXR1cyBwYXJ0IG9mIHRoZSBp
ZWVlODAyMTFfdHhfaW5mby4gSXQNCj4gZG9lc24ndCB0b3VjaCAnZmxhZ3MnIGZpZWxkIC0gdGhl
IG9ubHkgb25lIGZpbGxlZCBoZXJlIGJ5IHJ0dzg5X3BjaV90eF9zdGF0dXMoKS4gSXQgc2hvdWxk
bid0IGJlDQo+IHdyb25nIGZvciBub3JtYWwgcGFja2V0cy4NCj4gDQoNCkkgZG91YmxlIGNoZWNr
ZWQgaXQgYWdhaW4gYW5kIHRoaW5rIHlvdSBhcmUgcmlnaHQuDQpJIG1pc3JlYWQgdHhfaW5mby0+
ZmxhZ3MgYWdhaW5zdCB0eF9pbmZvLT5zdGF0dXMuZmxhZ3MuDQpTb3JyeS4NCg0KPiBUaGUgcmVh
c29uIGZvciBjaGFuZ2luZyB0aGUgb3JkZXIgb2YgdGhvc2UgY2FsbHMgaXMgdG8gaGF2ZSBhIGNo
YW5jZSB0byB1cGRhdGUgdHhfcmluZw0KPiBzdGF0aXN0aWNzIGJlZm9yZSBmYXN0IHJldHVybiBm
cm9tIHJ0dzg5X3BjaV90eF9zdGF0dXMoKSBpbiBjYXNlIG9mIHR4X3dhaXQgcGFja2V0cy4NCj4g
DQo+IEJ1dCwgZXJnaCwgSSBjYW4ndCBmaW5kIHRob3NlIHN0YXRzIHJlcG9ydGVkIGFueXdoZXJl
IGluIHRoZSBkcml2ZXIgc28gaXQgbG9va3MgbGlrZSBqdXN0IG5vdCBhIHJlYWwNCj4gaXNzdWUg
Y3VycmVudGx5IGFuZCBJJ2QgcmF0aGVyIG5vdCBjaGFuZ2UgdGhlIG9yZGVyLCBva2F5Lg0KPiAN
Cg0KVGhlc2Ugc3RhdGlzdGljcyBhcmUgdXNlZCB3aGVuIGRlYnVnZ2luZyBub3JtYWwgcGFja2V0
cyBmcm9tIHN0YWNrLg0KRm9yIGRyaXZlciBwYWNrZXRzICh3aXRoIHR4IHdhaXQpLCBJIHRoaW5r
IHRvcCBjYWxsZXJzLCBlLmcuIHJ0dzg5X2NvcmVfc2VuZF9udWxsZnVuYywNCndpbGwgd2FybnMg
d2hlbiB0eCBmYWlsZWQuIFNvLCBkb24ndCBjYXJlIHRoZXNlIHN0YXRpc3RpY3MuDQoNCj4gPiA+
ICAgICBpZWVlODAyMTFfdHhfc3RhdHVzX25pKHJ0d2Rldi0+aHcsIHNrYik7ICB9DQo+ID4gPg0K

