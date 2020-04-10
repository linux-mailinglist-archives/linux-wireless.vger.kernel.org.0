Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9001F1A43FB
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 10:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgDJIy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 04:54:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48806 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725858AbgDJIy6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 04:54:58 -0400
X-UUID: ea57044bcd3e46b197d4ff8d22c73e06-20200410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w7xtRv8vlqO5EQ+J2L0Cx4x5jxri0BXKTgW3PSYCHdw=;
        b=mCL/Z9uoxozs2pt+ejawMVweJIJvNmm9CAKVt+/wTNY2gfG8MFmvXQ7dJ4CBxdsbuzZ/jNkFH+KtaCKffLkfHo73ot/4LsuX664Lchzw7Rex98vZBohPN1UgzeHTv4PM00fisVaciyJrqh6QXknPz2AgzYHHDQ+NA4Fv98PH+fs=;
X-UUID: ea57044bcd3e46b197d4ff8d22c73e06-20200410
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 180451673; Fri, 10 Apr 2020 16:54:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 10 Apr 2020 16:54:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Apr 2020 16:54:52 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 01/16] mt76: avoid rx reorder buffer overflow
Date:   Fri, 10 Apr 2020 16:54:38 +0800
Message-ID: <749e0b262ffe77a854d9d78b6eb833db77c96541.1586507878.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1586507878.git.ryder.lee@mediatek.com>
References: <cover.1586507878.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RW5sYXJnZSBzbG90IHRvIHN1cHBvcnQgMTFheCAyNTYgQkEgKDI1NiBNUERVcyBpbiBhbiBBTVBE
VSkNCg0KU2lnbmVkLW9mZi1ieTogQ2hpaC1NaW4gQ2hlbiA8Y2hpaC1taW4uY2hlbkBtZWRpYXRl
ay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2FnZy1yeC5jIHwgOCAr
KysrLS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oICAgfCA2
ICsrKy0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9hZ2ct
cnguYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvYWdnLXJ4LmMNCmluZGV4
IGY3N2YwMzUzMDI1OS4uYWNkYmU2ZjgyNDhkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9hZ2ctcnguYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9hZ2ctcnguYw0KQEAgLTE1Miw4ICsxNTIsOCBAQCB2b2lkIG10NzZfcnhf
YWdncl9yZW9yZGVyKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBza19idWZmX2hlYWQgKmZy
YW1lcykNCiAJc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YTsNCiAJc3RydWN0IG10NzZfcnhfdGlk
ICp0aWQ7DQogCWJvb2wgc25fbGVzczsNCi0JdTE2IHNlcW5vLCBoZWFkLCBzaXplOw0KLQl1OCBh
Y2twLCBpZHg7DQorCXUxNiBzZXFubywgaGVhZCwgc2l6ZSwgaWR4Ow0KKwl1OCBhY2twOw0KIA0K
IAlfX3NrYl9xdWV1ZV90YWlsKGZyYW1lcywgc2tiKTsNCiANCkBAIC0yMzksNyArMjM5LDcgQEAg
dm9pZCBtdDc2X3J4X2FnZ3JfcmVvcmRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgc2tf
YnVmZl9oZWFkICpmcmFtZXMpDQogfQ0KIA0KIGludCBtdDc2X3J4X2FnZ3Jfc3RhcnQoc3RydWN0
IG10NzZfZGV2ICpkZXYsIHN0cnVjdCBtdDc2X3djaWQgKndjaWQsIHU4IHRpZG5vLA0KLQkJICAg
ICAgIHUxNiBzc24sIHU4IHNpemUpDQorCQkgICAgICAgdTE2IHNzbiwgdTE2IHNpemUpDQogew0K
IAlzdHJ1Y3QgbXQ3Nl9yeF90aWQgKnRpZDsNCiANCkBAIC0yNjQsNyArMjY0LDcgQEAgRVhQT1JU
X1NZTUJPTF9HUEwobXQ3Nl9yeF9hZ2dyX3N0YXJ0KTsNCiANCiBzdGF0aWMgdm9pZCBtdDc2X3J4
X2FnZ3Jfc2h1dGRvd24oc3RydWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdCBtdDc2X3J4X3RpZCAq
dGlkKQ0KIHsNCi0JdTggc2l6ZSA9IHRpZC0+c2l6ZTsNCisJdTE2IHNpemUgPSB0aWQtPnNpemU7
DQogCWludCBpOw0KIA0KIAlzcGluX2xvY2tfYmgoJnRpZC0+bG9jayk7DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmggYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaA0KaW5kZXggZTMxZDk4YTRmODhmLi4zNmZlMTYz
ODg5YjggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzYuaA0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2LmgNCkBA
IC0yNDQsOCArMjQ0LDggQEAgc3RydWN0IG10NzZfcnhfdGlkIHsNCiAJc3RydWN0IGRlbGF5ZWRf
d29yayByZW9yZGVyX3dvcms7DQogDQogCXUxNiBoZWFkOw0KLQl1OCBzaXplOw0KLQl1OCBuZnJh
bWVzOw0KKwl1MTYgc2l6ZTsNCisJdTE2IG5mcmFtZXM7DQogDQogCXU4IG51bTsNCiANCkBAIC03
OTQsNyArNzk0LDcgQEAgaW50IG10NzZfZ2V0X3N1cnZleShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpo
dywgaW50IGlkeCwNCiB2b2lkIG10NzZfc2V0X3N0cmVhbV9jYXBzKHN0cnVjdCBtdDc2X2RldiAq
ZGV2LCBib29sIHZodCk7DQogDQogaW50IG10NzZfcnhfYWdncl9zdGFydChzdHJ1Y3QgbXQ3Nl9k
ZXYgKmRldiwgc3RydWN0IG10NzZfd2NpZCAqd2NpZCwgdTggdGlkLA0KLQkJICAgICAgIHUxNiBz
c24sIHU4IHNpemUpOw0KKwkJICAgICAgIHUxNiBzc24sIHUxNiBzaXplKTsNCiB2b2lkIG10NzZf
cnhfYWdncl9zdG9wKHN0cnVjdCBtdDc2X2RldiAqZGV2LCBzdHJ1Y3QgbXQ3Nl93Y2lkICp3Y2lk
LCB1OCB0aWQpOw0KIA0KIHZvaWQgbXQ3Nl93Y2lkX2tleV9zZXR1cChzdHJ1Y3QgbXQ3Nl9kZXYg
KmRldiwgc3RydWN0IG10NzZfd2NpZCAqd2NpZCwNCi0tIA0KMi4xOC4wDQo=

