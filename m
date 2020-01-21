Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE1143F14
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2020 15:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgAUON6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jan 2020 09:13:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:52943 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729335AbgAUON6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jan 2020 09:13:58 -0500
X-UUID: d4abc07388884fab83039075f17a8750-20200121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gd37oZ0axLyEI/QyrcT0vJ08dR3b4hQAx7SsmCJF/Ng=;
        b=MeomrP5DvXeI0xrFL/IBv6/hSXdrnt7ol7H0sbLxveZWKPEZNcUetdU521H0icf4VcWK+haEaV6iy2N10UapsfEb+u1/zVAAvlZj+KK5biJ+H2cL0aWV3HjdJrFc89JT+UZU3wGc6uKC0rvRd9VT8EOGMJFk8vc3PxvE1alhkno=;
X-UUID: d4abc07388884fab83039075f17a8750-20200121
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 280709605; Tue, 21 Jan 2020 22:13:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 Jan 2020 22:14:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 Jan 2020 22:13:32 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 7/7] mt76: mt7615: switch mt7615_mcu_set_rx_ba to new MCU format
Date:   Tue, 21 Jan 2020 22:13:42 +0800
Message-ID: <157c7f251ab1b436c18815cca3423360e0eec07c.1579237414.git.ryder.lee@mediatek.com>
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

VG8gYWRhcHQgbmV3IGZpcm13YXJlIHZlcnNpb24uDQoNClNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExl
ZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NClRlc3RlZC1ieTogU2hheW5lIENoZW4gPHNoYXlu
ZS5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2MTUvbWN1LmMgICB8IDYyICsrKysrKysrKystLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgMzQgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jDQppbmRleCA3M2U0NDA2ZGJmNWEu
LmQzYmI5Njc1Njg4OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3NjE1L21jdS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9t
dDc2L210NzYxNS9tY3UuYw0KQEAgLTE2NDAsMjkgKzE2NDAsMTEgQEAgaW50IG10NzYxNV9tY3Vf
c2V0X3J4X2JhKHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYsDQogew0KIAlzdHJ1Y3QgbXQ3NjE1X3N0
YSAqbXN0YSA9IChzdHJ1Y3QgbXQ3NjE1X3N0YSAqKXBhcmFtcy0+c3RhLT5kcnZfcHJpdjsNCiAJ
c3RydWN0IG10NzYxNV92aWYgKm12aWYgPSBtc3RhLT52aWY7DQotCXN0cnVjdCB7DQotCQlzdHJ1
Y3Qgd3RibF9yZXFfaGRyIGhkcjsNCi0JCXN0cnVjdCB3dGJsX2JhIGJhOw0KLQl9IHd0YmxfcmVx
ID0gew0KLQkJLmhkciA9IHsNCi0JCQkud2xhbl9pZHggPSBtc3RhLT53Y2lkLmlkeCwNCi0JCQku
b3BlcmF0aW9uID0gV1RCTF9TRVQsDQotCQkJLnRsdl9udW0gPSBjcHVfdG9fbGUxNigxKSwNCi0J
CX0sDQotCQkuYmEgPSB7DQotCQkJLnRhZyA9IGNwdV90b19sZTE2KFdUQkxfQkEpLA0KLQkJCS5s
ZW4gPSBjcHVfdG9fbGUxNihzaXplb2Yoc3RydWN0IHd0YmxfYmEpKSwNCi0JCQkudGlkID0gcGFy
YW1zLT50aWQsDQotCQkJLmJhX3R5cGUgPSBNVF9CQV9UWVBFX1JFQ0lQSUVOVCwNCi0JCQkucnN0
X2JhX3RpZCA9IHBhcmFtcy0+dGlkLA0KLQkJCS5yc3RfYmFfc2VsID0gUlNUX0JBX01BQ19USURf
TUFUQ0gsDQotCQkJLnJzdF9iYV9zYiA9IDEsDQotCQl9LA0KLQl9Ow0KIAlzdHJ1Y3Qgew0KIAkJ
c3RydWN0IHN0YV9yZXFfaGRyIGhkcjsNCiAJCXN0cnVjdCBzdGFfcmVjX2JhIGJhOw0KLQl9IHN0
YV9yZXEgPSB7DQorCQl1OCBidWZbTVQ3NjE1X1dUQkxfVVBEQVRFX01BWF9TSVpFXTsNCisJfSBf
X3BhY2tlZCByZXEgPSB7DQogCQkuaGRyID0gew0KIAkJCS5ic3NfaWR4ID0gbXZpZi0+aWR4LA0K
IAkJCS53bGFuX2lkeCA9IG1zdGEtPndjaWQuaWR4LA0KQEAgLTE2ODEsMTcgKzE2NjMsNDEgQEAg
aW50IG10NzYxNV9tY3Vfc2V0X3J4X2JhKHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYsDQogCQkJLndp
bnNpemUgPSBjcHVfdG9fbGUxNihwYXJhbXMtPmJ1Zl9zaXplKSwNCiAJCX0sDQogCX07DQotCWlu
dCByZXQ7DQorCXN0cnVjdCBzdGFfcmVjX3d0YmwgKnd0YmwgPSBOVUxMOw0KKwlzdHJ1Y3Qgd3Ri
bF9yZXFfaGRyICp3dGJsX2hkcjsNCisJc3RydWN0IHd0YmxfYmEgKnd0YmxfYmE7DQorCXU4ICpi
dWYgPSByZXEuYnVmOw0KIA0KLQltZW1jcHkod3RibF9yZXEuYmEucGVlcl9hZGRyLCBwYXJhbXMt
PnN0YS0+YWRkciwgRVRIX0FMRU4pOw0KKwlpZiAoZGV2LT5md192ZXIgPiBNVDc2MTVfRklSTVdB
UkVfVjEpIHsNCisJCXJlcS5oZHIudGx2X251bSA9IGNwdV90b19sZTE2KDIpOw0KKwkJd3RibCA9
IChzdHJ1Y3Qgc3RhX3JlY193dGJsICopYnVmOw0KKwkJd3RibC0+dGFnID0gY3B1X3RvX2xlMTYo
U1RBX1JFQ19XVEJMKTsNCisJCWJ1ZiArPSBzaXplb2YoKnd0YmwpOw0KKwl9DQogDQotCXJldCA9
IF9fbXQ3Nl9tY3Vfc2VuZF9tc2coJmRldi0+bXQ3NiwgTUNVX0VYVF9DTURfU1RBX1JFQ19VUERB
VEUsDQotCQkJCSAgJnN0YV9yZXEsIHNpemVvZihzdGFfcmVxKSwgdHJ1ZSk7DQotCWlmIChyZXQg
fHwgIWFkZCkNCi0JCXJldHVybiByZXQ7DQorCXd0YmxfaGRyID0gKHN0cnVjdCB3dGJsX3JlcV9o
ZHIgKilidWY7DQorCWJ1ZiArPSBzaXplb2YoKnd0YmxfaGRyKTsNCisJd3RibF9oZHItPndsYW5f
aWR4ID0gbXN0YS0+d2NpZC5pZHg7DQorCXd0YmxfaGRyLT5vcGVyYXRpb24gPSBXVEJMX1NFVDsN
CisJd3RibF9oZHItPnRsdl9udW0gPSBjcHVfdG9fbGUxNigxKTsNCiANCi0JcmV0dXJuIF9fbXQ3
Nl9tY3Vfc2VuZF9tc2coJmRldi0+bXQ3NiwgTUNVX0VYVF9DTURfV1RCTF9VUERBVEUsDQotCQkJ
CSAgICZ3dGJsX3JlcSwgc2l6ZW9mKHd0YmxfcmVxKSwgdHJ1ZSk7DQorCXd0YmxfYmEgPSAoc3Ry
dWN0IHd0YmxfYmEgKilidWY7DQorCWJ1ZiArPSBzaXplb2YoKnd0YmxfYmEpOw0KKwl3dGJsX2Jh
LT50YWcgPSBjcHVfdG9fbGUxNihXVEJMX0JBKTsNCisJd3RibF9iYS0+bGVuID0gY3B1X3RvX2xl
MTYoc2l6ZW9mKCp3dGJsX2JhKSk7DQorCXd0YmxfYmEtPnRpZCA9IHBhcmFtcy0+dGlkOw0KKwl3
dGJsX2JhLT5iYV90eXBlID0gTVRfQkFfVFlQRV9SRUNJUElFTlQ7DQorCXd0YmxfYmEtPnJzdF9i
YV90aWQgPSBwYXJhbXMtPnRpZDsNCisJd3RibF9iYS0+cnN0X2JhX3NlbCA9IFJTVF9CQV9NQUNf
VElEX01BVENIOw0KKwl3dGJsX2JhLT5yc3RfYmFfc2IgPSAxOw0KKw0KKwltZW1jcHkod3RibF9i
YS0+cGVlcl9hZGRyLCBwYXJhbXMtPnN0YS0+YWRkciwgRVRIX0FMRU4pOw0KKw0KKwlpZiAod3Ri
bCkNCisJCXd0YmwtPmxlbiA9IGNwdV90b19sZTE2KGJ1ZiAtICh1OCAqKXd0YmxfaGRyKTsNCisN
CisJcmV0dXJuIG10NzYxNV9tY3Vfc2VuZF9zdGFfcmVjKGRldiwgKHU4ICopJnJlcSwgKHU4ICop
d3RibF9oZHIsDQorCQkJCSAgICAgICBidWYgLSAodTggKil3dGJsX2hkciwgYWRkKTsNCiB9DQog
DQogaW50IG10NzYxNV9tY3VfZ2V0X3RlbXBlcmF0dXJlKHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYs
IGludCBpbmRleCkNCi0tIA0KMi4xOC4wDQo=

