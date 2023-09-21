Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0F7AA4BC
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 00:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjIUWQC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 18:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjIUWP0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 18:15:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1357EA2A
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1843DC3279F;
        Thu, 21 Sep 2023 10:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695293036;
        bh=JmPRwGD8tXRsnlGbou9Rh78/vsK7nzRrY8wYaA8z1qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KwutYm2orkJo8R5BbNM2OY0xhq6wxrn98m10MKv7lyRbBGyTO38s7sLJ29bIUkNpN
         fMIi9jnrUpfr0KopuniSf+rGImmiURVbQVYPGvoI31MYfg33Cw7rDfT/V5uP0xKr3Q
         /FSiWvJlrJFnXm+XVGfYr/LyQnRyvaH4zQ5WMRhPcV8Ygdu40UPtJyVqs8OCS43mmb
         h3rg0dTDZ/roYAV+fN1KHSH+PH8Kg9kKKMwDojaEm0uYoLcFTbHDJosAM/Q2LzJ57D
         UuvBhZ18XMjQ0lM6tx9RBCHnZTF12b6rn/qQf91EZSbLFMEq+wLfTDSsDj3d8z3/5Z
         ulMxDFtw5Kq3g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 3/9] wifi: mt76: move mt76_net_setup_tc in common code
Date:   Thu, 21 Sep 2023 12:43:32 +0200
Message-ID: <ce4092754b42ced1a2417fa7590bf5656b090abb.1695292502.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695292502.git.lorenzo@kernel.org>
References: <cover.1695292502.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce WED support for mt7996

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 16 ++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h        |  6 ++++++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 16 +---------------
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index cb76053973aa..15c4ca664b3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1842,3 +1842,19 @@ enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy)
 	return MT_DFS_STATE_ACTIVE;
 }
 EXPORT_SYMBOL_GPL(mt76_phy_dfs_state);
+
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+int mt76_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      struct net_device *netdev, enum tc_setup_type type,
+		      void *type_data)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mtk_wed_device *wed = &phy->dev->mmio.wed;
+
+	if (!mtk_wed_device_active(wed))
+		return -EOPNOTSUPP;
+
+	return mtk_wed_device_setup_tc(wed, netdev, type, type_data);
+}
+EXPORT_SYMBOL_GPL(mt76_net_setup_tc);
+#endif /* CONFIG_NET_MEDIATEK_SOC_WED */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 82e33a1b36ab..e8e9d9bc3730 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1047,6 +1047,12 @@ bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs);
 void mt76_pci_disable_aspm(struct pci_dev *pdev);
 
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+int mt76_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      struct net_device *netdev, enum tc_setup_type type,
+		      void *type_data);
+#endif /*CONFIG_NET_MEDIATEK_SOC_WED */
+
 static inline u16 mt76_chip(struct mt76_dev *dev)
 {
 	return dev->rev >> 16;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index a3fd54cc1911..ba34c8e19aab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1653,20 +1653,6 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 
 	return 0;
 }
-
-static int
-mt7915_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		    struct net_device *netdev, enum tc_setup_type type,
-		    void *type_data)
-{
-	struct mt7915_dev *dev = mt7915_hw_dev(hw);
-	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
-
-	if (!mtk_wed_device_active(wed))
-		return -EOPNOTSUPP;
-
-	return mtk_wed_device_setup_tc(wed, netdev, type, type_data);
-}
 #endif
 
 const struct ieee80211_ops mt7915_ops = {
@@ -1721,6 +1707,6 @@ const struct ieee80211_ops mt7915_ops = {
 	.set_radar_background = mt7915_set_radar_background,
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	.net_fill_forward_path = mt7915_net_fill_forward_path,
-	.net_setup_tc = mt7915_net_setup_tc,
+	.net_setup_tc = mt76_net_setup_tc,
 #endif
 };
-- 
2.41.0

