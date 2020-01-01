Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F58412DDF5
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2020 07:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgAAF4q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jan 2020 00:56:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:6945 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbgAAF4q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jan 2020 00:56:46 -0500
X-UUID: bf8f0a30a2f34b2385b6f8c4becc16b7-20200101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hKgJzwzefE+FPfSamusgqvNTI7peHIm1WvPCMjSXGwY=;
        b=bAiToZYs4Tl0vsvVJPJ/EDIBfXf7fk0GcUluU4KH+m2ULQgqQ4ujMp2blWqx3XciOSm961YnFbCT8We2TrefPMYRGxZibIQr50xkWRbKtH3sS96XgJ4zOL4oNAaG6vvFyskSJCfIZoCYV8iPS8sxOStM3RwrqgTC7STijf6rcBU=;
X-UUID: bf8f0a30a2f34b2385b6f8c4becc16b7-20200101
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 194416538; Wed, 01 Jan 2020 13:56:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 1 Jan 2020 13:55:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 1 Jan 2020 13:56:35 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7615: fix endianness in mt7615_mcu_set_eeprom
Date:   Wed, 1 Jan 2020 13:56:25 +0800
Message-ID: <4f6dfa450f2bf3ca5be7c7b417d62b2eb339918d.1577856956.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 858B261DFA2EE7E5F64E35FECBE3FABDF3C6DA8D88590AABFE143C117432EDE82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhlIGZpZWxkICd1MTYgbGVuJyBzaG91bGQgYmUgX19sZTE2Lg0KDQpTaWduZWQtb2ZmLWJ5OiBS
eWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL25ldC93aXJl
bGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2L210NzYxNS9tY3UuYyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NjE1L21jdS5jDQppbmRleCBjOGQ2YTM2ZjVkMGEuLjFh
NjAwMTZkODUzNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210
NzYvbXQ3NjE1L21jdS5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tZWRpYXRlay9tdDc2
L210NzYxNS9tY3UuYw0KQEAgLTU5OCwxMCArNTk4LDEwIEBAIGludCBtdDc2MTVfbWN1X3NldF9l
ZXByb20oc3RydWN0IG10NzYxNV9kZXYgKmRldikNCiAJc3RydWN0IHsNCiAJCXU4IGJ1ZmZlcl9t
b2RlOw0KIAkJdTggcGFkOw0KLQkJdTE2IGxlbjsNCisJCV9fbGUxNiBsZW47DQogCX0gX19wYWNr
ZWQgcmVxX2hkciA9IHsNCiAJCS5idWZmZXJfbW9kZSA9IDEsDQotCQkubGVuID0gX19NVF9FRV9N
QVggLSBNVF9FRV9OSUNfQ09ORl8wLA0KKwkJLmxlbiA9IGNwdV90b19sZTE2KF9fTVRfRUVfTUFY
IC0gTVRfRUVfTklDX0NPTkZfMCksDQogCX07DQogCWludCByZXQsIGxlbiA9IHNpemVvZihyZXFf
aGRyKSArIF9fTVRfRUVfTUFYIC0gTVRfRUVfTklDX0NPTkZfMDsNCiAJdTggKnJlcSwgKmVlcCA9
ICh1OCAqKWRldi0+bXQ3Ni5lZXByb20uZGF0YTsNCi0tIA0KMi4xOC4wDQo=

