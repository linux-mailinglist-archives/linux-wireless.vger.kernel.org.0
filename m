Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CACE1B7EFE
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgDXTdJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 15:33:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38853 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729409AbgDXTdJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 15:33:09 -0400
X-UUID: d43a6f3a9223463a85dfb57e4ac4337a-20200425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FU4fnFK6FjATZkPgOccxNKSpbEJPY03LnfTBWhP01rs=;
        b=ImratJ3fT8WLivRtj6Px4LMooJMWaRYtC+prqoUZquGF1ybCl7ZctWNF7yMN4iPZ2vSc83svvxzAgC6XW0jFcAw7JtUTWVuhtQdWD9xoI48nfrujXUZwuJM9BPxQwb5EK7cAR1IHEQNeJ5IqcmJYy4LeOAmbgi8LbZ7PIQ9VFQU=;
X-UUID: d43a6f3a9223463a85dfb57e4ac4337a-20200425
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 863494962; Sat, 25 Apr 2020 03:33:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 25 Apr 2020 03:32:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 25 Apr 2020 03:32:55 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Sean Wang" <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 13/18] mt76: mt7915: add .sta_add_debugfs support
Date:   Sat, 25 Apr 2020 03:32:34 +0800
Message-ID: <8b725cdd9b9fb1c3ce3218d38f560203a761cb73.1587756404.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1587756404.git.ryder.lee@mediatek.com>
References: <cover.1587756404.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0116BC3C9EB0ECFBF45BBC0E442DC25C6A68AC45EE6A94034D87A64A1E0074022000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBnZW5lcmF0aW9uIHN1cHBvcnRzIG11Y2ggbW9yZSBwZXItcGVlciBzdGF0aXN0aWNzIHRo
YW4gbGVnYWN5IG9uZXMsDQpzbyBhZGQgLnN0YV9hZGRfZGVidWdmcyBhY2NvcmRpbmdseS4NCg0K
VGhpcyBpcyBjb252ZW5pZW50IHRvIHNldC9nZXQgbW9yZSBzZXR0aW5ncy9jb3VudGVycyBpbiB0
aGUgbG9uZyBydW4uDQoNClNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KIC4uLi93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9kZWJ1Z2Zz
LmMgICB8IDY1ICsrKysrKysrKysrKysrKysrKysNCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTE1L21haW4uYyAgfCAgMyArDQogLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L210NzkxNS5oICAgIHwgIDQgKysNCiAzIGZpbGVzIGNoYW5nZWQsIDcyIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L2RlYnVnZnMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTE1L2RlYnVnZnMuYw0KaW5kZXggMmUzZjA1ZjczNjk3Li43ZjY3YTFhODAxM2IgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9kZWJ1Z2ZzLmMN
CisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2RlYnVnZnMu
Yw0KQEAgLTMwMiwzICszMDIsNjggQEAgaW50IG10NzkxNV9pbml0X2RlYnVnZnMoc3RydWN0IG10
NzkxNV9kZXYgKmRldikNCiANCiAJcmV0dXJuIDA7DQogfQ0KKw0KKy8qKiBwZXItc3RhdGlvbiBk
ZWJ1Z2ZzICoqLw0KKw0KK3N0YXRpYyBpbnQNCittdDc5MTVfc3RhX3N0YXRzX3JlYWQoc3RydWN0
IHNlcV9maWxlICpzLCB2b2lkICpkYXRhKQ0KK3sNCisJc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0
YSA9IHMtPnByaXZhdGU7DQorCXN0cnVjdCBtdDc5MTVfc3RhICptc3RhID0gKHN0cnVjdCBtdDc5
MTVfc3RhICopc3RhLT5kcnZfcHJpdjsNCisJc3RydWN0IG10NzkxNV9zdGFfc3RhdHMgKnN0YXRz
ID0gJm1zdGEtPnN0YXRzOw0KKwlzdHJ1Y3QgcmF0ZV9pbmZvICpyYXRlID0gJnN0YXRzLT5wcm9i
X3JhdGU7DQorCXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgYndbXSA9IHsNCisJCSJCVzIwIiwg
IkJXNSIsICJCVzEwIiwgIkJXNDAiLA0KKwkJIkJXODAiLCAiQlcxNjAiLCAiQldfSEVfUlUiDQor
CX07DQorDQorCWlmICghcmF0ZS0+bGVnYWN5ICYmICFyYXRlLT5mbGFncykNCisJCXJldHVybiAw
Ow0KKw0KKwlzZXFfcHV0cyhzLCAiUHJvYmluZyByYXRlIC0gIik7DQorCWlmIChyYXRlLT5mbGFn
cyAmIFJBVEVfSU5GT19GTEFHU19NQ1MpDQorCQlzZXFfcHV0cyhzLCAiSFQgIik7DQorCWVsc2Ug
aWYgKHJhdGUtPmZsYWdzICYgUkFURV9JTkZPX0ZMQUdTX1ZIVF9NQ1MpDQorCQlzZXFfcHV0cyhz
LCAiVkhUICIpOw0KKwllbHNlIGlmIChyYXRlLT5mbGFncyAmIFJBVEVfSU5GT19GTEFHU19IRV9N
Q1MpDQorCQlzZXFfcHV0cyhzLCAiSEUgIik7DQorCWVsc2UNCisJCXNlcV9wcmludGYocywgIkJp
dHJhdGUgJWRcbiIsIHJhdGUtPmxlZ2FjeSk7DQorDQorCWlmIChyYXRlLT5mbGFncykgew0KKwkJ
c2VxX3ByaW50ZihzLCAiJXMgTlNTJWQgTUNTJWQgIiwNCisJCQkgICBid1tyYXRlLT5id10sIHJh
dGUtPm5zcywgcmF0ZS0+bWNzKTsNCisNCisJCWlmIChyYXRlLT5mbGFncyAmIFJBVEVfSU5GT19G
TEFHU19TSE9SVF9HSSkNCisJCQlzZXFfcHV0cyhzLCAiU0dJICIpOw0KKwkJZWxzZSBpZiAocmF0
ZS0+aGVfZ2kpDQorCQkJc2VxX3B1dHMocywgIkhFIEdJICIpOw0KKw0KKwkJaWYgKHJhdGUtPmhl
X2RjbSkNCisJCQlzZXFfcHV0cyhzLCAiRENNICIpOw0KKwl9DQorDQorCXNlcV9wcmludGYocywg
IlxuUFBEVSBQRVI6ICVsZC4lMWxkJSVcbiIsDQorCQkgICBzdGF0cy0+cGVyIC8gMTAsIHN0YXRz
LT5wZXIgJSAxMCk7DQorDQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgaW50DQorbXQ3OTE1
X3N0YV9zdGF0c19vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmKQ0KK3sN
CisJcmV0dXJuIHNpbmdsZV9vcGVuKGYsIG10NzkxNV9zdGFfc3RhdHNfcmVhZCwgaW5vZGUtPmlf
cHJpdmF0ZSk7DQorfQ0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGZv
cHNfc3RhX3N0YXRzID0gew0KKwkub3BlbiA9IG10NzkxNV9zdGFfc3RhdHNfb3BlbiwNCisJLnJl
YWQgPSBzZXFfcmVhZCwNCisJLmxsc2VlayA9IHNlcV9sc2VlaywNCisJLnJlbGVhc2UgPSBzaW5n
bGVfcmVsZWFzZSwNCit9Ow0KKw0KK3ZvaWQgbXQ3OTE1X3N0YV9hZGRfZGVidWdmcyhzdHJ1Y3Qg
aWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCisJCQkgICAgc3Ry
dWN0IGllZWU4MDIxMV9zdGEgKnN0YSwgc3RydWN0IGRlbnRyeSAqZGlyKQ0KK3sNCisJZGVidWdm
c19jcmVhdGVfZmlsZSgic3RhdHMiLCAwNDAwLCBkaXIsIHN0YSwgJmZvcHNfc3RhX3N0YXRzKTsN
Cit9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWFpbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFp
bi5jDQppbmRleCAwOTcyMjU2OTIwMjYuLjZjYjY5YWU2Y2IwZSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYw0KKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5jDQpAQCAtNzQ2LDQgKzc0
Niw3IEBAIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfb3BzIG10NzkxNV9vcHMgPSB7DQogCS5nZXRf
YW50ZW5uYSA9IG10NzZfZ2V0X2FudGVubmEsDQogCS5zZXRfYW50ZW5uYSA9IG10NzkxNV9zZXRf
YW50ZW5uYSwNCiAJLnNldF9jb3ZlcmFnZV9jbGFzcyA9IG10NzkxNV9zZXRfY292ZXJhZ2VfY2xh
c3MsDQorI2lmZGVmIENPTkZJR19NQUM4MDIxMV9ERUJVR0ZTDQorCS5zdGFfYWRkX2RlYnVnZnMg
PSBtdDc5MTVfc3RhX2FkZF9kZWJ1Z2ZzLA0KKyNlbmRpZg0KIH07DQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmggYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tdDc5MTUuaA0KaW5kZXggOTJhNmJm
NzQ2ZDczLi4zNWUzNGQyNzBjMTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkxNS9tdDc5MTUuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmgNCkBAIC00NDgsNSArNDQ4LDkgQEAgaW50IG10
NzkxNV9kZnNfaW5pdF9yYWRhcl9kZXRlY3RvcihzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5KTsNCiB2
b2lkIG10NzkxNV9zZXRfc3RyZWFtX2hlX2NhcHMoc3RydWN0IG10NzkxNV9waHkgKnBoeSk7DQog
dm9pZCBtdDc5MTVfdXBkYXRlX2NoYW5uZWwoc3RydWN0IG10NzZfZGV2ICptZGV2KTsNCiBpbnQg
bXQ3OTE1X2luaXRfZGVidWdmcyhzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2KTsNCisjaWZkZWYgQ09O
RklHX01BQzgwMjExX0RFQlVHRlMNCit2b2lkIG10NzkxNV9zdGFfYWRkX2RlYnVnZnMoc3RydWN0
IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQorCQkJICAgIHN0
cnVjdCBpZWVlODAyMTFfc3RhICpzdGEsIHN0cnVjdCBkZW50cnkgKmRpcik7DQorI2VuZGlmDQog
DQogI2VuZGlmDQotLSANCjIuMTguMA0K

