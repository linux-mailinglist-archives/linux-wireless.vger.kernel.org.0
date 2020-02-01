Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D114F891
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Feb 2020 16:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBAPeH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Feb 2020 10:34:07 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47557 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727066AbgBAPeG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Feb 2020 10:34:06 -0500
X-UUID: 680e532a0c7f4bf7bab58263dbc06821-20200201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aQbmh620igvV3NDTNU693dnCanRuvWrzmm24DXTcmvA=;
        b=OAYFjyq3ZushwW5Gp/e18wYW1zfPONI6q2WC+dO0vP0/BAS5jVsna0FWU5ig5uaPffOm55vfCRYSvwTuZr1AfPHCqil/vMjAOQjYYj1ZawTFpKJX12CqfTxBb5myhe/RvGnA440lRwurfuNGWV5WQ+oXOo+9PNrtSZedKLiZwRs=;
X-UUID: 680e532a0c7f4bf7bab58263dbc06821-20200201
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1424730728; Sat, 01 Feb 2020 23:34:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 1 Feb 2020 23:33:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 1 Feb 2020 23:31:35 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Josh Boyer <jwboyer@kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 5/7] mt76: mt7615: use new tag sta_rec_wtbl
Date:   Sat, 1 Feb 2020 23:33:50 +0800
Message-ID: <dd9cb430c3c3a6baa843663bc1478dc72dd7f188.1580565624.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1580565624.git.ryder.lee@mediatek.com>
References: <cover.1580565624.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0E33A85B1B71A70A95D4BAA585959583BBE5B8EE23FA693F907B92669DA033332000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SW4gb3JkZXIgdG8gcmVkdWNlIGNvbW1hbmQvZXZlbnQgdGltZXMsIG5ld2VyIGZpcm13YXJlIGFk
ZHMgYSB0YWcNCnN0YV9yZWNfd3RibCB0byB0YWtlIGNhcmUgb2YgV1RCTCBvcGVyYXRpb25zLg0K
DQpNQ1VfRVhUX0NNRF9XVEJMX1VQREFURSBpcyBkZXByZWNhdGVkLg0KDQpTaWduZWQtb2ZmLWJ5
OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTaGF5
bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsuY29tPg0KVGVzdGVkLWJ5OiBTZWFuIFdhbmcg
PHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3NjE1L21jdS5jICAgfCAyMiArKysrKysrKysrKysrKysrKysrDQogLi4uL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuaCAgIHwgIDggKysrKy0tLQ0KIDIgZmls
ZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCmluZGV4IGNlNzBl
MmMwMzk1Ni4uNThlYWM4ZmU1NTExIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jDQpAQCAtMTA0NSw2ICsxMDQ1LDcgQEAgaW50IG10NzYx
NV9tY3Vfc2V0X2JtYyhzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2LA0KIAkJCS5jb25uX3R5cGUgPSBj
cHVfdG9fbGUzMihDT05ORUNUSU9OX0lORlJBX0JDKSwNCiAJCX0sDQogCX07DQorCXN0cnVjdCBz
dGFfcmVjX3d0YmwgKnd0YmwgPSBOVUxMOw0KIAlzdHJ1Y3Qgd3RibF9yZXFfaGRyICp3dGJsX2hk
cjsNCiAJc3RydWN0IHd0YmxfZ2VuZXJpYyAqd3RibF9nOw0KIAlzdHJ1Y3Qgd3RibF9yeCAqd3Ri
bF9yeDsNCkBAIC0xMDUyLDYgKzEwNTMsMTMgQEAgaW50IG10NzYxNV9tY3Vfc2V0X2JtYyhzdHJ1
Y3QgbXQ3NjE1X2RldiAqZGV2LA0KIA0KIAlldGhfYnJvYWRjYXN0X2FkZHIocmVxLmJhc2ljLnBl
ZXJfYWRkcik7DQogDQorCWlmIChkZXYtPmZ3X3ZlciA+IE1UNzYxNV9GSVJNV0FSRV9WMSkgew0K
KwkJcmVxLmhkci50bHZfbnVtID0gY3B1X3RvX2xlMTYoMik7DQorCQl3dGJsID0gKHN0cnVjdCBz
dGFfcmVjX3d0YmwgKilidWY7DQorCQl3dGJsLT50YWcgPSBjcHVfdG9fbGUxNihTVEFfUkVDX1dU
QkwpOw0KKwkJYnVmICs9IHNpemVvZigqd3RibCk7DQorCX0NCisNCiAJd3RibF9oZHIgPSAoc3Ry
dWN0IHd0YmxfcmVxX2hkciAqKWJ1ZjsNCiAJYnVmICs9IHNpemVvZigqd3RibF9oZHIpOw0KIAl3
dGJsX2hkci0+d2xhbl9pZHggPSBtdmlmLT5zdGEud2NpZC5pZHg7DQpAQCAtMTA4NSw2ICsxMDkz
LDkgQEAgaW50IG10NzYxNV9tY3Vfc2V0X2JtYyhzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2LA0KIAl3
dGJsX2hkci0+dGx2X251bSA9IGNwdV90b19sZTE2KDIpOw0KIA0KIG91dDoNCisJaWYgKHd0Ymwp
DQorCQl3dGJsLT5sZW4gPSBjcHVfdG9fbGUxNihidWYgLSAodTggKil3dGJsX2hkcik7DQorDQog
CXJldHVybiBtdDc2MTVfbWN1X3NlbmRfc3RhX3JlYyhkZXYsICh1OCAqKSZyZXEsICh1OCAqKXd0
YmxfaGRyLA0KIAkJCQkgICAgICAgYnVmIC0gKHU4ICopd3RibF9oZHIsIGVuKTsNCiB9DQpAQCAt
MTExMyw2ICsxMTI0LDcgQEAgaW50IG10NzYxNV9tY3Vfc2V0X3N0YShzdHJ1Y3QgbXQ3NjE1X2Rl
diAqZGV2LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KIAkJCS5haWQgPSBjcHVfdG9fbGUx
NihzdGEtPmFpZCksDQogCQl9LA0KIAl9Ow0KKwlzdHJ1Y3Qgc3RhX3JlY193dGJsICp3dGJsID0g
TlVMTDsNCiAJc3RydWN0IHd0YmxfcmVxX2hkciAqd3RibF9oZHI7DQogCXN0cnVjdCB3dGJsX2dl
bmVyaWMgKnd0YmxfZzsNCiAJc3RydWN0IHd0YmxfcnggKnd0Ymxfcng7DQpAQCAtMTE3Niw2ICsx
MTg4LDEzIEBAIGludCBtdDc2MTVfbWN1X3NldF9zdGEoc3RydWN0IG10NzYxNV9kZXYgKmRldiwg
c3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCiAJfQ0KIA0KIAkvKiB3dGJsICovDQorCWlmIChk
ZXYtPmZ3X3ZlciA+IE1UNzYxNV9GSVJNV0FSRV9WMSkgew0KKwkJd3RibCA9IChzdHJ1Y3Qgc3Rh
X3JlY193dGJsICopYnVmOw0KKwkJd3RibC0+dGFnID0gY3B1X3RvX2xlMTYoU1RBX1JFQ19XVEJM
KTsNCisJCWJ1ZiArPSBzaXplb2YoKnd0YmwpOw0KKwkJc3RsdisrOw0KKwl9DQorDQogCXd0Ymxf
aGRyID0gKHN0cnVjdCB3dGJsX3JlcV9oZHIgKilidWY7DQogCWJ1ZiArPSBzaXplb2YoKnd0Ymxf
aGRyKTsNCiAJd3RibF9oZHItPndsYW5faWR4ID0gbXN0YS0+d2NpZC5pZHg7DQpAQCAtMTI3MSw2
ICsxMjkwLDkgQEAgaW50IG10NzYxNV9tY3Vfc2V0X3N0YShzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2
LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KIAl9DQogDQogb3V0Og0KKwlpZiAod3RibCkN
CisJCXd0YmwtPmxlbiA9IGNwdV90b19sZTE2KGJ1ZiAtICh1OCAqKXd0YmxfaGRyKTsNCisNCiAJ
d3RibF9oZHItPnRsdl9udW0gPSBjcHVfdG9fbGUxNih3dGx2KTsNCiAJcmVxLmhkci50bHZfbnVt
ID0gY3B1X3RvX2xlMTYoc3Rsdik7DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzYxNS9tY3UuaA0KaW5kZXggOGQwNTdjNzIzNjZhLi4wYWY1ZTUxOWY3MTIg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9t
Y3UuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1
LmgNCkBAIC01MDYsOSArNTA2LDEwIEBAIHN0cnVjdCBzdGFfcmVjX2JhIHsNCiAJX19sZTE2IHdp
bnNpemU7DQogfSBfX3BhY2tlZDsNCiANCi0jZGVmaW5lIE1UNzYxNV9TVEFfUkVDX1VQREFURV9N
QVhfU0laRSAoc2l6ZW9mKHN0cnVjdCBzdGFfcmVjX2Jhc2ljKSArIFwNCi0JCQkJCXNpemVvZihz
dHJ1Y3Qgc3RhX3JlY19odCkgKyBcDQotCQkJCQlzaXplb2Yoc3RydWN0IHN0YV9yZWNfdmh0KSkN
CitzdHJ1Y3Qgc3RhX3JlY193dGJsIHsNCisJX19sZTE2IHRhZzsNCisJX19sZTE2IGxlbjsNCit9
IF9fcGFja2VkOw0KIA0KIGVudW0gew0KIAlTVEFfUkVDX0JBU0lDLA0KQEAgLTUyMyw2ICs1MjQs
NyBAQCBlbnVtIHsNCiAJU1RBX1JFQ19IVCwNCiAJU1RBX1JFQ19WSFQsDQogCVNUQV9SRUNfQVBQ
UywNCisJU1RBX1JFQ19XVEJMID0gMTMsDQogCVNUQV9SRUNfTUFYX05VTQ0KIH07DQogDQotLSAN
CjIuMTguMA0K

