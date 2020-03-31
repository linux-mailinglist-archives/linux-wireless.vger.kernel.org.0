Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2DA198C8C
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2020 08:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgCaGvt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Mar 2020 02:51:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19038 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726299AbgCaGvt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Mar 2020 02:51:49 -0400
X-UUID: e0a15d4555984197a1dbd54ca4458438-20200331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=u13/otOsZwQRNSYopzBCUAzrteMoNJLZU3KM9kEkgXI=;
        b=tuQugvTRNlpEBYwK7607rkL/75D+tLtPgynY0DeE9qLED17rLnHRThAQFZ9SnbtFoV9CnLsAmxvaKsiYaxfTH/cKaj2Jk7I4mTNf9jiOVosBg47Bkhnzafjttqby9rc7OwR9iaYV2byHJTHzKej4Zl5pIIovQIlGeSFPih4plU8=;
X-UUID: e0a15d4555984197a1dbd54ca4458438-20200331
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 729634148; Tue, 31 Mar 2020 14:51:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 31 Mar 2020 14:51:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 31 Mar 2020 14:51:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/4] mt76: mt7615: modify mt7615_ampdu_stat_read for each phy
Date:   Tue, 31 Mar 2020 14:51:35 +0800
Message-ID: <1fc90ec2a64d062ac7264aaa3dd158f2282ad7b8.1585636614.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhpcyBpcyBhIHByZWxpbWluYXJ5IHBhdGNoIHRvIGFkZCBtb3JlIFR4IGNvdW50ZXJzLg0KDQpT
aWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiAu
Li4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvZGVidWdmcy5jICAgfCAyMCArKysrKysr
KysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzYxNS9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzYxNS9kZWJ1Z2ZzLmMNCmluZGV4IGI0ZDA3OTUxNTRlMy4uOWZkNDBkNzIzMjAxIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvZGVidWdmcy5j
DQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9kZWJ1Z2Zz
LmMNCkBAIC0xMjAsMTIgKzEyMCwxNyBAQCBtdDc2MTVfcmVzZXRfdGVzdF9zZXQodm9pZCAqZGF0
YSwgdTY0IHZhbCkNCiBERUZJTkVfREVCVUdGU19BVFRSSUJVVEUoZm9wc19yZXNldF90ZXN0LCBO
VUxMLA0KIAkJCSBtdDc2MTVfcmVzZXRfdGVzdF9zZXQsICIlbGxkXG4iKTsNCiANCi1zdGF0aWMg
aW50DQotbXQ3NjE1X2FtcGR1X3N0YXRfcmVhZChzdHJ1Y3Qgc2VxX2ZpbGUgKmZpbGUsIHZvaWQg
KmRhdGEpDQorc3RhdGljIHZvaWQNCittdDc2MTVfYW1wZHVfc3RhdF9yZWFkX3BoeShzdHJ1Y3Qg
bXQ3NjE1X3BoeSAqcGh5LA0KKwkJCSAgIHN0cnVjdCBzZXFfZmlsZSAqZmlsZSkNCiB7DQogCXN0
cnVjdCBtdDc2MTVfZGV2ICpkZXYgPSBmaWxlLT5wcml2YXRlOw0KKwlib29sIGV4dF9waHkgPSBw
aHkgIT0gJmRldi0+cGh5Ow0KIAlpbnQgYm91bmRbN10sIGksIHJhbmdlOw0KIA0KKwlpZiAoIXBo
eSkNCisJCXJldHVybjsNCisNCiAJcmFuZ2UgPSBtdDc2X3JyKGRldiwgTVRfQUdHX0FTUkNSMCk7
DQogCWZvciAoaSA9IDA7IGkgPCA0OyBpKyspDQogCQlib3VuZFtpXSA9IE1UX0FHR19BU1JDUl9S
QU5HRShyYW5nZSwgaSkgKyAxOw0KQEAgLTEzMyw2ICsxMzgsOCBAQCBtdDc2MTVfYW1wZHVfc3Rh
dF9yZWFkKHN0cnVjdCBzZXFfZmlsZSAqZmlsZSwgdm9pZCAqZGF0YSkNCiAJZm9yIChpID0gMDsg
aSA8IDM7IGkrKykNCiAJCWJvdW5kW2kgKyA0XSA9IE1UX0FHR19BU1JDUl9SQU5HRShyYW5nZSwg
aSkgKyAxOw0KIA0KKwlzZXFfcHJpbnRmKGZpbGUsICJcblBoeSAlZFxuIiwgZXh0X3BoeSk7DQor
DQogCXNlcV9wcmludGYoZmlsZSwgIkxlbmd0aDogJThkIHwgIiwgYm91bmRbMF0pOw0KIAlmb3Ig
KGkgPSAwOyBpIDwgQVJSQVlfU0laRShib3VuZCkgLSAxOyBpKyspDQogCQlzZXFfcHJpbnRmKGZp
bGUsICIlM2QgLSUzZCB8ICIsDQpAQCAtMTQxLDYgKzE0OCwxNSBAQCBtdDc2MTVfYW1wZHVfc3Rh
dF9yZWFkKHN0cnVjdCBzZXFfZmlsZSAqZmlsZSwgdm9pZCAqZGF0YSkNCiAJZm9yIChpID0gMDsg
aSA8IEFSUkFZX1NJWkUoYm91bmQpOyBpKyspDQogCQlzZXFfcHJpbnRmKGZpbGUsICIlOGQgfCAi
LCBkZXYtPm10NzYuYWdncl9zdGF0c1tpXSk7DQogCXNlcV9wdXRzKGZpbGUsICJcbiIpOw0KK30N
CisNCitzdGF0aWMgaW50DQorbXQ3NjE1X2FtcGR1X3N0YXRfcmVhZChzdHJ1Y3Qgc2VxX2ZpbGUg
KmZpbGUsIHZvaWQgKmRhdGEpDQorew0KKwlzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2ID0gZmlsZS0+
cHJpdmF0ZTsNCisNCisJbXQ3NjE1X2FtcGR1X3N0YXRfcmVhZF9waHkoJmRldi0+cGh5LCBmaWxl
KTsNCisJbXQ3NjE1X2FtcGR1X3N0YXRfcmVhZF9waHkobXQ3NjE1X2V4dF9waHkoZGV2KSwgZmls
ZSk7DQogDQogCXJldHVybiAwOw0KIH0NCi0tIA0KMi4xOC4wDQo=

