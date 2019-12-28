Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C012BC5C
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2019 04:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfL1DGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Dec 2019 22:06:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:7575 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726044AbfL1DGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Dec 2019 22:06:32 -0500
X-UUID: 5cbc3f8681d24474b03547c3bba3cf04-20191228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ij959lRItOwY5+DCQXFnh/qX3GVtKszFINCfTg2rMt0=;
        b=cOcFuJqeNqJzsxEgXG0pEyElfAwG+mNT6edzRkGVUhUMcrIJTeR45dYM2Nvi8B6gnb5GmTxnurXqGnzNThjEGcXudf60Ysd3HAfVODm0peL3SjTtNW3p8BPVJkNJz7wwMSncmk464g8+pmLZvnsLGKDVlox1+LITRSQwB71bf5c=;
X-UUID: 5cbc3f8681d24474b03547c3bba3cf04-20191228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1336383943; Sat, 28 Dec 2019 11:06:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 28 Dec 2019 11:05:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 28 Dec 2019 11:05:52 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 3/3] mt76: mt7615: add a get_stats() callback
Date:   Sat, 28 Dec 2019 11:05:12 +0800
Message-ID: <294f99d401beeee1e7f1e65bf32d580d1568aa24.1577501739.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <769aba6e014b8e7650c3909d6adb8427c1d5c5ae.1577501739.git.ryder.lee@mediatek.com>
References: <769aba6e014b8e7650c3909d6adb8427c1d5c5ae.1577501739.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C67F8ACB24958420C070F8DC06EF8CBC01D642FFE0CBF873142BF4F0890688832000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIGEgZ2V0X3N0YXRzKCkgY2FsbGJhY2sgZm9yIG1pYiBzdGF0aXN0aWNzLg0KDQpTaWduZWQt
b2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMgfCAxNiArKysrKysrKysr
KysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21haW4uYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21haW4uYw0KaW5kZXggZmE2NzMz
MTkxOGVhLi40YTJiZjY4OWM3OTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3NjE1L21haW4uYw0KQEAgLTYyOCw2ICs2MjgsMjEgQEAgbXQ3NjE1X3N0
YV9yZW1vdmUoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2
aWYsDQogCQkJICBJRUVFODAyMTFfU1RBX05PVEVYSVNUKTsNCiB9DQogDQorc3RhdGljIGludA0K
K210NzYxNV9nZXRfc3RhdHMoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsDQorCQkgc3RydWN0IGll
ZWU4MDIxMV9sb3dfbGV2ZWxfc3RhdHMgKnN0YXRzKQ0KK3sNCisJc3RydWN0IG10NzYxNV9waHkg
KnBoeSA9IG10NzYxNV9od19waHkoaHcpOw0KKwlzdHJ1Y3QgbWliX3N0YXRzICptaWIgPSAmcGh5
LT5taWI7DQorDQorCXN0YXRzLT5kb3QxMVJUU1N1Y2Nlc3NDb3VudCA9IG1pYi0+cnRzX2NudDsN
CisJc3RhdHMtPmRvdDExUlRTRmFpbHVyZUNvdW50ID0gbWliLT5ydHNfcmV0cmllc19jbnQ7DQor
CXN0YXRzLT5kb3QxMUZDU0Vycm9yQ291bnQgPSBtaWItPmZjc19lcnJfY250Ow0KKwlzdGF0cy0+
ZG90MTFBQ0tGYWlsdXJlQ291bnQgPSBtaWItPmFja19mYWlsX2NudDsNCisNCisJcmV0dXJuIDA7
DQorfQ0KKw0KIHN0YXRpYyB1NjQNCiBtdDc2MTVfZ2V0X3RzZihzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZikNCiB7DQpAQCAtNjc5LDYgKzY5NCw3IEBA
IGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfb3BzIG10NzYxNV9vcHMgPSB7DQogCS5yZWxlYXNlX2J1
ZmZlcmVkX2ZyYW1lcyA9IG10NzZfcmVsZWFzZV9idWZmZXJlZF9mcmFtZXMsDQogCS5nZXRfdHhw
b3dlciA9IG10NzZfZ2V0X3R4cG93ZXIsDQogCS5jaGFubmVsX3N3aXRjaF9iZWFjb24gPSBtdDc2
MTVfY2hhbm5lbF9zd2l0Y2hfYmVhY29uLA0KKwkuZ2V0X3N0YXRzID0gbXQ3NjE1X2dldF9zdGF0
cywNCiAJLmdldF90c2YgPSBtdDc2MTVfZ2V0X3RzZiwNCiAJLmdldF9zdXJ2ZXkgPSBtdDc2X2dl
dF9zdXJ2ZXksDQogCS5nZXRfYW50ZW5uYSA9IG10NzZfZ2V0X2FudGVubmEsDQotLSANCjIuMTgu
MA0K

