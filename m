Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560EB19D324
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbgDCJJY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 05:09:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46679 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727635AbgDCJJY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 05:09:24 -0400
X-UUID: 9b543f924a994a1fa534c2d4ac509a7e-20200403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=noTg9XcjB6G862HLpOk/NARelLKgQV8r1Sj1NFb+P00=;
        b=Tx4nBRZ2ZnWr94w5Tu+7/nC3nrvwPGBJTqIgjE3NsOpJtE4TC9qe2mrFk//rEqUFY2mxCAOd6wU8yYlESJZtSv+PLDmwHreMEpwlbEc7qMLVjrXNnzb2V3JAlNbaqntwVojTqKkzkPvvCqOIwGYDV4LtstanBHgRMhBUl0aItNM=;
X-UUID: 9b543f924a994a1fa534c2d4ac509a7e-20200403
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 257580661; Fri, 03 Apr 2020 17:09:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Apr 2020 17:09:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Apr 2020 17:09:15 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7663: correct the name of the rom patch
Date:   Fri, 3 Apr 2020 17:09:16 +0800
Message-ID: <e290681bc341a60575ee087d0bbd9a91ad1b1de0.1585904519.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpSb20gcGF0Y2ggaXMg
c2hhcmVkIGJldHdlZW4gQmx1ZXRvb3RoIGFuZCBXaWZpIGRldmljZXMsIHNvIGNvcnJlY3QgdGhl
DQpuYW1pbmcgdG8gYWxsb3cgdHdvIGRyaXZlcnMgdG8gc2hhcmUgdGhlIHNhbWUgZmlsZS4NCg0K
U2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbXQ3NjE1LmggfCAyICst
DQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tdDc2MTUu
aCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L210NzYxNS5oDQpp
bmRleCA1MmQyZDFhNDFmZTAuLjIzZmMxMjY0ODU4MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L210NzYxNS5oDQorKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tdDc2MTUuaA0KQEAgLTQxLDcgKzQxLDcg
QEANCiAjZGVmaW5lIE1UNzYxNV9GSVJNV0FSRV9WMgkJMg0KICNkZWZpbmUgTVQ3NjE1X0ZJUk1X
QVJFX1YzCQkzDQogDQotI2RlZmluZSBNVDc2NjNfUk9NX1BBVENICQkibWVkaWF0ZWsvbXQ3NjYz
cHIyaF92My5iaW4iDQorI2RlZmluZSBNVDc2NjNfUk9NX1BBVENICQkibWVkaWF0ZWsvbXQ3NjYz
cHIyaC5iaW4iDQogI2RlZmluZSBNVDc2NjNfRklSTVdBUkVfTjkgICAgICAgICAgICAgICJtZWRp
YXRlay9tdDc2NjNfbjlfdjMuYmluIg0KIA0KICNkZWZpbmUgTVQ3NjE1X0VFUFJPTV9TSVpFCQkx
MDI0DQotLSANCjIuMjUuMQ0K

