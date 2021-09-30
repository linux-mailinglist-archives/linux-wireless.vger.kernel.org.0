Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E041D49C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348737AbhI3Hjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 03:39:45 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:24579 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348783AbhI3Hjn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 03:39:43 -0400
X-UUID: ec0d25b12e25429a99139e1374b57ae1-20210930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hdVH/FfnZus1GUan8Vi1chx+4kTao6AmMOXIKsLSzvw=;
        b=U4LdvuRvRwlTdmsDrLYCWHz6+DOnkU1axPo8wjwC1UaxweNcY13tMvLEdkMCbgL+F3Phyw8RRC7Lr5hw1iHjFR1/d5Zx0pZjN1vuJdTutLUcby5mOWDTlQQke48cCugeY2xa15ELWmQhLuTmp6V6In95Lx6jvYT33dC3MzCVLYE=;
X-UUID: ec0d25b12e25429a99139e1374b57ae1-20210930
Received: from mtkcas36.mediatek.inc [(172.27.7.253)] by mailgw02.mediatek.com
        (envelope-from <xing.song@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1123434750; Thu, 30 Sep 2021 15:37:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 30 Sep
 2021 15:37:41 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 30 Sep 2021 15:37:41 +0800
From:   Xing Song <xing.song@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Xing Song <xing.song@mediatek.com>
Subject: [PATCH] mt76: use a separate CCMP PN receive counter for management frames
Date:   Thu, 30 Sep 2021 15:37:37 +0800
Message-ID: <20210930073737.146789-1-xing.song@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3A44D0BB44E9B51AC5356A502F2DFBDAEF6EBEC57AAB601A95621F9D3F742AC92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V2hlbiByZWNlaXZlZCBmcmFtZSBpcyBkZWNyeXBlZCBieSBoYXJkd2FyZSwgQ0NNUCBQTiBpcyBj
aGVja2VkIGJ5DQptdDc2Lg0KDQpXaGVuIG1hbmFnZW1lbnQgZnJhbWUgcHJvdGVjdGlvbiAoSUVF
RSA4MDIuMTF3KSBpcyB1c2VkLCB3ZSBtdXN0IHVzZQ0KYSBzZXBhcmF0ZSBjb3VudGVyIGZvciB0
cmFja2luZyByZWNlaXZlZCBDQ01QIHBhY2tldCBudW1iZXIgZm9yIHRoZQ0KbWFuYWdlbWVudCBm
cmFtZXMuIFRoZSBwcmV2aW91c2x5IHVzZWQgY291bnRlciB3YXMgc2hhcmVkIHdpdGggZGF0YQ0K
ZnJhbWVzIGFuZCB0aGF0IGNhbiBjYXVzZSBwcm9ibGVtcyBpbiBkZXRlY3RpbmcgcmVwbGF5cyBp
bmNvcnJlY3RseQ0KZm9yIHJvYnVzdCBtYW5hZ2VtZW50IGZyYW1lcy4NCg0KQWRkIGEgbmV3IGNv
dW50ZXIganVzdCBmb3Igcm9idXN0IG1hbmFnZW1lbnQgZnJhbWVzIHRvIGF2b2lkIHRoaXMNCmlz
c3VlLg0KDQpTaWduZWQtb2ZmLWJ5OiBYaW5nIFNvbmcgPHhpbmcuc29uZ0BtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L21hYzgwMjExLmMgfCAy
NyArKysrKysrKysrKysrKysrLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2LmggICAgIHwgIDIgKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L21hYzgwMjExLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L21hYzgwMjExLmMNCmluZGV4IGJiZTdiYTY0Y2NkMi4uNDE5YjhlNzU3MzlhIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tYWM4MDIxMS5jDQorKysgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L21hYzgwMjExLmMNCkBAIC03ODgsMTAg
Kzc4OCwxNyBAQCB2b2lkIG10NzZfd2NpZF9rZXlfc2V0dXAoc3RydWN0IG10NzZfZGV2ICpkZXYs
IHN0cnVjdCBtdDc2X3djaWQgKndjaWQsDQogCQlyZXR1cm47DQogDQogCXdjaWQtPnJ4X2NoZWNr
X3BuID0gdHJ1ZTsNCisNCisJLyogZGF0YSBmcmFtZSAqLw0KIAlmb3IgKGkgPSAwOyBpIDwgSUVF
RTgwMjExX05VTV9USURTOyBpKyspIHsNCiAJCWllZWU4MDIxMV9nZXRfa2V5X3J4X3NlcShrZXks
IGksICZzZXEpOw0KIAkJbWVtY3B5KHdjaWQtPnJ4X2tleV9wbltpXSwgc2VxLmNjbXAucG4sIHNp
emVvZihzZXEuY2NtcC5wbikpOw0KIAl9DQorDQorCS8qIHJvYnVzdCBtYW5hZ2VtZW50IGZyYW1l
ICovDQorCWllZWU4MDIxMV9nZXRfa2V5X3J4X3NlcShrZXksIC0xLCAmc2VxKTsNCisJbWVtY3B5
KHdjaWQtPnJ4X2tleV9wbltpXSwgc2VxLmNjbXAucG4sIHNpemVvZihzZXEuY2NtcC5wbikpOw0K
Kw0KIH0NCiBFWFBPUlRfU1lNQk9MKG10NzZfd2NpZF9rZXlfc2V0dXApOw0KIA0KQEAgLTg0NCw3
ICs4NTEsNyBAQCBtdDc2X2NoZWNrX2NjbXBfcG4oc3RydWN0IHNrX2J1ZmYgKnNrYikNCiAJc3Ry
dWN0IG10NzZfcnhfc3RhdHVzICpzdGF0dXMgPSAoc3RydWN0IG10NzZfcnhfc3RhdHVzICopc2ti
LT5jYjsNCiAJc3RydWN0IG10NzZfd2NpZCAqd2NpZCA9IHN0YXR1cy0+d2NpZDsNCiAJc3RydWN0
IGllZWU4MDIxMV9oZHIgKmhkcjsNCi0JdTggdGlkbm8gPSBzdGF0dXMtPnFvc19jdGwgJiBJRUVF
ODAyMTFfUU9TX0NUTF9USURfTUFTSzsNCisJaW50IHNlY3VyaXR5X2lkeDsNCiAJaW50IHJldDsN
CiANCiAJaWYgKCEoc3RhdHVzLT5mbGFnICYgUlhfRkxBR19ERUNSWVBURUQpKQ0KQEAgLTg1Mywy
NCArODYwLDM2IEBAIG10NzZfY2hlY2tfY2NtcF9wbihzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KIAlp
ZiAoIXdjaWQgfHwgIXdjaWQtPnJ4X2NoZWNrX3BuKQ0KIAkJcmV0dXJuIDA7DQogDQorCWhkciA9
IG10NzZfc2tiX2dldF9oZHIoc2tiKTsNCiAJaWYgKCEoc3RhdHVzLT5mbGFnICYgUlhfRkxBR19J
Vl9TVFJJUFBFRCkpIHsNCiAJCS8qDQogCQkgKiBWYWxpZGF0ZSB0aGUgZmlyc3QgZnJhZ21lbnQg
Ym90aCBoZXJlIGFuZCBpbiBtYWM4MDIxMQ0KIAkJICogQWxsIGZ1cnRoZXIgZnJhZ21lbnRzIHdp
bGwgYmUgdmFsaWRhdGVkIGJ5IG1hYzgwMjExIG9ubHkuDQogCQkgKi8NCi0JCWhkciA9IG10NzZf
c2tiX2dldF9oZHIoc2tiKTsNCiAJCWlmIChpZWVlODAyMTFfaXNfZnJhZyhoZHIpICYmDQogCQkg
ICAgIWllZWU4MDIxMV9pc19maXJzdF9mcmFnKGhkci0+ZnJhbWVfY29udHJvbCkpDQogCQkJcmV0
dXJuIDA7DQogCX0NCiANCisJLyogSUVFRSA4MDIuMTEtMjAyMCwgMTIuNS4zLjQuNCAiUE4gYW5k
IHJlcGxheSBkZXRlY3Rpb24iIGMpOg0KKwkgKg0KKwkgKiB0aGUgcmVjaXBpZW50IHNoYWxsIG1h
aW50YWluIGEgc2luZ2xlIHJlcGxheSBjb3VudGVyIGZvciByZWNlaXZlZA0KKwkgKiBpbmRpdmlk
dWFsbHkgYWRkcmVzc2VkIHJvYnVzdCBNYW5hZ2VtZW50IGZyYW1lcyB0aGF0IGFyZSByZWNlaXZl
ZA0KKwkgKiB3aXRoIHRoZSBUbyBEUyBzdWJmaWVsZCBlcXVhbCB0byAwLCBbLi4uXQ0KKwkgKi8N
CisJaWYgKGllZWU4MDIxMV9pc19tZ210KGhkci0+ZnJhbWVfY29udHJvbCkgJiYNCisJICAgICFp
ZWVlODAyMTFfaGFzX3RvZHMoaGRyLT5mcmFtZV9jb250cm9sKSkNCisJCXNlY3VyaXR5X2lkeCA9
IElFRUU4MDIxMV9OVU1fVElEUzsNCisJZWxzZQ0KKwkJc2VjdXJpdHlfaWR4ID0gc3RhdHVzLT5x
b3NfY3RsICYgSUVFRTgwMjExX1FPU19DVExfVElEX01BU0s7DQorDQogCUJVSUxEX0JVR19PTihz
aXplb2Yoc3RhdHVzLT5pdikgIT0gc2l6ZW9mKHdjaWQtPnJ4X2tleV9wblswXSkpOw0KLQlyZXQg
PSBtZW1jbXAoc3RhdHVzLT5pdiwgd2NpZC0+cnhfa2V5X3BuW3RpZG5vXSwNCisJcmV0ID0gbWVt
Y21wKHN0YXR1cy0+aXYsIHdjaWQtPnJ4X2tleV9wbltzZWN1cml0eV9pZHhdLA0KIAkJICAgICBz
aXplb2Yoc3RhdHVzLT5pdikpOw0KIAlpZiAocmV0IDw9IDApDQogCQlyZXR1cm4gLUVJTlZBTDsg
LyogcmVwbGF5ICovDQogDQotCW1lbWNweSh3Y2lkLT5yeF9rZXlfcG5bdGlkbm9dLCBzdGF0dXMt
Pml2LCBzaXplb2Yoc3RhdHVzLT5pdikpOw0KKwltZW1jcHkod2NpZC0+cnhfa2V5X3BuW3NlY3Vy
aXR5X2lkeF0sIHN0YXR1cy0+aXYsIHNpemVvZihzdGF0dXMtPml2KSk7DQogDQogCWlmIChzdGF0
dXMtPmZsYWcgJiBSWF9GTEFHX0lWX1NUUklQUEVEKQ0KIAkJc3RhdHVzLT5mbGFnIHw9IFJYX0ZM
QUdfUE5fVkFMSURBVEVEOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlh
dGVrL210NzYvbXQ3Ni5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2
LmgNCmluZGV4IDc4M2VhNTU1ZmE2MC4uMTA0YTAxNzA0MjA4IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCisrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQpAQCAtMjU1LDcgKzI1NSw3IEBAIHN0cnVjdCBt
dDc2X3djaWQgew0KIAl1OCBhbXNkdToxOw0KIA0KIAl1OCByeF9jaGVja19wbjsNCi0JdTggcnhf
a2V5X3BuW0lFRUU4MDIxMV9OVU1fVElEU11bNl07DQorCXU4IHJ4X2tleV9wbltJRUVFODAyMTFf
TlVNX1RJRFMgKyAxXVs2XTsNCiAJdTE2IGNpcGhlcjsNCiANCiAJdTMyIHR4X2luZm87DQotLSAN
CjIuMTguMA0K

