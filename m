Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD93B9DA0
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jul 2021 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGBImm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 04:42:42 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:16675 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230166AbhGBImm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 04:42:42 -0400
X-UUID: 742705fc12f64afc8debfd8d4d33cf27-20210702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1OnGl7xq3NOFK3e1GzhJyCLVnMWI/X73iPrxvmoKimg=;
        b=rGcBqFz/mpIM8KXQQ9tSSx84OrIHihCS8FG/qi+MvvwJrqlKtCIiB3X3bhH0Ty0w6J2X813pwizq9CSAQPsfdZCkk3MR6NhaTwJJiqy7zCYx33hgwFjl78z3lrNBd7K28FtvAyETTjYy34x3BjMe22/OTWWOzFxy62wFR8E9l+k=;
X-UUID: 742705fc12f64afc8debfd8d4d33cf27-20210702
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 5926091; Fri, 02 Jul 2021 16:40:00 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 2 Jul
 2021 16:39:52 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 2 Jul 2021 16:39:52 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH] mt76: mt7915: cleanup miscellaneous errors and redundant codes
Date:   Fri, 2 Jul 2021 16:39:49 +0800
Message-ID: <20210702083949.4431-1-bo.jiao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E5970F82D679ACA60D60ABEF64347722AD57499F5300A5D1BA73B0C9D78891502000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogQm8gSmlhbyA8Qm8uSmlhb0BtZWRpYXRlay5jb20+DQoNCmNsZWFudXAgbWlzY2VsbGFu
ZW91cyBlcnJvcnMgYW5kIHJlZHVuZGFudCBjb2Rlcy4NCg0KU2lnbmVkLW9mZi1ieTogQm8gSmlh
byA8Qm8uSmlhb0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9pbml0LmMgfCAgMiArLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jICB8IDEwICsrKy0tLS0tLS0NCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMgfCAgMiArLQ0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jICB8ICA3ICstLS0tLS0NCiA0IGZp
bGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCmluZGV4IDQ3
OThkNjM0NDMwNS4uMWQyMjE0NTE5ZjVhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvaW5pdC5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzkxNS9pbml0LmMNCkBAIC00ODAsNyArNDgwLDcgQEAgc3RhdGlj
IGludCBtdDc5MTVfaW5pdF9oYXJkd2FyZShzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2KQ0KIAl9DQog
DQogCS8qIEJlYWNvbiBhbmQgbWdtdCBmcmFtZXMgc2hvdWxkIG9jY3VweSB3Y2lkIDAgKi8NCi0J
aWR4ID0gbXQ3Nl93Y2lkX2FsbG9jKGRldi0+bXQ3Ni53Y2lkX21hc2ssIE1UNzkxNV9XVEJMX1NU
QSAtIDEpOw0KKwlpZHggPSBtdDc2X3djaWRfYWxsb2MoZGV2LT5tdDc2LndjaWRfbWFzaywgTVQ3
OTE1X1dUQkxfU1RBKTsNCiAJaWYgKGlkeCkNCiAJCXJldHVybiAtRU5PU1BDOw0KIA0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMNCmluZGV4IDI0
NjI3MDQwOTRiMC4uMTg2YThmNDRhYmI4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jDQpAQCAtMTM3NywxMyArMTM3Nyw5IEBAIHZvaWQg
bXQ3OTE1X21hY19yZXNldF9jb3VudGVycyhzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5KQ0KIAkJbXQ3
Nl9ycihkZXYsIE1UX1RYX0FHR19DTlQyKGV4dF9waHksIGkpKTsNCiAJfQ0KIA0KLQlpZiAoZXh0
X3BoeSkgew0KLQkJZGV2LT5tdDc2LnBoeTItPnN1cnZleV90aW1lID0ga3RpbWVfZ2V0X2Jvb3R0
aW1lKCk7DQotCQlpID0gQVJSQVlfU0laRShkZXYtPm10NzYuYWdncl9zdGF0cykgLyAyOw0KLQl9
IGVsc2Ugew0KLQkJZGV2LT5tdDc2LnBoeS5zdXJ2ZXlfdGltZSA9IGt0aW1lX2dldF9ib290dGlt
ZSgpOw0KLQkJaSA9IDA7DQotCX0NCisJcGh5LT5tdDc2LT5zdXJ2ZXlfdGltZSA9IGt0aW1lX2dl
dF9ib290dGltZSgpOw0KKwlpID0gZXh0X3BoeSA/IEFSUkFZX1NJWkUoZGV2LT5tdDc2LmFnZ3Jf
c3RhdHMpIC8gMiA6IDA7DQorDQogCW1lbXNldCgmZGV2LT5tdDc2LmFnZ3Jfc3RhdHNbaV0sIDAs
IHNpemVvZihkZXYtPm10NzYuYWdncl9zdGF0cykgLyAyKTsNCiANCiAJLyogcmVzZXQgYWlydGlt
ZSBjb3VudGVycyAqLw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTE1L21haW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3OTE1L21haW4uYw0KaW5kZXggYzI1ZjhkYTU5MGRkLi5kOGFiZWJjZmZlNGIgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tYWluLmMNCisr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21haW4uYw0KQEAg
LTYxMyw3ICs2MTMsNyBAQCBpbnQgbXQ3OTE1X21hY19zdGFfYWRkKHN0cnVjdCBtdDc2X2RldiAq
bWRldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCiAJc3RydWN0IG10NzkxNV92aWYgKm12
aWYgPSAoc3RydWN0IG10NzkxNV92aWYgKil2aWYtPmRydl9wcml2Ow0KIAlpbnQgcmV0LCBpZHg7
DQogDQotCWlkeCA9IG10NzZfd2NpZF9hbGxvYyhkZXYtPm10NzYud2NpZF9tYXNrLCBNVDc5MTVf
V1RCTF9TVEEgLSAxKTsNCisJaWR4ID0gbXQ3Nl93Y2lkX2FsbG9jKGRldi0+bXQ3Ni53Y2lkX21h
c2ssIE1UNzkxNV9XVEJMX1NUQSk7DQogCWlmIChpZHggPCAwKQ0KIAkJcmV0dXJuIC1FTk9TUEM7
DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3Uu
Yw0KaW5kZXggODYzYWExOGIzMDI0Li42MjE2MGNhNzIxYjggMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9tY3UuYw0KKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCkBAIC05NzUsMTIgKzk3NSw3
IEBAIG10NzkxNV9tY3VfYnNzX3JmY2hfdGx2KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBp
ZWVlODAyMTFfdmlmICp2aWYsDQogCX0NCiANCiAJaWYgKHZpZi0+YnNzX2NvbmYuaGVfc3VwcG9y
dCAmJiB2aWYtPnR5cGUgPT0gTkw4MDIxMV9JRlRZUEVfU1RBVElPTikgew0KLQkJc3RydWN0IG10
NzkxNV9kZXYgKmRldiA9IHBoeS0+ZGV2Ow0KLQkJc3RydWN0IG10NzZfcGh5ICptcGh5ID0gJmRl
di0+bXQ3Ni5waHk7DQotCQlib29sIGV4dF9waHkgPSBwaHkgIT0gJmRldi0+cGh5Ow0KLQ0KLQkJ
aWYgKGV4dF9waHkgJiYgZGV2LT5tdDc2LnBoeTIpDQotCQkJbXBoeSA9IGRldi0+bXQ3Ni5waHky
Ow0KKwkJc3RydWN0IG10NzZfcGh5ICptcGh5ID0gcGh5LT5tdDc2Ow0KIA0KIAkJY2gtPmhlX3J1
MjZfYmxvY2sgPQ0KIAkJCW10NzkxNV9jaGVja19oZV9vYnNzX25hcnJvd19id19ydShtcGh5LT5o
dywgdmlmKTsNCi0tIA0KMi4xOC4wDQo=

