Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5F94B28BC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 16:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351223AbiBKPIT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 10:08:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351216AbiBKPIS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 10:08:18 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA47304
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 07:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644592097; x=1676128097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=hP4FP2KmgQC8N5CZYSPezY/YY9L5vKXU4ZTQ8wfZZl4=;
  b=AHb0UPk6N9DFSAaLj4EBdSpFSyn1FR9jI7xweKEWFUsO0xhl6bLbSJSR
   lLxooqEypkGGIGN51FjJHoaqBVxymqukhqQa8Fla/7XsMNHlT6cbY+bGg
   K28mCiG2PylEuY8BHPwihjHK/by418hjw5QNxtGMLIcN99I40vZC8bo/2
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 07:08:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:08:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 07:08:15 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 07:08:13 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCH 4/6] ath11k: register vendor sub command for CFR configuration
Date:   Fri, 11 Feb 2022 20:37:53 +0530
Message-ID: <1644592075-27082-5-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
References: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to parse CFR parameters configured through
the vendor commands.

Also, send the required WMI commands to the firmware based
on the CFR configurations.

Tested-on: IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/Makefile |   3 +-
 drivers/net/wireless/ath/ath11k/cfr.c    | 227 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h    |  72 ++++++++++
 drivers/net/wireless/ath/ath11k/core.h   |  11 ++
 drivers/net/wireless/ath/ath11k/mac.c    |  18 ++-
 drivers/net/wireless/ath/ath11k/vendor.c | 192 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/vendor.h |  13 ++
 drivers/net/wireless/ath/ath11k/wmi.c    |  58 +++++++-
 drivers/net/wireless/ath/ath11k/wmi.h    |  51 ++++++-
 9 files changed, 639 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/vendor.c
 create mode 100644 drivers/net/wireless/ath/ath11k/vendor.h

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
index 36ffd2e..7eb4c52 100644
--- a/drivers/net/wireless/ath/ath11k/Makefile
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -17,7 +17,8 @@ ath11k-y += core.o \
 	    peer.o \
 	    dbring.o \
 	    hw.o \
-	    wow.o
+	    wow.o \
+	    vendor.o
 
 ath11k-$(CONFIG_ATH11K_DEBUGFS) += debugfs.o debugfs_htt_stats.o debugfs_sta.o
 ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index 00230e0..658b920 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -14,6 +14,233 @@ static int ath11k_cfr_process_data(struct ath11k *ar,
 	return 0;
 }
 
+/* Helper function to check whether the given peer mac address
+ * is in unassociated peer pool or not.
+ */
+bool ath11k_cfr_peer_is_in_cfr_unassoc_pool(struct ath11k *ar, const u8 *peer_mac)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	int i;
+
+	if (!ar->cfr_enabled)
+		return false;
+
+	spin_lock_bh(&cfr->lock);
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+		if (!entry->is_valid)
+			continue;
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+			spin_unlock_bh(&cfr->lock);
+			return true;
+		}
+	}
+
+	spin_unlock_bh(&cfr->lock);
+
+	return false;
+}
+
+void ath11k_cfr_update_unassoc_pool_entry(struct ath11k *ar,
+					  const u8 *peer_mac)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	int i;
+
+	spin_lock_bh(&cfr->lock);
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+		if (!entry->is_valid)
+			continue;
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac) &&
+		    entry->period == 0) {
+			memset(entry->peer_mac, 0, ETH_ALEN);
+			entry->is_valid = false;
+			cfr->cfr_enabled_peer_cnt--;
+			break;
+		}
+	}
+
+	spin_unlock_bh(&cfr->lock);
+}
+
+void ath11k_cfr_decrement_peer_count(struct ath11k *ar,
+				     struct ath11k_sta *arsta)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+
+	spin_lock_bh(&cfr->lock);
+
+	if (arsta->cfr_capture.cfr_enable)
+		cfr->cfr_enabled_peer_cnt--;
+
+	spin_unlock_bh(&cfr->lock);
+}
+
+static enum ath11k_wmi_cfr_capture_bw
+ath11k_cfr_bw_to_fw_cfr_bw(enum ath11k_cfr_capture_bw bw)
+{
+	switch (bw) {
+	case ATH11K_CFR_CAPTURE_BW_20:
+		return WMI_PEER_CFR_CAPTURE_BW_20;
+	case ATH11K_CFR_CAPTURE_BW_40:
+		return WMI_PEER_CFR_CAPTURE_BW_40;
+	case ATH11K_CFR_CAPTURE_BW_80:
+		return WMI_PEER_CFR_CAPTURE_BW_80;
+	default:
+		return WMI_PEER_CFR_CAPTURE_BW_MAX;
+	}
+}
+
+static enum ath11k_wmi_cfr_capture_method
+ath11k_cfr_method_to_fw_cfr_method(enum ath11k_cfr_capture_method method)
+{
+	switch (method) {
+	case ATH11K_CFR_CAPTURE_METHOD_NULL_FRAME:
+		return WMI_CFR_CAPTURE_METHOD_NULL_FRAME;
+	case ATH11K_CFR_CAPTURE_METHOD_NULL_FRAME_WITH_PHASE:
+		return WMI_CFR_CAPTURE_METHOD_NULL_FRAME_WITH_PHASE;
+	case ATH11K_CFR_CAPTURE_METHOD_PROBE_RESP:
+		return WMI_CFR_CAPTURE_METHOD_PROBE_RESP;
+	default:
+		return WMI_CFR_CAPTURE_METHOD_MAX;
+	}
+}
+
+int ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
+					 struct ath11k_sta *arsta,
+					 struct ath11k_per_peer_cfr_capture *params,
+					 const u8 *peer_mac)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct wmi_peer_cfr_capture_conf_arg arg;
+	enum ath11k_wmi_cfr_capture_bw bw;
+	enum ath11k_wmi_cfr_capture_method method;
+	int ret = 0;
+
+	if (cfr->cfr_enabled_peer_cnt >= ATH11K_MAX_CFR_ENABLED_CLIENTS &&
+	    !arsta->cfr_capture.cfr_enable) {
+		ath11k_err(ar->ab, "CFR enable peer threshold reached %u\n",
+			   cfr->cfr_enabled_peer_cnt);
+		return -ENOSPC;
+	}
+
+	if (params->cfr_enable == arsta->cfr_capture.cfr_enable &&
+	    params->cfr_period == arsta->cfr_capture.cfr_period &&
+	    params->cfr_method == arsta->cfr_capture.cfr_method &&
+	    params->cfr_bw == arsta->cfr_capture.cfr_bw)
+		return ret;
+
+	if (!params->cfr_enable && !arsta->cfr_capture.cfr_enable)
+		return ret;
+
+	bw = ath11k_cfr_bw_to_fw_cfr_bw(params->cfr_bw);
+	if (bw >= WMI_PEER_CFR_CAPTURE_BW_MAX) {
+		ath11k_warn(ar->ab, "FW doesn't support configured bw %d\n",
+			    params->cfr_bw);
+		return -EINVAL;
+	}
+
+	method = ath11k_cfr_method_to_fw_cfr_method(params->cfr_method);
+	if (method >= WMI_CFR_CAPTURE_METHOD_MAX) {
+		ath11k_warn(ar->ab, "FW doesn't support configured method %d\n",
+			    params->cfr_method);
+		return -EINVAL;
+	}
+
+	arg.request = params->cfr_enable;
+	arg.periodicity = params->cfr_period;
+	arg.bw = bw;
+	arg.method = method;
+
+	ret = ath11k_wmi_peer_set_cfr_capture_conf(ar, arsta->arvif->vdev_id,
+						   peer_mac, &arg);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send cfr capture info: vdev_id %u peer %pM\n",
+			    arsta->arvif->vdev_id, peer_mac);
+		return ret;
+	}
+
+	spin_lock_bh(&cfr->lock);
+
+	if (params->cfr_enable &&
+	    params->cfr_enable != arsta->cfr_capture.cfr_enable)
+		cfr->cfr_enabled_peer_cnt++;
+	else if (!params->cfr_enable)
+		cfr->cfr_enabled_peer_cnt--;
+
+	spin_unlock_bh(&cfr->lock);
+
+	arsta->cfr_capture.cfr_enable = params->cfr_enable;
+	arsta->cfr_capture.cfr_period = params->cfr_period;
+	arsta->cfr_capture.cfr_method = params->cfr_method;
+	arsta->cfr_capture.cfr_bw = params->cfr_bw;
+
+	return ret;
+}
+
+void ath11k_cfr_update_unassoc_pool(struct ath11k *ar,
+				    struct ath11k_per_peer_cfr_capture *params,
+				    u8 *peer_mac)
+{
+	struct ath11k_cfr *cfr = &ar->cfr;
+	struct cfr_unassoc_pool_entry *entry;
+	int i;
+	int available_idx = -1;
+
+	spin_lock_bh(&cfr->lock);
+
+	if (!params->cfr_enable) {
+		for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+			entry = &cfr->unassoc_pool[i];
+			if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+				memset(entry->peer_mac, 0, ETH_ALEN);
+				entry->is_valid = false;
+				cfr->cfr_enabled_peer_cnt--;
+				break;
+			}
+		}
+
+		goto exit;
+	}
+
+	if (cfr->cfr_enabled_peer_cnt >= ATH11K_MAX_CFR_ENABLED_CLIENTS) {
+		ath11k_info(ar->ab, "Max cfr peer threshold reached\n");
+		goto exit;
+	}
+
+	for (i = 0; i < ATH11K_MAX_CFR_ENABLED_CLIENTS; i++) {
+		entry = &cfr->unassoc_pool[i];
+
+		if (ether_addr_equal(peer_mac, entry->peer_mac)) {
+			ath11k_info(ar->ab,
+				    "peer entry already present updating params\n");
+			entry->period = params->cfr_period;
+			available_idx = -1;
+			break;
+		}
+
+		if (available_idx < 0 && !entry->is_valid)
+			available_idx = i;
+	}
+
+	if (available_idx >= 0) {
+		entry = &cfr->unassoc_pool[available_idx];
+		ether_addr_copy(entry->peer_mac, peer_mac);
+		entry->period = params->cfr_period;
+		entry->is_valid = true;
+		cfr->cfr_enabled_peer_cnt++;
+	}
+
+exit:
+	spin_unlock_bh(&cfr->lock);
+}
+
 static struct dentry *create_buf_file_handler(const char *filename,
 					      struct dentry *parent,
 					      umode_t mode,
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index f39b82c..e209dc0 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -13,10 +13,14 @@
 #define ATH11K_CFR_NUM_RESP_PER_EVENT   1
 #define ATH11K_CFR_EVENT_TIMEOUT_MS     1
 
+#define ATH11K_MAX_CFR_ENABLED_CLIENTS 10
 #define CFR_MAX_LUT_ENTRIES 136
 
 #define HOST_MAX_CHAINS 8
 
+struct ath11k_sta;
+struct ath11k_per_peer_cfr_capture;
+
 struct ath11k_cfir_dma_hdr {
 	u16 info0;
 	u16 info1;
@@ -42,12 +46,19 @@ struct ath11k_look_up_table {
 	struct ath11k_dbring_element *buff;
 };
 
+struct cfr_unassoc_pool_entry {
+	u8 peer_mac[ETH_ALEN];
+	u32 period;
+	bool is_valid;
+};
+
 struct ath11k_cfr {
 	struct ath11k_dbring rx_ring;
 	/* Protects cfr data */
 	spinlock_t lock;
 	struct rchan *rfs_cfr_capture;
 	struct ath11k_look_up_table *lut;
+	u8 cfr_enabled_peer_cnt;
 	u32 lut_num;
 	u32 dbr_buf_size;
 	u32 dbr_num_bufs;
@@ -67,6 +78,21 @@ struct ath11k_cfr {
 	u64 clear_txrx_event;
 	u64 cfr_dma_aborts;
 	u64 flush_timeout_dbr_cnt;
+	struct cfr_unassoc_pool_entry unassoc_pool[ATH11K_MAX_CFR_ENABLED_CLIENTS];
+};
+
+enum ath11k_cfr_capture_method {
+	ATH11K_CFR_CAPTURE_METHOD_NULL_FRAME,
+	ATH11K_CFR_CAPTURE_METHOD_NULL_FRAME_WITH_PHASE,
+	ATH11K_CFR_CAPTURE_METHOD_PROBE_RESP,
+	ATH11K_CFR_CAPTURE_METHOD_MAX,
+};
+
+enum ath11k_cfr_capture_bw {
+	ATH11K_CFR_CAPTURE_BW_20,
+	ATH11K_CFR_CAPTURE_BW_40,
+	ATH11K_CFR_CAPTURE_BW_80,
+	ATH11K_CFR_CAPTURE_BW_MAX,
 };
 
 #ifdef CONFIG_ATH11K_CFR
@@ -74,6 +100,20 @@ int ath11k_cfr_init(struct ath11k_base *ab);
 void ath11k_cfr_deinit(struct ath11k_base *ab);
 void ath11k_cfr_lut_update_paddr(struct ath11k *ar, dma_addr_t paddr,
 				 u32 buf_id);
+void ath11k_cfr_decrement_peer_count(struct ath11k *ar,
+				     struct ath11k_sta *arsta);
+void ath11k_cfr_update_unassoc_pool_entry(struct ath11k *ar,
+					  const u8 *peer_mac);
+bool ath11k_cfr_peer_is_in_cfr_unassoc_pool(struct ath11k *ar,
+					    const u8 *peer_mac);
+void ath11k_cfr_update_unassoc_pool(struct ath11k *ar,
+				    struct ath11k_per_peer_cfr_capture *params,
+				    u8 *peer_mac);
+int ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
+					 struct ath11k_sta *arsta,
+					 struct ath11k_per_peer_cfr_capture *params,
+					 const u8 *peer_mac);
+
 #else
 static inline int ath11k_cfr_init(struct ath11k_base *ab)
 {
@@ -88,5 +128,37 @@ static inline void ath11k_cfr_lut_update_paddr(struct ath11k *ar,
 					       dma_addr_t paddr, u32 buf_id)
 {
 }
+
+static inline void ath11k_cfr_decrement_peer_count(struct ath11k *ar,
+						   struct ath11k_sta *arsta)
+{
+}
+
+static inline void ath11k_cfr_update_unassoc_pool_entry(struct ath11k *ar,
+							const u8 *peer_mac)
+{
+}
+
+static inline bool
+ath11k_cfr_peer_is_in_cfr_unassoc_pool(struct ath11k *ar, const u8 *peer_mac)
+{
+	return false;
+}
+
+static inline void
+ath11k_cfr_update_unassoc_pool(struct ath11k *ar,
+			       struct ath11k_per_peer_cfr_capture *params,
+			       u8 *peer_mac)
+{
+}
+
+static inline int
+ath11k_cfr_send_peer_cfr_capture_cmd(struct ath11k *ar,
+				     struct ath11k_sta *arsta,
+				     struct ath11k_per_peer_cfr_capture *params,
+				     const u8 *peer_mac)
+{
+	return 0;
+}
 #endif /* CONFIG_ATH11K_CFR */
 #endif /* ATH11K_CFR_H */
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 3cf026c..63f3a30 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -25,6 +25,7 @@
 #include "dbring.h"
 #include "spectral.h"
 #include "cfr.h"
+#include "vendor.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -375,6 +376,13 @@ struct ath11k_per_ppdu_tx_stats {
 	u32 retry_bytes;
 };
 
+struct ath11k_per_peer_cfr_capture {
+	enum ath11k_cfr_capture_method cfr_method;
+	enum ath11k_cfr_capture_bw cfr_bw;
+	u32 cfr_enable;
+	u32 cfr_period;
+};
+
 struct ath11k_sta {
 	struct ath11k_vif *arvif;
 
@@ -405,6 +413,9 @@ struct ath11k_sta {
 
 	bool use_4addr_set;
 	u16 tcl_metadata;
+#ifdef CONFIG_ATH11K_CFR
+	struct ath11k_per_peer_cfr_capture cfr_capture;
+#endif
 };
 
 #define ATH11K_MIN_5G_FREQ 4150
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ed89905..ee18a3b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4550,6 +4550,8 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 
 		kfree(arsta->rx_stats);
 		arsta->rx_stats = NULL;
+
+		ath11k_cfr_decrement_peer_count(ar, arsta);
 	} else if (old_state == IEEE80211_STA_AUTH &&
 		   new_state == IEEE80211_STA_ASSOC &&
 		   (vif->type == NL80211_IFTYPE_AP ||
@@ -5453,6 +5455,8 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 	dma_addr_t paddr;
 	int buf_id;
 	int ret;
+	bool tx_params_valid = false;
+	bool peer_in_unassoc_pool;
 
 	ATH11K_SKB_CB(skb)->ar = ar;
 
@@ -5486,7 +5490,18 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 
 	ATH11K_SKB_CB(skb)->paddr = paddr;
 
-	ret = ath11k_wmi_mgmt_send(ar, arvif->vdev_id, buf_id, skb);
+	peer_in_unassoc_pool = ath11k_cfr_peer_is_in_cfr_unassoc_pool(ar, hdr->addr1);
+
+	if (ar->cfr_enabled &&
+	    ieee80211_is_probe_resp(hdr->frame_control) &&
+	    peer_in_unassoc_pool)
+		tx_params_valid = true;
+
+	if (peer_in_unassoc_pool)
+		ath11k_cfr_update_unassoc_pool_entry(ar, hdr->addr1);
+
+	ret = ath11k_wmi_mgmt_send(ar, arvif->vdev_id, buf_id, skb,
+				   tx_params_valid);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to send mgmt frame: %d\n", ret);
 		goto err_unmap_buf;
@@ -8481,6 +8496,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	}
 
 	ath11k_reg_init(ar);
+	ath11k_vendor_register(ar);
 
 	if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {
 		ar->hw->netdev_features = NETIF_F_HW_CSUM;
diff --git a/drivers/net/wireless/ath/ath11k/vendor.c b/drivers/net/wireless/ath/ath11k/vendor.c
new file mode 100644
index 0000000..d76e2ea
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/vendor.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
+ */
+
+#include <net/netlink.h>
+#include <net/mac80211.h>
+#include <uapi/linux/nl80211-vnd-qca.h>
+#include "core.h"
+#include "debug.h"
+#include "peer.h"
+
+static const struct nla_policy
+ath11k_vendor_cfr_config_policy[QCA_WLAN_VENDOR_ATTR_PEER_CFR_MAX + 1] = {
+	[QCA_WLAN_VENDOR_ATTR_CFR_PEER_MAC_ADDR] = NLA_POLICY_ETH_ADDR,
+	[QCA_WLAN_VENDOR_ATTR_PEER_CFR_ENABLE] = { .type = NLA_FLAG },
+	[QCA_WLAN_VENDOR_ATTR_PEER_CFR_BANDWIDTH] =
+		NLA_POLICY_RANGE(NLA_U8, 0, NL80211_CHAN_WIDTH_80),
+	[QCA_WLAN_VENDOR_ATTR_PEER_CFR_PERIODICITY] = { .type = NLA_U32},
+		 NLA_POLICY_MIN(NLA_U32, 1),
+	[QCA_WLAN_VENDOR_ATTR_PEER_CFR_METHOD] =
+		NLA_POLICY_RANGE(NLA_U8, 0, QCA_WLAN_VENDOR_CFR_PROBE_RESPONSE),
+	[QCA_WLAN_VENDOR_ATTR_PERIODIC_CFR_CAPTURE_ENABLE] = { .type = NLA_FLAG },
+};
+
+static enum ath11k_cfr_capture_bw
+vendor_cfr_bw_to_ath11k_cfr_bw(enum nl80211_chan_width bw)
+{
+	switch (bw) {
+	case NL80211_CHAN_WIDTH_20:
+		return ATH11K_CFR_CAPTURE_BW_20;
+	case NL80211_CHAN_WIDTH_40:
+		return ATH11K_CFR_CAPTURE_BW_40;
+	case NL80211_CHAN_WIDTH_80:
+		return ATH11K_CFR_CAPTURE_BW_80;
+	default:
+		return ATH11K_CFR_CAPTURE_BW_MAX;
+	}
+}
+
+static enum ath11k_cfr_capture_method
+vendor_cfr_method_to_ath11k_cfr_method(enum qca_wlan_vendor_cfr_method method)
+{
+	switch (method) {
+	case QCA_WLAN_VENDOR_CFR_METHOD_QOS_NULL:
+		return ATH11K_CFR_CAPTURE_METHOD_NULL_FRAME;
+	case QCA_WLAN_VENDOR_CFR_QOS_NULL_WITH_PHASE:
+		return ATH11K_CFR_CAPTURE_METHOD_NULL_FRAME_WITH_PHASE;
+	case QCA_WLAN_VENDOR_CFR_PROBE_RESPONSE:
+		return ATH11K_CFR_CAPTURE_METHOD_PROBE_RESP;
+	default:
+		return ATH11K_CFR_CAPTURE_METHOD_MAX;
+	}
+}
+
+static int ath11k_vendor_parse_cfr_config(struct wiphy *wihpy,
+					  struct wireless_dev *wdev,
+					  const void *data,
+					  int data_len)
+{
+	struct nlattr *tb[QCA_WLAN_VENDOR_ATTR_PEER_CFR_MAX + 1];
+	struct ieee80211_vif *vif;
+	struct ath11k_vif *arvif;
+	struct ath11k *ar;
+	struct ath11k_peer *peer;
+	struct ath11k_sta *arsta = NULL;
+	struct ieee80211_sta *sta = NULL;
+	struct ath11k_per_peer_cfr_capture params;
+	enum qca_wlan_vendor_cfr_method method = QCA_WLAN_VENDOR_CFR_METHOD_QOS_NULL;
+	enum nl80211_chan_width bw = NL80211_CHAN_WIDTH_20;
+	enum ath11k_cfr_capture_method cfr_method;
+	enum ath11k_cfr_capture_bw cfr_bw;
+	u8 *mac_addr;
+	u32 periodicity = 0;
+	bool enable_cfr;
+	bool unassoc_peer = false;
+	int ret = 0;
+
+	if (!wdev)
+		return -EINVAL;
+
+	vif = wdev_to_ieee80211_vif(wdev);
+	if (!vif)
+		return -EINVAL;
+
+	arvif = (struct ath11k_vif *)vif->drv_priv;
+	ar = arvif->ar;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ret = nla_parse(tb, QCA_WLAN_VENDOR_ATTR_PEER_CFR_MAX, data, data_len,
+			ath11k_vendor_cfr_config_policy, NULL);
+	if (ret) {
+		ath11k_warn(ar->ab, "invalid cfr config policy attribute\n");
+		goto exit;
+	}
+
+	/* MAC address is mandatory to enable/disable cfr capture*/
+	if (!tb[QCA_WLAN_VENDOR_ATTR_CFR_PEER_MAC_ADDR]) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	enable_cfr = nla_get_flag(tb[QCA_WLAN_VENDOR_ATTR_PEER_CFR_ENABLE]);
+	mac_addr = nla_data(tb[QCA_WLAN_VENDOR_ATTR_CFR_PEER_MAC_ADDR]);
+
+	if (enable_cfr &&
+	    (!tb[QCA_WLAN_VENDOR_ATTR_PEER_CFR_BANDWIDTH] ||
+	     !tb[QCA_WLAN_VENDOR_ATTR_PEER_CFR_METHOD] ||
+	     !tb[QCA_WLAN_VENDOR_ATTR_PEER_CFR_PERIODICITY])) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (enable_cfr) {
+		periodicity = nla_get_u32(tb[QCA_WLAN_VENDOR_ATTR_PEER_CFR_PERIODICITY]);
+		bw = nla_get_u8(tb[QCA_WLAN_VENDOR_ATTR_PEER_CFR_BANDWIDTH]);
+		method = nla_get_u8(tb[QCA_WLAN_VENDOR_ATTR_PEER_CFR_METHOD]);
+	}
+
+	if (periodicity > WMI_PEER_CFR_PERIODICITY_MAX) {
+		ath11k_warn(ar->ab, "Invalid periodicity %u max supported %u\n",
+			    periodicity, WMI_PEER_CFR_PERIODICITY_MAX);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	cfr_bw = vendor_cfr_bw_to_ath11k_cfr_bw(bw);
+	if (cfr_bw >= ATH11K_CFR_CAPTURE_BW_MAX) {
+		ath11k_warn(ar->ab, "Driver doesn't support configured bw %d\n", bw);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	cfr_method = vendor_cfr_method_to_ath11k_cfr_method(method);
+	if (cfr_method >= ATH11K_CFR_CAPTURE_METHOD_MAX) {
+		ath11k_warn(ar->ab, "Driver doesn't support configured method %d\n",
+			    method);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	spin_lock_bh(&ar->ab->base_lock);
+	peer = ath11k_peer_find_by_addr(ar->ab, mac_addr);
+	if (!peer || !peer->sta) {
+		unassoc_peer = true;
+	} else {
+		sta = peer->sta;
+		arsta = (struct ath11k_sta *)sta->drv_priv;
+	}
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	if (unassoc_peer && cfr_method != ATH11K_CFR_CAPTURE_METHOD_PROBE_RESP) {
+		ath11k_warn(ar->ab, "invalid capture method for an unassoc sta");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	params.cfr_enable = enable_cfr;
+	params.cfr_period = periodicity;
+	params.cfr_bw = cfr_bw;
+	params.cfr_method = cfr_method;
+
+	if (unassoc_peer)
+		ath11k_cfr_update_unassoc_pool(ar, &params, mac_addr);
+	else
+		ret = ath11k_cfr_send_peer_cfr_capture_cmd(ar, arsta,
+							   &params, mac_addr);
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static struct wiphy_vendor_command ath11k_vendor_commands[] = {
+	{
+		.info.vendor_id = OUI_QCA,
+		.info.subcmd = QCA_NL80211_VENDOR_SUBCMD_PEER_CFR_CAPTURE_CFG,
+		.flags = WIPHY_VENDOR_CMD_NEED_WDEV | WIPHY_VENDOR_CMD_NEED_RUNNING,
+		.doit = ath11k_vendor_parse_cfr_config,
+		.policy = ath11k_vendor_cfr_config_policy,
+		.maxattr = QCA_WLAN_VENDOR_ATTR_PEER_CFR_MAX
+	}
+};
+
+int ath11k_vendor_register(struct ath11k *ar)
+{
+	ar->hw->wiphy->vendor_commands = ath11k_vendor_commands;
+	ar->hw->wiphy->n_vendor_commands = ARRAY_SIZE(ath11k_vendor_commands);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath11k/vendor.h b/drivers/net/wireless/ath/ath11k/vendor.h
new file mode 100644
index 0000000..93870ef
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/vendor.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
+ */
+
+#ifndef ATH11K_VENDOR_H
+#define ATH11K_VENDOR_H
+
+int ath11k_vendor_register(struct ath11k *ar);
+
+#endif /* QCA_VENDOR_H */
+
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b4f86c4..f945d45 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -621,9 +622,10 @@ struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len)
 }
 
 int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
-			 struct sk_buff *frame)
+			 struct sk_buff *frame, bool tx_params_valid)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_mgmt_send_params *params;
 	struct wmi_mgmt_send_cmd *cmd;
 	struct wmi_tlv *frame_tlv;
 	struct sk_buff *skb;
@@ -634,6 +636,8 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 		  frame->len : WMI_MGMT_SEND_DOWNLD_LEN;
 
 	len = sizeof(*cmd) + sizeof(*frame_tlv) + roundup(buf_len, 4);
+	if (tx_params_valid)
+		len += sizeof(*params);
 
 	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
@@ -649,7 +653,7 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 	cmd->paddr_hi = upper_32_bits(ATH11K_SKB_CB(frame)->paddr);
 	cmd->frame_len = frame->len;
 	cmd->buf_len = buf_len;
-	cmd->tx_params_valid = 0;
+	cmd->tx_params_valid = !!tx_params_valid;
 
 	frame_tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
 	frame_tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
@@ -659,6 +663,15 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 
 	ath11k_ce_byte_swap(frame_tlv->value, buf_len);
 
+	if (tx_params_valid) {
+		params =
+		(struct wmi_mgmt_send_params *)(skb->data + (len - sizeof(*params)));
+		params->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TX_SEND_PARAMS) |
+				     FIELD_PREP(WMI_TLV_LEN,
+						sizeof(*params) - TLV_HDR_SIZE);
+		params->tx_params_dword1 |= WMI_TX_PARAMS_DWORD1_CFR_CAPTURE;
+	}
+
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_MGMT_TX_SEND_CMDID);
 	if (ret) {
 		ath11k_warn(ar->ab,
@@ -3679,6 +3692,47 @@ int ath11k_wmi_fils_discovery_tmpl(struct ath11k *ar, u32 vdev_id,
 	return ret;
 }
 
+int ath11k_wmi_peer_set_cfr_capture_conf(struct ath11k *ar,
+					 u32 vdev_id, const u8 *mac_addr,
+					 struct wmi_peer_cfr_capture_conf_arg *arg)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_peer_cfr_capture_cmd_fixed_param *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_peer_cfr_capture_cmd_fixed_param *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_PEER_CFR_CAPTURE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	memcpy(&cmd->mac_addr, mac_addr, ETH_ALEN);
+	cmd->request = arg->request;
+	cmd->vdev_id = vdev_id;
+	cmd->periodicity = arg->periodicity;
+	cmd->bandwidth = arg->bw;
+	cmd->capture_method = arg->method;
+
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_PEER_CFR_CAPTURE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "WMI vdev %d failed to send peer cfr capture cmd\n",
+			    vdev_id);
+		dev_kfree_skb(skb);
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI peer CFR capture cmd req %u id %u period %u bw %u mode %u\n",
+		   arg->request, vdev_id, arg->periodicity,
+		   arg->bw, arg->method);
+
+	return ret;
+}
+
 int ath11k_wmi_probe_resp_tmpl(struct ath11k *ar, u32 vdev_id,
 			       struct sk_buff *tmpl)
 {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 72e2e20..3fe195f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -334,6 +334,10 @@ enum wmi_tlv_cmd_id {
 	WMI_PEER_REORDER_QUEUE_REMOVE_CMDID,
 	WMI_PEER_SET_RX_BLOCKSIZE_CMDID,
 	WMI_PEER_ANTDIV_INFO_REQ_CMDID,
+	WMI_PEER_RESERVED0_CMDID,
+	WMI_PEER_TID_MSDUQ_QDEPTH_THRESH_UPDATE_CMDID,
+	WMI_PEER_TID_CONFIGURATIONS_CMDID,
+	WMI_PEER_CFR_CAPTURE_CMDID,
 	WMI_BCN_TX_CMDID = WMI_TLV_CMD(WMI_GRP_MGMT),
 	WMI_PDEV_SEND_BCN_CMDID,
 	WMI_BCN_TMPL_CMDID,
@@ -3336,6 +3340,45 @@ struct wmi_bssid_arg {
 	const u8 *bssid;
 };
 
+enum ath11k_wmi_cfr_capture_bw {
+	WMI_PEER_CFR_CAPTURE_BW_20,
+	WMI_PEER_CFR_CAPTURE_BW_40,
+	WMI_PEER_CFR_CAPTURE_BW_80,
+	WMI_PEER_CFR_CAPTURE_BW_MAX,
+};
+
+enum ath11k_wmi_cfr_capture_method {
+	WMI_CFR_CAPTURE_METHOD_NULL_FRAME,
+	WMI_CFR_CAPTURE_METHOD_NULL_FRAME_WITH_PHASE,
+	WMI_CFR_CAPTURE_METHOD_PROBE_RESP,
+	WMI_CFR_CAPTURE_METHOD_MAX,
+};
+
+struct wmi_peer_cfr_capture_conf_arg {
+	enum ath11k_wmi_cfr_capture_bw bw;
+	enum ath11k_wmi_cfr_capture_method method;
+	u32 request;
+	u32 periodicity;
+};
+
+struct wmi_peer_cfr_capture_cmd_fixed_param {
+	u32 tlv_header;
+	u32 request;
+	struct wmi_mac_addr mac_addr;
+	u32 vdev_id;
+	u32 periodicity;
+	/* BW of measurement - of type enum ath11k_wmi_cfr_capture_bw */
+	u32 bandwidth;
+	/* Method used to capture CFR - of type enum ath11k_wmi_cfr_capture_method */
+	u32 capture_method;
+} __packed;
+
+#define WMI_PEER_CFR_CAPTURE_ENABLE   1
+#define WMI_PEER_CFR_CAPTURE_DISABLE  0
+
+/*periodicity in ms */
+#define WMI_PEER_CFR_PERIODICITY_MAX  (10 * 60 * 1000)
+
 struct wmi_start_scan_arg {
 	u32 scan_id;
 	u32 scan_req_id;
@@ -3704,7 +3747,8 @@ struct wmi_scan_prob_req_oui_cmd {
 #define WMI_TX_PARAMS_DWORD1_BW_MASK		GENMASK(14, 8)
 #define WMI_TX_PARAMS_DWORD1_PREAMBLE_TYPE	GENMASK(19, 15)
 #define WMI_TX_PARAMS_DWORD1_FRAME_TYPE		BIT(20)
-#define WMI_TX_PARAMS_DWORD1_RSVD		GENMASK(31, 21)
+#define WMI_TX_PARAMS_DWORD1_CFR_CAPTURE	BIT(21)
+#define WMI_TX_PARAMS_DWORD1_RSVD		GENMASK(31, 22)
 
 struct wmi_mgmt_send_params {
 	u32 tlv_header;
@@ -5559,7 +5603,7 @@ int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
 int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
-			 struct sk_buff *frame);
+			 struct sk_buff *frame, bool tx_params_valid);
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
 			struct sk_buff *bcn);
@@ -5716,4 +5760,7 @@ int ath11k_wmi_scan_prob_req_oui(struct ath11k *ar,
 				 const u8 mac_addr[ETH_ALEN]);
 int ath11k_wmi_fw_dbglog_cfg(struct ath11k *ar, u32 *module_id_bitmap,
 			     struct ath11k_fw_dbglog *dbglog);
+int ath11k_wmi_peer_set_cfr_capture_conf(struct ath11k *ar,
+					 u32 vdev_id, const u8 *mac,
+					 struct wmi_peer_cfr_capture_conf_arg *arg);
 #endif
-- 
2.7.4

