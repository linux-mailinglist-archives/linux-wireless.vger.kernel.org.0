Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE1420ECB2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 06:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgF3EiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 00:38:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7366 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726710AbgF3Eh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 00:37:59 -0400
X-UUID: 7a7beb4e41294a04b489af7aee3879f4-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=sLhvuF8ycBP/EBmo222dGA/PKnzAApSuMpmdqeHpmNc=;
        b=ucTjWca50y+ryFB9qApPXn4mvNS6FJFvlH06eGSh+pPf3nWdHMN2C8fqLrYcL3tId3X13sMP/nv7mkATEukPivNBNnEamcyPLbYwijviMfKQR6XAXJDGbizIVqIc7YFZA4SSqZiIlgJhJAvyvMAJUPm4ynH2sQ0VEKXqHwE59Y8=;
X-UUID: 7a7beb4e41294a04b489af7aee3879f4-20200630
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 56072673; Tue, 30 Jun 2020 12:37:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 12:37:52 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 12:37:54 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/3] mt76: mt7663u: fix memory leak in set key
Date:   Tue, 30 Jun 2020 12:37:49 +0800
Message-ID: <5e8786d9cf0ccd09dd9c13c24c48ce441afbf0ff.1593491298.git.sean.wang@mediatek.com>
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
YWsgaW4gc2V0IGtleS4NCg0KRml4ZXM6IGViOTljYzk1YzNiNiAoIm10NzY6IG10NzYxNTogaW50
cm9kdWNlIG10NzY2M3Ugc3VwcG9ydCIpDQpTaWduZWQtb2ZmLWJ5OiBTZWFuIFdhbmcgPHNlYW4u
d2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3NjE1L3VzYi5jICAgfCAyMiArKysrKysrKysrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS91c2IuYyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3VzYi5jDQppbmRleCAwYmEyOGQzN2M0MTQuLjk2
YTA4MWJlMTA4ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3NjE1L3VzYi5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzYxNS91c2IuYw0KQEAgLTE2NSwxMiArMTY1LDE2IEBAIF9fbXQ3NjYzdV9tYWNfc2V0X2tl
eShzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2LA0KIA0KIAlsb2NrZGVwX2Fzc2VydF9oZWxkKCZkZXYt
Pm10NzYubXV0ZXgpOw0KIA0KLQlpZiAoIXN0YSkNCi0JCXJldHVybiAtRUlOVkFMOw0KKwlpZiAo
IXN0YSkgew0KKwkJZXJyID0gLUVJTlZBTDsNCisJCWdvdG8gb3V0Ow0KKwl9DQogDQogCWNpcGhl
ciA9IG10NzYxNV9tYWNfZ2V0X2NpcGhlcihrZXktPmNpcGhlcik7DQotCWlmIChjaXBoZXIgPT0g
TVRfQ0lQSEVSX05PTkUpDQotCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQorCWlmIChjaXBoZXIgPT0g
TVRfQ0lQSEVSX05PTkUpIHsNCisJCWVyciA9IC1FT1BOT1RTVVBQOw0KKwkJZ290byBvdXQ7DQor
CX0NCiANCiAJd2NpZCA9ICZ3ZC0+c3RhLT53Y2lkOw0KIA0KQEAgLTE3OCwxOSArMTgyLDIzIEBA
IF9fbXQ3NjYzdV9tYWNfc2V0X2tleShzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2LA0KIAllcnIgPSBt
dDc2MTVfbWFjX3d0YmxfdXBkYXRlX2tleShkZXYsIHdjaWQsIGtleS0+a2V5LCBrZXktPmtleWxl
biwNCiAJCQkJCSBjaXBoZXIsIGtleS0+Y21kKTsNCiAJaWYgKGVyciA8IDApDQotCQlyZXR1cm4g
ZXJyOw0KKwkJZ290byBvdXQ7DQogDQogCWVyciA9IG10NzYxNV9tYWNfd3RibF91cGRhdGVfcGso
ZGV2LCB3Y2lkLCBjaXBoZXIsIGtleS0+a2V5aWR4LA0KIAkJCQkJa2V5LT5jbWQpOw0KIAlpZiAo
ZXJyIDwgMCkNCi0JCXJldHVybiBlcnI7DQorCQlnb3RvIG91dDsNCiANCiAJaWYgKGtleS0+Y21k
ID09IFNFVF9LRVkpDQogCQl3Y2lkLT5jaXBoZXIgfD0gQklUKGNpcGhlcik7DQogCWVsc2UNCiAJ
CXdjaWQtPmNpcGhlciAmPSB+QklUKGNpcGhlcik7DQogDQotCXJldHVybiAwOw0KK291dDoNCisJ
a2ZyZWUoa2V5LT5rZXkpOw0KKwlrZnJlZSh3ZCk7DQorDQorCXJldHVybiBlcnI7DQogfQ0KIA0K
IHZvaWQgbXQ3NjYzdV93dGJsX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KLS0gDQoy
LjI1LjENCg==

