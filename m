Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A97332D434
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 14:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbhCDNbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Mar 2021 08:31:31 -0500
Received: from mailgw02.mediatek.com ([216.200.240.185]:5139 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241343AbhCDNbQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Mar 2021 08:31:16 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Mar 2021 08:31:16 EST
X-UUID: 03a119481ebd41c2ad5af279ae2259d0-20210304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qpt7mK9+6UdB6YiUWW6FGwMifHUQkMCII30VTDrvVg0=;
        b=Dnb+dehm4UBsp94Bc11tq4mtlM4PV32JZIXbi2T0z8a6UBcc3+2Z88EOellteuvhbgvasJlFjqSx80iX5+NmQ9i0UIfhKbodF+VJDCqsJmQBNind4wwZ39eRf6231ygxGeUsQZg7IgmJ+zWui2PPTWhIXnMNfODX0s4On0SD+K8=;
X-UUID: 03a119481ebd41c2ad5af279ae2259d0-20210304
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 58716149; Thu, 04 Mar 2021 05:25:29 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Mar 2021 05:25:27 -0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Mar 2021 21:25:26 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/3] mt76: mt7663s: make all of packets 4-bytes aligned in sdio tx aggregation
Date:   Thu, 4 Mar 2021 21:25:22 +0800
Message-ID: <8f6807d6161efbed6d585a2ca041d4b126b30451.1614863741.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <801a2aa986f5486a0e789065feef7b77c612ea7b.1614863741.git.objelf@gmail.com>
References: <801a2aa986f5486a0e789065feef7b77c612ea7b.1614863741.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpFYWNoIHBhY2tldCBz
aG91bGQgYmUgcGFkZGVkIHdpdGggdGhlIGFkZGl0aW9uYWwgemVybyB0byBiZWNvbWUgNC1ieXRl
cw0KYWxpZ25tZW50IGluIHNkaW8gdHggYWdncmVnYXRpb24uDQoNCkZpeGVzOiAxNTIyZmY3MzFm
ODQgKCJtdDc2OiBtdDc2NjNzOiBpbnRyb2R1Y2Ugc2RpbyB0eCBhZ2dyZWdhdGlvbiIpDQpTaWdu
ZWQtb2ZmLWJ5OiBTZWFuIFdhbmcgPHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9zZGlvX3R4cnguYyB8IDcgKysr
KysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3Nk
aW9fdHhyeC5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvc2Rp
b190eHJ4LmMNCmluZGV4IDlmYjUwNmYyYWNlNi4uMmQzYjdkMWUyYzkyIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc2MTUvc2Rpb190eHJ4LmMNCisr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L3NkaW9fdHhyeC5j
DQpAQCAtMjE4LDYgKzIxOCw3IEBAIHN0YXRpYyBpbnQgbXQ3NjYzc190eF9ydW5fcXVldWUoc3Ry
dWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdCBtdDc2X3F1ZXVlICpxKQ0KIAlpbnQgcWlkLCBlcnIs
IG5mcmFtZXMgPSAwLCBsZW4gPSAwLCBwc2Vfc3ogPSAwLCBwbGVfc3ogPSAwOw0KIAlib29sIG1j
dSA9IHEgPT0gZGV2LT5xX21jdVtNVF9NQ1VRX1dNXTsNCiAJc3RydWN0IG10NzZfc2RpbyAqc2Rp
byA9ICZkZXYtPnNkaW87DQorCXU4IHBhZDsNCiANCiAJcWlkID0gbWN1ID8gQVJSQVlfU0laRShz
ZGlvLT54bWl0X2J1ZikgLSAxIDogcS0+cWlkOw0KIAl3aGlsZSAocS0+Zmlyc3QgIT0gcS0+aGVh
ZCkgew0KQEAgLTIzNCw3ICsyMzUsOCBAQCBzdGF0aWMgaW50IG10NzY2M3NfdHhfcnVuX3F1ZXVl
KHN0cnVjdCBtdDc2X2RldiAqZGV2LCBzdHJ1Y3QgbXQ3Nl9xdWV1ZSAqcSkNCiAJCQlnb3RvIG5l
eHQ7DQogCQl9DQogDQotCQlpZiAobGVuICsgZS0+c2tiLT5sZW4gKyA0ID4gTVQ3NlNfWE1JVF9C
VUZfU1opDQorCQlwYWQgPSByb3VuZHVwKGUtPnNrYi0+bGVuLCA0KSAtIGUtPnNrYi0+bGVuOw0K
KwkJaWYgKGxlbiArIGUtPnNrYi0+bGVuICsgcGFkICsgNCA+IE1UNzZTX1hNSVRfQlVGX1NaKQ0K
IAkJCWJyZWFrOw0KIA0KIAkJaWYgKG10NzY2M3NfdHhfcGlja19xdW90YShzZGlvLCBtY3UsIGUt
PmJ1Zl9zeiwgJnBzZV9zeiwNCkBAIC0yNTIsNiArMjU0LDkgQEAgc3RhdGljIGludCBtdDc2NjNz
X3R4X3J1bl9xdWV1ZShzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgc3RydWN0IG10NzZfcXVldWUgKnEp
DQogCQkJbGVuICs9IGl0ZXItPmxlbjsNCiAJCQluZnJhbWVzKys7DQogCQl9DQorDQorCQltZW1z
ZXQoc2Rpby0+eG1pdF9idWZbcWlkXSArIGxlbiwgMCwgcGFkKTsNCisJCWxlbiArPSBwYWQ7DQog
bmV4dDoNCiAJCXEtPmZpcnN0ID0gKHEtPmZpcnN0ICsgMSkgJSBxLT5uZGVzYzsNCiAJCWUtPmRv
bmUgPSB0cnVlOw0KLS0gDQoyLjI1LjENCg==

