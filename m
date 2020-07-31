Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7F0234D82
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Aug 2020 00:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGaWYY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 18:24:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43681 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbgGaWYX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 18:24:23 -0400
X-UUID: d21d2e84bc424a88956fca30607852aa-20200801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xnz7ZONKdY2puDtlW4rbgiCv9EsKBL6SG/bcd3ZFP3s=;
        b=lQXqXmC13T42f8MJ/+rrR96mp7hTH0jM/sEw+175SzSntL4bRJx3AbKJQ1BCiufbqQGVDZ6eNiFmYCWilE918nROW7HqB5QDm220HkSAe1eW7S6/UVKRA75q6PQJWugPSrxtihTtK/ebKd1s/LgO3F2lZkVZDa3ajKWVi7jLpmQ=;
X-UUID: d21d2e84bc424a88956fca30607852aa-20200801
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 614753913; Sat, 01 Aug 2020 06:24:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 1 Aug 2020 06:24:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 1 Aug 2020 06:24:17 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: enable U-APSD on AP side
Date:   Sat, 1 Aug 2020 06:24:15 +0800
Message-ID: <c95b963ca2fad59b73ec3b4ccf3ca109ac5e5f63.1596173828.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 543531E0BD19A8784F58EB00277F76E37F990FE80C7FC417E504666826EF4D1A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RW5hYmxlIFUtQVBTRCBzdXBwb3J0IGZvciBBUCBpbnRlcmZhY2UuDQoNClNpZ25lZC1vZmYtYnk6
IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMgICB8IDM5ICsrKysrKysrKysrKysrKysrKy0N
CiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5oICAgfCAxMiArKysr
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
Y3UuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQpp
bmRleCAxZmZiOWVlYmNmMWMuLjAxZmE5Y2EzMWQwZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KQEAgLTE0NDAsNiArMTQ0MCwzOCBA
QCBtdDc5MTVfbWN1X3N0YV9oZV90bHYoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGllZWU4
MDIxMV9zdGEgKnN0YSkNCiAJaGUtPnBrdF9leHQgPSAyOw0KIH0NCiANCitzdGF0aWMgdm9pZA0K
K210NzkxNV9tY3Vfc3RhX3VhcHNkX3RsdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgaWVl
ZTgwMjExX3N0YSAqc3RhLA0KKwkJICAgICBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmKQ0KK3sN
CisJc3RydWN0IHN0YV9yZWNfdWFwc2QgKnVhcHNkOw0KKwlzdHJ1Y3QgdGx2ICp0bHY7DQorDQor
CWlmICh2aWYtPnR5cGUgIT0gTkw4MDIxMV9JRlRZUEVfQVAgfHwgIXN0YS0+d21lKQ0KKwkJcmV0
dXJuOw0KKw0KKwl0bHYgPSBtdDc5MTVfbWN1X2FkZF90bHYoc2tiLCBTVEFfUkVDX0FQUFMsIHNp
emVvZigqdWFwc2QpKTsNCisJdWFwc2QgPSAoc3RydWN0IHN0YV9yZWNfdWFwc2QgKil0bHY7DQor
DQorCWlmIChzdGEtPnVhcHNkX3F1ZXVlcyAmIElFRUU4MDIxMV9XTU1fSUVfU1RBX1FPU0lORk9f
QUNfVk8pIHsNCisJCXVhcHNkLT5kYWNfbWFwIHw9IEJJVCgzKTsNCisJCXVhcHNkLT50YWNfbWFw
IHw9IEJJVCgzKTsNCisJfQ0KKwlpZiAoc3RhLT51YXBzZF9xdWV1ZXMgJiBJRUVFODAyMTFfV01N
X0lFX1NUQV9RT1NJTkZPX0FDX1ZJKSB7DQorCQl1YXBzZC0+ZGFjX21hcCB8PSBCSVQoMik7DQor
CQl1YXBzZC0+dGFjX21hcCB8PSBCSVQoMik7DQorCX0NCisJaWYgKHN0YS0+dWFwc2RfcXVldWVz
ICYgSUVFRTgwMjExX1dNTV9JRV9TVEFfUU9TSU5GT19BQ19CRSkgew0KKwkJdWFwc2QtPmRhY19t
YXAgfD0gQklUKDEpOw0KKwkJdWFwc2QtPnRhY19tYXAgfD0gQklUKDEpOw0KKwl9DQorCWlmIChz
dGEtPnVhcHNkX3F1ZXVlcyAmIElFRUU4MDIxMV9XTU1fSUVfU1RBX1FPU0lORk9fQUNfQkspIHsN
CisJCXVhcHNkLT5kYWNfbWFwIHw9IEJJVCgwKTsNCisJCXVhcHNkLT50YWNfbWFwIHw9IEJJVCgw
KTsNCisJfQ0KKwl1YXBzZC0+bWF4X3NwID0gc3RhLT5tYXhfc3A7DQorfQ0KKw0KIHN0YXRpYyB2
b2lkDQogbXQ3OTE1X21jdV9zdGFfbXVydV90bHYoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0
IGllZWU4MDIxMV9zdGEgKnN0YSkNCiB7DQpAQCAtMTUxMyw3ICsxNTQ1LDcgQEAgbXQ3OTE1X21j
dV9hZGRfbXUoc3RydWN0IG10NzkxNV9kZXYgKmRldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZp
ZiwNCiANCiBzdGF0aWMgdm9pZA0KIG10NzkxNV9tY3Vfc3RhX3RsdihzdHJ1Y3QgbXQ3OTE1X2Rl
diAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KLQkJICAgc3RydWN0IGllZWU4MDIxMV9zdGEg
KnN0YSkNCisJCSAgIHN0cnVjdCBpZWVlODAyMTFfc3RhICpzdGEsIHN0cnVjdCBpZWVlODAyMTFf
dmlmICp2aWYpDQogew0KIAlzdHJ1Y3QgdGx2ICp0bHY7DQogDQpAQCAtMTU0MCw2ICsxNTcyLDkg
QEAgbXQ3OTE1X21jdV9zdGFfdGx2KHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBza19i
dWZmICpza2IsDQogCS8qIHN0YXJlYyBoZSAqLw0KIAlpZiAoc3RhLT5oZV9jYXAuaGFzX2hlKQ0K
IAkJbXQ3OTE1X21jdV9zdGFfaGVfdGx2KHNrYiwgc3RhKTsNCisNCisJLyogc3RhcmVjIHVhcHNk
ICovDQorCW10NzkxNV9tY3Vfc3RhX3VhcHNkX3Rsdihza2IsIHN0YSwgdmlmKTsNCiB9DQogDQog
c3RhdGljIHZvaWQNCkBAIC0yMTc2LDcgKzIyMTEsNyBAQCBpbnQgbXQ3OTE1X21jdV9hZGRfc3Rh
KHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQogDQog
CW10NzkxNV9tY3Vfc3RhX2Jhc2ljX3Rsdihza2IsIHZpZiwgc3RhLCBlbmFibGUpOw0KIAlpZiAo
ZW5hYmxlICYmIHN0YSkNCi0JCW10NzkxNV9tY3Vfc3RhX3RsdihkZXYsIHNrYiwgc3RhKTsNCisJ
CW10NzkxNV9tY3Vfc3RhX3RsdihkZXYsIHNrYiwgc3RhLCB2aWYpOw0KIA0KIAlzdGFfd3RibCA9
IG10NzkxNV9tY3VfYWRkX3Rsdihza2IsIFNUQV9SRUNfV1RCTCwgc2l6ZW9mKHN0cnVjdCB0bHYp
KTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzkxNS9tY3UuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21j
dS5oDQppbmRleCBjYjM1ZTcxODQwOWEuLmE0NjAwODYwZmJmNyAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5oDQorKysgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuaA0KQEAgLTY0NSw2ICs2NDUs
MTcgQEAgc3RydWN0IHN0YV9yZWNfdmh0IHsNCiAJdTggcnN2WzNdOw0KIH0gX19wYWNrZWQ7DQog
DQorc3RydWN0IHN0YV9yZWNfdWFwc2Qgew0KKwlfX2xlMTYgdGFnOw0KKwlfX2xlMTYgbGVuOw0K
Kwl1OCBkYWNfbWFwOw0KKwl1OCB0YWNfbWFwOw0KKwl1OCBtYXhfc3A7DQorCXU4IHJzdjA7DQor
CV9fbGUxNiBsaXN0ZW5faW50ZXJ2YWw7DQorCXU4IHJzdjFbMl07DQorfSBfX3BhY2tlZDsNCisN
CiBzdHJ1Y3Qgc3RhX3JlY19tdXJ1IHsNCiAJX19sZTE2IHRhZzsNCiAJX19sZTE2IGxlbjsNCkBA
IC05NTEsNiArOTYyLDcgQEAgZW51bSB7DQogCQkJCQkgc2l6ZW9mKHN0cnVjdCBzdGFfcmVjX2hl
KSArCVwNCiAJCQkJCSBzaXplb2Yoc3RydWN0IHN0YV9yZWNfYmEpICsJXA0KIAkJCQkJIHNpemVv
ZihzdHJ1Y3Qgc3RhX3JlY192aHQpICsJXA0KKwkJCQkJIHNpemVvZihzdHJ1Y3Qgc3RhX3JlY191
YXBzZCkgKyBcDQogCQkJCQkgc2l6ZW9mKHN0cnVjdCB0bHYpICsJCVwNCiAJCQkJCSBNVDc5MTVf
V1RCTF9VUERBVEVfTUFYX1NJWkUpDQogDQotLSANCjIuMTguMA0K

