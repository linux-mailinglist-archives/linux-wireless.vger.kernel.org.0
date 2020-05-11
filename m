Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1F1CDFF9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgEKQGu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 12:06:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42083 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730634AbgEKQGt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 12:06:49 -0400
X-UUID: 3a2915e458274d0ca34dd0727942f379-20200512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FHEMH0BW/B3IHs8+yf1A994YLQsxOjuJtYLfdF1XWY4=;
        b=IuE7zNlkdntWxNzkOVb7sIgdJb/BTG2YE/ECuQ7D1DrQtAv4GXLu0jMRwSUzWRfoOVhGVEXONbnMnlhVCGUO6XyKIgHSQPtRT0ExC4O3qXAWB8Kfs45huEUKkUWCaxFe+s13FbsvOphDvTcUm3j1/R++RcC9OMQmetAstadL/qU=;
X-UUID: 3a2915e458274d0ca34dd0727942f379-20200512
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1454169398; Tue, 12 May 2020 00:06:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 May 2020 00:06:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 May 2020 00:06:39 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/7] mt76: mt7915: introduce mt7915_get_he_phy_cap
Date:   Tue, 12 May 2020 00:06:32 +0800
Message-ID: <388715592e47739507970be49766ffb35af95afb.1589212457.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1589212457.git.ryder.lee@mediatek.com>
References: <cover.1589212457.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A76AA779FF5C4AF74D3C76B7265B4893BA8FC5ED108C5E0E47693D5A5BD4FCA62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIGEgaGVscGVyIHRvIHJlZHVjZSBkdXBsaWNhdGUgY29kZXMuDQpUaGlzIGlzIGEgcHJlbGlt
aW5hcnkgcGF0Y2ggdG8gYWRkIFR4IGJlYW1mb3JtaW5nIHN1cHBvcnQuDQoNClNpZ25lZC1vZmYt
Ynk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMgICB8IDMxICsrKysrKysrKysrLS0tLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
Y3UuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQpp
bmRleCAzZTNkNmYxZDU1NWEuLmMxNDdhMDMzMjUwYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KQEAgLTEzNCw2ICsxMzQsMTggQEAg
c3RhdGljIHU4IG10NzkxNV9tY3VfY2hhbl9idyhzdHJ1Y3QgY2ZnODAyMTFfY2hhbl9kZWYgKmNo
YW5kZWYpDQogCXJldHVybiB3aWR0aF90b19id1tjaGFuZGVmLT53aWR0aF07DQogfQ0KIA0KK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX3N0YV9oZV9jYXAgKg0KK210NzkxNV9nZXRfaGVf
cGh5X2NhcChzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlm
KQ0KK3sNCisJc3RydWN0IGllZWU4MDIxMV9zdXBwb3J0ZWRfYmFuZCAqc2JhbmQ7DQorCWVudW0g
bmw4MDIxMV9iYW5kIGJhbmQ7DQorDQorCWJhbmQgPSBwaHktPm10NzYtPmNoYW5kZWYuY2hhbi0+
YmFuZDsNCisJc2JhbmQgPSBwaHktPm10NzYtPmh3LT53aXBoeS0+YmFuZHNbYmFuZF07DQorDQor
CXJldHVybiBpZWVlODAyMTFfZ2V0X2hlX2lmdHlwZV9jYXAoc2JhbmQsIHZpZi0+dHlwZSk7DQor
fQ0KKw0KIHN0YXRpYyB1OA0KIG10NzkxNV9nZXRfcGh5X21vZGUoc3RydWN0IG10NzkxNV9kZXYg
KmRldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCiAJCSAgICBlbnVtIG5sODAyMTFfYmFu
ZCBiYW5kLCBzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqc3RhKQ0KQEAgLTE0OSwxMSArMTYxLDEyIEBA
IG10NzkxNV9nZXRfcGh5X21vZGUoc3RydWN0IG10NzkxNV9kZXYgKmRldiwgc3RydWN0IGllZWU4
MDIxMV92aWYgKnZpZiwNCiAJCWhlX2NhcCA9ICZzdGEtPmhlX2NhcDsNCiAJfSBlbHNlIHsNCiAJ
CXN0cnVjdCBpZWVlODAyMTFfc3VwcG9ydGVkX2JhbmQgKnNiYW5kOw0KKwkJc3RydWN0IG10Nzkx
NV9waHkgKnBoeTsNCisJCXN0cnVjdCBtdDc5MTVfdmlmICptdmlmOw0KIA0KLQkJaWYgKGJhbmQg
PT0gTkw4MDIxMV9CQU5EXzJHSFopDQotCQkJc2JhbmQgPSAmZGV2LT5tcGh5LnNiYW5kXzJnLnNi
YW5kOw0KLQkJZWxzZQ0KLQkJCXNiYW5kID0gJmRldi0+bXBoeS5zYmFuZF81Zy5zYmFuZDsNCisJ
CW12aWYgPSAoc3RydWN0IG10NzkxNV92aWYgKil2aWYtPmRydl9wcml2Ow0KKwkJcGh5ID0gbXZp
Zi0+YmFuZF9pZHggPyBtdDc5MTVfZXh0X3BoeShkZXYpIDogJmRldi0+cGh5Ow0KKwkJc2JhbmQg
PSBwaHktPm10NzYtPmh3LT53aXBoeS0+YmFuZHNbYmFuZF07DQogDQogCQlodF9jYXAgPSAmc2Jh
bmQtPmh0X2NhcDsNCiAJCXZodF9jYXAgPSAmc2JhbmQtPnZodF9jYXA7DQpAQCAtODg0LDE5ICs4
OTcsMTEgQEAgbXQ3OTE1X21jdV9ic3NfaGVfdGx2KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVj
dCBpZWVlODAyMTFfdmlmICp2aWYsDQogew0KICNkZWZpbmUgREVGQVVMVF9IRV9QRV9EVVJBVElP
TgkJNA0KICNkZWZpbmUgREVGQVVMVF9IRV9EVVJBVElPTl9SVFNfVEhSRVMJMTAyMw0KLQlzdHJ1
Y3QgY2ZnODAyMTFfY2hhbl9kZWYgKmNoYW5kZWYgPSAmcGh5LT5tdDc2LT5jaGFuZGVmOw0KLQll
bnVtIG5sODAyMTFfYmFuZCBiYW5kID0gY2hhbmRlZi0+Y2hhbi0+YmFuZDsNCi0Jc3RydWN0IGll
ZWU4MDIxMV9zdXBwb3J0ZWRfYmFuZCAqc2JhbmQ7DQogCWNvbnN0IHN0cnVjdCBpZWVlODAyMTFf
c3RhX2hlX2NhcCAqY2FwOw0KIAlzdHJ1Y3QgYnNzX2luZm9faGUgKmhlOw0KIAlzdHJ1Y3QgdGx2
ICp0bHY7DQogDQotCWlmIChiYW5kID09IE5MODAyMTFfQkFORF8yR0haKQ0KLQkJc2JhbmQgPSAm
cGh5LT5tdDc2LT5zYmFuZF8yZy5zYmFuZDsNCi0JZWxzZQ0KLQkJc2JhbmQgPSAmcGh5LT5tdDc2
LT5zYmFuZF81Zy5zYmFuZDsNCi0NCi0JY2FwID0gaWVlZTgwMjExX2dldF9oZV9pZnR5cGVfY2Fw
KHNiYW5kLCB2aWYtPnR5cGUpOw0KKwljYXAgPSBtdDc5MTVfZ2V0X2hlX3BoeV9jYXAocGh5LCB2
aWYpOw0KIA0KIAl0bHYgPSBtdDc5MTVfbWN1X2FkZF90bHYoc2tiLCBCU1NfSU5GT19IRV9CQVNJ
Qywgc2l6ZW9mKCpoZSkpOw0KIA0KLS0gDQoyLjE4LjANCg==

