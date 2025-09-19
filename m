Return-Path: <linux-wireless+bounces-27507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D9B87809
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 02:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB1356570A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 00:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92318230274;
	Fri, 19 Sep 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="tzQp7MX7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3719D89E;
	Fri, 19 Sep 2025 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242097; cv=none; b=Wa+ph8mzboZ7MDqbRG0GDYqULUQjzrqCnK/HzdxDfO1dZXFY2K2itIXN0X/LGKEofjidBj3Fw26vH8bnRoNeow2IxBFGZKI1TI8UzEmZIXlwt4OUE5qWRrWvMvDOoGksUv+KMYZuZjF7ub6G8IFngJJiHlXLEcsrswTiZdqHc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242097; c=relaxed/simple;
	bh=L4W0AzbnKlf7wNawPd0mOCv3aKNs4cLJAM5rgwBnb8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QRfhQcVKHvgZ9sDUzPyginOvPouB9FW7inq/Ntd2xF3EzQYvWbzXGPwRykSB1sof87W6NAfYorOKhcPbmTj/xhsfrpbV8XJJGWcY/gQgiqJkSozo431d/aJmcWexYmUzoe35AH5JZvY/UXVBX7KLIp45yUKzGuvCGZfw7tV/NbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tzQp7MX7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58J0YckoE2852636, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758242078; bh=L4W0AzbnKlf7wNawPd0mOCv3aKNs4cLJAM5rgwBnb8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tzQp7MX7+V2+XVrcGNgwQ1SuUJwbMrSOlAvvKL0CIzJRRRvwJLvdLqwWV7zMpJ6Ic
	 fpruK/4bq3msudIcfM/PyDk3aHmzMNcz7kLacK0P2k8YbK8Lf3oqM4FQ6LMdnu9zuY
	 Dajy3YnND0Hh8NxmVpYdc1VQUH2BhHuYko7dtASl4a/tCxBUz6Zwr5RUTtx4c25Qwf
	 U7BeV7WiSPMZ1moQxPeEF2cBvf7TItofBQUafBi1TmIVNHVr0kcqe3y2wIhCz9VypY
	 V5iDdxbvi2+0sKnD0uevw7b+8IycbLxGZfMvMf1SyNDy6PkQ7vTytsAlE6pId0aSvq
	 0KeuY1F3ciDdQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58J0YckoE2852636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 08:34:38 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 19 Sep 2025 08:34:39 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 19 Sep 2025 08:34:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 19 Sep 2025 08:34:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw v4 2/4] wifi: rtw89: fix tx_wait initialization race
Thread-Topic: [PATCH rtw v4 2/4] wifi: rtw89: fix tx_wait initialization race
Thread-Index: AQHcJ7j8gFkFIGygsECCjdEXp53dJbSYbw2QgAAaqwCAAR9BUA==
Date: Fri, 19 Sep 2025 00:34:38 +0000
Message-ID: <7a53522bc0004a979fd78b1d6f440457@realtek.com>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-3-pchelkin@ispras.ru>
 <08b25263c6874a089e4a271cb95a9cb7@realtek.com>
 <20250918173522-07abe99566c12fa46a096fc5-pchelkin@ispras>
In-Reply-To: <20250918173522-07abe99566c12fa46a096fc5-pchelkin@ispras>
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

RmVkb3IgUGNoZWxraW4gPHBjaGVsa2luQGlzcHJhcy5ydT4gd3JvdGU6DQo+IE9uIFRodSwgMTgu
IFNlcCAwNTo0NywgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEZlZG9yIFBjaGVsa2luIDxwY2hl
bGtpbkBpc3ByYXMucnU+IHdyb3RlOg0KPiA+ID4gQEAgLTEwOTQsMjIgKzEwOTQsMTMgQEAgaW50
IHJ0dzg5X2NvcmVfdHhfa2lja19vZmZfYW5kX3dhaXQoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2
LCBzdHJ1Y3Qgc2tfYnVmZg0KPiAqc2sNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGludCBxc2VsLCB1bnNpZ25lZCBpbnQgdGltZW91dCkNCj4gPiA+ICB7DQo+ID4g
PiAgICAgICAgIHN0cnVjdCBydHc4OV90eF9za2JfZGF0YSAqc2tiX2RhdGEgPSBSVFc4OV9UWF9T
S0JfQ0Ioc2tiKTsNCj4gPiA+IC0gICAgICAgc3RydWN0IHJ0dzg5X3R4X3dhaXRfaW5mbyAqd2Fp
dDsNCj4gPiA+ICsgICAgICAgc3RydWN0IHJ0dzg5X3R4X3dhaXRfaW5mbyAqd2FpdCA9IHdpcGh5
X2RlcmVmZXJlbmNlKHJ0d2Rldi0+aHctPndpcGh5LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2tiX2RhdGEtPndhaXQp
Ow0KPiA+DQo+ID4gQ2FuJ3Qgd2UganVzdCBwYXNzICd3YWl0JyBieSBmdW5jdGlvbiBhcmd1bWVu
dD8NCj4gDQo+IFllcC4NCj4gDQo+ID4NCj4gPiA+ICAgICAgICAgdW5zaWduZWQgbG9uZyB0aW1l
X2xlZnQ7DQo+ID4gPiAgICAgICAgIGludCByZXQgPSAwOw0KPiA+ID4NCj4gPiA+ICAgICAgICAg
bG9ja2RlcF9hc3NlcnRfd2lwaHkocnR3ZGV2LT5ody0+d2lwaHkpOw0KPiA+ID4NCj4gPiA+IC0g
ICAgICAgd2FpdCA9IGt6YWxsb2Moc2l6ZW9mKCp3YWl0KSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiAt
ICAgICAgIGlmICghd2FpdCkgew0KPiA+ID4gLSAgICAgICAgICAgICAgIHJ0dzg5X2NvcmVfdHhf
a2lja19vZmYocnR3ZGV2LCBxc2VsKTsNCj4gPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gMDsN
Cj4gPiA+IC0gICAgICAgfQ0KPiA+ID4gLQ0KPiA+ID4gLSAgICAgICBpbml0X2NvbXBsZXRpb24o
JndhaXQtPmNvbXBsZXRpb24pOw0KPiA+ID4gLSAgICAgICB3YWl0LT5za2IgPSBza2I7DQo+ID4g
PiAtICAgICAgIHJjdV9hc3NpZ25fcG9pbnRlcihza2JfZGF0YS0+d2FpdCwgd2FpdCk7DQo+ID4g
PiAtDQo+ID4NCj4gPiBIZXJlLCBvcmlnaW5hbCBjb2RlIHByZXBhcmVzIGNvbXBsZXRpb24gYmVm
b3JlIFRYIGtpY2sgb2ZmLiBIb3cgaXQgY291bGQNCj4gPiBiZSBhIHByb2JsZW0/IERvIEkgbWlz
cyBzb21ldGhpbmc/DQo+IA0KPiBUaGF0J3MgYSBnb29kIHF1ZXN0aW9uIGFuZCBpdCBtYWRlIG1l
IHJldGhpbmsgdGhlIGNhdXNlIG9mIHRoZSByYWNlDQo+IHNjZW5hcmlvLiAgSSBkaWRuJ3QgaW5p
dGlhbGx5IHRha2UgVFgga2ljayBvZmYgaW50byBjb25zaWRlcmF0aW9uIHdoZW4NCj4gaXQgYWN0
dWFsbHkgbWF0dGVycy4NCg0KRG8gaXQgbWVhbiB0aGF0IHlvdSBwaWN0dXJlZCB0aGUgcmFjaW5n
IHNjZW5hcmlvIGluIGNvbW1pdCBtZXNzYWdlIGJ5IA0KY29kZSByZXZpZXcgaW5zdGVhZCBvZiBh
IHJlYWwgY2FzZSB5b3UgbWV0PyANCg0KPiANCj4gVGhlIHRoaW5nIGlzOiB0aGVyZSBtaWdodCBo
YXZlIGJlZW4gYW5vdGhlciB0aHJlYWQgaW5pdGlhdGluZyBUWCBraWNrIG9mZg0KPiBmb3IgdGhl
IHNhbWUgcXVldWUgaW4gcGFyYWxsZWwuICBCdXQgbm8gc3VjaCB0aHJlYWQgZXhpc3RzIGJlY2F1
c2UgYSB0YWtlbg0KPiB3aXBoeSBsb2NrIGdlbmVyYWxseSBwcm90ZWN0cyBmcm9tIHN1Y2ggc2l0
dWF0aW9ucy4gcnR3ODlfY29yZV90eHFfc2NoZWR1bGUoKQ0KPiB3b3JrZXIgbG9va3MgbGlrZSBh
IGdvb2QgY2FuZGlkYXRlIGJ1dCBpdCBkb2Vzbid0IG9wZXJhdGUgb24gdGhlIG5lZWRlZA0KPiBt
YW5hZ2VtZW50IHF1ZXVlcy4NCg0KTGFzdCBuaWdodCBJIGFsc28gdGhvdWdodCBpZiBhbm90aGVy
IHRocmVhZCB3b3JrcyBpbiBwYXJhbGxlbC4gDQpNYXliZSBydHc4OV9vcHNfdHgoKSBjb3VsZCBi
ZT8gDQoNCj4gDQo+IFNvIEkgbWF5IGNvbmNsdWRlIHRoaXMgcGF0Y2ggZG9lc24ndCBmaXggYW55
IHJlYWwgYnVnIHRob3VnaCBJJ2QgcHJlZmVyIHRvDQo+IGtlZXAgaXQgKHdpdGggZGVzY3JpcHRp
b24gcmV3cml0dGVuIG9mIGNvdXJzZSkgYmVjYXVzZSBpdCBoZWxwcyB0byBhdm9pZA0KPiBwb3Rl
bnRpYWwgaXNzdWVzIGluIGZ1dHVyZS4NCg0KQWdyZWUuDQoNCg0K

