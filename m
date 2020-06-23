Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0713204AFA
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgFWH1P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 03:27:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32222 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731145AbgFWH1P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 03:27:15 -0400
X-UUID: e71a3a78342f4b7c851cead62a4928cf-20200623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AmTtxgjJJqlpgIBCkHW6b+asXc8NJTfuHQ0UTXoQ8Kc=;
        b=JqScRjgNgH02QytFICUfas7JJefBLhvTSXIqlUymRDfyl8Vi1F6Bf4Cg9kXPz4n1TN7j5bmuzCTtncMo8rgV4suBX6Eln3K9p7F/v+DdMpT2QEJthYMdANi+TczYP4/l29mXHjJgGhwAfx6jfl63hflsSBKPl2JVAh/7blT+tnU=;
X-UUID: e71a3a78342f4b7c851cead62a4928cf-20200623
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2086534945; Tue, 23 Jun 2020 15:27:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Jun 2020 15:26:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Jun 2020 15:26:58 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: remove unused parameters in mt7915_puts_rate_txpower()
Date:   Tue, 23 Jun 2020 15:26:44 +0800
Message-ID: <20200623072644.15713-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A7ABA8D085CB36C85595EA289AD50EA6BCFE3B40605EAB6508A8BC5EDC68B8832000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U2ltcGxpZnkgYW5kIHJlbW92ZSB1bnVzZWQgcGFyYW1ldGVycyBpbiBtdDc5MTVfcHV0c19yYXRl
X3R4cG93ZXIoKQ0KZnVuY3Rpb24uDQoNClNpZ25lZC1vZmYtYnk6IFNoYXluZSBDaGVuIDxzaGF5
bmUuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCkBGZWxpeCwgcGxlYXNlIGZvbGQgdGhpcyBpbnRv
IDUzODU1NjNiMSBtdDc2OiBtdDc5MTU6IGRpcmVjdGx5IHJlYWQNCnBlci1yYXRlIHR4IHBvd2Vy
IGZyb20gcmVnaXN0ZXJzLCB0aGFua3MuDQotLS0NCiAuLi4vd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvZGVidWdmcy5jICAgfCAyNyArKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvZGVidWdmcy5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvZGVidWdmcy5jDQppbmRleCA5
MmFmZmQ0Li4wMzMxYzQ5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0
ZWsvbXQ3Ni9tdDc5MTUvZGVidWdmcy5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9kZWJ1Z2ZzLmMNCkBAIC0zMDAsOCArMzAwLDcgQEAgbXQ3OTE1X3F1
ZXVlc19yZWFkKHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqZGF0YSkNCiB9DQogDQogc3RhdGlj
IHZvaWQNCi1tdDc5MTVfcHV0c19yYXRlX3R4cG93ZXIoc3RydWN0IHNlcV9maWxlICpzLCBzdHJ1
Y3QgbXQ3OTE1X2RldiAqZGV2LA0KLQkJCSBpbnQgYmFuZCwgYm9vbCBleHRfcGh5KQ0KK210Nzkx
NV9wdXRzX3JhdGVfdHhwb3dlcihzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHN0cnVjdCBtdDc5MTVfcGh5
ICpwaHkpDQogew0KIAlzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHNrdV9ncm91cF9uYW1lW10g
PSB7DQogCQkiQ0NLIiwgIk9GRE0iLCAiSFQyMCIsICJIVDQwIiwNCkBAIC0zMDksOSArMzA4LDE3
IEBAIG10NzkxNV9wdXRzX3JhdGVfdHhwb3dlcihzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHN0cnVjdCBt
dDc5MTVfZGV2ICpkZXYsDQogCQkiUlUyNiIsICJSVTUyIiwgIlJVMTA2IiwgIlJVMjQyL1NVMjAi
LA0KIAkJIlJVNDg0L1NVNDAiLCAiUlU5OTYvU1U4MCIsICJSVTJ4OTk2L1NVMTYwIg0KIAl9Ow0K
LQl1MzIgcmVnX2Jhc2UgPSBNVF9UTUFDX0ZQMFIwKGV4dF9waHkpOw0KKwlzdHJ1Y3QgbXQ3OTE1
X2RldiAqZGV2ID0gZGV2X2dldF9kcnZkYXRhKHMtPnByaXZhdGUpOw0KKwlib29sIGV4dF9waHkg
PSBwaHkgIT0gJmRldi0+cGh5Ow0KKwl1MzIgcmVnX2Jhc2U7DQogCWludCBpLCBpZHggPSAwOw0K
IA0KKwlpZiAoIXBoeSkNCisJCXJldHVybjsNCisNCisJcmVnX2Jhc2UgPSBNVF9UTUFDX0ZQMFIw
KGV4dF9waHkpOw0KKwlzZXFfcHJpbnRmKHMsICJcbkJhbmQgJWRcbiIsIGV4dF9waHkpOw0KKw0K
IAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShtdDc5MTVfc2t1X2dyb3VwX2xlbik7IGkrKykg
ew0KIAkJdTggY250LCBtY3NfbnVtID0gbXQ3OTE1X3NrdV9ncm91cF9sZW5baV07DQogCQlzOCB0
eHBvd2VyWzEyXTsNCkBAIC0zNTYsMTkgKzM2Myw5IEBAIHN0YXRpYyBpbnQNCiBtdDc5MTVfcmVh
ZF9yYXRlX3R4cG93ZXIoc3RydWN0IHNlcV9maWxlICpzLCB2b2lkICpkYXRhKQ0KIHsNCiAJc3Ry
dWN0IG10NzkxNV9kZXYgKmRldiA9IGRldl9nZXRfZHJ2ZGF0YShzLT5wcml2YXRlKTsNCi0Jc3Ry
dWN0IG10NzZfcGh5ICptcGh5ID0gJmRldi0+bXBoeTsNCi0JZW51bSBubDgwMjExX2JhbmQgYmFu
ZCA9IG1waHktPmNoYW5kZWYuY2hhbi0+YmFuZDsNCi0NCi0Jc2VxX3B1dHMocywgIkJhbmQgMDog
KHVuaXQ6IDAuNSBkQm0pXG4iKTsNCi0JbXQ3OTE1X3B1dHNfcmF0ZV90eHBvd2VyKHMsIGRldiwg
YmFuZCwgZmFsc2UpOw0KIA0KLQlpZiAoZGV2LT5tdDc2LnBoeTIpIHsNCi0JCW1waHkgPSBkZXYt
Pm10NzYucGh5MjsNCi0JCWJhbmQgPSBtcGh5LT5jaGFuZGVmLmNoYW4tPmJhbmQ7DQotDQotCQlz
ZXFfcHV0cyhzLCAiQmFuZCAxOiAodW5pdDogMC41IGRCbSlcbiIpOw0KLQkJbXQ3OTE1X3B1dHNf
cmF0ZV90eHBvd2VyKHMsIGRldiwgYmFuZCwgdHJ1ZSk7DQotCX0NCisJbXQ3OTE1X3B1dHNfcmF0
ZV90eHBvd2VyKHMsICZkZXYtPnBoeSk7DQorCW10NzkxNV9wdXRzX3JhdGVfdHhwb3dlcihzLCBt
dDc5MTVfZXh0X3BoeShkZXYpKTsNCiANCiAJcmV0dXJuIDA7DQogfQ0KLS0gDQoyLjE3LjENCg==

