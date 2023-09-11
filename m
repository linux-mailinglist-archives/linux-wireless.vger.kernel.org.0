Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D751479BC86
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 02:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbjIKVsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 17:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbjIKSlz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 14:41:55 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F07D1A7
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WkXdiO68jJnbJQUnBoaimxKLTbA37DUiHPaNYaTfp9U=; b=IU51y0mu0Hugru/Q3iiqQskEyY
        85PzTU7y2kL0VwKNe2JI9wO+AS5KJJQXKgoPD9gqo4AlbhRPChDuUmdAI5S7BNzMB5EtRxC8tc5hd
        nv62psKlU5hMtUl7LiaYv1rb2XojtJRkYYZ8/6u2iDwPnLk+9GPJczCVLy0BR24TthdU=;
Received: from p4ff13705.dip0.t-ipconnect.de ([79.241.55.5] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qflr2-000t2k-FV
        for linux-wireless@vger.kernel.org; Mon, 11 Sep 2023 20:41:48 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: fix monitor mode issues
Date:   Mon, 11 Sep 2023 20:41:48 +0200
Message-ID: <20230911184148.51854-1-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable receiving other-unicast packets
Disable RX header translation in order to proprerly receive data packets.
Fixes warnings and missed packets when rx decap offload is enabled

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 24 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 ++
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 55809d9f7a7b..240483154faa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -483,16 +483,22 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 		bool band = phy->mt76->band_idx;
+		u32 rxfilter = phy->rxfilter;
 
-		if (!enabled)
-			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
-		else
-			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+		if (!enabled) {
+			rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
+			dev->monitor_mask &= ~BIT(band);
+		} else {
+			rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+			dev->monitor_mask |= BIT(band);
+		}
 
 		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
 			       enabled);
+		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_MDP_DCR0_RX_HDR_TRANS_EN,
+			       !dev->monitor_mask);
 		mt76_testmode_reset(phy->mt76, true);
-		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
+		mt76_wr(dev, MT_WF_RFCR(band), rxfilter);
 	}
 
 	mutex_unlock(&dev->mt76.mutex);
@@ -527,6 +533,7 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 			MT_WF_RFCR1_DROP_BA |
 			MT_WF_RFCR1_DROP_CFEND |
 			MT_WF_RFCR1_DROP_CFACK;
+	u32 rxfilter;
 	u32 flags = 0;
 
 #define MT76_FILTER(_flag, _hw) do {					\
@@ -561,7 +568,12 @@ static void mt7915_configure_filter(struct ieee80211_hw *hw,
 			     MT_WF_RFCR_DROP_NDPA);
 
 	*total_flags = flags;
-	mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
+	rxfilter = phy->rxfilter;
+	if (hw->conf.flags & IEEE80211_CONF_MONITOR)
+		rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
+	else
+		rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
+	mt76_wr(dev, MT_WF_RFCR(band), rxfilter);
 
 	if (*total_flags & FIF_CONTROL)
 		mt76_clear(dev, MT_WF_RFCR1(band), ctl_flags);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0456e56f6348..795c3e6f80ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -295,6 +295,8 @@ struct mt7915_dev {
 	bool muru_debug;
 	bool ibf;
 
+	u8 monitor_mask;
+
 	struct dentry *debugfs_dir;
 	struct rchan *relay_fwlog;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 588cd87e24e9..89ac8e6707b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -172,6 +172,7 @@ enum offs_rev {
 
 #define MT_MDP_DCR0			MT_MDP(0x000)
 #define MT_MDP_DCR0_DAMSDU_EN		BIT(15)
+#define MT_MDP_DCR0_RX_HDR_TRANS_EN	BIT(19)
 
 #define MT_MDP_DCR1			MT_MDP(0x004)
 #define MT_MDP_DCR1_MAX_RX_LEN		GENMASK(15, 3)
-- 
2.41.0

