Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474852177C0
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2020 21:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgGGTQ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jul 2020 15:16:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16610 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728840AbgGGTQ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jul 2020 15:16:57 -0400
X-UUID: 581ff3ed9db14024bc379809d4b02727-20200708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6WwLQZSskyqVpi7nnoZklS0XEE0b/m647iz/70QPzhA=;
        b=Al1fLAqMtxgm9Z4FlGhArPx2AeOHiMhU7dNhq3NmZLuIlN0ZiRz25Xt8yjgvXeEtyw+a6u2I08x8vvGURmYb7SHO9J8qTEIUqxSieUpZF0ixwRrAg7fCSy0AR4A537N2UDJpZkJ/HfZujirydB0p+S3+XkDoEWKoEHu7UUy2y3o=;
X-UUID: 581ff3ed9db14024bc379809d4b02727-20200708
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 588844300; Wed, 08 Jul 2020 03:16:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Jul 2020 03:16:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jul 2020 03:16:46 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/3] mt76: mt7663u: fix potential memory leak in mcu message handler
Date:   Wed, 8 Jul 2020 03:16:47 +0800
Message-ID: <f2a7b771de7a82b430f9960a6294090d62991a8f.1594148548.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <57b81f8efe7e767616a0d5957728756cbfdfa235.1594148548.git.sean.wang@mediatek.com>
References: <57b81f8efe7e767616a0d5957728756cbfdfa235.1594148548.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DFAE3EC087A09961308A87017844A1E472331BF8FCC4033435F92BDFEFB911A42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpGaXggcG90ZW50aWFs
IG1lbW9yeSBsZWFrIGluIG1jdSBtZXNzYWdlIGhhbmRsZXIgb24gZXJyb3IgY29uZGl0aW9uLg0K
DQp2MSAtPiB2MjoNCgktIGFkZCBBY2tlZC1ieSB0YWcNCg0KRml4ZXM6IGViOTljYzk1YzNiNiAo
Im10NzY6IG10NzYxNTogaW50cm9kdWNlIG10NzY2M3Ugc3VwcG9ydCIpDQpBY2tlZC1ieTogTG9y
ZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPg0KU2lnbmVkLW9mZi1ieTogU2VhbiBX
YW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvdXNiX21jdS5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvdXNiX21jdS5jIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvdXNiX21jdS5jDQppbmRleCBjZDcwOWZkNjE3ZGIu
LjNlNjZmZjk4Y2FiOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3NjE1L3VzYl9tY3UuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc2MTUvdXNiX21jdS5jDQpAQCAtMzQsNyArMzQsNiBAQCBtdDc2NjN1X21jdV9z
ZW5kX21lc3NhZ2Uoc3RydWN0IG10NzZfZGV2ICptZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0K
IA0KIAlyZXQgPSBtdDc2dV9idWxrX21zZygmZGV2LT5tdDc2LCBza2ItPmRhdGEsIHNrYi0+bGVu
LCBOVUxMLA0KIAkJCSAgICAgMTAwMCwgZXApOw0KLQlkZXZfa2ZyZWVfc2tiKHNrYik7DQogCWlm
IChyZXQgPCAwKQ0KIAkJZ290byBvdXQ7DQogDQpAQCAtNDMsNiArNDIsNyBAQCBtdDc2NjN1X21j
dV9zZW5kX21lc3NhZ2Uoc3RydWN0IG10NzZfZGV2ICptZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LA0KIA0KIG91dDoNCiAJbXV0ZXhfdW5sb2NrKCZtZGV2LT5tY3UubXV0ZXgpOw0KKwlkZXZfa2Zy
ZWVfc2tiKHNrYik7DQogDQogCXJldHVybiByZXQ7DQogfQ0KLS0gDQoyLjI1LjENCg==

