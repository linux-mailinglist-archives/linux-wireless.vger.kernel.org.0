Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8229565B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 04:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895047AbgJVC2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Oct 2020 22:28:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53853 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2895045AbgJVC2q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Oct 2020 22:28:46 -0400
X-UUID: f80af63315d1490b9343b2a9f0e4d030-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Xc9AEzvVsB14dXFTxBdxWUYms3Pt4khR3WyeScYHvVw=;
        b=jz24tWuQhDkfvxMkjhqrvDRVk+1SXz3k2e24z76TUGQj5AWAEwz85Twdi17XHwJDoRlmhJuuJLVA67uJUr/TC0K6BDatEy8qvsXjR9lFFuQMVDKiGHAtlOlk+Rv5THi1uFYtpAxP44FKxuc+O0bO0QAkKIfda9M42r1GWfafDts=;
X-UUID: f80af63315d1490b9343b2a9f0e4d030-20201022
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1957443281; Thu, 22 Oct 2020 10:28:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 10:28:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 10:28:40 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v4 10/10] mt76: mt7915: add support to set tx frequency offset in testmode
Date:   Thu, 22 Oct 2020 10:28:20 +0800
Message-ID: <20201022022820.3077-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201022022820.3077-1-shayne.chen@mediatek.com>
References: <20201022022820.3077-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CB4A3D2A80CB3F71F154246CEE489732BE5F3B5B1E04D93793DBBDF147D4C7B02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U3VwcG9ydCB0byBzZXQgdHggZnJlcXVlbmN5IG9mZnNldCBpbiB0ZXN0bW9kZSwgd2hpY2ggaXMg
dXNhbGx5IHVzZWQgaW4NCnRoZSBwcmUtY2FsaWJyYXRpb24gc3RhZ2UuDQoNClJldmlld2VkLWJ5
OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTaGF5
bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuaCAgIHwgIDEgKw0KIC4uLi93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS90ZXN0bW9kZS5jICB8IDIwICsrKysrKysrKysrKysrKysrKysNCiAu
Li4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1vZGUuaCAgfCAgNiArKysrKysN
CiAzIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5oIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmgNCmluZGV4IDBhN2U5ZDIuLmZmNWVk
MDkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzkx
NS9tY3UuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
bWN1LmgNCkBAIC00OCw2ICs0OCw3IEBAIGVudW0gew0KIA0KIGVudW0gew0KIAlNQ1VfQVRFX1NF
VF9UUlggPSAweDEsDQorCU1DVV9BVEVfU0VUX0ZSRVFfT0ZGU0VUID0gMHhhLA0KIH07DQogDQog
c3RydWN0IG10NzkxNV9tY3VfcnhkIHsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS90ZXN0bW9kZS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1vZGUuYw0KaW5kZXggYjM2NDliYy4uOWVlODJlMiAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Rl
c3Rtb2RlLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1
L3Rlc3Rtb2RlLmMNCkBAIC04LDYgKzgsNyBAQA0KIA0KIGVudW0gew0KIAlUTV9DSEFOR0VEX1RY
UE9XRVIsDQorCVRNX0NIQU5HRURfRlJFUV9PRkZTRVQsDQogDQogCS8qIG11c3QgYmUgbGFzdCAq
Lw0KIAlOVU1fVE1fQ0hBTkdFRA0KQEAgLTE1LDYgKzE2LDcgQEAgZW51bSB7DQogDQogc3RhdGlj
IGNvbnN0IHU4IHRtX2NoYW5nZV9tYXBbXSA9IHsNCiAJW1RNX0NIQU5HRURfVFhQT1dFUl0gPSBN
VDc2X1RNX0FUVFJfVFhfUE9XRVIsDQorCVtUTV9DSEFOR0VEX0ZSRVFfT0ZGU0VUXSA9IE1UNzZf
VE1fQVRUUl9GUkVRX09GRlNFVCwNCiB9Ow0KIA0KIHN0cnVjdCByZWdfYmFuZCB7DQpAQCAtODIs
NiArODQsMTkgQEAgbXQ3OTE1X3RtX3NldF90eF9wb3dlcihzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5
KQ0KIAlyZXR1cm4gcmV0Ow0KIH0NCiANCitzdGF0aWMgaW50DQorbXQ3OTE1X3RtX3NldF9mcmVx
X29mZnNldChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBib29sIGVuLCB1MzIgdmFsKQ0KK3sNCisJ
c3RydWN0IG10NzkxNV90bV9jbWQgcmVxID0gew0KKwkJLnRlc3Rtb2RlX2VuID0gZW4sDQorCQku
cGFyYW1faWR4ID0gTUNVX0FURV9TRVRfRlJFUV9PRkZTRVQsDQorCQkucGFyYW0uZnJlcS5mcmVx
X29mZnNldCA9IGNwdV90b19sZTMyKHZhbCksDQorCX07DQorDQorCXJldHVybiBtdDc2X21jdV9z
ZW5kX21zZygmZGV2LT5tdDc2LCBNQ1VfRVhUX0NNRF9BVEVfQ1RSTCwgJnJlcSwNCisJCQkJIHNp
emVvZihyZXEpLCBmYWxzZSk7DQorfQ0KKw0KIHN0YXRpYyBpbnQNCiBtdDc5MTVfdG1fbW9kZV9j
dHJsKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIGJvb2wgZW5hYmxlKQ0KIHsNCkBAIC0yMjYsNiAr
MjQxLDExIEBAIG10NzkxNV90bV9zZXRfcnhfZnJhbWVzKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYs
IGJvb2wgZW4pDQogc3RhdGljIHZvaWQNCiBtdDc5MTVfdG1fdXBkYXRlX3BhcmFtcyhzdHJ1Y3Qg
bXQ3OTE1X2RldiAqZGV2LCB1MzIgY2hhbmdlZCkNCiB7DQorCXN0cnVjdCBtdDc2X3Rlc3Rtb2Rl
X2RhdGEgKnRkID0gJmRldi0+bXQ3Ni50ZXN0Ow0KKwlib29sIGVuID0gZGV2LT5tdDc2LnRlc3Qu
c3RhdGUgIT0gTVQ3Nl9UTV9TVEFURV9PRkY7DQorDQorCWlmIChjaGFuZ2VkICYgQklUKFRNX0NI
QU5HRURfRlJFUV9PRkZTRVQpKQ0KKwkJbXQ3OTE1X3RtX3NldF9mcmVxX29mZnNldChkZXYsIGVu
LCBlbiA/IHRkLT5mcmVxX29mZnNldCA6IDApOw0KIAlpZiAoY2hhbmdlZCAmIEJJVChUTV9DSEFO
R0VEX1RYUE9XRVIpKQ0KIAkJbXQ3OTE1X3RtX3NldF90eF9wb3dlcigmZGV2LT5waHkpOw0KIH0N
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS90
ZXN0bW9kZS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvdGVz
dG1vZGUuaA0KaW5kZXggMDRmNGEyYy4uOTY0ZjJkNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Rlc3Rtb2RlLmgNCisrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Rlc3Rtb2RlLmgNCkBAIC0xMSw2ICsx
MSwxMSBAQCBzdHJ1Y3QgbXQ3OTE1X3RtX3RyeCB7DQogCXU4IHJzdjsNCiB9Ow0KIA0KK3N0cnVj
dCBtdDc5MTVfdG1fZnJlcV9vZmZzZXQgew0KKwl1OCBiYW5kOw0KKwlfX2xlMzIgZnJlcV9vZmZz
ZXQ7DQorfTsNCisNCiBzdHJ1Y3QgbXQ3OTE1X3RtX2NtZCB7DQogCXU4IHRlc3Rtb2RlX2VuOw0K
IAl1OCBwYXJhbV9pZHg7DQpAQCAtMTgsNiArMjMsNyBAQCBzdHJ1Y3QgbXQ3OTE1X3RtX2NtZCB7
DQogCXVuaW9uIHsNCiAJCV9fbGUzMiBkYXRhOw0KIAkJc3RydWN0IG10NzkxNV90bV90cnggdHJ4
Ow0KKwkJc3RydWN0IG10NzkxNV90bV9mcmVxX29mZnNldCBmcmVxOw0KIAkJdTggdGVzdFs3Ml07
DQogCX0gcGFyYW07DQogfSBfX3BhY2tlZDsNCi0tIA0KMi4xNy4xDQo=

