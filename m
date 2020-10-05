Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BB1283BC5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Oct 2020 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgJEP6C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Oct 2020 11:58:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45976 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbgJEP6C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Oct 2020 11:58:02 -0400
X-UUID: 3659ad1a2af2496db2ae31592f658f0d-20201005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=778ghGkMZz72jTLXw73LJtRp6+PZ+82zSbj3perVHWo=;
        b=qIeYfWWhGE+N3tZUMMudrSlYcsu4L11jq0fGVksKJJ8leSpBP0nBDZB2a5CSEWV/GnXPlmd+6Bqtgdleg+pzcW4bG6Bi60yY1Vh5I29vEfivEkj9Kzw0+jhg8eJivmClkr4VJopjAGcbCa4pcCjU2vHP1YhpS3ExhWfd70H9tHU=;
X-UUID: 3659ad1a2af2496db2ae31592f658f0d-20201005
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 494021052; Mon, 05 Oct 2020 23:57:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Oct 2020 23:57:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Oct 2020 23:57:55 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7915: rename mt7915_mcu_get_rate_info to mt7915_mcu_get_tx_rate
Date:   Mon, 5 Oct 2020 23:57:53 +0800
Message-ID: <01543bd6f88eb9420d327a06b5f066c6721c5c2a.1601913208.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <b381936001c1d62e520283b83d5492bdcdd5cf4f.1601913208.git.ryder.lee@mediatek.com>
References: <b381936001c1d62e520283b83d5492bdcdd5cf4f.1601913208.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QXZvaWQgY29uZnVzaW9uIHdpdGggcnggcmF0ZSBxdWVyeSBmdW5jdGlvbi4NCg0KU2lnbmVkLW9m
Zi1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMgICAgfCAgMiArLQ0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jICAgIHwgMTAgKysrKyst
LS0tLQ0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210NzkxNS5o
IHwgIDIgKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3
OTE1L21hYy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFj
LmMNCmluZGV4IGE3MTE4ZGY3YjkzZi4uNTIxZDBjMmY2YzI1IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWFjLmMNCisrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21hYy5jDQpAQCAtMTQyMiw3ICsxNDIy
LDcgQEAgbXQ3OTE1X21hY19zdGFfc3RhdHNfd29yayhzdHJ1Y3QgbXQ3OTE1X3BoeSAqcGh5KQ0K
IAkJc3Bpbl91bmxvY2tfYmgoJmRldi0+c3RhX3BvbGxfbG9jayk7DQogDQogCQkvKiB1c2UgTVRf
VFhfRlJFRV9SQVRFIHRvIHJlcG9ydCBUeCByYXRlIGZvciBmdXJ0aGVyIGRldmljZXMgKi8NCi0J
CW10NzkxNV9tY3VfZ2V0X3JhdGVfaW5mbyhkZXYsIFJBVEVfQ1RSTF9SVV9JTkZPLCBtc3RhLT53
Y2lkLmlkeCk7DQorCQltdDc5MTVfbWN1X2dldF90eF9yYXRlKGRldiwgUkFURV9DVFJMX1JVX0lO
Rk8sIG1zdGEtPndjaWQuaWR4KTsNCiANCiAJCXNwaW5fbG9ja19iaCgmZGV2LT5zdGFfcG9sbF9s
b2NrKTsNCiAJfQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3OTE1L21jdS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5
MTUvbWN1LmMNCmluZGV4IGY0MmE1NGNkOGQ0NS4uMDE2MzExNjM5YzI0IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCisrKyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQpAQCAtNDIyLDgg
KzQyMiw4IEBAIG10NzkxNV9tY3VfcnhfcmFkYXJfZGV0ZWN0ZWQoc3RydWN0IG10NzkxNV9kZXYg
KmRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCiB9DQogDQogc3RhdGljIHZvaWQNCi1tdDc5MTVf
bWN1X3R4X3JhdGVfY2FsKHN0cnVjdCBtdDc2X3BoeSAqbXBoeSwgc3RydWN0IG10NzkxNV9tY3Vf
cmFfaW5mbyAqcmEsDQotCQkgICAgICAgc3RydWN0IHJhdGVfaW5mbyAqcmF0ZSwgdTE2IHIpDQor
bXQ3OTE1X21jdV90eF9yYXRlX3BhcnNlKHN0cnVjdCBtdDc2X3BoeSAqbXBoeSwgc3RydWN0IG10
NzkxNV9tY3VfcmFfaW5mbyAqcmEsDQorCQkJIHN0cnVjdCByYXRlX2luZm8gKnJhdGUsIHUxNiBy
KQ0KIHsNCiAJc3RydWN0IGllZWU4MDIxMV9zdXBwb3J0ZWRfYmFuZCAqc2JhbmQ7DQogCXUxNiBy
dV9pZHggPSBsZTE2X3RvX2NwdShyYS0+cnVfaWR4KTsNCkBAIC01MzUsMTEgKzUzNSwxMSBAQCBt
dDc5MTVfbWN1X3R4X3JhdGVfcmVwb3J0KHN0cnVjdCBtdDc5MTVfZGV2ICpkZXYsIHN0cnVjdCBz
a19idWZmICpza2IpDQogCQltcGh5ID0gZGV2LT5tdDc2LnBoeTI7DQogDQogCS8qIGN1cnJlbnQg
cmF0ZSAqLw0KLQltdDc5MTVfbWN1X3R4X3JhdGVfY2FsKG1waHksIHJhLCAmcmF0ZSwgY3Vycik7
DQorCW10NzkxNV9tY3VfdHhfcmF0ZV9wYXJzZShtcGh5LCByYSwgJnJhdGUsIGN1cnIpOw0KIAlz
dGF0cy0+dHhfcmF0ZSA9IHJhdGU7DQogDQogCS8qIHByb2JpbmcgcmF0ZSAqLw0KLQltdDc5MTVf
bWN1X3R4X3JhdGVfY2FsKG1waHksIHJhLCAmcHJvYl9yYXRlLCBwcm9iZSk7DQorCW10NzkxNV9t
Y3VfdHhfcmF0ZV9wYXJzZShtcGh5LCByYSwgJnByb2JfcmF0ZSwgcHJvYmUpOw0KIAlzdGF0cy0+
cHJvYl9yYXRlID0gcHJvYl9yYXRlOw0KIA0KIAlpZiAoYXR0ZW1wdHMpIHsNCkBAIC0zMzE2LDcg
KzMzMTYsNyBAQCBpbnQgbXQ3OTE1X21jdV9nZXRfdGVtcGVyYXR1cmUoc3RydWN0IG10NzkxNV9k
ZXYgKmRldiwgaW50IGluZGV4KQ0KIAkJCQkgICBzaXplb2YocmVxKSwgdHJ1ZSk7DQogfQ0KIA0K
LWludCBtdDc5MTVfbWN1X2dldF9yYXRlX2luZm8oc3RydWN0IG10NzkxNV9kZXYgKmRldiwgdTMy
IGNtZCwgdTE2IHdsYW5faWR4KQ0KK2ludCBtdDc5MTVfbWN1X2dldF90eF9yYXRlKHN0cnVjdCBt
dDc5MTVfZGV2ICpkZXYsIHUzMiBjbWQsIHUxNiB3bGFuX2lkeCkNCiB7DQogCXN0cnVjdCB7DQog
CQlfX2xlMzIgY21kOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVr
L210NzYvbXQ3OTE1L210NzkxNS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3
Ni9tdDc5MTUvbXQ3OTE1LmgNCmluZGV4IDI5MjA3NWQzZjBkYS4uODFjMDQ0MGZkMGE1IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbXQ3OTE1
LmgNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L210Nzkx
NS5oDQpAQCAtMzE5LDcgKzMxOSw3IEBAIGludCBtdDc5MTVfbWN1X3NldF9wdWxzZV90aChzdHJ1
Y3QgbXQ3OTE1X2RldiAqZGV2LA0KIAkJCSAgICBjb25zdCBzdHJ1Y3QgbXQ3OTE1X2Rmc19wdWxz
ZSAqcHVsc2UpOw0KIGludCBtdDc5MTVfbWN1X3NldF9yYWRhcl90aChzdHJ1Y3QgbXQ3OTE1X2Rl
diAqZGV2LCBpbnQgaW5kZXgsDQogCQkJICAgIGNvbnN0IHN0cnVjdCBtdDc5MTVfZGZzX3BhdHRl
cm4gKnBhdHRlcm4pOw0KLWludCBtdDc5MTVfbWN1X2dldF9yYXRlX2luZm8oc3RydWN0IG10Nzkx
NV9kZXYgKmRldiwgdTMyIGNtZCwgdTE2IHdsYW5faWR4KTsNCitpbnQgbXQ3OTE1X21jdV9nZXRf
dHhfcmF0ZShzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCB1MzIgY21kLCB1MTYgd2xhbl9pZHgpOw0K
IGludCBtdDc5MTVfbWN1X2dldF90ZW1wZXJhdHVyZShzdHJ1Y3QgbXQ3OTE1X2RldiAqZGV2LCBp
bnQgaW5kZXgpOw0KIGludCBtdDc5MTVfbWN1X3JkZF9jbWQoc3RydWN0IG10NzkxNV9kZXYgKmRl
diwgZW51bSBtdDc5MTVfcmRkX2NtZCBjbWQsDQogCQkgICAgICAgdTggaW5kZXgsIHU4IHJ4X3Nl
bCwgdTggdmFsKTsNCi0tIA0KMi4xOC4wDQo=

