Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97A1B4CC6
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgDVSjg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 14:39:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58378 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725648AbgDVSjg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 14:39:36 -0400
X-UUID: a803670f4c50418d9d5d2670264cbe66-20200423
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=23cwNfaGhhqL+PnOh1YFT8tP/y0EhVeeizW0SlUrSJo=;
        b=JG4TxcBXhZwPg1AhoGdviYX7W4NtXxidTf48h4nOhlLTz4OrrHMtHQ1SiLq4XyFwPXs+LOpSgyd9evaGw7Lo2SdpeG29veu3bLJXunJbl5Ss+Uxk/W3HDgdreqYF+z26H7XtJRo1/mqj/LAY8hJ9TpJf6kH0vbmToAWjjho3Zso=;
X-UUID: a803670f4c50418d9d5d2670264cbe66-20200423
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1107093250; Thu, 23 Apr 2020 02:39:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Apr 2020 02:39:27 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Apr 2020 02:39:20 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2] mt76: mt7663: fix up BMC entry indicated to unicmd firmware
Date:   Thu, 23 Apr 2020 02:39:20 +0800
Message-ID: <71a5733885991a8211104b616d2f51d120efccb9.1587580510.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3C479BEA1633D2955B3668A86E7F39C6192C47299CC315A46AF21B248DC1B4242000:8
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
Zi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KQ28tZGV2ZWxvcGVkLWJ5
OiBMb3JlbnpvIEJpYW5jb25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBM
b3JlbnpvIEJpYW5jb25pIDxsb3JlbnpvQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBTZWFu
IFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQotLQ0KdjEtPnYyOg0KbXQ3NjE1X21jdV91
bmlfYWRkX2JzcyBpcyBvbmx5IGNhbGxlZCBvbiBtdDc2NjMgd2l0aCB0aGUgb2ZmbG9hZCBmaXJt
d2FyZSwNCnNvIHJlbW92ZSB0aGUgZW50aXJlIHVubmVjZXNzYXJ5IGlmIGNvZGUgc2VjdGlvbi4N
Ci0tLQ0KIC4uLi9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMgICAgfCAx
OCArLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE3
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzYxNS9tY3UuYw0KaW5kZXggMjRiNzhkMTBkN2Y3Li45OTQ0NDZiMWJhYmEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0KKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCkBAIC0x
MzU5LDcgKzEzNTksNyBAQCBtdDc2MTVfbWN1X3VuaV9hZGRfYnNzKHN0cnVjdCBtdDc2MTVfcGh5
ICpwaHksDQogCQkJLnNob3J0X3N0ID0gdHJ1ZSwNCiAJCX0sDQogCX07DQotCXU4IGlkeCwgdHhf
d2xhbl9pZHggPSAwOw0KKwl1OCBpZHgsIHR4X3dsYW5faWR4ID0gbXZpZi0+c3RhLndjaWQuaWR4
Ow0KIAlpbnQgZXJyOw0KIA0KIAlpZHggPSBtdmlmLT5vbWFjX2lkeCA+IEVYVF9CU1NJRF9TVEFS
VCA/IEhXX0JTU0lEXzAgOiBtdmlmLT5vbWFjX2lkeDsNCkBAIC0xMzY5LDI0ICsxMzY5LDggQEAg
bXQ3NjE1X21jdV91bmlfYWRkX2JzcyhzdHJ1Y3QgbXQ3NjE1X3BoeSAqcGh5LA0KIAljYXNlIE5M
ODAyMTFfSUZUWVBFX01FU0hfUE9JTlQ6DQogCWNhc2UgTkw4MDIxMV9JRlRZUEVfQVA6DQogCQli
YXNpY19yZXEuYmFzaWMuY29ubl90eXBlID0gY3B1X3RvX2xlMzIoQ09OTkVDVElPTl9JTkZSQV9B
UCk7DQotCQl0eF93bGFuX2lkeCA9IG12aWYtPnN0YS53Y2lkLmlkeDsNCiAJCWJyZWFrOw0KIAlj
YXNlIE5MODAyMTFfSUZUWVBFX1NUQVRJT046DQotCQlpZiAoZW5hYmxlKSB7DQotCQkJc3RydWN0
IGllZWU4MDIxMV9zdGEgKnN0YTsNCi0JCQlzdHJ1Y3QgbXQ3NjE1X3N0YSAqbXN0YTsNCi0NCi0J
CQlyY3VfcmVhZF9sb2NrKCk7DQotCQkJc3RhID0gaWVlZTgwMjExX2ZpbmRfc3RhKHZpZiwgdmlm
LT5ic3NfY29uZi5ic3NpZCk7DQotCQkJaWYgKCFzdGEpIHsNCi0JCQkJcmN1X3JlYWRfdW5sb2Nr
KCk7DQotCQkJCXJldHVybiAtRUlOVkFMOw0KLQkJCX0NCi0NCi0JCQltc3RhID0gKHN0cnVjdCBt
dDc2MTVfc3RhICopc3RhLT5kcnZfcHJpdjsNCi0JCQl0eF93bGFuX2lkeCA9IG1zdGEtPndjaWQu
aWR4Ow0KLQkJCXJjdV9yZWFkX3VubG9jaygpOw0KLQkJfQ0KIAkJYmFzaWNfcmVxLmJhc2ljLmNv
bm5fdHlwZSA9IGNwdV90b19sZTMyKENPTk5FQ1RJT05fSU5GUkFfU1RBKTsNCiAJCWJyZWFrOw0K
IAlkZWZhdWx0Og0KLS0gDQoyLjI1LjENCg==

