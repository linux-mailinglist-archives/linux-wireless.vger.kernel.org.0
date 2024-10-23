Return-Path: <linux-wireless+bounces-14342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB09ABB35
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 03:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66CD2845E8
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 01:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4424B1798C;
	Wed, 23 Oct 2024 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KDxew0Ge"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161F381BA
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648672; cv=none; b=qhCA1UHRykfM45VwQrcz9jLU3FFvcrvCbHhbGvLJtjI9uvTkhhh6RdUIllU0BGHu3I0tFC+A7wQlZKT22afqPWQFNFIaGVfdPixjyOfQLkKyWD9uzEm+s6p9feb0bohrn4mlzqEV53sSZS5UiR8p6+ZClS6nkD8Eh3pUZ5Xede4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648672; c=relaxed/simple;
	bh=M/6Gwapjut9cKZHpNUeY0JtuIJlfngwGeTzw/ETy714=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GR+o7FGEgxcWCAHdAp0nYSCDgasC281xCzycUYD4DB6eW2O7YIh7B3s5/BuC8d0HVM5uA/Gr9aMKEMaI0gE1g7JV8pRlny5fVgReatW5d6Bh1Rp4xRCKSnR2GtUxyUXDVD2QVcB/dsRZJ14HI6igEaWDcwCOqTJdkGMOpSVpegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KDxew0Ge; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49N1viiqF761017, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729648664; bh=M/6Gwapjut9cKZHpNUeY0JtuIJlfngwGeTzw/ETy714=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KDxew0Ge76POK78P0BZ/dAhZy6vVyYFoPifg6cNGIDzHA+LDgaTpJ+/lNPXFsBT0D
	 Z8C/3qpijSEiBRK3PVkvRjkeFNHNPp8IxZySRvW3m2OJID3eH09ZwH3WuJVldA9iDs
	 yM7N2NnalmDDhoQjzRjtsuoe3hmqgeQ7W9MPiwQ/FpkbanDvLeTsG686YDK8SHxjQw
	 lzMeD1UTr67eJPYWC2CccKe9lOECADx+ARS7Mu+kG9lw66tYckD+tCq/3NIiUn1j/P
	 0bA1jtKVeyeHylUpjQO11ojC2JezIIzKj6A0gH04B4/SPeVa3+7zvNnYM3niipb3vm
	 Ae4SiR0MYG2Vw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49N1viiqF761017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 09:57:44 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 09:57:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 23 Oct 2024 09:57:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 23 Oct 2024 09:57:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: Report the signal strength only if it's known
Thread-Topic: [PATCH] wifi: rtw88: Report the signal strength only if it's
 known
Thread-Index: AQHbJKazdJZwN9XI30e2tNZEQzE0M7KTicpw
Date: Wed, 23 Oct 2024 01:57:44 +0000
Message-ID: <6d378ad2796f42d88fe80461b8618694@realtek.com>
References: <f7e1e448-2c9b-498f-b8b1-a14dd967d7d3@gmail.com>
In-Reply-To: <f7e1e448-2c9b-498f-b8b1-a14dd967d7d3@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
UlRMODgxMUNVIGRvZXNuJ3QgcmVwb3J0IHRoZSBzaWduYWwgc3RyZW5ndGggZm9yIG1hbnkgKGFu
eT8pIGRhdGENCj4gZnJhbWVzLiBXaGVuIHRoZSBzaWduYWwgc3RyZW5ndGggaXMgbm90IGtub3du
LCBzZXQNCj4gUlhfRkxBR19OT19TSUdOQUxfVkFMIGluIG9yZGVyIHRvIGF2b2lkIHJlcG9ydGlu
ZyBhIHNpZ25hbA0KPiBzdHJlbmd0aCBvZiAwLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVy
Ymx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtl
IFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnR3ODgvcnguYyB8IDEyICsrKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMNCj4gaW5kZXggMWRlOTNmYzllZmU5Li45MGZjOGE1ZmE4
OWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcngu
Yw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMNCj4gQEAg
LTIzNCwxMCArMjM0LDE0IEBAIHN0YXRpYyB2b2lkIHJ0d19yeF9maWxsX3J4X3N0YXR1cyhzdHJ1
Y3QgcnR3X2RldiAqcnR3ZGV2LA0KPiAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgIHJ4
X3N0YXR1cy0+YncgPSBSQVRFX0lORk9fQldfMjA7DQo+IA0KPiAtICAgICAgIHJ4X3N0YXR1cy0+
c2lnbmFsID0gcGt0X3N0YXQtPnNpZ25hbF9wb3dlcjsNCj4gLSAgICAgICBmb3IgKHBhdGggPSAw
OyBwYXRoIDwgcnR3ZGV2LT5oYWwucmZfcGF0aF9udW07IHBhdGgrKykgew0KPiAtICAgICAgICAg
ICAgICAgcnhfc3RhdHVzLT5jaGFpbnMgfD0gQklUKHBhdGgpOw0KPiAtICAgICAgICAgICAgICAg
cnhfc3RhdHVzLT5jaGFpbl9zaWduYWxbcGF0aF0gPSBwa3Rfc3RhdC0+cnhfcG93ZXJbcGF0aF07
DQo+ICsgICAgICAgaWYgKHBrdF9zdGF0LT5waHlfc3RhdHVzKSB7DQoNCldoZW4gb25seSBwa3Rf
c3RhdC0+cGh5X3N0YXR1cyBpcyBzZXQsIGRyaXZlciBjYWxscyBydHdkZXYtPmNoaXAtPm9wcy0+
cXVlcnlfcGh5X3N0YXR1cygpDQp0byBnZXQgUEhZIHN0YXR1cy4gSGF2ZSB5b3UgcmV2aWV3ZWQg
YWxsIHBsYWNlcyBhY2Nlc3NpbmcgUEhZIGZpZWxkcyANCmFsc28gY2hlY2sgcGt0X3N0YXQtPnBo
eV9zdGF0dXM/IA0KDQoNCj4gKyAgICAgICAgICAgICAgIHJ4X3N0YXR1cy0+c2lnbmFsID0gcGt0
X3N0YXQtPnNpZ25hbF9wb3dlcjsNCj4gKyAgICAgICAgICAgICAgIGZvciAocGF0aCA9IDA7IHBh
dGggPCBydHdkZXYtPmhhbC5yZl9wYXRoX251bTsgcGF0aCsrKSB7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJ4X3N0YXR1cy0+Y2hhaW5zIHw9IEJJVChwYXRoKTsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcnhfc3RhdHVzLT5jaGFpbl9zaWduYWxbcGF0aF0gPSBwa3Rfc3RhdC0+cnhf
cG93ZXJbcGF0aF07DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgfSBlbHNlIHsNCj4g
KyAgICAgICAgICAgICAgIHJ4X3N0YXR1cy0+ZmxhZyB8PSBSWF9GTEFHX05PX1NJR05BTF9WQUw7
DQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICBydHdfcnhfYWRkcl9tYXRjaChydHdkZXYsIHBr
dF9zdGF0LCBoZHIpOw0KPiAtLQ0KPiAyLjQ2LjANCg0K

