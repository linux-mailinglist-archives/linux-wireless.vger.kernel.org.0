Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242D51B7EF8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 21:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgDXTdA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 15:33:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24807 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729369AbgDXTc7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 15:32:59 -0400
X-UUID: bc070601f1664a1289f7be9819272716-20200425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PM/tnHF829ngtHOTKKrhyuy84EmR7mXqLZMyji6w4Dc=;
        b=meyNFn2s3q5ux8jTYBVXFE+HJ8uDH1vCtQGjDEKwFyG0fJNJ2sJuaTAMBcR6/V8WQG735fT7pSDuurgkHSz9b4X66i8PSx9EWg/BVKZxa/m6pByAHPcbjH9hDsYt5KSyp4Saoy4PukZKx2p5ZxdSZDwyo6B2C8DyrDCI3vKzVBo=;
X-UUID: bc070601f1664a1289f7be9819272716-20200425
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 652446989; Sat, 25 Apr 2020 03:32:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 25 Apr 2020 03:32:52 +0800
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
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 14/18] mt76: mt7915: add .sta_statistics support
Date:   Sat, 25 Apr 2020 03:32:35 +0800
Message-ID: <3eb5f6555d9351aa9cf6ba551c806e025d9ec478.1587756404.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1587756404.git.ryder.lee@mediatek.com>
References: <cover.1587756404.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIHVzZWZ1bCBkZWJ1ZyBjb3VudGVycyBzaW5jZSB0aGlzIGdlbmVyYXRpb24gdXNlcyBzdHJ1
Y3QgcmF0ZV9pbmZvDQp0byByZXBvcnQgSEUgdHggcmF0ZS4NCg0KU2lnbmVkLW9mZi1ieTogUnlk
ZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMgIHwgMjYgKysrKysrKysrKysrKysrKysrKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCmluZGV4IDZjYjY5YWU2Y2IwZS4uYjNl
MjZmZjMyMjg3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvbWFpbi5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzkxNS9tYWluLmMNCkBAIC02OTgsNiArNjk4LDMxIEBAIG10NzkxNV9zZXRfYW50ZW5uYShz
dHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgdTMyIHR4X2FudCwgdTMyIHJ4X2FudCkNCiAJcmV0dXJu
IDA7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIG10NzkxNV9zdGFfc3RhdGlzdGljcyhzdHJ1Y3QgaWVl
ZTgwMjExX2h3ICpodywNCisJCQkJICBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KKwkJCQkg
IHN0cnVjdCBpZWVlODAyMTFfc3RhICpzdGEsDQorCQkJCSAgc3RydWN0IHN0YXRpb25faW5mbyAq
c2luZm8pDQorew0KKwlzdHJ1Y3QgbXQ3OTE1X3N0YSAqbXN0YSA9IChzdHJ1Y3QgbXQ3OTE1X3N0
YSAqKXN0YS0+ZHJ2X3ByaXY7DQorCXN0cnVjdCBtdDc5MTVfc3RhX3N0YXRzICpzdGF0cyA9ICZt
c3RhLT5zdGF0czsNCisNCisJaWYgKCFzdGF0cy0+dHhfcmF0ZS5sZWdhY3kgJiYgIXN0YXRzLT50
eF9yYXRlLmZsYWdzKQ0KKwkJcmV0dXJuOw0KKw0KKwlpZiAoc3RhdHMtPnR4X3JhdGUubGVnYWN5
KSB7DQorCQlzaW5mby0+dHhyYXRlLmxlZ2FjeSA9IHN0YXRzLT50eF9yYXRlLmxlZ2FjeTsNCisJ
fSBlbHNlIHsNCisJCXNpbmZvLT50eHJhdGUubWNzID0gc3RhdHMtPnR4X3JhdGUubWNzOw0KKwkJ
c2luZm8tPnR4cmF0ZS5uc3MgPSBzdGF0cy0+dHhfcmF0ZS5uc3M7DQorCQlzaW5mby0+dHhyYXRl
LmJ3ID0gc3RhdHMtPnR4X3JhdGUuYnc7DQorCQlzaW5mby0+dHhyYXRlLmhlX2dpID0gc3RhdHMt
PnR4X3JhdGUuaGVfZ2k7DQorCQlzaW5mby0+dHhyYXRlLmhlX2RjbSA9IHN0YXRzLT50eF9yYXRl
LmhlX2RjbTsNCisJCXNpbmZvLT50eHJhdGUuaGVfcnVfYWxsb2MgPSBzdGF0cy0+dHhfcmF0ZS5o
ZV9ydV9hbGxvYzsNCisJfQ0KKwlzaW5mby0+dHhyYXRlLmZsYWdzID0gc3RhdHMtPnR4X3JhdGUu
ZmxhZ3M7DQorCXNpbmZvLT5maWxsZWQgfD0gQklUX1VMTChOTDgwMjExX1NUQV9JTkZPX1RYX0JJ
VFJBVEUpOw0KK30NCisNCiBzdGF0aWMgdm9pZA0KIG10NzkxNV9zdGFfcmNfdXBkYXRlKHN0cnVj
dCBpZWVlODAyMTFfaHcgKmh3LA0KIAkJICAgICBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0K
QEAgLTc0Niw2ICs3NzEsNyBAQCBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX29wcyBtdDc5MTVfb3Bz
ID0gew0KIAkuZ2V0X2FudGVubmEgPSBtdDc2X2dldF9hbnRlbm5hLA0KIAkuc2V0X2FudGVubmEg
PSBtdDc5MTVfc2V0X2FudGVubmEsDQogCS5zZXRfY292ZXJhZ2VfY2xhc3MgPSBtdDc5MTVfc2V0
X2NvdmVyYWdlX2NsYXNzLA0KKwkuc3RhX3N0YXRpc3RpY3MgPSBtdDc5MTVfc3RhX3N0YXRpc3Rp
Y3MsDQogI2lmZGVmIENPTkZJR19NQUM4MDIxMV9ERUJVR0ZTDQogCS5zdGFfYWRkX2RlYnVnZnMg
PSBtdDc5MTVfc3RhX2FkZF9kZWJ1Z2ZzLA0KICNlbmRpZg0KLS0gDQoyLjE4LjANCg==

