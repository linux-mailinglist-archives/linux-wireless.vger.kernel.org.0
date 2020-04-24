Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9961B7EF2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 21:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgDXTc5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 15:32:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57369 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725970AbgDXTcz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 15:32:55 -0400
X-UUID: 2b906e80d0444ad0a2b18bc1052980e0-20200425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=28kyiWh+DJyUahYzVncxWTlfyCRoL0b/vSUBaKQXca8=;
        b=u8YBCN/9pV035ApETabGjmU1qnn5eVeaAYrGBPU/TTRAi8w9cClf6Y7P/eUe8Wx50d+hK/lry/SrKh3BQIthL/rdXQFHyIvaYMS2/ws8Xy5PWesiO/uLOiNx8i0N/oWTyDQRqtwod5+bNnkJWtFp4bwEzcJzEni20j7fOQbOt4g=;
X-UUID: 2b906e80d0444ad0a2b18bc1052980e0-20200425
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 388193277; Sat, 25 Apr 2020 03:32:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 25 Apr 2020 03:32:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 25 Apr 2020 03:32:49 +0800
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
Subject: [PATCH v3 03/18] mt76: add Rx stats support for radiotap
Date:   Sat, 25 Apr 2020 03:32:24 +0800
Message-ID: <d3214ff0e88e7002db151364deceede0d2e5d889.1587756404.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1587756404.git.ryder.lee@mediatek.com>
References: <cover.1587756404.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2FE1901E1305162641D7C11B72595574A4AF624437F882A3DDE5620F69FCF0D02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SEUgZGVpdmNlcyBuZWVkIHRvIGFkZCBSeCByYWRpb3RhcCBoZWFkZXIuDQoNClNpZ25lZC1vZmYt
Ynk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL21lZGlhdGVrL210NzYvYWdnLXJ4LmMgICB8ICA0ICsrLS0NCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L21hYzgwMjExLmMgfCAgNiArKystLS0NCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaCAgICAgfCAxOSArKysrKysrKysrKysr
KysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9hZ2ct
cnguYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvYWdnLXJ4LmMNCmluZGV4
IGFjZGJlNmY4MjQ4ZC4uZGYyNWMwMGQ5ZTA2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9hZ2ctcnguYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni9hZ2ctcnguYw0KQEAgLTExOSw3ICsxMTksNyBAQCBzdGF0aWMgdm9pZA0K
IG10NzZfcnhfYWdncl9jaGVja19jdGwoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IHNrX2J1
ZmZfaGVhZCAqZnJhbWVzKQ0KIHsNCiAJc3RydWN0IG10NzZfcnhfc3RhdHVzICpzdGF0dXMgPSAo
c3RydWN0IG10NzZfcnhfc3RhdHVzICopc2tiLT5jYjsNCi0Jc3RydWN0IGllZWU4MDIxMV9iYXIg
KmJhciA9IChzdHJ1Y3QgaWVlZTgwMjExX2JhciAqKXNrYi0+ZGF0YTsNCisJc3RydWN0IGllZWU4
MDIxMV9iYXIgKmJhciA9IG10NzZfc2tiX2dldF9oZHIoc2tiKTsNCiAJc3RydWN0IG10NzZfd2Np
ZCAqd2NpZCA9IHN0YXR1cy0+d2NpZDsNCiAJc3RydWN0IG10NzZfcnhfdGlkICp0aWQ7DQogCXUx
NiBzZXFubzsNCkBAIC0xNDcsNyArMTQ3LDcgQEAgbXQ3Nl9yeF9hZ2dyX2NoZWNrX2N0bChzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgc2tfYnVmZl9oZWFkICpmcmFtZXMpDQogdm9pZCBtdDc2
X3J4X2FnZ3JfcmVvcmRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgc2tfYnVmZl9oZWFk
ICpmcmFtZXMpDQogew0KIAlzdHJ1Y3QgbXQ3Nl9yeF9zdGF0dXMgKnN0YXR1cyA9IChzdHJ1Y3Qg
bXQ3Nl9yeF9zdGF0dXMgKilza2ItPmNiOw0KLQlzdHJ1Y3QgaWVlZTgwMjExX2hkciAqaGRyID0g
KHN0cnVjdCBpZWVlODAyMTFfaGRyICopc2tiLT5kYXRhOw0KKwlzdHJ1Y3QgaWVlZTgwMjExX2hk
ciAqaGRyID0gbXQ3Nl9za2JfZ2V0X2hkcihza2IpOw0KIAlzdHJ1Y3QgbXQ3Nl93Y2lkICp3Y2lk
ID0gc3RhdHVzLT53Y2lkOw0KIAlzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqc3RhOw0KIAlzdHJ1Y3Qg
bXQ3Nl9yeF90aWQgKnRpZDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRp
YXRlay9tdDc2L21hYzgwMjExLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L21hYzgwMjExLmMNCmluZGV4IGYxMzExNGIwN2I2ZS4uZjY1ZTFiM2U4ZjdhIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tYWM4MDIxMS5jDQorKysgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L21hYzgwMjExLmMNCkBAIC03MjYsNyAr
NzI2LDcgQEAgbXQ3Nl9jaGVja19jY21wX3BuKHN0cnVjdCBza19idWZmICpza2IpDQogCQkgKiBW
YWxpZGF0ZSB0aGUgZmlyc3QgZnJhZ21lbnQgYm90aCBoZXJlIGFuZCBpbiBtYWM4MDIxMQ0KIAkJ
ICogQWxsIGZ1cnRoZXIgZnJhZ21lbnRzIHdpbGwgYmUgdmFsaWRhdGVkIGJ5IG1hYzgwMjExIG9u
bHkuDQogCQkgKi8NCi0JCWhkciA9IChzdHJ1Y3QgaWVlZTgwMjExX2hkciAqKXNrYi0+ZGF0YTsN
CisJCWhkciA9IG10NzZfc2tiX2dldF9oZHIoc2tiKTsNCiAJCWlmIChpZWVlODAyMTFfaXNfZnJh
ZyhoZHIpICYmDQogCQkgICAgIWllZWU4MDIxMV9pc19maXJzdF9mcmFnKGhkci0+ZnJhbWVfY29u
dHJvbCkpDQogCQkJcmV0dXJuIDA7DQpAQCAtNzk5LDcgKzc5OSw3IEBAIG10NzZfYWlydGltZV9m
bHVzaF9hbXBkdShzdHJ1Y3QgbXQ3Nl9kZXYgKmRldikNCiBzdGF0aWMgdm9pZA0KIG10NzZfYWly
dGltZV9jaGVjayhzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCiB7
DQotCXN0cnVjdCBpZWVlODAyMTFfaGRyICpoZHIgPSAoc3RydWN0IGllZWU4MDIxMV9oZHIgKilz
a2ItPmRhdGE7DQorCXN0cnVjdCBpZWVlODAyMTFfaGRyICpoZHIgPSBtdDc2X3NrYl9nZXRfaGRy
KHNrYik7DQogCXN0cnVjdCBtdDc2X3J4X3N0YXR1cyAqc3RhdHVzID0gKHN0cnVjdCBtdDc2X3J4
X3N0YXR1cyAqKXNrYi0+Y2I7DQogCXN0cnVjdCBtdDc2X3djaWQgKndjaWQgPSBzdGF0dXMtPndj
aWQ7DQogDQpAQCAtODM2LDcgKzgzNiw3IEBAIHN0YXRpYyB2b2lkDQogbXQ3Nl9jaGVja19zdGEo
c3RydWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdCBza19idWZmICpza2IpDQogew0KIAlzdHJ1Y3Qg
bXQ3Nl9yeF9zdGF0dXMgKnN0YXR1cyA9IChzdHJ1Y3QgbXQ3Nl9yeF9zdGF0dXMgKilza2ItPmNi
Ow0KLQlzdHJ1Y3QgaWVlZTgwMjExX2hkciAqaGRyID0gKHN0cnVjdCBpZWVlODAyMTFfaGRyICop
c2tiLT5kYXRhOw0KKwlzdHJ1Y3QgaWVlZTgwMjExX2hkciAqaGRyID0gbXQ3Nl9za2JfZ2V0X2hk
cihza2IpOw0KIAlzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqc3RhOw0KIAlzdHJ1Y3QgaWVlZTgwMjEx
X2h3ICpodzsNCiAJc3RydWN0IG10NzZfd2NpZCAqd2NpZCA9IHN0YXR1cy0+d2NpZDsNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYuaCBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3Ni5oDQppbmRleCBjZWJlZjUyZmI2ODUu
LmIyZTYxOWJhYjBlOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3Ni5oDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210
NzYuaA0KQEAgLTc0NCw2ICs3NDQsMjUgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgbXQ3Nl90eF9j
YiAqbXQ3Nl90eF9za2JfY2Ioc3RydWN0IHNrX2J1ZmYgKnNrYikNCiAJcmV0dXJuICgodm9pZCAq
KUlFRUU4MDIxMV9TS0JfQ0Ioc2tiKS0+c3RhdHVzLnN0YXR1c19kcml2ZXJfZGF0YSk7DQogfQ0K
IA0KK3N0YXRpYyBpbmxpbmUgdm9pZCAqbXQ3Nl9za2JfZ2V0X2hkcihzdHJ1Y3Qgc2tfYnVmZiAq
c2tiKQ0KK3sNCisJc3RydWN0IG10NzZfcnhfc3RhdHVzIG1zdGF0Ow0KKwl1OCAqZGF0YSA9IHNr
Yi0+ZGF0YTsNCisNCisJLyogQWxpZ25tZW50IGNvbmNlcm5zICovDQorCUJVSUxEX0JVR19PTihz
aXplb2Yoc3RydWN0IGllZWU4MDIxMV9yYWRpb3RhcF9oZSkgJSA0KTsNCisJQlVJTERfQlVHX09O
KHNpemVvZihzdHJ1Y3QgaWVlZTgwMjExX3JhZGlvdGFwX2hlX211KSAlIDQpOw0KKw0KKwltc3Rh
dCA9ICooKHN0cnVjdCBtdDc2X3J4X3N0YXR1cyAqKXNrYi0+Y2IpOw0KKw0KKwlpZiAobXN0YXQu
ZmxhZyAmIFJYX0ZMQUdfUkFESU9UQVBfSEUpDQorCQlkYXRhICs9IHNpemVvZihzdHJ1Y3QgaWVl
ZTgwMjExX3JhZGlvdGFwX2hlKTsNCisJaWYgKG1zdGF0LmZsYWcgJiBSWF9GTEFHX1JBRElPVEFQ
X0hFX01VKQ0KKwkJZGF0YSArPSBzaXplb2Yoc3RydWN0IGllZWU4MDIxMV9yYWRpb3RhcF9oZV9t
dSk7DQorDQorCXJldHVybiBkYXRhOw0KK30NCisNCiBzdGF0aWMgaW5saW5lIHZvaWQgbXQ3Nl9p
bnNlcnRfaGRyX3BhZChzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KIHsNCiAJaW50IGxlbiA9IGllZWU4
MDIxMV9nZXRfaGRybGVuX2Zyb21fc2tiKHNrYik7DQotLSANCjIuMTguMA0K

