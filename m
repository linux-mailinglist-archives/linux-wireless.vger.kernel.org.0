Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46041FB116
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgFPMrK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 08:47:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38020 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgFPMrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 08:47:10 -0400
X-UUID: 22fa8ade47ad4d9d93accefb4df73746-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EHgc6usT4G4/hgz5NXvICcMpwnoY3iXu64idsp5U1Jk=;
        b=bFfmgrL9h50b1IAUQmp80u69FpIF88j8AspvEpXpIr1zCTAimuBkyjlNe9i1vqAyRG1egmS8Wrfw4PM0RmKPbmL6UbLBZw/Aouy4/WLCgaOqM6Z5qmgeXRj3NgUFHg4LZhCts339BiVNr/QtGqUd5bTeQAKGWnvJHMu5Ndvm2aE=;
X-UUID: 22fa8ade47ad4d9d93accefb4df73746-20200616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1979095913; Tue, 16 Jun 2020 20:47:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 20:46:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 20:46:58 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 3/4] mt76: mt7915: add support for DT rate power limits
Date:   Tue, 16 Jun 2020 20:46:12 +0800
Message-ID: <279b29408c742c4b043e7af11217dcd5eeb7b8c2.1592276165.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <9ae2b6233284b60206e3513f7bf2eb03d2fbd724.1592276165.git.ryder.lee@mediatek.com>
References: <9ae2b6233284b60206e3513f7bf2eb03d2fbd724.1592276165.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 24678ACB82BEA57D358342FF229A7D0922D92586A8DF5F8F21FBBA311760836D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIHN1cHBvcnQgdG8gbGltaXQgcGVyLXJhdGUgbWF4IHR4cG93ZXIgZnJvbSBEVC4NCg0KVGVz
dGVkLWJ5OiBFdmVseW4gVHNhaSA8ZXZlbHluLnRzYWlAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9m
Zi1ieTogU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9lZXByb20uaCAgICB8ICAyICstDQogLi4uL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYyAgIHwgMzggKysrKysrKysrKysr
KysrKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTE1L2VlcHJvbS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
ZWVwcm9tLmgNCmluZGV4IDRlMzFkNmFiNGZhNi4uMjg0ZGU4YjRlMGE0IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvZWVwcm9tLmgNCisrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2VlcHJvbS5oDQpAQCAt
MTIwLDYgKzEyMCw2IEBAIG10NzkxNV90c3NpX2VuYWJsZWQoc3RydWN0IG10NzkxNV9kZXYgKmRl
diwgZW51bSBubDgwMjExX2JhbmQgYmFuZCkNCiAJCXJldHVybiBlZXBbTVRfRUVfV0lGSV9DT05G
ICsgN10gJiBNVF9FRV9XSUZJX0NPTkZfVFNTSTBfMkc7DQogfQ0KIA0KLWV4dGVybiBjb25zdCBz
dHJ1Y3Qgc2t1X2dyb3VwIG10NzkxNV9za3VfZ3JvdXBzW107DQorZXh0ZXJuIGNvbnN0IHN0cnVj
dCBza3VfZ3JvdXAgbXQ3OTE1X3NrdV9ncm91cHNbTUFYX1NLVV9SQVRFX0dST1VQX05VTV07DQog
DQogI2VuZGlmDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzkx
NS9tY3UuYw0KaW5kZXggMzQ5MTYzZDBiN2YyLi5jNWU5ODkzY2JkODcgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCkBAIC0zMTcxLDE1
ICszMTcxLDQ1IEBAIGludCBtdDc5MTVfbWN1X3NldF9za3Uoc3RydWN0IG10NzkxNV9waHkgKnBo
eSkNCiAJCS5mb3JtYXRfaWQgPSA0LA0KIAkJLmRiZGNfaWR4ID0gcGh5ICE9ICZkZXYtPnBoeSwN
CiAJfTsNCi0JaW50IGk7DQotCXM4ICpkZWx0YTsNCisJc3RydWN0IG10NzZfcG93ZXJfbGltaXRz
IGxpbWl0c19hcnJheTsNCisJczggKmRlbHRhLCAqbGEgPSAoczggKikmbGltaXRzX2FycmF5Ow0K
KwlpbnQgaSwgaWR4Ow0KIA0KIAlkZWx0YSA9IGRldi0+cmF0ZV9wb3dlclttcGh5LT5jaGFuZGVm
LmNoYW4tPmJhbmRdOw0KIAltcGh5LT50eHBvd2VyX2N1ciA9IGh3LT5jb25mLnBvd2VyX2xldmVs
ICogMiArDQogCQkJICAgIGRlbHRhW01UNzkxNV9TS1VfTUFYX0RFTFRBX0lEWF07DQogDQotCWZv
ciAoaSA9IDA7IGkgPCBNVDc5MTVfU0tVX1JBVEVfTlVNOyBpKyspDQotCQlyZXEudmFsW2ldID0g
aHctPmNvbmYucG93ZXJfbGV2ZWwgKiAyICsgZGVsdGFbaV07DQorCW10NzZfZ2V0X3JhdGVfcG93
ZXJfbGltaXRzKG1waHksIG1waHktPmNoYW5kZWYuY2hhbiwNCisJCQkJICAgJmxpbWl0c19hcnJh
eSwgbXBoeS0+dHhwb3dlcl9jdXIpOw0KKw0KKwlmb3IgKGkgPSAwLCBpZHggPSAwOyBpIDwgQVJS
QVlfU0laRShtdDc5MTVfc2t1X2dyb3Vwcyk7IGkrKykgew0KKwkJY29uc3Qgc3RydWN0IHNrdV9n
cm91cCAqc2t1ID0gJm10NzkxNV9za3VfZ3JvdXBzW2ldOw0KKwkJdTMyIG9mZnNldCA9IHNrdS0+
b2Zmc2V0W21waHktPmNoYW5kZWYuY2hhbi0+YmFuZF07DQorCQl1OCBtY3NfbnVtID0gc2t1LT5s
ZW47DQorCQlpbnQgajsNCisNCisJCWlmIChpID49IFNLVV9IVF9CVzIwICYmIGkgPD0gU0tVX1ZI
VF9CVzE2MCkgew0KKwkJCW1jc19udW0gPSAxMDsNCisNCisJCQlpZiAoaSA9PSBTS1VfSFRfQlcy
MCB8fCBpID09IFNLVV9WSFRfQlcyMCkNCisJCQkJbGEgPSAoczggKikmbGltaXRzX2FycmF5ICsg
MTI7DQorCQl9DQorDQorCQlpZiAoIW9mZnNldCkgew0KKwkJCWlkeCArPSBza3UtPmxlbjsNCisJ
CQlsYSArPSBtY3NfbnVtOw0KKwkJCWNvbnRpbnVlOw0KKwkJfQ0KKw0KKwkJZm9yIChqID0gMDsg
aiA8IG1pbl90KHU4LCBtY3NfbnVtLCBza3UtPmxlbik7IGorKykgew0KKwkJCXM4IHJhdGVfcG93
ZXI7DQorDQorCQkJcmF0ZV9wb3dlciA9IGh3LT5jb25mLnBvd2VyX2xldmVsICogMiArIGRlbHRh
W2lkeCArIGpdOw0KKwkJCXJlcS52YWxbaWR4ICsgal0gPSBtaW5fdChzOCwgbGFbal0sIHJhdGVf
cG93ZXIpOw0KKwkJfQ0KKwkJbGEgKz0gbWNzX251bTsNCisJCWlkeCArPSBza3UtPmxlbjsNCisJ
fQ0KIA0KIAlyZXR1cm4gX19tdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LA0KIAkJCQkgICBN
Q1VfRVhUX0NNRF9UWF9QT1dFUl9GRUFUVVJFX0NUUkwsDQotLSANCjIuMTguMA0K

