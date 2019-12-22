Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCCB128FC7
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 21:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLVULv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 15:11:51 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12127 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725951AbfLVULv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 15:11:51 -0500
X-UUID: c62fb3d6d6864253a7bdd0b2cbb2ac63-20191223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qwrFGFIz+QsHDpFfg3vjjA8jTU7ruwsFDOyFkQxVOwo=;
        b=XzBePS2oWDOW/O8HlRnO/pinGEhEHV/Ur8WBdG10D7nscXA9/HQPcIhx+SiTTIa2a1ktxji36EEXUHXsJOSy119x+SW9IxtOW1SCDCYuv3FlGchhq0a6RZFx1hQ/Ejbyucs3Pi7NBJLtFIMIql/P82jXj6t6JV3imQZQvZTdW2Y=;
X-UUID: c62fb3d6d6864253a7bdd0b2cbb2ac63-20191223
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 958929746; Mon, 23 Dec 2019 04:11:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Dec 2019 04:11:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Dec 2019 04:10:52 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v1 2/2] mt76: mt7615: add set_antenna callback
Date:   Mon, 23 Dec 2019 04:11:39 +0800
Message-ID: <965287b3917a6cb0cfd2acbf91dbbd0b9db9b085.1577044827.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <9a37e1340cc8c546587d7cf99d6c4d92e12e1a7d.1577044827.git.ryder.lee@mediatek.com>
References: <9a37e1340cc8c546587d7cf99d6c4d92e12e1a7d.1577044827.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8FD17A3244B10A2B92653ADE44844F4B5FF4EAB66C010A873F8A6619B11B88FE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIGEgc2V0X2FudGVubmEgY2FsbGJhY2sgdG8gc2V0dXAgcGVyIHBoeSB0eC9yeCBzdHJlYW1z
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBTaGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29t
Pg0KU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0t
DQpDaGFuZ2VzIHNpbmNlIHYxOg0KLSByZW1vdmUgdW5uZWNlc3NhcnkgY2FsbCByZWdhcmQgdG8g
YW50ZW5uYSBzZXR0aW5ncy4NCi0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc2MTUvbWFpbi5jICB8IDI3ICsrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwg
MjcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc2MTUvbWFpbi5jDQppbmRleCA5MGM0ZTc4NWExYTMuLjViODM1MjhmNzdhMCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21haW4u
Yw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5j
DQpAQCAtNjM3LDYgKzYzNywzMiBAQCBtdDc2MTVfc2V0X2NvdmVyYWdlX2NsYXNzKHN0cnVjdCBp
ZWVlODAyMTFfaHcgKmh3LCBzMTYgY292ZXJhZ2VfY2xhc3MpDQogCW10NzYxNV9tYWNfc2V0X3Rp
bWluZyhwaHkpOw0KIH0NCiANCitzdGF0aWMgaW50DQorbXQ3NjE1X3NldF9hbnRlbm5hKHN0cnVj
dCBpZWVlODAyMTFfaHcgKmh3LCB1MzIgdHhfYW50LCB1MzIgcnhfYW50KQ0KK3sNCisJc3RydWN0
IG10NzYxNV9kZXYgKmRldiA9IG10NzYxNV9od19kZXYoaHcpOw0KKwlzdHJ1Y3QgbXQ3NjE1X3Bo
eSAqcGh5ID0gbXQ3NjE1X2h3X3BoeShodyk7DQorCWludCBtYXhfbnNzID0gaHdlaWdodDgoaHct
PndpcGh5LT5hdmFpbGFibGVfYW50ZW5uYXNfdHgpOw0KKwlib29sIGV4dF9waHkgPSBwaHkgIT0g
JmRldi0+cGh5Ow0KKw0KKwlpZiAoIXR4X2FudCB8fCB0eF9hbnQgIT0gcnhfYW50IHx8IGZmcyh0
eF9hbnQpID4gbWF4X25zcykNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KKwlpZiAoKEJJVChod2Vp
Z2h0OCh0eF9hbnQpKSAtIDEpICE9IHR4X2FudCkNCisJCXR4X2FudCA9IEJJVChmZnModHhfYW50
KSAtIDEpIC0gMTsNCisNCisJbXV0ZXhfbG9jaygmZGV2LT5tdDc2Lm11dGV4KTsNCisNCisJcGh5
LT5tdDc2LT5hbnRlbm5hX21hc2sgPSB0eF9hbnQ7DQorCXBoeS0+Y2hhaW5tYXNrID0gZXh0X3Bo
eSA/IHR4X2FudCA8PCAyIDogdHhfYW50Ow0KKw0KKwltdDc2X3NldF9zdHJlYW1fY2FwcygmZGV2
LT5tdDc2LCB0cnVlKTsNCisNCisJbXV0ZXhfdW5sb2NrKCZkZXYtPm10NzYubXV0ZXgpOw0KKw0K
KwlyZXR1cm4gMDsNCit9DQorDQogY29uc3Qgc3RydWN0IGllZWU4MDIxMV9vcHMgbXQ3NjE1X29w
cyA9IHsNCiAJLnR4ID0gbXQ3NjE1X3R4LA0KIAkuc3RhcnQgPSBtdDc2MTVfc3RhcnQsDQpAQCAt
NjYxLDUgKzY4Nyw2IEBAIGNvbnN0IHN0cnVjdCBpZWVlODAyMTFfb3BzIG10NzYxNV9vcHMgPSB7
DQogCS5jaGFubmVsX3N3aXRjaF9iZWFjb24gPSBtdDc2MTVfY2hhbm5lbF9zd2l0Y2hfYmVhY29u
LA0KIAkuZ2V0X3N1cnZleSA9IG10NzZfZ2V0X3N1cnZleSwNCiAJLmdldF9hbnRlbm5hID0gbXQ3
Nl9nZXRfYW50ZW5uYSwNCisJLnNldF9hbnRlbm5hID0gbXQ3NjE1X3NldF9hbnRlbm5hLA0KIAku
c2V0X2NvdmVyYWdlX2NsYXNzID0gbXQ3NjE1X3NldF9jb3ZlcmFnZV9jbGFzcywNCiB9Ow0KLS0g
DQoyLjE4LjANCg==

