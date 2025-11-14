Return-Path: <linux-wireless+bounces-28939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 229E3C5AD7E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 01:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76B83341E64
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 00:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA98255E34;
	Fri, 14 Nov 2025 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mVBe6TtK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224A67262E
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763081230; cv=none; b=TdQbxTsZp9ZUBMPk59jPN/Enpkk50ldIH5uupoqSNRaV4aitwYWJlcp4MzgAuYG4TCo9PmBdHR1gXvzhWw7P6uSElti9XOo6ZLzOE84jIILv3B2FzYWQcoP4rRgD+zxdskherKNrXp/J/GAB/OvqZH6mtMoagvieGZooHoa+xXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763081230; c=relaxed/simple;
	bh=7Wx3ZAfxYZ5kTrYOze+cLJpxYZtILdezK8wHpeSCpaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZHUUuTmLmJ5eeRuIoa9ZzdNI3uPiL9NSDWjZnw1tXCi9S/V55l8jULIP1ewe3/5/RZEm577ujhz0DNtYswFrQnmUmgExh+ocxWtrBD+uEnAqWqpeejAlMSlGahz7NbpUFXjzC9LSz3p7rQbZpTbZrtotWXjDrhAd+MYn18xLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mVBe6TtK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE0l2GL1545425, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763081222; bh=7Wx3ZAfxYZ5kTrYOze+cLJpxYZtILdezK8wHpeSCpaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mVBe6TtKz3em59wbvjGhqNHkM8PxpuZmOaXXqdAWgetRq5emhNLoViOd2eTRfiB85
	 JrsFPMcprDmf/nRfMwwv1sm/IHQFCn60XamIs07EjKFWEbdQ0rmJUgod4LBD+Mo+9b
	 le7e7LRZ5ooD+03suNHa73uHzBAe/dzcZu/cN3ebxzTDhCYc+9qpj5KPI/+WHBd/G6
	 38C2wpr8WW8dbn75mw8NSg+jxQSzufKVBZH+TpihzkIT5zYLfB2aQUqhCnrn2HNEpN
	 cu/9UH9yEWpOr4X9/aKBZ4y53iNzfvOtrmjoJCcIFWTdi5o0397fcZY2RpUYu35zLl
	 nwgcAxHHTVJyw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE0l2GL1545425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 08:47:02 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 08:47:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 08:47:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Fri, 14 Nov 2025 08:47:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Gary Chang <gary.chang@realtek.com>
Subject: RE: [PATCH rtw-next 06/14] wifi: rtw89: mac: update wcpu_on to
 download firmware for RTL8922D
Thread-Topic: [PATCH rtw-next 06/14] wifi: rtw89: mac: update wcpu_on to
 download firmware for RTL8922D
Thread-Index: AQHcVElGK8pec5TH20KXl/55++ZxXbTwFSqAgAFCbkA=
Date: Fri, 14 Nov 2025 00:47:02 +0000
Message-ID: <00d08a2338bb4536a125be3cf6921ce7@realtek.com>
References: <20251113025620.31086-1-pkshih@realtek.com>
 <20251113025620.31086-7-pkshih@realtek.com>
 <92a76505-7b2a-4eda-9645-edf81a1f1cd4@gmail.com>
In-Reply-To: <92a76505-7b2a-4eda-9645-edf81a1f1cd4@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
My8xMS8yMDI1IDA0OjU2LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gVGhlIFJUTDg5MjJEIGRv
ZXMgbW9yZSBzZXR0aW5ncyBiZWZvcmUgZG93bmxvYWRpbmcgZmlybXdhcmUsIHNvIGFkZCB0aGVt
DQo+ID4gYWNjb3JkaW5nbHkuIEFsc28sIHVwZGF0ZSB0aGUgbWlzc2VkIHNldHRpbmdzIGZvciBS
VEw4OTIyQS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJl
YWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg5L21hY19iZS5jIHwgIDcgKysrKysrKw0KPiA+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg5L3JlZy5oICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjX2JlLmMgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg5L21hY19iZS5jDQo+ID4gaW5kZXggYzM2MjBkYjhhZmY2Li4zM2Uz
OTE5MWI3YzMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9tYWNfYmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvbWFjX2JlLmMNCj4gPiBAQCAtNDU4LDYgKzQ1OCw3IEBAIHN0YXRpYyB2b2lkIHNldF9jcHVf
ZW4oc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBib29sIGluY2x1ZGVfYmIpDQo+ID4NCj4gPiAg
c3RhdGljIGludCB3Y3B1X29uKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwgdTggYm9vdF9yZWFz
b24sIGJvb2wgZGxmdykNCj4gPiAgew0KPiA+ICsgICAgIGNvbnN0IHN0cnVjdCBydHc4OV9jaGlw
X2luZm8gKmNoaXAgPSBydHdkZXYtPmNoaXA7DQo+ID4gICAgICAgdTMyIHZhbDMyOw0KPiA+ICAg
ICAgIGludCByZXQ7DQo+ID4NCj4gPiBAQCAtNDc5LDYgKzQ4MCw3IEBAIHN0YXRpYyBpbnQgd2Nw
dV9vbihzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIHU4IGJvb3RfcmVhc29uLCBib29sIGRsZncp
DQo+ID4NCj4gPiAgICAgICBydHc4OV93cml0ZTMyKHJ0d2RldiwgUl9CRV9VRE0xLCAwKTsNCj4g
PiAgICAgICBydHc4OV93cml0ZTMyKHJ0d2RldiwgUl9CRV9VRE0yLCAwKTsNCj4gPiArICAgICBy
dHc4OV93cml0ZTMyKHJ0d2RldiwgUl9CRV9CT09UX0RCRywgMHgwKTsNCj4gPiAgICAgICBydHc4
OV93cml0ZTMyKHJ0d2RldiwgUl9CRV9IQUxUX0gyQywgMCk7DQo+ID4gICAgICAgcnR3ODlfd3Jp
dGUzMihydHdkZXYsIFJfQkVfSEFMVF9DMkgsIDApOw0KPiA+ICAgICAgIHJ0dzg5X3dyaXRlMzIo
cnR3ZGV2LCBSX0JFX0hBTFRfSDJDX0NUUkwsIDApOw0KPiA+IEBAIC00OTMsNiArNDk1LDExIEBA
IHN0YXRpYyBpbnQgd2NwdV9vbihzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIHU4IGJvb3RfcmVh
c29uLCBib29sIGRsZncpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgQl9CRV9XRFRfV0FL
RV9QQ0lFX0VOIHwgQl9CRV9XRFRfV0FLRV9VU0JfRU4pOw0KPiA+ICAgICAgIHJ0dzg5X3dyaXRl
MzJfY2xyKHJ0d2RldiwgUl9CRV9XQ1BVX0ZXX0NUUkwsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgQl9CRV9XRFRfUExUX1JTVF9FTiB8IEJfQkVfV0NQVV9ST01fQ1VUX0dFVCk7DQo+ID4g
KyAgICAgcnR3ODlfd3JpdGUzMl9jbHIocnR3ZGV2LCBSX0JFX1NFQ1VSRV9CT09UX01BTExPQ19J
TkZPLCAwKTsNCj4gDQo+IFRoaXMgZG9lc24ndCBjaGFuZ2UgdGhlIHZhbHVlIG9mIHRoZSByZWdp
c3Rlci4gRGlkIHlvdSBtZWFuIHRvIHVzZQ0KPiBydHc4OV93cml0ZTMyKCkgPw0KDQpSaWdodC4g
SSBtaXNyZWFkIHRoZSBjb2RlIGluIHZlbmRvciBkcml2ZXIuIFdpbGwgZml4IGl0IGJ5IHYyLg0K
DQo=

