Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B91728AC73
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 05:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgJLD0g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Oct 2020 23:26:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54570 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727157AbgJLD0f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Oct 2020 23:26:35 -0400
X-UUID: cf09e9cf8070453980e45c223ade5ef9-20201012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2TN7jVjMjbxZZhJmbSbjCMoCBxy54utpQMS3/Gy+B9A=;
        b=Si6WkEj2IPJWjZh+HBwTN/7+HqAHOKO35N7xTtLc0AqmAc9mbMUBtvhZ7iIjdR1IYPoKcUJXMbXLuK/yo5waK7FqXpRo/eW2L+lPGPF7Ol5vbHKizUNKmDcPpo+nS2e0DQRpmLBPN7I9385OEPSJPvcbDaC5oM7sVsBD811Xwxs=;
X-UUID: cf09e9cf8070453980e45c223ade5ef9-20201012
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1491985267; Mon, 12 Oct 2020 11:26:31 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Oct 2020 11:26:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 11:26:28 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 09/10] mt76: mt7915: add support to set txpower in testmode
Date:   Mon, 12 Oct 2020 11:25:37 +0800
Message-ID: <20201012032538.21314-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201012032538.21314-1-shayne.chen@mediatek.com>
References: <20201012032538.21314-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U3VwcG9ydCB0eF9wb3dlciBzZXR0aW5nIGluIHRlc3Rtb2RlLiBOb3RlIHRoYXQgdGhlIHR4IHBv
d2VyIHZhbHVlIG9mDQphbnRlbm5hIDEtMyBlcXVhbCB0byBhbnRlbm5hIDAuDQoNClJldmlld2Vk
LWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBT
aGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L3Rlc3Rtb2RlLmMgIHwgMTAwICsrKysrKysrKysrKysrKysr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvdGVzdG1vZGUuYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Rlc3Rtb2RlLmMNCmluZGV4IGNj
NWFiOTguLjMzOWY0N2EgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzkxNS90ZXN0bW9kZS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS90ZXN0bW9kZS5jDQpAQCAtNiw2ICs2LDE3IEBADQogI2luY2x1ZGUg
Im1jdS5oIg0KICNpbmNsdWRlICJ0ZXN0bW9kZS5oIg0KIA0KK2VudW0gew0KKwlUTV9DSEFOR0VE
X1RYUE9XRVIsDQorDQorCS8qIG11c3QgYmUgbGFzdCAqLw0KKwlOVU1fVE1fQ0hBTkdFRA0KK307
DQorDQorc3RhdGljIGNvbnN0IHU4IHRtX2NoYW5nZV9tYXBbXSA9IHsNCisJW1RNX0NIQU5HRURf
VFhQT1dFUl0gPSBNVDc2X1RNX0FUVFJfVFhfUE9XRVIsDQorfTsNCisNCiBzdHJ1Y3QgcmVnX2Jh
bmQgew0KIAl1MzIgYmFuZFsyXTsNCiB9Ow0KQEAgLTMzLDYgKzQ0LDQyIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgcmVnX2JhbmQgcmVnX2JhY2t1cF9saXN0W10gPSB7DQogCVJFR19CQU5EX0lEWChB
UkJfRFJOR1IwLCAxKSwNCiB9Ow0KIA0KK3N0YXRpYyBpbnQNCittdDc5MTVfdG1fc2V0X3R4X3Bv
d2VyKHN0cnVjdCBtdDc5MTVfcGh5ICpwaHkpDQorew0KKwlzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2
ID0gcGh5LT5kZXY7DQorCXN0cnVjdCBtdDc2X3BoeSAqbXBoeSA9IHBoeS0+bXQ3NjsNCisJc3Ry
dWN0IGNmZzgwMjExX2NoYW5fZGVmICpjaGFuZGVmID0gJm1waHktPmNoYW5kZWY7DQorCWludCBm
cmVxID0gY2hhbmRlZi0+Y2VudGVyX2ZyZXExOw0KKwlpbnQgcmV0Ow0KKwlzdHJ1Y3Qgew0KKwkJ
dTggZm9ybWF0X2lkOw0KKwkJdTggZGJkY19pZHg7DQorCQlzOCB0eF9wb3dlcjsNCisJCXU4IGFu
dF9pZHg7CS8qIE9ubHkgMCBpcyB2YWxpZCAqLw0KKwkJdTggY2VudGVyX2NoYW47DQorCQl1OCBy
c3ZbM107DQorCX0gX19wYWNrZWQgcmVxID0gew0KKwkJLmZvcm1hdF9pZCA9IDB4ZiwNCisJCS5k
YmRjX2lkeCA9IHBoeSAhPSAmZGV2LT5waHksDQorCQkuY2VudGVyX2NoYW4gPSBpZWVlODAyMTFf
ZnJlcXVlbmN5X3RvX2NoYW5uZWwoZnJlcSksDQorCX07DQorCXU4ICp0eF9wb3dlciA9IE5VTEw7
DQorDQorCWlmIChkZXYtPm10NzYudGVzdC5zdGF0ZSAhPSBNVDc2X1RNX1NUQVRFX09GRikNCisJ
CXR4X3Bvd2VyID0gZGV2LT5tdDc2LnRlc3QudHhfcG93ZXI7DQorDQorCS8qIFR4IHBvd2VyIG9m
IHRoZSBvdGhlciBhbnRlbm5hcyBhcmUgdGhlIHNhbWUgYXMgYW50ZW5uYSAwICovDQorCWlmICh0
eF9wb3dlciAmJiB0eF9wb3dlclswXSkNCisJCXJlcS50eF9wb3dlciA9IHR4X3Bvd2VyWzBdOw0K
Kw0KKwlyZXQgPSBtdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LA0KKwkJCQlNQ1VfRVhUX0NN
RF9UWF9QT1dFUl9GRUFUVVJFX0NUUkwsDQorCQkJCSZyZXEsIHNpemVvZihyZXEpLCBmYWxzZSk7
DQorDQorCXJldHVybiByZXQ7DQorfQ0KKw0KIHN0YXRpYyBpbnQNCiBtdDc5MTVfdG1fbW9kZV9j
dHJsKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIGJvb2wgZW5hYmxlKQ0KIHsNCkBAIC0xOTYsNiAr
MjQzLDEzIEBAIG10NzkxNV90bV9zZXRfcnhfZnJhbWVzKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYs
IGJvb2wgZW4pDQogCW10NzkxNV90bV9zZXRfdHJ4KGRldiwgJmRldi0+cGh5LCBUTV9NQUNfUlhf
UlhWLCBlbik7DQogfQ0KIA0KK3N0YXRpYyB2b2lkDQorbXQ3OTE1X3RtX3VwZGF0ZV9wYXJhbXMo
c3RydWN0IG10NzkxNV9kZXYgKmRldiwgdTMyIGNoYW5nZWQpDQorew0KKwlpZiAoY2hhbmdlZCAm
IEJJVChUTV9DSEFOR0VEX1RYUE9XRVIpKQ0KKwkJbXQ3OTE1X3RtX3NldF90eF9wb3dlcigmZGV2
LT5waHkpOw0KK30NCisNCiBzdGF0aWMgaW50DQogbXQ3OTE1X3RtX3NldF9zdGF0ZShzdHJ1Y3Qg
bXQ3Nl9kZXYgKm1kZXYsIGVudW0gbXQ3Nl90ZXN0bW9kZV9zdGF0ZSBzdGF0ZSkNCiB7DQpAQCAt
MjE2LDYgKzI3MCw1MSBAQCBtdDc5MTVfdG1fc2V0X3N0YXRlKHN0cnVjdCBtdDc2X2RldiAqbWRl
diwgZW51bSBtdDc2X3Rlc3Rtb2RlX3N0YXRlIHN0YXRlKQ0KIAllbHNlIGlmIChwcmV2X3N0YXRl
ID09IE1UNzZfVE1fU1RBVEVfT0ZGIHx8IHN0YXRlID09IE1UNzZfVE1fU1RBVEVfT0ZGKQ0KIAkJ
bXQ3OTE1X3RtX2luaXQoZGV2KTsNCiANCisJaWYgKChzdGF0ZSA9PSBNVDc2X1RNX1NUQVRFX0lE
TEUgJiYNCisJICAgICBwcmV2X3N0YXRlID09IE1UNzZfVE1fU1RBVEVfT0ZGKSB8fA0KKwkgICAg
KHN0YXRlID09IE1UNzZfVE1fU1RBVEVfT0ZGICYmDQorCSAgICAgcHJldl9zdGF0ZSA9PSBNVDc2
X1RNX1NUQVRFX0lETEUpKSB7DQorCQl1MzIgY2hhbmdlZCA9IDA7DQorCQlpbnQgaTsNCisNCisJ
CWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHRtX2NoYW5nZV9tYXApOyBpKyspIHsNCisJCQl1
MTYgY3VyID0gdG1fY2hhbmdlX21hcFtpXTsNCisNCisJCQlpZiAodGQtPnBhcmFtX3NldFtjdXIg
LyAzMl0gJiBCSVQoY3VyICUgMzIpKQ0KKwkJCQljaGFuZ2VkIHw9IEJJVChpKTsNCisJCX0NCisN
CisJCW10NzkxNV90bV91cGRhdGVfcGFyYW1zKGRldiwgY2hhbmdlZCk7DQorCX0NCisNCisJcmV0
dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyBpbnQNCittdDc5MTVfdG1fc2V0X3BhcmFtcyhzdHJ1Y3Qg
bXQ3Nl9kZXYgKm1kZXYsIHN0cnVjdCBubGF0dHIgKip0YiwNCisJCSAgICAgZW51bSBtdDc2X3Rl
c3Rtb2RlX3N0YXRlIG5ld19zdGF0ZSkNCit7DQorCXN0cnVjdCBtdDc5MTVfZGV2ICpkZXYgPSBj
b250YWluZXJfb2YobWRldiwgc3RydWN0IG10NzkxNV9kZXYsIG10NzYpOw0KKwlzdHJ1Y3QgbXQ3
Nl90ZXN0bW9kZV9kYXRhICp0ZCA9ICZkZXYtPm10NzYudGVzdDsNCisJdTMyIGNoYW5nZWQgPSAw
Ow0KKwlpbnQgaTsNCisNCisJQlVJTERfQlVHX09OKE5VTV9UTV9DSEFOR0VEID49IDMyKTsNCisN
CisJaWYgKG5ld19zdGF0ZSA9PSBNVDc2X1RNX1NUQVRFX09GRiB8fA0KKwkgICAgdGQtPnN0YXRl
ID09IE1UNzZfVE1fU1RBVEVfT0ZGKQ0KKwkJcmV0dXJuIDA7DQorDQorCWlmICh0ZC0+dHhfYW50
ZW5uYV9tYXNrICYgfmRldi0+cGh5LmNoYWlubWFzaykNCisJCXJldHVybiAtRUlOVkFMOw0KKw0K
Kwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh0bV9jaGFuZ2VfbWFwKTsgaSsrKSB7DQorCQlp
ZiAodGJbdG1fY2hhbmdlX21hcFtpXV0pDQorCQkJY2hhbmdlZCB8PSBCSVQoaSk7DQorCX0NCisN
CisJbXQ3OTE1X3RtX3VwZGF0ZV9wYXJhbXMoZGV2LCBjaGFuZ2VkKTsNCisNCiAJcmV0dXJuIDA7
DQogfQ0KIA0KQEAgLTI3Myw1ICszNzIsNiBAQCBtdDc5MTVfdG1fZHVtcF9zdGF0cyhzdHJ1Y3Qg
bXQ3Nl9kZXYgKm1kZXYsIHN0cnVjdCBza19idWZmICptc2cpDQogDQogY29uc3Qgc3RydWN0IG10
NzZfdGVzdG1vZGVfb3BzIG10NzkxNV90ZXN0bW9kZV9vcHMgPSB7DQogCS5zZXRfc3RhdGUgPSBt
dDc5MTVfdG1fc2V0X3N0YXRlLA0KKwkuc2V0X3BhcmFtcyA9IG10NzkxNV90bV9zZXRfcGFyYW1z
LA0KIAkuZHVtcF9zdGF0cyA9IG10NzkxNV90bV9kdW1wX3N0YXRzLA0KIH07DQotLSANCjIuMTcu
MQ0K

