Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6118277575
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 17:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgIXPde (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 11:33:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39954 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728139AbgIXPde (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 11:33:34 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 11:33:34 EDT
X-UUID: b32ec940a2b24fc38ef2cb1e11ff6c4c-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LmgvGuej7fW84C6X2+Aw7a3cm/HXAiGlJjhjzE8CYXs=;
        b=F1BHQVqCB4ed24ksXq9kknq6dbMu5Y1MSajP+aCOKBDSrgAgX8MTDuiU7pwykgsE1ZZSVEQee4oeBk1SIkJO3iFrDyq59IaRwj+TzJ0ps+SM61QDqajOQFOv5AKfzTXCqwMidvQhYCQ8PR5anwBDRP5ljWBe6GDox/wOKQjwtWA=;
X-UUID: b32ec940a2b24fc38ef2cb1e11ff6c4c-20200924
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2104916421; Thu, 24 Sep 2020 23:23:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 23:23:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 23:23:14 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7915: fix VHT LDPC capability
Date:   Thu, 24 Sep 2020 23:23:14 +0800
Message-ID: <891f34b8f6b9bf16413514ee054e6e6185e0f12c.1600960534.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <670fe8dcb9e1308041047718af241225ff5614bb.1600960534.git.ryder.lee@mediatek.com>
References: <670fe8dcb9e1308041047718af241225ff5614bb.1600960534.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EBBF17836A4C1B03E52A209B24B98C02C15AE1D64FD20977D621CF462077636E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhlIE1DVSBmaWVsZCBzaG91bGQgY29udGFpbiBhIGJvb2xlYW4gMC8xLCBub3QgdGhlIGZsYWcg
aXRzZWxmLg0KDQpTaWduZWQtb2ZmLWJ5OiBGZWxpeCBGaWV0a2F1IDxuYmRAbmJkLm5hbWU+DQpT
aWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCmh0
dHBzOi8vZ2l0aHViLmNvbS9vcGVud3J0L210NzYvY29tbWl0L2IxZjQyNTY4NjEyNTE0OWViNTg1
ZDVjM2UwNWY5NmExZjdkYWIyZGINCi0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTE1L21jdS5jIHwgNiArKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L210NzkxNS9tY3UuYw0KaW5kZXggZTU0NDU0ZmMwNWI5Li5hNTRlYjgzMWMwYTUg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzkxNS9t
Y3UuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1
LmMNCkBAIC0xNjYyLDcgKzE2NjIsNyBAQCBtdDc5MTVfbWN1X3d0YmxfaHRfdGx2KHN0cnVjdCBz
a19idWZmICpza2IsIHN0cnVjdCBpZWVlODAyMTFfc3RhICpzdGEsDQogCQl0bHYgPSBtdDc5MTVf
bWN1X2FkZF9uZXN0ZWRfdGx2KHNrYiwgV1RCTF9IVCwgc2l6ZW9mKCpodCksDQogCQkJCQkJd3Ri
bF90bHYsIHN0YV93dGJsKTsNCiAJCWh0ID0gKHN0cnVjdCB3dGJsX2h0ICopdGx2Ow0KLQkJaHQt
PmxkcGMgPSBzdGEtPmh0X2NhcC5jYXAgJiBJRUVFODAyMTFfSFRfQ0FQX0xEUENfQ09ESU5HOw0K
KwkJaHQtPmxkcGMgPSAhIShzdGEtPmh0X2NhcC5jYXAgJiBJRUVFODAyMTFfSFRfQ0FQX0xEUENf
Q09ESU5HKTsNCiAJCWh0LT5hZiA9IHN0YS0+aHRfY2FwLmFtcGR1X2ZhY3RvcjsNCiAJCWh0LT5t
bSA9IHN0YS0+aHRfY2FwLmFtcGR1X2RlbnNpdHk7DQogCQlodC0+aHQgPSB0cnVlOw0KQEAgLTE2
NzYsNyArMTY3Niw3IEBAIG10NzkxNV9tY3Vfd3RibF9odF90bHYoc3RydWN0IHNrX2J1ZmYgKnNr
Yiwgc3RydWN0IGllZWU4MDIxMV9zdGEgKnN0YSwNCiAJCXRsdiA9IG10NzkxNV9tY3VfYWRkX25l
c3RlZF90bHYoc2tiLCBXVEJMX1ZIVCwgc2l6ZW9mKCp2aHQpLA0KIAkJCQkJCXd0YmxfdGx2LCBz
dGFfd3RibCk7DQogCQl2aHQgPSAoc3RydWN0IHd0Ymxfdmh0ICopdGx2Ow0KLQkJdmh0LT5sZHBj
ID0gc3RhLT52aHRfY2FwLmNhcCAmIElFRUU4MDIxMV9WSFRfQ0FQX1JYTERQQywNCisJCXZodC0+
bGRwYyA9ICEhKHN0YS0+dmh0X2NhcC5jYXAgJiBJRUVFODAyMTFfVkhUX0NBUF9SWExEUEMpOw0K
IAkJdmh0LT52aHQgPSB0cnVlOw0KIA0KIAkJYWYgPSBGSUVMRF9HRVQoSUVFRTgwMjExX1ZIVF9D
QVBfTUFYX0FfTVBEVV9MRU5HVEhfRVhQT05FTlRfTUFTSywNCkBAIC0yODU4LDcgKzI4NTgsNyBA
QCBpbnQgbXQ3OTE1X21jdV9pbml0KHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYpDQogCX07DQogCWlu
dCByZXQ7DQogDQotCWRldi0+bXQ3Ni5tY3Vfb3BzID0gJm10NzkxNV9tY3Vfb3BzLA0KKwlkZXYt
Pm10NzYubWN1X29wcyA9ICZtdDc5MTVfbWN1X29wczsNCiANCiAJcmV0ID0gbXQ3OTE1X2RyaXZl
cl9vd24oZGV2KTsNCiAJaWYgKHJldCkNCi0tIA0KMi4xOC4wDQo=

