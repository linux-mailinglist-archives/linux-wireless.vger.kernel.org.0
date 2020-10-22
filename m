Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE429565D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 04:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895051AbgJVC2s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Oct 2020 22:28:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53862 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2443052AbgJVC2q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Oct 2020 22:28:46 -0400
X-UUID: 6d83216522a94d4c8f42f975051eb2bf-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OsrUwQxqriwwfjssZ4zMnRPt/9Y56sd1QaZKXyN19zk=;
        b=KLkPzBJ5NQLpMzQXwpPGlgUDpcQOx5nFB7F4hd5mH8GRFsncpzblro0FXyaQ5W4PyU3XPqBHqB6yeM7zRryJg3L2w+IO+GbSIp0GrRxj8aiCZ7BCT0l/VrpLDoPgNMzTPH23cHBpHQiiLzoPbd70NTyzIiXPg+w0miQ83QFtRMI=;
X-UUID: 6d83216522a94d4c8f42f975051eb2bf-20201022
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 965517465; Thu, 22 Oct 2020 10:28:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 10:28:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 10:28:39 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v4 05/10] mt76: mt7915: fix tx rate related fields in tx descriptor
Date:   Thu, 22 Oct 2020 10:28:15 +0800
Message-ID: <20201022022820.3077-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201022022820.3077-1-shayne.chen@mediatek.com>
References: <20201022022820.3077-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9BFCD7095D1E61FF07160C6A723BEC9EBAC75324263F79930F00E168388C8AB92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Q29ycmVjdCB0aGUgYml0ZmllbGRzIG9mIHR4IHJhdGV2YWwgYW5kIGJ3IGluIHR4IGRlc2NyaXB0
b3IuDQoNClJldmlld2VkLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBTaGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0t
DQogZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmggfCA2ICsr
KystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
YWMuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5oDQpp
bmRleCA0NTZiYjgxLi4wOTIxYjZmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L21hYy5oDQpAQCAtMjMxLDcgKzIzMSw3IEBAIGVudW0gdHhfbWN1
X3BvcnRfcV9pZHggew0KICNkZWZpbmUgTVRfVFhENl9BTlRfSUQJCQlHRU5NQVNLKDcsIDQpDQog
I2RlZmluZSBNVF9UWEQ2X0RZTl9CVwkJCUJJVCgzKQ0KICNkZWZpbmUgTVRfVFhENl9GSVhFRF9C
VwkJQklUKDIpDQotI2RlZmluZSBNVF9UWEQ2X0JXCQkJR0VOTUFTSygyLCAwKQ0KKyNkZWZpbmUg
TVRfVFhENl9CVwkJCUdFTk1BU0soMSwgMCkNCiANCiAjZGVmaW5lIE1UX1RYRDdfVFhEX0xFTgkJ
CUdFTk1BU0soMzEsIDMwKQ0KICNkZWZpbmUgTVRfVFhEN19VRFBfVENQX1NVTQkJQklUKDI5KQ0K
QEAgLTI0OCw3ICsyNDgsOSBAQCBlbnVtIHR4X21jdV9wb3J0X3FfaWR4IHsNCiAjZGVmaW5lIE1U
X1RYX1JBVEVfU1RCQwkJCUJJVCgxMykNCiAjZGVmaW5lIE1UX1RYX1JBVEVfTlNTCQkJR0VOTUFT
SygxMiwgMTApDQogI2RlZmluZSBNVF9UWF9SQVRFX01PREUJCQlHRU5NQVNLKDksIDYpDQotI2Rl
ZmluZSBNVF9UWF9SQVRFX0lEWAkJCUdFTk1BU0soNSwgMCkNCisjZGVmaW5lIE1UX1RYX1JBVEVf
U1VfRVhUX1RPTkUJCUJJVCg1KQ0KKyNkZWZpbmUgTVRfVFhfUkFURV9EQ00JCQlCSVQoNCkNCisj
ZGVmaW5lIE1UX1RYX1JBVEVfSURYCQkJR0VOTUFTSygzLCAwKQ0KIA0KICNkZWZpbmUgTVRfVFhQ
X01BWF9CVUZfTlVNCQk2DQogDQotLSANCjIuMTcuMQ0K

