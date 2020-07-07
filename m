Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F422177C1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2020 21:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgGGTRA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jul 2020 15:17:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54265 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728840AbgGGTRA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jul 2020 15:17:00 -0400
X-UUID: c58ddb599a124722be53072fa746300f-20200708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/WUA0+LRnFB+TGhQ0pQghsVlxdUXTpYr3oN8/7I5g/Q=;
        b=jq25Rx78OWmVL8dfMgMH6EC3GVo+o3TDtNV/N3OHzq4cg5i60vEzakcRsCHsn1StDTMCvy3ZrYcatUO/WxSi3GhZZYcAWm6kEY0Kt7AXdQaeGQbnI1UV9cZigVZ/aBSxRB+vGe0P60qTSJKgeV8jJr7mYAqOKKhsXOFgOUAOvtw=;
X-UUID: c58ddb599a124722be53072fa746300f-20200708
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1886084432; Wed, 08 Jul 2020 03:16:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Jul 2020 03:16:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jul 2020 03:16:46 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 3/3] mt76: mt7615: fix potential memory leak in mcu message handler
Date:   Wed, 8 Jul 2020 03:16:48 +0800
Message-ID: <1d14e3065c4cae75ac8c91fcedd5af80f8282413.1594148548.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <57b81f8efe7e767616a0d5957728756cbfdfa235.1594148548.git.sean.wang@mediatek.com>
References: <57b81f8efe7e767616a0d5957728756cbfdfa235.1594148548.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpGaXggcG90ZW50aWFs
IG1lbW9yeSBsZWFrIGluIG1jdSBtZXNzYWdlIGhhbmRsZXIgb24gZXJyb3IgY29uZGl0aW9uLg0K
DQp2MSAtPiB2MjoNCiAgICAgICAgLSBhZGQgQWNrZWQtYnkgdGFnDQoNCkZpeGVzOiAwZTZhMjll
NDc3ZjMgKCJtdDc2OiBtdDc2MTU6IGFkZCBzdXBwb3J0IHRvIHJlYWQgdGVtcGVyYXR1cmUgZnJv
bSBtY3UiKQ0KQWNrZWQtYnk6IExvcmVuem8gQmlhbmNvbmkgPGxvcmVuem9Aa2VybmVsLm9yZz4N
ClNpZ25lZC1vZmYtYnk6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jIHwgNyArKysr
Ky0tDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21j
dS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCmlu
ZGV4IDFiNDZjY2NkOTNjNS4uNThlMzgzOGEzZGJhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jDQpAQCAtMTgzLDggKzE4MywxMCBAQCBt
dDc2MTVfbWN1X3BhcnNlX3Jlc3BvbnNlKHN0cnVjdCBtdDc2MTVfZGV2ICpkZXYsIGludCBjbWQs
DQogCXN0cnVjdCBtdDc2MTVfbWN1X3J4ZCAqcnhkID0gKHN0cnVjdCBtdDc2MTVfbWN1X3J4ZCAq
KXNrYi0+ZGF0YTsNCiAJaW50IHJldCA9IDA7DQogDQotCWlmIChzZXEgIT0gcnhkLT5zZXEpDQot
CQlyZXR1cm4gLUVBR0FJTjsNCisJaWYgKHNlcSAhPSByeGQtPnNlcSkgew0KKwkJcmV0ID0gLUVB
R0FJTjsNCisJCWdvdG8gb3V0Ow0KKwl9DQogDQogCXN3aXRjaCAoY21kKSB7DQogCWNhc2UgTUNV
X0NNRF9QQVRDSF9TRU1fQ09OVFJPTDoNCkBAIC0yMTUsNiArMjE3LDcgQEAgbXQ3NjE1X21jdV9w
YXJzZV9yZXNwb25zZShzdHJ1Y3QgbXQ3NjE1X2RldiAqZGV2LCBpbnQgY21kLA0KIAlkZWZhdWx0
Og0KIAkJYnJlYWs7DQogCX0NCitvdXQ6DQogCWRldl9rZnJlZV9za2Ioc2tiKTsNCiANCiAJcmV0
dXJuIHJldDsNCi0tIA0KMi4yNS4xDQo=

