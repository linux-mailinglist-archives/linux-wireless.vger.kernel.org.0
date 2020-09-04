Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D85F25E338
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Sep 2020 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgIDVQQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Sep 2020 17:16:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23962 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726842AbgIDVQP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Sep 2020 17:16:15 -0400
X-UUID: 42e1fbee9e0d4ad1b1dd1853dd361cf1-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tlschwqKZgdubNfFxtjzpGyZVI9ZZHhyWThWKoFy9Pg=;
        b=fRIW1z90qvTaZwYCnwHIw3dPbOojsVA5UVEOHb52CE90DwkAhOOaLhDNB0kuGmPoYhnk6SuQguuYuUHQ9Ho5gsgiGwUHOCoWcNFflzCKi4IGfOD91oKT8ew8rGqfjupUmQq1t8UE3ktWUO/p+5imLO/fqomd3q/6J5pwPELBGiE=;
X-UUID: 42e1fbee9e0d4ad1b1dd1853dd361cf1-20200905
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1180230908; Sat, 05 Sep 2020 05:16:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 05:16:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 05:16:04 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7615: fix VHT LDPC capability
Date:   Sat, 5 Sep 2020 05:16:05 +0800
Message-ID: <1ffbbae4ce3905ddf52b9edb3b8ef1c107f47fa6.1599251705.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E76CA06A040520C10866A4FF875D5DA7323044EB342F9488C7D41543398306072000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhlIE1DVSBmaWVsZCBzaG91bGQgY29udGFpbiBhIGJvb2xlYW4gMC8xLCBub3QgdGhlIGZsYWcg
aXRzZWxmLg0KDQpTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5j
b20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3Uu
YyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQogbW9kZSBjaGFuZ2UgMTAwNjQ0ID0+IDEwMDc1NSBkcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0KaW5kZXggMDc0Y2RlZmJhOGFhLi5lNjFiZjU4NTA1
MTANCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5j
DQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0K
QEAgLTExNzksNyArMTE3OSw3IEBAIG10NzYxNV9tY3Vfd3RibF9odF90bHYoc3RydWN0IHNrX2J1
ZmYgKnNrYiwgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSwNCiAJCXRsdiA9IG10NzYxNV9tY3Vf
YWRkX25lc3RlZF90bHYoc2tiLCBXVEJMX0hULCBzaXplb2YoKmh0KSwNCiAJCQkJCQl3dGJsX3Rs
diwgc3RhX3d0YmwpOw0KIAkJaHQgPSAoc3RydWN0IHd0YmxfaHQgKil0bHY7DQotCQlodC0+bGRw
YyA9IHN0YS0+aHRfY2FwLmNhcCAmIElFRUU4MDIxMV9IVF9DQVBfTERQQ19DT0RJTkc7DQorCQlo
dC0+bGRwYyA9ICEhKHN0YS0+aHRfY2FwLmNhcCAmIElFRUU4MDIxMV9IVF9DQVBfTERQQ19DT0RJ
TkcpOw0KIAkJaHQtPmFmID0gc3RhLT5odF9jYXAuYW1wZHVfZmFjdG9yOw0KIAkJaHQtPm1tID0g
c3RhLT5odF9jYXAuYW1wZHVfZGVuc2l0eTsNCiAJCWh0LT5odCA9IDE7DQpAQCAtMTE5Nyw3ICsx
MTk3LDcgQEAgbXQ3NjE1X21jdV93dGJsX2h0X3RsdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1
Y3QgaWVlZTgwMjExX3N0YSAqc3RhLA0KIAkJdGx2ID0gbXQ3NjE1X21jdV9hZGRfbmVzdGVkX3Rs
dihza2IsIFdUQkxfVkhULCBzaXplb2YoKnZodCksDQogCQkJCQkJd3RibF90bHYsIHN0YV93dGJs
KTsNCiAJCXZodCA9IChzdHJ1Y3Qgd3RibF92aHQgKil0bHY7DQotCQl2aHQtPmxkcGMgPSBzdGEt
PnZodF9jYXAuY2FwICYgSUVFRTgwMjExX1ZIVF9DQVBfUlhMRFBDLA0KKwkJdmh0LT5sZHBjID0g
ISEoc3RhLT52aHRfY2FwLmNhcCAmIElFRUU4MDIxMV9WSFRfQ0FQX1JYTERQQyk7DQogCQl2aHQt
PnZodCA9IDE7DQogDQogCQlhZiA9IChzdGEtPnZodF9jYXAuY2FwICYNCi0tIA0KMi4xOC4wDQo=

