Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F79828BD89
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390257AbgJLQVh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 12:21:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45042 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390130AbgJLQVh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 12:21:37 -0400
X-UUID: 1d9b395a728b451a9eda6026476b3ff8-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=waJ1Cl7TmNEDBI+o8ifx+7GweQsvOZGboSlY0FOCwaY=;
        b=sMg9/8q2/vuSQXz9nw8eO2u27/svQ8kop974j2b+NTy2JphMvCcYNAtigGPGSzL/eiMIbPzeV+GJE8FS8N8Xg9HuxLHIZ5iJ21rdIzi0DwiCPynF0d+CZBpVrBbpKjIFjzHP+WR69S37A5y3NmM2exypN0jzmk2s41MS6anVATQ=;
X-UUID: 1d9b395a728b451a9eda6026476b3ff8-20201013
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 711164395; Tue, 13 Oct 2020 00:21:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Oct 2020 00:21:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Oct 2020 00:21:22 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix sparse warning cast from restricted __le16
Date:   Tue, 13 Oct 2020 00:21:21 +0800
Message-ID: <bdd848a347b7c5b037c76b2617f1825402895f2c.1602519389.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D012C46E0D2F8B7A1F5C40D17353E05C647CCE7B7507DB6FE6A8C4E4F47006402000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jOjMzOToyNjog
c3BhcnNlOg0Kc3BhcnNlOiBjYXN0IGZyb20gcmVzdHJpY3RlZCBfX2xlMTYNCg0KRml4ZXM6IDAw
YjJlMTYgKCJtdDc2OiBtdDc5MTU6IGFkZCBUeEJGIGNhcGFiaWxpdGllcyIpDQpSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSeWRl
ciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCmluZGV4IDUxZWViNzhjYTA3Ny4uMjQ1NzEy
NmZjODIzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5MTUvaW5pdC5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzkxNS9pbml0LmMNCkBAIC0zNTEsNyArMzUxLDcgQEAgbXQ3OTE1X3NldF9zdHJlYW1faGVfdHhi
Zl9jYXBzKHN0cnVjdCBpZWVlODAyMTFfc3RhX2hlX2NhcCAqaGVfY2FwLA0KIAllbGVtLT5waHlf
Y2FwX2luZm9bNF0gfD0gSUVFRTgwMjExX0hFX1BIWV9DQVA0X01VX0JFQU1GT1JNRVI7DQogDQog
CS8qIG51bV9zbmRfZGltICovDQotCWMgPSAobnNzIC0gMSkgfCAobWF4X3QoaW50LCBtY3MtPnR4
X21jc18xNjAsIDEpIDw8IDMpOw0KKwljID0gKG5zcyAtIDEpIHwgKG1heF90KGludCwgbGUxNl90
b19jcHUobWNzLT50eF9tY3NfMTYwKSwgMSkgPDwgMyk7DQogCWVsZW0tPnBoeV9jYXBfaW5mb1s1
XSB8PSBjOw0KIA0KIAljID0gSUVFRTgwMjExX0hFX1BIWV9DQVA2X1RSSUdfU1VfQkVBTUZPUk1F
Ul9GQiB8DQotLSANCjIuMTguMA0K

