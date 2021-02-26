Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87D0325EDE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 09:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBZIYY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 03:24:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:58413 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229498AbhBZIYX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 03:24:23 -0500
X-UUID: 8005b81f9ff04d9cb6a1334597faad20-20210226
X-UUID: 8005b81f9ff04d9cb6a1334597faad20-20210226
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 738523191; Fri, 26 Feb 2021 16:23:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 26 Feb 2021 16:23:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Feb 2021 16:23:30 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] mt76: mt7921: fix the base of the dynamic remap
Date:   Fri, 26 Feb 2021 16:23:27 +0800
Message-ID: <93e133d30b727b1bf5fd7df397bc113d8ea1f108.1614327185.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4ff45223ff7ecff8e20a722ffd2db77fe51fea00.1614327185.git.objelf@gmail.com>
References: <4ff45223ff7ecff8e20a722ffd2db77fe51fea00.1614327185.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9F1D6F8B1359B400F2310FEAD5BA557555E1D6D73C9965A5B0048A3673D6830B2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

We should change the base for the dynamic remap into another one, because
the current base (0xe0000) have been the one used to operate the device
ownership.

Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index c4bd31cc81cb..f45f05c794cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -364,11 +364,11 @@
 #define MT_INFRA_CFG_BASE		0xfe000
 #define MT_INFRA(ofs)			(MT_INFRA_CFG_BASE + (ofs))
 
-#define MT_HIF_REMAP_L1			MT_INFRA(0x260)
+#define MT_HIF_REMAP_L1			MT_INFRA(0x24c)
 #define MT_HIF_REMAP_L1_MASK		GENMASK(15, 0)
 #define MT_HIF_REMAP_L1_OFFSET		GENMASK(15, 0)
 #define MT_HIF_REMAP_L1_BASE		GENMASK(31, 16)
-#define MT_HIF_REMAP_BASE_L1		0xe0000
+#define MT_HIF_REMAP_BASE_L1		0x40000
 
 #define MT_SWDEF_BASE			0x41f200
 #define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
-- 
2.25.1

