Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8042005F8
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2020 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgFSKEo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jun 2020 06:04:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6986 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731419AbgFSKEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jun 2020 06:04:43 -0400
X-UUID: 415bf6f00c484cc98a792b306a6f47a9-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kMusfDarPb/KK+NktRNU53kwkwnAYp5on8NunFNTVkU=;
        b=TuZEyFt6KHaikNreuGV1lL/UByFMqxpT83YQWh27FN2T6ZKOFq+v0C5c46/VuRwEW+6rlLr/VNjWRVpUIsg+v9C50ice0kg7j8orptG+8AxAi78E5hsrl4/YNWH/miQrvBncadlAbkByrYhtxibnCFsQqylLl+1+rpJp3CRo9SA=;
X-UUID: 415bf6f00c484cc98a792b306a6f47a9-20200619
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1723526728; Fri, 19 Jun 2020 18:04:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 18:04:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 18:04:33 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v3 1/3] mt76: mt7915: add support for DT rate power limits
Date:   Fri, 19 Jun 2020 18:04:23 +0800
Message-ID: <20200619100425.26351-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2E984BD51C2883AC88FC321FC5804DC03A85E46DDDBCDFC9EEFBB4712C3D74CA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RW5hYmxlIHRvIGxpbWl0IHBlci1yYXRlIG1heCB0eHBvd2VyIGZyb20gRFQuDQoNClRlc3RlZC1i
eTogRXZlbHluIFRzYWkgPGV2ZWx5bi50c2FpQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6
IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCnYzOg0KIC0gZml4
IHBhdGNoIHJlZ3Jlc3Npb24sIHNvcnJ5IGZvciB0aGUgaW5jb252ZW5pZW5jZQ0KdjI6DQogLSBz
dWJ0cmFjdCBuc3NfZGVsdGEgZnJvbSB0eHBvd2VyX2N1ciANCiAtIHNldCB0eHBvd2VyX2N1ciB0
byB0aGUgcmV0dXJuIGNvZGUgb2YgbXQ3Nl9nZXRfcmF0ZV9wb3dlcl9saW1pdHMNCg0KVGhlIHNl
cmllcyBpcyBiYXNlZCBvbiBGZWxpeCdzIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC13aXJlbGVzcy9saXN0Lz9zZXJpZXM9MzAzOTEzDQotLS0NCiAuLi4vbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jICAgfCA0NCArKysrKysrKysrKysrKysr
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
Y3UuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQpp
bmRleCBjOGMxMmM3Li45OGRlMmY2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQpAQCAtMzA2OCwxNSArMzA2OCw0NyBAQCBpbnQgbXQ3
OTE1X21jdV9zZXRfc2t1KHN0cnVjdCBtdDc5MTVfcGh5ICpwaHkpDQogCQkuZm9ybWF0X2lkID0g
NCwNCiAJCS5kYmRjX2lkeCA9IHBoeSAhPSAmZGV2LT5waHksDQogCX07DQotCWludCBpOw0KLQlz
OCAqZGVsdGE7DQorCXN0cnVjdCBtdDc2X3Bvd2VyX2xpbWl0cyBsaW1pdHNfYXJyYXk7DQorCXM4
ICpkZWx0YSwgKmxhID0gKHM4ICopJmxpbWl0c19hcnJheTsNCisJaW50IGksIGlkeCwgbl9jaGFp
bnMgPSBod2VpZ2h0OChtcGh5LT5hbnRlbm5hX21hc2spOw0KKwlpbnQgdHhfcG93ZXI7DQogDQog
CWRlbHRhID0gZGV2LT5yYXRlX3Bvd2VyW21waHktPmNoYW5kZWYuY2hhbi0+YmFuZF07DQotCW1w
aHktPnR4cG93ZXJfY3VyID0gaHctPmNvbmYucG93ZXJfbGV2ZWwgKiAyICsNCi0JCQkgICAgZGVs
dGFbTVQ3OTE1X1NLVV9NQVhfREVMVEFfSURYXTsNCisJdHhfcG93ZXIgPSBody0+Y29uZi5wb3dl
cl9sZXZlbCAqIDIgLQ0KKwkJICAgbXQ3Nl90eF9wb3dlcl9uc3NfZGVsdGEobl9jaGFpbnMpOw0K
IA0KLQlmb3IgKGkgPSAwOyBpIDwgTVQ3OTE1X1NLVV9SQVRFX05VTTsgaSsrKQ0KLQkJcmVxLnZh
bFtpXSA9IGh3LT5jb25mLnBvd2VyX2xldmVsICogMiArIGRlbHRhW2ldOw0KKwl0eF9wb3dlciA9
IG10NzZfZ2V0X3JhdGVfcG93ZXJfbGltaXRzKG1waHksIG1waHktPmNoYW5kZWYuY2hhbiwNCisJ
CQkJCSAgICAgICZsaW1pdHNfYXJyYXksIHR4X3Bvd2VyKTsNCisJbXBoeS0+dHhwb3dlcl9jdXIg
PSB0eF9wb3dlcjsNCisNCisJZm9yIChpID0gMCwgaWR4ID0gMDsgaSA8IE1BWF9TS1VfUkFURV9H
Uk9VUF9OVU07IGkrKykgew0KKwkJY29uc3Qgc3RydWN0IHNrdV9ncm91cCAqc2t1ID0gJm10Nzkx
NV9za3VfZ3JvdXBzW2ldOw0KKwkJdTMyIG9mZnNldCA9IHNrdS0+b2Zmc2V0W21waHktPmNoYW5k
ZWYuY2hhbi0+YmFuZF07DQorCQl1OCBtY3NfbnVtID0gc2t1LT5sZW47DQorCQlpbnQgajsNCisN
CisJCWlmIChpID49IFNLVV9IVF9CVzIwICYmIGkgPD0gU0tVX1ZIVF9CVzE2MCkgew0KKwkJCW1j
c19udW0gPSAxMDsNCisNCisJCQlpZiAoaSA9PSBTS1VfSFRfQlcyMCB8fCBpID09IFNLVV9WSFRf
QlcyMCkNCisJCQkJbGEgPSAoczggKikmbGltaXRzX2FycmF5ICsgMTI7DQorCQl9DQorDQorCQlp
ZiAoIW9mZnNldCkgew0KKwkJCWlkeCArPSBza3UtPmxlbjsNCisJCQlsYSArPSBtY3NfbnVtOw0K
KwkJCWNvbnRpbnVlOw0KKwkJfQ0KKw0KKwkJZm9yIChqID0gMDsgaiA8IG1pbl90KHU4LCBtY3Nf
bnVtLCBza3UtPmxlbik7IGorKykgew0KKwkJCXM4IHJhdGVfcG93ZXI7DQorDQorCQkJcmF0ZV9w
b3dlciA9IGh3LT5jb25mLnBvd2VyX2xldmVsICogMiArIGRlbHRhW2lkeCArIGpdOw0KKwkJCXJl
cS52YWxbaWR4ICsgal0gPSBtaW5fdChzOCwgbGFbal0sIHJhdGVfcG93ZXIpOw0KKwkJfQ0KKwkJ
bGEgKz0gbWNzX251bTsNCisJCWlkeCArPSBza3UtPmxlbjsNCisJfQ0KIA0KIAlyZXR1cm4gX19t
dDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LA0KIAkJCQkgICBNQ1VfRVhUX0NNRF9UWF9QT1dF
Ul9GRUFUVVJFX0NUUkwsDQotLSANCjIuMTcuMQ0K

