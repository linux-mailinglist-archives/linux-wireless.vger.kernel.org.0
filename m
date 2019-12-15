Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4164511F577
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2019 04:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfLOD4q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Dec 2019 22:56:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59863 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725933AbfLOD4q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Dec 2019 22:56:46 -0500
X-UUID: bd32002ec29549f8b1e57599c5ff4c02-20191215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=94xcQ2Z3dMqXswcxMI8M18CsZNx5V6+VkyJZm38GJdA=;
        b=M6RPoHdBWCLhl7GGdPO2fAIPyIgHq8iYFcyKkoQDhlSTJ+fbVd3uBqBsUKEtmGArRipAvuYCx2woY9rJ4XRQCoK2RDScr4ToifTnL1foKHzUODPE5W+Ar108oBhQYrGXhvQX/kYac+9xixRTg7LRp7CZU7mceDz89koUmnKLFWo=;
X-UUID: bd32002ec29549f8b1e57599c5ff4c02-20191215
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1202441300; Sun, 15 Dec 2019 11:56:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 15 Dec 2019 11:56:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 15 Dec 2019 11:56:22 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7615: add set_antenna callback
Date:   Sun, 15 Dec 2019 11:56:32 +0800
Message-ID: <6b3ac6736c0cfa12492f383ec9cfcaad91bfb965.1576381077.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <d3d47e29e2a39c42adfcf912a27b9d19a01d5010.1576381077.git.ryder.lee@mediatek.com>
References: <d3d47e29e2a39c42adfcf912a27b9d19a01d5010.1576381077.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 57E95DD40047F0123CF19775E0D27F7C3250BF6C281BF99FAF626FD033563F632000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIGEgc2V0X2FudGVubmEgY2FsbGJhY2sgdG8gc2V0dXAgcGVyIHBoeSB0eC9yeCBzdHJlYW1z
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBTaGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29t
Pg0KU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0t
DQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMgIHwgMzAgKysr
KysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWlu
LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMNCmlu
ZGV4IDc1OWE2Njk5N2M2Zi4uNzA3OTE1NDRhMDg4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jDQorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMNCkBAIC00OCw2ICs0OCw4IEBAIHN0
YXRpYyBpbnQgbXQ3NjE1X3N0YXJ0KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KIAkJbXQ3NjE1
X21jdV9zZXRfbWFjX2VuYWJsZShkZXYsIDEsIHRydWUpOw0KIAl9DQogDQorCW10NzYxNV9tY3Vf
c2V0X2NoYW5faW5mbyhwaHksIE1DVV9FWFRfQ01EX1NFVF9SWF9QQVRIKTsNCisNCiAJc2V0X2Jp
dChNVDc2X1NUQVRFX1JVTk5JTkcsICZwaHktPm10NzYtPnN0YXRlKTsNCiANCiAJaWYgKHJ1bm5p
bmcpDQpAQCAtNjM1LDYgKzYzNywzMyBAQCBtdDc2MTVfc2V0X2NvdmVyYWdlX2NsYXNzKHN0cnVj
dCBpZWVlODAyMTFfaHcgKmh3LCBzMTYgY292ZXJhZ2VfY2xhc3MpDQogCW10NzYxNV9tYWNfc2V0
X3RpbWluZyhwaHkpOw0KIH0NCiANCitzdGF0aWMgaW50DQorbXQ3NjE1X3NldF9hbnRlbm5hKHN0
cnVjdCBpZWVlODAyMTFfaHcgKmh3LCB1MzIgdHhfYW50LCB1MzIgcnhfYW50KQ0KK3sNCisJc3Ry
dWN0IG10NzYxNV9kZXYgKmRldiA9IG10NzYxNV9od19kZXYoaHcpOw0KKwlzdHJ1Y3QgbXQ3NjE1
X3BoeSAqcGh5ID0gbXQ3NjE1X2h3X3BoeShodyk7DQorCWludCBtYXhfbnNzID0gaHdlaWdodDgo
aHctPndpcGh5LT5hdmFpbGFibGVfYW50ZW5uYXNfdHgpOw0KKwlib29sIGV4dF9waHkgPSBwaHkg
IT0gJmRldi0+cGh5Ow0KKw0KKwlpZiAoIXR4X2FudCB8fCB0eF9hbnQgIT0gcnhfYW50IHx8IGZm
cyh0eF9hbnQpID4gbWF4X25zcykNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KKwlpZiAoKEJJVCho
d2VpZ2h0OCh0eF9hbnQpKSAtIDEpICE9IHR4X2FudCkNCisJCXR4X2FudCA9IEJJVChmZnModHhf
YW50KSAtIDEpIC0gMTsNCisNCisJbXV0ZXhfbG9jaygmZGV2LT5tdDc2Lm11dGV4KTsNCisNCisJ
cGh5LT5tdDc2LT5hbnRlbm5hX21hc2sgPSB0eF9hbnQ7DQorCXBoeS0+Y2hhaW5tYXNrID0gZXh0
X3BoeSA/IHR4X2FudCA8PCAyIDogdHhfYW50Ow0KKw0KKwltdDc2X3NldF9zdHJlYW1fY2Fwcygm
ZGV2LT5tdDc2LCB0cnVlKTsNCisJbXQ3NjE1X21jdV9zZXRfY2hhbl9pbmZvKHBoeSwgTUNVX0VY
VF9DTURfU0VUX1JYX1BBVEgpOw0KKw0KKwltdXRleF91bmxvY2soJmRldi0+bXQ3Ni5tdXRleCk7
DQorDQorCXJldHVybiAwOw0KK30NCisNCiBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX29wcyBtdDc2
MTVfb3BzID0gew0KIAkudHggPSBtdDc2MTVfdHgsDQogCS5zdGFydCA9IG10NzYxNV9zdGFydCwN
CkBAIC02NTksNSArNjg4LDYgQEAgY29uc3Qgc3RydWN0IGllZWU4MDIxMV9vcHMgbXQ3NjE1X29w
cyA9IHsNCiAJLmNoYW5uZWxfc3dpdGNoX2JlYWNvbiA9IG10NzYxNV9jaGFubmVsX3N3aXRjaF9i
ZWFjb24sDQogCS5nZXRfc3VydmV5ID0gbXQ3Nl9nZXRfc3VydmV5LA0KIAkuZ2V0X2FudGVubmEg
PSBtdDc2X2dldF9hbnRlbm5hLA0KKwkuc2V0X2FudGVubmEgPSBtdDc2MTVfc2V0X2FudGVubmEs
DQogCS5zZXRfY292ZXJhZ2VfY2xhc3MgPSBtdDc2MTVfc2V0X2NvdmVyYWdlX2NsYXNzLA0KIH07
DQotLSANCjIuMTguMA0K

