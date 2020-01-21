Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C1C143F13
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2020 15:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgAUON5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jan 2020 09:13:57 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:52943 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729300AbgAUON4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jan 2020 09:13:56 -0500
X-UUID: cc872b21e6974122a7c1faed90e62134-20200121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=v+wcGDsO7LzhLYd0t7yY8jTM7GyhTanF/p5aGuMf2uY=;
        b=M7dOuynClHVnt635uLeS5o8Mfj1VwIESUyTXExnKPoaZoIA+EwCPnTJza3URKsFqOoRWwddCXI0vL60920Aiw7VCqGXRLU2HCX9yPagb5WgF29S4MVuA9iwpu1AF+QkvRdHTBJic1w6uvpuiwoH7i6qqcEWHxwq/4zb2+rJSoqM=;
X-UUID: cc872b21e6974122a7c1faed90e62134-20200121
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 386455802; Tue, 21 Jan 2020 22:13:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 Jan 2020 22:12:18 +0800
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
Subject: [PATCH 4/7] mt76: mt7615: adjust command flow for firmware v2
Date:   Tue, 21 Jan 2020 22:13:39 +0800
Message-ID: <48e1baba8a4d87dc6c081189034f78447d65bf14.1579237414.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <ae72dd289f8a26a2c0f42de1f940bb8b6d1f2c29.1579237414.git.ryder.lee@mediatek.com>
References: <ae72dd289f8a26a2c0f42de1f940bb8b6d1f2c29.1579237414.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2B03C0DA28A1CC07F7DDAEF4D85FBDFC6E7BE8B28A39E7767ABA05FED6B601882000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIGZ3X3ZlcnNpb24gaW4gbXQ3NjE1X2RldiB0byBhZGFwdCBuZXcgZmlybXdhcmUgdmVyc2lv
bi4NCg0KU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0K
U2lnbmVkLW9mZi1ieTogU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4NClRl
c3RlZC1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMgIHwgMTYgKysrKysrKysr
KysrLS0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbXQ3NjE1Lmgg
ICB8ICA1ICsrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYx
NS9tY3UuYw0KaW5kZXggNmJlZjBkY2I4M2I3Li5jMDU1OTQ5YjI4OWMgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0KKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCkBAIC00OTEsNiAr
NDkxLDExIEBAIHN0YXRpYyBpbnQgbXQ3NjE1X2xvYWRfcmFtKHN0cnVjdCBtdDc2MTVfZGV2ICpk
ZXYpDQogCQlnb3RvIG91dDsNCiAJfQ0KIA0KKwlpZiAoIXN0cm5jbXAoaGRyLT5md192ZXIsICJt
dGtfdjIiLCA2KSkNCisJCWRldi0+ZndfdmVyID0gTVQ3NjE1X0ZJUk1XQVJFX1YyOw0KKwllbHNl
DQorCQlkZXYtPmZ3X3ZlciA9IE1UNzYxNV9GSVJNV0FSRV9WMTsNCisNCiAJcmVsZWFzZV9maXJt
d2FyZShmdyk7DQogDQogCXJldCA9IHJlcXVlc3RfZmlybXdhcmUoJmZ3LCBNVDc2MTVfRklSTVdB
UkVfQ1I0LCBkZXYtPm10NzYuZGV2KTsNCkBAIC05OTIsMTggKzk5NywyMSBAQCBzdGF0aWMgaW50
DQogbXQ3NjE1X21jdV9zZW5kX3N0YV9yZWMoc3RydWN0IG10NzYxNV9kZXYgKmRldiwgdTggKnJl
cSwgdTggKndyZXEsDQogCQkJdTggd2xlbiwgYm9vbCBlbmFibGUpDQogew0KLQl1MzIgc2xlbiA9
IHdyZXEgLSByZXE7DQorCWJvb2wgaXNfdjEgPSAoZGV2LT5md192ZXIgPT0gTVQ3NjE1X0ZJUk1X
QVJFX1YxKSA/IHRydWUgOiBmYWxzZTsNCisJdTMyIHNsZW4gPSBpc192MSA/IHdyZXEgLSByZXEg
OiB3cmVxIC0gcmVxICsgd2xlbjsNCiANCi0JaWYgKCFlbmFibGUpIHsNCisJaWYgKGlzX3YxICYm
ICFlbmFibGUpIHsNCiAJCV9fbXQ3Nl9tY3Vfc2VuZF9tc2coJmRldi0+bXQ3NiwgTUNVX0VYVF9D
TURfU1RBX1JFQ19VUERBVEUsDQogCQkJCSAgICByZXEsIHNsZW4sIHRydWUpOw0KIA0KIAkJcmV0
dXJuIF9fbXQ3Nl9tY3Vfc2VuZF9tc2coJmRldi0+bXQ3NiwgTUNVX0VYVF9DTURfV1RCTF9VUERB
VEUsDQogCQkJCQkgICB3cmVxLCB3bGVuLCB0cnVlKTsNCisNCiAJfQ0KIA0KLQlfX210NzZfbWN1
X3NlbmRfbXNnKCZkZXYtPm10NzYsIE1DVV9FWFRfQ01EX1dUQkxfVVBEQVRFLCB3cmVxLA0KLQkJ
CSAgICB3bGVuLCB0cnVlKTsNCisJaWYgKGlzX3YxKQ0KKwkJX19tdDc2X21jdV9zZW5kX21zZygm
ZGV2LT5tdDc2LCBNQ1VfRVhUX0NNRF9XVEJMX1VQREFURSwNCisJCQkJICAgIHdyZXEsIHdsZW4s
IHRydWUpOw0KIA0KIAlyZXR1cm4gX19tdDc2X21jdV9zZW5kX21zZygmZGV2LT5tdDc2LCBNQ1Vf
RVhUX0NNRF9TVEFfUkVDX1VQREFURSwNCiAJCQkJICAgcmVxLCBzbGVuLCB0cnVlKTsNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tdDc2MTUu
aCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L210NzYxNS5oDQpp
bmRleCA5YmQ5MjZkNjk2M2YuLmZhMzk2MzJjZDJiZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L210NzYxNS5oDQorKysgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tdDc2MTUuaA0KQEAgLTMwLDYgKzMwLDkg
QEANCiAjZGVmaW5lIE1UNzYxNV9GSVJNV0FSRV9OOQkJIm1lZGlhdGVrL210NzYxNV9uOS5iaW4i
DQogI2RlZmluZSBNVDc2MTVfUk9NX1BBVENICQkibWVkaWF0ZWsvbXQ3NjE1X3JvbV9wYXRjaC5i
aW4iDQogDQorI2RlZmluZSBNVDc2MTVfRklSTVdBUkVfVjEJCTENCisjZGVmaW5lIE1UNzYxNV9G
SVJNV0FSRV9WMgkJMg0KKw0KICNkZWZpbmUgTVQ3NjE1X0VFUFJPTV9TSVpFCQkxMDI0DQogI2Rl
ZmluZSBNVDc2MTVfVE9LRU5fU0laRQkJNDA5Ng0KIA0KQEAgLTE0NCw2ICsxNDcsOCBAQCBzdHJ1
Y3QgbXQ3NjE1X2RldiB7DQogDQogCXNwaW5sb2NrX3QgdG9rZW5fbG9jazsNCiAJc3RydWN0IGlk
ciB0b2tlbjsNCisNCisJdTggZndfdmVyOw0KIH07DQogDQogZW51bSB7DQotLSANCjIuMTguMA0K

