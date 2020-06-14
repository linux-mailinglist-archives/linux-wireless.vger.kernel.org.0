Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6F1F8A08
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2020 20:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgFNSXr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jun 2020 14:23:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24262 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbgFNSXq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jun 2020 14:23:46 -0400
X-UUID: 4b472b98f7e44604b15d952f5abc045a-20200615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6Iu78bEOZUuD+x8ntpu745/T1aWmMJUM0s0T5RAk/6Q=;
        b=ipKJ8JKVHC9sbrSx8UUwM1DjzHdX/9qfUq8A6J9Ng12BQLLpNMgThctmmgnZ3MRQRQgS2qhqZOH/j1wXIYkaRB4ymAhkoW6V4j+Xu0PdwDwCjKDwUb1xRQ0CaT1SPXp171AD9CHmZYl2onIpI52/1OTc4/0M2hXaGcQ8HJQp7KI=;
X-UUID: 4b472b98f7e44604b15d952f5abc045a-20200615
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1926286898; Mon, 15 Jun 2020 02:23:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Jun 2020 02:23:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Jun 2020 02:23:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 4/4] mt76: mt7915: use ieee80211_tx_queue_params to avoid open coded
Date:   Mon, 15 Jun 2020 02:23:36 +0800
Message-ID: <f781975807a95d6d823a165d8eef727fb38cf259.1592158312.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1592158312.git.ryder.lee@mediatek.com>
References: <cover.1592158312.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBpcyBlYXN5IHRvIGFkZCBNVSBFRENBIHBhcmFtZXRlcnMgaW4gdGhlIGZ1dHVyZS4gVGhp
cyBwYXRjaA0KYWxzbyBmaXhlcyBhIHdyb25nIGN3X21pbiBhc3NpZ25tZW50Lg0KDQpTaWduZWQt
b2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMgICB8ICA2ICstLS0tLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jICAgIHwgMTQg
KysrKysrKy0tLS0tLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210Nzkx
NS9tdDc5MTUuaCB8ICA5ICsrLS0tLS0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgMTkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9tYWluLmMNCmluZGV4IGUwOTg5OTc0OGM5Yi4uMGMxMjE3ZDNhY2Q4
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUv
bWFpbi5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
YWluLmMNCkBAIC0zNTUsMTEgKzM1NSw3IEBAIG10NzkxNV9jb25mX3R4KHN0cnVjdCBpZWVlODAy
MTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLCB1MTYgcXVldWUsDQogDQogCS8q
IG5vIG5lZWQgdG8gdXBkYXRlIHJpZ2h0IGF3YXksIHdlJ2xsIGdldCBCU1NfQ0hBTkdFRF9RT1Mg
Ki8NCiAJcXVldWUgPSBtdDc5MTVfbG1hY19tYXBwaW5nKGRldiwgcXVldWUpOw0KLQ0KLQltdmlm
LT53bW1bcXVldWVdLmN3X21pbiA9IHBhcmFtcy0+Y3dfbWluOw0KLQltdmlmLT53bW1bcXVldWVd
LmN3X21heCA9IHBhcmFtcy0+Y3dfbWF4Ow0KLQltdmlmLT53bW1bcXVldWVdLmFpZnMgPSBwYXJh
bXMtPmFpZnM7DQotCW12aWYtPndtbVtxdWV1ZV0udHhvcCA9IHBhcmFtcy0+dHhvcDsNCisJbXZp
Zi0+cXVldWVfcGFyYW1zW3F1ZXVlXSA9ICpwYXJhbXM7DQogDQogCXJldHVybiAwOw0KIH0NCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3Uu
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQppbmRl
eCBjYTNlNzAwNDI1YjYuLmZhOWYzMmZhOWYyZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KQEAgLTI4ODgsMjMgKzI4ODgsMjMgQEAg
aW50IG10NzkxNV9tY3Vfc2V0X3R4KHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBpZWVl
ODAyMTFfdmlmICp2aWYpDQogCWludCBhYzsNCiANCiAJZm9yIChhYyA9IDA7IGFjIDwgSUVFRTgw
MjExX05VTV9BQ1M7IGFjKyspIHsNCisJCXN0cnVjdCBpZWVlODAyMTFfdHhfcXVldWVfcGFyYW1z
ICpxID0gJm12aWYtPnF1ZXVlX3BhcmFtc1thY107DQogCQlzdHJ1Y3QgZWRjYSAqZSA9ICZyZXEu
ZWRjYVthY107DQogDQogCQllLT5xdWV1ZSA9IGFjICsgbXZpZi0+d21tX2lkeCAqIE1UNzkxNV9N
QVhfV01NX1NFVFM7DQotCQllLT5haWZzID0gbXZpZi0+d21tW2FjXS5haWZzOw0KLQkJZS0+dHhv
cCA9IGNwdV90b19sZTE2KG12aWYtPndtbVthY10udHhvcCk7DQorCQllLT5haWZzID0gcS0+YWlm
czsNCisJCWUtPnR4b3AgPSBjcHVfdG9fbGUxNihxLT50eG9wKTsNCiANCi0JCWlmIChtdmlmLT53
bW1bYWNdLmN3X21pbikNCi0JCQllLT5jd19taW4gPSBmbHMobXZpZi0+d21tW2FjXS5jd19tYXgp
Ow0KKwkJaWYgKHEtPmN3X21pbikNCisJCQllLT5jd19taW4gPSBmbHMocS0+Y3dfbWluKTsNCiAJ
CWVsc2UNCiAJCQllLT5jd19taW4gPSA1Ow0KIA0KLQkJaWYgKG12aWYtPndtbVthY10uY3dfbWF4
KQ0KLQkJCWUtPmN3X21heCA9IGNwdV90b19sZTE2KGZscyhtdmlmLT53bW1bYWNdLmN3X21heCkp
Ow0KKwkJaWYgKHEtPmN3X21heCkNCisJCQllLT5jd19tYXggPSBjcHVfdG9fbGUxNihmbHMocS0+
Y3dfbWF4KSk7DQogCQllbHNlDQogCQkJZS0+Y3dfbWF4ID0gY3B1X3RvX2xlMTYoMTApOw0KIAl9
DQotDQogCXJldHVybiBfX210NzZfbWN1X3NlbmRfbXNnKCZkZXYtPm10NzYsIE1DVV9FWFRfQ01E
X0VEQ0FfVVBEQVRFLA0KIAkJCQkgICZyZXEsIHNpemVvZihyZXEpLCB0cnVlKTsNCiB9DQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1
LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tdDc5MTUuaA0K
aW5kZXggYjNiMDBkMDk5MjM2Li40YTA2M2MxZTVlYTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tdDc5MTUuaA0KKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1LmgNCkBAIC05OSwxNSArOTks
MTAgQEAgc3RydWN0IG10NzkxNV92aWYgew0KIAl1OCBiYW5kX2lkeDsNCiAJdTggd21tX2lkeDsN
CiANCi0Jc3RydWN0IHsNCi0JCXUxNiBjd19taW47DQotCQl1MTYgY3dfbWF4Ow0KLQkJdTE2IHR4
b3A7DQotCQl1OCBhaWZzOw0KLQl9IHdtbVtJRUVFODAyMTFfTlVNX0FDU107DQotDQogCXN0cnVj
dCBtdDc5MTVfc3RhIHN0YTsNCiAJc3RydWN0IG10NzkxNV9kZXYgKmRldjsNCisNCisJc3RydWN0
IGllZWU4MDIxMV90eF9xdWV1ZV9wYXJhbXMgcXVldWVfcGFyYW1zW0lFRUU4MDIxMV9OVU1fQUNT
XTsNCiB9Ow0KIA0KIHN0cnVjdCBtaWJfc3RhdHMgew0KLS0gDQoyLjE4LjANCg==

