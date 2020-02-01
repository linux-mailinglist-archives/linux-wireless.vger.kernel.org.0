Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0FE14F893
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Feb 2020 16:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgBAPeI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Feb 2020 10:34:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51861 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727014AbgBAPeI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Feb 2020 10:34:08 -0500
X-UUID: 4c6c4c040a154b28a6c4a7c028e620cd-20200201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=x0RcsqRquhcXQty96nPHhZqu/2xMH1iLFFxG59uudt4=;
        b=bx3kHoia+tNZhtk6b0JAPZUNNKgaWpapd8mrDAdkdHcKF0yJvjNQQ+1Lhj4rmPYum2Apu+NHEc3FRaHUBdTrVNP9iSb32rmZBQJLerIubRKwSWRWHfpBJCfVvoB9Ltzh2Oc83rTI2yUPSPcZpz0ECsyurgGKS5IjXKp8k55pOMo=;
X-UUID: 4c6c4c040a154b28a6c4a7c028e620cd-20200201
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 798518575; Sat, 01 Feb 2020 23:34:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 1 Feb 2020 23:34:13 +0800
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
Subject: [PATCH v2 6/7] mt76: mt7615: switch mt7615_mcu_set_tx_ba to v2 format
Date:   Sat, 1 Feb 2020 23:33:51 +0800
Message-ID: <d2ec8d96e98d289af203e38c5c0d62634065b15a.1580565624.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1580565624.git.ryder.lee@mediatek.com>
References: <cover.1580565624.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VG8gYWRhcHQgbmV3IGZpcm13YXJlIHZlcnNpb24uDQoNClNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExl
ZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NClRlc3RlZC1ieTogU2hheW5lIENoZW4gPHNoYXlu
ZS5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2MTUvbWN1LmMgICB8IDYwICsrKysrKysrKystLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgMzMgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jDQppbmRleCA1OGVhYzhmZTU1MTEu
LmE3YzQ1MzhlNTZmYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3NjE1L21jdS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzYxNS9tY3UuYw0KQEAgLTE1NzIsMjggKzE1NzIsMTEgQEAgaW50IG10NzYxNV9tY3Vf
c2V0X3R4X2JhKHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYsDQogew0KIAlzdHJ1Y3QgbXQ3NjE1X3N0
YSAqbXN0YSA9IChzdHJ1Y3QgbXQ3NjE1X3N0YSAqKXBhcmFtcy0+c3RhLT5kcnZfcHJpdjsNCiAJ
c3RydWN0IG10NzYxNV92aWYgKm12aWYgPSBtc3RhLT52aWY7DQotCXN0cnVjdCB7DQotCQlzdHJ1
Y3Qgd3RibF9yZXFfaGRyIGhkcjsNCi0JCXN0cnVjdCB3dGJsX2JhIGJhOw0KLQl9IHd0YmxfcmVx
ID0gew0KLQkJLmhkciA9IHsNCi0JCQkud2xhbl9pZHggPSBtc3RhLT53Y2lkLmlkeCwNCi0JCQku
b3BlcmF0aW9uID0gV1RCTF9TRVQsDQotCQkJLnRsdl9udW0gPSBjcHVfdG9fbGUxNigxKSwNCi0J
CX0sDQotCQkuYmEgPSB7DQotCQkJLnRhZyA9IGNwdV90b19sZTE2KFdUQkxfQkEpLA0KLQkJCS5s
ZW4gPSBjcHVfdG9fbGUxNihzaXplb2Yoc3RydWN0IHd0YmxfYmEpKSwNCi0JCQkudGlkID0gcGFy
YW1zLT50aWQsDQotCQkJLmJhX3R5cGUgPSBNVF9CQV9UWVBFX09SSUdJTkFUT1IsDQotCQkJLnNu
ID0gYWRkID8gY3B1X3RvX2xlMTYocGFyYW1zLT5zc24pIDogMCwNCi0JCQkuYmFfZW4gPSBhZGQs
DQotCQl9LA0KLQl9Ow0KIAlzdHJ1Y3Qgew0KIAkJc3RydWN0IHN0YV9yZXFfaGRyIGhkcjsNCiAJ
CXN0cnVjdCBzdGFfcmVjX2JhIGJhOw0KLQl9IHN0YV9yZXEgPSB7DQorCQl1OCBidWZbTVQ3NjE1
X1dUQkxfVVBEQVRFX01BWF9TSVpFXTsNCisJfSBfX3BhY2tlZCByZXEgPSB7DQogCQkuaGRyID0g
ew0KIAkJCS5ic3NfaWR4ID0gbXZpZi0+aWR4LA0KIAkJCS53bGFuX2lkeCA9IG1zdGEtPndjaWQu
aWR4LA0KQEAgLTE2MTIsNyArMTU5NSwzMiBAQCBpbnQgbXQ3NjE1X21jdV9zZXRfdHhfYmEoc3Ry
dWN0IG10NzYxNV9kZXYgKmRldiwNCiAJCQkud2luc2l6ZSA9IGNwdV90b19sZTE2KHBhcmFtcy0+
YnVmX3NpemUpLA0KIAkJfSwNCiAJfTsNCi0JaW50IHJldDsNCisJc3RydWN0IHN0YV9yZWNfd3Ri
bCAqd3RibCA9IE5VTEw7DQorCXN0cnVjdCB3dGJsX3JlcV9oZHIgKnd0YmxfaGRyOw0KKwlzdHJ1
Y3Qgd3RibF9iYSAqd3RibF9iYTsNCisJdTggKmJ1ZiA9IHJlcS5idWY7DQorDQorCWlmIChkZXYt
PmZ3X3ZlciA+IE1UNzYxNV9GSVJNV0FSRV9WMSkgew0KKwkJcmVxLmhkci50bHZfbnVtID0gY3B1
X3RvX2xlMTYoMik7DQorCQl3dGJsID0gKHN0cnVjdCBzdGFfcmVjX3d0YmwgKilidWY7DQorCQl3
dGJsLT50YWcgPSBjcHVfdG9fbGUxNihTVEFfUkVDX1dUQkwpOw0KKwkJYnVmICs9IHNpemVvZigq
d3RibCk7DQorCX0NCisNCisJd3RibF9oZHIgPSAoc3RydWN0IHd0YmxfcmVxX2hkciAqKWJ1ZjsN
CisJYnVmICs9IHNpemVvZigqd3RibF9oZHIpOw0KKwl3dGJsX2hkci0+d2xhbl9pZHggPSBtc3Rh
LT53Y2lkLmlkeDsNCisJd3RibF9oZHItPm9wZXJhdGlvbiA9IFdUQkxfU0VUOw0KKwl3dGJsX2hk
ci0+dGx2X251bSA9IGNwdV90b19sZTE2KDEpOw0KKw0KKwl3dGJsX2JhID0gKHN0cnVjdCB3dGJs
X2JhICopYnVmOw0KKwlidWYgKz0gc2l6ZW9mKCp3dGJsX2JhKTsNCisJd3RibF9iYS0+dGFnID0g
Y3B1X3RvX2xlMTYoV1RCTF9CQSk7DQorCXd0YmxfYmEtPmxlbiA9IGNwdV90b19sZTE2KHNpemVv
Zigqd3RibF9iYSkpOw0KKwl3dGJsX2JhLT50aWQgPSBwYXJhbXMtPnRpZDsNCisJd3RibF9iYS0+
YmFfdHlwZSA9IE1UX0JBX1RZUEVfT1JJR0lOQVRPUjsNCisJd3RibF9iYS0+c24gPSBhZGQgPyBj
cHVfdG9fbGUxNihwYXJhbXMtPnNzbikgOiAwOw0KKwl3dGJsX2JhLT5iYV9lbiA9IGFkZDsNCiAN
CiAJaWYgKGFkZCkgew0KIAkJdTggaWR4LCBiYV9yYW5nZVtdID0geyA0LCA4LCAxMiwgMjQsIDM2
LCA0OCwgNTQsIDY0IH07DQpAQCAtMTYyMiwxNiArMTYzMCwxNCBAQCBpbnQgbXQ3NjE1X21jdV9z
ZXRfdHhfYmEoc3RydWN0IG10NzYxNV9kZXYgKmRldiwNCiAJCQkJYnJlYWs7DQogCQl9DQogDQot
CQl3dGJsX3JlcS5iYS5iYV93aW5zaXplX2lkeCA9IGlkeDsNCisJCXd0YmxfYmEtPmJhX3dpbnNp
emVfaWR4ID0gaWR4Ow0KIAl9DQogDQotCXJldCA9IF9fbXQ3Nl9tY3Vfc2VuZF9tc2coJmRldi0+
bXQ3NiwgTUNVX0VYVF9DTURfV1RCTF9VUERBVEUsDQotCQkJCSAgJnd0YmxfcmVxLCBzaXplb2Yo
d3RibF9yZXEpLCB0cnVlKTsNCi0JaWYgKHJldCkNCi0JCXJldHVybiByZXQ7DQorCWlmICh3dGJs
KQ0KKwkJd3RibC0+bGVuID0gY3B1X3RvX2xlMTYoYnVmIC0gKHU4ICopd3RibF9oZHIpOw0KIA0K
LQlyZXR1cm4gX19tdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LCBNQ1VfRVhUX0NNRF9TVEFf
UkVDX1VQREFURSwNCi0JCQkJICAgJnN0YV9yZXEsIHNpemVvZihzdGFfcmVxKSwgdHJ1ZSk7DQor
CXJldHVybiBtdDc2MTVfbWN1X3NlbmRfc3RhX3JlYyhkZXYsICh1OCAqKSZyZXEsICh1OCAqKXd0
YmxfaGRyLA0KKwkJCQkgICAgICAgYnVmIC0gKHU4ICopd3RibF9oZHIsIHRydWUpOw0KIH0NCiAN
CiBpbnQgbXQ3NjE1X21jdV9zZXRfcnhfYmEoc3RydWN0IG10NzYxNV9kZXYgKmRldiwNCi0tIA0K
Mi4xOC4wDQo=

