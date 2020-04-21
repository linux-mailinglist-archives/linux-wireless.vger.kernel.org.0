Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B141A1B1E27
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 07:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDUFUn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 01:20:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13648 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgDUFUn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 01:20:43 -0400
X-UUID: 5a3a076786c84c8d9a66f7de46457447-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xl04sGst5RWKqj6KRI3YoPG+MmLEAdUG9UGxqBx1emY=;
        b=bK3bvDV+irIB7SYH3X5F1e/BhdLU1w01yFWbry2c8yC72ADhH2biX2v9Tz0lsPie5kxeAjVJ1LpA7V/2ocYC1/lXegx47Qo4sR4w7ebaY3dpDaGWzH2S0w1OAwGmGIC9n/lvGuBPjR9qASiQrhmeVsrcDJJbnY+rK9jZVZQPbAY=;
X-UUID: 5a3a076786c84c8d9a66f7de46457447-20200421
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2033385352; Tue, 21 Apr 2020 13:20:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Apr 2020 13:20:27 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Apr 2020 13:20:26 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 2/3] mt76: mt7615: add missing code for providing aid info to the mcu
Date:   Tue, 21 Apr 2020 13:20:22 +0800
Message-ID: <0292e088e934199434f0ea06598274f57a24f3d9.1587445885.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1467d47fd111b5711fa74410833153bdc9e01b72.1587445885.git.sean.wang@mediatek.com>
References: <1467d47fd111b5711fa74410833153bdc9e01b72.1587445885.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpQYXJhbWV0ZXJzIGlu
IHN0YXRpb24gcmVjb3JkIHNob3VsZCBiZSBrZXB0IGFzIHVwIHRvIGRhdGUgYXMgQlNTIGJlaW5n
DQp1cGRhdGVkLg0KDQpGaXhlczogYTkwYjRiYTFmMTM0ICgibXQ3NjogbXQ3NjE1OiBwcm92aWRl
IGFpZCBpbmZvIHRvIHRoZSBtY3UiKQ0KU3VnZ2VzdGVkLWJ5OiBZRiBMdW8gPFlmLkx1b0BtZWRp
YXRlay5jb20+DQpTdWdnZXN0ZWQtYnk6IEx1Y3kgSHN1IDxMdWN5LkhzdUBtZWRpYXRlay5jb20+
DQpDby1kZXZlbG9wZWQtYnk6IFNvdWwgSHVhbmcgPFNvdWwuSHVhbmdAbWVkaWF0ZWsuY29tPg0K
U2lnbmVkLW9mZi1ieTogU291bCBIdWFuZyA8U291bC5IdWFuZ0BtZWRpYXRlay5jb20+DQpDby1k
ZXZlbG9wZWQtYnk6IExvcmVuem8gQmlhbmNvbmkgPGxvcmVuem9Aa2VybmVsLm9yZz4NClNpZ25l
ZC1vZmYtYnk6IExvcmVuem8gQmlhbmNvbmkgPGxvcmVuem9Aa2VybmVsLm9yZz4NClNpZ25lZC1v
ZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21haW4uYyB8IDE1ICsrKysrKysrKysr
KystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUv
bWFpbi5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5j
DQppbmRleCBjZGM4YmFiY2E4NWEuLmU1MDEyYWQ2ODBiYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21haW4uYw0KKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jDQpAQCAtNDk3LDkgKzQ5Nywx
OSBAQCBzdGF0aWMgdm9pZCBtdDc2MTVfYnNzX2luZm9fY2hhbmdlZChzdHJ1Y3QgaWVlZTgwMjEx
X2h3ICpodywNCiANCiAJbXV0ZXhfbG9jaygmZGV2LT5tdDc2Lm11dGV4KTsNCiANCi0JaWYgKGNo
YW5nZWQgJiBCU1NfQ0hBTkdFRF9BU1NPQykNCisJaWYgKGNoYW5nZWQgJiBCU1NfQ0hBTkdFRF9B
U1NPQykgew0KKwkJc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YTsNCisNCiAJCW10NzYxNV9tY3Vf
YWRkX2Jzc19pbmZvKHBoeSwgdmlmLCBpbmZvLT5hc3NvYyk7DQogDQorCQlyY3VfcmVhZF9sb2Nr
KCk7DQorCQlzdGEgPSBpZWVlODAyMTFfZmluZF9zdGEodmlmLCB2aWYtPmJzc19jb25mLmJzc2lk
KTsNCisJCXJjdV9yZWFkX3VubG9jaygpOw0KKw0KKwkJaWYgKHN0YSkNCisJCQltdDc2MTVfbWN1
X3N0YV9hZGQoZGV2LCB2aWYsIHN0YSwgaW5mby0+YXNzb2MpOw0KKwl9DQorDQogCWlmIChjaGFu
Z2VkICYgQlNTX0NIQU5HRURfRVJQX1NMT1QpIHsNCiAJCWludCBzbG90dGltZSA9IGluZm8tPnVz
ZV9zaG9ydF9zbG90ID8gOSA6IDIwOw0KIA0KQEAgLTU1Nyw3ICs1NjcsOCBAQCBpbnQgbXQ3NjE1
X21hY19zdGFfYWRkKHN0cnVjdCBtdDc2X2RldiAqbWRldiwgc3RydWN0IGllZWU4MDIxMV92aWYg
KnZpZiwNCiAJbXQ3NjE1X21hY193dGJsX3VwZGF0ZShkZXYsIGlkeCwNCiAJCQkgICAgICAgTVRf
V1RCTF9VUERBVEVfQURNX0NPVU5UX0NMRUFSKTsNCiANCi0JbXQ3NjE1X21jdV9zdGFfYWRkKGRl
diwgdmlmLCBzdGEsIHRydWUpOw0KKwlpZiAodmlmLT50eXBlICE9IE5MODAyMTFfSUZUWVBFX1NU
QVRJT04pDQorCQltdDc2MTVfbWN1X3N0YV9hZGQoZGV2LCB2aWYsIHN0YSwgdHJ1ZSk7DQogDQog
CXJldHVybiAwOw0KIH0NCi0tIA0KMi4yNS4xDQo=

