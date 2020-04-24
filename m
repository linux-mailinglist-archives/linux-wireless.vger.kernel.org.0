Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2E1B7EF1
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 21:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbgDXTc4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 15:32:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57369 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726908AbgDXTcz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 15:32:55 -0400
X-UUID: 0094ff5f8dd34af88c3da406774ab62d-20200425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yEW8X2NnaYwRxQbxBF03TWaDWQpug/aAmvpFQkebjBg=;
        b=AREBsd9yMPbGNC1fHL12DKsCjxCZuWtchBNl/UOCvDMZ3c6bipDpdZbe0NtTAb6pZp77GhmRu8C1fG/iyzeKq4RrZu69ZRjDWtbz3GCFRMV4IuV91jvbyiK/m3CLd+udJpHU5iuLzoK+tanb9g1Hp8sRvMsU6D216xdxIE/E8/w=;
X-UUID: 0094ff5f8dd34af88c3da406774ab62d-20200425
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1164148110; Sat, 25 Apr 2020 03:32:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 25 Apr 2020 03:32:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 25 Apr 2020 03:32:49 +0800
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
Subject: [PATCH v3 02/18] mt76: add support for HE RX rate reporting
Date:   Sat, 25 Apr 2020 03:32:23 +0800
Message-ID: <4de594b915945eef1e98c856391f25568f415fcd.1587756404.git.ryder.lee@mediatek.com>
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

QWRkIHN1cHBvcnQgZm9yIGVuY29kaW5nIGFuZCByZXBvcnRpbmcgSEUgUlggcmF0ZXMuDQoNClNp
Z25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbWFjODAyMTEuYyB8IDQgKysrLQ0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oICAgICB8IDMgKystDQogMiBm
aWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L21hYzgwMjExLmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L21hYzgwMjExLmMNCmluZGV4IDE3NmMyMmE1
MzE5YS4uZjEzMTE0YjA3YjZlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tYWM4MDIxMS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L21hYzgwMjExLmMNCkBAIC02NzYsNyArNjc2LDYgQEAgbXQ3Nl9yeF9jb252ZXJ0KHN0
cnVjdCBtdDc2X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KIAkJc3RydWN0IGllZWU4
MDIxMV9odyAqKmh3LA0KIAkJc3RydWN0IGllZWU4MDIxMV9zdGEgKipzdGEpDQogew0KLQ0KIAlz
dHJ1Y3QgaWVlZTgwMjExX3J4X3N0YXR1cyAqc3RhdHVzID0gSUVFRTgwMjExX1NLQl9SWENCKHNr
Yik7DQogCXN0cnVjdCBtdDc2X3J4X3N0YXR1cyBtc3RhdDsNCiANCkBAIC02ODgsNiArNjg3LDkg
QEAgbXQ3Nl9yeF9jb252ZXJ0KHN0cnVjdCBtdDc2X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLA0KIAlzdGF0dXMtPmVuY19mbGFncyA9IG1zdGF0LmVuY19mbGFnczsNCiAJc3RhdHVzLT5l
bmNvZGluZyA9IG1zdGF0LmVuY29kaW5nOw0KIAlzdGF0dXMtPmJ3ID0gbXN0YXQuYnc7DQorCXN0
YXR1cy0+aGVfcnUgPSBtc3RhdC5oZV9ydTsNCisJc3RhdHVzLT5oZV9naSA9IG1zdGF0LmhlX2dp
Ow0KKwlzdGF0dXMtPmhlX2RjbSA9IG1zdGF0LmhlX2RjbTsNCiAJc3RhdHVzLT5yYXRlX2lkeCA9
IG1zdGF0LnJhdGVfaWR4Ow0KIAlzdGF0dXMtPm5zcyA9IG1zdGF0Lm5zczsNCiAJc3RhdHVzLT5i
YW5kID0gbXN0YXQuYmFuZDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzYuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
Ni5oDQppbmRleCA2ZTFkYWU3MTg2MDIuLmNlYmVmNTJmYjY4NSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0KQEAgLTQ2MCw3ICs0NjAsOCBAQCBzdHJ1Y3Qg
bXQ3Nl9yeF9zdGF0dXMgew0KIAl1MTYgZnJlcTsNCiAJdTMyIGZsYWc7DQogCXU4IGVuY19mbGFn
czsNCi0JdTggZW5jb2Rpbmc6MiwgYnc6MzsNCisJdTggZW5jb2Rpbmc6MiwgYnc6MywgaGVfcnU6
MzsNCisJdTggaGVfZ2k6MiwgaGVfZGNtOjE7DQogCXU4IHJhdGVfaWR4Ow0KIAl1OCBuc3M7DQog
CXU4IGJhbmQ7DQotLSANCjIuMTguMA0K

