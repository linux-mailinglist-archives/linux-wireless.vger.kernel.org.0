Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D0912B35F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2019 10:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfL0JAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Dec 2019 04:00:21 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3598 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726169AbfL0JAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Dec 2019 04:00:21 -0500
X-UUID: b9de2991da414af59d50dae5af12f267-20191227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ay+ibNcB5NYuieSrDeYdH8wOhecnM0m+aMHmpuj+/+g=;
        b=EtXThFTMb4P/nuUn0mAeVpVjxhxCg3venYqslp1vxLUCF/lfgY5YOeXQnb1a/1pPDcM90jLTnQxs6hI3vn1GCrWm1uZyLZv62IskeEEC2s7ZB6f9gT8sR5UmNJlaJXoF10ngkyaVa2mLRv0YSb1Q/cUpGhtoRRDX1Zl2pMXK2UE=;
X-UUID: b9de2991da414af59d50dae5af12f267-20191227
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1178422584; Fri, 27 Dec 2019 17:00:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 27 Dec 2019 16:59:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 27 Dec 2019 17:00:00 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/3] mt76: mt7615: add a .get_stats callback
Date:   Fri, 27 Dec 2019 17:00:09 +0800
Message-ID: <b9c5cf59dd656fb5dea67b46ed264d0e0290da3f.1577411732.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <7d450f0c4fec3c7242804e47f9bce13255e7f28d.1577411732.git.ryder.lee@mediatek.com>
References: <7d450f0c4fec3c7242804e47f9bce13255e7f28d.1577411732.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D8B3679B52C8892946EFCE5EE48E5DCE8D2162D8BAB16D665268CFBF2D8ACECB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIGEgLmdldF9zdGF0cyBjYWxsYmFjay4NCg0KU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxy
eWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jIHwgMTYgKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzYxNS9tYWluLmMNCmluZGV4IDBlZmQ4MDY1ODEyYy4uMzMxYmVkNzc1YjZk
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUv
bWFpbi5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9t
YWluLmMNCkBAIC02MjgsNiArNjI4LDIxIEBAIG10NzYxNV9zdGFfcmVtb3ZlKHN0cnVjdCBpZWVl
ODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KIAkJCSAgSUVFRTgwMjEx
X1NUQV9OT1RFWElTVCk7DQogfQ0KIA0KK3N0YXRpYyBpbnQNCittdDc2MTVfZ2V0X3N0YXRzKHN0
cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0KKwkJIHN0cnVjdCBpZWVlODAyMTFfbG93X2xldmVsX3N0
YXRzICpzdGF0cykNCit7DQorCXN0cnVjdCBtdDc2MTVfcGh5ICpwaHkgPSBtdDc2MTVfaHdfcGh5
KGh3KTsNCisJc3RydWN0IG1pYl9zdGF0cyAqbWliID0gJnBoeS0+bWliOw0KKw0KKwlzdGF0cy0+
ZG90MTFSVFNTdWNjZXNzQ291bnQgPSBtaWItPnJ0c19jbnQ7DQorCXN0YXRzLT5kb3QxMVJUU0Zh
aWx1cmVDb3VudCA9IG1pYi0+cnRzX3JldHJpZXNfY250Ow0KKwlzdGF0cy0+ZG90MTFGQ1NFcnJv
ckNvdW50ID0gbWliLT5mY3NfZXJyX2NudDsNCisJc3RhdHMtPmRvdDExQUNLRmFpbHVyZUNvdW50
ID0gbWliLT5hY2tfZmFpbF9jbnQ7DQorDQorCXJldHVybiAwOw0KK30NCisNCiBzdGF0aWMgdTY0
DQogbXQ3NjE1X2dldF90c2Yoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAy
MTFfdmlmICp2aWYpDQogew0KQEAgLTY3OSw2ICs2OTQsNyBAQCBjb25zdCBzdHJ1Y3QgaWVlZTgw
MjExX29wcyBtdDc2MTVfb3BzID0gew0KIAkucmVsZWFzZV9idWZmZXJlZF9mcmFtZXMgPSBtdDc2
X3JlbGVhc2VfYnVmZmVyZWRfZnJhbWVzLA0KIAkuZ2V0X3R4cG93ZXIgPSBtdDc2X2dldF90eHBv
d2VyLA0KIAkuY2hhbm5lbF9zd2l0Y2hfYmVhY29uID0gbXQ3NjE1X2NoYW5uZWxfc3dpdGNoX2Jl
YWNvbiwNCisJLmdldF9zdGF0cyA9IG10NzYxNV9nZXRfc3RhdHMsDQogCS5nZXRfdHNmID0gbXQ3
NjE1X2dldF90c2YsDQogCS5nZXRfc3VydmV5ID0gbXQ3Nl9nZXRfc3VydmV5LA0KIAkuZ2V0X2Fu
dGVubmEgPSBtdDc2X2dldF9hbnRlbm5hLA0KLS0gDQoyLjE4LjANCg==

