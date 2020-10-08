Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CE9287A6C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgJHQ5p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 12:57:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45007 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729402AbgJHQ5p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 12:57:45 -0400
X-UUID: 88827db169d945dab300e95322c4a702-20201009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vB60bkKivbIghJ/O1u+Kwt4O/FxKdZHQa4QAp7QJNLE=;
        b=pDNR7rFD08SH81tiLpOS0qHWi68IobGDm9auib+2t86+vPC7DfkPfxbW+Gh/VUbiKE7B5TfRTgbHFin3VQP3dIJSUD4Sw9bYfRzCvazQBgDJOLUd2bOtlMeutKc0x7Nz9ZOShk8Hd9/a91M3lQxtMewASv+jvpJeLF7PhH10P3c=;
X-UUID: 88827db169d945dab300e95322c4a702-20201009
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 497383600; Fri, 09 Oct 2020 00:57:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Oct 2020 00:57:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Oct 2020 00:57:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] mt76: mt7915: rename mt7915_mcu_get_rate_info to mt7915_mcu_get_tx_rate
Date:   Fri, 9 Oct 2020 00:57:36 +0800
Message-ID: <6c4f3c9146c3a6b5657780961a5cf78413c017a1.1602175329.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <e1beae5f3177c82fa73635a8a96fa95be609149e.1602175329.git.ryder.lee@mediatek.com>
References: <e1beae5f3177c82fa73635a8a96fa95be609149e.1602175329.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QXZvaWQgY29uZnVzaW9uIHdpdGggcnggcmF0ZSBxdWVyeSBmdW5jdGlvbi4NCg0KU2lnbmVkLW9m
Zi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTog
U2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KY2hhbmdlIHNpbmNl
IHYyIC1yZWJhc2Ugb24gdG9wIG9mIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gv
MTE4MDg5NjEvDQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzkx
NS9tYWMuYyAgICB8ICAyICstDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5MTUvbWN1LmMgICAgfCAxMCArKysrKy0tLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmggfCAgMiArLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWMuYw0KaW5kZXggYTcxMThkZjdiOTNmLi41MjFkMGMy
ZjZjMjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzkxNS9tYWMuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWFjLmMNCkBAIC0xNDIyLDcgKzE0MjIsNyBAQCBtdDc5MTVfbWFjX3N0YV9zdGF0c193b3Jr
KHN0cnVjdCBtdDc5MTVfcGh5ICpwaHkpDQogCQlzcGluX3VubG9ja19iaCgmZGV2LT5zdGFfcG9s
bF9sb2NrKTsNCiANCiAJCS8qIHVzZSBNVF9UWF9GUkVFX1JBVEUgdG8gcmVwb3J0IFR4IHJhdGUg
Zm9yIGZ1cnRoZXIgZGV2aWNlcyAqLw0KLQkJbXQ3OTE1X21jdV9nZXRfcmF0ZV9pbmZvKGRldiwg
UkFURV9DVFJMX1JVX0lORk8sIG1zdGEtPndjaWQuaWR4KTsNCisJCW10NzkxNV9tY3VfZ2V0X3R4
X3JhdGUoZGV2LCBSQVRFX0NUUkxfUlVfSU5GTywgbXN0YS0+d2NpZC5pZHgpOw0KIA0KIAkJc3Bp
bl9sb2NrX2JoKCZkZXYtPnN0YV9wb2xsX2xvY2spOw0KIAl9DQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KaW5kZXggZGRlMDUzYTc2MjYxLi5j
ZTIzNTc1NTAwMTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tY3UuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvbWN1LmMNCkBAIC0zNTIsOCArMzUyLDggQEAgbXQ3OTE1X21jdV9yeF9yYWRhcl9k
ZXRlY3RlZChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KIH0N
CiANCiBzdGF0aWMgdm9pZA0KLW10NzkxNV9tY3VfdHhfcmF0ZV9jYWwoc3RydWN0IG10NzZfcGh5
ICptcGh5LCBzdHJ1Y3QgbXQ3OTE1X21jdV9yYV9pbmZvICpyYSwNCi0JCSAgICAgICBzdHJ1Y3Qg
cmF0ZV9pbmZvICpyYXRlLCB1MTYgcikNCittdDc5MTVfbWN1X3R4X3JhdGVfcGFyc2Uoc3RydWN0
IG10NzZfcGh5ICptcGh5LCBzdHJ1Y3QgbXQ3OTE1X21jdV9yYV9pbmZvICpyYSwNCisJCQkgc3Ry
dWN0IHJhdGVfaW5mbyAqcmF0ZSwgdTE2IHIpDQogew0KIAlzdHJ1Y3QgaWVlZTgwMjExX3N1cHBv
cnRlZF9iYW5kICpzYmFuZDsNCiAJdTE2IHJ1X2lkeCA9IGxlMTZfdG9fY3B1KHJhLT5ydV9pZHgp
Ow0KQEAgLTQ2NSwxMSArNDY1LDExIEBAIG10NzkxNV9tY3VfdHhfcmF0ZV9yZXBvcnQoc3RydWN0
IG10NzkxNV9kZXYgKmRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCiAJCW1waHkgPSBkZXYtPm10
NzYucGh5MjsNCiANCiAJLyogY3VycmVudCByYXRlICovDQotCW10NzkxNV9tY3VfdHhfcmF0ZV9j
YWwobXBoeSwgcmEsICZyYXRlLCBjdXJyKTsNCisJbXQ3OTE1X21jdV90eF9yYXRlX3BhcnNlKG1w
aHksIHJhLCAmcmF0ZSwgY3Vycik7DQogCXN0YXRzLT50eF9yYXRlID0gcmF0ZTsNCiANCiAJLyog
cHJvYmluZyByYXRlICovDQotCW10NzkxNV9tY3VfdHhfcmF0ZV9jYWwobXBoeSwgcmEsICZwcm9i
X3JhdGUsIHByb2JlKTsNCisJbXQ3OTE1X21jdV90eF9yYXRlX3BhcnNlKG1waHksIHJhLCAmcHJv
Yl9yYXRlLCBwcm9iZSk7DQogCXN0YXRzLT5wcm9iX3JhdGUgPSBwcm9iX3JhdGU7DQogDQogCWlm
IChhdHRlbXB0cykgew0KQEAgLTMyNjAsNyArMzI2MCw3IEBAIGludCBtdDc5MTVfbWN1X2dldF90
ZW1wZXJhdHVyZShzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBpbnQgaW5kZXgpDQogCQkJCSBzaXpl
b2YocmVxKSwgdHJ1ZSk7DQogfQ0KIA0KLWludCBtdDc5MTVfbWN1X2dldF9yYXRlX2luZm8oc3Ry
dWN0IG10NzkxNV9kZXYgKmRldiwgdTMyIGNtZCwgdTE2IHdsYW5faWR4KQ0KK2ludCBtdDc5MTVf
bWN1X2dldF90eF9yYXRlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHUzMiBjbWQsIHUxNiB3bGFu
X2lkeCkNCiB7DQogCXN0cnVjdCB7DQogCQlfX2xlMzIgY21kOw0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5oIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmgNCmluZGV4IDBlYTM5NjVj
MjhmNS4uODljYWJkYTY0ZjQxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5oDQpAQCAtMzE5LDggKzMxOSw4IEBAIGludCBtdDc5
MTVfbWN1X3NldF9wdWxzZV90aChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LA0KIAkJCSAgICBjb25z
dCBzdHJ1Y3QgbXQ3OTE1X2Rmc19wdWxzZSAqcHVsc2UpOw0KIGludCBtdDc5MTVfbWN1X3NldF9y
YWRhcl90aChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBpbnQgaW5kZXgsDQogCQkJICAgIGNvbnN0
IHN0cnVjdCBtdDc5MTVfZGZzX3BhdHRlcm4gKnBhdHRlcm4pOw0KLWludCBtdDc5MTVfbWN1X2dl
dF9yYXRlX2luZm8oc3RydWN0IG10NzkxNV9kZXYgKmRldiwgdTMyIGNtZCwgdTE2IHdsYW5faWR4
KTsNCiBpbnQgbXQ3OTE1X21jdV9nZXRfdGVtcGVyYXR1cmUoc3RydWN0IG10NzkxNV9kZXYgKmRl
diwgaW50IGluZGV4KTsNCitpbnQgbXQ3OTE1X21jdV9nZXRfdHhfcmF0ZShzdHJ1Y3QgbXQ3OTE1
X2RldiAqZGV2LCB1MzIgY21kLCB1MTYgd2xhbl9pZHgpOw0KIGludCBtdDc5MTVfbWN1X2dldF9y
eF9yYXRlKHN0cnVjdCBtdDc5MTVfcGh5ICpwaHksIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYs
DQogCQkJICAgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSwgc3RydWN0IHJhdGVfaW5mbyAqcmF0
ZSk7DQogaW50IG10NzkxNV9tY3VfcmRkX2NtZChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBlbnVt
IG10NzkxNV9yZGRfY21kIGNtZCwNCi0tIA0KMi4xOC4wDQo=

