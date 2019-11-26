Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10D6109F18
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 14:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfKZNRs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 08:17:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:10995 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727734AbfKZNRr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 08:17:47 -0500
X-UUID: d280355e739a48b6bb8f3d13768babdb-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jZRVn5TlvJrTrTr3DZJgx1M6iBQCf9Nk3/ncmMlFv4c=;
        b=kA3On3UqMr2kt4qal2yIT1KEbiJV03Qro/4TAmEi6iPnTLx1dCxa/VKUzpGz8T8aSJd2ZqZNp6UV3J9859hEdidqJYz92Ffdy0PcBhZE6seCTZ7TEQDKuUaAR6tf55jQ/bVrdi9SDxNO+1jqlUVVoloob6RVgMG9S5/pUILMvWU=;
X-UUID: d280355e739a48b6bb8f3d13768babdb-20191126
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 295749486; Tue, 26 Nov 2019 21:17:42 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 21:17:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Nov 2019 21:17:36 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: fix possible undetected invalid MAC address
Date:   Tue, 26 Nov 2019 21:15:54 +0800
Message-ID: <20191126131554.32457-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C5DD055B51CD7A390C073BA74141EDA9DD3D1017221B87A0542E61E140A4008C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TWFrZSBzdXJlIHRoZSBNQUMgYWRkcmVzcyBpcyBjaGVja2VkIGJlZm9yZSBmdW5jdGlvbiByZXR1
cm5zLg0KDQpJZiBDT05GSUdfT0YgaXMgc2V0IGFuZCB0aGUgZGV2aWNlIG5vZGUgaXMgbnVsbCwg
dGhlIGZ1bmN0aW9uIHdpbGwgDQpyZXR1cm4gZGlyZWN0bHksIGFuZCBhbiBpbnZhbGlkIE1BQyBh
ZGRyZXNzIHdpbGwgbm90IGJlIGNoZWNrZWQuDQoNClNpZ25lZC1vZmYtYnk6IFNoYXluZSBDaGVu
IDxzaGF5bmUuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJlbGVzcy9t
ZWRpYXRlay9tdDc2L2VlcHJvbS5jIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9tZWRpYXRlay9tdDc2L2VlcHJvbS5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWVkaWF0ZWsv
bXQ3Ni9lZXByb20uYw0KaW5kZXggODA0MjI0ZTgxMTAzLi4zNThmYjBhMWU1MjMgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2VlcHJvbS5jDQorKysgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L2VlcHJvbS5jDQpAQCAtODAsMTMgKzgw
LDE0IEBAIG10NzZfZWVwcm9tX292ZXJyaWRlKHN0cnVjdCBtdDc2X2RldiAqZGV2KQ0KIAljb25z
dCB1OCAqbWFjOw0KIA0KIAlpZiAoIW5wKQ0KLQkJcmV0dXJuOw0KKwkJZ290byBvdXQ7DQogDQog
CW1hYyA9IG9mX2dldF9tYWNfYWRkcmVzcyhucCk7DQogCWlmICghSVNfRVJSKG1hYykpDQogCQll
dGhlcl9hZGRyX2NvcHkoZGV2LT5tYWNhZGRyLCBtYWMpOw0KICNlbmRpZg0KIA0KK291dDoNCiAJ
aWYgKCFpc192YWxpZF9ldGhlcl9hZGRyKGRldi0+bWFjYWRkcikpIHsNCiAJCWV0aF9yYW5kb21f
YWRkcihkZXYtPm1hY2FkZHIpOw0KIAkJZGV2X2luZm8oZGV2LT5kZXYsDQotLSANCjIuMTcuMQ0K

