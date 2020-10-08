Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAA0287365
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 13:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgJHLdY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 07:33:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47545 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725900AbgJHLdX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 07:33:23 -0400
X-UUID: fe2de0d88e49451bb098695b667271de-20201008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=D0UZOTk44VFqT44JLOZadB5K96q63am3T/vBtiOOUJw=;
        b=Vvl48UpvecTtWeBQO5dh/jpXgQXOyT+gNrxLOheKCKeXTUwl/D4JJlmbRY2cms+rDN63k9NRlora2OymCbZiQp1VUHzld3ovqr3ZZwVRS08tJvvq/1j7jsNQpIQo7uNH0OF0oV+6npwq5PAsJYVkaJwVP640UGzY8ZhOXSIbz6w=;
X-UUID: fe2de0d88e49451bb098695b667271de-20201008
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1101395883; Thu, 08 Oct 2020 19:33:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Oct 2020 19:33:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Oct 2020 19:33:13 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 02/10] mt76: testmode: add snr attribute in rx statistics
Date:   Thu, 8 Oct 2020 19:28:56 +0800
Message-ID: <20201008112904.10620-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201008112904.10620-1-shayne.chen@mediatek.com>
References: <20201008112904.10620-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

U3VwcG9ydCB0byBkaXNwbGF5IHNuciB2YWx1ZSB3aGVuIGR1bXBpbmcgcnggc3RhdGlzdGljcy4N
Cg0KU2lnbmVkLW9mZi1ieTogU2hheW5lIENoZW4gPHNoYXluZS5jaGVuQG1lZGlhdGVrLmNvbT4N
ClJldmlld2VkLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBk
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3Rlc3Rtb2RlLmggfCAyICsrDQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90ZXN0bW9kZS5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
bWVkaWF0ZWsvbXQ3Ni90ZXN0bW9kZS5oDQppbmRleCAwMmM5NDk1Li40MDE1ZjFkIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni90ZXN0bW9kZS5oDQorKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L3Rlc3Rtb2RlLmgNCkBAIC0xMDEs
NiArMTAxLDcgQEAgZW51bSBtdDc2X3Rlc3Rtb2RlX3N0YXRzX2F0dHIgew0KICAqIEBNVDc2X1RN
X1JYX0FUVFJfUkNQSTogcmVjZWl2ZWQgY2hhbm5lbCBwb3dlciBpbmRpY2F0b3IgKGFycmF5LCB1
OCkNCiAgKiBATVQ3Nl9UTV9SWF9BVFRSX0lCX1JTU0k6IGludGVybmFsIGluYmFuZCBSU1NJIChh
cnJheSwgczgpDQogICogQE1UNzZfVE1fUlhfQVRUUl9XQl9SU1NJOiBpbnRlcm5hbCB3aWRlYmFu
ZCBSU1NJIChhcnJheSwgczgpDQorICogQE1UNzZfVE1fUlhfQVRUUl9TTlI6IHNpZ25hbC10by1u
b2lzZSByYXRpbyAoczMyKQ0KICAqLw0KIGVudW0gbXQ3Nl90ZXN0bW9kZV9yeF9hdHRyIHsNCiAJ
TVQ3Nl9UTV9SWF9BVFRSX1VOU1BFQywNCkBAIC0xMDksNiArMTEwLDcgQEAgZW51bSBtdDc2X3Rl
c3Rtb2RlX3J4X2F0dHIgew0KIAlNVDc2X1RNX1JYX0FUVFJfUkNQSSwNCiAJTVQ3Nl9UTV9SWF9B
VFRSX0lCX1JTU0ksDQogCU1UNzZfVE1fUlhfQVRUUl9XQl9SU1NJLA0KKwlNVDc2X1RNX1JYX0FU
VFJfU05SLA0KIA0KIAkvKiBrZWVwIGxhc3QgKi8NCiAJTlVNX01UNzZfVE1fUlhfQVRUUlMsDQot
LSANCjIuMTcuMQ0K

