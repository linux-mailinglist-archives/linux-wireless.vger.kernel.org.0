Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D553E25D100
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Sep 2020 07:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIDFvK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Sep 2020 01:51:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42992 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725812AbgIDFvJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Sep 2020 01:51:09 -0400
X-UUID: 6dd3e289bd8840d19d9b71b25bc22b22-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jPwwJyFn/+V/3BD7kswj4A4OC14ihyANbZY+bcDcNig=;
        b=jOi6ySowdlOa3/dwTxbrW1Wr5jWrpcmDZ4A+QHZ14oEYKgvn5sovrc5+5keTFOaC5OU8mYDeTWSrSGgnDi3KttN29wIl+7yab3nLobMMj8SrIzT0pbPLuON3kunkUgjKHCOMU6Cts6pO5zxdvwXynxBeAvzZW9bnTNLFA/tk9xM=;
X-UUID: 6dd3e289bd8840d19d9b71b25bc22b22-20200904
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1095372783; Fri, 04 Sep 2020 13:51:04 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Sep 2020 13:51:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 13:51:03 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix unexpected firmware mode
Date:   Fri, 4 Sep 2020 13:51:02 +0800
Message-ID: <1ff9c333497bc23c535028c53e19e9d9724cf4c0.1599099379.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQ2hpaC1NaW4gQ2hlbiA8Y2hpaC1taW4uY2hlbkBtZWRpYXRlay5jb20+DQoNCkF2b2lk
IGZpcm13YXJlIGZhbGxpbmcgaW50byBzcGVjdHJ1bSBtb2RlIHNpbmNlIHRoYXQgd2lsbCBzZXQN
CnVuZXhwZWN0ZWQgUFNFL1BMRSB0aHJlc2hvbGRzIHdoaWNoIGxlYWQgdG8gVHggaGFuZy4NCg0K
VGhpcyBtb2RlIHNob3VsZCBiZSBjbGVhbmVkIGJlZm9yZSBmaXJtd2FyZSBkb3dubG9hZCBzdGFn
ZS4NCg0KU2lnbmVkLW9mZi1ieTogQ2hpaC1NaW4gQ2hlbiA8Y2hpaC1taW4uY2hlbkBtZWRpYXRl
ay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMg
fCA2ICsrKysrKw0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L3Jl
Z3MuaCB8IDcgKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5p
dC5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQpp
bmRleCA1MTdmNTI2ZWM4NTIuLjVhMmRiYmQ5YWE1YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2luaXQuYw0KKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQpAQCAtMTM5LDYgKzEzOSwxMiBA
QCBzdGF0aWMgaW50IG10NzkxNV9pbml0X2hhcmR3YXJlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYp
DQogDQogCXNldF9iaXQoTVQ3Nl9TVEFURV9JTklUSUFMSVpFRCwgJmRldi0+bXBoeS5zdGF0ZSk7
DQogDQorCS8qDQorCSAqIGZvcmNlIGZpcm13YXJlIG9wZXJhdGlvbiBtb2RlIGludG8gbm9ybWFs
IHN0YXRlLA0KKwkgKiB3aGljaCBzaG91bGQgYmUgc2V0IGJlZm9yZSBmaXJtd2FyZSBkb3dubG9h
ZCBzdGFnZS4NCisJICovDQorCW10NzZfd3IoZGV2LCBNVF9TV0RFRl9NT0RFLCBNVF9TV0RFRl9O
T1JNQUxfTU9ERSk7DQorDQogCXJldCA9IG10NzkxNV9tY3VfaW5pdChkZXYpOw0KIAlpZiAocmV0
KQ0KIAkJcmV0dXJuIHJldDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9yZWdzLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzkxNS9yZWdzLmgNCmluZGV4IGUwNmM0ZDZjZDJmYy4uY2I4NTJhNGJmZDk3IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvcmVncy5o
DQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9yZWdzLmgN
CkBAIC0zNzEsNiArMzcxLDEzIEBAIHN0YXRpYyBpbmxpbmUgdTMyIG10NzkxNV9pbnRfcnhfbWFz
ayhlbnVtIG10NzZfcnhxX2lkIHEpDQogI2RlZmluZSBNVF9ISUZfUkVNQVBfTDJfQkFTRQkJR0VO
TUFTSygzMSwgMTIpDQogI2RlZmluZSBNVF9ISUZfUkVNQVBfQkFTRV9MMgkJMHgwMDAwMA0KIA0K
KyNkZWZpbmUgTVRfU1dERUZfQkFTRQkJCTB4NDFmMjAwDQorI2RlZmluZSBNVF9TV0RFRihvZnMp
CQkJKE1UX1NXREVGX0JBU0UgKyAob2ZzKSkNCisjZGVmaW5lIE1UX1NXREVGX01PREUJCQlNVF9T
V0RFRigweDNjKQ0KKyNkZWZpbmUgTVRfU1dERUZfTk9STUFMX01PREUJCTANCisjZGVmaW5lIE1U
X1NXREVGX0lDQVBfTU9ERQkJMQ0KKyNkZWZpbmUgTVRfU1dERUZfU1BFQ1RSVU1fTU9ERQkJMg0K
Kw0KICNkZWZpbmUgTVRfVE9QX0JBU0UJCQkweDE4MDYwMDAwDQogI2RlZmluZSBNVF9UT1Aob2Zz
KQkJCShNVF9UT1BfQkFTRSArIChvZnMpKQ0KIA0KLS0gDQoyLjE4LjANCg==

