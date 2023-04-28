Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EA46F1FA8
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Apr 2023 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346735AbjD1UuO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Apr 2023 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346738AbjD1UuL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Apr 2023 16:50:11 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1177240CB
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 13:50:10 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5C342C00085
        for <linux-wireless@vger.kernel.org>; Fri, 28 Apr 2023 20:50:07 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 7B2DE13C2B0;
        Fri, 28 Apr 2023 13:50:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7B2DE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1682715007;
        bh=e11/gnVChue1BujwM6BEcZi03d9GKv2rCZfp1q0DbnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jiK+5EFAVmZ1E2cVjx2QG+JQQtrS9F0/NIM8s+fsAaeNj/XBDiuwwYWAxr23m0gY0
         q+y4U0I1rvYImLDDY6UT6/6H9llc1hvGto/NRlDta/9+8EE0WhJlMTYGY0D9nx8BO9
         ciHxbPQhwcjtP1Mup2J9dDh0IHSL7zGpxqV5qHoI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 6/6] wifi: mt76: mt7915: support enabling rx group-5 status
Date:   Fri, 28 Apr 2023 13:50:00 -0700
Message-Id: <20230428205000.2647945-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428205000.2647945-1-greearb@candelatech.com>
References: <20230428205000.2647945-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1682715009-DQG2JuvyfGlv
X-MDID-O: us5;at1;1682715009;DQG2JuvyfGlv;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

When enabled, this allows per-skb rx rate reporting.
Enabling this may degrade RX performance, so it remains
disabled by default.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 33 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 +++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index f836754103dc..cb01f7f72d85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -743,6 +743,38 @@ mt7915_fw_util_wa_show(struct seq_file *file, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(mt7915_fw_util_wa);
 
+static int
+mt7915_rx_group_5_enable_set(void *data, u64 val)
+{
+	struct mt7915_dev *dev = data;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	dev->rx_group_5_enable = !!val;
+
+	/* Enabled if we requested enabled OR if monitor mode is enabled. */
+	mt76_rmw_field(dev, MT_DMA_DCR0(0), MT_DMA_DCR0_RXD_G5_EN,
+		       dev->rx_group_5_enable);
+	mt76_testmode_reset(dev->phy.mt76, true);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static int
+mt7915_rx_group_5_enable_get(void *data, u64 *val)
+{
+	struct mt7915_dev *dev = data;
+
+	*val = dev->rx_group_5_enable;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_rx_group_5_enable, mt7915_rx_group_5_enable_get,
+			 mt7915_rx_group_5_enable_set, "%lld\n");
+
 static void
 mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 			   struct seq_file *file)
@@ -1297,6 +1329,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 			    &mt7915_fw_util_wm_fops);
 	debugfs_create_file("fw_util_wa", 0400, dir, dev,
 			    &mt7915_fw_util_wa_fops);
+	debugfs_create_file("rx_group_5_enable", 0600, dir, dev, &fops_rx_group_5_enable);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
 	debugfs_create_file("txpower_sku", 0400, dir, phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index cd98a1e1e63c..75571566430e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -476,7 +476,8 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 0x680);
 
 	/* mt7915: disable rx rate report by default due to hw issues */
-	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
+	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
+		       dev->rx_group_5_enable);
 
 	/* clear estimated value of EIFS for Rx duration & OBSS time */
 	mt76_wr(dev, MT_WF_RMAC_RSVD0(band), MT_WF_RMAC_RSVD0_EIFS_CLR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 55aed3c6d3be..dd73b12cea61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -492,7 +492,7 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 		phy->monitor_enabled = enabled;
 
 		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
-			       enabled);
+			       dev->rx_group_5_enable);
 		mt76_testmode_reset(phy->mt76, true);
 		__mt7915_configure_filter(hw, 0, &total_flags, multicast);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 084001647aaa..03459c6d94cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -313,6 +313,11 @@ struct mt7915_dev {
 	u16 chainshift;
 	u32 hif_idx;
 
+	/* Should we enable group-5 rx descriptor logic?  This may decrease RX
+	 * throughput, but will give per skb rx rate information..
+	 */
+	bool rx_group_5_enable;
+
 	struct work_struct init_work;
 	struct work_struct rc_work;
 	struct work_struct dump_work;
-- 
2.40.0

