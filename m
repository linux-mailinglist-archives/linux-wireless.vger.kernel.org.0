Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869D4729CC9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjFIOZY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 10:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbjFIOZA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 10:25:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833930F6
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 07:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0F6460F55
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 14:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6FEC433D2;
        Fri,  9 Jun 2023 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320697;
        bh=Tn5xdpP3ZVCbWQ2pxQeNA98z1MSs+dcYpZ0Y4uUh4q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EI9NlN7WUXp29e8QA/lzo/FyVHUcuI6NgEu1SY2b6a5hv4k28L93qthI2o0iDC0wm
         FcJ0jy4D6FQJt41Ti6ZW2mcIawwRuqmut1+zsEfEvTdR/YNLbQEXPVT75nJ1y6XMRI
         IZNYFnXWpVylMe1cZc2sjsmavDcEYgRV1AjzXRHpH3eQctQO9cXF+FF9Kc+E8xH49V
         PY10P2w4WVXnUjanL84r/JRlMOwko/NZdtqElY9HuHGBciavilFRqnIZLM1BXjTfdL
         tGiUKF63QrfE2zhNLs/K2wRQhvXObkXkM40xD2x9oNcicUaOIVFPRshEkyOJLnYAoI
         Xao1Mo2IMZ0hQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 13/15] wifi: ath11k: don't use %pK
Date:   Fri,  9 Jun 2023 17:24:38 +0300
Message-Id: <20230609142440.24643-14-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609142440.24643-1-kvalo@kernel.org>
References: <20230609142440.24643-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

According to Documentation/core-api/printk-formats.rst %pK should not be used
with printk(), so switch back to using just %p. printk() will hash the address
so addresses are not leaked to user space.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c |  6 +++---
 drivers/net/wireless/ath/ath11k/htc.c   |  4 ++--
 drivers/net/wireless/ath/ath11k/mac.c   | 10 +++++-----
 drivers/net/wireless/ath/ath11k/pci.c   |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.c   |  4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 0ed3d2580e91..5c76664ba0dd 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2466,7 +2466,7 @@ static void ath11k_dp_rx_deliver_msdu(struct ath11k *ar, struct napi_struct *nap
 	spin_unlock_bh(&ar->ab->base_lock);
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_DATA,
-		   "rx skb %pK len %u peer %pM %d %s sn %u %s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
+		   "rx skb %p len %u peer %pM %d %s sn %u %s%s%s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
 		   msdu,
 		   msdu->len,
 		   peer ? peer->addr : NULL,
@@ -4908,7 +4908,7 @@ ath11k_dp_rx_mon_merg_msdus(struct ath11k *ar,
 			goto err_merge_fail;
 
 		ath11k_dbg(ab, ATH11K_DBG_DATA,
-			   "mpdu_buf %pK mpdu_buf->len %u",
+			   "mpdu_buf %p mpdu_buf->len %u",
 			   prev_buf, prev_buf->len);
 	} else {
 		ath11k_dbg(ab, ATH11K_DBG_DATA,
@@ -5099,7 +5099,7 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 
 	if (!mon_dst_srng) {
 		ath11k_warn(ar->ab,
-			    "HAL Monitor Destination Ring Init Failed -- %pK",
+			    "HAL Monitor Destination Ring Init Failed -- %p",
 			    mon_dst_srng);
 		return;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 7d277cd60b07..deace873da85 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -46,7 +46,7 @@ static struct sk_buff *ath11k_htc_build_tx_ctrl_skb(void *ab)
 	skb_cb = ATH11K_SKB_CB(skb);
 	memset(skb_cb, 0, sizeof(*skb_cb));
 
-	ath11k_dbg(ab, ATH11K_DBG_HTC, "%s: skb %pK\n", __func__, skb);
+	ath11k_dbg(ab, ATH11K_DBG_HTC, "%s: skb %p\n", __func__, skb);
 	return skb;
 }
 
@@ -393,7 +393,7 @@ void ath11k_htc_rx_completion_handler(struct ath11k_base *ab,
 		goto out;
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_HTC, "rx completion ep %d skb %pK\n",
+	ath11k_dbg(ab, ATH11K_DBG_HTC, "rx completion ep %d skb %p\n",
 		   eid, skb);
 	ep->ep_ops.ep_rx_complete(ab, skb);
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1bb2a88fecb2..32d958b66ba4 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7144,7 +7144,7 @@ static int ath11k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_base *ab = ar->ab;
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "chanctx add freq %u width %d ptr %pK\n",
+		   "chanctx add freq %u width %d ptr %p\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx);
 
 	mutex_lock(&ar->conf_mutex);
@@ -7168,7 +7168,7 @@ static void ath11k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_base *ab = ar->ab;
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "chanctx remove freq %u width %d ptr %pK\n",
+		   "chanctx remove freq %u width %d ptr %p\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx);
 
 	mutex_lock(&ar->conf_mutex);
@@ -7522,7 +7522,7 @@ static void ath11k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "chanctx change freq %u width %d ptr %pK changed %x\n",
+		   "chanctx change freq %u width %d ptr %p changed %x\n",
 		   ctx->def.chan->center_freq, ctx->def.width, ctx, changed);
 
 	/* This shouldn't really happen because channel switching should use
@@ -7603,7 +7603,7 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "chanctx assign ptr %pK vdev_id %i\n",
+		   "chanctx assign ptr %p vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
 	/* for QCA6390 bss peer must be created before vdev_start */
@@ -7693,7 +7693,7 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC,
-		   "chanctx unassign ptr %pK vdev_id %i\n",
+		   "chanctx unassign ptr %p vdev_id %i\n",
 		   ctx, arvif->vdev_id);
 
 	WARN_ON(!arvif->is_started);
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index ee67bfd90abe..79e2cbe82638 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -545,7 +545,7 @@ static int ath11k_pci_claim(struct ath11k_pci *ab_pci, struct pci_dev *pdev)
 
 	ab->mem_ce = ab->mem;
 
-	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pci_mem 0x%pK\n", ab->mem);
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pci_mem 0x%p\n", ab->mem);
 	return 0;
 
 release_region:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 17d565b03238..6dc2109557bc 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6439,7 +6439,7 @@ static int ath11k_wmi_tlv_rssi_chain_parse(struct ath11k_base *ab,
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "stats bssid %pM vif %pK\n",
+		   "stats bssid %pM vif %p\n",
 		   arvif->bssid, arvif->vif);
 
 	sta = ieee80211_find_sta_by_ifaddr(ar->hw,
@@ -7634,7 +7634,7 @@ static void ath11k_mgmt_rx_event(struct ath11k_base *ab, struct sk_buff *skb)
 		ath11k_mac_handle_beacon(ar, skb);
 
 	ath11k_dbg(ab, ATH11K_DBG_MGMT,
-		   "event mgmt rx skb %pK len %d ftype %02x stype %02x\n",
+		   "event mgmt rx skb %p len %d ftype %02x stype %02x\n",
 		   skb, skb->len,
 		   fc & IEEE80211_FCTL_FTYPE, fc & IEEE80211_FCTL_STYPE);
 
-- 
2.30.2

