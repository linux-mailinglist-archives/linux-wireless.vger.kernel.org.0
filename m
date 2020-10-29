Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E76329F2B3
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 18:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgJ2RLX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 13:11:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42683 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgJ2RLX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 13:11:23 -0400
X-UUID: 82bfba6bb00e449f8301719a8ab6430e-20201030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1Y/zeZh6Q1NIhynx9eUjorVoZ+repOhjvcxYnJbNTQs=;
        b=MPcge86VybdKEUiqo58ZdLv/3lUMa+n5F/KK/qK6dt3k4Qu5grUI5nV/Ivw0BG4jIq/UM3QY0Rh5aSFXttlt2xol16/U33Ooltj54I7pXuiwzSfBmZFQkgmPtc94U9gnblwp7sxvdqXokJ8PkGg88vOVJQlZkzYzX3oTQoJTJBw=;
X-UUID: 82bfba6bb00e449f8301719a8ab6430e-20201030
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 146681960; Fri, 30 Oct 2020 01:11:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Oct 2020 01:11:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Oct 2020 01:11:18 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/3] mt76: mt7915: remove unused mt7915_mcu_bss_sync_tlv()
Date:   Fri, 30 Oct 2020 01:11:16 +0800
Message-ID: <4e10985307260de60fea3fae0b6f41985136082c.1603988327.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <879705a8af8fa44c711feb3aa0351c1138aeef6c.1603988327.git.ryder.lee@mediatek.com>
References: <879705a8af8fa44c711feb3aa0351c1138aeef6c.1603988327.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

bXQ3OTE1X21jdV9ic3Nfc3luY190bHYoKSBpcyBubyBsb25nZXIgdXNlZCwgc28gcmVtb3ZlIGl0
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQot
LS0NCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jICAgfCAxOSAr
Ky0tLS0tLS0tLS0tLS0tLS0tDQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzkx
NS9tY3UuaCAgIHwgMTEgKy0tLS0tLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMjcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L21jdS5jDQppbmRleCAxODM4M2RjZGFmMzUuLmVkNzY3YjI4YWE4NiAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21j
dS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3Uu
Yw0KQEAgLTkzOCwyMCArOTM4LDYgQEAgbXQ3OTE1X21jdV9ic3NfYm1jX3RsdihzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLCBzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5KQ0KIAl9DQogfQ0KIA0KLXN0YXRpYyB2
b2lkDQotbXQ3OTE1X21jdV9ic3Nfc3luY190bHYoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0
IGllZWU4MDIxMV92aWYgKnZpZikNCi17DQotCXN0cnVjdCBic3NfaW5mb19zeW5jX21vZGUgKnN5
bmM7DQotCXN0cnVjdCB0bHYgKnRsdjsNCi0NCi0JdGx2ID0gbXQ3OTE1X21jdV9hZGRfdGx2KHNr
YiwgQlNTX0lORk9fU1lOQ19NT0RFLCBzaXplb2YoKnN5bmMpKTsNCi0NCi0Jc3luYyA9IChzdHJ1
Y3QgYnNzX2luZm9fc3luY19tb2RlICopdGx2Ow0KLQlzeW5jLT5iY25faW50ZXJ2YWwgPSBjcHVf
dG9fbGUxNih2aWYtPmJzc19jb25mLmJlYWNvbl9pbnQpOw0KLQlzeW5jLT5kdGltX3BlcmlvZCA9
IHZpZi0+YnNzX2NvbmYuZHRpbV9wZXJpb2Q7DQotCXN5bmMtPmVuYWJsZSA9IHRydWU7DQotfQ0K
LQ0KIHN0YXRpYyBpbnQNCiBtdDc5MTVfbWN1X211YXJfY29uZmlnKHN0cnVjdCBtdDc5MTVfcGh5
ICpwaHksIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQogCQkgICAgICAgYm9vbCBic3NpZCwg
Ym9vbCBlbmFibGUpDQpAQCAtMTAxOSw5ICsxMDA1LDggQEAgaW50IG10NzkxNV9tY3VfYWRkX2Jz
c19pbmZvKHN0cnVjdCBtdDc5MTVfcGh5ICpwaHksDQogCQlpZiAodmlmLT5ic3NfY29uZi5oZV9z
dXBwb3J0KQ0KIAkJCW10NzkxNV9tY3VfYnNzX2hlX3Rsdihza2IsIHZpZiwgcGh5KTsNCiANCi0J
CWlmIChtdmlmLT5vbWFjX2lkeCA8IEVYVF9CU1NJRF9TVEFSVCkNCi0JCQltdDc5MTVfbWN1X2Jz
c19zeW5jX3Rsdihza2IsIHZpZik7DQotCQllbHNlIGlmIChtdmlmLT5vbWFjX2lkeCA8IFJFUEVB
VEVSX0JTU0lEX1NUQVJUKQ0KKwkJaWYgKG12aWYtPm9tYWNfaWR4ID49IEVYVF9CU1NJRF9TVEFS
VCAmJg0KKwkJICAgIG12aWYtPm9tYWNfaWR4IDwgUkVQRUFURVJfQlNTSURfU1RBUlQpDQogCQkJ
bXQ3OTE1X21jdV9ic3NfZXh0X3Rsdihza2IsIG12aWYpOw0KIAl9DQogDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmggYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuaA0KaW5kZXggNTc0NDZjZDEx
YzQwLi4zZTA0YTFmOTg2Y2MgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9tY3UuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MTUvbWN1LmgNCkBAIC0zODcsMTUgKzM4Nyw2IEBAIHN0cnVjdCBic3NfaW5m
b19leHRfYnNzIHsNCiAJdTggcnN2WzhdOw0KIH0gX19wYWNrZWQ7DQogDQotc3RydWN0IGJzc19p
bmZvX3N5bmNfbW9kZSB7DQotCV9fbGUxNiB0YWc7DQotCV9fbGUxNiBsZW47DQotCV9fbGUxNiBi
Y25faW50ZXJ2YWw7DQotCXU4IGVuYWJsZTsNCi0JdTggZHRpbV9wZXJpb2Q7DQotCXU4IHJzdls4
XTsNCi19IF9fcGFja2VkOw0KLQ0KIHN0cnVjdCBic3NfaW5mb19ibWNfcmF0ZSB7DQogCV9fbGUx
NiB0YWc7DQogCV9fbGUxNiBsZW47DQpAQCAtNTEzLDcgKzUwNCw3IEBAIGVudW0gew0KIAlCU1Nf
SU5GT19MUV9STSwJCS8qIG9ic29sZXRlZCAqLw0KIAlCU1NfSU5GT19FWFRfQlNTLA0KIAlCU1Nf
SU5GT19CTUNfUkFURSwJLyogZm9yIGJtYyByYXRlIGNvbnRyb2wgaW4gQ1I0ICovDQotCUJTU19J
TkZPX1NZTkNfTU9ERSwNCisJQlNTX0lORk9fU1lOQ19NT0RFLAkvKiBvYnNvbGV0ZWQgKi8NCiAJ
QlNTX0lORk9fUkEsDQogCUJTU19JTkZPX0hXX0FNU0RVLA0KIAlCU1NfSU5GT19CU1NfQ09MT1Is
DQotLSANCjIuMTguMA0K

