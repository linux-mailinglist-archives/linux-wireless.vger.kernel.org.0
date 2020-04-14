Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889E21A8D14
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2020 23:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633562AbgDNVBm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Apr 2020 17:01:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16032 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2633557AbgDNVB1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Apr 2020 17:01:27 -0400
X-UUID: 49c47fb9103f456abd2c040eb1d84027-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oObplImmavcTva7D2A2N6IVXbjIf17SETkg9WgxQcH4=;
        b=mEuYxw7vTErWNdf3ConxmpCXJfQotBIloRofY8EOd5wxQsdk54myc0Xp/hPK9xYKvtKrURywRP4IW7rSK+ivv5AOW4hpITqqU4dvienHJEKrNIXrvGWk0rVVKk7o8wEfkrak6pARlxwMuEWiy5a6fXapZl4/XWxSno60+9EbwoM=;
X-UUID: 49c47fb9103f456abd2c040eb1d84027-20200415
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 388822282; Wed, 15 Apr 2020 05:01:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 05:01:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Apr 2020 05:01:18 +0800
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
Subject: [PATCH v2 02/18] mt76: add support for HE RX rate reporting
Date:   Wed, 15 Apr 2020 05:01:00 +0800
Message-ID: <1f9ed54786ea8f7933a1c720d631c1051b53f2cf.1586895593.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1586895593.git.ryder.lee@mediatek.com>
References: <cover.1586895593.git.ryder.lee@mediatek.com>
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
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L21hYzgwMjExLmMNCmluZGV4IGY0NGY5OTE4
NGMxMC4uNWU3OTVlODQ5OTkwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tYWM4MDIxMS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L21hYzgwMjExLmMNCkBAIC02NzcsNyArNjc3LDYgQEAgbXQ3Nl9yeF9jb252ZXJ0KHN0
cnVjdCBtdDc2X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KIAkJc3RydWN0IGllZWU4
MDIxMV9odyAqKmh3LA0KIAkJc3RydWN0IGllZWU4MDIxMV9zdGEgKipzdGEpDQogew0KLQ0KIAlz
dHJ1Y3QgaWVlZTgwMjExX3J4X3N0YXR1cyAqc3RhdHVzID0gSUVFRTgwMjExX1NLQl9SWENCKHNr
Yik7DQogCXN0cnVjdCBtdDc2X3J4X3N0YXR1cyBtc3RhdDsNCiANCkBAIC02ODksNiArNjg4LDkg
QEAgbXQ3Nl9yeF9jb252ZXJ0KHN0cnVjdCBtdDc2X2RldiAqZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLA0KIAlzdGF0dXMtPmVuY19mbGFncyA9IG1zdGF0LmVuY19mbGFnczsNCiAJc3RhdHVzLT5l
bmNvZGluZyA9IG1zdGF0LmVuY29kaW5nOw0KIAlzdGF0dXMtPmJ3ID0gbXN0YXQuYnc7DQorCXN0
YXR1cy0+aGVfcnUgPSBtc3RhdC5oZV9ydTsNCisJc3RhdHVzLT5oZV9naSA9IG1zdGF0LmhlX2dp
Ow0KKwlzdGF0dXMtPmhlX2RjbSA9IG1zdGF0LmhlX2RjbTsNCiAJc3RhdHVzLT5yYXRlX2lkeCA9
IG1zdGF0LnJhdGVfaWR4Ow0KIAlzdGF0dXMtPm5zcyA9IG1zdGF0Lm5zczsNCiAJc3RhdHVzLT5i
YW5kID0gbXN0YXQuYmFuZDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzYuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
Ni5oDQppbmRleCAzNmZlMTYzODg5YjguLjRmOTk4MDRmZjkwMiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQorKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0KQEAgLTQ1OCw3ICs0NTgsOCBAQCBzdHJ1Y3Qg
bXQ3Nl9yeF9zdGF0dXMgew0KIAl1MTYgZnJlcTsNCiAJdTMyIGZsYWc7DQogCXU4IGVuY19mbGFn
czsNCi0JdTggZW5jb2Rpbmc6MiwgYnc6MzsNCisJdTggZW5jb2Rpbmc6MiwgYnc6MywgaGVfcnU6
MzsNCisJdTggaGVfZ2k6MiwgaGVfZGNtOjE7DQogCXU4IHJhdGVfaWR4Ow0KIAl1OCBuc3M7DQog
CXU4IGJhbmQ7DQotLSANCjIuMTguMA0K

