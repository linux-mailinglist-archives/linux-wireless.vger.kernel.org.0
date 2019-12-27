Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900E512B361
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2019 10:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfL0JAW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Dec 2019 04:00:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:62155 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726297AbfL0JAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Dec 2019 04:00:21 -0500
X-UUID: 954e0df1a1164a75b568aaaac63a13bf-20191227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wEhcdasdHQ1MGhAkqC1Xmfme5mB/fjPet8BYixdocfA=;
        b=GF3FPAaZOVMOJ++CfNLvJvI7A2OCGcv6n1d8Mh8CW9iZECasLbOw5QqiSFzcRDXbndZz1cJJy4rhzwH/Ygznd9zM5D68Hdk1nNJ2R7cz6j85R/mAqVK486sJTXLnygFH6cIs2VktL121qK306Lxfx+2lggDMqTBnfrrQfcvsYZU=;
X-UUID: 954e0df1a1164a75b568aaaac63a13bf-20191227
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 402121409; Fri, 27 Dec 2019 17:00:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 27 Dec 2019 17:00:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 27 Dec 2019 16:59:59 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/3] mt76: mt7615: report TSF information
Date:   Fri, 27 Dec 2019 17:00:07 +0800
Message-ID: <7d450f0c4fec3c7242804e47f9bce13255e7f28d.1577411732.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBhZGRzIGEgLmdldF90c2YoKSBjYWxsYmFjayB0byByZXBvcnQgVFNGIHRpbWUuDQoNClNp
Z25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4u
Li9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jICB8IDIxICsrKysrKysr
KysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jDQppbmRleCAy
YTg1ODU5ZGE3NTQuLjBlZmQ4MDY1ODEyYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21haW4uYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jDQpAQCAtNjI4LDYgKzYyOCwyNiBAQCBtdDc2
MTVfc3RhX3JlbW92ZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92
aWYgKnZpZiwNCiAJCQkgIElFRUU4MDIxMV9TVEFfTk9URVhJU1QpOw0KIH0NCiANCitzdGF0aWMg
dTY0DQorbXQ3NjE1X2dldF90c2Yoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVl
ODAyMTFfdmlmICp2aWYpDQorew0KKwlzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2ID0gbXQ3NjE1X2h3
X2Rldihodyk7DQorCXVuaW9uIHsNCisJCXU2NCBxd29yZDsNCisJCXUzMiBkd29yZFsyXTsNCisJ
fSB0c2Y7DQorDQorCW11dGV4X2xvY2soJmRldi0+bXQ3Ni5tdXRleCk7DQorDQorCW10NzZfc2V0
KGRldiwgTVRfTFBPTl9UMENSLCBNVF9MUE9OX1QwQ1JfTU9ERSk7IC8qIFRTRiByZWFkICovDQor
CXRzZi5kd29yZFswXSA9IG10NzZfcnIoZGV2LCBNVF9MUE9OX1VUVFIwKTsNCisJdHNmLmR3b3Jk
WzFdID0gbXQ3Nl9ycihkZXYsIE1UX0xQT05fVVRUUjEpOw0KKw0KKwltdXRleF91bmxvY2soJmRl
di0+bXQ3Ni5tdXRleCk7DQorDQorCXJldHVybiB0c2YucXdvcmQ7DQorfQ0KKw0KIHN0YXRpYyB2
b2lkDQogbXQ3NjE1X3NldF9jb3ZlcmFnZV9jbGFzcyhzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywg
czE2IGNvdmVyYWdlX2NsYXNzKQ0KIHsNCkBAIC02NTksNiArNjc5LDcgQEAgY29uc3Qgc3RydWN0
IGllZWU4MDIxMV9vcHMgbXQ3NjE1X29wcyA9IHsNCiAJLnJlbGVhc2VfYnVmZmVyZWRfZnJhbWVz
ID0gbXQ3Nl9yZWxlYXNlX2J1ZmZlcmVkX2ZyYW1lcywNCiAJLmdldF90eHBvd2VyID0gbXQ3Nl9n
ZXRfdHhwb3dlciwNCiAJLmNoYW5uZWxfc3dpdGNoX2JlYWNvbiA9IG10NzYxNV9jaGFubmVsX3N3
aXRjaF9iZWFjb24sDQorCS5nZXRfdHNmID0gbXQ3NjE1X2dldF90c2YsDQogCS5nZXRfc3VydmV5
ID0gbXQ3Nl9nZXRfc3VydmV5LA0KIAkuZ2V0X2FudGVubmEgPSBtdDc2X2dldF9hbnRlbm5hLA0K
IAkuc2V0X2NvdmVyYWdlX2NsYXNzID0gbXQ3NjE1X3NldF9jb3ZlcmFnZV9jbGFzcywNCi0tIA0K
Mi4xOC4wDQo=

