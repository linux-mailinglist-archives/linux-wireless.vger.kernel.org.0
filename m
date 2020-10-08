Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B49E287368
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgJHLd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 07:33:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33947 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729833AbgJHLd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 07:33:26 -0400
X-UUID: 037c8011df074a2a8d09ce0e34844743-20201008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=y8SErLPJ/2MtYnV7AZG7G84PhcKcS0BnSRx4cxeN2zk=;
        b=cxDuUVTV+rMwARyrx1Hi4Gfw73u2Lp+g4ceF1pyG4i1GIQ9W9CppAqGiD7Nu1ZaD3Yxq4zrRvqyUmiV+CYpypWdRQEVioNGAB7Yz/O1yG2Q5OnYOUxsZcrjGXNc8mO+tRSGiyKHbKxuW2Xx6HN/1H7k8Vr2JuT3CRxArgo4DuiY=;
X-UUID: 037c8011df074a2a8d09ce0e34844743-20201008
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 520007122; Thu, 08 Oct 2020 19:33:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Oct 2020 19:33:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Oct 2020 19:33:14 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 10/10] mt76: mt7915: add support to set tx frequency offset in testmode
Date:   Thu, 8 Oct 2020 19:29:04 +0800
Message-ID: <20201008112904.10620-10-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201008112904.10620-1-shayne.chen@mediatek.com>
References: <20201008112904.10620-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E7BEB9366F865D62E26A1C70124A8D3E09C346FDFA2E958A7CA0B96678545CC02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U3VwcG9ydCB0byBzZXQgdHggZnJlcXVlbmN5IG9mZnNldCBpbiB0ZXN0bW9kZSwgd2hpY2ggaXMg
dXNhbGx5IHVzZWQgaW4NCnRoZSBwcmUtY2FsaWJyYXRpb24gc3RhZ2UuDQoNClNpZ25lZC1vZmYt
Ynk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTog
UnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuaCAgIHwgIDEgKw0KIC4uLi93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS90ZXN0bW9kZS5jICB8IDIwICsrKysrKysrKysrKysrKysrKysNCiAu
Li4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1vZGUuaCAgfCAgNiArKysrKysN
CiAzIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5oIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmgNCmluZGV4IDg5NDUzYTYuLjYwYzVm
MWIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzkx
NS9tY3UuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
bWN1LmgNCkBAIC00OSw2ICs0OSw3IEBAIGVudW0gew0KIGVudW0gew0KIAlNQ1VfQVRFX1NFVF9U
UlggPSAweDEsDQogCU1DVV9BVEVfU0VUX1JYX0ZJTFRFUiA9IDB4MywNCisJTUNVX0FURV9TRVRf
RlJFUV9PRkZTRVQgPSAweGEsDQogfTsNCiANCiBzdHJ1Y3QgbXQ3OTE1X21jdV9yeGQgew0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Rlc3Rt
b2RlLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS90ZXN0bW9k
ZS5jDQppbmRleCAzMzlmNDdhLi44YWUwNjcyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1vZGUuYw0KKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1vZGUuYw0KQEAgLTgsNiArOCw3IEBA
DQogDQogZW51bSB7DQogCVRNX0NIQU5HRURfVFhQT1dFUiwNCisJVE1fQ0hBTkdFRF9GUkVRX09G
RlNFVCwNCiANCiAJLyogbXVzdCBiZSBsYXN0ICovDQogCU5VTV9UTV9DSEFOR0VEDQpAQCAtMTUs
NiArMTYsNyBAQCBlbnVtIHsNCiANCiBzdGF0aWMgY29uc3QgdTggdG1fY2hhbmdlX21hcFtdID0g
ew0KIAlbVE1fQ0hBTkdFRF9UWFBPV0VSXSA9IE1UNzZfVE1fQVRUUl9UWF9QT1dFUiwNCisJW1RN
X0NIQU5HRURfRlJFUV9PRkZTRVRdID0gTVQ3Nl9UTV9BVFRSX0ZSRVFfT0ZGU0VULA0KIH07DQog
DQogc3RydWN0IHJlZ19iYW5kIHsNCkBAIC04MCw2ICs4MiwxOSBAQCBtdDc5MTVfdG1fc2V0X3R4
X3Bvd2VyKHN0cnVjdCBtdDc5MTVfcGh5ICpwaHkpDQogCXJldHVybiByZXQ7DQogfQ0KIA0KK3N0
YXRpYyBpbnQNCittdDc5MTVfdG1fc2V0X2ZyZXFfb2Zmc2V0KHN0cnVjdCBtdDc5MTVfZGV2ICpk
ZXYsIGJvb2wgZW4sIHUzMiB2YWwpDQorew0KKwlzdHJ1Y3QgbXQ3OTE1X3RtX2NtZCByZXEgPSB7
DQorCQkudGVzdG1vZGVfZW4gPSBlbiwNCisJCS5wYXJhbV9pZHggPSBNQ1VfQVRFX1NFVF9GUkVR
X09GRlNFVCwNCisJCS5wYXJhbS5mcmVxLmZyZXFfb2Zmc2V0ID0gY3B1X3RvX2xlMzIodmFsKSwN
CisJfTsNCisNCisJcmV0dXJuIG10NzZfbWN1X3NlbmRfbXNnKCZkZXYtPm10NzYsIE1DVV9FWFRf
Q01EX0FURV9DVFJMLCAmcmVxLA0KKwkJCQkgc2l6ZW9mKHJlcSksIGZhbHNlKTsNCit9DQorDQog
c3RhdGljIGludA0KIG10NzkxNV90bV9tb2RlX2N0cmwoc3RydWN0IG10NzkxNV9kZXYgKmRldiwg
Ym9vbCBlbmFibGUpDQogew0KQEAgLTI0Niw2ICsyNjEsMTEgQEAgbXQ3OTE1X3RtX3NldF9yeF9m
cmFtZXMoc3RydWN0IG10NzkxNV9kZXYgKmRldiwgYm9vbCBlbikNCiBzdGF0aWMgdm9pZA0KIG10
NzkxNV90bV91cGRhdGVfcGFyYW1zKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHUzMiBjaGFuZ2Vk
KQ0KIHsNCisJc3RydWN0IG10NzZfdGVzdG1vZGVfZGF0YSAqdGQgPSAmZGV2LT5tdDc2LnRlc3Q7
DQorCWJvb2wgZW4gPSBkZXYtPm10NzYudGVzdC5zdGF0ZSAhPSBNVDc2X1RNX1NUQVRFX09GRjsN
CisNCisJaWYgKGNoYW5nZWQgJiBCSVQoVE1fQ0hBTkdFRF9GUkVRX09GRlNFVCkpDQorCQltdDc5
MTVfdG1fc2V0X2ZyZXFfb2Zmc2V0KGRldiwgZW4sIGVuID8gdGQtPmZyZXFfb2Zmc2V0IDogMCk7
DQogCWlmIChjaGFuZ2VkICYgQklUKFRNX0NIQU5HRURfVFhQT1dFUikpDQogCQltdDc5MTVfdG1f
c2V0X3R4X3Bvd2VyKCZkZXYtPnBoeSk7DQogfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Rlc3Rtb2RlLmggYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS90ZXN0bW9kZS5oDQppbmRleCBiMzQ0YTY0Li4zOWQ0
ZDJlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvdGVzdG1vZGUuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5MTUvdGVzdG1vZGUuaA0KQEAgLTExLDYgKzExLDExIEBAIHN0cnVjdCBtdDc5MTVfdG1fdHJ4
IHsNCiAJdTggcnN2Ow0KIH07DQogDQorc3RydWN0IG10NzkxNV90bV9mcmVxX29mZnNldCB7DQor
CXU4IGJhbmQ7DQorCV9fbGUzMiBmcmVxX29mZnNldDsNCit9Ow0KKw0KIHN0cnVjdCBtdDc5MTVf
dG1fcnhfZmlsdGVyIHsNCiAJdTggcHJvbWlzY3VvdXM7DQogCXU4IHJlcG9ydF9lbjsNCkBAIC0y
Nyw2ICszMiw3IEBAIHN0cnVjdCBtdDc5MTVfdG1fY21kIHsNCiAJdW5pb24gew0KIAkJX19sZTMy
IGRhdGE7DQogCQlzdHJ1Y3QgbXQ3OTE1X3RtX3RyeCB0cng7DQorCQlzdHJ1Y3QgbXQ3OTE1X3Rt
X2ZyZXFfb2Zmc2V0IGZyZXE7DQogCQlzdHJ1Y3QgbXQ3OTE1X3RtX3J4X2ZpbHRlciBmaWx0ZXI7
DQogCQl1OCB0ZXN0WzcyXTsNCiAJfSBwYXJhbTsNCi0tIA0KMi4xNy4xDQo=

