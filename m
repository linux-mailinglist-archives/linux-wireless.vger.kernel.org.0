Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B4326241
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 13:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBZMCr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 07:02:47 -0500
Received: from z11.mailgun.us ([104.130.96.11]:33494 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhBZMCq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 07:02:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614340946; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jpruO1+MevPHLMOvmxcJcR7b+FAAZIJrSGev0HKg+e8=; b=s42bAJQlX70hD6GRRhHQp3kgrv3K1zVi16h8c3ZObNSHrhforvnzx7kErveLhcOhlGsvF4l+
 iQerDW8nNc0h+uqlIq/CWC7CbKe7BJ26OEYNSnbigaWPOEUoKEahwi6YoYf/Ekxzouw1i9E8
 0qCIhIt3WBkO/J1ctQXxF0wYQ/s=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6038e3096ba9d8a92bddfc0c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Feb 2021 12:01:13
 GMT
Sender: lavaks=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F429C43461; Fri, 26 Feb 2021 12:01:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from lavaks-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lavaks)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F245BC433C6;
        Fri, 26 Feb 2021 12:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F245BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=lavaks@codeaurora.org
From:   Lavanya Suresh <lavaks@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: [PATCH] ath11k: Add support for STA to handle beacon miss
Date:   Fri, 26 Feb 2021 17:30:59 +0530
Message-Id: <1614340859-28867-1-git-send-email-lavaks@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When AP goes down without any indication to STA, firmware detects
missing beacon, and sends wmi roam event with reason BEACON_MISS
to the host.

Added support for STA mode to trigger disassociation from AP,
on receiving this event from firmware.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01717-QCAHKSWPL_SILICONZ-1
Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  2 +
 drivers/net/wireless/ath/ath11k/mac.c  | 79 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/mac.h  |  2 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 11 ++---
 4 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index ad8e7cf..9f4370d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -34,6 +34,7 @@
 #define ATH11K_PRB_RSP_DROP_THRESHOLD ((ATH11K_TX_MGMT_TARGET_MAX_SUPPORT_WMI * 3) / 4)
 
 #define ATH11K_INVALID_HW_MAC_ID	0xFF
+#define ATH11K_CONNECTION_LOSS_HZ	(3 * HZ)
 
 extern unsigned int ath11k_frame_mode;
 
@@ -235,6 +236,7 @@ struct ath11k_vif {
 	u32 aid;
 	u8 bssid[ETH_ALEN];
 	struct cfg80211_bitrate_mask bitrate_mask;
+	struct delayed_work connection_loss_work;
 	int num_legacy_stations;
 	int rtscts_prot_mode;
 	int txpower;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3c1f35a..c9bd615 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -829,6 +829,75 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev %d up\n", arvif->vdev_id);
 }
 
+static void ath11k_mac_handle_beacon_iter(void *data, u8 *mac,
+					  struct ieee80211_vif *vif)
+{
+	struct sk_buff *skb = data;
+	struct ieee80211_mgmt *mgmt = (void *)skb->data;
+	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (!ether_addr_equal(mgmt->bssid, vif->bss_conf.bssid))
+		return;
+
+	cancel_delayed_work(&arvif->connection_loss_work);
+}
+
+void ath11k_mac_handle_beacon(struct ath11k *ar, struct sk_buff *skb)
+{
+	ieee80211_iterate_active_interfaces_atomic(ar->hw,
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   ath11k_mac_handle_beacon_iter,
+						   skb);
+}
+
+static void ath11k_mac_handle_beacon_miss_iter(void *data, u8 *mac,
+					       struct ieee80211_vif *vif)
+{
+	u32 *vdev_id = data;
+	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k *ar = arvif->ar;
+	struct ieee80211_hw *hw = ar->hw;
+
+	if (arvif->vdev_id != *vdev_id)
+		return;
+
+	if (!arvif->is_up)
+		return;
+
+	ieee80211_beacon_loss(vif);
+
+	/* Firmware doesn't report beacon loss events repeatedly. If AP probe
+	 * (done by mac80211) succeeds but beacons do not resume then it
+	 * doesn't make sense to continue operation. Queue connection loss work
+	 * which can be cancelled when beacon is received.
+	 */
+	ieee80211_queue_delayed_work(hw, &arvif->connection_loss_work,
+				     ATH11K_CONNECTION_LOSS_HZ);
+}
+
+void ath11k_mac_handle_beacon_miss(struct ath11k *ar, u32 vdev_id)
+{
+	ieee80211_iterate_active_interfaces_atomic(ar->hw,
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   ath11k_mac_handle_beacon_miss_iter,
+						   &vdev_id);
+}
+
+static void ath11k_mac_vif_sta_connection_loss_work(struct work_struct *work)
+{
+	struct ath11k_vif *arvif = container_of(work, struct ath11k_vif,
+						connection_loss_work.work);
+	struct ieee80211_vif *vif = arvif->vif;
+
+	if (!arvif->is_up)
+		return;
+
+	ieee80211_connection_loss(vif);
+}
+
 static void ath11k_peer_assoc_h_basic(struct ath11k *ar,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
@@ -1760,7 +1829,7 @@ static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
 
 	arvif->is_up = false;
 
-	/* TODO: cancel connection_loss_work */
+	cancel_delayed_work_sync(&arvif->connection_loss_work);
 }
 
 static u32 ath11k_mac_get_rate_hw_value(int bitrate)
@@ -4615,10 +4684,8 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	arvif->vif = vif;
 
 	INIT_LIST_HEAD(&arvif->list);
-
-	/* Should we initialize any worker to handle connection loss indication
-	 * from firmware in sta mode?
-	 */
+	INIT_DELAYED_WORK(&arvif->connection_loss_work,
+			  ath11k_mac_vif_sta_connection_loss_work);
 
 	for (i = 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
 		arvif->bitrate_mask.control[i].legacy = 0xffffffff;
@@ -4827,6 +4894,8 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	int ret;
 	int i;
 
+	cancel_delayed_work_sync(&arvif->connection_loss_work);
+
 	mutex_lock(&ar->conf_mutex);
 
 	ath11k_dbg(ab, ATH11K_DBG_MAC, "mac remove interface (vdev %d)\n",
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 4555779..4bc59bd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -150,4 +150,6 @@ int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
 u8 ath11k_mac_bw_to_mac80211_bw(u8 bw);
 enum ath11k_supported_bw ath11k_mac_mac80211_bw_to_ath11k_bw(enum rate_info_bw bw);
 enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher);
+void ath11k_mac_handle_beacon(struct ath11k *ar, struct sk_buff *skb);
+void ath11k_mac_handle_beacon_miss(struct ath11k *ar, u32 vdev_id);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index ca5cda8..5ca2d80 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6171,10 +6171,8 @@ static void ath11k_mgmt_rx_event(struct ath11k_base *ab, struct sk_buff *skb)
 		}
 	}
 
-	/* TODO: Pending handle beacon implementation
-	 *if (ieee80211_is_beacon(hdr->frame_control))
-	 *	ath11k_mac_handle_beacon(ar, skb);
-	 */
+	if (ieee80211_is_beacon(hdr->frame_control))
+		ath11k_mac_handle_beacon(ar, skb);
 
 	ath11k_dbg(ab, ATH11K_DBG_MGMT,
 		   "event mgmt rx skb %pK len %d ftype %02x stype %02x\n",
@@ -6393,10 +6391,7 @@ static void ath11k_roam_event(struct ath11k_base *ab, struct sk_buff *skb)
 
 	switch (roam_ev.reason) {
 	case WMI_ROAM_REASON_BEACON_MISS:
-		/* TODO: Pending beacon miss and connection_loss_work
-		 * implementation
-		 * ath11k_mac_handle_beacon_miss(ar, vdev_id);
-		 */
+		ath11k_mac_handle_beacon_miss(ar, roam_ev.vdev_id);
 		break;
 	case WMI_ROAM_REASON_BETTER_AP:
 	case WMI_ROAM_REASON_LOW_RSSI:
-- 
2.7.4

