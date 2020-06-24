Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D364207036
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbgFXJkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 05:40:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64855 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388031AbgFXJkO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 05:40:14 -0400
X-UUID: 1b86b787c4584403948d60ac70f21b58-20200624
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7PK14oqTmOFJOT/MNKY1j9wxaPQDa9X5TZTJttjSw70=;
        b=fv58FYKv3yYzjiDp1LWJZvC3DzF4eiu2EMP+W9enWPjV5UUcYJzr47CxXi2gefUpp+pk7XiDt9Nawvw6LMagIMI9zOljDIHqxDqTQ0KHqs0TcM1EabeylddHwC9bPJdZ2B1S+sWwA5qPpNjIqV1xOrfQfBCQUxYLvOVPot+ddhs=;
X-UUID: 1b86b787c4584403948d60ac70f21b58-20200624
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 355615992; Wed, 24 Jun 2020 17:40:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Jun 2020 17:40:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Jun 2020 17:40:03 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7615: register ext_phy if DBDC is detected
Date:   Wed, 24 Jun 2020 17:39:37 +0800
Message-ID: <20200624093937.26741-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B75E107CDB5820FA4F527F0EDDC99885F69BA3767655EBCCEA2B8DAFEB7A1CC92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TVRfRUVfV0lGSV9DT05GIGZpZWxkIGNhbiBiZSB1c2VkIHRvIGRldGVjdCBpZiB0aGUgY2hpcHNl
dCBpcyBNVDc2MTVELg0KVGh1cywgYWRkIHN1cHBvcnQgdG8gYXV0b21hdGljYWxseSByZWdpc3Rl
ciBleHRfcGh5IGlmIERCREMgaXMgZGV0ZWN0ZWQuDQoNClNpZ25lZC1vZmYtYnk6IFNoYXluZSBD
aGVuIDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L210NzYxNS9lZXByb20uYyAgIHwgMyArKysNCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9pbml0LmMgICAgIHwgMiArLQ0KIGRyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3BjaV9pbml0LmMgfCAzICsrKw0KIDMg
ZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9lZXByb20uYyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L2VlcHJvbS5jDQppbmRl
eCAyMmU0ZWFiLi40ZTA3YzdlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVk
aWF0ZWsvbXQ3Ni9tdDc2MTUvZWVwcm9tLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21l
ZGlhdGVrL210NzYvbXQ3NjE1L2VlcHJvbS5jDQpAQCAtMTI1LDYgKzEyNSw5IEBAIG10NzYxNV9l
ZXByb21fcGFyc2VfaHdfYmFuZF9jYXAoc3RydWN0IG10NzYxNV9kZXYgKmRldikNCiAJY2FzZSBN
VF9FRV8yR0haOg0KIAkJZGV2LT5tdDc2LmNhcC5oYXNfMmdoeiA9IHRydWU7DQogCQlicmVhazsN
CisJY2FzZSBNVF9FRV9EQkRDOg0KKwkJZGV2LT5tdDc2LnBoeTIgPSAmZGV2LT5tcGh5Ow0KKwkJ
LyogZmFsbCB0aHJvdWdoICovDQogCWRlZmF1bHQ6DQogCQlkZXYtPm10NzYuY2FwLmhhc18yZ2h6
ID0gdHJ1ZTsNCiAJCWRldi0+bXQ3Ni5jYXAuaGFzXzVnaHogPSB0cnVlOw0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L2luaXQuYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L2luaXQuYw0KaW5kZXggMzkyMWU3
ZS4uYzA3NTAwNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3NjE1L2luaXQuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2MTUvaW5pdC5jDQpAQCAtMzg0LDcgKzM4NCw3IEBAIGludCBtdDc2MTVfcmVnaXN0ZXJf
ZXh0X3BoeShzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2KQ0KIAlpZiAodGVzdF9iaXQoTVQ3Nl9TVEFU
RV9SVU5OSU5HLCAmZGV2LT5tcGh5LnN0YXRlKSkNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KLQlp
ZiAocGh5KQ0KKwlpZiAocGh5ICYmIHBoeSAhPSAmZGV2LT5waHkpDQogCQlyZXR1cm4gMDsNCiAN
CiAJbXQ3NjE1X2NhcF9kYmRjX2VuYWJsZShkZXYpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3BjaV9pbml0LmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9wY2lfaW5pdC5jDQppbmRleCA2OWNiYTg2Li5l
Yzk0OTQ0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc2MTUvcGNpX2luaXQuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc2MTUvcGNpX2luaXQuYw0KQEAgLTI1LDYgKzI1LDkgQEAgc3RhdGljIHZvaWQgbXQ3NjE1
X2luaXRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQogCW10NzYxNV9waHlfaW5pdChk
ZXYpOw0KIAltdDc2MTVfbWN1X2RlbF93dGJsX2FsbChkZXYpOw0KIAltdDc2MTVfY2hlY2tfb2Zm
bG9hZF9jYXBhYmlsaXR5KGRldik7DQorDQorCWlmIChkZXYtPm10NzYucGh5MikNCisJCW10NzYx
NV9yZWdpc3Rlcl9leHRfcGh5KGRldik7DQogfQ0KIA0KIHN0YXRpYyBpbnQgbXQ3NjE1X2luaXRf
aGFyZHdhcmUoc3RydWN0IG10NzYxNV9kZXYgKmRldikNCi0tIA0KMi4xNy4xDQo=

