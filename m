Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133F1287A6B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgJHQ5o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 12:57:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44999 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729061AbgJHQ5o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 12:57:44 -0400
X-UUID: b7e0c28428484014940fefb1933427a2-20201009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=B9S3JQEMt9isWDCJIhLxXkAqVd6tOOBHmeP5jMCSV68=;
        b=kYHE9qHrAaH6FRLFua3lqJ/WUWllkW0aislJJutKX+61Jw/HrtN0xsRxnRTN1gW7rjgEmhNDU+X6E8qftNROsB3P+Snc1M9apnUhUedFRbuW+ssA9vQoyZZzX5Yh4DHP9arcI7IKZ1pGDpykUvY7rGJ+207u+dtcFQ2Q1J148rg=;
X-UUID: b7e0c28428484014940fefb1933427a2-20201009
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 444471015; Fri, 09 Oct 2020 00:57:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Oct 2020 00:57:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Oct 2020 00:57:36 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/2] mt76: mt7915: update ppe threshold
Date:   Fri, 9 Oct 2020 00:57:35 +0800
Message-ID: <e1beae5f3177c82fa73635a8a96fa95be609149e.1602175329.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VXBkYXRlIHBwZV90aHJlc2ggY2FwYWJpbGl0eSB0byBzeW5jIFNESyBzZXR0aW5nLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBTaGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tPg0KU2lnbmVk
LW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMgIHwgNDMgKysrKysrKy0tLS0t
LS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTE1L2luaXQuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2lu
aXQuYw0KaW5kZXggNWYyMzhiYzYzYzJhLi43MzhiNGVkOGI3ZTcgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCisrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0KQEAgLTM1NywzNSAr
MzU3LDI0IEBAIG10NzkxNV9zZXRfc3RyZWFtX2hlX3R4YmZfY2FwcyhzdHJ1Y3QgaWVlZTgwMjEx
X3N0YV9oZV9jYXAgKmhlX2NhcCwNCiB9DQogDQogc3RhdGljIHZvaWQNCi1tdDc5MTVfZ2VuX3Bw
ZV90aHJlc2godTggKmhlX3BwZXQpDQorbXQ3OTE1X2dlbl9wcGVfdGhyZXNoKHU4ICpoZV9wcGV0
LCBpbnQgbnNzKQ0KIHsNCi0JaW50IHJ1LCBuc3MsIG1heF9uc3MgPSAxLCBtYXhfcnUgPSAzOw0K
LQl1OCBiaXQgPSA3LCBydV9iaXRfbWFzayA9IDB4NzsNCisJdTggaSwgcHBldF9iaXRzLCBwcGV0
X3NpemUsIHJ1X2JpdF9tYXNrID0gMHg3OyAvKiBIRTgwICovDQogCXU4IHBwZXQxNl9wcGV0OF9y
dTNfcnUwW10gPSB7MHgxYywgMHhjNywgMHg3MX07DQogDQotCWhlX3BwZXRbMF0gPSBtYXhfbnNz
ICYgSUVFRTgwMjExX1BQRV9USFJFU19OU1NfTUFTSzsNCi0JaGVfcHBldFswXSB8PSAocnVfYml0
X21hc2sgPDwNCi0JCSAgICAgICBJRUVFODAyMTFfUFBFX1RIUkVTX1JVX0lOREVYX0JJVE1BU0tf
UE9TKSAmDQotCQkJSUVFRTgwMjExX1BQRV9USFJFU19SVV9JTkRFWF9CSVRNQVNLX01BU0s7DQot
DQotCWZvciAobnNzID0gMDsgbnNzIDw9IG1heF9uc3M7IG5zcysrKSB7DQotCQlmb3IgKHJ1ID0g
MDsgcnUgPCBtYXhfcnU7IHJ1KyspIHsNCi0JCQl1OCB2YWw7DQotCQkJaW50IGk7DQotDQotCQkJ
aWYgKCEocnVfYml0X21hc2sgJiBCSVQocnUpKSkNCi0JCQkJY29udGludWU7DQotDQotCQkJdmFs
ID0gKHBwZXQxNl9wcGV0OF9ydTNfcnUwW25zc10gPj4gKHJ1ICogNikpICYNCi0JCQkgICAgICAg
MHgzZjsNCi0JCQl2YWwgPSAoKHZhbCA+PiAzKSAmIDB4NykgfCAoKHZhbCAmIDB4NykgPDwgMyk7
DQotCQkJZm9yIChpID0gNTsgaSA+PSAwOyBpLS0pIHsNCi0JCQkJaGVfcHBldFtiaXQgLyA4XSB8
PQ0KLQkJCQkJKCh2YWwgPj4gaSkgJiAweDEpIDw8ICgoYml0ICUgOCkpOw0KLQkJCQliaXQrKzsN
Ci0JCQl9DQotCQl9DQotCX0NCisJaGVfcHBldFswXSA9IEZJRUxEX1BSRVAoSUVFRTgwMjExX1BQ
RV9USFJFU19OU1NfTUFTSywgbnNzIC0gMSkgfA0KKwkJICAgICBGSUVMRF9QUkVQKElFRUU4MDIx
MV9QUEVfVEhSRVNfUlVfSU5ERVhfQklUTUFTS19NQVNLLA0KKwkJCQlydV9iaXRfbWFzayk7DQor
DQorCXBwZXRfYml0cyA9IElFRUU4MDIxMV9QUEVfVEhSRVNfSU5GT19QUEVUX1NJWkUgKg0KKwkJ
ICAgIG5zcyAqIGh3ZWlnaHQ4KHJ1X2JpdF9tYXNrKSAqIDI7DQorCXBwZXRfc2l6ZSA9IERJVl9S
T1VORF9VUChwcGV0X2JpdHMsIDgpOw0KKw0KKwlmb3IgKGkgPSAwOyBpIDwgcHBldF9zaXplIC0g
MTsgaSsrKQ0KKwkJaGVfcHBldFtpICsgMV0gPSBwcGV0MTZfcHBldDhfcnUzX3J1MFtpICUgM107
DQorDQorCWhlX3BwZXRbaSArIDFdID0gcHBldDE2X3BwZXQ4X3J1M19ydTBbaSAlIDNdICYNCisJ
CQkgKDB4ZmYgPj4gKDggLSAocHBldF9iaXRzIC0gMSkgJSA4KSk7DQogfQ0KIA0KIHN0YXRpYyBp
bnQNCkBAIC01MTYsNyArNTA1LDcgQEAgbXQ3OTE1X2luaXRfaGVfY2FwcyhzdHJ1Y3QgbXQ3OTE1
X3BoeSAqcGh5LCBlbnVtIG5sODAyMTFfYmFuZCBiYW5kLA0KIAkJbWVtc2V0KGhlX2NhcC0+cHBl
X3RocmVzLCAwLCBzaXplb2YoaGVfY2FwLT5wcGVfdGhyZXMpKTsNCiAJCWlmIChoZV9jYXBfZWxl
bS0+cGh5X2NhcF9pbmZvWzZdICYNCiAJCSAgICBJRUVFODAyMTFfSEVfUEhZX0NBUDZfUFBFX1RI
UkVTSE9MRF9QUkVTRU5UKSB7DQotCQkJbXQ3OTE1X2dlbl9wcGVfdGhyZXNoKGhlX2NhcC0+cHBl
X3RocmVzKTsNCisJCQltdDc5MTVfZ2VuX3BwZV90aHJlc2goaGVfY2FwLT5wcGVfdGhyZXMsIG5z
cyk7DQogCQl9IGVsc2Ugew0KIAkJCWhlX2NhcF9lbGVtLT5waHlfY2FwX2luZm9bOV0gfD0NCiAJ
CQkJSUVFRTgwMjExX0hFX1BIWV9DQVA5X05PTUlNQUxfUEtUX1BBRERJTkdfMTZVUzsNCi0tIA0K
Mi4xOC4wDQo=

