Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C699328AC76
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 05:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgJLD0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Oct 2020 23:26:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54583 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727219AbgJLD0k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Oct 2020 23:26:40 -0400
X-UUID: efc0538aad904d5aa40d8b16f44a314b-20201012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XSBHCv4njhQ7QH/QrbTKtQ8GdakL0lcLP/q0VLgKqus=;
        b=bxi8hH7Don/2rvX5+zXEoFv8xY/Y6gdtHwHreRJ4Bef6d93B5PAZ+gy5imGzhDwYNZSMjbc7jzQEDpRZR9nju9CErYIFqQqvS+PoVcgJZdBISTWCzJaK2l2JTQT0AZ06NBvY6zTb4XixhkQHB7WmOh5KbRDTFC2uSk3n3Hlr71Q=;
X-UUID: efc0538aad904d5aa40d8b16f44a314b-20201012
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 418556679; Mon, 12 Oct 2020 11:26:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Oct 2020 11:26:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 11:26:26 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 07/10] mt76: mt7915: implement testmode tx support
Date:   Mon, 12 Oct 2020 11:25:35 +0800
Message-ID: <20201012032538.21314-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201012032538.21314-1-shayne.chen@mediatek.com>
References: <20201012032538.21314-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ABFA21B615E3442D4A7E491E86B8132CA4837126888EAC97E226EB0D8D7B3F3D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U3VwcG9ydCB0ZXN0bW9kZSB0eCBmb3IgTVQ3OTE1QSwgaW5jbHVkaW5nIHR4IHN0cmVhbXMgYW5k
IEhFIHJhdGUNCnNldHRpbmdzLg0KDQpSZXZpZXdlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVA
bWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9NYWtl
ZmlsZSAgICB8ICAgMiArDQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9p
bml0LmMgIHwgICA0ICsNCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21h
Yy5jICAgfCAxMjcgKysrKysrKysrKysrDQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzkxNS9tYWluLmMgIHwgIDQwICsrKy0NCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L21jdS5jICAgfCAgMzEgKysrDQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tY3UuaCAgIHwgICA1ICsNCiAuLi4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5MTUvbXQ3OTE1LmggICAgfCAgMTQgKysNCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L3JlZ3MuaCAgfCAgMzEgKysrDQogLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L3Rlc3Rtb2RlLmMgIHwgMTgwICsrKysrKysrKysrKysrKysrKw0KIC4uLi93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS90ZXN0bW9kZS5oICB8ICAzNCArKysrDQogMTAgZmlsZXMg
Y2hhbmdlZCwgNDYyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Rlc3Rtb2Rl
LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvdGVzdG1vZGUuaA0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvTWFrZWZpbGUgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9NYWtlZmlsZQ0KaW5kZXggNTdmZTcyNi4uY2MyMDU0ZCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L01ha2VmaWxl
DQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9NYWtlZmls
ZQ0KQEAgLTQsMyArNCw1IEBAIG9iai0kKENPTkZJR19NVDc5MTVFKSArPSBtdDc5MTVlLm8NCiAN
CiBtdDc5MTVlLXkgOj0gcGNpLm8gaW5pdC5vIGRtYS5vIGVlcHJvbS5vIG1haW4ubyBtY3UubyBt
YWMubyBcDQogCSAgICAgZGVidWdmcy5vDQorDQorbXQ3OTE1ZS0kKENPTkZJR19OTDgwMjExX1RF
U1RNT0RFKSArPSB0ZXN0bW9kZS5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQppbmRleCBlZTY5ZmU0Li4zOTBiMzI4IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQorKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCkBAIC02
OTUsNiArNjk1LDEwIEBAIGludCBtdDc5MTVfcmVnaXN0ZXJfZGV2aWNlKHN0cnVjdCBtdDc5MTVf
ZGV2ICpkZXYpDQogCW10NzkxNV9jYXBfZGJkY19kaXNhYmxlKGRldik7DQogCWRldi0+cGh5LmRm
c19zdGF0ZSA9IC0xOw0KIA0KKyNpZmRlZiBDT05GSUdfTkw4MDIxMV9URVNUTU9ERQ0KKwlkZXYt
Pm10NzYudGVzdF9vcHMgPSAmbXQ3OTE1X3Rlc3Rtb2RlX29wczsNCisjZW5kaWYNCisNCiAJcmV0
ID0gbXQ3Nl9yZWdpc3Rlcl9kZXZpY2UoJmRldi0+bXQ3NiwgdHJ1ZSwgbXQ3OTE1X3JhdGVzLA0K
IAkJCQkgICBBUlJBWV9TSVpFKG10NzkxNV9yYXRlcykpOw0KIAlpZiAocmV0KQ0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMNCmluZGV4IGE3MTE4
ZGYuLmUwM2UxMmYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tYWMuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvbWFjLmMNCkBAIC01NjIsNiArNTYyLDExOCBAQCBpbnQgbXQ3OTE1X21hY19maWxs
X3J4KHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBza19idWZmICpza2IpDQogCXJldHVy
biAwOw0KIH0NCiANCitzdGF0aWMgdTE2DQorbXQ3OTE1X21hY190eF9yYXRlX3ZhbChzdHJ1Y3Qg
bXQ3Nl9waHkgKm1waHksIHU4IG1vZGUsIHU4IHJhdGVfaWR4LA0KKwkJICAgICAgIHU4IG5zcywg
dTggc3RiYywgdTggKmJ3KQ0KK3sNCisJdTE2IHJhdGV2YWw7DQorDQorCXN3aXRjaCAobXBoeS0+
Y2hhbmRlZi53aWR0aCkgew0KKwljYXNlIE5MODAyMTFfQ0hBTl9XSURUSF80MDoNCisJCSpidyA9
IDE7DQorCQlicmVhazsNCisJY2FzZSBOTDgwMjExX0NIQU5fV0lEVEhfODA6DQorCQkqYncgPSAy
Ow0KKwkJYnJlYWs7DQorCWNhc2UgTkw4MDIxMV9DSEFOX1dJRFRIXzgwUDgwOg0KKwljYXNlIE5M
ODAyMTFfQ0hBTl9XSURUSF8xNjA6DQorCQkqYncgPSAzOw0KKwkJYnJlYWs7DQorCWRlZmF1bHQ6
DQorCQkqYncgPSAwOw0KKwkJYnJlYWs7DQorCX0NCisNCisJaWYgKG1vZGUgPT0gTVRfUEhZX1RZ
UEVfSFQgfHwgbW9kZSA9PSBNVF9QSFlfVFlQRV9IVF9HRikNCisJCW5zcyA9IDEgKyAocmF0ZV9p
ZHggPj4gMyk7DQorDQorCXJhdGV2YWwgPSBGSUVMRF9QUkVQKE1UX1RYX1JBVEVfSURYLCByYXRl
X2lkeCkgfA0KKwkJICBGSUVMRF9QUkVQKE1UX1RYX1JBVEVfTU9ERSwgbW9kZSkgfA0KKwkJICBG
SUVMRF9QUkVQKE1UX1RYX1JBVEVfTlNTLCBuc3MgLSAxKTsNCisNCisJaWYgKHN0YmMgJiYgbnNz
ID09IDEpIHsNCisJCW5zcysrOw0KKwkJcmF0ZXZhbCB8PSBNVF9UWF9SQVRFX1NUQkM7DQorCX0N
CisNCisJcmV0dXJuIHJhdGV2YWw7DQorfQ0KKw0KK3N0YXRpYyB2b2lkDQorbXQ3OTE1X21hY193
cml0ZV90eHdpX3RtKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBtdDc2X3BoeSAqbXBo
eSwNCisJCQkgX19sZTMyICp0eHdpLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KK3sNCisjaWZkZWYg
Q09ORklHX05MODAyMTFfVEVTVE1PREUNCisJc3RydWN0IG10NzZfdGVzdG1vZGVfZGF0YSAqdGQg
PSAmZGV2LT5tdDc2LnRlc3Q7DQorCXU4IGJ3LCBtb2RlOw0KKwl1MTYgcmF0ZXZhbDsNCisJdTMy
IHZhbDsNCisNCisJaWYgKHNrYiAhPSBkZXYtPm10NzYudGVzdC50eF9za2IpDQorCQlyZXR1cm47
DQorDQorCXN3aXRjaCAodGQtPnR4X3JhdGVfbW9kZSkgew0KKwljYXNlIE1UNzZfVE1fVFhfTU9E
RV9DQ0s6DQorCQltb2RlID0gTVRfUEhZX1RZUEVfQ0NLOw0KKwkJYnJlYWs7DQorCWNhc2UgTVQ3
Nl9UTV9UWF9NT0RFX0hUOg0KKwkJbW9kZSA9IE1UX1BIWV9UWVBFX0hUOw0KKwkJYnJlYWs7DQor
CWNhc2UgTVQ3Nl9UTV9UWF9NT0RFX1ZIVDoNCisJCW1vZGUgPSBNVF9QSFlfVFlQRV9WSFQ7DQor
CQlicmVhazsNCisJY2FzZSBNVDc2X1RNX1RYX01PREVfSEVfU1U6DQorCQltb2RlID0gTVRfUEhZ
X1RZUEVfSEVfU1U7DQorCQlicmVhazsNCisJY2FzZSBNVDc2X1RNX1RYX01PREVfSEVfRVhUX1NV
Og0KKwkJbW9kZSA9IE1UX1BIWV9UWVBFX0hFX0VYVF9TVTsNCisJCWJyZWFrOw0KKwljYXNlIE1U
NzZfVE1fVFhfTU9ERV9IRV9UQjoNCisJCW1vZGUgPSBNVF9QSFlfVFlQRV9IRV9UQjsNCisJCWJy
ZWFrOw0KKwljYXNlIE1UNzZfVE1fVFhfTU9ERV9IRV9NVToNCisJCW1vZGUgPSBNVF9QSFlfVFlQ
RV9IRV9NVTsNCisJCWJyZWFrOw0KKwljYXNlIE1UNzZfVE1fVFhfTU9ERV9PRkRNOg0KKwlkZWZh
dWx0Og0KKwkJbW9kZSA9IE1UX1BIWV9UWVBFX09GRE07DQorCQlicmVhazsNCisJfQ0KKw0KKwly
YXRldmFsID0gbXQ3OTE1X21hY190eF9yYXRlX3ZhbChtcGh5LCBtb2RlLCB0ZC0+dHhfcmF0ZV9p
ZHgsDQorCQkJCQkgdGQtPnR4X3JhdGVfbnNzLCB0ZC0+dHhfcmF0ZV9zdGJjLCAmYncpOw0KKw0K
Kwl0eHdpWzJdIHw9IGNwdV90b19sZTMyKE1UX1RYRDJfRklYX1JBVEUpOw0KKwlpZiAodGQtPnR4
X3JhdGVfbW9kZSA8IE1UNzZfVE1fVFhfTU9ERV9IVCkNCisJCXR4d2lbM10gfD0gY3B1X3RvX2xl
MzIoTVRfVFhEM19CQV9ESVNBQkxFKTsNCisNCisJdmFsID0gTVRfVFhENl9GSVhFRF9CVyB8DQor
CSAgICAgIEZJRUxEX1BSRVAoTVRfVFhENl9CVywgYncpIHwNCisJICAgICAgRklFTERfUFJFUChN
VF9UWEQ2X1RYX1JBVEUsIHJhdGV2YWwpIHwNCisJICAgICAgRklFTERfUFJFUChNVF9UWEQ2X1NH
SSwgdGQtPnR4X3JhdGVfc2dpKTsNCisNCisJLyogZm9yIEhFX1NVL0hFX0VYVF9TVSBQUERVDQor
CSAqIC0gMXgsIDJ4LCA0eCBMVEYgKyAwLjh1cyBHSQ0KKwkgKiAtIDJ4IExURiArIDEuNnVzIEdJ
LCA0eCBMVEYgKyAzLjJ1cyBHSQ0KKwkgKiBmb3IgSEVfTVUgUFBEVQ0KKwkgKiAtIDJ4LCA0eCBM
VEYgKyAwLjh1cyBHSQ0KKwkgKiAtIDJ4IExURiArIDEuNnVzIEdJLCA0eCBMVEYgKyAzLjJ1cyBH
SQ0KKwkgKiBmb3IgSEVfVEIgUFBEVQ0KKwkgKiAtIDF4LCAyeCBMVEYgKyAxLjZ1cyBHSQ0KKwkg
KiAtIDR4IExURiArIDMuMnVzIEdJDQorCSAqLw0KKwlpZiAobW9kZSA+PSBNVF9QSFlfVFlQRV9I
RV9TVSkNCisJCXZhbCB8PSBGSUVMRF9QUkVQKE1UX1RYRDZfSEVMVEYsIHRkLT50eF9sdGYpOw0K
Kw0KKwlpZiAodGQtPnR4X3JhdGVfbGRwYykNCisJCXZhbCB8PSBNVF9UWEQ2X0xEUEM7DQorDQor
CXR4d2lbNl0gfD0gY3B1X3RvX2xlMzIodmFsKTsNCisJdHh3aVs3XSB8PSBjcHVfdG9fbGUzMihG
SUVMRF9QUkVQKE1UX1RYRDdfU1BFX0lEWCwNCisJCQkJCSAgZGV2LT50ZXN0LnNwZV9pZHgpKTsN
CisjZW5kaWYNCit9DQorDQogc3RhdGljIHZvaWQNCiBtdDc5MTVfbWFjX3dyaXRlX3R4d2lfODAy
MyhzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBfX2xlMzIgKnR4d2ksDQogCQkJICAgc3RydWN0IHNr
X2J1ZmYgKnNrYiwgc3RydWN0IG10NzZfd2NpZCAqd2NpZCkNCkBAIC03NjEsNiArODczLDkgQEAg
dm9pZCBtdDc5MTVfbWFjX3dyaXRlX3R4d2koc3RydWN0IG10NzkxNV9kZXYgKmRldiwgX19sZTMy
ICp0eHdpLA0KIAkJdHh3aVs2XSB8PSBjcHVfdG9fbGUzMih2YWwpOw0KIAkJdHh3aVszXSB8PSBj
cHVfdG9fbGUzMihNVF9UWEQzX0JBX0RJU0FCTEUpOw0KIAl9DQorDQorCWlmIChtdDc2X3Rlc3Rt
b2RlX2VuYWJsZWQoJmRldi0+bXQ3NikpDQorCQltdDc5MTVfbWFjX3dyaXRlX3R4d2lfdG0oZGV2
LCBtcGh5LCB0eHdpLCBza2IpOw0KIH0NCiANCiBpbnQgbXQ3OTE1X3R4X3ByZXBhcmVfc2tiKHN0
cnVjdCBtdDc2X2RldiAqbWRldiwgdm9pZCAqdHh3aV9wdHIsDQpAQCAtODgxLDYgKzk5NiwxOCBA
QCBtdDc5MTVfdHhfY29tcGxldGVfc3RhdHVzKHN0cnVjdCBtdDc2X2RldiAqbWRldiwgc3RydWN0
IHNrX2J1ZmYgKnNrYiwNCiANCiAJaHcgPSBtdDc2X3R4X3N0YXR1c19nZXRfaHcobWRldiwgc2ti
KTsNCiANCisjaWZkZWYgQ09ORklHX05MODAyMTFfVEVTVE1PREUNCisJaWYgKHNrYiA9PSBtZGV2
LT50ZXN0LnR4X3NrYikgew0KKwkJc3RydWN0IG10NzkxNV9waHkgKnBoeSA9IG10NzkxNV9od19w
aHkoaHcpOw0KKwkJc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiA9IHBoeS0+bW9uaXRvcl92aWY7
DQorCQlzdHJ1Y3QgbXQ3OTE1X3ZpZiAqbXZpZiA9IChzdHJ1Y3QgbXQ3OTE1X3ZpZiAqKXZpZi0+
ZHJ2X3ByaXY7DQorDQorCQltdDc2X3R4X2NvbXBsZXRlX3NrYihtZGV2LCBtdmlmLT5zdGEud2Np
ZC5pZHgsIHNrYik7DQorDQorCQlyZXR1cm47DQorCX0NCisjZW5kaWYNCisNCiAJaWYgKGluZm8t
PmZsYWdzICYgSUVFRTgwMjExX1RYX0NUTF9BTVBEVSkNCiAJCWluZm8tPmZsYWdzIHw9IElFRUU4
MDIxMV9UWF9TVEFUX0FNUERVOw0KIA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L21haW4uYw0KaW5kZXggMTI2MmZiMy4uOWViZTVhZiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYw0KKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5jDQpAQCAt
NDQsMTMgKzQ0LDE0IEBAIHN0YXRpYyBpbnQgbXQ3OTE1X3N0YXJ0KHN0cnVjdCBpZWVlODAyMTFf
aHcgKmh3KQ0KIAkJbXQ3OTE1X21hY19lbmFibGVfbmYoZGV2LCAxKTsNCiAJfQ0KIA0KLQltdDc5
MTVfbWN1X3NldF9za3VfZW4ocGh5LCB0cnVlKTsNCisJbXQ3OTE1X21jdV9zZXRfc2t1X2VuKHBo
eSwgIW10NzZfdGVzdG1vZGVfZW5hYmxlZCgmZGV2LT5tdDc2KSk7DQogCW10NzkxNV9tY3Vfc2V0
X2NoYW5faW5mbyhwaHksIE1DVV9FWFRfQ01EX1NFVF9SWF9QQVRIKTsNCiANCiAJc2V0X2JpdChN
VDc2X1NUQVRFX1JVTk5JTkcsICZwaHktPm10NzYtPnN0YXRlKTsNCiANCi0JaWVlZTgwMjExX3F1
ZXVlX2RlbGF5ZWRfd29yayhodywgJnBoeS0+bWFjX3dvcmssDQotCQkJCSAgICAgTVQ3OTE1X1dB
VENIRE9HX1RJTUUpOw0KKwlpZiAoIW10NzZfdGVzdG1vZGVfZW5hYmxlZCgmZGV2LT5tdDc2KSkN
CisJCWllZWU4MDIxMV9xdWV1ZV9kZWxheWVkX3dvcmsoaHcsICZwaHktPm1hY193b3JrLA0KKwkJ
CQkJICAgICBNVDc5MTVfV0FUQ0hET0dfVElNRSk7DQogDQogCWlmICghcnVubmluZykNCiAJCW10
NzkxNV9tYWNfcmVzZXRfY291bnRlcnMocGh5KTsNCkBAIC02OSw2ICs3MCw4IEBAIHN0YXRpYyB2
b2lkIG10NzkxNV9zdG9wKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KIA0KIAltdXRleF9sb2Nr
KCZkZXYtPm10NzYubXV0ZXgpOw0KIA0KKwltdDc2X3Rlc3Rtb2RlX3Jlc2V0KCZkZXYtPm10NzYs
IHRydWUpOw0KKw0KIAljbGVhcl9iaXQoTVQ3Nl9TVEFURV9SVU5OSU5HLCAmcGh5LT5tdDc2LT5z
dGF0ZSk7DQogDQogCWlmIChwaHkgIT0gJmRldi0+cGh5KSB7DQpAQCAtMTUwLDYgKzE1MywxMiBA
QCBzdGF0aWMgaW50IG10NzkxNV9hZGRfaW50ZXJmYWNlKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
LA0KIA0KIAltdXRleF9sb2NrKCZkZXYtPm10NzYubXV0ZXgpOw0KIA0KKwltdDc2X3Rlc3Rtb2Rl
X3Jlc2V0KCZkZXYtPm10NzYsIHRydWUpOw0KKw0KKwlpZiAodmlmLT50eXBlID09IE5MODAyMTFf
SUZUWVBFX01PTklUT1IgJiYNCisJICAgIGlzX3plcm9fZXRoZXJfYWRkcih2aWYtPmFkZHIpKQ0K
KwkJcGh5LT5tb25pdG9yX3ZpZiA9IHZpZjsNCisNCiAJbXZpZi0+aWR4ID0gZmZzKH5waHktPm10
NzYtPnZpZl9tYXNrKSAtIDE7DQogCWlmIChtdmlmLT5pZHggPj0gTVQ3OTE1X01BWF9JTlRFUkZB
Q0VTKSB7DQogCQlyZXQgPSAtRU5PU1BDOw0KQEAgLTIxOCw2ICsyMjcsMTMgQEAgc3RhdGljIHZv
aWQgbXQ3OTE1X3JlbW92ZV9pbnRlcmZhY2Uoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQogDQog
CS8qIFRPRE86IGRpc2FibGUgYmVhY29uIGZvciB0aGUgYnNzICovDQogDQorCW11dGV4X2xvY2so
JmRldi0+bXQ3Ni5tdXRleCk7DQorCW10NzZfdGVzdG1vZGVfcmVzZXQoJmRldi0+bXQ3NiwgdHJ1
ZSk7DQorCW11dGV4X3VubG9jaygmZGV2LT5tdDc2Lm11dGV4KTsNCisNCisJaWYgKHZpZiA9PSBw
aHktPm1vbml0b3JfdmlmKQ0KKwkJcGh5LT5tb25pdG9yX3ZpZiA9IE5VTEw7DQorDQogCW10Nzkx
NV9tY3VfYWRkX2Rldl9pbmZvKHBoeSwgdmlmLCBmYWxzZSk7DQogDQogCXJjdV9hc3NpZ25fcG9p
bnRlcihkZXYtPm10NzYud2NpZFtpZHhdLCBOVUxMKTsNCkBAIC0yNTIsNyArMjY4LDcgQEAgc3Rh
dGljIHZvaWQgbXQ3OTE1X2luaXRfZGZzX3N0YXRlKHN0cnVjdCBtdDc5MTVfcGh5ICpwaHkpDQog
CXBoeS0+ZGZzX3N0YXRlID0gLTE7DQogfQ0KIA0KLXN0YXRpYyBpbnQgbXQ3OTE1X3NldF9jaGFu
bmVsKHN0cnVjdCBtdDc5MTVfcGh5ICpwaHkpDQoraW50IG10NzkxNV9zZXRfY2hhbm5lbChzdHJ1
Y3QgbXQ3OTE1X3BoeSAqcGh5KQ0KIHsNCiAJc3RydWN0IG10NzkxNV9kZXYgKmRldiA9IHBoeS0+
ZGV2Ow0KIAlpbnQgcmV0Ow0KQEAgLTI4MSw4ICsyOTcsMTAgQEAgb3V0Og0KIAltdXRleF91bmxv
Y2soJmRldi0+bXQ3Ni5tdXRleCk7DQogDQogCW10NzZfdHhxX3NjaGVkdWxlX2FsbChwaHktPm10
NzYpOw0KLQlpZWVlODAyMTFfcXVldWVfZGVsYXllZF93b3JrKHBoeS0+bXQ3Ni0+aHcsICZwaHkt
Pm1hY193b3JrLA0KLQkJCQkgICAgIE1UNzkxNV9XQVRDSERPR19USU1FKTsNCisNCisJaWYgKCFt
dDc2X3Rlc3Rtb2RlX2VuYWJsZWQoJmRldi0+bXQ3NikpDQorCQlpZWVlODAyMTFfcXVldWVfZGVs
YXllZF93b3JrKHBoeS0+bXQ3Ni0+aHcsICZwaHktPm1hY193b3JrLA0KKwkJCQkJICAgICBNVDc5
MTVfV0FUQ0hET0dfVElNRSk7DQogDQogCXJldHVybiByZXQ7DQogfQ0KQEAgLTM0Niw2ICszNjQs
MTMgQEAgc3RhdGljIGludCBtdDc5MTVfY29uZmlnKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCB1
MzIgY2hhbmdlZCkNCiAJaW50IHJldDsNCiANCiAJaWYgKGNoYW5nZWQgJiBJRUVFODAyMTFfQ09O
Rl9DSEFOR0VfQ0hBTk5FTCkgew0KKyNpZmRlZiBDT05GSUdfTkw4MDIxMV9URVNUTU9ERQ0KKwkJ
aWYgKGRldi0+bXQ3Ni50ZXN0LnN0YXRlICE9IE1UNzZfVE1fU1RBVEVfT0ZGKSB7DQorCQkJbXV0
ZXhfbG9jaygmZGV2LT5tdDc2Lm11dGV4KTsNCisJCQltdDc2X3Rlc3Rtb2RlX3Jlc2V0KCZkZXYt
Pm10NzYsIGZhbHNlKTsNCisJCQltdXRleF91bmxvY2soJmRldi0+bXQ3Ni5tdXRleCk7DQorCQl9
DQorI2VuZGlmDQogCQlpZWVlODAyMTFfc3RvcF9xdWV1ZXMoaHcpOw0KIAkJcmV0ID0gbXQ3OTE1
X3NldF9jaGFubmVsKHBoeSk7DQogCQlpZiAocmV0KQ0KQEAgLTM3MCw2ICszOTUsNyBAQCBzdGF0
aWMgaW50IG10NzkxNV9jb25maWcoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHUzMiBjaGFuZ2Vk
KQ0KIAkJCXBoeS0+cnhmaWx0ZXIgJj0gfk1UX1dGX1JGQ1JfRFJPUF9PVEhFUl9VQzsNCiANCiAJ
CW10NzZfcm13X2ZpZWxkKGRldiwgTVRfRE1BX0RDUjAsIE1UX0RNQV9EQ1IwX1JYRF9HNV9FTiwg
ZW5hYmxlZCk7DQorCQltdDc2X3Rlc3Rtb2RlX3Jlc2V0KCZkZXYtPm10NzYsIHRydWUpOw0KIAkJ
bXQ3Nl93cihkZXYsIE1UX1dGX1JGQ1IoYmFuZCksIHBoeS0+cnhmaWx0ZXIpOw0KIAl9DQogDQpA
QCAtODg3LDYgKzkxMyw4IEBAIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfb3BzIG10NzkxNV9vcHMg
PSB7DQogCS5zZXRfY292ZXJhZ2VfY2xhc3MgPSBtdDc5MTVfc2V0X2NvdmVyYWdlX2NsYXNzLA0K
IAkuc3RhX3N0YXRpc3RpY3MgPSBtdDc5MTVfc3RhX3N0YXRpc3RpY3MsDQogCS5zdGFfc2V0XzRh
ZGRyID0gbXQ3OTE1X3N0YV9zZXRfNGFkZHIsDQorCUNGRzgwMjExX1RFU1RNT0RFX0NNRChtdDc2
X3Rlc3Rtb2RlX2NtZCkNCisJQ0ZHODAyMTFfVEVTVE1PREVfRFVNUChtdDc2X3Rlc3Rtb2RlX2R1
bXApDQogI2lmZGVmIENPTkZJR19NQUM4MDIxMV9ERUJVR0ZTDQogCS5zdGFfYWRkX2RlYnVnZnMg
PSBtdDc5MTVfc3RhX2FkZF9kZWJ1Z2ZzLA0KICNlbmRpZg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCmluZGV4IDVjY2RlNTQuLjM3MmY0NWIg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
Y3UuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1
LmMNCkBAIC0zMTg2LDYgKzMxODYsMTUgQEAgaW50IG10NzkxNV9tY3Vfc2V0X2NoYW5faW5mbyhz
dHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5LCBpbnQgY21kKQ0KIAkJLmNoYW5uZWxfYmFuZCA9IGNoYW5k
ZWYtPmNoYW4tPmJhbmQsDQogCX07DQogDQorI2lmZGVmIENPTkZJR19OTDgwMjExX1RFU1RNT0RF
DQorCWlmIChkZXYtPm10NzYudGVzdC50eF9hbnRlbm5hX21hc2sgJiYNCisJICAgIChkZXYtPm10
NzYudGVzdC5zdGF0ZSA9PSBNVDc2X1RNX1NUQVRFX1RYX0ZSQU1FUyB8fA0KKwkgICAgIGRldi0+
bXQ3Ni50ZXN0LnN0YXRlID09IE1UNzZfVE1fU1RBVEVfUlhfRlJBTUVTKSkgew0KKwkJcmVxLnR4
X3N0cmVhbXNfbnVtID0gZmxzKGRldi0+bXQ3Ni50ZXN0LnR4X2FudGVubmFfbWFzayk7DQorCQly
ZXEucnhfc3RyZWFtcyA9IGRldi0+bXQ3Ni50ZXN0LnR4X2FudGVubmFfbWFzazsNCisJfQ0KKyNl
bmRpZg0KKw0KIAlpZiAoZGV2LT5tdDc2Lmh3LT5jb25mLmZsYWdzICYgSUVFRTgwMjExX0NPTkZf
T0ZGQ0hBTk5FTCkNCiAJCXJlcS5zd2l0Y2hfcmVhc29uID0gQ0hfU1dJVENIX1NDQU5fQllQQVNT
X0RQRDsNCiAJZWxzZSBpZiAoKGNoYW5kZWYtPmNoYW4tPmZsYWdzICYgSUVFRTgwMjExX0NIQU5f
UkFEQVIpICYmDQpAQCAtMzMzMCw2ICszMzM5LDI4IEBAIGludCBtdDc5MTVfbWN1X3NldF90eHBv
d2VyX3NrdShzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5KQ0KIAkJCQkgc2l6ZW9mKHJlcSksIHRydWUp
Ow0KIH0NCiANCitpbnQgbXQ3OTE1X21jdV9zZXRfdGVzdF9wYXJhbShzdHJ1Y3QgbXQ3OTE1X2Rl
diAqZGV2LCB1OCBwYXJhbSwgYm9vbCB0ZXN0X21vZGUsDQorCQkJICAgICAgdTggZW4pDQorew0K
KwlzdHJ1Y3Qgew0KKwkJdTggdGVzdF9tb2RlX2VuOw0KKwkJdTggcGFyYW1faWR4Ow0KKwkJdTgg
X3JzdlsyXTsNCisNCisJCXU4IGVuYWJsZTsNCisJCXU4IF9yc3YyWzNdOw0KKw0KKwkJdTggcGFk
WzhdOw0KKwl9IF9fcGFja2VkIHJlcSA9IHsNCisJCS50ZXN0X21vZGVfZW4gPSB0ZXN0X21vZGUs
DQorCQkucGFyYW1faWR4ID0gcGFyYW0sDQorCQkuZW5hYmxlID0gZW4sDQorCX07DQorDQorCXJl
dHVybiBtdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LCBNQ1VfRVhUX0NNRF9BVEVfQ1RSTCwg
JnJlcSwNCisJCQkJIHNpemVvZihyZXEpLCBmYWxzZSk7DQorfQ0KKw0KIGludCBtdDc5MTVfbWN1
X3NldF9za3VfZW4oc3RydWN0IG10NzkxNV9waHkgKnBoeSwgYm9vbCBlbmFibGUpDQogew0KIAlz
dHJ1Y3QgbXQ3OTE1X2RldiAqZGV2ID0gcGh5LT5kZXY7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmggYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuaA0KaW5kZXggNWYyM2YyNy4uMGE3ZTlkMiAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21j
dS5oDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3Uu
aA0KQEAgLTQ2LDYgKzQ2LDEwIEBAIGVudW0gew0KIAlNQ1VfRVhUX0VWRU5UX1JBVEVfUkVQT1JU
ID0gMHg4NywNCiB9Ow0KIA0KK2VudW0gew0KKwlNQ1VfQVRFX1NFVF9UUlggPSAweDEsDQorfTsN
CisNCiBzdHJ1Y3QgbXQ3OTE1X21jdV9yeGQgew0KIAlfX2xlMzIgcnhkWzZdOw0KIA0KQEAgLTIx
Niw2ICsyMjAsNyBAQCBlbnVtIHsNCiAJTUNVX0VYVF9DTURfV1RCTF9VUERBVEUgPSAweDMyLA0K
IAlNQ1VfRVhUX0NNRF9TRVRfRFJSX0NUUkwgPSAweDM2LA0KIAlNQ1VfRVhUX0NNRF9TRVRfUkRE
X0NUUkwgPSAweDNhLA0KKwlNQ1VfRVhUX0NNRF9BVEVfQ1RSTCA9IDB4M2QsDQogCU1DVV9FWFRf
Q01EX1BST1RFQ1RfQ1RSTCA9IDB4M2UsDQogCU1DVV9FWFRfQ01EX01BQ19JTklUX0NUUkwgPSAw
eDQ2LA0KIAlNQ1VfRVhUX0NNRF9SWF9IRFJfVFJBTlMgPSAweDQ3LA0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5oIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmgNCmluZGV4IDQyOTIx
NTMuLjY3MzU5MTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tdDc5MTUuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MTUvbXQ3OTE1LmgNCkBAIC0xMDgsNiArMTA4LDggQEAgc3RydWN0IG10NzkxNV9w
aHkgew0KIA0KIAlzdHJ1Y3QgaWVlZTgwMjExX3NiYW5kX2lmdHlwZV9kYXRhIGlmdHlwZVsyXVtO
VU1fTkw4MDIxMV9JRlRZUEVTXTsNCiANCisJc3RydWN0IGllZWU4MDIxMV92aWYgKm1vbml0b3Jf
dmlmOw0KKw0KIAl1MzIgcnhmaWx0ZXI7DQogCXU2NCBvbWFjX21hc2s7DQogDQpAQCAtMTU4LDYg
KzE2MCwxNCBAQCBzdHJ1Y3QgbXQ3OTE1X2RldiB7DQogCXN0cnVjdCBpZHIgdG9rZW47DQogDQog
CWJvb2wgZndfZGVidWc7DQorDQorI2lmZGVmIENPTkZJR19OTDgwMjExX1RFU1RNT0RFDQorCXN0
cnVjdCB7DQorCQl1MzIgKnJlZ19iYWNrdXA7DQorDQorCQl1OCBzcGVfaWR4Ow0KKwl9IHRlc3Q7
DQorI2VuZGlmDQogfTsNCiANCiBlbnVtIHsNCkBAIC0yNDcsNiArMjU3LDcgQEAgc3RhdGljIGlu
bGluZSB1OCBtdDc5MTVfbG1hY19tYXBwaW5nKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHU4IGFj
KQ0KIA0KIGV4dGVybiBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX29wcyBtdDc5MTVfb3BzOw0KIGV4
dGVybiBzdHJ1Y3QgcGNpX2RyaXZlciBtdDc5MTVfcGNpX2RyaXZlcjsNCitleHRlcm4gY29uc3Qg
c3RydWN0IG10NzZfdGVzdG1vZGVfb3BzIG10NzkxNV90ZXN0bW9kZV9vcHM7DQogDQogdTMyIG10
NzkxNV9yZWdfbWFwKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHUzMiBhZGRyKTsNCiANCkBAIC0y
OTIsNiArMzAzLDcgQEAgaW50IG10NzkxNV9tY3VfYWRkX3JhdGVfY3RybChzdHJ1Y3QgbXQ3OTE1
X2RldiAqZGV2LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KIAkJCSAgICAgc3RydWN0IGll
ZWU4MDIxMV9zdGEgKnN0YSk7DQogaW50IG10NzkxNV9tY3VfYWRkX3NtcHMoc3RydWN0IG10Nzkx
NV9kZXYgKmRldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCiAJCQlzdHJ1Y3QgaWVlZTgw
MjExX3N0YSAqc3RhKTsNCitpbnQgbXQ3OTE1X3NldF9jaGFubmVsKHN0cnVjdCBtdDc5MTVfcGh5
ICpwaHkpOw0KIGludCBtdDc5MTVfbWN1X3NldF9jaGFuX2luZm8oc3RydWN0IG10NzkxNV9waHkg
KnBoeSwgaW50IGNtZCk7DQogaW50IG10NzkxNV9tY3Vfc2V0X3R4KHN0cnVjdCBtdDc5MTVfZGV2
ICpkZXYsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYpOw0KIGludCBtdDc5MTVfbWN1X3NldF9m
aXhlZF9yYXRlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsDQpAQCAtMzAwLDYgKzMxMiw4IEBAIGlu
dCBtdDc5MTVfbWN1X3NldF9lZXByb20oc3RydWN0IG10NzkxNV9kZXYgKmRldik7DQogaW50IG10
NzkxNV9tY3VfZ2V0X2VlcHJvbShzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCB1MzIgb2Zmc2V0KTsN
CiBpbnQgbXQ3OTE1X21jdV9zZXRfbWFjKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIGludCBiYW5k
LCBib29sIGVuYWJsZSwNCiAJCSAgICAgICBib29sIGhkcl90cmFucyk7DQoraW50IG10NzkxNV9t
Y3Vfc2V0X3Rlc3RfcGFyYW0oc3RydWN0IG10NzkxNV9kZXYgKmRldiwgdTggcGFyYW0sIGJvb2wg
dGVzdF9tb2RlLA0KKwkJCSAgICAgIHU4IGVuKTsNCiBpbnQgbXQ3OTE1X21jdV9zZXRfc2NzKHN0
cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHU4IGJhbmQsIGJvb2wgZW5hYmxlKTsNCiBpbnQgbXQ3OTE1
X21jdV9zZXRfc2VyKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHU4IGFjdGlvbiwgdTggc2V0LCB1
OCBiYW5kKTsNCiBpbnQgbXQ3OTE1X21jdV9zZXRfcnRzX3RocmVzaChzdHJ1Y3QgbXQ3OTE1X3Bo
eSAqcGh5LCB1MzIgdmFsKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9yZWdzLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9yZWdzLmgNCmluZGV4IGU0MjUyYzguLjkxYjYzNTYgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9yZWdzLmgNCisrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3JlZ3MuaA0KQEAgLTUxLDYg
KzUxLDkgQEANCiAjZGVmaW5lIE1UX1dGX1RNQUNfQkFTRShfYmFuZCkJCSgoX2JhbmQpID8gMHhh
MTAwMCA6IDB4MjEwMDApDQogI2RlZmluZSBNVF9XRl9UTUFDKF9iYW5kLCBvZnMpCQkoTVRfV0Zf
VE1BQ19CQVNFKF9iYW5kKSArIChvZnMpKQ0KIA0KKyNkZWZpbmUgTVRfVE1BQ19UQ1IwKF9iYW5k
KQkJTVRfV0ZfVE1BQyhfYmFuZCwgMCkNCisjZGVmaW5lIE1UX1RNQUNfVENSMF9UQlRUX1NUT1Bf
Q1RSTAlCSVQoMjUpDQorDQogI2RlZmluZSBNVF9UTUFDX0NEVFIoX2JhbmQpCQlNVF9XRl9UTUFD
KF9iYW5kLCAweDA5MCkNCiAjZGVmaW5lIE1UX1RNQUNfT0RUUihfYmFuZCkJCU1UX1dGX1RNQUMo
X2JhbmQsIDB4MDk0KQ0KICNkZWZpbmUgTVRfVElNRU9VVF9WQUxfUExDUAkJR0VOTUFTSygxNSwg
MCkNCkBAIC03Miw2ICs3NSw5IEBADQogI2RlZmluZSBNVF9UTUFDX0ZQMFIxOChfYmFuZCkJCU1U
X1dGX1RNQUMoX2JhbmQsIDB4MjcwKQ0KICNkZWZpbmUgTVRfVE1BQ19GUF9NQVNLCQkJR0VOTUFT
Syg3LCAwKQ0KIA0KKyNkZWZpbmUgTVRfVE1BQ19UUkNSMChfYmFuZCkJCU1UX1dGX1RNQUMoX2Jh
bmQsIDB4MDljKQ0KKyNkZWZpbmUgTVRfVE1BQ19URkNSMChfYmFuZCkJCU1UX1dGX1RNQUMoX2Jh
bmQsIDB4MWUwKQ0KKw0KIC8qIERNQSBCYW5kIDAgKi8NCiAjZGVmaW5lIE1UX1dGX0RNQV9CQVNF
CQkJMHgyMWUwMA0KICNkZWZpbmUgTVRfV0ZfRE1BKG9mcykJCQkoTVRfV0ZfRE1BX0JBU0UgKyAo
b2ZzKSkNCkBAIC0xNzEsMTAgKzE3NywzMyBAQA0KICNkZWZpbmUgTVRfV0ZfQUdHX0JBU0UoX2Jh
bmQpCQkoKF9iYW5kKSA/IDB4YTA4MDAgOiAweDIwODAwKQ0KICNkZWZpbmUgTVRfV0ZfQUdHKF9i
YW5kLCBvZnMpCQkoTVRfV0ZfQUdHX0JBU0UoX2JhbmQpICsgKG9mcykpDQogDQorI2RlZmluZSBN
VF9BR0dfQVdTQ1IwKF9iYW5kLCBfbikJCU1UX1dGX0FHRyhfYmFuZCwgMHgwNWMgKyAoX24pICog
NCkNCisjZGVmaW5lIE1UX0FHR19QQ1IwKF9iYW5kLCBfbikJCU1UX1dGX0FHRyhfYmFuZCwgMHgw
NmMgKyAoX24pICogNCkNCisjZGVmaW5lIE1UX0FHR19QQ1IwX01NX1BST1QJCUJJVCgwKQ0KKyNk
ZWZpbmUgTVRfQUdHX1BDUjBfR0ZfUFJPVAkJQklUKDEpDQorI2RlZmluZSBNVF9BR0dfUENSMF9C
VzIwX1BST1QJCUJJVCgyKQ0KKyNkZWZpbmUgTVRfQUdHX1BDUjBfQlc0MF9QUk9UCQlCSVQoNCkN
CisjZGVmaW5lIE1UX0FHR19QQ1IwX0JXODBfUFJPVAkJQklUKDYpDQorI2RlZmluZSBNVF9BR0df
UENSMF9FUlBfUFJPVAkJR0VOTUFTSygxMiwgOCkNCisjZGVmaW5lIE1UX0FHR19QQ1IwX1ZIVF9Q
Uk9UCQlCSVQoMTMpDQorI2RlZmluZSBNVF9BR0dfUENSMF9QVEFfV0lOX0RJUwkJQklUKDE1KQ0K
Kw0KKyNkZWZpbmUgTVRfQUdHX1BDUjFfUlRTMF9OVU1fVEhSRVMJR0VOTUFTSygzMSwgMjMpDQor
I2RlZmluZSBNVF9BR0dfUENSMV9SVFMwX0xFTl9USFJFUwlHRU5NQVNLKDE5LCAwKQ0KKw0KICNk
ZWZpbmUgTVRfQUdHX0FDUjAoX2JhbmQpCQlNVF9XRl9BR0coX2JhbmQsIDB4MDg0KQ0KICNkZWZp
bmUgTVRfQUdHX0FDUl9DRkVORF9SQVRFCQlHRU5NQVNLKDEzLCAwKQ0KICNkZWZpbmUgTVRfQUdH
X0FDUl9CQVJfUkFURQkJR0VOTUFTSygyOSwgMTYpDQogDQorI2RlZmluZSBNVF9BR0dfTVJDUihf
YmFuZCkJCU1UX1dGX0FHRyhfYmFuZCwgMHgwOTgpDQorI2RlZmluZSBNVF9BR0dfTVJDUl9CQVJf
Q05UX0xJTUlUCUdFTk1BU0soMTUsIDEyKQ0KKyNkZWZpbmUgTVRfQUdHX01SQ1JfTEFTVF9SVFNf
Q1RTX1JOCUJJVCg2KQ0KKyNkZWZpbmUgTVRfQUdHX01SQ1JfUlRTX0ZBSUxfTElNSVQJR0VOTUFT
SygxMSwgNykNCisjZGVmaW5lIE1UX0FHR19NUkNSX1RYQ01EX1JUU19GQUlMX0xJTUlUCUdFTk1B
U0soMjgsIDI0KQ0KKw0KKyNkZWZpbmUgTVRfQUdHX0FUQ1IxKF9iYW5kKQkJTVRfV0ZfQUdHKF9i
YW5kLCAweDBmMCkNCisjZGVmaW5lIE1UX0FHR19BVENSMyhfYmFuZCkJCU1UX1dGX0FHRyhfYmFu
ZCwgMHgwZjQpDQorDQogLyogQVJCOiBiYW5kIDAoMHgyMGMwMCksIGJhbmQgMSgweGEwYzAwKSAq
Lw0KICNkZWZpbmUgTVRfV0ZfQVJCX0JBU0UoX2JhbmQpCQkoKF9iYW5kKSA/IDB4YTBjMDAgOiAw
eDIwYzAwKQ0KICNkZWZpbmUgTVRfV0ZfQVJCKF9iYW5kLCBvZnMpCQkoTVRfV0ZfQVJCX0JBU0Uo
X2JhbmQpICsgKG9mcykpDQpAQCAtMTgzLDYgKzIxMiw4IEBADQogI2RlZmluZSBNVF9BUkJfU0NS
X1RYX0RJU0FCTEUJCUJJVCg4KQ0KICNkZWZpbmUgTVRfQVJCX1NDUl9SWF9ESVNBQkxFCQlCSVQo
OSkNCiANCisjZGVmaW5lIE1UX0FSQl9EUk5HUjAoX2JhbmQsIF9uKQlNVF9XRl9BUkIoX2JhbmQs
IDB4MTk0ICsgKF9uKSAqIDQpDQorDQogLyogUk1BQzogYmFuZCAwKDB4MjE0MDApLCBiYW5kIDEo
MHhhMTQwMCkgKi8NCiAjZGVmaW5lIE1UX1dGX1JNQUNfQkFTRShfYmFuZCkJCSgoX2JhbmQpID8g
MHhhMTQwMCA6IDB4MjE0MDApDQogI2RlZmluZSBNVF9XRl9STUFDKF9iYW5kLCBvZnMpCQkoTVRf
V0ZfUk1BQ19CQVNFKF9iYW5kKSArIChvZnMpKQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Rlc3Rtb2RlLmMgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS90ZXN0bW9kZS5jDQpuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KaW5kZXggMDAwMDAwMC4uNTNmYzk3Nw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1vZGUuYw0KQEAgLTAsMCArMSwx
ODAgQEANCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogSVNDDQorLyogQ29weXJpZ2h0IChD
KSAyMDIwIE1lZGlhVGVrIEluYy4gKi8NCisNCisjaW5jbHVkZSAibXQ3OTE1LmgiDQorI2luY2x1
ZGUgIm1hYy5oIg0KKyNpbmNsdWRlICJtY3UuaCINCisjaW5jbHVkZSAidGVzdG1vZGUuaCINCisN
CitzdHJ1Y3QgcmVnX2JhbmQgew0KKwl1MzIgYmFuZFsyXTsNCit9Ow0KKw0KKyNkZWZpbmUgUkVH
X0JBTkQoX3JlZykgXA0KKwl7IC5iYW5kWzBdID0gTVRfIyNfcmVnKDApLCAuYmFuZFsxXSA9IE1U
XyMjX3JlZygxKSB9DQorI2RlZmluZSBSRUdfQkFORF9JRFgoX3JlZywgX2lkeCkgXA0KKwl7IC5i
YW5kWzBdID0gTVRfIyNfcmVnKDAsIF9pZHgpLCAuYmFuZFsxXSA9IE1UXyMjX3JlZygxLCBfaWR4
KSB9DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCByZWdfYmFuZCByZWdfYmFja3VwX2xpc3RbXSA9
IHsNCisJUkVHX0JBTkRfSURYKEFHR19QQ1IwLCAwKSwNCisJUkVHX0JBTkRfSURYKEFHR19QQ1Iw
LCAxKSwNCisJUkVHX0JBTkRfSURYKEFHR19BV1NDUjAsIDApLA0KKwlSRUdfQkFORF9JRFgoQUdH
X0FXU0NSMCwgMSksDQorCVJFR19CQU5EX0lEWChBR0dfQVdTQ1IwLCAyKSwNCisJUkVHX0JBTkRf
SURYKEFHR19BV1NDUjAsIDMpLA0KKwlSRUdfQkFORChBR0dfTVJDUiksDQorCVJFR19CQU5EKFRN
QUNfVEZDUjApLA0KKwlSRUdfQkFORChUTUFDX1RDUjApLA0KKwlSRUdfQkFORChBR0dfQVRDUjEp
LA0KKwlSRUdfQkFORChBR0dfQVRDUjMpLA0KKwlSRUdfQkFORChUTUFDX1RSQ1IwKSwNCisJUkVH
X0JBTkQoVE1BQ19JQ1IwKSwNCisJUkVHX0JBTkRfSURYKEFSQl9EUk5HUjAsIDApLA0KKwlSRUdf
QkFORF9JRFgoQVJCX0RSTkdSMCwgMSksDQorfTsNCisNCitzdGF0aWMgaW50DQorbXQ3OTE1X3Rt
X21vZGVfY3RybChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBib29sIGVuYWJsZSkNCit7DQorCXN0
cnVjdCB7DQorCQl1OCBmb3JtYXRfaWQ7DQorCQlib29sIGVuYWJsZTsNCisJCXU4IHJzdlsyXTsN
CisJfSByZXEgPSB7DQorCQkuZm9ybWF0X2lkID0gMHg2LA0KKwkJLmVuYWJsZSA9IGVuYWJsZSwN
CisJfTsNCisNCisJcmV0dXJuIG10NzZfbWN1X3NlbmRfbXNnKCZkZXYtPm10NzYsDQorCQkJCSBN
Q1VfRVhUX0NNRF9UWF9QT1dFUl9GRUFUVVJFX0NUUkwsDQorCQkJCSAmcmVxLCBzaXplb2YocmVx
KSwgZmFsc2UpOw0KK30NCisNCitzdGF0aWMgaW50DQorbXQ3OTE1X3RtX3NldF90cngoc3RydWN0
IG10NzkxNV9kZXYgKmRldiwgc3RydWN0IG10NzkxNV9waHkgKnBoeSwNCisJCSAgaW50IHR5cGUs
IGJvb2wgZW4pDQorew0KKwlzdHJ1Y3QgbXQ3OTE1X3RtX2NtZCByZXEgPSB7DQorCQkudGVzdG1v
ZGVfZW4gPSAxLA0KKwkJLnBhcmFtX2lkeCA9IE1DVV9BVEVfU0VUX1RSWCwNCisJCS5wYXJhbS50
cngudHlwZSA9IHR5cGUsDQorCQkucGFyYW0udHJ4LmVuYWJsZSA9IGVuLA0KKwkJLnBhcmFtLnRy
eC5iYW5kID0gcGh5ICE9ICZkZXYtPnBoeSwNCisJfTsNCisNCisJcmV0dXJuIG10NzZfbWN1X3Nl
bmRfbXNnKCZkZXYtPm10NzYsIE1DVV9FWFRfQ01EX0FURV9DVFJMLCAmcmVxLA0KKwkJCQkgc2l6
ZW9mKHJlcSksIGZhbHNlKTsNCit9DQorDQorc3RhdGljIHZvaWQNCittdDc5MTVfdG1fcmVnX2Jh
Y2t1cF9yZXN0b3JlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBtdDc5MTVfcGh5ICpw
aHkpDQorew0KKwlpbnQgbl9yZWdzID0gQVJSQVlfU0laRShyZWdfYmFja3VwX2xpc3QpOw0KKwli
b29sIGV4dF9waHkgPSBwaHkgIT0gJmRldi0+cGh5Ow0KKwl1MzIgKmIgPSBkZXYtPnRlc3QucmVn
X2JhY2t1cDsNCisJaW50IGk7DQorDQorCWlmIChkZXYtPm10NzYudGVzdC5zdGF0ZSA9PSBNVDc2
X1RNX1NUQVRFX09GRikgew0KKwkJZm9yIChpID0gMDsgaSA8IG5fcmVnczsgaSsrKQ0KKwkJCW10
NzZfd3IoZGV2LCByZWdfYmFja3VwX2xpc3RbaV0uYmFuZFtleHRfcGh5XSwgYltpXSk7DQorCQly
ZXR1cm47DQorCX0NCisNCisJaWYgKGIpDQorCQlyZXR1cm47DQorDQorCWIgPSBkZXZtX2t6YWxs
b2MoZGV2LT5tdDc2LmRldiwgNCAqIG5fcmVncywgR0ZQX0tFUk5FTCk7DQorCWlmICghYikNCisJ
CXJldHVybjsNCisNCisJZGV2LT50ZXN0LnJlZ19iYWNrdXAgPSBiOw0KKwlmb3IgKGkgPSAwOyBp
IDwgbl9yZWdzOyBpKyspDQorCQliW2ldID0gbXQ3Nl9ycihkZXYsIHJlZ19iYWNrdXBfbGlzdFtp
XS5iYW5kW2V4dF9waHldKTsNCisNCisJbXQ3Nl9jbGVhcihkZXYsIE1UX0FHR19QQ1IwKGV4dF9w
aHksIDApLCBNVF9BR0dfUENSMF9NTV9QUk9UIHwNCisJCSAgIE1UX0FHR19QQ1IwX0dGX1BST1Qg
fCBNVF9BR0dfUENSMF9FUlBfUFJPVCB8DQorCQkgICBNVF9BR0dfUENSMF9WSFRfUFJPVCB8IE1U
X0FHR19QQ1IwX0JXMjBfUFJPVCB8DQorCQkgICBNVF9BR0dfUENSMF9CVzQwX1BST1QgfCBNVF9B
R0dfUENSMF9CVzgwX1BST1QpOw0KKwltdDc2X3NldChkZXYsIE1UX0FHR19QQ1IwKGV4dF9waHks
IDApLCBNVF9BR0dfUENSMF9QVEFfV0lOX0RJUyk7DQorDQorCW10NzZfd3IoZGV2LCBNVF9BR0df
UENSMChleHRfcGh5LCAxKSwgTVRfQUdHX1BDUjFfUlRTMF9OVU1fVEhSRVMgfA0KKwkJTVRfQUdH
X1BDUjFfUlRTMF9MRU5fVEhSRVMpOw0KKw0KKwltdDc2X2NsZWFyKGRldiwgTVRfQUdHX01SQ1Io
MCksIE1UX0FHR19NUkNSX0JBUl9DTlRfTElNSVQgfA0KKwkJICAgTVRfQUdHX01SQ1JfTEFTVF9S
VFNfQ1RTX1JOIHwgTVRfQUdHX01SQ1JfUlRTX0ZBSUxfTElNSVQgfA0KKwkJICAgTVRfQUdHX01S
Q1JfVFhDTURfUlRTX0ZBSUxfTElNSVQpOw0KKw0KKwltdDc2X3JtdyhkZXYsIE1UX0FHR19NUkNS
KDApLCBNVF9BR0dfTVJDUl9SVFNfRkFJTF9MSU1JVCB8DQorCQkgTVRfQUdHX01SQ1JfVFhDTURf
UlRTX0ZBSUxfTElNSVQsDQorCQkgRklFTERfUFJFUChNVF9BR0dfTVJDUl9SVFNfRkFJTF9MSU1J
VCwgMSkgfA0KKwkJIEZJRUxEX1BSRVAoTVRfQUdHX01SQ1JfVFhDTURfUlRTX0ZBSUxfTElNSVQs
IDEpKTsNCisNCisJbXQ3Nl93cihkZXYsIE1UX1RNQUNfVEZDUjAoMCksIDApOw0KKwltdDc2X2Ns
ZWFyKGRldiwgTVRfVE1BQ19UQ1IwKDApLCBNVF9UTUFDX1RDUjBfVEJUVF9TVE9QX0NUUkwpOw0K
K30NCisNCitzdGF0aWMgdm9pZA0KK210NzkxNV90bV9pbml0KHN0cnVjdCBtdDc5MTVfZGV2ICpk
ZXYpDQorew0KKwlib29sIGVuID0gIShkZXYtPm10NzYudGVzdC5zdGF0ZSA9PSBNVDc2X1RNX1NU
QVRFX09GRik7DQorDQorCWlmICghdGVzdF9iaXQoTVQ3Nl9TVEFURV9SVU5OSU5HLCAmZGV2LT5w
aHkubXQ3Ni0+c3RhdGUpKQ0KKwkJcmV0dXJuOw0KKw0KKwltdDc5MTVfdG1fbW9kZV9jdHJsKGRl
diwgZW4pOw0KKwltdDc5MTVfdG1fcmVnX2JhY2t1cF9yZXN0b3JlKGRldiwgJmRldi0+cGh5KTsN
CisJbXQ3OTE1X3RtX3NldF90cngoZGV2LCAmZGV2LT5waHksIFRNX01BQ19UWFJYLCAhZW4pOw0K
K30NCisNCitzdGF0aWMgdm9pZA0KK210NzkxNV90bV9zZXRfdHhfZnJhbWVzKHN0cnVjdCBtdDc5
MTVfZGV2ICpkZXYsIGJvb2wgZW4pDQorew0KKwlzdGF0aWMgY29uc3QgdTggc3BlX2lkeF9tYXBb
XSA9IHswLCAwLCAxLCAwLCAzLCAyLCA0LCAwLA0KKwkJCQkJIDksIDgsIDYsIDEwLCAxNiwgMTIs
IDE4LCAwfTsNCisJc3RydWN0IHNrX2J1ZmYgKnNrYiA9IGRldi0+bXQ3Ni50ZXN0LnR4X3NrYjsN
CisJc3RydWN0IGllZWU4MDIxMV90eF9pbmZvICppbmZvOw0KKw0KKwltdDc5MTVfdG1fc2V0X3Ry
eChkZXYsICZkZXYtPnBoeSwgVE1fTUFDX1JYX1JYViwgZmFsc2UpOw0KKw0KKwlpZiAoZW4pIHsN
CisJCXU4IHR4X2FudCA9IGRldi0+bXQ3Ni50ZXN0LnR4X2FudGVubmFfbWFzazsNCisNCisJCW11
dGV4X3VubG9jaygmZGV2LT5tdDc2Lm11dGV4KTsNCisJCW10NzkxNV9zZXRfY2hhbm5lbCgmZGV2
LT5waHkpOw0KKwkJbXV0ZXhfbG9jaygmZGV2LT5tdDc2Lm11dGV4KTsNCisNCisJCW10NzkxNV9t
Y3Vfc2V0X2NoYW5faW5mbygmZGV2LT5waHksIE1DVV9FWFRfQ01EX1NFVF9SWF9QQVRIKTsNCisJ
CWRldi0+dGVzdC5zcGVfaWR4ID0gc3BlX2lkeF9tYXBbdHhfYW50XTsNCisJfQ0KKw0KKwltdDc5
MTVfdG1fc2V0X3RyeChkZXYsICZkZXYtPnBoeSwgVE1fTUFDX1RYLCBlbik7DQorDQorCWlmICgh
ZW4gfHwgIXNrYikNCisJCXJldHVybjsNCisNCisJaW5mbyA9IElFRUU4MDIxMV9TS0JfQ0Ioc2ti
KTsNCisJaW5mby0+Y29udHJvbC52aWYgPSBkZXYtPnBoeS5tb25pdG9yX3ZpZjsNCit9DQorDQor
c3RhdGljIGludA0KK210NzkxNV90bV9zZXRfc3RhdGUoc3RydWN0IG10NzZfZGV2ICptZGV2LCBl
bnVtIG10NzZfdGVzdG1vZGVfc3RhdGUgc3RhdGUpDQorew0KKwlzdHJ1Y3QgbXQ3OTE1X2RldiAq
ZGV2ID0gY29udGFpbmVyX29mKG1kZXYsIHN0cnVjdCBtdDc5MTVfZGV2LCBtdDc2KTsNCisJc3Ry
dWN0IG10NzZfdGVzdG1vZGVfZGF0YSAqdGQgPSAmbWRldi0+dGVzdDsNCisJZW51bSBtdDc2X3Rl
c3Rtb2RlX3N0YXRlIHByZXZfc3RhdGUgPSB0ZC0+c3RhdGU7DQorDQorCW1kZXYtPnRlc3Quc3Rh
dGUgPSBzdGF0ZTsNCisNCisJaWYgKHByZXZfc3RhdGUgPT0gTVQ3Nl9UTV9TVEFURV9UWF9GUkFN
RVMpDQorCQltdDc5MTVfdG1fc2V0X3R4X2ZyYW1lcyhkZXYsIGZhbHNlKTsNCisJZWxzZSBpZiAo
c3RhdGUgPT0gTVQ3Nl9UTV9TVEFURV9UWF9GUkFNRVMpDQorCQltdDc5MTVfdG1fc2V0X3R4X2Zy
YW1lcyhkZXYsIHRydWUpOw0KKwllbHNlIGlmIChwcmV2X3N0YXRlID09IE1UNzZfVE1fU1RBVEVf
T0ZGIHx8IHN0YXRlID09IE1UNzZfVE1fU1RBVEVfT0ZGKQ0KKwkJbXQ3OTE1X3RtX2luaXQoZGV2
KTsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KK2NvbnN0IHN0cnVjdCBtdDc2X3Rlc3Rtb2RlX29w
cyBtdDc5MTVfdGVzdG1vZGVfb3BzID0gew0KKwkuc2V0X3N0YXRlID0gbXQ3OTE1X3RtX3NldF9z
dGF0ZSwNCit9Ow0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L3Rlc3Rtb2RlLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzkxNS90ZXN0bW9kZS5oDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4u
MDRmNGEyYw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1vZGUuaA0KQEAgLTAsMCArMSwzNCBAQA0KKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBJU0MNCisvKiBDb3B5cmlnaHQgKEMpIDIwMjAgTWVkaWFUZWsgSW5j
LiAqLw0KKw0KKyNpZm5kZWYgX19NVDc5MTVfVEVTVE1PREVfSA0KKyNkZWZpbmUgX19NVDc5MTVf
VEVTVE1PREVfSA0KKw0KK3N0cnVjdCBtdDc5MTVfdG1fdHJ4IHsNCisJdTggdHlwZTsNCisJdTgg
ZW5hYmxlOw0KKwl1OCBiYW5kOw0KKwl1OCByc3Y7DQorfTsNCisNCitzdHJ1Y3QgbXQ3OTE1X3Rt
X2NtZCB7DQorCXU4IHRlc3Rtb2RlX2VuOw0KKwl1OCBwYXJhbV9pZHg7DQorCXU4IF9yc3ZbMl07
DQorCXVuaW9uIHsNCisJCV9fbGUzMiBkYXRhOw0KKwkJc3RydWN0IG10NzkxNV90bV90cnggdHJ4
Ow0KKwkJdTggdGVzdFs3Ml07DQorCX0gcGFyYW07DQorfSBfX3BhY2tlZDsNCisNCitlbnVtIHsN
CisJVE1fTUFDX1RYID0gMSwNCisJVE1fTUFDX1JYLA0KKwlUTV9NQUNfVFhSWCwNCisJVE1fTUFD
X1RYUlhfUlhWLA0KKwlUTV9NQUNfUlhWLA0KKwlUTV9NQUNfUlhfUlhWLA0KK307DQorDQorI2Vu
ZGlmDQotLSANCjIuMTcuMQ0K

