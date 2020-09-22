Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C082740FE
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 13:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIVLgY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 07:36:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57309 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726651AbgIVLgY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 07:36:24 -0400
X-UUID: 75d9772af6594ae5bda9c5c79365aaae-20200922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QiRB9b6QFX/n3VwaIGIkzGNyJgGwq+YynWOJjCc5ZTM=;
        b=VK0RV/ahrGJ1tNgRG4RfrLlodZ1iA+DSqgB/ZIlfYXnRiAJusRFX4XTukYYK/Sxqlvrp5gPw8d08jBm3y0vB/izkDpSZmJVLCeQye5L5U9VEun4DwLz9QJfcDAWYP2mDWmCd86II3/WSqLFVV1xqlwAbsnEoItgW11kF4JkmRGw=;
X-UUID: 75d9772af6594ae5bda9c5c79365aaae-20200922
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 401991970; Tue, 22 Sep 2020 19:36:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Sep 2020 19:36:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Sep 2020 19:36:16 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: add offchannel condition in switch channel command
Date:   Tue, 22 Sep 2020 19:36:01 +0800
Message-ID: <20200922113601.5276-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QWRkIGEgbWlzc2luZyBvZmZjaGFubmVsIGNvbmRpdGlvbiBmb3IgY2hhbm5lbCBzd2l0Y2ggcmVh
c29uLCB3aGljaA0KYnlwYXNzZXMgRFBEIGNhbGlicmF0aW9uIHRvIHJlZHVjZSBzY2FubmluZyB0
aW1lLg0KDQpTaWduZWQtb2ZmLWJ5OiBTaGF5bmUgQ2hlbiA8c2hheW5lLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KLS0tDQogZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1
LmMgfCA2ICsrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzkxNS9tY3UuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1
L21jdS5jDQppbmRleCBmYTNlYTQ2Li43NDJlMDg1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvbWVkaWF0ZWsvbXQ3Ni9tdDc5MTUvbWN1LmMNCisrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3OTE1L21jdS5jDQpAQCAtMzIxMiw4ICszMjEyLDEwIEBA
IGludCBtdDc5MTVfbWN1X3NldF9jaGFuX2luZm8oc3RydWN0IG10NzkxNV9waHkgKnBoeSwgaW50
IGNtZCkNCiAJCS5jaGFubmVsX2JhbmQgPSBjaGFuZGVmLT5jaGFuLT5iYW5kLA0KIAl9Ow0KIA0K
LQlpZiAoKGNoYW5kZWYtPmNoYW4tPmZsYWdzICYgSUVFRTgwMjExX0NIQU5fUkFEQVIpICYmDQot
CSAgICBjaGFuZGVmLT5jaGFuLT5kZnNfc3RhdGUgIT0gTkw4MDIxMV9ERlNfQVZBSUxBQkxFKQ0K
KwlpZiAoZGV2LT5tdDc2Lmh3LT5jb25mLmZsYWdzICYgSUVFRTgwMjExX0NPTkZfT0ZGQ0hBTk5F
TCkNCisJCXJlcS5zd2l0Y2hfcmVhc29uID0gQ0hfU1dJVENIX1NDQU5fQllQQVNTX0RQRDsNCisJ
ZWxzZSBpZiAoKGNoYW5kZWYtPmNoYW4tPmZsYWdzICYgSUVFRTgwMjExX0NIQU5fUkFEQVIpICYm
DQorCQkgY2hhbmRlZi0+Y2hhbi0+ZGZzX3N0YXRlICE9IE5MODAyMTFfREZTX0FWQUlMQUJMRSkN
CiAJCXJlcS5zd2l0Y2hfcmVhc29uID0gQ0hfU1dJVENIX0RGUzsNCiAJZWxzZQ0KIAkJcmVxLnN3
aXRjaF9yZWFzb24gPSBDSF9TV0lUQ0hfTk9STUFMOw0KLS0gDQoyLjE3LjENCg0K

