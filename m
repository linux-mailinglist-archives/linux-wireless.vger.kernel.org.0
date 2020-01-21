Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D3B144128
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2020 17:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAUQAo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jan 2020 11:00:44 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:14698 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbgAUQAo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jan 2020 11:00:44 -0500
X-UUID: 4b30edc956f84d85bc4e2ce0221ea96e-20200122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hl0UeD+P+rTTtPqsFkqtujX3P2uXkUS9JL4iwIHiWhk=;
        b=hB9PHdQocbpaaPneY55GxhipThVOhW6GnMyRx5l5kDd1bXoa+XuDa0ZWAaiMbygCpqZr/ov6Y8ReatlixWOvJDMUFukeKG+IbnIb98NFldU07DTPy6v4d8/HNvfHXft6ZFRVMv/M/rsi9XtPhd3zXCvFADS7+QnMa6GlW7x6wWU=;
X-UUID: 4b30edc956f84d85bc4e2ce0221ea96e-20200122
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1909450229; Wed, 22 Jan 2020 00:00:40 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 22 Jan 2020 00:00:39 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 22 Jan 2020 00:01:35 +0800
Message-ID: <1579622439.4993.17.camel@mtkswgap22>
Subject: Re: [PATCH 1/7] mt76: mt7615: simplify mcu_set_bmc flow
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Roy Luo" <royluo@google.com>, Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 22 Jan 2020 00:00:39 +0800
In-Reply-To: <20200121151105.GA2396@localhost.localdomain>
References: <ae72dd289f8a26a2c0f42de1f940bb8b6d1f2c29.1579237414.git.ryder.lee@mediatek.com>
         <20200121151105.GA2396@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTIxIGF0IDE2OjExICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IE1vdmUgbWN1X3d0YmxfYm1jIGludG8gbWN1X3NldF9zdGFfcmVjX2JtYyB0byBzaW1w
bGlmeSBmbG93Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVl
QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzYxNS9tYWluLmMgIHwgIDMgKy0NCj4gPiAgLi4uL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzYxNS9tY3UuYyAgIHwgOTcgKysrKysrKystLS0tLS0tLS0tLQ0KPiA+ICAuLi4v
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbXQ3NjE1LmggICAgfCAgNiArLQ0KPiA+ICAz
IGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDYxIGRlbGV0aW9ucygtKQ0KPiA+IA0K
PiANCj4gWy4uLl0NCj4gDQo+ID4gLWludCBtdDc2MTVfbWN1X3NldF9zdGFfcmVjX2JtYyhzdHJ1
Y3QgbXQ3NjE1X2RldiAqZGV2LA0KPiA+IC0JCQkgICAgICAgc3RydWN0IGllZWU4MDIxMV92aWYg
KnZpZiwgYm9vbCBlbikNCj4gPiAraW50IG10NzYxNV9tY3Vfc2V0X2JtYyhzdHJ1Y3QgbXQ3NjE1
X2RldiAqZGV2LA0KPiA+ICsJCSAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLCBib29s
IGVuKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgbXQ3NjE1X3ZpZiAqbXZpZiA9IChzdHJ1Y3QgbXQ3
NjE1X3ZpZiAqKXZpZi0+ZHJ2X3ByaXY7DQo+ID4gIAlzdHJ1Y3Qgew0KPiA+ICAJCXN0cnVjdCBz
dGFfcmVxX2hkciBoZHI7DQo+ID4gIAkJc3RydWN0IHN0YV9yZWNfYmFzaWMgYmFzaWM7DQo+ID4g
LQl9IHJlcSA9IHsNCj4gPiArCQl1OCBidWZbTVQ3NjE1X1dUQkxfVVBEQVRFX01BWF9TSVpFXTsN
Cj4gPiArCX0gX19wYWNrZWQgcmVxID0gew0KPiA+ICAJCS5oZHIgPSB7DQo+ID4gIAkJCS5ic3Nf
aWR4ID0gbXZpZi0+aWR4LA0KPiA+ICAJCQkud2xhbl9pZHggPSBtdmlmLT5zdGEud2NpZC5pZHgs
DQo+ID4gQEAgLTExMDksOCArMTA1OSwxOCBAQCBpbnQgbXQ3NjE1X21jdV9zZXRfc3RhX3JlY19i
bWMoc3RydWN0IG10NzYxNV9kZXYgKmRldiwNCj4gPiAgCQkJLmNvbm5fdHlwZSA9IGNwdV90b19s
ZTMyKENPTk5FQ1RJT05fSU5GUkFfQkMpLA0KPiA+ICAJCX0sDQo+ID4gIAl9Ow0KPiA+ICsJc3Ry
dWN0IHd0YmxfcmVxX2hkciAqd3RibF9oZHI7DQo+ID4gKwlzdHJ1Y3Qgd3RibF9nZW5lcmljICp3
dGJsX2c7DQo+ID4gKwlzdHJ1Y3Qgd3RibF9yeCAqd3RibF9yeDsNCj4gPiArCXU4ICpidWYgPSBy
ZXEuYnVmOw0KPiA+ICsNCj4gPiAgCWV0aF9icm9hZGNhc3RfYWRkcihyZXEuYmFzaWMucGVlcl9h
ZGRyKTsNCj4gPiAgDQo+ID4gKwl3dGJsX2hkciA9IChzdHJ1Y3Qgd3RibF9yZXFfaGRyICopYnVm
Ow0KPiA+ICsJYnVmICs9IHNpemVvZigqd3RibF9oZHIpOw0KPiA+ICsJd3RibF9oZHItPndsYW5f
aWR4ID0gbXZpZi0+c3RhLndjaWQuaWR4Ow0KPiA+ICsJd3RibF9oZHItPm9wZXJhdGlvbiA9IFdU
QkxfUkVTRVRfQU5EX1NFVDsNCj4gPiArDQo+ID4gIAlpZiAoZW4pIHsNCj4gPiAgCQlyZXEuYmFz
aWMuY29ubl9zdGF0ZSA9IENPTk5fU1RBVEVfUE9SVF9TRUNVUkU7DQo+ID4gIAkJcmVxLmJhc2lj
LmV4dHJhX2luZm8gPSBjcHVfdG9fbGUxNihFWFRSQV9JTkZPX1ZFUiB8DQo+ID4gQEAgLTExMTgs
MTAgKzEwNzgsMzcgQEAgaW50IG10NzYxNV9tY3Vfc2V0X3N0YV9yZWNfYm1jKHN0cnVjdCBtdDc2
MTVfZGV2ICpkZXYsDQo+ID4gIAl9IGVsc2Ugew0KPiA+ICAJCXJlcS5iYXNpYy5jb25uX3N0YXRl
ID0gQ09OTl9TVEFURV9ESVNDT05ORUNUOw0KPiA+ICAJCXJlcS5iYXNpYy5leHRyYV9pbmZvID0g
Y3B1X3RvX2xlMTYoRVhUUkFfSU5GT19WRVIpOw0KPiA+ICsNCj4gPiArCQlfX210NzZfbWN1X3Nl
bmRfbXNnKCZkZXYtPm10NzYsIE1DVV9FWFRfQ01EX1NUQV9SRUNfVVBEQVRFLA0KPiA+ICsJCQkJ
ICAgICZyZXEsICh1OCAqKXd0YmxfaGRyIC0gKHU4ICopJnJlcSwgdHJ1ZSk7DQo+IA0KPiB3ZSBu
ZWVkIHRvIGNoZWNrIHRoZSByZXR1cm4gdmFsdWUgZnJvbSBfX210NzZfbWN1X3NlbmRfbXNnIGhl
cmUuDQoNCk9rYXksIGJ1dCBpdCBzZWVtcyB3ZSBsYWNrIG9mIHNvbWUgZXJyb3IgaGFuZGxpbmcg
Zm9yIG1jdSBpbiBtYWluLmMuDQoNCj4gTW9yZW92ZXIsIGhlcmUgKHU4ICopd3RibF9oZHIgLSAo
dTggKikmcmVxIGlzDQo+IHNpemVvZihzdHJ1Y3Qgc3RhX3JlcV9oZHIpICsgc2l6ZW9mKHN0cnVj
dCBzdGFfcmVjX2Jhc2ljKSwgcmlnaHQ/DQo+IEkgZ3Vlc3MgaXQgd291bGQgYmUgZWFzaWVyIHRv
IHVuZGVyc3RhbmQgaWYgd2UgZXhwbGljaXQgdGhlIGxlbmd0aCwgd2hhdCBkbyB5b3UgdGhpbms/
DQoNCkknZCBsb3ZlIHRvIGV4cGxpY2l0IHRoZSBsZW5ndGgsIGJ1dCB0aGUgbGVuZ3RoIG9mIHRo
ZXNlIHZhcmlhYmxlIHRsdg0KcmVseSBvbiBzdGEncyBodC92aHRfY2FwLiBFc3BlY2lhbGx5IHdl
IGhhdmUgdG8gdGFrZSBiYWNrd2FyZA0KY29tcGF0aWJpbGl0eSAoZmlybXdhcmUgdjEpIGludG8g
YWNjb3VudCwgYW5kIHRoaXMgYWN0dWFsbHkgbWFrZXMgY29kZSBhDQpiaXQgbWVzc3kuIA0KDQo+
ID4gKw0KPiA+ICsJCXJldHVybiBfX210NzZfbWN1X3NlbmRfbXNnKCZkZXYtPm10NzYsIE1DVV9F
WFRfQ01EX1dUQkxfVVBEQVRFLA0KPiA+ICsJCQkJCSAgICh1OCAqKXd0YmxfaGRyLCBidWYgLSAo
dTggKil3dGJsX2hkciwNCj4gPiArCQkJCQkgICB0cnVlKTsNCj4gPiAgCX0NCj4gPiAgDQo+ID4g
Kwl3dGJsX2cgPSAoc3RydWN0IHd0YmxfZ2VuZXJpYyAqKWJ1ZjsNCj4gPiArCWJ1ZiArPSBzaXpl
b2YoKnd0YmxfZyk7DQo+ID4gKwl3dGJsX2ctPnRhZyA9IGNwdV90b19sZTE2KFdUQkxfR0VORVJJ
Qyk7DQo+ID4gKwl3dGJsX2ctPmxlbiA9IGNwdV90b19sZTE2KHNpemVvZigqd3RibF9nKSk7DQo+
ID4gKwl3dGJsX2ctPm11YXJfaWR4ID0gMHhlOw0KPiA+ICsJZXRoX2Jyb2FkY2FzdF9hZGRyKHd0
YmxfZy0+cGVlcl9hZGRyKTsNCj4gPiArDQo+ID4gKwl3dGJsX3J4ID0gKHN0cnVjdCB3dGJsX3J4
ICopYnVmOw0KPiA+ICsJYnVmICs9IHNpemVvZigqd3RibF9yeCk7DQo+ID4gKwl3dGJsX3J4LT50
YWcgPSBjcHVfdG9fbGUxNihXVEJMX1JYKTsNCj4gPiArCXd0YmxfcngtPmxlbiA9IGNwdV90b19s
ZTE2KHNpemVvZigqd3RibF9yeCkpOw0KPiA+ICsJd3RibF9yeC0+cnYgPSAxOw0KPiA+ICsJd3Ri
bF9yeC0+cmNhMSA9IDE7DQo+ID4gKwl3dGJsX3J4LT5yY2EyID0gMTsNCj4gPiArDQo+ID4gKwl3
dGJsX2hkci0+dGx2X251bSA9IGNwdV90b19sZTE2KDIpOw0KPiA+ICsNCj4gPiArCV9fbXQ3Nl9t
Y3Vfc2VuZF9tc2coJmRldi0+bXQ3NiwgTUNVX0VYVF9DTURfV1RCTF9VUERBVEUsDQo+ID4gKwkJ
CSAgICAodTggKil3dGJsX2hkciwgYnVmIC0gKHU4ICopd3RibF9oZHIsIHRydWUpOw0KPiANCj4g
d2UgbmVlZCB0byBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIGZyb20gX19tdDc2X21jdV9zZW5kX21z
ZyBoZXJlDQo+ID4gKw0KPiA+ICAJcmV0dXJuIF9fbXQ3Nl9tY3Vfc2VuZF9tc2coJmRldi0+bXQ3
NiwgTUNVX0VYVF9DTURfU1RBX1JFQ19VUERBVEUsDQo+ID4gLQkJCQkgICAmcmVxLCBzaXplb2Yo
cmVxKSwgdHJ1ZSk7DQo+ID4gKwkJCQkgICAmcmVxLCAodTggKil3dGJsX2hkciAtICh1OCAqKSZy
ZXEsIHRydWUpOw0KPiANCj4gc2FtZSBoZXJlIGFib3V0IHRoZSBsZW5ndGguDQo+IA0KPiBSZWdh
cmRzLA0KPiBMb3JlbnpvDQo+IA0KUnlkZXINCg0KDQo=

