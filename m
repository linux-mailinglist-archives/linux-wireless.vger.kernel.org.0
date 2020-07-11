Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369EA21C57E
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2020 19:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgGKRZ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jul 2020 13:25:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24386 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728507AbgGKRZ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jul 2020 13:25:59 -0400
X-UUID: b0c6d6c996fd4e42a3b9fd63c9ad292f-20200712
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KsPZrYh83BKh7NcfY83O8cMZ2ziWNuHaOaDclSXHB/Y=;
        b=FxOCxey2I4SzYJKmx8sRZuPR2qFnDRjNLnxrENsDc58fKydoHzkRQSL74kQQOjLsp8K24l0eOI4wJHGrU8OvAXJXZkAPxQD+j0oQzhfbJrN/MTGyje+bkyBuXovcJM9zo66naq4gi3D1iDE9KLPnspgGp94KZ9tXp6Intxw8BKM=;
X-UUID: b0c6d6c996fd4e42a3b9fd63c9ad292f-20200712
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 998760287; Sun, 12 Jul 2020 01:25:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 12 Jul 2020 01:25:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 12 Jul 2020 01:25:49 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix potential memory leak in mcu message handler
Date:   Sun, 12 Jul 2020 01:25:51 +0800
Message-ID: <4cced050b9b3dc4d1da2a15e38738ba80a30dac0.1594487923.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D7429033F07453C9D9C29E3419561C1A46274DDF38E6A64AE525150F343466A32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rml4IHBvdGVudGlhbCBtZW1vcnkgbGVhayBpbiBtY3UgbWVzc2FnZSBoYW5kbGVyIG9uIGVycm9y
IGNvbmRpdGlvbi4NCg0KRml4ZXM6IGM2YjAwMmJjZGZhNiAoIm10NzY6IGFkZCBtYWM4MDIxMSBk
cml2ZXIgZm9yIE1UNzkxNSBQQ0llLWJhc2VkIGNoaXBzZXRzIikNClNpZ25lZC1vZmYtYnk6IFJ5
ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jIHwgNyArKysrKy0tDQogMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCmluZGV4IGVlZDMyN2IwOWRkYi4u
YWIwODYyMmQxNzM2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9tdDc5MTUvbWN1LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L21jdS5jDQpAQCAtMzEyLDggKzMxMiwxMCBAQCBtdDc5MTVfbWN1X3BhcnNlX3Jl
c3BvbnNlKHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIGludCBjbWQsDQogCXN0cnVjdCBtdDc5MTVf
bWN1X3J4ZCAqcnhkID0gKHN0cnVjdCBtdDc5MTVfbWN1X3J4ZCAqKXNrYi0+ZGF0YTsNCiAJaW50
IHJldCA9IDA7DQogDQotCWlmIChzZXEgIT0gcnhkLT5zZXEpDQotCQlyZXR1cm4gLUVBR0FJTjsN
CisJaWYgKHNlcSAhPSByeGQtPnNlcSkgew0KKwkJcmV0ID0gLUVBR0FJTjsNCisJCWdvdG8gb3V0
Ow0KKwl9DQogDQogCXN3aXRjaCAoY21kKSB7DQogCWNhc2UgLU1DVV9DTURfUEFUQ0hfU0VNX0NP
TlRST0w6DQpAQCAtMzMwLDYgKzMzMiw3IEBAIG10NzkxNV9tY3VfcGFyc2VfcmVzcG9uc2Uoc3Ry
dWN0IG10NzkxNV9kZXYgKmRldiwgaW50IGNtZCwNCiAJZGVmYXVsdDoNCiAJCWJyZWFrOw0KIAl9
DQorb3V0Og0KIAlkZXZfa2ZyZWVfc2tiKHNrYik7DQogDQogCXJldHVybiByZXQ7DQotLSANCjIu
MTguMA0K

