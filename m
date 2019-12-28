Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A412BC5B
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2019 04:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfL1DGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Dec 2019 22:06:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42727 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbfL1DGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Dec 2019 22:06:32 -0500
X-UUID: 6e18bea4fded4b338d5f7cdaee77f323-20191228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=uSTVEK+nsIniuJAECvz0aav3uObqmPZflDTTEqMVwi4=;
        b=V1Fmr/vxZ1I7HA7CDRWwWElz89uYJHWOgd0RFarg6OXXEmDbNvuk28r/dofIdTkkAltENQzQIQmdg9tFUhc1yk0IeEMxMJgHlGA2uuswkjYR3cLIpWcyHN7tqEUgSfgjDh2QV8u1i5Hh6UIpddLznEB5kHLMH8RpOhy3RGPxu3s=;
X-UUID: 6e18bea4fded4b338d5f7cdaee77f323-20191228
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1878609012; Sat, 28 Dec 2019 11:06:26 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 28 Dec 2019 11:07:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 28 Dec 2019 11:05:49 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v1 1/3] mt76: mt7615: report TSF information
Date:   Sat, 28 Dec 2019 11:05:10 +0800
Message-ID: <769aba6e014b8e7650c3909d6adb8427c1d5c5ae.1577501739.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBhZGRzIGEgZ2V0X3RzZigpIGNhbGxiYWNrIGZvciBpYnNzLg0KDQpTaWduZWQtb2ZmLWJ5
OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCmNoYW5nZXMgc2luY2Ug
djEgLSBtb2RpZnkgY29tbWl0IG1zZyBhbmQgdmFyaWFibGUgbmFtZS4NCi0tLQ0KIC4uLi9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jICB8IDIxICsrKysrKysrKysrKysr
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jDQppbmRleCAyYTg1ODU5
ZGE3NTQuLmZhNjczMzE5MThlYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3NjE1L21haW4uYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc2MTUvbWFpbi5jDQpAQCAtNjI4LDYgKzYyOCwyNiBAQCBtdDc2MTVfc3Rh
X3JlbW92ZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZp
ZiwNCiAJCQkgIElFRUU4MDIxMV9TVEFfTk9URVhJU1QpOw0KIH0NCiANCitzdGF0aWMgdTY0DQor
bXQ3NjE1X2dldF90c2Yoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFf
dmlmICp2aWYpDQorew0KKwlzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2ID0gbXQ3NjE1X2h3X2Rldiho
dyk7DQorCXVuaW9uIHsNCisJCXU2NCB0NjQ7DQorCQl1MzIgdDMyWzJdOw0KKwl9IHRzZjsNCisN
CisJbXV0ZXhfbG9jaygmZGV2LT5tdDc2Lm11dGV4KTsNCisNCisJbXQ3Nl9zZXQoZGV2LCBNVF9M
UE9OX1QwQ1IsIE1UX0xQT05fVDBDUl9NT0RFKTsgLyogVFNGIHJlYWQgKi8NCisJdHNmLnQzMlsw
XSA9IG10NzZfcnIoZGV2LCBNVF9MUE9OX1VUVFIwKTsNCisJdHNmLnQzMlsxXSA9IG10NzZfcnIo
ZGV2LCBNVF9MUE9OX1VUVFIxKTsNCisNCisJbXV0ZXhfdW5sb2NrKCZkZXYtPm10NzYubXV0ZXgp
Ow0KKw0KKwlyZXR1cm4gdHNmLnQ2NDsNCit9DQorDQogc3RhdGljIHZvaWQNCiBtdDc2MTVfc2V0
X2NvdmVyYWdlX2NsYXNzKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzMTYgY292ZXJhZ2VfY2xh
c3MpDQogew0KQEAgLTY1OSw2ICs2NzksNyBAQCBjb25zdCBzdHJ1Y3QgaWVlZTgwMjExX29wcyBt
dDc2MTVfb3BzID0gew0KIAkucmVsZWFzZV9idWZmZXJlZF9mcmFtZXMgPSBtdDc2X3JlbGVhc2Vf
YnVmZmVyZWRfZnJhbWVzLA0KIAkuZ2V0X3R4cG93ZXIgPSBtdDc2X2dldF90eHBvd2VyLA0KIAku
Y2hhbm5lbF9zd2l0Y2hfYmVhY29uID0gbXQ3NjE1X2NoYW5uZWxfc3dpdGNoX2JlYWNvbiwNCisJ
LmdldF90c2YgPSBtdDc2MTVfZ2V0X3RzZiwNCiAJLmdldF9zdXJ2ZXkgPSBtdDc2X2dldF9zdXJ2
ZXksDQogCS5nZXRfYW50ZW5uYSA9IG10NzZfZ2V0X2FudGVubmEsDQogCS5zZXRfY292ZXJhZ2Vf
Y2xhc3MgPSBtdDc2MTVfc2V0X2NvdmVyYWdlX2NsYXNzLA0KLS0gDQoyLjE4LjANCg==

