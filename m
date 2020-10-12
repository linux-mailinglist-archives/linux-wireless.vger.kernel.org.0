Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50128AC71
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 05:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgJLD0e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Oct 2020 23:26:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54570 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726371AbgJLD0e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Oct 2020 23:26:34 -0400
X-UUID: a1155154aa1a4a69bc7abeb4487fc605-20201012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1C3zflfx2s+KzWYaoiZsMJZCys0IJqzAQ1/HIbiKSH4=;
        b=LrtCxUQodyQApQ8B+pqUs+z8j7R8XaS5Qcl+nu8JLL7RzUEHMdFOEtOs4eCowg54GKDJ5Nd7j9X63D7O6jgwggijNq/qgETEZprzcL+olovjaDKPVpnOtZ9A58h1ClSJVMx7cTcVxO0JabFq8HarXItrzSVE6QpHAqIaQsFw9A4=;
X-UUID: a1155154aa1a4a69bc7abeb4487fc605-20201012
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 560125108; Mon, 12 Oct 2020 11:26:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Oct 2020 11:26:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 11:26:25 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 06/10] mt76: testmode: add support for HE rate modes
Date:   Mon, 12 Oct 2020 11:25:34 +0800
Message-ID: <20201012032538.21314-6-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201012032538.21314-1-shayne.chen@mediatek.com>
References: <20201012032538.21314-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 09CC6FF2875DF2C761E7C19B27DC23A6E7DAC8E7C99941BBD19E3BBBE80905B82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RXh0ZW5kIGVudW0gbXQ3Nl90ZXN0bW9kZV90eF9tb2RlIHRvIHN1cHBvcnQgdmFyaW91cyBIRSBy
YXRlIG1vZGVzLg0KDQpSZXZpZXdlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsu
Y29tPg0KU2lnbmVkLW9mZi1ieTogU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvdGVzdG1vZGUuYyB8
IDYgKysrKystDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90ZXN0bW9kZS5o
IHwgOCArKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni90ZXN0bW9kZS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90ZXN0bW9k
ZS5jDQppbmRleCBmMzdhNDYwLi5kMWIxNzE2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90ZXN0bW9kZS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L3Rlc3Rtb2RlLmMNCkBAIC04NCw2ICs4NCwxMCBAQCBtdDc2X3Rlc3Rt
b2RlX3R4X2luaXQoc3RydWN0IG10NzZfZGV2ICpkZXYpDQogCWluZm8tPmZsYWdzID0gSUVFRTgw
MjExX1RYX0NUTF9JTkpFQ1RFRCB8DQogCQkgICAgICBJRUVFODAyMTFfVFhfQ1RMX05PX0FDSyB8
DQogCQkgICAgICBJRUVFODAyMTFfVFhfQ1RMX05PX1BTX0JVRkZFUjsNCisNCisJaWYgKHRkLT50
eF9yYXRlX21vZGUgPiBNVDc2X1RNX1RYX01PREVfVkhUKQ0KKwkJZ290byBvdXQ7DQorDQogCXJh
dGUgPSAmaW5mby0+Y29udHJvbC5yYXRlc1swXTsNCiAJcmF0ZS0+Y291bnQgPSAxOw0KIAlyYXRl
LT5pZHggPSB0ZC0+dHhfcmF0ZV9pZHg7DQpAQCAtMTUyLDcgKzE1Niw3IEBAIG10NzZfdGVzdG1v
ZGVfdHhfaW5pdChzdHJ1Y3QgbXQ3Nl9kZXYgKmRldikNCiAJCQlicmVhazsNCiAJCX0NCiAJfQ0K
LQ0KK291dDoNCiAJc2tiX3NldF9xdWV1ZV9tYXBwaW5nKHNrYiwgSUVFRTgwMjExX0FDX0JFKTsN
CiANCiAJcmV0dXJuIDA7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni90ZXN0bW9kZS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90
ZXN0bW9kZS5oDQppbmRleCAzYzA5YWE1Li43ZWZhZDY4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90ZXN0bW9kZS5oDQorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L3Rlc3Rtb2RlLmgNCkBAIC0xNDcsMTIgKzE0NywyMCBAQCBl
bnVtIG10NzZfdGVzdG1vZGVfc3RhdGUgew0KICAqIEBNVDc2X1RNX1RYX01PREVfT0ZETTogbGVn
YWN5IE9GRE0gbW9kZQ0KICAqIEBNVDc2X1RNX1RYX01PREVfSFQ6IDgwMi4xMW4gTUNTDQogICog
QE1UNzZfVE1fVFhfTU9ERV9WSFQ6IDgwMi4xMWFjIE1DUw0KKyAqIEBNVDc2X1RNX1RYX01PREVf
SEVfU1U6IDgwMi4xMWF4IHNpbmdsZS11c2VyIE1JTU8NCisgKiBATVQ3Nl9UTV9UWF9NT0RFX0hF
X0VYVF9TVTogODAyLjExYXggZXh0ZW5kZWQtcmFuZ2UgU1UNCisgKiBATVQ3Nl9UTV9UWF9NT0RF
X0hFX1RCOiA4MDIuMTFheCB0cmlnZ2VyLWJhc2VkDQorICogQE1UNzZfVE1fVFhfTU9ERV9IRV9N
VTogODAyLjExYXggbXVsdGktdXNlciBNSU1PDQogICovDQogZW51bSBtdDc2X3Rlc3Rtb2RlX3R4
X21vZGUgew0KIAlNVDc2X1RNX1RYX01PREVfQ0NLLA0KIAlNVDc2X1RNX1RYX01PREVfT0ZETSwN
CiAJTVQ3Nl9UTV9UWF9NT0RFX0hULA0KIAlNVDc2X1RNX1RYX01PREVfVkhULA0KKwlNVDc2X1RN
X1RYX01PREVfSEVfU1UsDQorCU1UNzZfVE1fVFhfTU9ERV9IRV9FWFRfU1UsDQorCU1UNzZfVE1f
VFhfTU9ERV9IRV9UQiwNCisJTVQ3Nl9UTV9UWF9NT0RFX0hFX01VLA0KIA0KIAkvKiBrZWVwIGxh
c3QgKi8NCiAJTlVNX01UNzZfVE1fVFhfTU9ERVMsDQotLSANCjIuMTcuMQ0K

