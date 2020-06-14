Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F811F8A10
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2020 20:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFNS1y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jun 2020 14:27:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11574 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbgFNS1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jun 2020 14:27:54 -0400
X-UUID: fb7583b060c240b59fdb4576e3b561ef-20200615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BJmFZxpc5gJCz9bp1c2mprgDExNZVkRketLDbjwuhBA=;
        b=DB5uIEK/BdCnCXAZwofRYD6R9QJUrE6LX+j7JliI8NpJV25I2MVOapQ1340UTdEkflXlSgiHacfYL0HAAh3TgwUZmAu4vVXmRYjur9ZxJL+lSGCpmgulD29ZaOqK0wbyvemqboztmbwVk5CSl6WVHR7annfS5JLTHiNIk02GJsY=;
X-UUID: fb7583b060c240b59fdb4576e3b561ef-20200615
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1303633512; Mon, 15 Jun 2020 02:27:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 15 Jun 2020 02:27:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 15 Jun 2020 02:27:45 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 0/4] mt7915: add MU-MIMO support
Date:   Mon, 15 Jun 2020 02:27:43 +0800
Message-ID: <cover.1592158312.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 51BD0B510CE7B4BDB95B28DDD489A5BBB0D09640FBCC167C46E2AB553BF6D0ED2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBzZXJpZXMgYWRkcyBNVS1NSU1PIHN1cHBvcnQuDQoNCmNoYW5nZXMgc2luY2UgdjM6DQot
IGFkZCBwYXRjaCAxLzQgdG8gYXZvaWQgb3BlbiBjb2RlZCBhbmQgZml4IGEgd3JvbmcgV01NIHBh
cmFtZXRlciBhc3NpZ25tZW50Lg0KLSBjbGVhbnVwIHVudXNlZCBzdGFfcmVjX211X2VkY2FfdGx2
Lg0KLSBmaXggYSB3cm9uZyBlbnVtIG51bWJlciAiTVRfTE1BQ19CTUMwID0gMHgxMCIsDQoNCmNo
YW5nZXMgc2luY2UgdjI6DQotIG1vdmUgQ09ORklHX01BQzgwMjExX0RFQlVHRlMgZml4dXAgaW50
byBwYXRjaCAxLzMNCg0KUnlkZXIgTGVlICg0KToNCiAgbXQ3NjogbXQ3OTE1OiBhZGQgbWlzc2lu
ZyBDT05GSUdfTUFDODAyMTFfREVCVUdGUw0KICBtdDc2OiBtdDc5MTU6IGFkZCBhIGZpeGVkIEFD
IHF1ZXVlIG1hcHBpbmcNCiAgbXQ3NjogbXQ3OTE1OiBhZGQgTVUtTUlNTyBzdXBwb3J0DQogIG10
NzY6IG10NzkxNTogdXNlIGllZWU4MDIxMV90eF9xdWV1ZV9wYXJhbXMgdG8gYXZvaWQgb3BlbiBj
b2RlZA0KDQogLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L2RlYnVnZnMuYyAgIHwg
MTEgKystDQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWMuYyAgIHwg
IDIgKy0NCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5oICAgfCAx
MCAtLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFpbi5jICB8ICA3
ICstDQogLi4uL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYyAgIHwgOTEg
KysrKysrKysrKysrKysrKy0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWN1LmggICB8ICA2ICstDQogLi4uL3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210
NzkxNS5oICAgIHwgMzQgKysrKystLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc5MTUvcmVncy5oICB8ICA1ICsNCiA4IGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNlcnRpb25zKCsp
LCAzOSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE4LjANCg==

