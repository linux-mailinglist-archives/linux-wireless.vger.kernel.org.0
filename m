Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698DC1A8D24
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 23:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633614AbgDNVDd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 17:03:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3408 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2633581AbgDNVCB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 17:02:01 -0400
X-UUID: acba19abd5544550a07864ad417d02e9-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PrMrGQUfXMNhRG58H8+GNHeDRKweulvlAJdxD1OYkqE=;
        b=ot7CvZsEmPT07XGAlM9EYs1Yu76ule+skpRiVtR9530o6AT93oI4bQwwgK+D4yewaEl5134VU7b0MqwDNyIxFiMB0Z7JLNaRfE5BTOVl/UBB/+91oJ/zfDmN1YpcRhGk+QLSPjMRBLPLg0hPUJby3u9iHpoa/KPp0zL6hXTZauA=;
X-UUID: acba19abd5544550a07864ad417d02e9-20200415
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 488875829; Wed, 15 Apr 2020 05:01:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 05:01:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Apr 2020 05:01:37 +0800
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
Subject: [PATCH v2 16/18] mt76: mt7915: add tsf related callbacks
Date:   Wed, 15 Apr 2020 05:01:14 +0800
Message-ID: <ecbe495a0275e9742aa81baf4681a950558dceef.1586895593.git.ryder.lee@mediatek.com>
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

SXQgaXMgdXNlZnVsIGZvciBJQlNTIE1lc2ggdG8gYWRqdXN0IHRfY2xvY2tkcmlmdC4NCg0KU2ln
bmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KUmVwb3J0ZWQt
Ynk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQpUZXN0ZWQtYnk6IEV2
ZWx5biBUc2FpIDxldmVseW4udHNhaUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYyAgfCA1MyArKysrKysrKysrKysrKysrKysr
DQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9yZWdzLmggIHwgMTEgKysr
Kw0KIDIgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5jIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5jDQppbmRleCBiM2UyNmZmMzIy
ODcuLmVmMGM5MTk5MGI0OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3OTE1L21haW4uYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5jDQpAQCAtNjU1LDYgKzY1NSw1NyBAQCBtdDc5MTVfZ2V0X3N0
YXRzKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0KIAlyZXR1cm4gMDsNCiB9DQogDQorc3RhdGlj
IHU2NA0KK210NzkxNV9nZXRfdHNmKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVl
ZTgwMjExX3ZpZiAqdmlmKQ0KK3sNCisJc3RydWN0IG10NzkxNV92aWYgKm12aWYgPSAoc3RydWN0
IG10NzkxNV92aWYgKil2aWYtPmRydl9wcml2Ow0KKwlzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2ID0g
bXQ3OTE1X2h3X2Rldihodyk7DQorCXN0cnVjdCBtdDc5MTVfcGh5ICpwaHkgPSBtdDc5MTVfaHdf
cGh5KGh3KTsNCisJYm9vbCBiYW5kID0gcGh5ICE9ICZkZXYtPnBoeTsNCisJdW5pb24gew0KKwkJ
dTY0IHQ2NDsNCisJCXUzMiB0MzJbMl07DQorCX0gdHNmOw0KKwl1MTYgbjsNCisNCisJbXV0ZXhf
bG9jaygmZGV2LT5tdDc2Lm11dGV4KTsNCisNCisJbiA9IG12aWYtPm9tYWNfaWR4ID4gSFdfQlNT
SURfTUFYID8gSFdfQlNTSURfMCA6IG12aWYtPm9tYWNfaWR4Ow0KKwkvKiBUU0Ygc29mdHdhcmUg
cmVhZCAqLw0KKwltdDc2X3NldChkZXYsIE1UX0xQT05fVENSKGJhbmQsIG4pLCBNVF9MUE9OX1RD
Ul9TV19NT0RFKTsNCisJdHNmLnQzMlswXSA9IG10NzZfcnIoZGV2LCBNVF9MUE9OX1VUVFIwKGJh
bmQpKTsNCisJdHNmLnQzMlsxXSA9IG10NzZfcnIoZGV2LCBNVF9MUE9OX1VUVFIxKGJhbmQpKTsN
CisNCisJbXV0ZXhfdW5sb2NrKCZkZXYtPm10NzYubXV0ZXgpOw0KKw0KKwlyZXR1cm4gdHNmLnQ2
NDsNCit9DQorDQorc3RhdGljIHZvaWQNCittdDc5MTVfc2V0X3RzZihzdHJ1Y3QgaWVlZTgwMjEx
X2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCisJICAgICAgIHU2NCB0aW1lc3Rh
bXApDQorew0KKwlzdHJ1Y3QgbXQ3OTE1X3ZpZiAqbXZpZiA9IChzdHJ1Y3QgbXQ3OTE1X3ZpZiAq
KXZpZi0+ZHJ2X3ByaXY7DQorCXN0cnVjdCBtdDc5MTVfZGV2ICpkZXYgPSBtdDc5MTVfaHdfZGV2
KGh3KTsNCisJc3RydWN0IG10NzkxNV9waHkgKnBoeSA9IG10NzkxNV9od19waHkoaHcpOw0KKwli
b29sIGJhbmQgPSBwaHkgIT0gJmRldi0+cGh5Ow0KKwl1bmlvbiB7DQorCQl1NjQgdDY0Ow0KKwkJ
dTMyIHQzMlsyXTsNCisJfSB0c2YgPSB7IC50NjQgPSB0aW1lc3RhbXAsIH07DQorCXUxNiBuOw0K
Kw0KKwltdXRleF9sb2NrKCZkZXYtPm10NzYubXV0ZXgpOw0KKw0KKwluID0gbXZpZi0+b21hY19p
ZHggPiBIV19CU1NJRF9NQVggPyBIV19CU1NJRF8wIDogbXZpZi0+b21hY19pZHg7DQorCW10NzZf
d3IoZGV2LCBNVF9MUE9OX1VUVFIwKGJhbmQpLCB0c2YudDMyWzBdKTsNCisJbXQ3Nl93cihkZXYs
IE1UX0xQT05fVVRUUjEoYmFuZCksIHRzZi50MzJbMV0pOw0KKwkvKiBUU0Ygc29mdHdhcmUgb3Zl
cndyaXRlICovDQorCW10NzZfc2V0KGRldiwgTVRfTFBPTl9UQ1IoYmFuZCwgbiksIE1UX0xQT05f
VENSX1NXX1dSSVRFKTsNCisNCisJbXV0ZXhfdW5sb2NrKCZkZXYtPm10NzYubXV0ZXgpOw0KK30N
CisNCiBzdGF0aWMgdm9pZA0KIG10NzkxNV9zZXRfY292ZXJhZ2VfY2xhc3Moc3RydWN0IGllZWU4
MDIxMV9odyAqaHcsIHMxNiBjb3ZlcmFnZV9jbGFzcykNCiB7DQpAQCAtNzY3LDYgKzgxOCw4IEBA
IGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfb3BzIG10NzkxNV9vcHMgPSB7DQogCS5nZXRfdHhwb3dl
ciA9IG10NzZfZ2V0X3R4cG93ZXIsDQogCS5jaGFubmVsX3N3aXRjaF9iZWFjb24gPSBtdDc5MTVf
Y2hhbm5lbF9zd2l0Y2hfYmVhY29uLA0KIAkuZ2V0X3N0YXRzID0gbXQ3OTE1X2dldF9zdGF0cywN
CisJLmdldF90c2YgPSBtdDc5MTVfZ2V0X3RzZiwNCisJLnNldF90c2YgPSBtdDc5MTVfc2V0X3Rz
ZiwNCiAJLmdldF9zdXJ2ZXkgPSBtdDc2X2dldF9zdXJ2ZXksDQogCS5nZXRfYW50ZW5uYSA9IG10
NzZfZ2V0X2FudGVubmEsDQogCS5zZXRfYW50ZW5uYSA9IG10NzkxNV9zZXRfYW50ZW5uYSwNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9yZWdz
LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9yZWdzLmgNCmlu
ZGV4IDU3MmJkYzE2ZmIyZC4uNjYwMGZjNjI1MTk2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvcmVncy5oDQorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9yZWdzLmgNCkBAIC03NSw2ICs3NSwxNyBAQA0K
ICNkZWZpbmUgTVRfRE1BX0RDUjBfTUFYX1JYX0xFTgkJR0VOTUFTSygxNSwgMykNCiAjZGVmaW5l
IE1UX0RNQV9EQ1IwX1JYRF9HNV9FTgkJQklUKDIzKQ0KIA0KKy8qIExQT046IGJhbmQgMCgweDI0
MjAwKSwgYmFuZCAxKDB4YTQyMDApICovDQorI2RlZmluZSBNVF9XRl9MUE9OX0JBU0UoX2JhbmQp
CQkoKF9iYW5kKSA/IDB4YTQyMDAgOiAweDI0MjAwKQ0KKyNkZWZpbmUgTVRfV0ZfTFBPTihfYmFu
ZCwgb2ZzKQkJKE1UX1dGX0xQT05fQkFTRShfYmFuZCkgKyAob2ZzKSkNCisNCisjZGVmaW5lIE1U
X0xQT05fVVRUUjAoX2JhbmQpCQlNVF9XRl9MUE9OKF9iYW5kLCAweDA4MCkNCisjZGVmaW5lIE1U
X0xQT05fVVRUUjEoX2JhbmQpCQlNVF9XRl9MUE9OKF9iYW5kLCAweDA4NCkNCisNCisjZGVmaW5l
IE1UX0xQT05fVENSKF9iYW5kLCBuKQkJTVRfV0ZfTFBPTihfYmFuZCwgMHgwYTggKyAobikgKiA0
KQ0KKyNkZWZpbmUgTVRfTFBPTl9UQ1JfU1dfTU9ERQkJR0VOTUFTSygxLCAwKQ0KKyNkZWZpbmUg
TVRfTFBPTl9UQ1JfU1dfV1JJVEUJCUJJVCgwKQ0KKw0KIC8qIE1JQjogYmFuZCAwKDB4MjQ4MDAp
LCBiYW5kIDEoMHhhNDgwMCkgKi8NCiAjZGVmaW5lIE1UX1dGX01JQl9CQVNFKF9iYW5kKQkJKChf
YmFuZCkgPyAweGE0ODAwIDogMHgyNDgwMCkNCiAjZGVmaW5lIE1UX1dGX01JQihfYmFuZCwgb2Zz
KQkJKE1UX1dGX01JQl9CQVNFKF9iYW5kKSArIChvZnMpKQ0KLS0gDQoyLjE4LjANCg==

