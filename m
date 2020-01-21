Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A48CA143F16
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2020 15:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgAUOOA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jan 2020 09:14:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:20013 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729308AbgAUON5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jan 2020 09:13:57 -0500
X-UUID: 8e1906cf188648cd810aa3e3060c7c14-20200121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5PijtlWhrJ3vYo3oL0POogoDCVJJn4dKgaURDq8yKg0=;
        b=Zaxw1rvgtJ9ySipDlDT8Vu1tozDUMPEDuho8bkjFJ9kBpzwzoabyuwx++YJBLt8HyNEn4/gXexwZOwUypUj4zKFnYtlFUfMkP9uVdSNeXLEUzSw81uaD3Cor+nCr4scQj+304CNZ9XWCpWTQIRNusLT7mXiBkcNynXPaFS9JTKc=;
X-UUID: 8e1906cf188648cd810aa3e3060c7c14-20200121
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2007033303; Tue, 21 Jan 2020 22:13:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 Jan 2020 22:13:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 Jan 2020 22:13:30 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 5/7] mt76: mt7615: add a tag sta_rec_wtbl for v2 firmware
Date:   Tue, 21 Jan 2020 22:13:40 +0800
Message-ID: <f63355b98c04dc866d703e444e40401fe377cdb8.1579237414.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <ae72dd289f8a26a2c0f42de1f940bb8b6d1f2c29.1579237414.git.ryder.lee@mediatek.com>
References: <ae72dd289f8a26a2c0f42de1f940bb8b6d1f2c29.1579237414.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TmV3IGZpcm13YXJlIHVzZSB0YWcgc3RhX3JlY193dGJsIHRvIHJlcGxhY2UgTUNVX0VYVF9DTURf
V1RCTF9VUERBVEUuDQpUaGlzIGNhbiByZWR1Y2UgY29tbWFuZC9ldmVudCB0aW1lcy4NCg0KU2ln
bmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9m
Zi1ieTogU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4NClRlc3RlZC1ieTog
U2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYyAgIHwgMjIgKysrKysrKysrKysrKysrKysrKw0K
IC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmggICB8ICA5ICsrKysr
LS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUv
bWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0K
aW5kZXggYzA1NTk0OWIyODljLi44ZjRiOGQ4MTU5ZGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0KKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCkBAIC0xMDM5LDYgKzEwMzksNyBA
QCBpbnQgbXQ3NjE1X21jdV9zZXRfYm1jKHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYsDQogCQkJLmNv
bm5fdHlwZSA9IGNwdV90b19sZTMyKENPTk5FQ1RJT05fSU5GUkFfQkMpLA0KIAkJfSwNCiAJfTsN
CisJc3RydWN0IHN0YV9yZWNfd3RibCAqd3RibCA9IE5VTEw7DQogCXN0cnVjdCB3dGJsX3JlcV9o
ZHIgKnd0YmxfaGRyOw0KIAlzdHJ1Y3Qgd3RibF9nZW5lcmljICp3dGJsX2c7DQogCXN0cnVjdCB3
dGJsX3J4ICp3dGJsX3J4Ow0KQEAgLTEwNDYsNiArMTA0NywxMyBAQCBpbnQgbXQ3NjE1X21jdV9z
ZXRfYm1jKHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYsDQogDQogCWV0aF9icm9hZGNhc3RfYWRkcihy
ZXEuYmFzaWMucGVlcl9hZGRyKTsNCiANCisJaWYgKGRldi0+ZndfdmVyID4gTVQ3NjE1X0ZJUk1X
QVJFX1YxKSB7DQorCQlyZXEuaGRyLnRsdl9udW0gPSBjcHVfdG9fbGUxNigyKTsNCisJCXd0Ymwg
PSAoc3RydWN0IHN0YV9yZWNfd3RibCAqKWJ1ZjsNCisJCXd0YmwtPnRhZyA9IGNwdV90b19sZTE2
KFNUQV9SRUNfV1RCTCk7DQorCQlidWYgKz0gc2l6ZW9mKCp3dGJsKTsNCisJfQ0KKw0KIAl3dGJs
X2hkciA9IChzdHJ1Y3Qgd3RibF9yZXFfaGRyICopYnVmOw0KIAlidWYgKz0gc2l6ZW9mKCp3dGJs
X2hkcik7DQogCXd0YmxfaGRyLT53bGFuX2lkeCA9IG12aWYtPnN0YS53Y2lkLmlkeDsNCkBAIC0x
MDc5LDYgKzEwODcsOSBAQCBpbnQgbXQ3NjE1X21jdV9zZXRfYm1jKHN0cnVjdCBtdDc2MTVfZGV2
ICpkZXYsDQogCXd0YmxfaGRyLT50bHZfbnVtID0gY3B1X3RvX2xlMTYoMik7DQogDQogb3V0Og0K
KwlpZiAod3RibCkNCisJCXd0YmwtPmxlbiA9IGNwdV90b19sZTE2KGJ1ZiAtICh1OCAqKXd0Ymxf
aGRyKTsNCisNCiAJcmV0dXJuIG10NzYxNV9tY3Vfc2VuZF9zdGFfcmVjKGRldiwgKHU4ICopJnJl
cSwgKHU4ICopd3RibF9oZHIsDQogCQkJCSAgICAgICBidWYgLSAodTggKil3dGJsX2hkciwgZW4p
Ow0KIH0NCkBAIC0xMTA3LDYgKzExMTgsNyBAQCBpbnQgbXQ3NjE1X21jdV9zZXRfc3RhKHN0cnVj
dCBtdDc2MTVfZGV2ICpkZXYsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQogCQkJLmFpZCA9
IGNwdV90b19sZTE2KHN0YS0+YWlkKSwNCiAJCX0sDQogCX07DQorCXN0cnVjdCBzdGFfcmVjX3d0
YmwgKnd0YmwgPSBOVUxMOw0KIAlzdHJ1Y3Qgd3RibF9yZXFfaGRyICp3dGJsX2hkcjsNCiAJc3Ry
dWN0IHd0YmxfZ2VuZXJpYyAqd3RibF9nOw0KIAlzdHJ1Y3Qgd3RibF9yeCAqd3RibF9yeDsNCkBA
IC0xMTcwLDYgKzExODIsMTMgQEAgaW50IG10NzYxNV9tY3Vfc2V0X3N0YShzdHJ1Y3QgbXQ3NjE1
X2RldiAqZGV2LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KIAl9DQogDQogCS8qIHd0Ymwg
Ki8NCisJaWYgKGRldi0+ZndfdmVyID4gTVQ3NjE1X0ZJUk1XQVJFX1YxKSB7DQorCQl3dGJsID0g
KHN0cnVjdCBzdGFfcmVjX3d0YmwgKilidWY7DQorCQl3dGJsLT50YWcgPSBjcHVfdG9fbGUxNihT
VEFfUkVDX1dUQkwpOw0KKwkJYnVmICs9IHNpemVvZigqd3RibCk7DQorCQlzdGx2Kys7DQorCX0N
CisNCiAJd3RibF9oZHIgPSAoc3RydWN0IHd0YmxfcmVxX2hkciAqKWJ1ZjsNCiAJYnVmICs9IHNp
emVvZigqd3RibF9oZHIpOw0KIAl3dGJsX2hkci0+d2xhbl9pZHggPSBtc3RhLT53Y2lkLmlkeDsN
CkBAIC0xMjY1LDYgKzEyODQsOSBAQCBpbnQgbXQ3NjE1X21jdV9zZXRfc3RhKHN0cnVjdCBtdDc2
MTVfZGV2ICpkZXYsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYsDQogCX0NCiANCiBvdXQ6DQor
CWlmICh3dGJsKQ0KKwkJd3RibC0+bGVuID0gY3B1X3RvX2xlMTYoYnVmIC0gKHU4ICopd3RibF9o
ZHIpOw0KKw0KIAl3dGJsX2hkci0+dGx2X251bSA9IGNwdV90b19sZTE2KHd0bHYpOw0KIAlyZXEu
aGRyLnRsdl9udW0gPSBjcHVfdG9fbGUxNihzdGx2KTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuaCBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5oDQppbmRleCA4ZDA1N2M3MjM2NmEuLmQ5
NzhiOTRhYWNjMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3NjE1L21jdS5oDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzYxNS9tY3UuaA0KQEAgLTUwNiw5ICs1MDYsMTAgQEAgc3RydWN0IHN0YV9yZWNfYmEgew0K
IAlfX2xlMTYgd2luc2l6ZTsNCiB9IF9fcGFja2VkOw0KIA0KLSNkZWZpbmUgTVQ3NjE1X1NUQV9S
RUNfVVBEQVRFX01BWF9TSVpFIChzaXplb2Yoc3RydWN0IHN0YV9yZWNfYmFzaWMpICsgXA0KLQkJ
CQkJc2l6ZW9mKHN0cnVjdCBzdGFfcmVjX2h0KSArIFwNCi0JCQkJCXNpemVvZihzdHJ1Y3Qgc3Rh
X3JlY192aHQpKQ0KK3N0cnVjdCBzdGFfcmVjX3d0Ymwgew0KKwlfX2xlMTYgdGFnOw0KKwlfX2xl
MTYgbGVuOw0KK30gX19wYWNrZWQ7DQogDQogZW51bSB7DQogCVNUQV9SRUNfQkFTSUMsDQpAQCAt
NTIzLDYgKzUyNCw4IEBAIGVudW0gew0KIAlTVEFfUkVDX0hULA0KIAlTVEFfUkVDX1ZIVCwNCiAJ
U1RBX1JFQ19BUFBTLA0KKwlTVEFfUkVDX0tFWSwNCisJU1RBX1JFQ19XVEJMLA0KIAlTVEFfUkVD
X01BWF9OVU0NCiB9Ow0KIA0KLS0gDQoyLjE4LjANCg==

