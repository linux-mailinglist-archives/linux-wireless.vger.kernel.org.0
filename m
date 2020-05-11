Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E2D1CDFF8
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgEKQGt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 12:06:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42083 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730627AbgEKQGs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 12:06:48 -0400
X-UUID: c8f74522345a4f9686a976f2769e5237-20200512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Wq5vNatoLxOl6u7ea0lqUPIpt436Lkik0iyxAITq0lQ=;
        b=dLE8vyDvcHmU/59gDORDAbVRxzDTLbBBFrKjbv/hJlO8GL772Dp6q0rJabbraGd7pUGK0HfT3mIFq98GDOozndlNn6OgvcjEBD2xnuAlbOukSdD7Gwi3BTlzZWGyZupvdrMGu7teIrsyLSSwW3sDkhYq2DrdhgYqKxkIDR76TmE=;
X-UUID: c8f74522345a4f9686a976f2769e5237-20200512
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 12457636; Tue, 12 May 2020 00:06:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 May 2020 00:06:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 May 2020 00:06:41 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 6/7] mt76: mt7915: allocate proper size for tlv tags
Date:   Tue, 12 May 2020 00:06:37 +0800
Message-ID: <2952abbe3b1f47fdf48de37b36af5aed34c03c05.1589212457.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1589212457.git.ryder.lee@mediatek.com>
References: <cover.1589212457.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AD9E4E709F0B02E3936059A6C03D0ADDD4AA97E3B1F282A1A87AB3FEC3CDAC802000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWxsb2NhdGluZyBwcm9wZXIgbWVtb3J5IHNpemUgYWNjb3JkaW5nIHRvIHRsdiB1c2FnZS4NCg0K
U2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMgfCAxNCArKysr
KysrLS0tLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21j
dS5oIHwgMTIgKysrKysrKysrKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tY3UuYw0KaW5kZXggNTJlMzQ5YjE3MjQ2Li5mMDBhZDJiNjY3NjEgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0K
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCkBA
IC05OTcsNyArOTk3LDcgQEAgaW50IG10NzkxNV9tY3VfYWRkX2Jzc19pbmZvKHN0cnVjdCBtdDc5
MTVfcGh5ICpwaHksDQogCXN0cnVjdCBza19idWZmICpza2I7DQogDQogCXNrYiA9IG10NzkxNV9t
Y3VfYWxsb2Nfc3RhX3JlcShwaHktPmRldiwgbXZpZiwgTlVMTCwNCi0JCQkJICAgICAgIE1UNzkx
NV9TVEFfVVBEQVRFX01BWF9TSVpFKTsNCisJCQkJICAgICAgIE1UNzkxNV9CU1NfVVBEQVRFX01B
WF9TSVpFKTsNCiAJaWYgKElTX0VSUihza2IpKQ0KIAkJcmV0dXJuIFBUUl9FUlIoc2tiKTsNCiAN
CkBAIC0xMDkyLDEwICsxMDkyLDEwIEBAIGludCBtdDc5MTVfbWN1X2FkZF9rZXkoc3RydWN0IG10
NzkxNV9kZXYgKmRldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCiB7DQogCXN0cnVjdCBt
dDc5MTVfdmlmICptdmlmID0gKHN0cnVjdCBtdDc5MTVfdmlmICopdmlmLT5kcnZfcHJpdjsNCiAJ
c3RydWN0IHNrX2J1ZmYgKnNrYjsNCisJaW50IGxlbiA9IHNpemVvZihzdHJ1Y3Qgc3RhX3JlcV9o
ZHIpICsgc2l6ZW9mKHN0cnVjdCBzdGFfcmVjX3NlYyk7DQogCWludCByZXQ7DQogDQotCXNrYiA9
IG10NzkxNV9tY3VfYWxsb2Nfc3RhX3JlcShkZXYsIG12aWYsIG1zdGEsDQotCQkJCSAgICAgICBN
VDc5MTVfU1RBX1VQREFURV9NQVhfU0laRSk7DQorCXNrYiA9IG10NzkxNV9tY3VfYWxsb2Nfc3Rh
X3JlcShkZXYsIG12aWYsIG1zdGEsIGxlbik7DQogCWlmIChJU19FUlIoc2tiKSkNCiAJCXJldHVy
biBQVFJfRVJSKHNrYik7DQogDQpAQCAtMjA1Niw5ICsyMDU2LDkgQEAgaW50IG10NzkxNV9tY3Vf
YWRkX3JhdGVfY3RybChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBzdHJ1Y3QgaWVlZTgwMjExX3Zp
ZiAqdmlmLA0KIAlzdHJ1Y3QgbXQ3OTE1X3ZpZiAqbXZpZiA9IChzdHJ1Y3QgbXQ3OTE1X3ZpZiAq
KXZpZi0+ZHJ2X3ByaXY7DQogCXN0cnVjdCBtdDc5MTVfc3RhICptc3RhID0gKHN0cnVjdCBtdDc5
MTVfc3RhICopc3RhLT5kcnZfcHJpdjsNCiAJc3RydWN0IHNrX2J1ZmYgKnNrYjsNCisJaW50IGxl
biA9IHNpemVvZihzdHJ1Y3Qgc3RhX3JlcV9oZHIpICsgc2l6ZW9mKHN0cnVjdCBzdGFfcmVjX3Jh
KTsNCiANCi0Jc2tiID0gbXQ3OTE1X21jdV9hbGxvY19zdGFfcmVxKGRldiwgbXZpZiwgbXN0YSwN
Ci0JCQkJICAgICAgIE1UNzkxNV9TVEFfVVBEQVRFX01BWF9TSVpFKTsNCisJc2tiID0gbXQ3OTE1
X21jdV9hbGxvY19zdGFfcmVxKGRldiwgbXZpZiwgbXN0YSwgbGVuKTsNCiAJaWYgKElTX0VSUihz
a2IpKQ0KIAkJcmV0dXJuIFBUUl9FUlIoc2tiKTsNCiANCkBAIC0yMTI5LDkgKzIxMjksOSBAQCBp
bnQgbXQ3OTE1X21jdV9zZXRfZml4ZWRfcmF0ZShzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LA0KIAlz
dHJ1Y3Qgc3RhX3JlY19yYV9maXhlZCAqcmE7DQogCXN0cnVjdCBza19idWZmICpza2I7DQogCXN0
cnVjdCB0bHYgKnRsdjsNCisJaW50IGxlbiA9IHNpemVvZihzdHJ1Y3Qgc3RhX3JlcV9oZHIpICsg
c2l6ZW9mKCpyYSk7DQogDQotCXNrYiA9IG10NzkxNV9tY3VfYWxsb2Nfc3RhX3JlcShkZXYsIG12
aWYsIG1zdGEsDQotCQkJCSAgICAgICBNVDc5MTVfU1RBX1VQREFURV9NQVhfU0laRSk7DQorCXNr
YiA9IG10NzkxNV9tY3VfYWxsb2Nfc3RhX3JlcShkZXYsIG12aWYsIG1zdGEsIGxlbik7DQogCWlm
IChJU19FUlIoc2tiKSkNCiAJCXJldHVybiBQVFJfRVJSKHNrYik7DQogDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmggYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuaA0KaW5kZXggY2RlYmE1YTBl
ZjM0Li4zNGFjZTZlNjcyZDAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9tY3UuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MTUvbWN1LmgNCkBAIC05NTEsMTMgKzk1MSwyMSBAQCBlbnVtIHsNCiAJCQkJ
CSBzaXplb2Yoc3RydWN0IHN0YV9yZWNfdmh0KSArCVwNCiAJCQkJCSBzaXplb2Yoc3RydWN0IHRs
dikgKwkJXA0KIAkJCQkJIHNpemVvZihzdHJ1Y3Qgc3RhX3JlY19tdXJ1KSArCVwNCi0JCQkJCSBz
aXplb2Yoc3RydWN0IHN0YV9yZWNfc2VjKSArCVwNCi0JCQkJCSBzaXplb2Yoc3RydWN0IHN0YV9y
ZWNfcmEpICsJXA0KIAkJCQkJIE1UNzkxNV9XVEJMX1VQREFURV9NQVhfU0laRSkNCiANCiAjZGVm
aW5lIE1UNzkxNV9XVEJMX1VQREFURV9CQV9TSVpFCShzaXplb2Yoc3RydWN0IHd0YmxfcmVxX2hk
cikgKwlcDQogCQkJCQkgc2l6ZW9mKHN0cnVjdCB3dGJsX2JhKSkNCiANCisjZGVmaW5lIE1UNzkx
NV9CU1NfVVBEQVRFX01BWF9TSVpFCShzaXplb2Yoc3RydWN0IHN0YV9yZXFfaGRyKSArCVwNCisJ
CQkJCSBzaXplb2Yoc3RydWN0IGJzc19pbmZvX29tYWMpICsJXA0KKwkJCQkJIHNpemVvZihzdHJ1
Y3QgYnNzX2luZm9fYmFzaWMpICtcDQorCQkJCQkgc2l6ZW9mKHN0cnVjdCBic3NfaW5mb19yZl9j
aCkgK1wNCisJCQkJCSBzaXplb2Yoc3RydWN0IGJzc19pbmZvX3JhKSArCVwNCisJCQkJCSBzaXpl
b2Yoc3RydWN0IGJzc19pbmZvX2hlKSArCVwNCisJCQkJCSBzaXplb2Yoc3RydWN0IGJzc19pbmZv
X2JtY19yYXRlKSArXA0KKwkJCQkJIHNpemVvZihzdHJ1Y3QgYnNzX2luZm9fZXh0X2JzcykgK1wN
CisJCQkJCSBzaXplb2Yoc3RydWN0IGJzc19pbmZvX3N5bmNfbW9kZSkpDQorDQogI2RlZmluZSBN
VDc5MTVfQkVBQ09OX1VQREFURV9TSVpFCShzaXplb2Yoc3RydWN0IHN0YV9yZXFfaGRyKSArCVwN
CiAJCQkJCSBzaXplb2Yoc3RydWN0IGJzc19pbmZvX2Jjbl9jc2EpICsgXA0KIAkJCQkJIHNpemVv
ZihzdHJ1Y3QgYnNzX2luZm9fYmNuX2JjYykgKyBcDQotLSANCjIuMTguMA0K

