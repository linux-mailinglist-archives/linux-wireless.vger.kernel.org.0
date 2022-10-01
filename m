Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F545F1CA3
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Oct 2022 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJAOTa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Oct 2022 10:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJAOT3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Oct 2022 10:19:29 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AD23D5BA
        for <linux-wireless@vger.kernel.org>; Sat,  1 Oct 2022 07:19:27 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.177])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 36F05A0068
        for <linux-wireless@vger.kernel.org>; Sat,  1 Oct 2022 14:19:26 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F231268006F
        for <linux-wireless@vger.kernel.org>; Sat,  1 Oct 2022 14:19:25 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 3D71413C2B0;
        Sat,  1 Oct 2022 07:19:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3D71413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1664633965;
        bh=wN3Rt9NIJEX0lXQd0cNLDBVTfR78iKkJf8tCvKOPJJY=;
        h=From:To:Cc:Subject:Date:From;
        b=Uk8OIBEozZrXNXeBmu1ISuWoRiRWahWgel5h5Ogy2c31s0oUxIzinM9SCMIjTEM+Z
         OIZhZIUz6Grsm4FVHtDkfNeUn8BDqZkkdjl/A/bPXzWCGHtfRAtKQ/rXorSrNa2XQo
         mStFuUKdllS6IdDXiOxZiDgq/6D2lryjSqa7jhWs=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>,
        Carson Vandegriffe <carson.vandegriffe@candelatech.com>
Subject: [RFC] Revert "mt76: use IEEE80211_OFFLOAD_ENCAP_ENABLED instead of MT_DRV_AMSDU_OFFLOAD"
Date:   Sat,  1 Oct 2022 07:19:20 -0700
Message-Id: <20221001141920.17592-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1664633966-qG6gzfKXCLgb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This reverts commit f17f4864504d754bcbf31e4c89412cdf9946c409.

The reverted commit significantly decreases performance when running
a test where two MTK7915 radios have 16 station vdevs each, configured
for AC mode, and transmitting UDP traffic to AP.

Reported-by: Carson Vandegriffe <carson.vandegriffe@candelatech.com>
Signed-off-by: Ben Greear <greearb@candelatech.com>
---

NOTE:  This patch fixes the performance regression we see, but maybe
there is a better way to fix it.

Test run before this patch:

http://www.candelatech.com/downloads/tr-398-2022-10-01-07-03-52-bad/

After this patch:

http://www.candelatech.com/downloads/tr-398-2022-10-01-07-04-50-good/

 drivers/net/wireless/mediatek/mt76/mac80211.c    | 8 ++++++--
 drivers/net/wireless/mediatek/mt76/mt76.h        | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 3 ++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 088f6de28500..bde99a478777 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -444,8 +444,12 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
-	ieee80211_hw_set(hw, TX_AMSDU);
-	ieee80211_hw_set(hw, TX_FRAG_LIST);
+
+	if (!(dev->drv->drv_flags & MT_DRV_AMSDU_OFFLOAD)) {
+		ieee80211_hw_set(hw, TX_AMSDU);
+		ieee80211_hw_set(hw, TX_FRAG_LIST);
+	}
+
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, AP_LINK_PS);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 531f52fa282f..82ef26ca5db1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -395,6 +395,7 @@ struct mt76_hw_cap {
 #define MT_DRV_SW_RX_AIRTIME		BIT(2)
 #define MT_DRV_RX_DMA_HDR		BIT(3)
 #define MT_DRV_HW_MGMT_TXQ		BIT(4)
+#define MT_DRV_AMSDU_OFFLOAD		BIT(5)
 
 struct mt76_driver_ops {
 	u32 drv_flags;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index c41b5b00e939..24c9fda005ca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -658,7 +658,8 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_fw_txp),
-		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
+			     MT_DRV_AMSDU_OFFLOAD,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ea3069d18c35..6a8f43879422 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -231,7 +231,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_hw_txp),
-		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
+			     MT_DRV_AMSDU_OFFLOAD,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
-- 
2.20.1

