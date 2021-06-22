Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA73AFB1C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 04:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhFVCjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 22:39:21 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35742 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230045AbhFVCjU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 22:39:20 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 22:39:20 EDT
X-UUID: 263110465861455faf2f5880c05e07ab-20210622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eTodyqMyYRd024o564gRpnPI6Tqoq4hTYqKHDs4/ipk=;
        b=oe44yEYAWj0/IONSU6+jBXgF4uOWAtJs8+uCANyV8Xe1v1B1emL1xLWTJEa5vZbx05rHdw6jqrZWb7RPB70Ya9QcDYnCObC0d+T9TXNqgC7uplntSFOUzFShOPnRTi84IlBXD98cQ8ESO4MlWofmReNU1GoTL/9gpdCoMouHf48=;
X-UUID: 263110465861455faf2f5880c05e07ab-20210622
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1262497527; Tue, 22 Jun 2021 10:31:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 10:31:58 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Jun 2021 10:31:58 +0800
Message-ID: <10817fc92345946be76860d6944acb2205677447.camel@mediatek.com>
Subject: Re: [PATCH v2] mt76: mt7921: add .set_sar_specs support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <sean.wang@mediatek.com>, <nbd@nbd.name>,
        <lorenzo.bianconi@redhat.com>
CC:     <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 22 Jun 2021 10:31:58 +0800
In-Reply-To: <28d23d04a251490241763dd0b5fe50a523f6fb02.1624316313.git.objelf@gmail.com>
References: <28d23d04a251490241763dd0b5fe50a523f6fb02.1624316313.git.objelf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTIyIGF0IDA3OjA3ICswODAwLCBzZWFuLndhbmdAbWVkaWF0ZWsuY29t
IHdyb3RlOg0KPiBGcm9tOiBZTiBDaGVuIDxZTi5DaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IGFk
ZCAuc2V0X3Nhcl9zcGVjcyB0byBhbGxvdyBjb25maWd1cmluZyBTQVIgcG93ZXIgbGltaXRhdGlv
bnMgb24gdGhlDQo+IGZyZXF1ZW5jeSByYW5nZXMgZnJvbSB0aGUgdXNlcmxhbmQuDQo+IA0KPiBD
by1kZXZlbG9wZWQtYnk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBZTiBDaGVuIDxZTi5DaGVuQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+IHYyOiAxLiBs
b29wIGVuaGFuY2VtZW50IHdpdGggY29uc2lkZXJpbmcgbm8gb3ZlcmxhcHBpbmcgZnJlcXMNCj4g
ICAgIDIuIGVycm9yIGhhbmRsaW5nIGZvciBkZXZtX2tjYWxsb2MNCj4gICAgIDMuIHNhbml0eSBj
aGVjayB3aXRob3V0IGFjcXVpcmUgbG9jaw0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3Ni5oICAgICB8ICAzICsrDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3Nl9jb25uYWMuaCAgfCAgNSArKysNCj4gIC4uLi93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzZfY29ubmFjX21jdS5jICB8IDI2ICsrKysrKysrKysrLQ0KPiAgLi4uL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkyMS9pbml0LmMgIHwgMzMgKysrKysrKysrKysr
KystDQo+ICAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL21haW4uYyAgfCA0
MQ0KPiArKysrKysrKysrKysrKysrKysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDEwNSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc2LmgNCj4gaW5kZXggMjVjNWNlZWY1MjU3Li42M2NlNTI0MmM0ZDUgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQo+IEBAIC02
MzYsNiArNjM2LDkgQEAgc3RydWN0IG10NzZfcGh5IHsNCj4gIAkJc3RydWN0IHNrX2J1ZmYgKip0
YWlsOw0KPiAgCQl1MTYgc2Vxbm87DQo+ICAJfSByeF9hbXNkdVtfX01UX1JYUV9NQVhdOw0KPiAr
DQo+ICsJdm9pZCAqZnJwX2RhdGE7DQo+ICsJdTggbnVtX2ZycHM7DQo+ICB9Ow0KPiAgDQo+ICBz
dHJ1Y3QgbXQ3Nl9kZXYgew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hYy5oDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc2X2Nvbm5hYy5oDQo+IGluZGV4IGY0OWQ5N2QwYTFjNS4uOTVjN2QxY2FjN2M0
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzZf
Y29ubmFjLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2
X2Nvbm5hYy5oDQo+IEBAIC04Myw2ICs4MywxMSBAQCBzdHJ1Y3QgbXQ3Nl9jb25uYWNfY29yZWR1
bXAgew0KPiAgCXVuc2lnbmVkIGxvbmcgbGFzdF9hY3Rpdml0eTsNCj4gIH07DQo+ICANCj4gK3N0
cnVjdCBtdDc2X2Nvbm5hY19mcmVxX3JhbmdlX3Bvd2VyIHsNCj4gKwljb25zdCBzdHJ1Y3QgY2Zn
ODAyMTFfc2FyX2ZyZXFfcmFuZ2VzICpyYW5nZTsNCj4gKwlzOCBwb3dlcjsNCj4gK307DQo+ICsN
Cj4gIGV4dGVybiBjb25zdCBzdHJ1Y3Qgd2lwaHlfd293bGFuX3N1cHBvcnQgbXQ3Nl9jb25uYWNf
d293bGFuX3N1cHBvcnQ7DQo+ICANCj4gIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19tdDc5MjEoc3Ry
dWN0IG10NzZfZGV2ICpkZXYpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzZfY29ubmFjX21jdS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc2X2Nvbm5hY19tY3UuYw0KPiBpbmRleCA1YzNhODFlNWY1NTkuLjQ5
N2RlMWQ5MWM3YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc2X2Nvbm5hY19tY3UuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzZfY29ubmFjX21jdS5jDQo+IEBAIC0xNzQ5LDYgKzE3NDksMjYgQEAgbXQ3
Nl9jb25uYWNfbWN1X2J1aWxkX3NrdShzdHJ1Y3QgbXQ3Nl9kZXYNCj4gKmRldiwgczggKnNrdSwN
Cj4gIAl9DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBzOCBtdDc2X2Nvbm5hY19nZXRfc2FyX3Bvd2Vy
KHN0cnVjdCBtdDc2X3BoeSAqcGh5LA0KPiArCQkJCSAgICBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5u
ZWwgKmNoYW4sDQo+ICsJCQkJICAgIHM4IHRhcmdldF9wb3dlcikNCj4gK3sNCj4gKwlzdHJ1Y3Qg
bXQ3Nl9jb25uYWNfZnJlcV9yYW5nZV9wb3dlciAqZnJwID0gcGh5LT5mcnBfZGF0YTsNCj4gKwlp
bnQgZnJlcSwgaTsNCj4gKw0KPiArCWZyZXEgPSBpZWVlODAyMTFfY2hhbm5lbF90b19mcmVxdWVu
Y3koY2hhbi0+aHdfdmFsdWUsIGNoYW4tDQo+ID5iYW5kKTsNCj4gKwlmb3IgKGkgPSAwIDsgaSA8
IHBoeS0+bnVtX2ZycHM7IGkrKykgew0KPiArCQlpZiAoZnJwW2ldLnJhbmdlICYmDQo+ICsJCSAg
ICBmcmVxID49IGZycFtpXS5yYW5nZS0+c3RhcnRfZnJlcSAmJg0KPiArCQkgICAgZnJlcSA8IGZy
cFtpXS5yYW5nZS0+ZW5kX2ZyZXEpIHsNCj4gKwkJCXRhcmdldF9wb3dlciA9IG1pbl90KHM4LCBm
cnBbaV0ucG93ZXIsDQo+IHRhcmdldF9wb3dlcik7DQo+ICsJCQlicmVhazsNCj4gKwkJfQ0KPiAr
CX0NCj4gKw0KPiArCXJldHVybiB0YXJnZXRfcG93ZXI7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBp
bnQNCj4gIG10NzZfY29ubmFjX21jdV9yYXRlX3R4cG93ZXJfYmFuZChzdHJ1Y3QgbXQ3Nl9waHkg
KnBoeSwNCj4gIAkJCQkgIGVudW0gbmw4MDIxMV9iYW5kIGJhbmQpDQo+IEBAIC0xODE2LDkgKzE4
MzYsMTMgQEAgbXQ3Nl9jb25uYWNfbWN1X3JhdGVfdHhwb3dlcl9iYW5kKHN0cnVjdA0KPiBtdDc2
X3BoeSAqcGh5LA0KPiAgCQkJCS5od192YWx1ZSA9IGNoX2xpc3RbaWR4XSwNCj4gIAkJCQkuYmFu
ZCA9IGJhbmQsDQo+ICAJCQl9Ow0KPiArCQkJczggc2FyX3Bvd2VyOw0KPiArDQo+ICsJCQlzYXJf
cG93ZXIgPSBtdDc2X2Nvbm5hY19nZXRfc2FyX3Bvd2VyKHBoeSwNCj4gJmNoYW4sDQo+ICsJCQkJ
CQkJICAgICAgdHhfcG93ZXIpDQo+IDsNCj4gIA0KPiAgCQkJbXQ3Nl9nZXRfcmF0ZV9wb3dlcl9s
aW1pdHMocGh5LCAmY2hhbiwgJmxpbWl0cywNCj4gLQkJCQkJCSAgIHR4X3Bvd2VyKTsNCj4gKwkJ
CQkJCSAgIHNhcl9wb3dlcik7DQo+ICANCj4gIAkJCXR4X3Bvd2VyX3Rsdi5sYXN0X21zZyA9IGNo
X2xpc3RbaWR4XSA9PQ0KPiBsYXN0X2NoOw0KPiAgCQkJc2t1X3RsYnYuY2hhbm5lbCA9IGNoX2xp
c3RbaWR4XTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTIxL2luaXQuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTIxL2luaXQuYw0KPiBpbmRleCBhOWNlMTBiOTg4MjcuLmMxMWE1YjkyNTIwOSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MjEvaW5pdC5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTIxL2luaXQu
Yw0KPiBAQCAtMjQsNiArMjQsMjAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfaWZh
Y2VfY29tYmluYXRpb24NCj4gaWZfY29tYltdID0gew0KPiAgCX0NCj4gIH07DQo+ICANCj4gK2Nv
bnN0IHN0cnVjdCBjZmc4MDIxMV9zYXJfZnJlcV9yYW5nZXMgbXQ3OTIxX3Nhcl9mcmVxX3Jhbmdl
c1tdID0gew0KPiArCXsgLnN0YXJ0X2ZyZXEgPSAyNDAyLCAuZW5kX2ZyZXEgPSAyNDk0LCB9LA0K
PiArCXsgLnN0YXJ0X2ZyZXEgPSA1MTUwLCAuZW5kX2ZyZXEgPSA1MzUwLCB9LA0KPiArCXsgLnN0
YXJ0X2ZyZXEgPSA1MzUwLCAuZW5kX2ZyZXEgPSA1NDcwLCB9LA0KPiArCXsgLnN0YXJ0X2ZyZXEg
PSA1NDcwLCAuZW5kX2ZyZXEgPSA1NzI1LCB9LA0KPiArCXsgLnN0YXJ0X2ZyZXEgPSA1NzI1LCAu
ZW5kX2ZyZXEgPSA1OTUwLCB9LA0KPiArfTsNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBj
Zmc4MDIxMV9zYXJfY2FwYSBtdDc5MjFfc2FyX2NhcGEgPSB7DQo+ICsJLnR5cGUgPSBOTDgwMjEx
X1NBUl9UWVBFX1BPV0VSLA0KPiArCS5udW1fZnJlcV9yYW5nZXMgPSBBUlJBWV9TSVpFKG10Nzky
MV9zYXJfZnJlcV9yYW5nZXMpLA0KPiArCS5mcmVxX3JhbmdlcyA9ICZtdDc5MjFfc2FyX2ZyZXFf
cmFuZ2VzWzBdLA0KPiArfTsNCj4gKw0KPiANCg0KTm93dGhhdCB3ZSBoYXZlIGZycHMgaW4gbXQ3
Ni5oIHdlIGNhbiBtYWtlIHRoZXNlIFNBUiBjaHVuayBzaGFyYWJsZSBhcw0Kd2VsbCB0byBwcm92
aWRlIGEgY29tbW9uIGdyb3VuZCB0byBvdGhlciBtdDc2IHN0YXRpb24gZGV2aWNlcyBtaWdodA0K
cmVxdWlyZSBzZXRfc2FyX3NwZWMuDQoNClJ5ZGVyDQo=

