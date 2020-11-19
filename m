Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A980F2B95CD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 16:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgKSPHZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Nov 2020 10:07:25 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:44584 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgKSPHY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Nov 2020 10:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1605798442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QAB02+/JKvAreox33eAGXaLpOOGb6c+roXTp6gkh2kg=;
        b=p3JdzyApjqwpQ914tVTHYoA8ncNUEJeSrZK3FMLWxQ/oUYjsAok39uxme72RaryfJQ4kiz
        wNnkhCkt0H2s8R7r7XJfTGbrPYOhZ7RB6aNWSo3j6yDv+xkdWwnMkn1+H3BwN8CkIjtQ/2
        teyo7SarT2XvDbAAoc2x3sRB5UfJ6r0=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 1/2] ath11k: Don't cast ath11k_skb_cb to ieee80211_tx_info.control
Date:   Thu, 19 Nov 2020 16:06:13 +0100
Message-Id: <20201119150614.216644-1-sven@narfation.org>
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
 drivers/net/wireless/ath/ath11k/mac.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7f8dd47d2333..0296ba925455 100644
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
@@ -4053,10 +4052,13 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ieee80211_vif *vif = info->control.vif;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	u32 info_flags = info->flags;
 	bool is_prb_rsp;
 	int ret;
 
-	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
+	skb_cb->vif = vif;
+
+	if (info_flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
 		skb_cb->flags |= ATH11K_SKB_HW_80211_ENCAP;
 	} else if (ieee80211_is_mgmt(hdr->frame_control)) {
 		is_prb_rsp = ieee80211_is_probe_resp(hdr->frame_control);
-- 
2.29.2

