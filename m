Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461BD1A8D17
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 23:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633579AbgDNVCM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 17:02:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47633 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2633564AbgDNVBu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 17:01:50 -0400
X-UUID: ade5d2f928d343c9a82687ceee4dcecc-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Q0KuVQkH3OPUeMZiYOYmpsxrkYmoMi9sq3Xu3C/T3Nw=;
        b=Cn7tUqQr7tCpBcbqF+cDN9lIIbFPiEwQM6UlHwJ7wPhppDZ2+8e768dnI/1gaZIg4sDwusz0QyXlgsh8y/MTk23HF/bl8yzlC80pjhyfnPL4J1OowOeHzArKHDBtPg1rIW7LkZvF/i4vJAj78t06HXyBrEkkRTrfOr1aaM+2ZPM=;
X-UUID: ade5d2f928d343c9a82687ceee4dcecc-20200415
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1203836020; Wed, 15 Apr 2020 05:01:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 05:01:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Apr 2020 05:01:23 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 07/18] mt76: mt7915: enable Rx HE rate reporting
Date:   Wed, 15 Apr 2020 05:01:05 +0800
Message-ID: <b24ee1958c7da0b2cdb336dd0e60259dfde59e28.1586895593.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1586895593.git.ryder.lee@mediatek.com>
References: <cover.1586895593.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RW5hYmxlIEhFIHJhdGUgcmVwb3J0aW5nIGluIFJ4IHBhdGgNCg0KU2lnbmVkLW9mZi1ieTogUnlk
ZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogU2hheW5lIENo
ZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jICB8ICAyICsrDQogLi4uL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9tYWMuYyAgIHwgMjcgKysrKysrKysrKysrKysrKystLQ0KIC4uLi9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmggICB8ICAyICsrDQogLi4uL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9yZWdzLmggIHwgIDEgKw0KIDQgZmlsZXMg
Y2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0KaW5kZXggZmI1OTZh
ZmRmMGJlLi5mOTM4NGUxZGFiNzQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0KQEAgLTQzLDYgKzQzLDggQEAgc3RhdGljIHZvaWQg
bXQ3OTE1X21hY19pbml0KHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYpDQogDQogCW10NzZfcm13X2Zp
ZWxkKGRldiwgTVRfRE1BX0RDUjAsIE1UX0RNQV9EQ1IwX01BWF9SWF9MRU4sIDE1MzYpOw0KIAlt
dDc2X3Jtd19maWVsZChkZXYsIE1UX01EUF9EQ1IxLCBNVF9NRFBfRENSMV9NQVhfUlhfTEVOLCAx
NTM2KTsNCisJLyogZW5hYmxlIHJ4IHJhdGUgcmVwb3J0ICovDQorCW10NzZfc2V0KGRldiwgTVRf
RE1BX0RDUjAsIE1UX0RNQV9EQ1IwX1JYRF9HNV9FTik7DQogCS8qIGRpc2FibGUgaGFyZHdhcmUg
ZGUtYWdnICovDQogCW10NzZfY2xlYXIoZGV2LCBNVF9NRFBfRENSMCwgTVRfTURQX0RDUjBfREFN
U0RVX0VOKTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9tYWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTE1L21hYy5jDQppbmRleCBiN2ZlZDY0Mjg2NWMuLjUxMWE2ZDJlOGRkMSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jDQorKysgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWMuYw0KQEAgLTM0Nyw2
ICszNDcsMjIgQEAgaW50IG10NzkxNV9tYWNfZmlsbF9yeChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KIAkJCQlpZiAoaSA+IDkpDQogCQkJCQlyZXR1cm4gLUVJ
TlZBTDsNCiAJCQkJYnJlYWs7DQorCQkJY2FzZSBNVF9QSFlfVFlQRV9IRV9NVToNCisJCQkJLyog
ZmFsbCB0aHJvdWdoICovDQorCQkJY2FzZSBNVF9QSFlfVFlQRV9IRV9TVToNCisJCQljYXNlIE1U
X1BIWV9UWVBFX0hFX0VYVF9TVToNCisJCQljYXNlIE1UX1BIWV9UWVBFX0hFX1RCOg0KKwkJCQlz
dGF0dXMtPm5zcyA9DQorCQkJCQlGSUVMRF9HRVQoTVRfUFJYVl9OU1RTLCByeHYudlswXSkgKyAx
Ow0KKwkJCQlzdGF0dXMtPmVuY29kaW5nID0gUlhfRU5DX0hFOw0KKwkJCQlpICY9IEdFTk1BU0so
MywgMCk7DQorDQorCQkJCWlmIChnaSA8PSBOTDgwMjExX1JBVEVfSU5GT19IRV9HSV8zXzIpDQor
CQkJCQlzdGF0dXMtPmhlX2dpID0gZ2k7DQorDQorCQkJCWlmIChpZHggJiBNVF9QUlhWX1RYX0RD
TSkNCisJCQkJCXN0YXR1cy0+aGVfZGNtID0gdHJ1ZTsNCisJCQkJYnJlYWs7DQogCQkJZGVmYXVs
dDoNCiAJCQkJcmV0dXJuIC1FSU5WQUw7DQogCQkJfQ0KQEAgLTM1Niw3ICszNzIsMTQgQEAgaW50
IG10NzkxNV9tYWNfZmlsbF9yeChzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiKQ0KIAkJCWNhc2UgSUVFRTgwMjExX1NUQV9SWF9CV18yMDoNCiAJCQkJYnJlYWs7DQog
CQkJY2FzZSBJRUVFODAyMTFfU1RBX1JYX0JXXzQwOg0KLQkJCQlzdGF0dXMtPmJ3ID0gUkFURV9J
TkZPX0JXXzQwOw0KKwkJCQlpZiAocnh2LnBoeSAmIE1UX1BIWV9UWVBFX0hFX0VYVF9TVSAmJg0K
KwkJCQkgICAgKGlkeCAmIE1UX1BSWFZfVFhfRVJfU1VfMTA2VCkpIHsNCisJCQkJCXN0YXR1cy0+
YncgPSBSQVRFX0lORk9fQldfSEVfUlU7DQorCQkJCQlzdGF0dXMtPmhlX3J1ID0NCisJCQkJCQlO
TDgwMjExX1JBVEVfSU5GT19IRV9SVV9BTExPQ18xMDY7DQorCQkJCX0gZWxzZSB7DQorCQkJCQlz
dGF0dXMtPmJ3ID0gUkFURV9JTkZPX0JXXzQwOw0KKwkJCQl9DQogCQkJCWJyZWFrOw0KIAkJCWNh
c2UgSUVFRTgwMjExX1NUQV9SWF9CV184MDoNCiAJCQkJc3RhdHVzLT5idyA9IFJBVEVfSU5GT19C
V184MDsNCkBAIC0zNjksNyArMzkyLDcgQEAgaW50IG10NzkxNV9tYWNfZmlsbF9yeChzdHJ1Y3Qg
bXQ3OTE1X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KIAkJCX0NCiANCiAJCQlzdGF0
dXMtPmVuY19mbGFncyB8PSBSWF9FTkNfRkxBR19TVEJDX01BU0sgKiBzdGJjOw0KLQkJCWlmIChn
aSkNCisJCQlpZiAocnh2LnBoeSA8IE1UX1BIWV9UWVBFX0hFX1NVICYmIGdpKQ0KIAkJCQlzdGF0
dXMtPmVuY19mbGFncyB8PSBSWF9FTkNfRkxBR19TSE9SVF9HSTsNCiAJCX0NCiAJfQ0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5oIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmgNCmluZGV4IDdk
YTc1NTFmOThlNC4uNzEyNzUzNDg0YWVlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5oDQpAQCAtOTcsNiArOTcsOCBAQCBlbnVtIHJ4X3Br
dF90eXBlIHsNCiANCiAvKiBQLVJYViAqLw0KICNkZWZpbmUgTVRfUFJYVl9UWF9SQVRFCQkJR0VO
TUFTSyg2LCAwKQ0KKyNkZWZpbmUgTVRfUFJYVl9UWF9EQ00JCQlCSVQoNCkNCisjZGVmaW5lIE1U
X1BSWFZfVFhfRVJfU1VfMTA2VAkJQklUKDUpDQogI2RlZmluZSBNVF9QUlhWX05TVFMJCQlHRU5N
QVNLKDksIDcpDQogI2RlZmluZSBNVF9QUlhWX0hUX0FEX0NPREUJCUJJVCgxMSkNCiAjZGVmaW5l
IE1UX1BSWFZfUkNQSTMJCQlHRU5NQVNLKDMxLCAyNCkNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9yZWdzLmggYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9yZWdzLmgNCmluZGV4IGVmODc1NzkwNTZmZS4uNTcy
YmRjMTZmYjJkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvcmVncy5oDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzkxNS9yZWdzLmgNCkBAIC03Myw2ICs3Myw3IEBADQogDQogI2RlZmluZSBNVF9ETUFfRENS
MAkJCU1UX1dGX0RNQSgweDAwMCkNCiAjZGVmaW5lIE1UX0RNQV9EQ1IwX01BWF9SWF9MRU4JCUdF
Tk1BU0soMTUsIDMpDQorI2RlZmluZSBNVF9ETUFfRENSMF9SWERfRzVfRU4JCUJJVCgyMykNCiAN
CiAvKiBNSUI6IGJhbmQgMCgweDI0ODAwKSwgYmFuZCAxKDB4YTQ4MDApICovDQogI2RlZmluZSBN
VF9XRl9NSUJfQkFTRShfYmFuZCkJCSgoX2JhbmQpID8gMHhhNDgwMCA6IDB4MjQ4MDApDQotLSAN
CjIuMTguMA0K

