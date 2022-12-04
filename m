Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4468641B47
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Dec 2022 08:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiLDHSc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Dec 2022 02:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLDHSa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Dec 2022 02:18:30 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB58C12D12
        for <linux-wireless@vger.kernel.org>; Sat,  3 Dec 2022 23:18:22 -0800 (PST)
X-UUID: 9b99ca49391c401e848ad851f9a278e1-20221204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7hmwsr/qq0qSzUazCGLdRMM8YZeRwOkqWqkC1IpBe4g=;
        b=GOLfpsIu7lOEUqC4IxC5v6CLLlFZYq+vGMVJrD/e3k779YKH+dqo/HNJJ09hUq53pweODaxXvR0FmWuTtfWy2Y+rcfV2T7VEU36iSTAXfC2IRKfNBF78LzvA8mnoe6qzZ698D+BoYX3NDJ0lFw2Hql312aO6Kl296sR1iczbm6c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:85021dd9-c0ef-420c-98b2-153bc9d4c3ce,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:85021dd9-c0ef-420c-98b2-153bc9d4c3ce,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:59ab131f-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:2212041518189XMI25P7,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9b99ca49391c401e848ad851f9a278e1-20221204
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1632662987; Sun, 04 Dec 2022 15:18:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sun, 4 Dec 2022 15:18:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sun, 4 Dec 2022 15:18:16 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt7915: drop always true condition of __mt7915_reg_addr()
Date:   Sun, 4 Dec 2022 15:18:14 +0800
Message-ID: <c7a43d2a715d0ed911780712edc60c7adbee806d.1670137513.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

smatch warnings:
addr <= MT_CBTOP2_PHY_END(0xffffffff) is always true (<= u32max),
so drop it.

Fixes: c2bf05db6c78 ("mt76: mt7915: refine register definition")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 0a95c3da241b..52be55dff947 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -495,7 +495,7 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 
 	if (dev_is_pci(dev->mt76.dev) &&
 	    ((addr >= MT_CBTOP1_PHY_START && addr <= MT_CBTOP1_PHY_END) ||
-	     (addr >= MT_CBTOP2_PHY_START && addr <= MT_CBTOP2_PHY_END)))
+	    addr >= MT_CBTOP2_PHY_START))
 		return mt7915_reg_map_l1(dev, addr);
 
 	/* CONN_INFRA: covert to phyiscal addr and use layer 1 remap */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index aca1b2f1e9e3..7e0d86366c77 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -803,7 +803,6 @@ enum offs_rev {
 #define MT_CBTOP1_PHY_START		0x70000000
 #define MT_CBTOP1_PHY_END		__REG(CBTOP1_PHY_END)
 #define MT_CBTOP2_PHY_START		0xf0000000
-#define MT_CBTOP2_PHY_END		0xffffffff
 #define MT_INFRA_MCU_START		0x7c000000
 #define MT_INFRA_MCU_END		__REG(INFRA_MCU_ADDR_END)
 #define MT_CONN_INFRA_OFFSET(p)		((p) - MT_INFRA_BASE)
-- 
2.18.0

