Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5127B1A4C3C
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2020 00:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDJWvw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 18:51:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11210 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726701AbgDJWvw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 18:51:52 -0400
X-UUID: 555c7ff7d1ac4f02a5464c511650d16c-20200411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MIvmGv2w9GSD2whpWf+Sw+fOtLcWbT81bwWiGHhLCdA=;
        b=OhVW/LcPBDeOr5wpGYwzyVEhEA/TkbYA07ukf5/4skKC+Z1o0kP2/IWGCTVq0hAL+hA4rXu6YNRxOB0CAkfTwlD0kq3iL9ybb0kJ4Q4lcspOI7HMOF6yQjqQExwkYAA4qjxSJRysphvMAQAOOyqJFjULQYSQdEX8xRbXFPMY3Ig=;
X-UUID: 555c7ff7d1ac4f02a5464c511650d16c-20200411
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1891700184; Sat, 11 Apr 2020 06:51:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Apr 2020 06:51:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Apr 2020 06:51:41 +0800
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
Subject: [PATCH v1 04/16] mt76: adjust wcid size to support new 802.11ax generation
Date:   Sat, 11 Apr 2020 06:51:19 +0800
Message-ID: <8bf00322cb80c1ff2e9b137e97b987f1534a4d25.1586558901.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1586558901.git.ryder.lee@mediatek.com>
References: <cover.1586558901.git.ryder.lee@mediatek.com>
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
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaCB8IDExICsrKysrLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCmluZGV4IDhkMjdhZjYxYjYyZS4uYzVlNDRj
ODk2MDk3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc2LmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQpA
QCAtMTgxLDcgKzE4MSw3IEBAIGVudW0gbXQ3Nl93Y2lkX2ZsYWdzIHsNCiAJTVRfV0NJRF9GTEFH
X1BTLA0KIH07DQogDQotI2RlZmluZSBNVDc2X05fV0NJRFMgMTI4DQorI2RlZmluZSBNVDc2X05f
V0NJRFMgMjg4DQogDQogLyogc3RvcmVkIGluIGllZWU4MDIxMV90eF9pbmZvOjpod19xdWV1ZSAq
Lw0KICNkZWZpbmUgTVRfVFhfSFdfUVVFVUVfRVhUX1BIWQkJQklUKDMpDQpAQCAtMjAxLDcgKzIw
MSw3IEBAIHN0cnVjdCBtdDc2X3djaWQgew0KIAlzdHJ1Y3QgZXdtYV9zaWduYWwgcnNzaTsNCiAJ
aW50IGluYWN0aXZlX2NvdW50Ow0KIA0KLQl1OCBpZHg7DQorCXUxNiBpZHg7DQogCXU4IGh3X2tl
eV9pZHg7DQogDQogCXU4IHN0YToxOw0KQEAgLTI2OCw3ICsyNjgsNyBAQCBzdHJ1Y3QgbXQ3Nl9y
eF90aWQgew0KIA0KIHN0cnVjdCBtdDc2X3R4X2NiIHsNCiAJdW5zaWduZWQgbG9uZyBqaWZmaWVz
Ow0KLQl1OCB3Y2lkOw0KKwl1MTYgd2NpZDsNCiAJdTggcGt0aWQ7DQogCXU4IGZsYWdzOw0KIH07
DQpAQCAtNDQxLDcgKzQ0MSw3IEBAIHN0cnVjdCBtdDc2X21taW8gew0KIHN0cnVjdCBtdDc2X3J4
X3N0YXR1cyB7DQogCXVuaW9uIHsNCiAJCXN0cnVjdCBtdDc2X3djaWQgKndjaWQ7DQotCQl1OCB3
Y2lkX2lkeDsNCisJCXUxNiB3Y2lkX2lkeDsNCiAJfTsNCiANCiAJdW5zaWduZWQgbG9uZyByZW9y
ZGVyX3RpbWU7DQpAQCAtNjE4LDcgKzYxOCw3IEBAIGVudW0gbXQ3Nl9waHlfdHlwZSB7DQogI2Rl
ZmluZSBtdDc2X2h3KGRldikgKGRldiktPm1waHkuaHcNCiANCiBzdGF0aWMgaW5saW5lIHN0cnVj
dCBpZWVlODAyMTFfaHcgKg0KLW10NzZfd2NpZF9odyhzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgdTgg
d2NpZCkNCittdDc2X3djaWRfaHcoc3RydWN0IG10NzZfZGV2ICpkZXYsIHUxNiB3Y2lkKQ0KIHsN
CiAJaWYgKHdjaWQgPD0gTVQ3Nl9OX1dDSURTICYmDQogCSAgICBtdDc2X3djaWRfbWFza190ZXN0
KGRldi0+d2NpZF9waHlfbWFzaywgd2NpZCkpDQpAQCAtNzg2LDcgKzc4Niw2IEBAIHN0YXRpYyBp
bmxpbmUgYm9vbCBtdDc2X2lzX3NrYl9wa3RpZCh1OCBwa3RpZCkNCiBzdGF0aWMgaW5saW5lIHU4
IG10NzZfdHhfcG93ZXJfbnNzX2RlbHRhKHU4IG5zcykNCiB7DQogCXN0YXRpYyBjb25zdCB1OCBu
c3NfZGVsdGFbNF0gPSB7IDAsIDYsIDksIDEyIH07DQotDQogCXJldHVybiBuc3NfZGVsdGFbbnNz
IC0gMV07DQogfQ0KIA0KLS0gDQoyLjE4LjANCg==

