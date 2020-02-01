Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF79114F894
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Feb 2020 16:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgBAPeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Feb 2020 10:34:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:21498 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727074AbgBAPeJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Feb 2020 10:34:09 -0500
X-UUID: f39701e74dd6459a9df1b464c915aa84-20200201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PT9WxQGhC3cEbQOw6A82uZTv0dUXzk8iQLhXQx+MP6c=;
        b=OKhOB6K8UmH+JEUH+rd4cnpU/RbT0s62TmQ1AvggXnzg6ep/pXS4J6qnBQbFc30Nn/VZ6WLKzb3CQnb5OQ8JRdQbpBjP5XOfVRMbq17jmyja5b0ko+lOkqOsPvDw0VL5u+0Pprd1BGNwirs93ELZ+4opJWw39VScSZp9qd+EXKo=;
X-UUID: f39701e74dd6459a9df1b464c915aa84-20200201
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1043976491; Sat, 01 Feb 2020 23:34:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 1 Feb 2020 23:33:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 1 Feb 2020 23:31:33 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Josh Boyer <jwboyer@kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 3/7] mt76: mt7615: add a helper to encapsulate sta_rec operation
Date:   Sat, 1 Feb 2020 23:33:48 +0800
Message-ID: <0be0e4d66e8a775c7e0f0b9d9289cb149df97678.1580565624.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1580565624.git.ryder.lee@mediatek.com>
References: <cover.1580565624.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7CC7DEA808D52862B1BE4DBA5B8249145234E03B1BFC32F24DCA5334ADE3C7792000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

T3BlcmF0aW5nIGNvbW1hbmQgaXMgc2ltcGxlciBhbmQganVzdCBhcyBjbGVhcg0KDQpTaWduZWQt
b2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBTaGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tPg0KVGVzdGVkLWJ5OiBTZWFu
IFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jICAgfCAxMjIgKysrKysrKysrKy0tLS0tLS0tDQogMSBm
aWxlIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKyksIDU3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0KaW5kZXggMzBm
ZjA4YmM5YWZjLi5iYWFmYThmYWZhZjEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCkBAIC05ODgsNiArOTg4LDMzIEBAIGludCBtdDc2
MTVfbWN1X2RlbF93dGJsX2FsbChzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2KQ0KIAkJCQkgICAmcmVx
LCBzaXplb2YocmVxKSwgdHJ1ZSk7DQogfQ0KIA0KK3N0YXRpYyBpbnQNCittdDc2MTVfbWN1X3Nl
bmRfc3RhX3JlYyhzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2LCB1OCAqcmVxLCB1OCAqd3JlcSwNCisJ
CQl1OCB3bGVuLCBib29sIGVuYWJsZSkNCit7DQorCXUzMiBzbGVuID0gd3JlcSAtIHJlcTsNCisJ
aW50IHJldDsNCisNCisJaWYgKCFlbmFibGUpIHsNCisJCXJldCA9IF9fbXQ3Nl9tY3Vfc2VuZF9t
c2coJmRldi0+bXQ3NiwNCisJCQkJCSAgTUNVX0VYVF9DTURfU1RBX1JFQ19VUERBVEUsDQorCQkJ
CQkgIHJlcSwgc2xlbiwgdHJ1ZSk7DQorCQlpZiAocmV0KQ0KKwkJCXJldHVybiByZXQ7DQorDQor
CQlyZXR1cm4gX19tdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LCBNQ1VfRVhUX0NNRF9XVEJM
X1VQREFURSwNCisJCQkJCSAgIHdyZXEsIHdsZW4sIHRydWUpOw0KKwl9DQorDQorCXJldCA9IF9f
bXQ3Nl9tY3Vfc2VuZF9tc2coJmRldi0+bXQ3NiwgTUNVX0VYVF9DTURfV1RCTF9VUERBVEUsIHdy
ZXEsDQorCQkJCSAgd2xlbiwgdHJ1ZSk7DQorCWlmIChyZXQpDQorCQlyZXR1cm4gcmV0Ow0KKw0K
KwlyZXR1cm4gX19tdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LCBNQ1VfRVhUX0NNRF9TVEFf
UkVDX1VQREFURSwNCisJCQkJICAgcmVxLCBzbGVuLCB0cnVlKTsNCit9DQorDQogaW50IG10NzYx
NV9tY3Vfc2V0X2JtYyhzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2LA0KIAkJICAgICAgIHN0cnVjdCBp
ZWVlODAyMTFfdmlmICp2aWYsIGJvb2wgZW4pDQogew0KQEAgLTEwMjksMTMgKzEwNTYsNyBAQCBp
bnQgbXQ3NjE1X21jdV9zZXRfYm1jKHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYsDQogCX0gZWxzZSB7
DQogCQlyZXEuYmFzaWMuY29ubl9zdGF0ZSA9IENPTk5fU1RBVEVfRElTQ09OTkVDVDsNCiAJCXJl
cS5iYXNpYy5leHRyYV9pbmZvID0gY3B1X3RvX2xlMTYoRVhUUkFfSU5GT19WRVIpOw0KLQ0KLQkJ
X19tdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LCBNQ1VfRVhUX0NNRF9TVEFfUkVDX1VQREFU
RSwNCi0JCQkJICAgICZyZXEsICh1OCAqKXd0YmxfaGRyIC0gKHU4ICopJnJlcSwgdHJ1ZSk7DQot
DQotCQlyZXR1cm4gX19tdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LCBNQ1VfRVhUX0NNRF9X
VEJMX1VQREFURSwNCi0JCQkJCSAgICh1OCAqKXd0YmxfaGRyLCBidWYgLSAodTggKil3dGJsX2hk
ciwNCi0JCQkJCSAgIHRydWUpOw0KKwkJZ290byBvdXQ7DQogCX0NCiANCiAJd3RibF9nID0gKHN0
cnVjdCB3dGJsX2dlbmVyaWMgKilidWY7DQpAQCAtMTA1NSwxMSArMTA3Niw5IEBAIGludCBtdDc2
MTVfbWN1X3NldF9ibWMoc3RydWN0IG10NzYxNV9kZXYgKmRldiwNCiANCiAJd3RibF9oZHItPnRs
dl9udW0gPSBjcHVfdG9fbGUxNigyKTsNCiANCi0JX19tdDc2X21jdV9zZW5kX21zZygmZGV2LT5t
dDc2LCBNQ1VfRVhUX0NNRF9XVEJMX1VQREFURSwNCi0JCQkgICAgKHU4ICopd3RibF9oZHIsIGJ1
ZiAtICh1OCAqKXd0YmxfaGRyLCB0cnVlKTsNCi0NCi0JcmV0dXJuIF9fbXQ3Nl9tY3Vfc2VuZF9t
c2coJmRldi0+bXQ3NiwgTUNVX0VYVF9DTURfU1RBX1JFQ19VUERBVEUsDQotCQkJCSAgICZyZXEs
ICh1OCAqKXd0YmxfaGRyIC0gKHU4ICopJnJlcSwgdHJ1ZSk7DQorb3V0Og0KKwlyZXR1cm4gbXQ3
NjE1X21jdV9zZW5kX3N0YV9yZWMoZGV2LCAodTggKikmcmVxLCAodTggKil3dGJsX2hkciwNCisJ
CQkJICAgICAgIGJ1ZiAtICh1OCAqKXd0YmxfaGRyLCBlbik7DQogfQ0KIA0KIGludCBtdDc2MTVf
bWN1X3NldF9zdGEoc3RydWN0IG10NzYxNV9kZXYgKmRldiwgc3RydWN0IGllZWU4MDIxMV92aWYg
KnZpZiwNCkBAIC0xMDc2LDcgKzEwOTUsNiBAQCBpbnQgbXQ3NjE1X21jdV9zZXRfc3RhKHN0cnVj
dCBtdDc2MTVfZGV2ICpkZXYsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQogCQkuaGRyID0g
ew0KIAkJCS5ic3NfaWR4ID0gbXZpZi0+aWR4LA0KIAkJCS53bGFuX2lkeCA9IG1zdGEtPndjaWQu
aWR4LA0KLQkJCS50bHZfbnVtID0gY3B1X3RvX2xlMTYoMSksDQogCQkJLmlzX3Rsdl9hcHBlbmQg
PSAxLA0KIAkJCS5tdWFyX2lkeCA9IG12aWYtPm9tYWNfaWR4LA0KIAkJfSwNCkBAIC0xMTE1LDQ5
ICsxMTMzLDM4IEBAIGludCBtdDc2MTVfbWN1X3NldF9zdGEoc3RydWN0IG10NzYxNV9kZXYgKmRl
diwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCiAJCXJlcS5iYXNpYy5jb25uX3N0YXRlID0g
Q09OTl9TVEFURV9QT1JUX1NFQ1VSRTsNCiAJCXJlcS5iYXNpYy5leHRyYV9pbmZvID0gY3B1X3Rv
X2xlMTYoRVhUUkFfSU5GT19WRVIgfA0KIAkJCQkJCSAgIEVYVFJBX0lORk9fTkVXKTsNCi0JfSBl
bHNlIHsNCi0JCXJlcS5iYXNpYy5jb25uX3N0YXRlID0gQ09OTl9TVEFURV9ESVNDT05ORUNUOw0K
LQkJcmVxLmJhc2ljLmV4dHJhX2luZm8gPSBjcHVfdG9fbGUxNihFWFRSQV9JTkZPX1ZFUik7DQot
DQotCQkvKiB3dGJsIHJlc2V0ICovDQotCQl3dGJsX2hkciA9IChzdHJ1Y3Qgd3RibF9yZXFfaGRy
ICopYnVmOw0KLQkJYnVmICs9IHNpemVvZigqd3RibF9oZHIpOw0KLQkJd3RibF9oZHItPndsYW5f
aWR4ID0gbXN0YS0+d2NpZC5pZHg7DQotCQl3dGJsX2hkci0+b3BlcmF0aW9uID0gV1RCTF9SRVNF
VF9BTkRfU0VUOw0KLQ0KLQkJX19tdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LCBNQ1VfRVhU
X0NNRF9TVEFfUkVDX1VQREFURSwNCi0JCQkJICAgICZyZXEsIHJlcS5idWYgLSAodTggKikmcmVx
LCB0cnVlKTsNCi0NCi0JCXJldHVybiBfX210NzZfbWN1X3NlbmRfbXNnKCZkZXYtPm10NzYsIE1D
VV9FWFRfQ01EX1dUQkxfVVBEQVRFLA0KLQkJCQkJICAgcmVxLmJ1ZiwgYnVmIC0gcmVxLmJ1Ziwg
dHJ1ZSk7DQotCX0NCi0NCi0JLyogc3RhX3JlYyBodCAqLw0KLQlpZiAoc3RhLT5odF9jYXAuaHRf
c3VwcG9ydGVkKSB7DQotCQlzdHJ1Y3Qgc3RhX3JlY19odCAqc3RhX2h0Ow0KIA0KLQkJc3RhX2h0
ID0gKHN0cnVjdCBzdGFfcmVjX2h0ICopYnVmOw0KLQkJYnVmICs9IHNpemVvZigqc3RhX2h0KTsN
Ci0JCXN0YV9odC0+dGFnID0gY3B1X3RvX2xlMTYoU1RBX1JFQ19IVCk7DQotCQlzdGFfaHQtPmxl
biA9IGNwdV90b19sZTE2KHNpemVvZigqc3RhX2h0KSk7DQotCQlzdGFfaHQtPmh0X2NhcCA9IGNw
dV90b19sZTE2KHN0YS0+aHRfY2FwLmNhcCk7DQotCQlzdGx2Kys7DQorCQkvKiBzdGFfcmVjIGh0
ICovDQorCQlpZiAoc3RhLT5odF9jYXAuaHRfc3VwcG9ydGVkKSB7DQorCQkJc3RydWN0IHN0YV9y
ZWNfaHQgKnN0YV9odDsNCiANCi0JCS8qIHN0YV9yZWMgdmh0ICovDQotCQlpZiAoc3RhLT52aHRf
Y2FwLnZodF9zdXBwb3J0ZWQpIHsNCi0JCQlzdHJ1Y3Qgc3RhX3JlY192aHQgKnN0YV92aHQ7DQot
DQotCQkJc3RhX3ZodCA9IChzdHJ1Y3Qgc3RhX3JlY192aHQgKilidWY7DQotCQkJYnVmICs9IHNp
emVvZigqc3RhX3ZodCk7DQotCQkJc3RhX3ZodC0+dGFnID0gY3B1X3RvX2xlMTYoU1RBX1JFQ19W
SFQpOw0KLQkJCXN0YV92aHQtPmxlbiA9IGNwdV90b19sZTE2KHNpemVvZigqc3RhX3ZodCkpOw0K
LQkJCXN0YV92aHQtPnZodF9jYXAgPSBjcHVfdG9fbGUzMihzdGEtPnZodF9jYXAuY2FwKTsNCi0J
CQlzdGFfdmh0LT52aHRfcnhfbWNzX21hcCA9DQotCQkJCXN0YS0+dmh0X2NhcC52aHRfbWNzLnJ4
X21jc19tYXA7DQotCQkJc3RhX3ZodC0+dmh0X3R4X21jc19tYXAgPQ0KLQkJCQlzdGEtPnZodF9j
YXAudmh0X21jcy50eF9tY3NfbWFwOw0KKwkJCXN0YV9odCA9IChzdHJ1Y3Qgc3RhX3JlY19odCAq
KWJ1ZjsNCisJCQlidWYgKz0gc2l6ZW9mKCpzdGFfaHQpOw0KKwkJCXN0YV9odC0+dGFnID0gY3B1
X3RvX2xlMTYoU1RBX1JFQ19IVCk7DQorCQkJc3RhX2h0LT5sZW4gPSBjcHVfdG9fbGUxNihzaXpl
b2YoKnN0YV9odCkpOw0KKwkJCXN0YV9odC0+aHRfY2FwID0gY3B1X3RvX2xlMTYoc3RhLT5odF9j
YXAuY2FwKTsNCiAJCQlzdGx2Kys7DQorDQorCQkJLyogc3RhX3JlYyB2aHQgKi8NCisJCQlpZiAo
c3RhLT52aHRfY2FwLnZodF9zdXBwb3J0ZWQpIHsNCisJCQkJc3RydWN0IHN0YV9yZWNfdmh0ICpz
dGFfdmh0Ow0KKw0KKwkJCQlzdGFfdmh0ID0gKHN0cnVjdCBzdGFfcmVjX3ZodCAqKWJ1ZjsNCisJ
CQkJYnVmICs9IHNpemVvZigqc3RhX3ZodCk7DQorCQkJCXN0YV92aHQtPnRhZyA9IGNwdV90b19s
ZTE2KFNUQV9SRUNfVkhUKTsNCisJCQkJc3RhX3ZodC0+bGVuID0gY3B1X3RvX2xlMTYoc2l6ZW9m
KCpzdGFfdmh0KSk7DQorCQkJCXN0YV92aHQtPnZodF9jYXAgPQ0KKwkJCQkJY3B1X3RvX2xlMzIo
c3RhLT52aHRfY2FwLmNhcCk7DQorCQkJCXN0YV92aHQtPnZodF9yeF9tY3NfbWFwID0NCisJCQkJ
CXN0YS0+dmh0X2NhcC52aHRfbWNzLnJ4X21jc19tYXA7DQorCQkJCXN0YV92aHQtPnZodF90eF9t
Y3NfbWFwID0NCisJCQkJCXN0YS0+dmh0X2NhcC52aHRfbWNzLnR4X21jc19tYXA7DQorCQkJCXN0
bHYrKzsNCisJCQl9DQogCQl9DQorCX0gZWxzZSB7DQorCQlyZXEuYmFzaWMuY29ubl9zdGF0ZSA9
IENPTk5fU1RBVEVfRElTQ09OTkVDVDsNCisJCXJlcS5iYXNpYy5leHRyYV9pbmZvID0gY3B1X3Rv
X2xlMTYoRVhUUkFfSU5GT19WRVIpOw0KIAl9DQogDQogCS8qIHd0YmwgKi8NCkBAIC0xMTY2LDYg
KzExNzMsOSBAQCBpbnQgbXQ3NjE1X21jdV9zZXRfc3RhKHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYs
IHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQogCXd0YmxfaGRyLT53bGFuX2lkeCA9IG1zdGEt
PndjaWQuaWR4Ow0KIAl3dGJsX2hkci0+b3BlcmF0aW9uID0gV1RCTF9SRVNFVF9BTkRfU0VUOw0K
IA0KKwlpZiAoIWVuKQ0KKwkJZ290byBvdXQ7DQorDQogCXd0YmxfZyA9IChzdHJ1Y3Qgd3RibF9n
ZW5lcmljICopYnVmOw0KIAlidWYgKz0gc2l6ZW9mKCp3dGJsX2cpOw0KIAl3dGJsX2ctPnRhZyA9
IGNwdV90b19sZTE2KFdUQkxfR0VORVJJQyk7DQpAQCAtMTI1MiwxNCArMTI2MiwxMiBAQCBpbnQg
bXQ3NjE1X21jdV9zZXRfc3RhKHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYsIHN0cnVjdCBpZWVlODAy
MTFfdmlmICp2aWYsDQogCQl3dGx2Kys7DQogCX0NCiANCitvdXQ6DQogCXd0YmxfaGRyLT50bHZf
bnVtID0gY3B1X3RvX2xlMTYod3Rsdik7DQogCXJlcS5oZHIudGx2X251bSA9IGNwdV90b19sZTE2
KHN0bHYpOw0KIA0KLQlfX210NzZfbWN1X3NlbmRfbXNnKCZkZXYtPm10NzYsIE1DVV9FWFRfQ01E
X1dUQkxfVVBEQVRFLCAodTggKil3dGJsX2hkciwNCi0JCQkgICAgYnVmIC0gKHU4ICopd3RibF9o
ZHIsIHRydWUpOw0KLQ0KLQlyZXR1cm4gX19tdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LCBN
Q1VfRVhUX0NNRF9TVEFfUkVDX1VQREFURSwNCi0JCQkJICAgJnJlcSwgKHU4ICopd3RibF9oZHIg
LSAodTggKikmcmVxLCB0cnVlKTsNCisJcmV0dXJuIG10NzYxNV9tY3Vfc2VuZF9zdGFfcmVjKGRl
diwgKHU4ICopJnJlcSwgKHU4ICopd3RibF9oZHIsDQorCQkJCSAgICAgICBidWYgLSAodTggKil3
dGJsX2hkciwgZW4pOw0KIH0NCiANCiBpbnQgbXQ3NjE1X21jdV9zZXRfYmNuKHN0cnVjdCBpZWVl
ODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KLS0gDQoyLjE4LjANCg==

