Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF46E583574
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 01:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiG0XBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 19:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiG0XBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 19:01:44 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED2C205E7
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 16:01:41 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.165])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 5B91420061;
        Wed, 27 Jul 2022 23:01:40 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0F6679C0066;
        Wed, 27 Jul 2022 23:01:39 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 8D80813C2B3;
        Wed, 27 Jul 2022 16:01:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8D80813C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1658962899;
        bh=hw54Lh/cn+8Lf1SYZ1CzOHrOZuIUOp2lGdLr85Xg6eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJnYj9AB0JLiRaMSrWSytXAPTmwv6tiZAhemcunPRz0dyXikrYWTV2hjnYraWlfmM
         nTQKse/0+SGNkhiDROzHG9OzOK4/wiDwb7DJy/h+xbi9Kkq/pngY2IsZAqHVXaH3r8
         DCm2dipOrRY2Xr+HsctgvpACau0Zzf/cqyUHBHkc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 03/12] wifi: mt76: mt7915: debugfs hook to enable TXS for NO_SKB pkt-ids
Date:   Wed, 27 Jul 2022 16:01:13 -0700
Message-Id: <20220727230122.29842-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220727230122.29842-1-greearb@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1658962900-osxRL_D2RqZY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This lets user turn on/off this feature.  Enabling gives better
tx-rate related stats, but will cause extra driver and (maybe)
firmware work.  Not sure if it actually affects performance or
not.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 24 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  3 ++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 ++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index cab6e02e1f8c..f71d80cd4002 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -633,6 +633,29 @@ mt7915_fw_util_wa_show(struct seq_file *file, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(mt7915_fw_util_wa);
 
+static int
+mt7915_txs_for_no_skb_set(void *data, u64 val)
+{
+	struct mt7915_dev *dev = data;
+
+	dev->txs_for_no_skb_enabled = !!val;
+
+	return 0;
+}
+
+static int
+mt7915_txs_for_no_skb_get(void *data, u64 *val)
+{
+	struct mt7915_dev *dev = data;
+
+	*val = dev->txs_for_no_skb_enabled;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_txs_for_no_skb, mt7915_txs_for_no_skb_get,
+			 mt7915_txs_for_no_skb_set, "%lld\n");
+
 static void
 mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 			   struct seq_file *file)
@@ -1017,6 +1040,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 			    &mt7915_fw_util_wm_fops);
 	debugfs_create_file("fw_util_wa", 0400, dir, dev,
 			    &mt7915_fw_util_wa_fops);
+	debugfs_create_file("force_txs", 0600, dir, dev, &fops_txs_for_no_skb);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
 	debugfs_create_file("txpower_sku", 0400, dir, phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2d1a8d8b04fb..cf4d11c0a88d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1257,7 +1257,8 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	txwi[4] = 0;
 
 	val = FIELD_PREP(MT_TXD5_PID, pid);
-	if (pid >= MT_PACKET_ID_FIRST)
+	if (pid >= MT_PACKET_ID_FIRST ||
+	    (pid == MT_PACKET_ID_NO_SKB && dev->txs_for_no_skb_enabled))
 		val |= MT_TXD5_TX_STATUS_HOST;
 	txwi[5] = cpu_to_le32(val);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 4dcae6991669..fa755bfa223f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -294,6 +294,11 @@ struct mt7915_dev {
 	u16 chainmask;
 	u16 chainshift;
 	u32 hif_idx;
+	/* Should we request TXS for MT_PACKET_ID_NO_SKB?  Doing so gives better
+	 * costs but causes a great deal more TXS packet processing by driver and
+	 * creation by firmware, so may be a performance drag.
+	 */
+	bool txs_for_no_skb_enabled;
 
 	struct work_struct init_work;
 	struct work_struct rc_work;
-- 
2.20.1

