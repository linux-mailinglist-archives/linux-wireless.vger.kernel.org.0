Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD751FEA4A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 06:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgFREmB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 00:42:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23495 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725889AbgFREmA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 00:42:00 -0400
X-UUID: 5971061ac49e4891af81536e92a18e19-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1MJwtjnSozcDYpnLZs9rWfOmBAurwZU/5UszGVVbHtU=;
        b=WrfHfUt+7GD2i73rfx/e1He2JQckiYIfI2kSYsUzQtTqXWA0S3Qg2lAWu9YA75VEE3/CJ8FekrqSGisyUwinVQ2UoLObzsav+1XscKb1jCipR3AULtKbUURY9HXFtuGVR5TnlSeZaDk1mZoj+uQFref481oHLYUG6m4YbuCmW3c=;
X-UUID: 5971061ac49e4891af81536e92a18e19-20200618
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1506349876; Thu, 18 Jun 2020 12:41:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 12:41:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 12:41:53 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7615: add .set_tsf callback
Date:   Thu, 18 Jun 2020 12:41:48 +0800
Message-ID: <f1b8ff0f2ac56d8045cb1836ae33d2e29fa766ef.1592449623.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SXQgaXMgdXNlZnVsIGZvciBJQlNTIE1lc2ggdG8gYWRqdXN0IHRfY2xvY2tkcmlmdC4NCg0KU2ln
bmVkLW9mZi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4u
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMgIHwgMjEgKysrKysrKysr
KysrKysrKysrKw0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvcmVncy5o
ICB8ICAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21haW4uYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21haW4uYw0KaW5kZXggNmI0
ZGQ1ZDg3OTRlLi5iMTM5MGVmZTczNDEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzYxNS9tYWluLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3NjE1L21haW4uYw0KQEAgLTc0MCw2ICs3NDAsMjYgQEAgbXQ3NjE1
X2dldF90c2Yoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2
aWYpDQogCXJldHVybiB0c2YudDY0Ow0KIH0NCiANCitzdGF0aWMgdm9pZA0KK210NzYxNV9zZXRf
dHNmKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0K
KwkgICAgICAgdTY0IHRpbWVzdGFtcCkNCit7DQorCXN0cnVjdCBtdDc2MTVfZGV2ICpkZXYgPSBt
dDc2MTVfaHdfZGV2KGh3KTsNCisJdW5pb24gew0KKwkJdTY0IHQ2NDsNCisJCXUzMiB0MzJbMl07
DQorCX0gdHNmID0geyAudDY0ID0gdGltZXN0YW1wLCB9Ow0KKw0KKwltdXRleF9sb2NrKCZkZXYt
Pm10NzYubXV0ZXgpOw0KKw0KKwltdDc2X3dyKGRldiwgTVRfTFBPTl9VVFRSMCwgdHNmLnQzMlsw
XSk7DQorCW10NzZfd3IoZGV2LCBNVF9MUE9OX1VUVFIxLCB0c2YudDMyWzFdKTsNCisJLyogVFNG
IHNvZnR3YXJlIG92ZXJ3cml0ZSAqLw0KKwltdDc2X3NldChkZXYsIE1UX0xQT05fVDBDUiwgTVRf
TFBPTl9UMENSX1dSSVRFKTsNCisNCisJbXV0ZXhfdW5sb2NrKCZkZXYtPm10NzYubXV0ZXgpOw0K
K30NCisNCiBzdGF0aWMgdm9pZA0KIG10NzYxNV9zZXRfY292ZXJhZ2VfY2xhc3Moc3RydWN0IGll
ZWU4MDIxMV9odyAqaHcsIHMxNiBjb3ZlcmFnZV9jbGFzcykNCiB7DQpAQCAtMTAzOCw2ICsxMDU4
LDcgQEAgY29uc3Qgc3RydWN0IGllZWU4MDIxMV9vcHMgbXQ3NjE1X29wcyA9IHsNCiAJLmNoYW5u
ZWxfc3dpdGNoX2JlYWNvbiA9IG10NzYxNV9jaGFubmVsX3N3aXRjaF9iZWFjb24sDQogCS5nZXRf
c3RhdHMgPSBtdDc2MTVfZ2V0X3N0YXRzLA0KIAkuZ2V0X3RzZiA9IG10NzYxNV9nZXRfdHNmLA0K
Kwkuc2V0X3RzZiA9IG10NzYxNV9zZXRfdHNmLA0KIAkuZ2V0X3N1cnZleSA9IG10NzZfZ2V0X3N1
cnZleSwNCiAJLmdldF9hbnRlbm5hID0gbXQ3Nl9nZXRfYW50ZW5uYSwNCiAJLnNldF9hbnRlbm5h
ID0gbXQ3NjE1X3NldF9hbnRlbm5hLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3NjE1L3JlZ3MuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3NjE1L3JlZ3MuaA0KaW5kZXggYWVlNDMzYTllZmY2Li5mMGIzNmIxNjJiZjMg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9y
ZWdzLmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3Jl
Z3MuaA0KQEAgLTQxNyw2ICs0MTcsNyBAQCBlbnVtIG10NzYxNV9yZWdfYmFzZSB7DQogDQogI2Rl
ZmluZSBNVF9MUE9OX1QwQ1IJCQlNVF9MUE9OKDB4MDEwKQ0KICNkZWZpbmUgTVRfTFBPTl9UMENS
X01PREUJCUdFTk1BU0soMSwgMCkNCisjZGVmaW5lIE1UX0xQT05fVDBDUl9XUklURQkJQklUKDAp
DQogDQogI2RlZmluZSBNVF9MUE9OX1VUVFIwCQkJTVRfTFBPTigweDAxOCkNCiAjZGVmaW5lIE1U
X0xQT05fVVRUUjEJCQlNVF9MUE9OKDB4MDFjKQ0KLS0gDQoyLjE4LjANCg==

