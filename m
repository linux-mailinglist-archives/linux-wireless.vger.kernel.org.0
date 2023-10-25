Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E8C7D73D6
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjJYTEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjJYTEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:04:05 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569DE128
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:04:03 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3E9A1C00065
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:04:01 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id C34D813C2B1;
        Wed, 25 Oct 2023 12:04:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C34D813C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260640;
        bh=iEwf1XblNzQOQ+DhUyrIFCs+StHXw+/25eB3qepZD0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTHOmw1lpr0S9mRUulNFPm3TDo6nkDC7/+X7Qk3B0zIf2qrmqrIPrpRKOK7G+r1gh
         O5EDteKk0DvwL80nTv3S4oh8DF/DUaNVTnI676if4+O1UkatIphTrlOnvys9BfNeX3
         WhlwCDPiRaky3UxaE5PsJ+pa44cZILmUsGd+vlbg=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 07/12] wifi: mt76: mt7915: support enabling rx group-5 status
Date:   Wed, 25 Oct 2023 12:03:49 -0700
Message-Id: <20231025190351.2141832-7-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231025190351.2141832-1-greearb@candelatech.com>
References: <20231025190351.2141832-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260641-ShpK9tvyTBk8
X-MDID-O: us5;ut7;1698260641;ShpK9tvyTBk8;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index f9309699f657..cb4409bf49d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -900,6 +900,38 @@ static const struct file_operations fops_set_rate_override = {
 	.llseek = default_llseek,
 };
 
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
@@ -1452,6 +1484,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 			    &mt7915_fw_util_wm_fops);
 	debugfs_create_file("fw_util_wa", 0400, dir, dev,
 			    &mt7915_fw_util_wa_fops);
+	debugfs_create_file("rx_group_5_enable", 0600, dir, dev, &fops_rx_group_5_enable);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
 	debugfs_create_file("txpower_sku", 0400, dir, phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index fce4318a1031..a442d1e8b04e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -486,7 +486,8 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 0x680);
 
 	/* mt7915: disable rx rate report by default due to hw issues */
-	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
+	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
+		       dev->rx_group_5_enable);
 
 	/* clear estimated value of EIFS for Rx duration & OBSS time */
 	mt76_wr(dev, MT_WF_RMAC_RSVD0(band), MT_WF_RMAC_RSVD0_EIFS_CLR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index e22d1d35161e..bef8a3c17731 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -494,7 +494,7 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 		}
 
 		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
-			       enabled);
+			       dev->rx_group_5_enable);
 		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_MDP_DCR0_RX_HDR_TRANS_EN,
 			       !dev->monitor_mask);
 		mt76_testmode_reset(phy->mt76, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 960435ad2c04..dada69dff46b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -264,6 +264,11 @@ struct mt7915_dev {
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

