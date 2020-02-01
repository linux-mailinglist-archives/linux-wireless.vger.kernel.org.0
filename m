Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA1414F895
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Feb 2020 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBAPeL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Feb 2020 10:34:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51861 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbgBAPeL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Feb 2020 10:34:11 -0500
X-UUID: 98f2effcbc83459ea5e955b1f6b3ccac-20200201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WHvlW4nzcYlhxJhkmi6GNJeu5+5MhcgG+sf8MXm+PcU=;
        b=mWYo68tQM7r31QVkL9WCTFBQPHri1SUkpSapkJeMh9xFMrt13Twnc1d9pisRMfpxJXlPIodNApHki6/ZINdGB0pJ6RfQH0FwZdwSvLDzHzswTabfZTgX3SLZJMGOgnccRViZ3vwH9RpvoiTgIDYHlnfVLRLhOZTtxDVrYutNPeQ=;
X-UUID: 98f2effcbc83459ea5e955b1f6b3ccac-20200201
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2091207316; Sat, 01 Feb 2020 23:34:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 1 Feb 2020 23:34:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 1 Feb 2020 23:31:34 +0800
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
Subject: [PATCH v2 4/7] mt76: mt7615: add starec operating flow for firmware v2
Date:   Sat, 1 Feb 2020 23:33:49 +0800
Message-ID: <5a64e78f336c1b72888bf000719b1cf7f77f62db.1580565624.git.ryder.lee@mediatek.com>
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

QWRkIGZ3X3ZlciBpbiBtdDc2MTVfZGV2IHRvIGNoZWNrIGZpcm13YXJlIHZlcnNpb24sIGFuZCBh
ZGp1c3QNCm10NzYxNV9tY3Vfc2VuZF9zdGFfcmVjKCkgdG8gYWRhcHQgZmlybXdhcmUgdjIgY2hh
bmdlcy4NCg0KU2lnbmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29t
Pg0KU2lnbmVkLW9mZi1ieTogU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4N
ClRlc3RlZC1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4u
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYyAgIHwgMjAgKysrKysrKysr
KysrKy0tLS0tLQ0KIC4uLi93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tdDc2MTUuaCAg
ICB8ICA1ICsrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYx
NS9tY3UuYw0KaW5kZXggYmFhZmE4ZmFmYWYxLi5jZTcwZTJjMDM5NTYgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0KKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCkBAIC00OTEsNiAr
NDkxLDExIEBAIHN0YXRpYyBpbnQgbXQ3NjE1X2xvYWRfcmFtKHN0cnVjdCBtdDc2MTVfZGV2ICpk
ZXYpDQogCQlnb3RvIG91dDsNCiAJfQ0KIA0KKwlpZiAoIXN0cm5jbXAoaGRyLT5md192ZXIsICIy
LjAiLCA2KSkNCisJCWRldi0+ZndfdmVyID0gTVQ3NjE1X0ZJUk1XQVJFX1YyOw0KKwllbHNlDQor
CQlkZXYtPmZ3X3ZlciA9IE1UNzYxNV9GSVJNV0FSRV9WMTsNCisNCiAJcmVsZWFzZV9maXJtd2Fy
ZShmdyk7DQogDQogCXJldCA9IHJlcXVlc3RfZmlybXdhcmUoJmZ3LCBNVDc2MTVfRklSTVdBUkVf
Q1I0LCBkZXYtPm10NzYuZGV2KTsNCkBAIC05OTIsMTAgKzk5NywxMSBAQCBzdGF0aWMgaW50DQog
bXQ3NjE1X21jdV9zZW5kX3N0YV9yZWMoc3RydWN0IG10NzYxNV9kZXYgKmRldiwgdTggKnJlcSwg
dTggKndyZXEsDQogCQkJdTggd2xlbiwgYm9vbCBlbmFibGUpDQogew0KLQl1MzIgc2xlbiA9IHdy
ZXEgLSByZXE7DQorCWJvb2wgaXNfdjEgPSAoZGV2LT5md192ZXIgPT0gTVQ3NjE1X0ZJUk1XQVJF
X1YxKTsNCisJdTMyIHNsZW4gPSBpc192MSA/IHdyZXEgLSByZXEgOiB3cmVxIC0gcmVxICsgd2xl
bjsNCiAJaW50IHJldDsNCiANCi0JaWYgKCFlbmFibGUpIHsNCisJaWYgKGlzX3YxICYmICFlbmFi
bGUpIHsNCiAJCXJldCA9IF9fbXQ3Nl9tY3Vfc2VuZF9tc2coJmRldi0+bXQ3NiwNCiAJCQkJCSAg
TUNVX0VYVF9DTURfU1RBX1JFQ19VUERBVEUsDQogCQkJCQkgIHJlcSwgc2xlbiwgdHJ1ZSk7DQpA
QCAtMTAwNiwxMCArMTAxMiwxMiBAQCBtdDc2MTVfbWN1X3NlbmRfc3RhX3JlYyhzdHJ1Y3QgbXQ3
NjE1X2RldiAqZGV2LCB1OCAqcmVxLCB1OCAqd3JlcSwNCiAJCQkJCSAgIHdyZXEsIHdsZW4sIHRy
dWUpOw0KIAl9DQogDQotCXJldCA9IF9fbXQ3Nl9tY3Vfc2VuZF9tc2coJmRldi0+bXQ3NiwgTUNV
X0VYVF9DTURfV1RCTF9VUERBVEUsIHdyZXEsDQotCQkJCSAgd2xlbiwgdHJ1ZSk7DQotCWlmIChy
ZXQpDQotCQlyZXR1cm4gcmV0Ow0KKwlpZiAoaXNfdjEpIHsNCisJCXJldCA9IF9fbXQ3Nl9tY3Vf
c2VuZF9tc2coJmRldi0+bXQ3NiwgTUNVX0VYVF9DTURfV1RCTF9VUERBVEUsDQorCQkJCQkgIHdy
ZXEsIHdsZW4sIHRydWUpOw0KKwkJaWYgKHJldCkNCisJCQlyZXR1cm4gcmV0Ow0KKwl9DQogDQog
CXJldHVybiBfX210NzZfbWN1X3NlbmRfbXNnKCZkZXYtPm10NzYsIE1DVV9FWFRfQ01EX1NUQV9S
RUNfVVBEQVRFLA0KIAkJCQkgICByZXEsIHNsZW4sIHRydWUpOw0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L210NzYxNS5oIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbXQ3NjE1LmgNCmluZGV4IDliZDkyNmQ2
OTYzZi4uZmEzOTYzMmNkMmJkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc2MTUvbXQ3NjE1LmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3NjE1L210NzYxNS5oDQpAQCAtMzAsNiArMzAsOSBAQA0KICNkZWZpbmUg
TVQ3NjE1X0ZJUk1XQVJFX045CQkibWVkaWF0ZWsvbXQ3NjE1X245LmJpbiINCiAjZGVmaW5lIE1U
NzYxNV9ST01fUEFUQ0gJCSJtZWRpYXRlay9tdDc2MTVfcm9tX3BhdGNoLmJpbiINCiANCisjZGVm
aW5lIE1UNzYxNV9GSVJNV0FSRV9WMQkJMQ0KKyNkZWZpbmUgTVQ3NjE1X0ZJUk1XQVJFX1YyCQky
DQorDQogI2RlZmluZSBNVDc2MTVfRUVQUk9NX1NJWkUJCTEwMjQNCiAjZGVmaW5lIE1UNzYxNV9U
T0tFTl9TSVpFCQk0MDk2DQogDQpAQCAtMTQ0LDYgKzE0Nyw4IEBAIHN0cnVjdCBtdDc2MTVfZGV2
IHsNCiANCiAJc3BpbmxvY2tfdCB0b2tlbl9sb2NrOw0KIAlzdHJ1Y3QgaWRyIHRva2VuOw0KKw0K
Kwl1OCBmd192ZXI7DQogfTsNCiANCiBlbnVtIHsNCi0tIA0KMi4xOC4wDQo=

