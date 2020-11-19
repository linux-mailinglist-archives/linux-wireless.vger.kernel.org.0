Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389982B9674
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgKSPm4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 10:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgKSPm4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 10:42:56 -0500
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8716CC0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 19 Nov 2020 07:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1605800572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xu11VYRmeRpj97DDc/i5ybj0mhVLi3KrB2seXXkbVyM=;
        b=r1Z4MrlY086jvNQf4FhMHcDZXYRdyvwqtG+GulMJpYqpMcRDjgB4RKDPvgYaWd18w2A8pv
        qfn3J2HX+4nJ31E7j9zTs1uEW4uUncuTaLa0LmMGJe38H1N9VFg8SsakDgEtNzmOZRi7ei
        CjkeG0HYq+mYdD+/BffWXoMPq2b0u1o=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v2 1/3] ath11k: Don't cast ath11k_skb_cb to ieee80211_tx_info.control
Date:   Thu, 19 Nov 2020 16:42:32 +0100
Message-Id: <20201119154235.263250-1-sven@narfation.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver_data area of ieee80211_tx_info is used in ath11k for
ath11k_skb_cb. The first function in the TX patch which rewrites it to
ath11k_skb_cb is already ath11k_mac_op_tx. No one else in the code path
must use it for something else before it reinitializes it. Otherwise the
data has to be considered uninitialized or corrupt.

But the ieee80211_tx_info.control shares exactly the same area as
ieee80211_tx_info.driver_data and ath11k is still using it. This results in
best case in a

  ath11k c000000.wifi1: no vif found for mgmt frame, flags 0x0

or (slightly worse) in a kernel oops.

Instead, the interesting data must be moved first into the ath11k_skb_cb
and ieee80211_tx_info.control must then not be used anymore.

Tested-on: IPQ8074 hw2.0 WLAN.HK.2.4.0.1.r1-00026-QCAHKSWPL_SILICONZ-2

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
- added cipher to cb to handle HAL_TCL_ENCAP_TYPE_RAW in ath11k_dp_tx

  + used u32 for the cipher instead of 8 byte point (aarch64) to save some
    space

 drivers/net/wireless/ath/ath11k/core.h  |  2 ++
 drivers/net/wireless/ath/ath11k/dp_tx.c |  5 ++---
 drivers/net/wireless/ath/ath11k/mac.c   | 26 ++++++++++++++++---------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 18b97420f0d8..5a7915f75e1e 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -75,12 +75,14 @@ static inline enum wme_ac ath11k_tid_to_ac(u32 tid)
 
 enum ath11k_skb_flags {
 	ATH11K_SKB_HW_80211_ENCAP = BIT(0),
+	ATH11K_SKB_CIPHER_SET = BIT(1),
 };
 
 struct ath11k_skb_cb {
 	dma_addr_t paddr;
 	u8 eid;
 	u8 flags;
+	u32 cipher;
 	struct ath11k *ar;
 	struct ieee80211_vif *vif;
 } __packed;
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 3d962eee4d61..21dfd08d3deb 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -84,7 +84,6 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	struct ath11k_dp *dp = &ab->dp;
 	struct hal_tx_info ti = {0};
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_key_conf *key = info->control.hw_key;
 	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
 	struct hal_srng *tcl_ring;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
@@ -149,9 +148,9 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	ti.meta_data_flags = arvif->tcl_metadata;
 
 	if (ti.encap_type == HAL_TCL_ENCAP_TYPE_RAW) {
-		if (key) {
+		if (skb_cb->flags & ATH11K_SKB_CIPHER_SET) {
 			ti.encrypt_type =
-				ath11k_dp_tx_get_encrypt_type(key->cipher);
+				ath11k_dp_tx_get_encrypt_type(skb_cb->cipher);
 
 			if (ieee80211_has_protected(hdr->frame_control))
 				skb_put(skb, IEEE80211_CCMP_MIC_LEN);
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7f8dd47d2333..05ed6ec99b55 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3977,21 +3977,20 @@ static void ath11k_mgmt_over_wmi_tx_purge(struct ath11k *ar)
 static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 {
 	struct ath11k *ar = container_of(work, struct ath11k, wmi_mgmt_tx_work);
-	struct ieee80211_tx_info *info;
+	struct ath11k_skb_cb *skb_cb;
 	struct ath11k_vif *arvif;
 	struct sk_buff *skb;
 	int ret;
 
 	while ((skb = skb_dequeue(&ar->wmi_mgmt_tx_queue)) != NULL) {
-		info = IEEE80211_SKB_CB(skb);
-		if (!info->control.vif) {
-			ath11k_warn(ar->ab, "no vif found for mgmt frame, flags 0x%x\n",
-				    info->control.flags);
+		skb_cb = ATH11K_SKB_CB(skb);
+		if (!skb_cb->vif) {
+			ath11k_warn(ar->ab, "no vif found for mgmt frame\n");
 			ieee80211_free_txskb(ar->hw, skb);
 			continue;
 		}
 
-		arvif = ath11k_vif_to_arvif(info->control.vif);
+		arvif = ath11k_vif_to_arvif(skb_cb->vif);
 		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id) &&
 		    arvif->is_started) {
 			ret = ath11k_mac_mgmt_tx_wmi(ar, arvif, skb);
@@ -4004,8 +4003,8 @@ static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 			}
 		} else {
 			ath11k_warn(ar->ab,
-				    "dropping mgmt frame for vdev %d, flags 0x%x is_started %d\n",
-				    arvif->vdev_id, info->control.flags,
+				    "dropping mgmt frame for vdev %d, is_started %d\n",
+				    arvif->vdev_id,
 				    arvif->is_started);
 			ieee80211_free_txskb(ar->hw, skb);
 		}
@@ -4053,10 +4052,19 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ieee80211_vif *vif = info->control.vif;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	u32 info_flags = info->flags;
 	bool is_prb_rsp;
 	int ret;
 
-	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+	skb_cb->vif = vif;
+
+	if (key) {
+		skb_cb->cipher = key->cipher;
+		skb_cb->flags |= ATH11K_SKB_CIPHER_SET;
+	}
+
+	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
 		skb_cb->flags |= ATH11K_SKB_HW_80211_ENCAP;
 	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
 		is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
-- 
2.29.2

