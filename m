Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC4287362
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgJHLdV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 07:33:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33947 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729371AbgJHLdU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 07:33:20 -0400
X-UUID: 7703e1a59818488b97e8e9f06925a20d-20201008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lB2yOL1yHNpt3oHBOa9YeTNVGOoIXY9o4YvJcmDEOSo=;
        b=i8er5Bm4u3Nu6JJFAY2mNnNMKf6YabRwkwPJvB8mhiQnIJ5petOEbbklNeTZUUH+Yd6zBEKjuvWR7JsCXjeK5kyylWlNyBvW9oagkJEV+l5+kshiLNfIdVxCqcIIU88zc0MqvqE22N67ckCHO0xs0mYuHKwFlqc/3xSohEjC6Ko=;
X-UUID: 7703e1a59818488b97e8e9f06925a20d-20201008
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1490517639; Thu, 08 Oct 2020 19:33:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Oct 2020 19:33:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Oct 2020 19:33:13 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 05/10] mt76: mt7915: fix tx rate related fields in tx descriptor
Date:   Thu, 8 Oct 2020 19:28:59 +0800
Message-ID: <20201008112904.10620-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201008112904.10620-1-shayne.chen@mediatek.com>
References: <20201008112904.10620-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Q29ycmVjdCB0aGUgYml0ZmllbGRzIG9mIHR4IHJhdGV2YWwgYW5kIGJ3IGluIHR4IGRlc2NyaXB0
b3IuDQoNClNpZ25lZC1vZmYtYnk6IFNoYXluZSBDaGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5j
b20+DQpSZXZpZXdlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0t
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

