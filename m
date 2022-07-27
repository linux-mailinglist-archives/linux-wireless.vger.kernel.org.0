Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BD2583578
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 01:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiG0XBu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 19:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiG0XBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 19:01:44 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CB42181E
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 16:01:43 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.75])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AAB1A2005E;
        Wed, 27 Jul 2022 23:01:41 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6B3758007B;
        Wed, 27 Jul 2022 23:01:41 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 28BD213C2B1;
        Wed, 27 Jul 2022 16:01:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 28BD213C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1658962901;
        bh=pO2GKPhCZ0/STsKTAzAQh3+K4aMTP5A/BqeWnzeSEQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCuWY0Oi0ycwWjT6jQmbJjLV7SEOvevA3Nc9Sj6tx4RYuoVJwEqW4CudYz7aF5ol1
         NY2drWVPzVTFGaVRVaMeI1iFC1yYEAqdRnidDDQCe5ydVMi601933ad04n6HGp2NcV
         SZMeZk4kfMwQv9dQsECPBM6xiMcNLFlzL6pK+AUE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 12/12] wifi: mt76: mt7915: add rx-ppdu-size-out-of-range ethtool counter
Date:   Wed, 27 Jul 2022 16:01:22 -0700
Message-Id: <20220727230122.29842-12-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220727230122.29842-1-greearb@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1658962902-FUVu7abVkSsQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Support this additional MIB counter, it shares register with
the rx-fifo-overflow counter.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index afd480dd255b..921fad4a3873 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2490,6 +2490,7 @@ void mt7915_mac_update_stats(struct mt7915_phy *phy)
 
 	cnt = mt76_rr(dev, MT_MIB_SDR4(phy->band_idx));
 	mib->rx_fifo_full_cnt += FIELD_GET(MT_MIB_SDR4_RX_FIFO_FULL_MASK, cnt);
+	mib->rx_oor_cnt += FIELD_GET(MT_MIB_SDR4_RX_OOR_MASK, cnt);
 
 	cnt = mt76_rr(dev, MT_MIB_SDR5(phy->band_idx));
 	mib->rx_mpdu_cnt += cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index f2e215468a38..4c847aac6de8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1148,6 +1148,7 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 
 	/* rx counters */
 	"rx_fifo_full_cnt",
+	"rx_oor_cnt", /* rx ppdu length is bad */
 	"rx_mpdu_cnt",
 	"channel_idle_cnt",
 	"rx_vector_mismatch_cnt",
@@ -1331,7 +1332,8 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 		data[ei++] = mib->tx_amsdu[i];
 
 	/* rx counters */
-	data[ei++] = mib->rx_fifo_full_cnt;
+	data[ei++] = mib->rx_fifo_full_cnt; /* group-5 might exacerbate this */
+	data[ei++] = mib->rx_oor_cnt;
 	data[ei++] = mib->rx_mpdu_cnt;
 	data[ei++] = mib->channel_idle_cnt;
 	data[ei++] = mib->rx_vector_mismatch_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c0bb87bf2a2c..895dff9d053c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -208,6 +208,7 @@ struct mib_stats {
 
 	/* rx stats */
 	u32 rx_fifo_full_cnt;
+	u32 rx_oor_cnt;
 	u32 channel_idle_cnt;
 	u32 rx_vector_mismatch_cnt;
 	u32 rx_delimiter_fail_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 8bbc9a0ae699..d8c0caa71122 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -292,6 +292,7 @@ enum offs_rev {
 
 #define MT_MIB_SDR4(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR4))
 #define MT_MIB_SDR4_RX_FIFO_FULL_MASK	GENMASK(15, 0)
+#define MT_MIB_SDR4_RX_OOR_MASK		GENMASK(23, 16)
 
 /* rx mpdu counter, full 32 bits */
 #define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, __OFFS(MIB_SDR5))
-- 
2.20.1

