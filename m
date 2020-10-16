Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35BC28FC0D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Oct 2020 02:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgJPA06 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Oct 2020 20:26:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38567 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731772AbgJPA06 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Oct 2020 20:26:58 -0400
X-UUID: 2761c0ee11e04572a0c7e3eba0ab2612-20201016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fbeyHcPr5HXFs3nWVr8l+SD2fzx2BPv1Slq4oYY7jSo=;
        b=q36OKirF3GRFv3T8lXvnREY0zhLM3Q1ELz9mHYtqnzhvVgGlpqtuUeJB0/FBkg+yzzN+Uh/j3gnBoZT2FouPn82wrQbwJb7AVbWNZYOYbF0KLP1l6XhBBQbxk+KaX+phW6urUNRjiFWbdP+NDo09kuWfMEzlplVPB3LUJe7i4SE=;
X-UUID: 2761c0ee11e04572a0c7e3eba0ab2612-20201016
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 377058225; Fri, 16 Oct 2020 08:26:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Oct 2020 08:26:48 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Oct 2020 08:26:48 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, Sean Wang <objelf@gmail.com>,
        YN Chen <YN.Chen@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7663s: introduce WoW support via GPIO
Date:   Fri, 16 Oct 2020 08:26:42 +0800
Message-ID: <e83ee8b209124306f3f62e85823d7f0e30721b26.1602807276.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <267346a9a9c5f71caec03292b6c33b39864b38c5.1602807276.git.objelf@gmail.com>
References: <267346a9a9c5f71caec03292b6c33b39864b38c5.1602807276.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 48CCB54E6685AF6484C239E9F170579B5A1571F1DB198B59D7F6A4180DD6FDDB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxvYmplbGZAZ21haWwuY29tPg0KDQpTRElPLWJhc2VkIFdpRmkgd291
bGQgcmVseSBvbiBhbiBhZGRpdGlvbmFsIEdQSU8gcGluIHRvIHdha2UgdXAgdGhlIGhvc3QuDQoN
CkNvLWRldmVsb3BlZC1ieTogWU4gQ2hlbiA8WU4uQ2hlbkBtZWRpYXRlay5jb20+DQpTaWduZWQt
b2ZmLWJ5OiBZTiBDaGVuIDxZTi5DaGVuQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6ICBT
ZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYyB8IDE0ICsrKysrKysrKysrKy0tDQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmggfCAxNiArKysrKysr
KysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9t
dDc2MTUvbWN1LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9t
Y3UuYw0KaW5kZXggYzk5MGNjZDZmNDcyLi5lY2Y2YzYxNjVlNzIgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYw0KKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvbWN1LmMNCkBAIC0zNTI1LDYgKzM1
MjUsOCBAQCBpbnQgbXQ3NjE1X21jdV9zZXRfaGlmX3N1c3BlbmQoc3RydWN0IG10NzYxNV9kZXYg
KmRldiwgYm9vbCBzdXNwZW5kKQ0KIAkJcmVxLmhkci5oaWZfdHlwZSA9IDI7DQogCWVsc2UgaWYg
KG10NzZfaXNfdXNiKCZkZXYtPm10NzYpKQ0KIAkJcmVxLmhkci5oaWZfdHlwZSA9IDE7DQorCWVs
c2UgaWYgKG10NzZfaXNfc2RpbygmZGV2LT5tdDc2KSkNCisJCXJlcS5oZHIuaGlmX3R5cGUgPSAw
Ow0KIA0KIAlyZXR1cm4gbXQ3Nl9tY3Vfc2VuZF9tc2coJmRldi0+bXQ3NiwgTUNVX1VOSV9DTURf
SElGX0NUUkwsICZyZXEsDQogCQkJCSBzaXplb2YocmVxKSwgdHJ1ZSk7DQpAQCAtMzU0Myw2ICsz
NTQ1LDcgQEAgbXQ3NjE1X21jdV9zZXRfd293X2N0cmwoc3RydWN0IG10NzYxNV9waHkgKnBoeSwg
c3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwNCiAJCQl1OCBwYWRbM107DQogCQl9IF9fcGFja2Vk
IGhkcjsNCiAJCXN0cnVjdCBtdDc2MTVfd293X2N0cmxfdGx2IHdvd19jdHJsX3RsdjsNCisJCXN0
cnVjdCBtdDc2MTVfd293X2dwaW9fcGFyYW1fdGx2IGdwaW9fdGx2Ow0KIAl9IHJlcSA9IHsNCiAJ
CS5oZHIgPSB7DQogCQkJLmJzc19pZHggPSBtdmlmLT5pZHgsDQpAQCAtMzU1Miw2ICszNTU1LDEx
IEBAIG10NzYxNV9tY3Vfc2V0X3dvd19jdHJsKHN0cnVjdCBtdDc2MTVfcGh5ICpwaHksIHN0cnVj
dCBpZWVlODAyMTFfdmlmICp2aWYsDQogCQkJLmxlbiA9IGNwdV90b19sZTE2KHNpemVvZihzdHJ1
Y3QgbXQ3NjE1X3dvd19jdHJsX3RsdikpLA0KIAkJCS5jbWQgPSBzdXNwZW5kID8gMSA6IDIsDQog
CQl9LA0KKwkJLmdwaW9fdGx2ID0gew0KKwkJCS50YWcgPSBjcHVfdG9fbGUxNihVTklfU1VTUEVO
RF9XT1dfR1BJT19QQVJBTSksDQorCQkJLmxlbiA9IGNwdV90b19sZTE2KHNpemVvZihzdHJ1Y3Qg
bXQ3NjE1X3dvd19ncGlvX3BhcmFtX3RsdikpLA0KKwkJCS5ncGlvX3BpbiA9IDB4ZmYsIC8qIGZv
bGxvdyBmdyBhYm91dCBHUElPIHBpbiAqLw0KKwkJfSwNCiAJfTsNCiANCiAJaWYgKHdvd2xhbi0+
bWFnaWNfcGt0KQ0KQEAgLTM1NjUsOSArMzU3MywxMSBAQCBtdDc2MTVfbWN1X3NldF93b3dfY3Ry
bChzdHJ1Y3QgbXQ3NjE1X3BoeSAqcGh5LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLA0KIAl9
DQogDQogCWlmIChtdDc2X2lzX21taW8oJmRldi0+bXQ3NikpDQotCQlyZXEud293X2N0cmxfdGx2
Lndha2V1cF9oaWYgPSAyOw0KKwkJcmVxLndvd19jdHJsX3Rsdi53YWtldXBfaGlmID0gV09XX1BD
SUU7DQogCWVsc2UgaWYgKG10NzZfaXNfdXNiKCZkZXYtPm10NzYpKQ0KLQkJcmVxLndvd19jdHJs
X3Rsdi53YWtldXBfaGlmID0gMTsNCisJCXJlcS53b3dfY3RybF90bHYud2FrZXVwX2hpZiA9IFdP
V19VU0I7DQorCWVsc2UgaWYgKG10NzZfaXNfc2RpbygmZGV2LT5tdDc2KSkNCisJCXJlcS53b3df
Y3RybF90bHYud2FrZXVwX2hpZiA9IFdPV19HUElPOw0KIA0KIAlyZXR1cm4gbXQ3Nl9tY3Vfc2Vu
ZF9tc2coJmRldi0+bXQ3NiwgTUNVX1VOSV9DTURfU1VTUEVORCwgJnJlcSwNCiAJCQkJIHNpemVv
ZihyZXEpLCB0cnVlKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRl
ay9tdDc2L210NzYxNS9tY3UuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3NjE1L21jdS5oDQppbmRleCA3Yjg1NmU5ZWVlMWUuLjU5YWQ2YWMxNWU0MSAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5oDQorKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuaA0KQEAgLTQ3
Nyw2ICs0NzcsMTIgQEAgc3RydWN0IG10NzYxNV9ic3NfcW9zX3RsdiB7DQogCXU4IHBhZFszXTsN
CiB9IF9fcGFja2VkOw0KIA0KK2VudW0gew0KKwlXT1dfVVNCID0gMSwNCisJV09XX1BDSUUgPSAy
LA0KKwlXT1dfR1BJTyA9IDMsDQorfTsNCisNCiBzdHJ1Y3QgbXQ3NjE1X3dvd19jdHJsX3RsdiB7
DQogCV9fbGUxNiB0YWc7DQogCV9fbGUxNiBsZW47DQpAQCAtNTAxLDYgKzUwNywxNiBAQCBzdHJ1
Y3QgbXQ3NjE1X3dvd19jdHJsX3RsdiB7DQogCXU4IHJzdls0XTsNCiB9IF9fcGFja2VkOw0KIA0K
K3N0cnVjdCBtdDc2MTVfd293X2dwaW9fcGFyYW1fdGx2IHsNCisJX19sZTE2IHRhZzsNCisJX19s
ZTE2IGxlbjsNCisJdTggZ3Bpb19waW47DQorCXU4IHRyaWdnZXJfbHZsOw0KKwl1OCBwYWRbMl07
DQorCV9fbGUzMiBncGlvX2ludGVydmFsOw0KKwl1OCByc3ZbNF07DQorfSBfX3BhY2tlZDsNCisN
CiAjZGVmaW5lIE1UNzYxNV9XT1dfTUFTS19NQVhfTEVOCQkxNg0KICNkZWZpbmUgTVQ3NjE1X1dP
V19QQVRURU5fTUFYX0xFTgkxMjgNCiBzdHJ1Y3QgbXQ3NjE1X3dvd19wYXR0ZXJuX3RsdiB7DQot
LSANCjIuMjUuMQ0K

