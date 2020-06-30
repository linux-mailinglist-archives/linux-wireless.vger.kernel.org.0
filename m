Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2B20ECB1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 06:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgF3EiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 00:38:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43811 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726469AbgF3Eh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 00:37:59 -0400
X-UUID: 3898ab492d5744199b4459c20521ffc2-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FoTYp24eF+YXVi71xoB1IHArULDVoU2R5ArOZql2HM8=;
        b=YayVW+MXANoksVFe8GGJ/+PUGPV98H8aM66cPuE04O9kAcw9EnfQIfSOkH7zwtbiiyzL8xMrQtED8djEKfMFIRwUlyJiDh2xhq3D3XpEkQzLwoqYt4Lhuv5j6gR0psDdecNxFa6ZRqbokgQriBLl3vhUlMD3IxgnWS6K6aTVALo=;
X-UUID: 3898ab492d5744199b4459c20521ffc2-20200630
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1827106165; Tue, 30 Jun 2020 12:37:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 12:37:54 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 12:37:56 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/3] mt76: mt7663u: fix potential memory leak in mcu message handler
Date:   Tue, 30 Jun 2020 12:37:50 +0800
Message-ID: <74f27a79f53c6df3c49484a27c5b954d827cd9a5.1593491298.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5e8786d9cf0ccd09dd9c13c24c48ce441afbf0ff.1593491298.git.sean.wang@mediatek.com>
References: <5e8786d9cf0ccd09dd9c13c24c48ce441afbf0ff.1593491298.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9F3B80C1C9581102FA6D476316E8008941CD87F125D212641B645BD95A92D3E62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpGaXggcG90ZW50aWFs
IG1lbW9yeSBsZWFrIGluIG1jdSBtZXNzYWdlIGhhbmRsZXIgb24gZXJyb3IgY29uZGl0aW9uLg0K
DQpGaXhlczogZWI5OWNjOTVjM2I2ICgibXQ3NjogbXQ3NjE1OiBpbnRyb2R1Y2UgbXQ3NjYzdSBz
dXBwb3J0IikNClNpZ25lZC1vZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3VzYl9t
Y3UuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
NjE1L3VzYl9tY3UuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1
L3VzYl9tY3UuYw0KaW5kZXggY2Q3MDlmZDYxN2RiLi4zZTY2ZmY5OGNhYjggMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS91c2JfbWN1LmMNCisr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3VzYl9tY3UuYw0K
QEAgLTM0LDcgKzM0LDYgQEAgbXQ3NjYzdV9tY3Vfc2VuZF9tZXNzYWdlKHN0cnVjdCBtdDc2X2Rl
diAqbWRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwNCiANCiAJcmV0ID0gbXQ3NnVfYnVsa19tc2co
JmRldi0+bXQ3Niwgc2tiLT5kYXRhLCBza2ItPmxlbiwgTlVMTCwNCiAJCQkgICAgIDEwMDAsIGVw
KTsNCi0JZGV2X2tmcmVlX3NrYihza2IpOw0KIAlpZiAocmV0IDwgMCkNCiAJCWdvdG8gb3V0Ow0K
IA0KQEAgLTQzLDYgKzQyLDcgQEAgbXQ3NjYzdV9tY3Vfc2VuZF9tZXNzYWdlKHN0cnVjdCBtdDc2
X2RldiAqbWRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwNCiANCiBvdXQ6DQogCW11dGV4X3VubG9j
aygmbWRldi0+bWN1Lm11dGV4KTsNCisJZGV2X2tmcmVlX3NrYihza2IpOw0KIA0KIAlyZXR1cm4g
cmV0Ow0KIH0NCi0tIA0KMi4yNS4xDQo=

