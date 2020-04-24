Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E711B7EF4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgDXTc7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 15:32:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14309 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729360AbgDXTc5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 15:32:57 -0400
X-UUID: 518bcbf365bf4709a110d15a39e7867b-20200425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XDktOf2vniFyQDGqyF7ynyGfsNnKETf+PHxTBonDFBg=;
        b=F5TA9mZ0i3UEbKdD/kKgfWaUVRiYoaPyLN7InoBYUmET6PQUP/y1IuOpXCGCGotOnpMMO4hBNaEX55YnpKx5rxWPZOEVW0ngGBeXp17E2mML0pRf82Yl4wZHlVJR/8rh49zAZIhlb9LDnaDrUflfTh8o3P3GIZmvAYb2PsoKpOQ=;
X-UUID: 518bcbf365bf4709a110d15a39e7867b-20200425
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 571092216; Sat, 25 Apr 2020 03:32:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 25 Apr 2020 03:32:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 25 Apr 2020 03:32:50 +0800
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
Subject: [PATCH v3 04/18] mt76: adjust wcid size to support new 802.11ax generation
Date:   Sat, 25 Apr 2020 03:32:25 +0800
Message-ID: <352573a70a544487e82aff10c20859bc6b44d6a0.1587756404.git.ryder.lee@mediatek.com>
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

VGhlIG5ld2VyIDgwMi4xMWF4IGRldmljZXMgKGkuZS4gTVQ3OTE1RSkgY2FuIGNvbm5lY3QgdG8g
bXVjaCBtb3JlDQpwZWVycyB0aGFuIHByZXZpb3VzIGdlbmVyYXRpb25zLg0KDQpTaWduZWQtb2Zm
LWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaCB8IDEwICsrKysrLS0tLS0NCiAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmggYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0KaW5kZXggYjJlNjE5YmFiMGU5Li4yZDBmYjU3
ZjA1MGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzYuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCkBA
IC0xODEsNyArMTgxLDcgQEAgZW51bSBtdDc2X3djaWRfZmxhZ3Mgew0KIAlNVF9XQ0lEX0ZMQUdf
UFMsDQogfTsNCiANCi0jZGVmaW5lIE1UNzZfTl9XQ0lEUyAxMjgNCisjZGVmaW5lIE1UNzZfTl9X
Q0lEUyAyODgNCiANCiAvKiBzdG9yZWQgaW4gaWVlZTgwMjExX3R4X2luZm86Omh3X3F1ZXVlICov
DQogI2RlZmluZSBNVF9UWF9IV19RVUVVRV9FWFRfUEhZCQlCSVQoMykNCkBAIC0yMDEsNyArMjAx
LDcgQEAgc3RydWN0IG10NzZfd2NpZCB7DQogCXN0cnVjdCBld21hX3NpZ25hbCByc3NpOw0KIAlp
bnQgaW5hY3RpdmVfY291bnQ7DQogDQotCXU4IGlkeDsNCisJdTE2IGlkeDsNCiAJdTggaHdfa2V5
X2lkeDsNCiANCiAJdTggc3RhOjE7DQpAQCAtMjY4LDcgKzI2OCw3IEBAIHN0cnVjdCBtdDc2X3J4
X3RpZCB7DQogDQogc3RydWN0IG10NzZfdHhfY2Igew0KIAl1bnNpZ25lZCBsb25nIGppZmZpZXM7
DQotCXU4IHdjaWQ7DQorCXUxNiB3Y2lkOw0KIAl1OCBwa3RpZDsNCiAJdTggZmxhZ3M7DQogfTsN
CkBAIC00NDMsNyArNDQzLDcgQEAgc3RydWN0IG10NzZfbW1pbyB7DQogc3RydWN0IG10NzZfcnhf
c3RhdHVzIHsNCiAJdW5pb24gew0KIAkJc3RydWN0IG10NzZfd2NpZCAqd2NpZDsNCi0JCXU4IHdj
aWRfaWR4Ow0KKwkJdTE2IHdjaWRfaWR4Ow0KIAl9Ow0KIA0KIAl1bnNpZ25lZCBsb25nIHJlb3Jk
ZXJfdGltZTsNCkBAIC02MjAsNyArNjIwLDcgQEAgZW51bSBtdDc2X3BoeV90eXBlIHsNCiAjZGVm
aW5lIG10NzZfaHcoZGV2KSAoZGV2KS0+bXBoeS5odw0KIA0KIHN0YXRpYyBpbmxpbmUgc3RydWN0
IGllZWU4MDIxMV9odyAqDQotbXQ3Nl93Y2lkX2h3KHN0cnVjdCBtdDc2X2RldiAqZGV2LCB1OCB3
Y2lkKQ0KK210NzZfd2NpZF9odyhzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgdTE2IHdjaWQpDQogew0K
IAlpZiAod2NpZCA8PSBNVDc2X05fV0NJRFMgJiYNCiAJICAgIG10NzZfd2NpZF9tYXNrX3Rlc3Qo
ZGV2LT53Y2lkX3BoeV9tYXNrLCB3Y2lkKSkNCi0tIA0KMi4xOC4wDQo=

