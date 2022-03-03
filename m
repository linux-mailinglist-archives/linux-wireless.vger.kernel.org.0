Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C984CB972
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Mar 2022 09:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiCCIrj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Mar 2022 03:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCCIri (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Mar 2022 03:47:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D9E1680A8
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 00:46:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 986BD61B8E
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 08:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A6AC004E1;
        Thu,  3 Mar 2022 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646297213;
        bh=VIPW62CjOcLNrtRMUwbzbb4BX0IfM9wVvddCFS9duxo=;
        h=From:To:Cc:Subject:Date:From;
        b=SceXbge0DPCWxf5v71/rBdfCEFs3d/Y2GfsLdsWIsopVAeTlXWJwMXgK9+Z7/KL5x
         eXbXdjDVb8padmMrcszQvDJ9gR1GwGgNOpOIvgSHO/ycyU63G4UTzPus2jSNIG6mBI
         wUhTuhgN/dOwJdUKniJM0bMwubmnXSkm9i+14StIChrVxiV0LbA2dqWFrdcpi+FfTQ
         ChT+jIhKlqAL6RwZG2IaAs8k5ghAf7nc8GOwIOa0FWpc0YU7vG6NqVCw8iG/u6w/2J
         A5mTo0BZv1hr6Ml3mbQhajeMAzyCYONW5cDNbwgGN0evJwhkaw8vTWsu6vO66PWEms
         uFygEgz37YMEQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921: fix  mt7921_queues_acq implementation
Date:   Thu,  3 Mar 2022 09:46:41 +0100
Message-Id: <f8fb37a6e29c1e7d59c557ffc336df86b98f01b9.1646297035.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix mt7921_queues_acq implementation according to the vendor sdk.

Fixes: 474a9f21e2e20 ("mt76: mt7921: add debugfs support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 13 ++++++-------
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h    | 11 +++++------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 1bb388ecc334..32004b55a360 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -129,23 +129,22 @@ mt7921_queues_acq(struct seq_file *s, void *data)
 
 	mt7921_mutex_acquire(dev);
 
-	for (i = 0; i < 16; i++) {
-		int j, acs = i / 4, index = i % 4;
+	for (i = 0; i < 4; i++) {
 		u32 ctrl, val, qlen = 0;
+		int j;
 
-		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(acs, index));
-		ctrl = BIT(31) | BIT(15) | (acs << 8);
+		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(i));
+		ctrl = BIT(31) | BIT(11) | (i << 24);
 
 		for (j = 0; j < 32; j++) {
 			if (val & BIT(j))
 				continue;
 
-			mt76_wr(dev, MT_PLE_FL_Q0_CTRL,
-				ctrl | (j + (index << 5)));
+			mt76_wr(dev, MT_PLE_FL_Q0_CTRL, ctrl | j);
 			qlen += mt76_get_field(dev, MT_PLE_FL_Q3_CTRL,
 					       GENMASK(11, 0));
 		}
-		seq_printf(s, "AC%d%d: queued=%d\n", acs, index, qlen);
+		seq_printf(s, "AC%d: queued=%d\n", i, qlen);
 	}
 
 	mt7921_mutex_release(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 411695f273cd..33578e0dfde3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -17,13 +17,12 @@
 #define MT_PLE_BASE			0x820c0000
 #define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
 
-#define MT_PLE_FL_Q0_CTRL		MT_PLE(0x1b0)
-#define MT_PLE_FL_Q1_CTRL		MT_PLE(0x1b4)
-#define MT_PLE_FL_Q2_CTRL		MT_PLE(0x1b8)
-#define MT_PLE_FL_Q3_CTRL		MT_PLE(0x1bc)
+#define MT_PLE_FL_Q0_CTRL		MT_PLE(0x3e0)
+#define MT_PLE_FL_Q1_CTRL		MT_PLE(0x3e4)
+#define MT_PLE_FL_Q2_CTRL		MT_PLE(0x3e8)
+#define MT_PLE_FL_Q3_CTRL		MT_PLE(0x3ec)
 
-#define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(0x300 + 0x10 * (ac) + \
-					       ((n) << 2))
+#define MT_PLE_AC_QEMPTY(_n)		MT_PLE(0x500 + 0x40 * (_n))
 #define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
 
 #define MT_MDP_BASE			0x820cd000
-- 
2.35.1

