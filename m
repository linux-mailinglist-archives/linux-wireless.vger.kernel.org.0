Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B28326D23
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 14:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhB0NgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 08:36:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:48335 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229912AbhB0NgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 08:36:18 -0500
X-UUID: 293a586b2d7b46f8875db4c04388ea09-20210227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+fyyoOPtYIfaBWS2oMwL/SOuUE5ToRW6IY5SE9Eij2Y=;
        b=ih5XHJwLwbBuNlzTxx/8BdyjY+QCbLCHkatvQkty11coaV/MrP707FdC0aigDsPH5JM3tUnlRNG5FGZenYQM+9YY/MNxrWC6NSnnTquskG7FF7TeJQW3dA+wCsgT6hPJUcQC7kH2NRK7FDHody9cjzs/ifEUtGvLUI/SLj9oAeQ=;
X-UUID: 293a586b2d7b46f8875db4c04388ea09-20210227
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1094444110; Sat, 27 Feb 2021 21:35:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 27 Feb 2021 21:35:30 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 27 Feb 2021 21:35:30 +0800
Message-ID: <1614432930.14551.7.camel@mtkswgap22>
Subject: Re: [PATCH 2/5] mt76: mt7615: stop ext_phy queue when mac reset
 happens
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Sat, 27 Feb 2021 21:35:30 +0800
In-Reply-To: <YDodpxIQzPA8754l@lore-desk>
References: <d6f2573790582538e8ba82f87a4c35329692ee32.1614411256.git.ryder.lee@mediatek.com>
         <3794a3ffadc4a08548a1223e6955671977e78e49.1614411256.git.ryder.lee@mediatek.com>
         <YDodpxIQzPA8754l@lore-desk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0FACCB4C644AB259B6BB76140C4710DC3A2830871372B2E1334688B423EE6B1E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gU2F0LCAyMDIxLTAyLTI3IGF0IDExOjIzICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IFN0b3AgVHggYnVyc3QgZm9yIGV4dF9waHkgYWZ0ZXIgbWFjIHJlc2V0Lg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFj
LmMgfCAzICsrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1
L21hYy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFjLmMN
Cj4gPiBpbmRleCBkZjJkYzc3YTMyM2EuLjBmNjEzMDYzYzFmZiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWMuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21hYy5jDQo+ID4gQEAg
LTIwODUsNiArMjA4NSw3IEBAIHZvaWQgbXQ3NjE1X21hY19yZXNldF93b3JrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykNCj4gPiAgCWRlbF90aW1lcl9zeW5jKCZkZXYtPnBoeS5yb2NfdGltZXIp
Ow0KPiA+ICAJY2FuY2VsX3dvcmtfc3luYygmZGV2LT5waHkucm9jX3dvcmspOw0KPiA+ICAJaWYg
KHBoeTIpIHsNCj4gPiArCQlzZXRfYml0KE1UNzZfUkVTRVQsICZwaHkyLT5tdDc2LT5zdGF0ZSk7
DQo+IA0KPiBIaSBSeWRlciwNCj4gDQo+IHNpbmNlIHdlIHJ1biBtdDc2X3R4cV9zY2hlZHVsZV9h
bGwgdGhlbiBhbmQgbXQ3Nl93b3JrZXJfZGlzYWJsZSBmZXcgbGluZXMgYmVsb3csIHdoYXQgaXMg
dGhlIHBvaW50DQo+IG9mIHNldHRpbmcgdGhlIHN0YXRlIHRvIFJFU0VUPw0KDQpKdXN0IGluIGNh
c2UgbXQ3Nl90eHFfc2NoZWR1bGVfKiBzdGlsbCBoYXMgdGhlIHBvc3NpYmlsaXR5IHRvIGJlIGNh
bGxlZA0KYnkgc29tZSBvdGhlciBwbGFjZSBhdCB0aGUgdGltZSByZXNldCBoYXBwZW5zLiBBbHNv
LCBJIHRoaW5rIE1UNzZfUkVTRVQNCmlzIG1vcmUgcmVsaWFibGUgdG8gYnJlYWsgVHggc2NoZWR1
bGluZyAoZnJvbSBpbnNpZGUgb2YgdGhlIGJ1cnN0IGxvb3ApLg0KDQpSeWRlcg0KPiANCj4gPiAg
CQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnBoeTItPm10NzYtPm1hY193b3JrKTsNCj4gPiAg
CQlkZWxfdGltZXJfc3luYygmcGh5Mi0+cm9jX3RpbWVyKTsNCj4gPiAgCQljYW5jZWxfd29ya19z
eW5jKCZwaHkyLT5yb2Nfd29yayk7DQo+ID4gQEAgLTIxMTgsNiArMjExOSw4IEBAIHZvaWQgbXQ3
NjE1X21hY19yZXNldF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiAgDQo+ID4g
IAljbGVhcl9iaXQoTVQ3Nl9NQ1VfUkVTRVQsICZkZXYtPm1waHkuc3RhdGUpOw0KPiA+ICAJY2xl
YXJfYml0KE1UNzZfUkVTRVQsICZkZXYtPm1waHkuc3RhdGUpOw0KPiA+ICsJaWYgKHBoeTIpDQo+
ID4gKwkJY2xlYXJfYml0KE1UNzZfUkVTRVQsICZwaHkyLT5tdDc2LT5zdGF0ZSk7DQo+ID4gIA0K
PiA+ICAJbXQ3Nl93b3JrZXJfZW5hYmxlKCZkZXYtPm10NzYudHhfd29ya2VyKTsNCj4gPiAgCW5h
cGlfZW5hYmxlKCZkZXYtPm10NzYudHhfbmFwaSk7DQo+ID4gLS0gDQo+ID4gMi4xOC4wDQo+ID4g
DQoNCg==

