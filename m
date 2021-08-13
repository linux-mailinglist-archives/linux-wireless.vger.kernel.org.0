Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72C13EB9CF
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhHMQJl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 12:09:41 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:49604 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229471AbhHMQJl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 12:09:41 -0400
X-UUID: 8270d9b2da2347c7a181e91fc547d50d-20210814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=l+ySDnC1xxmiXel2dEsTe3+lMh8lrZDZ747TEAnrsjA=;
        b=tS6jfda/CTVNcixMG1z5o6LXAye7r6Rh/GyfqSEXykGiIWKJH2nPQnxqDs5nYdGntjsKvWztoTV2tUvyOfTPGQPFRemyuRw74S6HCWMP1NFc4/j2bJKQ6J7Tcka+6H8cJYZamC6hxBhfK3484/l3oVRzjj2GeQ3g/iHJVPEso2E=;
X-UUID: 8270d9b2da2347c7a181e91fc547d50d-20210814
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 486236983; Sat, 14 Aug 2021 00:09:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 14 Aug 2021 00:09:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 14 Aug 2021 00:09:07 +0800
Message-ID: <bbe7e343d6788a3327aa5bc81509328568883c51.camel@mediatek.com>
Subject: Re: [PATCH] mt76: mt7915: add LED support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Money Wang" <money.wang@mediatek.com>
Date:   Sat, 14 Aug 2021 00:09:08 +0800
In-Reply-To: <670252a9-636c-9d3d-5d6e-acfcabfff4c0@nbd.name>
References: <20210621141430.17577-1-MeiChia.Chiu@mediatek.com>
         <670252a9-636c-9d3d-5d6e-acfcabfff4c0@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTEzIGF0IDEyOjUyICswMjAwLCBGZWxpeCBGaWV0a2F1IHdyb3RlOg0K
PiBPbiAyMDIxLTA2LTIxIDE2OjE0LCBNZWlDaGlhIENoaXUgd3JvdGU6DQo+ID4gRnJvbTogTWVp
Q2hpYSBDaGl1IDxtZWljaGlhLmNoaXVAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEluaXRpYWxp
emUgYnJpZ2h0bmVzc19zZXQgYW5kIGJsaW5rX3NldCBjYWxsYmFja3MgdG8gZW5hYmxlIExFRA0K
PiA+IHN1cHBvcnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWVpQ2hpYSBDaGl1IDxtZWlj
aGlhLmNoaXVAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlk
ZXIubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNb25leSBXYW5nIDxtb25l
eS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9pbml0LmMgfCA2OQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L21taW8uYyB8ICA2ICsrKy0tDQo+ID4gIC4uLi9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvcmVncy5oIHwgMTkgKysrKysrKysrKysrKysNCj4gPiAgMyBm
aWxlcyBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9p
bml0LmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2lu
aXQuYw0KPiA+IGluZGV4IGUwMjcyNzMuLmRlZmIwZWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQo+ID4gQEAgLTE1
MSw2ICsxNTEsNjQgQEAgc3RhdGljIGludCBtdDc5MTVfdGhlcm1hbF9pbml0KHN0cnVjdA0KPiA+
IG10NzkxNV9waHkgKnBoeSkNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICtz
dGF0aWMgdm9pZCBtdDc5MTVfbGVkX3NldF9jb25maWcoc3RydWN0IGxlZF9jbGFzc2RldiAqbGVk
X2NkZXYsDQo+ID4gKwkJCQkgIHU4IGRlbGF5X29uLCB1OCBkZWxheV9vZmYpDQo+ID4gK3sNCj4g
PiArCXN0cnVjdCBtdDc5MTVfZGV2ICpkZXY7DQo+ID4gKwlzdHJ1Y3QgbXQ3Nl9kZXYgKm10NzY7
DQo+ID4gKwl1MzIgdmFsOw0KPiA+ICsNCj4gPiArCW10NzYgPSBjb250YWluZXJfb2YobGVkX2Nk
ZXYsIHN0cnVjdCBtdDc2X2RldiwgbGVkX2NkZXYpOw0KPiA+ICsJZGV2ID0gY29udGFpbmVyX29m
KG10NzYsIHN0cnVjdCBtdDc5MTVfZGV2LCBtdDc2KTsNCj4gPiArDQo+ID4gKwkvKiBzZWxlY3Qg
VFggYmxpbmsgbW9kZSwgMjogb25seSBkYXRhIGZyYW1lcyAqLw0KPiA+ICsJbXQ3Nl9ybXdfZmll
bGQoZGV2LCBNVF9UTUFDX1RDUjAoMCksIE1UX1RNQUNfVENSMF9UWF9CTElOSywgMik7DQo+IA0K
PiBEb2VzIHRoYXQgbWVhbiB0aGUgaHcgdHJpZ2dlcnMgdGhlIExFRCB3aXRoIHRoZSBjb25maWd1
cmVkIG9uL29mZg0KPiBkZWxheQ0KPiBvbiBUWD8gSSB0aGluayBibGlua2luZyBzaG91bGQgYmUg
Y29udHJvbGxlZCBlbnRpcmVseSBieSBzb2Z0d2FyZS4NCj4gDQoNCkJsaW5rIGlzIHN0aWxsIGNv
bnRvbGxlZCBieSBzb2Z0d2FyZS4gVGhpcyBtZWFucyB1cHBlciBsYXllciBjYW4gc2V0DQpvbi9v
ZmYgZGlyZWN0bHkuDQoNCg0KUnlkZXINCg==

