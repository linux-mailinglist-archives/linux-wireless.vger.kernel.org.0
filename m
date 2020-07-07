Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBD2177C2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2020 21:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgGGTRB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jul 2020 15:17:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40254 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728858AbgGGTRB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jul 2020 15:17:01 -0400
X-UUID: f330164182ec492bb7d2d01260bf9607-20200708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2sll/Y485e+JNsrlD/BIKIwTJsEpJPT8Kwje84O+F/g=;
        b=XVo/B7sna3yn2Bnjv2ZnEAx+SuxoQHSNUJVBLUynozxX0xfyiIvpcQM6XP9lJGzwrAZ+6s+pgwbgTbj8q6X/0Uz99AfU3Ihpy5thGXdpPiDL8GskpteNrCpgr0aLcTk00E8sD26x/ZZo1oeDXiJcAmnz3BNcD0D1FUpTrewaOEw=;
X-UUID: f330164182ec492bb7d2d01260bf9607-20200708
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 928126492; Wed, 08 Jul 2020 03:16:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Jul 2020 03:16:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jul 2020 03:16:46 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 1/3] mt76: mt7663u: fix memory leak in set key
Date:   Wed, 8 Jul 2020 03:16:46 +0800
Message-ID: <57b81f8efe7e767616a0d5957728756cbfdfa235.1594148548.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpGaXggbWVtb3J5IGxl
YWsgaW4gc2V0IGtleS4NCg0KdjEgLT4gdjI6DQoJLSByZW1vdmUgdW5uZWVkZWQga2ZyZWUNCg0K
Rml4ZXM6IGViOTljYzk1YzNiNiAoIm10NzY6IG10NzYxNTogaW50cm9kdWNlIG10NzY2M3Ugc3Vw
cG9ydCIpDQpTaWduZWQtb2ZmLWJ5OiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+
DQotLS0NCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3VzYi5jICAgfCAy
MSArKysrKysrKysrKystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzYxNS91c2IuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3NjE1L3VzYi5jDQppbmRleCAwYmEyOGQzN2M0MTQuLmYzYzNhZDM1MDljOCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3VzYi5jDQor
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS91c2IuYw0KQEAg
LTE2NSwxMiArMTY1LDE2IEBAIF9fbXQ3NjYzdV9tYWNfc2V0X2tleShzdHJ1Y3QgbXQ3NjE1X2Rl
diAqZGV2LA0KIA0KIAlsb2NrZGVwX2Fzc2VydF9oZWxkKCZkZXYtPm10NzYubXV0ZXgpOw0KIA0K
LQlpZiAoIXN0YSkNCi0JCXJldHVybiAtRUlOVkFMOw0KKwlpZiAoIXN0YSkgew0KKwkJZXJyID0g
LUVJTlZBTDsNCisJCWdvdG8gb3V0Ow0KKwl9DQogDQogCWNpcGhlciA9IG10NzYxNV9tYWNfZ2V0
X2NpcGhlcihrZXktPmNpcGhlcik7DQotCWlmIChjaXBoZXIgPT0gTVRfQ0lQSEVSX05PTkUpDQot
CQlyZXR1cm4gLUVPUE5PVFNVUFA7DQorCWlmIChjaXBoZXIgPT0gTVRfQ0lQSEVSX05PTkUpIHsN
CisJCWVyciA9IC1FT1BOT1RTVVBQOw0KKwkJZ290byBvdXQ7DQorCX0NCiANCiAJd2NpZCA9ICZ3
ZC0+c3RhLT53Y2lkOw0KIA0KQEAgLTE3OCwxOSArMTgyLDIyIEBAIF9fbXQ3NjYzdV9tYWNfc2V0
X2tleShzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2LA0KIAllcnIgPSBtdDc2MTVfbWFjX3d0YmxfdXBk
YXRlX2tleShkZXYsIHdjaWQsIGtleS0+a2V5LCBrZXktPmtleWxlbiwNCiAJCQkJCSBjaXBoZXIs
IGtleS0+Y21kKTsNCiAJaWYgKGVyciA8IDApDQotCQlyZXR1cm4gZXJyOw0KKwkJZ290byBvdXQ7
DQogDQogCWVyciA9IG10NzYxNV9tYWNfd3RibF91cGRhdGVfcGsoZGV2LCB3Y2lkLCBjaXBoZXIs
IGtleS0+a2V5aWR4LA0KIAkJCQkJa2V5LT5jbWQpOw0KIAlpZiAoZXJyIDwgMCkNCi0JCXJldHVy
biBlcnI7DQorCQlnb3RvIG91dDsNCiANCiAJaWYgKGtleS0+Y21kID09IFNFVF9LRVkpDQogCQl3
Y2lkLT5jaXBoZXIgfD0gQklUKGNpcGhlcik7DQogCWVsc2UNCiAJCXdjaWQtPmNpcGhlciAmPSB+
QklUKGNpcGhlcik7DQogDQotCXJldHVybiAwOw0KK291dDoNCisJa2ZyZWUoa2V5LT5rZXkpOw0K
Kw0KKwlyZXR1cm4gZXJyOw0KIH0NCiANCiB2b2lkIG10NzY2M3Vfd3RibF93b3JrKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykNCi0tIA0KMi4yNS4xDQo=

