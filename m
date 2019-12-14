Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0072911F199
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2019 12:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfLNLhz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Dec 2019 06:37:55 -0500
Received: from mailgw02.mediatek.com ([216.200.240.185]:40034 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNLhz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Dec 2019 06:37:55 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Dec 2019 06:37:55 EST
X-UUID: 0d80f49c04a44ca3ab62fc25a93521be-20191214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tu9Jxro/WRqZ8zFULZtR4PTpeFKrsiSb8i5Fjp7K8r0=;
        b=Spb7eG4sloYHT1JwoOCvxMlcMZ85bc/WwqYNUdxfO62wQAVoX6dvDfB6Y4G41B6M8yjACN/VZxQUh8RnM5jbraYfxzQJ9ZhPLI1o3lJbuRuT+rQiwoXV4K6BiL2GGJU1HfbiHe0i9qFAwhxkFTAd9ykTKYbaO0Xa6a0vInb9eiw=;
X-UUID: 0d80f49c04a44ca3ab62fc25a93521be-20191214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 265399583; Sat, 14 Dec 2019 03:32:42 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 14 Dec 2019 19:25:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 14 Dec 2019 19:25:14 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: do not overwrite max_tx_fragments if it has been set
Date:   Sat, 14 Dec 2019 19:22:04 +0800
Message-ID: <20191214112204.32701-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6C614476A65735D8D959C8976F109021CB8C575DD9BAB6DA3602F85CBB2D2B3C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

UHJldmVudCB0aGUgb3ZlcndyaXRpbmcgb2YgbWF4X3R4X2ZyYWdtZW50cyBpZiBpdCBoYXMgYWxy
ZWFkeSBiZWVuIHNldA0KaW4gY2hpcC1zcGVjaWZpYyBpbml0IHJvdXRpbmUuDQoNClNpZ25lZC1v
ZmYtYnk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L21hYzgwMjExLmMgfCA0ICsrKy0NCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L21hYzgwMjExLmMgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L21hYzgwMjExLmMNCmluZGV4IDAwYzJhODc1YTU5
Ni4uMGM3MWQ2NzFmMjlhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tYWM4MDIxMS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L21hYzgwMjExLmMNCkBAIC0yODcsNyArMjg3LDkgQEAgbXQ3Nl9waHlfaW5pdChzdHJ1Y3Qg
bXQ3Nl9kZXYgKmRldiwgc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQogCXdpcGh5LT5hdmFpbGFi
bGVfYW50ZW5uYXNfcnggPSBkZXYtPnBoeS5hbnRlbm5hX21hc2s7DQogDQogCWh3LT50eHFfZGF0
YV9zaXplID0gc2l6ZW9mKHN0cnVjdCBtdDc2X3R4cSk7DQotCWh3LT5tYXhfdHhfZnJhZ21lbnRz
ID0gMTY7DQorDQorCWlmICghaHctPm1heF90eF9mcmFnbWVudHMpDQorCQlody0+bWF4X3R4X2Zy
YWdtZW50cyA9IDE2Ow0KIA0KIAlpZWVlODAyMTFfaHdfc2V0KGh3LCBTSUdOQUxfREJNKTsNCiAJ
aWVlZTgwMjExX2h3X3NldChodywgUFNfTlVMTEZVTkNfU1RBQ0spOw0KLS0gDQoyLjE3LjENCg==

