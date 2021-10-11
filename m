Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9459E428C25
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 13:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhJKLjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 07:39:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59453 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234116AbhJKLjn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 07:39:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633952264; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4vwz7aHVdUALdF5TlTsrPwab7VvPjYxQb6AztxWw7JM=; b=CZE42j1mZINObVIKGojpwKMNni/V2yEnVwTCAnG2X3cPCYDgXKmxqdiukHSdyrBh7Upu3epN
 nwh32FEANjoF6QPF9MQh4WxdRsCoSv5gZjnorHhZnrq1rFqvbs7XvonrAjKa83NB0RIAlXR8
 QSZe+lWIQdSfDbs86grQcUgUBkc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 616421f6ff0285fb0a2c94d6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 11:37:26
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 827EBC4360D; Mon, 11 Oct 2021 11:37:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7F1CC4338F;
        Mon, 11 Oct 2021 11:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E7F1CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/6] ath11k: Add basic WoW functionalities
Date:   Mon, 11 Oct 2021 15:37:45 -0400
Message-Id: <20211011193750.4891-2-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011193750.4891-1-cjhuang@codeaurora.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Implement basic WoW functionalities such as magic-packet, disconnect
and pattern. The logic is very similar to ath10k.

When WoW is configured, ath11k_core_suspend and ath11k_core_resume
are skipped as WoW configuration and hif suspend/resume are done in
ath11k_wow_op_suspend() and ath11k_wow_op_resume().

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  22 ++
 drivers/net/wireless/ath/ath11k/core.h |   4 +
 drivers/net/wireless/ath/ath11k/htc.c  |   6 +
 drivers/net/wireless/ath/ath11k/htc.h  |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  |  59 +++--
 drivers/net/wireless/ath/ath11k/mac.h  |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 156 +++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  |  76 +++++-
 drivers/net/wireless/ath/ath11k/wow.c  | 409 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wow.h  |  36 +++
 10 files changed, 753 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 7e4b5b3..e67136b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -244,10 +244,18 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 int ath11k_core_suspend(struct ath11k_base *ab)
 {
 	int ret;
+	struct ath11k *ar;
 
 	if (!ab->hw_params.supports_suspend)
 		return -EOPNOTSUPP;
 
+	/* so far single_pdev_only chips have supports_suspend as true
+	 * and only the first pdev is valid.
+	 */
+	ar = ab->pdevs[0].ar;
+	if (!ar || ar->state != ATH11K_STATE_OFF)
+		return 0;
+
 	/* TODO: there can frames in queues so for now add delay as a hack.
 	 * Need to implement to handle and remove this delay.
 	 */
@@ -260,6 +268,12 @@ int ath11k_core_suspend(struct ath11k_base *ab)
 		return ret;
 	}
 
+	ret = ath11k_mac_wait_tx_complete(ar);
+	if (ret) {
+		ath11k_warn(ab, "failed to wait tx complete: %d\n", ret);
+		return ret;
+	}
+
 	ret = ath11k_wow_enable(ab);
 	if (ret) {
 		ath11k_warn(ab, "failed to enable wow during suspend: %d\n", ret);
@@ -292,10 +306,18 @@ EXPORT_SYMBOL(ath11k_core_suspend);
 int ath11k_core_resume(struct ath11k_base *ab)
 {
 	int ret;
+	struct ath11k *ar;
 
 	if (!ab->hw_params.supports_suspend)
 		return -EOPNOTSUPP;
 
+	/* so far signle_pdev_only chips have supports_suspend as true
+	 * and only the first pdev is valid.
+	 */
+	ar = ab->pdevs[0].ar;
+	if (!ar || ar->state != ATH11K_STATE_OFF)
+		return 0;
+
 	ret = ath11k_hif_resume(ab);
 	if (ret) {
 		ath11k_warn(ab, "failed to resume hif during resume: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 61e9684..565cffc 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -23,6 +23,7 @@
 #include "thermal.h"
 #include "dbring.h"
 #include "spectral.h"
+#include "wow.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -609,6 +610,9 @@ struct ath11k {
 	struct work_struct wmi_mgmt_tx_work;
 	struct sk_buff_head wmi_mgmt_tx_queue;
 
+	struct ath11k_wow wow;
+	struct completion target_suspend;
+	bool target_suspend_ack;
 	struct ath11k_per_peer_tx_stats peer_tx_stats;
 	struct list_head ppdu_stats_info;
 	u32 ppdu_stat_list_depth;
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 54b1d34..7711443 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -245,6 +245,11 @@ static void ath11k_htc_suspend_complete(struct ath11k_base *ab, bool ack)
 	complete(&ab->htc_suspend);
 }
 
+static void ath11k_wakeup_from_suspend(struct ath11k_base *ab)
+{
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "wakeup from suspend is received\n");
+}
+
 void ath11k_htc_rx_completion_handler(struct ath11k_base *ab,
 				      struct sk_buff *skb)
 {
@@ -349,6 +354,7 @@ void ath11k_htc_rx_completion_handler(struct ath11k_base *ab,
 			ath11k_htc_suspend_complete(ab, false);
 			break;
 		case ATH11K_HTC_MSG_WAKEUP_FROM_SUSPEND_ID:
+			ath11k_wakeup_from_suspend(ab);
 			break;
 		default:
 			ath11k_warn(ab, "ignoring unsolicited htc ep0 event %ld\n",
diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
index 6c8a469..eb22c29 100644
--- a/drivers/net/wireless/ath/ath11k/htc.h
+++ b/drivers/net/wireless/ath/ath11k/htc.h
@@ -13,6 +13,7 @@
 #include <linux/timer.h>
 
 struct ath11k_base;
+struct ath11k;
 
 #define HTC_HDR_ENDPOINTID                       GENMASK(7, 0)
 #define HTC_HDR_FLAGS                            GENMASK(15, 8)
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a254ef3..b32ef40 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -15,6 +15,8 @@
 #include "testmode.h"
 #include "peer.h"
 #include "debugfs_sta.h"
+#include "hif.h"
+#include "wow.h"
 
 #define CHAN2G(_channel, _freq, _flags) { \
 	.band                   = NL80211_BAND_2GHZ, \
@@ -6761,31 +6763,47 @@ static int ath11k_mac_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 	return -EOPNOTSUPP;
 }
 
-static void ath11k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-				u32 queues, bool drop)
+int ath11k_mac_flush_tx_complete(struct ath11k *ar)
 {
-	struct ath11k *ar = hw->priv;
 	long time_left;
-
-	if (drop)
-		return;
+	int ret = 0;
 
 	time_left = wait_event_timeout(ar->dp.tx_empty_waitq,
 				       (atomic_read(&ar->dp.num_tx_pending) == 0),
 				       ATH11K_FLUSH_TIMEOUT);
-	if (time_left == 0)
-		ath11k_warn(ar->ab, "failed to flush transmit queue %ld\n", time_left);
+	if (time_left == 0) {
+		ath11k_warn(ar->ab, "failed to flush transmit queue, data pkts pending %d\n",
+			    atomic_read(&ar->dp.num_tx_pending));
+		ret = -ETIMEDOUT;
+	}
 
 	time_left = wait_event_timeout(ar->txmgmt_empty_waitq,
 				       (atomic_read(&ar->num_pending_mgmt_tx) == 0),
 				       ATH11K_FLUSH_TIMEOUT);
-	if (time_left == 0)
-		ath11k_warn(ar->ab, "failed to flush mgmt transmit queue %ld\n",
-			    time_left);
+	if (time_left == 0) {
+		ath11k_warn(ar->ab, "failed to flush mgmt transmit queue, mgmt pkts pending %d\n",
+			    atomic_read(&ar->num_pending_mgmt_tx));
+		ret = -ETIMEDOUT;
+	}
 
-	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-		   "mac mgmt tx flush mgmt pending %d\n",
-		   atomic_read(&ar->num_pending_mgmt_tx));
+	return ret;
+}
+
+int ath11k_mac_wait_tx_complete(struct ath11k *ar)
+{
+	ath11k_mac_drain_tx(ar);
+	return ath11k_mac_flush_tx_complete(ar);
+}
+
+static void ath11k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+				u32 queues, bool drop)
+{
+	struct ath11k *ar = hw->priv;
+
+	if (drop)
+		return;
+
+	ath11k_mac_flush_tx_complete(ar);
 }
 
 static int
@@ -7358,6 +7376,13 @@ static const struct ieee80211_ops ath11k_ops = {
 	.flush				= ath11k_mac_op_flush,
 	.sta_statistics			= ath11k_mac_op_sta_statistics,
 	CFG80211_TESTMODE_CMD(ath11k_tm_cmd)
+
+#ifdef CONFIG_PM
+	.suspend			= ath11k_wow_op_suspend,
+	.resume				= ath11k_wow_op_resume,
+	.set_wakeup			= ath11k_wow_op_set_wakeup,
+#endif
+
 #ifdef CONFIG_ATH11K_DEBUGFS
 	.sta_add_debugfs		= ath11k_debugfs_sta_op_add,
 #endif
@@ -7717,6 +7742,12 @@ static int __ath11k_mac_register(struct ath11k *ar)
 
 	ar->hw->wiphy->max_ap_assoc_sta = ar->max_num_stations;
 
+	ret = ath11k_wow_init(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to init wow: %d\n", ret);
+		goto err_free_if_combs;
+	}
+
 	ar->hw->queues = ATH11K_HW_MAX_QUEUES;
 	ar->hw->wiphy->tx_queue_len = ATH11K_QUEUE_LEN;
 	ar->hw->offchannel_tx_hw_queue = ATH11K_HW_MAX_QUEUES - 1;
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index fd04807..d04d4aa 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -174,4 +174,5 @@ void ath11k_mac_handle_beacon_miss(struct ath11k *ar, u32 vdev_id);
 void ath11k_mac_fill_reg_tpc_info(struct ath11k *ar,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_chanctx_conf *ctx);
+int ath11k_mac_wait_tx_complete(struct ath11k *ar);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8f46864..4fe56b7 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8390,3 +8390,159 @@ int ath11k_wmi_wow_enable(struct ath11k *ar)
 
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
 }
+
+int ath11k_wmi_wow_add_wakeup_event(struct ath11k *ar, u32 vdev_id,
+				    enum wmi_wow_wakeup_event event,
+				u32 enable)
+{
+	struct wmi_wow_add_del_event_cmd *cmd;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd);
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_wow_add_del_event_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_WOW_ADD_DEL_EVT_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = vdev_id;
+	cmd->is_add = enable;
+	cmd->event_bitmap = (1 << event);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv wow add wakeup event %s enable %d vdev_id %d\n",
+		   wow_wakeup_event(event), enable, vdev_id);
+
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_DISABLE_WAKE_EVENT_CMDID);
+}
+
+int ath11k_wmi_wow_add_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id,
+			       const u8 *pattern, const u8 *mask,
+			   int pattern_len, int pattern_offset)
+{
+	struct wmi_wow_add_pattern_cmd *cmd;
+	struct wmi_wow_bitmap_pattern *bitmap;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	u8 *ptr;
+	size_t len;
+
+	len = sizeof(*cmd) +
+	      sizeof(*tlv) +			/* array struct */
+	      sizeof(*bitmap) +			/* bitmap */
+	      sizeof(*tlv) +			/* empty ipv4 sync */
+	      sizeof(*tlv) +			/* empty ipv6 sync */
+	      sizeof(*tlv) +			/* empty magic */
+	      sizeof(*tlv) +			/* empty info timeout */
+	      sizeof(*tlv) + sizeof(u32);	/* ratelimit interval */
+
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	/* cmd */
+	ptr = (u8 *)skb->data;
+	cmd = (struct wmi_wow_add_pattern_cmd *)ptr;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_WOW_ADD_PATTERN_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = vdev_id;
+	cmd->pattern_id = pattern_id;
+	cmd->pattern_type = WOW_BITMAP_PATTERN;
+
+	ptr += sizeof(*cmd);
+
+	/* bitmap */
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG,
+				 WMI_TAG_ARRAY_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN, sizeof(*bitmap));
+
+	ptr += sizeof(*tlv);
+
+	bitmap = (struct wmi_wow_bitmap_pattern *)ptr;
+	bitmap->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+					WMI_TAG_WOW_BITMAP_PATTERN_T) |
+			     FIELD_PREP(WMI_TLV_LEN, sizeof(*bitmap) - TLV_HDR_SIZE);
+
+	memcpy(bitmap->patternbuf, pattern, pattern_len);
+	memcpy(bitmap->bitmaskbuf, mask, pattern_len);
+	bitmap->pattern_offset = pattern_offset;
+	bitmap->pattern_len = pattern_len;
+	bitmap->bitmask_len = pattern_len;
+	bitmap->pattern_id = pattern_id;
+
+	ptr += sizeof(*bitmap);
+
+	/* ipv4 sync */
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG,
+				 WMI_TAG_ARRAY_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN, 0);
+
+	ptr += sizeof(*tlv);
+
+	/* ipv6 sync */
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG,
+				 WMI_TAG_ARRAY_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN, 0);
+
+	ptr += sizeof(*tlv);
+
+	/* magic */
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG,
+				 WMI_TAG_ARRAY_STRUCT) |
+		      FIELD_PREP(WMI_TLV_LEN, 0);
+
+	ptr += sizeof(*tlv);
+
+	/* pattern info timeout */
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG,
+				 WMI_TAG_ARRAY_UINT32) |
+		      FIELD_PREP(WMI_TLV_LEN, 0);
+
+	ptr += sizeof(*tlv);
+
+	/* ratelimit interval */
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG,
+				 WMI_TAG_ARRAY_UINT32) |
+		      FIELD_PREP(WMI_TLV_LEN, sizeof(u32));
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv wow add pattern vdev_id %d pattern_id %d, pattern_offset %d\n",
+		   vdev_id, pattern_id, pattern_offset);
+
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ADD_WAKE_PATTERN_CMDID);
+}
+
+int ath11k_wmi_wow_del_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id)
+{
+	struct wmi_wow_del_pattern_cmd *cmd;
+	struct sk_buff *skb;
+	size_t len;
+
+	len = sizeof(*cmd);
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_wow_del_pattern_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_WOW_DEL_PATTERN_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = vdev_id;
+	cmd->pattern_id = pattern_id;
+	cmd->pattern_type = WOW_BITMAP_PATTERN;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "wmi tlv wow del pattern vdev_id %d pattern_id %d\n",
+		   vdev_id, pattern_id);
+
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_DEL_WAKE_PATTERN_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index e2cce86..0e3a880 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5544,6 +5544,45 @@ static inline const char *wow_reason(enum wmi_wow_wake_reason reason)
 
 #undef C2S
 
+struct wmi_wow_ev_arg {
+	u32 vdev_id;
+	u32 flag;
+	enum wmi_wow_wake_reason wake_reason;
+	u32 data_len;
+};
+
+enum wmi_tlv_pattern_type {
+	WOW_PATTERN_MIN = 0,
+	WOW_BITMAP_PATTERN = WOW_PATTERN_MIN,
+	WOW_IPV4_SYNC_PATTERN,
+	WOW_IPV6_SYNC_PATTERN,
+	WOW_WILD_CARD_PATTERN,
+	WOW_TIMER_PATTERN,
+	WOW_MAGIC_PATTERN,
+	WOW_IPV6_RA_PATTERN,
+	WOW_IOAC_PKT_PATTERN,
+	WOW_IOAC_TMR_PATTERN,
+	WOW_PATTERN_MAX
+};
+
+#define WOW_DEFAULT_BITMAP_PATTERN_SIZE		148
+#define WOW_DEFAULT_BITMASK_SIZE		148
+
+#define WOW_MIN_PATTERN_SIZE	1
+#define WOW_MAX_PATTERN_SIZE	148
+#define WOW_MAX_PKT_OFFSET	128
+#define WOW_HDR_LEN	(sizeof(struct ieee80211_hdr_3addr) + \
+	sizeof(struct rfc1042_hdr))
+#define WOW_MAX_REDUCE	(WOW_HDR_LEN - sizeof(struct ethhdr) - \
+	offsetof(struct ieee80211_hdr_3addr, addr1))
+
+struct wmi_wow_add_del_event_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 is_add;
+	u32 event_bitmap;
+} __packed;
+
 struct wmi_wow_enable_cmd {
 	u32 tlv_header;
 	u32 enable;
@@ -5556,12 +5595,36 @@ struct wmi_wow_host_wakeup_ind {
 	u32 reserved;
 } __packed;
 
-struct wmi_wow_ev_arg {
+struct wmi_tlv_wow_event_info {
 	u32 vdev_id;
 	u32 flag;
-	enum wmi_wow_wake_reason wake_reason;
+	u32 wake_reason;
 	u32 data_len;
-};
+} __packed;
+
+struct wmi_wow_bitmap_pattern {
+	u32 tlv_header;
+	u8 patternbuf[WOW_DEFAULT_BITMAP_PATTERN_SIZE];
+	u8 bitmaskbuf[WOW_DEFAULT_BITMASK_SIZE];
+	u32 pattern_offset;
+	u32 pattern_len;
+	u32 bitmask_len;
+	u32 pattern_id;
+} __packed;
+
+struct wmi_wow_add_pattern_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 pattern_id;
+	u32 pattern_type;
+} __packed;
+
+struct wmi_wow_del_pattern_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 pattern_id;
+	u32 pattern_type;
+} __packed;
 
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
@@ -5717,4 +5780,11 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 int ath11k_wmi_send_vdev_set_tpc_power(struct ath11k *ar,
 				       u32 vdev_id,
 				       struct ath11k_reg_tpc_power_info *param);
+int ath11k_wmi_wow_del_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id);
+int ath11k_wmi_wow_add_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id,
+			       const u8 *pattern, const u8 *mask,
+			       int pattern_len, int pattern_offset);
+int ath11k_wmi_wow_add_wakeup_event(struct ath11k *ar, u32 vdev_id,
+				    enum wmi_wow_wakeup_event event,
+				    u32 enable);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index 43c62e9..105a331 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -6,12 +6,22 @@
 #include <linux/delay.h>
 
 #include "mac.h"
+
+#include <net/mac80211.h>
 #include "core.h"
 #include "hif.h"
 #include "debug.h"
 #include "wmi.h"
 #include "wow.h"
 
+static const struct wiphy_wowlan_support ath11k_wowlan_support = {
+	.flags = WIPHY_WOWLAN_DISCONNECT |
+		 WIPHY_WOWLAN_MAGIC_PKT,
+	.pattern_min_len = WOW_MIN_PATTERN_SIZE,
+	.pattern_max_len = WOW_MAX_PATTERN_SIZE,
+	.max_pkt_offset = WOW_MAX_PKT_OFFSET,
+};
+
 int ath11k_wow_enable(struct ath11k_base *ab)
 {
 	struct ath11k *ar = ath11k_ab_to_ar(ab, 0);
@@ -71,3 +81,402 @@ int ath11k_wow_wakeup(struct ath11k_base *ab)
 
 	return 0;
 }
+
+static int ath11k_wow_vif_cleanup(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	int i, ret;
+
+	for (i = 0; i < WOW_EVENT_MAX; i++) {
+		ret = ath11k_wmi_wow_add_wakeup_event(ar, arvif->vdev_id, i, 0);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to issue wow wakeup for event %s on vdev %i: %d\n",
+				    wow_wakeup_event(i), arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ar->wow.max_num_patterns; i++) {
+		ret = ath11k_wmi_wow_del_pattern(ar, arvif->vdev_id, i);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to delete wow pattern %d for vdev %i: %d\n",
+				    i, arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ath11k_wow_cleanup(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath11k_wow_vif_cleanup(arvif);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to clean wow wakeups on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/* Convert a 802.3 format to a 802.11 format.
+ *         +------------+-----------+--------+----------------+
+ * 802.3:  |dest mac(6B)|src mac(6B)|type(2B)|     body...    |
+ *         +------------+-----------+--------+----------------+
+ *                |__         |_______    |____________  |________
+ *                   |                |                |          |
+ *         +--+------------+----+-----------+---------------+-----------+
+ * 802.11: |4B|dest mac(6B)| 6B |src mac(6B)|  8B  |type(2B)|  body...  |
+ *         +--+------------+----+-----------+---------------+-----------+
+ */
+static void ath11k_wow_convert_8023_to_80211(struct cfg80211_pkt_pattern *new,
+					     const struct cfg80211_pkt_pattern *old)
+{
+	u8 hdr_8023_pattern[ETH_HLEN] = {};
+	u8 hdr_8023_bit_mask[ETH_HLEN] = {};
+	u8 hdr_80211_pattern[WOW_HDR_LEN] = {};
+	u8 hdr_80211_bit_mask[WOW_HDR_LEN] = {};
+
+	int total_len = old->pkt_offset + old->pattern_len;
+	int hdr_80211_end_offset;
+
+	struct ieee80211_hdr_3addr *new_hdr_pattern =
+		(struct ieee80211_hdr_3addr *)hdr_80211_pattern;
+	struct ieee80211_hdr_3addr *new_hdr_mask =
+		(struct ieee80211_hdr_3addr *)hdr_80211_bit_mask;
+	struct ethhdr *old_hdr_pattern = (struct ethhdr *)hdr_8023_pattern;
+	struct ethhdr *old_hdr_mask = (struct ethhdr *)hdr_8023_bit_mask;
+	int hdr_len = sizeof(*new_hdr_pattern);
+
+	struct rfc1042_hdr *new_rfc_pattern =
+		(struct rfc1042_hdr *)(hdr_80211_pattern + hdr_len);
+	struct rfc1042_hdr *new_rfc_mask =
+		(struct rfc1042_hdr *)(hdr_80211_bit_mask + hdr_len);
+	int rfc_len = sizeof(*new_rfc_pattern);
+
+	memcpy(hdr_8023_pattern + old->pkt_offset,
+	       old->pattern, ETH_HLEN - old->pkt_offset);
+	memcpy(hdr_8023_bit_mask + old->pkt_offset,
+	       old->mask, ETH_HLEN - old->pkt_offset);
+
+	/* Copy destination address */
+	memcpy(new_hdr_pattern->addr1, old_hdr_pattern->h_dest, ETH_ALEN);
+	memcpy(new_hdr_mask->addr1, old_hdr_mask->h_dest, ETH_ALEN);
+
+	/* Copy source address */
+	memcpy(new_hdr_pattern->addr3, old_hdr_pattern->h_source, ETH_ALEN);
+	memcpy(new_hdr_mask->addr3, old_hdr_mask->h_source, ETH_ALEN);
+
+	/* Copy logic link type */
+	memcpy(&new_rfc_pattern->snap_type,
+	       &old_hdr_pattern->h_proto,
+	       sizeof(old_hdr_pattern->h_proto));
+	memcpy(&new_rfc_mask->snap_type,
+	       &old_hdr_mask->h_proto,
+	       sizeof(old_hdr_mask->h_proto));
+
+	/* Compute new pkt_offset */
+	if (old->pkt_offset < ETH_ALEN)
+		new->pkt_offset = old->pkt_offset +
+			offsetof(struct ieee80211_hdr_3addr, addr1);
+	else if (old->pkt_offset < offsetof(struct ethhdr, h_proto))
+		new->pkt_offset = old->pkt_offset +
+			offsetof(struct ieee80211_hdr_3addr, addr3) -
+			offsetof(struct ethhdr, h_source);
+	else
+		new->pkt_offset = old->pkt_offset + hdr_len + rfc_len - ETH_HLEN;
+
+	/* Compute new hdr end offset */
+	if (total_len > ETH_HLEN)
+		hdr_80211_end_offset = hdr_len + rfc_len;
+	else if (total_len > offsetof(struct ethhdr, h_proto))
+		hdr_80211_end_offset = hdr_len + rfc_len + total_len - ETH_HLEN;
+	else if (total_len > ETH_ALEN)
+		hdr_80211_end_offset = total_len - ETH_ALEN +
+			offsetof(struct ieee80211_hdr_3addr, addr3);
+	else
+		hdr_80211_end_offset = total_len +
+			offsetof(struct ieee80211_hdr_3addr, addr1);
+
+	new->pattern_len = hdr_80211_end_offset - new->pkt_offset;
+
+	memcpy((u8 *)new->pattern,
+	       hdr_80211_pattern + new->pkt_offset,
+	       new->pattern_len);
+	memcpy((u8 *)new->mask,
+	       hdr_80211_bit_mask + new->pkt_offset,
+	       new->pattern_len);
+
+	if (total_len > ETH_HLEN) {
+		/* Copy frame body */
+		memcpy((u8 *)new->pattern + new->pattern_len,
+		       (void *)old->pattern + ETH_HLEN - old->pkt_offset,
+		       total_len - ETH_HLEN);
+		memcpy((u8 *)new->mask + new->pattern_len,
+		       (void *)old->mask + ETH_HLEN - old->pkt_offset,
+		       total_len - ETH_HLEN);
+
+		new->pattern_len += total_len - ETH_HLEN;
+	}
+}
+
+static int ath11k_vif_wow_set_wakeups(struct ath11k_vif *arvif,
+				      struct cfg80211_wowlan *wowlan)
+{
+	int ret, i;
+	unsigned long wow_mask = 0;
+	struct ath11k *ar = arvif->ar;
+	const struct cfg80211_pkt_pattern *patterns = wowlan->patterns;
+	int pattern_id = 0;
+
+	/* Setup requested WOW features */
+	switch (arvif->vdev_type) {
+	case WMI_VDEV_TYPE_IBSS:
+		__set_bit(WOW_BEACON_EVENT, &wow_mask);
+		fallthrough;
+	case WMI_VDEV_TYPE_AP:
+		__set_bit(WOW_DEAUTH_RECVD_EVENT, &wow_mask);
+		__set_bit(WOW_DISASSOC_RECVD_EVENT, &wow_mask);
+		__set_bit(WOW_PROBE_REQ_WPS_IE_EVENT, &wow_mask);
+		__set_bit(WOW_AUTH_REQ_EVENT, &wow_mask);
+		__set_bit(WOW_ASSOC_REQ_EVENT, &wow_mask);
+		__set_bit(WOW_HTT_EVENT, &wow_mask);
+		__set_bit(WOW_RA_MATCH_EVENT, &wow_mask);
+		break;
+	case WMI_VDEV_TYPE_STA:
+		if (wowlan->disconnect) {
+			__set_bit(WOW_DEAUTH_RECVD_EVENT, &wow_mask);
+			__set_bit(WOW_DISASSOC_RECVD_EVENT, &wow_mask);
+			__set_bit(WOW_BMISS_EVENT, &wow_mask);
+			__set_bit(WOW_CSA_IE_EVENT, &wow_mask);
+		}
+
+		if (wowlan->magic_pkt)
+			__set_bit(WOW_MAGIC_PKT_RECVD_EVENT, &wow_mask);
+		break;
+	default:
+		break;
+	}
+
+	for (i = 0; i < wowlan->n_patterns; i++) {
+		u8 bitmask[WOW_MAX_PATTERN_SIZE] = {};
+		u8 ath_pattern[WOW_MAX_PATTERN_SIZE] = {};
+		u8 ath_bitmask[WOW_MAX_PATTERN_SIZE] = {};
+		struct cfg80211_pkt_pattern new_pattern = {};
+		struct cfg80211_pkt_pattern old_pattern = patterns[i];
+		int j;
+
+		new_pattern.pattern = ath_pattern;
+		new_pattern.mask = ath_bitmask;
+		if (patterns[i].pattern_len > WOW_MAX_PATTERN_SIZE)
+			continue;
+		/* convert bytemask to bitmask */
+		for (j = 0; j < patterns[i].pattern_len; j++)
+			if (patterns[i].mask[j / 8] & BIT(j % 8))
+				bitmask[j] = 0xff;
+		old_pattern.mask = bitmask;
+		new_pattern = old_pattern;
+
+		if (ar->wmi->wmi_ab->wlan_resource_config.rx_decap_mode ==
+		    ATH11K_HW_TXRX_NATIVE_WIFI) {
+			if (patterns[i].pkt_offset < ETH_HLEN)
+				ath11k_wow_convert_8023_to_80211(&new_pattern,
+								 &old_pattern);
+			else
+				new_pattern.pkt_offset += WOW_HDR_LEN - ETH_HLEN;
+		}
+
+		if (WARN_ON(new_pattern.pattern_len > WOW_MAX_PATTERN_SIZE))
+			return -EINVAL;
+
+		ret = ath11k_wmi_wow_add_pattern(ar, arvif->vdev_id,
+						 pattern_id,
+						 new_pattern.pattern,
+						 new_pattern.mask,
+						 new_pattern.pattern_len,
+						 new_pattern.pkt_offset);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to add pattern %i to vdev %i: %d\n",
+				    pattern_id,
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+
+		pattern_id++;
+		__set_bit(WOW_PATTERN_MATCH_EVENT, &wow_mask);
+	}
+
+	for (i = 0; i < WOW_EVENT_MAX; i++) {
+		if (!test_bit(i, &wow_mask))
+			continue;
+		ret = ath11k_wmi_wow_add_wakeup_event(ar, arvif->vdev_id, i, 1);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to enable wakeup event %s on vdev %i: %d\n",
+				    wow_wakeup_event(i), arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ath11k_wow_set_wakeups(struct ath11k *ar,
+				  struct cfg80211_wowlan *wowlan)
+{
+	struct ath11k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath11k_vif_wow_set_wakeups(arvif, wowlan);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set wow wakeups on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
+			  struct cfg80211_wowlan *wowlan)
+{
+	struct ath11k *ar = hw->priv;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ret =  ath11k_wow_cleanup(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to clear wow wakeup events: %d\n",
+			    ret);
+		goto exit;
+	}
+
+	ret = ath11k_wow_set_wakeups(ar, wowlan);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set wow wakeup events: %d\n",
+			    ret);
+		goto cleanup;
+	}
+
+	ret = ath11k_mac_wait_tx_complete(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to wait tx complete: %d\n", ret);
+		goto cleanup;
+	}
+
+	ret = ath11k_wow_enable(ar->ab);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to start wow: %d\n", ret);
+		goto cleanup;
+	}
+
+	ath11k_ce_stop_shadow_timers(ar->ab);
+	ath11k_dp_stop_shadow_timers(ar->ab);
+
+	ath11k_hif_irq_disable(ar->ab);
+	ath11k_hif_ce_irq_disable(ar->ab);
+
+	ret = ath11k_hif_suspend(ar->ab);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to suspend hif: %d\n", ret);
+		goto wakeup;
+	}
+
+	goto exit;
+
+wakeup:
+	ath11k_wow_wakeup(ar->ab);
+
+cleanup:
+	ath11k_wow_cleanup(ar);
+
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret ? 1 : 0;
+}
+
+void ath11k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled)
+{
+	struct ath11k *ar = hw->priv;
+
+	mutex_lock(&ar->conf_mutex);
+	device_set_wakeup_enable(ar->ab->dev, enabled);
+	mutex_unlock(&ar->conf_mutex);
+}
+
+int ath11k_wow_op_resume(struct ieee80211_hw *hw)
+{
+	struct ath11k *ar = hw->priv;
+	int ret;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ret = ath11k_hif_resume(ar->ab);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to resume hif: %d\n", ret);
+		goto exit;
+	}
+
+	ath11k_hif_ce_irq_enable(ar->ab);
+	ath11k_hif_irq_enable(ar->ab);
+
+	ret = ath11k_wow_wakeup(ar->ab);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to wakeup from wow: %d\n", ret);
+
+exit:
+	if (ret) {
+		switch (ar->state) {
+		case ATH11K_STATE_ON:
+			ar->state = ATH11K_STATE_RESTARTING;
+			ret = 1;
+			break;
+		case ATH11K_STATE_OFF:
+		case ATH11K_STATE_RESTARTING:
+		case ATH11K_STATE_RESTARTED:
+		case ATH11K_STATE_WEDGED:
+		case ATH11K_STATE_TM:
+			ath11k_warn(ar->ab, "encountered unexpected device state %d on resume, cannot recover\n",
+				    ar->state);
+			ret = -EIO;
+			break;
+		}
+	}
+
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+int ath11k_wow_init(struct ath11k *ar)
+{
+	if (WARN_ON(!test_bit(WMI_TLV_SERVICE_WOW, ar->wmi->wmi_ab->svc_map)))
+		return -EINVAL;
+
+	ar->wow.wowlan_support = ath11k_wowlan_support;
+
+	if (ar->wmi->wmi_ab->wlan_resource_config.rx_decap_mode ==
+	    ATH11K_HW_TXRX_NATIVE_WIFI) {
+		ar->wow.wowlan_support.pattern_max_len -= WOW_MAX_REDUCE;
+		ar->wow.wowlan_support.max_pkt_offset -= WOW_MAX_REDUCE;
+	}
+
+	ar->wow.max_num_patterns = ATH11K_WOW_PATTERNS;
+	ar->wow.wowlan_support.n_patterns = ar->wow.max_num_patterns;
+	ar->hw->wiphy->wowlan = &ar->wow.wowlan_support;
+
+	device_set_wakeup_capable(ar->ab->dev, true);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath11k/wow.h b/drivers/net/wireless/ath/ath11k/wow.h
index dabc4ee..6e27297 100644
--- a/drivers/net/wireless/ath/ath11k/wow.h
+++ b/drivers/net/wireless/ath/ath11k/wow.h
@@ -3,8 +3,44 @@
  * Copyright (c) 2020 The Linux Foundation. All rights reserved.
  */
 
+#ifndef _WOW_H_
+#define _WOW_H_
+
+struct ath11k_wow {
+	u32 max_num_patterns;
+	struct completion wakeup_completed;
+	struct wiphy_wowlan_support wowlan_support;
+};
+
+struct rfc1042_hdr {
+	u8 llc_dsap;
+	u8 llc_ssap;
+	u8 llc_ctrl;
+	u8 snap_oui[3];
+	__be16 snap_type;
+} __packed;
+
 #define ATH11K_WOW_RETRY_NUM		3
 #define ATH11K_WOW_RETRY_WAIT_MS	200
+#define ATH11K_WOW_PATTERNS		22
 
 int ath11k_wow_enable(struct ath11k_base *ab);
 int ath11k_wow_wakeup(struct ath11k_base *ab);
+
+#ifdef CONFIG_PM
+
+int ath11k_wow_init(struct ath11k *ar);
+int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
+			  struct cfg80211_wowlan *wowlan);
+int ath11k_wow_op_resume(struct ieee80211_hw *hw);
+void ath11k_wow_op_set_wakeup(struct ieee80211_hw *hw, bool enabled);
+
+#else
+
+static inline int ath11k_wow_init(struct ath11k *ar)
+{
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+#endif /* _WOW_H_ */
-- 
2.7.4

