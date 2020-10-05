Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2329283BC4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 17:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgJEP6A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 11:58:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49528 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbgJEP6A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 11:58:00 -0400
X-UUID: 86bfad94d67d4384ab6d1d5b99219fdf-20201005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ki3wTt7d1tvRrJ2MPiGpeliJV3ST6qE/ddjlBK6ldMA=;
        b=IYI7sKCYNmCiWPaOLv063Hrbd6uYxQ4JXI79b/3l8kalxPlLGncBVqEcEf54FZ4JR2ko1YDMNemi3ThtcH6nbo8W9c5cE/Nhdk6C3foOevISJ20HfehmsNgjdYrt5VQBvTg4RgfqAr1eoNTBcbebm+G7Hc8jBJFyqRWFYtn55nc=;
X-UUID: 86bfad94d67d4384ab6d1d5b99219fdf-20201005
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2106959968; Mon, 05 Oct 2020 23:57:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Oct 2020 23:57:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Oct 2020 23:57:54 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7915: update ppe threshold
Date:   Mon, 5 Oct 2020 23:57:52 +0800
Message-ID: <b381936001c1d62e520283b83d5492bdcdd5cf4f.1601913208.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AD7E908D8DDEDB847D2F270C7FD6F6B51A40574D610DE60E869CDEE11431880B2000:8
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
aXQuYw0KaW5kZXggNTg4NGMwY2U0NWU1Li5mMzQwY2M1Zjc4ZGEgMTAwNjQ0DQotLS0gYS9kcml2
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

