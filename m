Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44FA1B1E24
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 07:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgDUFUd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 01:20:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6048 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgDUFUd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 01:20:33 -0400
X-UUID: 582fc3bab3764b5fae37b843ff0d2f77-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HnBBAl5ApGkX57RqSlJeWzPnI68bVoLjmJ43j6pkVuk=;
        b=P/rADJw9p8J1AUs2H49qs426RjD8jtFtT2KY0Kxbatu8esBbEb7zKX590k407uFoiRsYlC5oQ9mJlfNrrhkFdlejJF74RB0J1wzZA5wLjST8uxpdmSIxIxDJUKKIXrdEeGyZvJS018lI/F6zxd70eUVd/e7YJUAvG4qPl4PLGkA=;
X-UUID: 582fc3bab3764b5fae37b843ff0d2f77-20200421
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 573305182; Tue, 21 Apr 2020 13:20:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Apr 2020 13:20:27 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Apr 2020 13:20:27 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Soul Huang <Soul.Huang@mediatek.com>
Subject: [PATCH 3/3] mt76: mt7663: fix up BMC entry indicated to unicmd firmware
Date:   Tue, 21 Apr 2020 13:20:23 +0800
Message-ID: <99b919b29ad60437749d5f30dc8c68ccb3df89f3.1587445885.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1467d47fd111b5711fa74410833153bdc9e01b72.1587445885.git.sean.wang@mediatek.com>
References: <1467d47fd111b5711fa74410833153bdc9e01b72.1587445885.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9B03E7B10743E9A1174ED658E4FA1FEFCC51863DC180DF2666E119831E7EE7A92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpCTUMgZW50cnkgZm9y
IE1UNzY2MyB1bmljbWQgZmlybXdhcmUgc2hvdWxkIGJlIGEgYnJvYWRjYXN0L211bHRpY2FzdCBl
bnRyeSwNCm5vdCBhIHVuaWNhc3QgZW50cnksIHRoYXQgaXMgR1RLIHJla2V5IG9mZmxvYWQgd291
bGQgcmVseSBvbi4NCg0KRml4ZXM6IDEzODg2MDY3OWIyYSAoIm10NzY6IG10NzYxNTogYWRkIG1v
cmUgdW5pIG1jdSBjb21tYW5kcyIpDQpDYzogU291bCBIdWFuZyA8U291bC5IdWFuZ0BtZWRpYXRl
ay5jb20+DQpTdWdnZXN0ZWQtYnk6IFlGIEx1byA8WWYuTHVvQG1lZGlhdGVrLmNvbT4NCkNvLWRl
dmVsb3BlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9m
Zi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTog
U2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMgfCA1ICsrLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCmluZGV4IDA0NWJkZTdmNTU0ZC4u
ZThjYWEyYzc5ODFlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc2MTUvbWN1LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3NjE1L21jdS5jDQpAQCAtMTMzOSw3ICsxMzM5LDcgQEAgbXQ3NjE1X21jdV91bmlfYWRk
X2JzcyhzdHJ1Y3QgbXQ3NjE1X3BoeSAqcGh5LA0KIAkJCS5zaG9ydF9zdCA9IHRydWUsDQogCQl9
LA0KIAl9Ow0KLQl1OCBpZHgsIHR4X3dsYW5faWR4ID0gMDsNCisJdTggaWR4LCB0eF93bGFuX2lk
eCA9IG12aWYtPnN0YS53Y2lkLmlkeDsNCiAJaW50IGVycjsNCiANCiAJaWR4ID0gbXZpZi0+b21h
Y19pZHggPiBFWFRfQlNTSURfU1RBUlQgPyBIV19CU1NJRF8wIDogbXZpZi0+b21hY19pZHg7DQpA
QCAtMTM0OSwxMCArMTM0OSw5IEBAIG10NzYxNV9tY3VfdW5pX2FkZF9ic3Moc3RydWN0IG10NzYx
NV9waHkgKnBoeSwNCiAJY2FzZSBOTDgwMjExX0lGVFlQRV9NRVNIX1BPSU5UOg0KIAljYXNlIE5M
ODAyMTFfSUZUWVBFX0FQOg0KIAkJYmFzaWNfcmVxLmJhc2ljLmNvbm5fdHlwZSA9IGNwdV90b19s
ZTMyKENPTk5FQ1RJT05fSU5GUkFfQVApOw0KLQkJdHhfd2xhbl9pZHggPSBtdmlmLT5zdGEud2Np
ZC5pZHg7DQogCQlicmVhazsNCiAJY2FzZSBOTDgwMjExX0lGVFlQRV9TVEFUSU9OOg0KLQkJaWYg
KGVuYWJsZSkgew0KKwkJaWYgKGVuYWJsZSAmJiAhaXNfbXQ3NjYzKCZkZXYtPm10NzYpKSB7DQog
CQkJc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YTsNCiAJCQlzdHJ1Y3QgbXQ3NjE1X3N0YSAqbXN0
YTsNCiANCi0tIA0KMi4yNS4xDQo=

