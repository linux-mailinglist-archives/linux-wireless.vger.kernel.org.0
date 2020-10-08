Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4126287369
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgJHLd3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 07:33:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47557 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729829AbgJHLd1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 07:33:27 -0400
X-UUID: 2c92eaa616ee47df8c7d03ead87aa5f0-20201008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eDsG0jlH0SbkNBK6qh4H39uup3IqO1o0uLrj6K7Zkvc=;
        b=iFp69IHF1ba7iiIZiVRA9WvDN9N148PAAhBahz/h9q/qhbqwKH0hbtLJO54GXNGOMTn1mhCD+vh2Kgu8xyuVWZCpNJWIYYJMMt53tw50EaY689RL6v9wCEg6Otot8B+r3Gq8H3kJ4T6Wjhu57irJIrTLKK7tt09tRrJv55KDpDg=;
X-UUID: 2c92eaa616ee47df8c7d03ead87aa5f0-20201008
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 717460526; Thu, 08 Oct 2020 19:33:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Oct 2020 19:33:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Oct 2020 19:33:14 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 08/10] mt76: mt7915: implement testmode rx support
Date:   Thu, 8 Oct 2020 19:29:02 +0800
Message-ID: <20201008112904.10620-8-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201008112904.10620-1-shayne.chen@mediatek.com>
References: <20201008112904.10620-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U3VwcG9ydCB0ZXN0bW9kZSByeCBhbmQgZGlzcGxheSByeCBzdGF0aXN0aWMgYnkgcGFyc2luZyBS
WFYgcGFja2V0DQp0eXBlLCB3aGljaCBpcyBjdXJyZW50bHkgb25seSBlbmFibGVkIGluIHRlc3Rt
b2RlLg0KDQpTaWduZWQtb2ZmLWJ5OiBTaGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KUmV2aWV3ZWQtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvZG1hLmMgICB8ICAzICsN
CiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jICAgfCAzNyArKysr
KysrDQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWMuaCAgIHwgIDUg
Kw0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmggICB8ICAxICsN
CiAuLi4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmggICAgfCAgNyArKw0K
IC4uLi93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS90ZXN0bW9kZS5jICB8IDk3ICsrKysr
KysrKysrKysrKysrKysNCiAuLi4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1v
ZGUuaCAgfCAzMCArKysrKysNCiA3IGZpbGVzIGNoYW5nZWQsIDE4MCBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9k
bWEuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2RtYS5jDQpp
bmRleCBjZmExMmM0Li5lMTQ4MTRkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvZG1hLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L2RtYS5jDQpAQCAtNjEsNiArNjEsOSBAQCB2b2lkIG10NzkxNV9x
dWV1ZV9yeF9za2Ioc3RydWN0IG10NzZfZGV2ICptZGV2LCBlbnVtIG10NzZfcnhxX2lkIHEsDQog
CWNhc2UgUEtUX1RZUEVfUlhfRVZFTlQ6DQogCQltdDc5MTVfbWN1X3J4X2V2ZW50KGRldiwgc2ti
KTsNCiAJCWJyZWFrOw0KKwljYXNlIFBLVF9UWVBFX1RYUlhWOg0KKwkJbXQ3OTE1X21hY19maWxs
X3J4X3ZlY3RvcihkZXYsIHNrYik7DQorCQlicmVhazsNCiAJY2FzZSBQS1RfVFlQRV9OT1JNQUw6
DQogCQlpZiAoIW10NzkxNV9tYWNfZmlsbF9yeChkZXYsIHNrYikpIHsNCiAJCQltdDc2X3J4KCZk
ZXYtPm10NzYsIHEsIHNrYik7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tYWMuYw0KaW5kZXggZTAzZTEyZi4uZWMzMGRkMiAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jDQorKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWMuYw0KQEAgLTU2Miw2ICs1
NjIsNDMgQEAgaW50IG10NzkxNV9tYWNfZmlsbF9yeChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBz
dHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KIAlyZXR1cm4gMDsNCiB9DQogDQordm9pZCBtdDc5MTVfbWFj
X2ZpbGxfcnhfdmVjdG9yKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBza19idWZmICpz
a2IpDQorew0KKyNpZmRlZiBDT05GSUdfTkw4MDIxMV9URVNUTU9ERQ0KKwlfX2xlMzIgKnJ4ZCA9
IChfX2xlMzIgKilza2ItPmRhdGE7DQorCV9fbGUzMiAqcnh2ID0gcnhkICsgNDsNCisJdTMyIHJj
cGksIGliX3Jzc2ksIHdiX3Jzc2ksIHYyMCwgdjIxOw0KKwlzMzIgZm9lLCBzbnI7DQorCWludCBp
Ow0KKw0KKwlyY3BpID0gbGUzMl90b19jcHUocnh2WzZdKTsNCisJaWJfcnNzaSA9IGxlMzJfdG9f
Y3B1KHJ4dls3XSk7DQorCXdiX3Jzc2kgPSBsZTMyX3RvX2NwdShyeHZbOF0pID4+IDU7DQorDQor
CWZvciAoaSA9IDA7IGkgPCA0OyBpKyssIHJjcGkgPj49IDgsIGliX3Jzc2kgPj49IDgsIHdiX3Jz
c2kgPj49IDkpIHsNCisJCWlmIChpID09IDMpDQorCQkJd2JfcnNzaSA9IGxlMzJfdG9fY3B1KHJ4
dls5XSk7DQorDQorCQlkZXYtPnRlc3QubGFzdF9yY3BpW2ldID0gcmNwaSAmIDB4ZmY7DQorCQlk
ZXYtPnRlc3QubGFzdF9pYl9yc3NpW2ldID0gaWJfcnNzaSAmIDB4ZmY7DQorCQlkZXYtPnRlc3Qu
bGFzdF93Yl9yc3NpW2ldID0gd2JfcnNzaSAmIDB4ZmY7DQorCX0NCisNCisJdjIwID0gbGUzMl90
b19jcHUocnh2WzIwXSk7DQorCXYyMSA9IGxlMzJfdG9fY3B1KHJ4dlsyMV0pOw0KKw0KKwlmb2Ug
PSBGSUVMRF9HRVQoTVRfQ1JYVl9GT0VfTE8sIHYyMCkgfA0KKwkgICAgICAoRklFTERfR0VUKE1U
X0NSWFZfRk9FX0hJLCB2MjEpIDw8IE1UX0NSWFZfRk9FX1NISUZUKTsNCisNCisJc25yID0gRklF
TERfR0VUKE1UX0NSWFZfU05SLCB2MjApIC0gMTY7DQorDQorCWRldi0+dGVzdC5sYXN0X2ZyZXFf
b2Zmc2V0ID0gZm9lOw0KKwlkZXYtPnRlc3QubGFzdF9zbnIgPSBzbnI7DQorDQorCWRldl9rZnJl
ZV9za2Ioc2tiKTsNCisjZW5kaWYNCit9DQorDQogc3RhdGljIHUxNg0KIG10NzkxNV9tYWNfdHhf
cmF0ZV92YWwoc3RydWN0IG10NzZfcGh5ICptcGh5LCB1OCBtb2RlLCB1OCByYXRlX2lkeCwNCiAJ
CSAgICAgICB1OCBuc3MsIHU4IHN0YmMsIHU4ICpidykNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWMuaCBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5oDQppbmRleCAwOTIxYjZmLi5kNDIwMzkyIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFj
LmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5o
DQpAQCAtMTI4LDYgKzEyOCwxMSBAQCBlbnVtIHJ4X3BrdF90eXBlIHsNCiAjZGVmaW5lIE1UX0NS
WFZfSEVfQkVBTV9DSE5HCQlCSVQoMTMpDQogI2RlZmluZSBNVF9DUlhWX0hFX0RPUFBMRVIJCUJJ
VCgxNikNCiANCisjZGVmaW5lIE1UX0NSWFZfU05SCQlHRU5NQVNLKDE4LCAxMykNCisjZGVmaW5l
IE1UX0NSWFZfRk9FX0xPCQlHRU5NQVNLKDMxLCAxOSkNCisjZGVmaW5lIE1UX0NSWFZfRk9FX0hJ
CQlHRU5NQVNLKDYsIDApDQorI2RlZmluZSBNVF9DUlhWX0ZPRV9TSElGVAkxMw0KKw0KIGVudW0g
dHhfaGVhZGVyX2Zvcm1hdCB7DQogCU1UX0hEUl9GT1JNQVRfODAyXzMsDQogCU1UX0hEUl9GT1JN
QVRfQ01ELA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L21jdS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
bWN1LmgNCmluZGV4IDBhN2U5ZDIuLjg5NDUzYTYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuaA0KKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmgNCkBAIC00OCw2ICs0OCw3IEBAIGVudW0g
ew0KIA0KIGVudW0gew0KIAlNQ1VfQVRFX1NFVF9UUlggPSAweDEsDQorCU1DVV9BVEVfU0VUX1JY
X0ZJTFRFUiA9IDB4MywNCiB9Ow0KIA0KIHN0cnVjdCBtdDc5MTVfbWN1X3J4ZCB7DQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1Lmgg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tdDc5MTUuaA0KaW5k
ZXggNjczNTkxNS4uOGViZmVkOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5oDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkxNS9tdDc5MTUuaA0KQEAgLTE2NSw2ICsxNjUsMTIgQEAgc3RydWN0
IG10NzkxNV9kZXYgew0KIAlzdHJ1Y3Qgew0KIAkJdTMyICpyZWdfYmFja3VwOw0KIA0KKwkJczMy
IGxhc3RfZnJlcV9vZmZzZXQ7DQorCQl1OCBsYXN0X3JjcGlbNF07DQorCQlzOCBsYXN0X2liX3Jz
c2lbNF07DQorCQlzOCBsYXN0X3diX3Jzc2lbNF07DQorCQlzMzIgbGFzdF9zbnI7DQorDQogCQl1
OCBzcGVfaWR4Ow0KIAl9IHRlc3Q7DQogI2VuZGlmDQpAQCAtNDM2LDYgKzQ0Miw3IEBAIHZvaWQg
bXQ3OTE1X21hY193cml0ZV90eHdpKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIF9fbGUzMiAqdHh3
aSwNCiAJCQkgICBzdHJ1Y3QgaWVlZTgwMjExX2tleV9jb25mICprZXksIGJvb2wgYmVhY29uKTsN
CiB2b2lkIG10NzkxNV9tYWNfc2V0X3RpbWluZyhzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5KTsNCiBp
bnQgbXQ3OTE1X21hY19maWxsX3J4KHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBza19i
dWZmICpza2IpOw0KK3ZvaWQgbXQ3OTE1X21hY19maWxsX3J4X3ZlY3RvcihzdHJ1Y3QgbXQ3OTE1
X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTsNCiB2b2lkIG10NzkxNV9tYWNfdHhfZnJl
ZShzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTsNCiBpbnQgbXQ3
OTE1X21hY19zdGFfYWRkKHN0cnVjdCBtdDc2X2RldiAqbWRldiwgc3RydWN0IGllZWU4MDIxMV92
aWYgKnZpZiwNCiAJCSAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqc3RhKTsNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS90ZXN0bW9kZS5j
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1vZGUuYw0K
aW5kZXggNTNmYzk3Ny4uY2M1YWI5OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L3Rlc3Rtb2RlLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Rlc3Rtb2RlLmMNCkBAIC0xMTMsNiArMTEzLDMxIEBA
IG10NzkxNV90bV9yZWdfYmFja3VwX3Jlc3RvcmUoc3RydWN0IG10NzkxNV9kZXYgKmRldiwgc3Ry
dWN0IG10NzkxNV9waHkgKnBoeSkNCiAJbXQ3Nl9jbGVhcihkZXYsIE1UX1RNQUNfVENSMCgwKSwg
TVRfVE1BQ19UQ1IwX1RCVFRfU1RPUF9DVFJMKTsNCiB9DQogDQorc3RhdGljIGludA0KK210Nzkx
NV90bV9jb25maWdfcnhfZmlsdGVyKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIGJvb2wgZW4pDQor
ew0KKwlzdHJ1Y3QgbXQ3OTE1X3RtX2NtZCByZXEgPSB7DQorCQkudGVzdG1vZGVfZW4gPSAxLA0K
KwkJLnBhcmFtX2lkeCA9IE1DVV9BVEVfU0VUX1JYX0ZJTFRFUiwNCisJCS5wYXJhbS5maWx0ZXIu
cmVwb3J0X2VuID0gZW4sDQorCQkucGFyYW0uZmlsdGVyLmJhbmQgPSAwLA0KKwl9Ow0KKwlfX2xl
MzIgbWFzayA9IFJYX0ZJTFRFUl9OT1RfT1dOX0JUSU0gfA0KKwkJICAgICAgUlhfRklMVEVSX05P
VF9PV05fVUNBU1QgfA0KKwkJICAgICAgUlhfRklMVEVSX1JUUyB8IFJYX0ZJTFRFUl9DVFMgfA0K
KwkJICAgICAgUlhfRklMVEVSX0NUUkxfUlNWIHwNCisJCSAgICAgIFJYX0ZJTFRFUl9CQ19NQ19C
U1NJRF9BMiB8DQorCQkgICAgICBSWF9GSUxURVJfQkNfTUNfQlNTSURfQTMgfA0KKwkJICAgICAg
UlhfRklMVEVSX0JDX01DX09NQUNfQTMgfA0KKwkJICAgICAgUlhfRklMVEVSX1BST1RPQ09MX1ZF
UlNJT04gfA0KKwkJICAgICAgUlhfRklMVEVSX0ZDU19FUlI7DQorDQorCXJlcS5wYXJhbS5maWx0
ZXIubWFzayA9IGNwdV90b19sZTMyKG1hc2spOw0KKw0KKwlyZXR1cm4gbXQ3Nl9tY3Vfc2VuZF9t
c2coJmRldi0+bXQ3NiwgTUNVX0VYVF9DTURfQVRFX0NUUkwsICZyZXEsDQorCQkJCSBzaXplb2Yo
cmVxKSwgZmFsc2UpOw0KK30NCisNCiBzdGF0aWMgdm9pZA0KIG10NzkxNV90bV9pbml0KHN0cnVj
dCBtdDc5MTVfZGV2ICpkZXYpDQogew0KQEAgLTEyNCw2ICsxNDksNyBAQCBtdDc5MTVfdG1faW5p
dChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2KQ0KIAltdDc5MTVfdG1fbW9kZV9jdHJsKGRldiwgZW4p
Ow0KIAltdDc5MTVfdG1fcmVnX2JhY2t1cF9yZXN0b3JlKGRldiwgJmRldi0+cGh5KTsNCiAJbXQ3
OTE1X3RtX3NldF90cngoZGV2LCAmZGV2LT5waHksIFRNX01BQ19UWFJYLCAhZW4pOw0KKwltdDc5
MTVfdG1fY29uZmlnX3J4X2ZpbHRlcihkZXYsIGVuKTsNCiB9DQogDQogc3RhdGljIHZvaWQNCkBA
IC0xNTYsNiArMTgyLDIwIEBAIG10NzkxNV90bV9zZXRfdHhfZnJhbWVzKHN0cnVjdCBtdDc5MTVf
ZGV2ICpkZXYsIGJvb2wgZW4pDQogCWluZm8tPmNvbnRyb2wudmlmID0gZGV2LT5waHkubW9uaXRv
cl92aWY7DQogfQ0KIA0KK3N0YXRpYyB2b2lkDQorbXQ3OTE1X3RtX3NldF9yeF9mcmFtZXMoc3Ry
dWN0IG10NzkxNV9kZXYgKmRldiwgYm9vbCBlbikNCit7DQorCWlmIChlbikgew0KKwkJbXV0ZXhf
dW5sb2NrKCZkZXYtPm10NzYubXV0ZXgpOw0KKwkJbXQ3OTE1X3NldF9jaGFubmVsKCZkZXYtPnBo
eSk7DQorCQltdXRleF9sb2NrKCZkZXYtPm10NzYubXV0ZXgpOw0KKw0KKwkJbXQ3OTE1X21jdV9z
ZXRfY2hhbl9pbmZvKCZkZXYtPnBoeSwgTUNVX0VYVF9DTURfU0VUX1JYX1BBVEgpOw0KKwl9DQor
DQorCW10NzkxNV90bV9zZXRfdHJ4KGRldiwgJmRldi0+cGh5LCBUTV9NQUNfUlhfUlhWLCBlbik7
DQorfQ0KKw0KIHN0YXRpYyBpbnQNCiBtdDc5MTVfdG1fc2V0X3N0YXRlKHN0cnVjdCBtdDc2X2Rl
diAqbWRldiwgZW51bSBtdDc2X3Rlc3Rtb2RlX3N0YXRlIHN0YXRlKQ0KIHsNCkBAIC0xNjksMTIg
KzIwOSw2OSBAQCBtdDc5MTVfdG1fc2V0X3N0YXRlKHN0cnVjdCBtdDc2X2RldiAqbWRldiwgZW51
bSBtdDc2X3Rlc3Rtb2RlX3N0YXRlIHN0YXRlKQ0KIAkJbXQ3OTE1X3RtX3NldF90eF9mcmFtZXMo
ZGV2LCBmYWxzZSk7DQogCWVsc2UgaWYgKHN0YXRlID09IE1UNzZfVE1fU1RBVEVfVFhfRlJBTUVT
KQ0KIAkJbXQ3OTE1X3RtX3NldF90eF9mcmFtZXMoZGV2LCB0cnVlKTsNCisJZWxzZSBpZiAocHJl
dl9zdGF0ZSA9PSBNVDc2X1RNX1NUQVRFX1JYX0ZSQU1FUykNCisJCW10NzkxNV90bV9zZXRfcnhf
ZnJhbWVzKGRldiwgZmFsc2UpOw0KKwllbHNlIGlmIChzdGF0ZSA9PSBNVDc2X1RNX1NUQVRFX1JY
X0ZSQU1FUykNCisJCW10NzkxNV90bV9zZXRfcnhfZnJhbWVzKGRldiwgdHJ1ZSk7DQogCWVsc2Ug
aWYgKHByZXZfc3RhdGUgPT0gTVQ3Nl9UTV9TVEFURV9PRkYgfHwgc3RhdGUgPT0gTVQ3Nl9UTV9T
VEFURV9PRkYpDQogCQltdDc5MTVfdG1faW5pdChkZXYpOw0KIA0KIAlyZXR1cm4gMDsNCiB9DQog
DQorc3RhdGljIGludA0KK210NzkxNV90bV9kdW1wX3N0YXRzKHN0cnVjdCBtdDc2X2RldiAqbWRl
diwgc3RydWN0IHNrX2J1ZmYgKm1zZykNCit7DQorCXN0cnVjdCBtdDc5MTVfZGV2ICpkZXYgPSBj
b250YWluZXJfb2YobWRldiwgc3RydWN0IG10NzkxNV9kZXYsIG10NzYpOw0KKwl2b2lkICpyeCwg
KnJzc2k7DQorCWludCBpOw0KKw0KKwlyeCA9IG5sYV9uZXN0X3N0YXJ0KG1zZywgTVQ3Nl9UTV9T
VEFUU19BVFRSX0xBU1RfUlgpOw0KKwlpZiAoIXJ4KQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQor
CWlmIChubGFfcHV0X3MzMihtc2csIE1UNzZfVE1fUlhfQVRUUl9GUkVRX09GRlNFVCwgZGV2LT50
ZXN0Lmxhc3RfZnJlcV9vZmZzZXQpKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCXJzc2kgPSBu
bGFfbmVzdF9zdGFydChtc2csIE1UNzZfVE1fUlhfQVRUUl9SQ1BJKTsNCisJaWYgKCFyc3NpKQ0K
KwkJcmV0dXJuIC1FTk9NRU07DQorDQorCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGRldi0+
dGVzdC5sYXN0X3JjcGkpOyBpKyspDQorCQlpZiAobmxhX3B1dF91OChtc2csIGksIGRldi0+dGVz
dC5sYXN0X3JjcGlbaV0pKQ0KKwkJCXJldHVybiAtRU5PTUVNOw0KKw0KKwlubGFfbmVzdF9lbmQo
bXNnLCByc3NpKTsNCisNCisJcnNzaSA9IG5sYV9uZXN0X3N0YXJ0KG1zZywgTVQ3Nl9UTV9SWF9B
VFRSX0lCX1JTU0kpOw0KKwlpZiAoIXJzc2kpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCisJZm9y
IChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZGV2LT50ZXN0Lmxhc3RfaWJfcnNzaSk7IGkrKykNCisJ
CWlmIChubGFfcHV0X3M4KG1zZywgaSwgZGV2LT50ZXN0Lmxhc3RfaWJfcnNzaVtpXSkpDQorCQkJ
cmV0dXJuIC1FTk9NRU07DQorDQorCW5sYV9uZXN0X2VuZChtc2csIHJzc2kpOw0KKw0KKwlyc3Np
ID0gbmxhX25lc3Rfc3RhcnQobXNnLCBNVDc2X1RNX1JYX0FUVFJfV0JfUlNTSSk7DQorCWlmICgh
cnNzaSkNCisJCXJldHVybiAtRU5PTUVNOw0KKw0KKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0la
RShkZXYtPnRlc3QubGFzdF93Yl9yc3NpKTsgaSsrKQ0KKwkJaWYgKG5sYV9wdXRfczgobXNnLCBp
LCBkZXYtPnRlc3QubGFzdF93Yl9yc3NpW2ldKSkNCisJCQlyZXR1cm4gLUVOT01FTTsNCisNCisJ
bmxhX25lc3RfZW5kKG1zZywgcnNzaSk7DQorDQorCWlmIChubGFfcHV0X3MzMihtc2csIE1UNzZf
VE1fUlhfQVRUUl9TTlIsIGRldi0+dGVzdC5sYXN0X3NucikpDQorCQlyZXR1cm4gLUVOT01FTTsN
CisNCisJbmxhX25lc3RfZW5kKG1zZywgcngpOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogY29u
c3Qgc3RydWN0IG10NzZfdGVzdG1vZGVfb3BzIG10NzkxNV90ZXN0bW9kZV9vcHMgPSB7DQogCS5z
ZXRfc3RhdGUgPSBtdDc5MTVfdG1fc2V0X3N0YXRlLA0KKwkuZHVtcF9zdGF0cyA9IG10NzkxNV90
bV9kdW1wX3N0YXRzLA0KIH07DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1vZGUuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L3Rlc3Rtb2RlLmgNCmluZGV4IDA0ZjRhMmMuLmIzNDRhNjQgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS90ZXN0bW9k
ZS5oDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS90ZXN0
bW9kZS5oDQpAQCAtMTEsNiArMTEsMTUgQEAgc3RydWN0IG10NzkxNV90bV90cnggew0KIAl1OCBy
c3Y7DQogfTsNCiANCitzdHJ1Y3QgbXQ3OTE1X3RtX3J4X2ZpbHRlciB7DQorCXU4IHByb21pc2N1
b3VzOw0KKwl1OCByZXBvcnRfZW47DQorCXU4IGJhbmQ7DQorCXU4IF9yc3Y7DQorCV9fbGUzMiBt
YXNrOw0KKwl1OCBfcnN2MVs0XTsNCit9Ow0KKw0KIHN0cnVjdCBtdDc5MTVfdG1fY21kIHsNCiAJ
dTggdGVzdG1vZGVfZW47DQogCXU4IHBhcmFtX2lkeDsNCkBAIC0xOCw2ICsyNyw3IEBAIHN0cnVj
dCBtdDc5MTVfdG1fY21kIHsNCiAJdW5pb24gew0KIAkJX19sZTMyIGRhdGE7DQogCQlzdHJ1Y3Qg
bXQ3OTE1X3RtX3RyeCB0cng7DQorCQlzdHJ1Y3QgbXQ3OTE1X3RtX3J4X2ZpbHRlciBmaWx0ZXI7
DQogCQl1OCB0ZXN0WzcyXTsNCiAJfSBwYXJhbTsNCiB9IF9fcGFja2VkOw0KQEAgLTMxLDQgKzQx
LDI0IEBAIGVudW0gew0KIAlUTV9NQUNfUlhfUlhWLA0KIH07DQogDQorI2RlZmluZSBSWF9GSUxU
RVJfU1RCQ19CQ05fQkNfTUMJQklUKDApDQorI2RlZmluZSBSWF9GSUxURVJfRkNTX0VSUgkJQklU
KDEpDQorI2RlZmluZSBSWF9GSUxURVJfUFJPVE9DT0xfVkVSU0lPTglCSVQoMikNCisjZGVmaW5l
IFJYX0ZJTFRFUl9QUk9CX1JFUQkJQklUKDMpDQorI2RlZmluZSBSWF9GSUxURVJfTUNBU1QJCQlC
SVQoNCkNCisjZGVmaW5lIFJYX0ZJTFRFUl9CQ0FTVAkJCUJJVCg1KQ0KKyNkZWZpbmUgUlhfRklM
VEVSX01DQVNUX1RBQkxFCQlCSVQoNikNCisjZGVmaW5lIFJYX0ZJTFRFUl9CQ19NQ19PTUFDX0Ez
CQlCSVQoNykNCisjZGVmaW5lIFJYX0ZJTFRFUl9CQ19NQ19CU1NJRF9BMwlCSVQoOCkNCisjZGVm
aW5lIFJYX0ZJTFRFUl9CQ19NQ19CU1NJRF9BMglCSVQoOSkNCisjZGVmaW5lIFJYX0ZJTFRFUl9C
Q05fQlNTSUQJCUJJVCgxMCkNCisjZGVmaW5lIFJYX0ZJTFRFUl9DVFJMX1JTVgkJQklUKDExKQ0K
KyNkZWZpbmUgUlhfRklMVEVSX0NUUwkJCUJJVCgxMikNCisjZGVmaW5lIFJYX0ZJTFRFUl9SVFMJ
CQlCSVQoMTMpDQorI2RlZmluZSBSWF9GSUxURVJfRFVQTElDQVRFCQlCSVQoMTQpDQorI2RlZmlu
ZSBSWF9GSUxURVJfTk9UX09XTl9CU1NJRAkJQklUKDE1KQ0KKyNkZWZpbmUgUlhfRklMVEVSX05P
VF9PV05fVUNBU1QJCUJJVCgxNikNCisjZGVmaW5lIFJYX0ZJTFRFUl9OT1RfT1dOX0JUSU0JCUJJ
VCgxNykNCisjZGVmaW5lIFJYX0ZJTFRFUl9ORFBBCQkJQklUKDE4KQ0KKw0KICNlbmRpZg0KLS0g
DQoyLjE3LjENCg==

