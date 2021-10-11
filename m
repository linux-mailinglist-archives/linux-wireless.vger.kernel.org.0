Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103DF428C27
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhJKLjr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 07:39:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39247 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234208AbhJKLjr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 07:39:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633952267; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=W9cryfzkKN/Q0Dshd41ICTv47fbN2Zr0IqqYXN8IbjY=; b=ksDJgHo0vCFOnf4h9BVH2P3SBTITmFiPgq4nrD0zbmGA92ESqL35zJavQPL6vGvt9gRh2+fG
 PGagf0368DsUcMUvWUARnvxBMj1xyGvmOdgGcX1FvHzyGhmvbpxBLytPgcoCb6iMEdveuu1T
 2RMzRI6D3XOOyx7rEKBCIrNmfFY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 616421fd446c6db0cb56efb9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 11:37:33
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2625BC43460; Mon, 11 Oct 2021 11:37:33 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91CFCC43460;
        Mon, 11 Oct 2021 11:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 91CFCC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/6] ath11k: support GTK rekey offload
Date:   Mon, 11 Oct 2021 15:37:50 -0400
Message-Id: <20211011193750.4891-7-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011193750.4891-1-cjhuang@codeaurora.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host sets GTK related info to firmware before WoW is enabled, and
gets rekey replay_count and then disables GTK rekey when WoW quits.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |   8 +++
 drivers/net/wireless/ath/ath11k/mac.c  |  32 ++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c  | 110 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  |  39 ++++++++++++
 drivers/net/wireless/ath/ath11k/wow.c  |  49 ++++++++++++++-
 5 files changed, 237 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index d9c6c1d..69461c3 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -256,6 +256,13 @@ struct ath11k_arp_ns_offload {
 	u8  mac_addr[ETH_ALEN];
 };
 
+struct ath11k_rekey_data {
+	u8 kck[NL80211_KCK_LEN];
+	u8 kek[NL80211_KCK_LEN];
+	u64 replay_ctr;
+	bool enable_offload;
+};
+
 struct ath11k_vif {
 	u32 vdev_id;
 	enum wmi_vdev_type vdev_type;
@@ -307,6 +314,7 @@ struct ath11k_vif {
 	struct ieee80211_chanctx_conf chanctx;
 	struct ath11k_reg_tpc_power_info reg_tpc_info;
 	struct ath11k_arp_ns_offload arp_ns_offload;
+	struct ath11k_rekey_data rekey_data;
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e3dc998..797e45e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2206,6 +2206,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	}
 
 	arvif->is_up = true;
+	arvif->rekey_data.enable_offload = false;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
 		   "mac vdev %d up (associated) bssid %pM aid %d\n",
@@ -2239,6 +2240,8 @@ static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
 
 	arvif->is_up = false;
 
+	memset(&arvif->rekey_data, 0, sizeof(arvif->rekey_data));
+
 	cancel_delayed_work_sync(&arvif->connection_loss_work);
 }
 
@@ -7451,6 +7454,34 @@ static void ath11k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
 	ath11k_generate_ns_mc_addr(ar, offload);
 }
 
+static void ath11k_mac_op_set_rekey_data(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct cfg80211_gtk_rekey_data *data)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	struct ath11k_rekey_data *rekey_data = &arvif->rekey_data;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "Set rekey data vdev_id %d\n",
+		   arvif->vdev_id);
+	mutex_lock(&ar->conf_mutex);
+
+	memcpy(rekey_data->kck, data->kck, NL80211_KCK_LEN);
+	memcpy(rekey_data->kek, data->kek, NL80211_KEK_LEN);
+
+	/* supplicant works on big-endian, converts to cpu-endian */
+	rekey_data->replay_ctr = be64_to_cpup((__be64 *)data->replay_ctr);
+	arvif->rekey_data.enable_offload = true;
+
+	ath11k_dbg_dump(ar->ab, ATH11K_DBG_MAC, "KCK", NULL,
+			rekey_data->kck, NL80211_KCK_LEN);
+	ath11k_dbg_dump(ar->ab, ATH11K_DBG_MAC, "KEK", NULL,
+			rekey_data->kck, NL80211_KEK_LEN);
+	ath11k_dbg_dump(ar->ab, ATH11K_DBG_MAC, "replay ctr", NULL,
+			&rekey_data->replay_ctr, sizeof(rekey_data->replay_ctr));
+	mutex_unlock(&ar->conf_mutex);
+}
+
 static const struct ieee80211_ops ath11k_ops = {
 	.tx				= ath11k_mac_op_tx,
 	.start                          = ath11k_mac_op_start,
@@ -7465,6 +7496,7 @@ static const struct ieee80211_ops ath11k_ops = {
 	.hw_scan                        = ath11k_mac_op_hw_scan,
 	.cancel_hw_scan                 = ath11k_mac_op_cancel_hw_scan,
 	.set_key                        = ath11k_mac_op_set_key,
+	.set_rekey_data	                = ath11k_mac_op_set_rekey_data,
 	.sta_state                      = ath11k_mac_op_sta_state,
 	.sta_set_txpwr			= ath11k_mac_op_sta_set_txpwr,
 	.sta_rc_update			= ath11k_mac_op_sta_rc_update,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 1e276d51..5b02e95 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8005,6 +8005,53 @@ ath11k_wmi_tm_event_segmented(struct ath11k_base *ab, u32 cmd_id,
 	}
 }
 
+static void
+ath11k_wmi_gtk_offload_status_event(struct ath11k_base *ab,
+				    struct sk_buff *skb)
+{
+	const void **tb;
+	const struct wmi_gtk_offload_status_event *ev;
+	struct ath11k_vif *arvif;
+	__be64 replay_ctr;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_GTK_OFFLOAD_STATUS_EVENT];
+	if (!ev) {
+		ath11k_warn(ab, "failed to fetch gtk offload status ev");
+		kfree(tb);
+		return;
+	}
+
+	arvif = ath11k_mac_get_arvif_by_vdev_id(ab, ev->vdev_id);
+	if (!arvif) {
+		ath11k_warn(ab, "failed to get arvif for vdev_id:%d\n",
+			    ev->vdev_id);
+		kfree(tb);
+		return;
+	}
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "gtk offload event refresh_cnt:%d\n",
+		   ev->refresh_cnt);
+	ath11k_dbg_dump(ab, ATH11K_DBG_WMI, "gtk offload event replay_cnt",
+			NULL, ev->replay_counter, GTK_REPLAY_COUNTER_BYTES);
+
+	arvif->rekey_data.replay_ctr = le64_to_cpup((__le64 *)ev->replay_counter);
+	/* supplicant expects big-endian replay counter */
+	replay_ctr = cpu_to_be64(le64_to_cpup((__le64 *)ev->replay_counter));
+
+	ieee80211_gtk_rekey_notify(arvif->vif, arvif->bssid,
+				   (void *)&replay_ctr, GFP_KERNEL);
+
+	kfree(tb);
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -8133,6 +8180,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_RFKILL_STATE_CHANGE_EVENTID:
 		ath11k_rfkill_state_change_event(ab, skb);
 		break;
+	case WMI_GTK_OFFLOAD_STATUS_EVENTID:
+		ath11k_wmi_gtk_offload_status_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath11k_dbg(ab, ATH11K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
@@ -8873,3 +8923,63 @@ int ath11k_wmi_arp_ns_offload(struct ath11k *ar,
 
 	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_SET_ARP_NS_OFFLOAD_CMDID);
 }
+
+int ath11k_wmi_gtk_rekey_offload(struct ath11k *ar,
+				 struct ath11k_vif *arvif, bool enable)
+{
+	struct wmi_gtk_rekey_offload_cmd *cmd;
+	struct ath11k_rekey_data *rekey_data = &arvif->rekey_data;
+	int len;
+	struct sk_buff *skb;
+
+	len = sizeof(*cmd);
+	skb =  ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_gtk_rekey_offload_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_GTK_OFFLOAD_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = arvif->vdev_id;
+
+	if (enable) {
+		cmd->flags = GTK_OFFLOAD_ENABLE_OPCODE;
+
+		/* the length in rekey_data and cmd is equal */
+		memcpy(cmd->kck, rekey_data->kck, sizeof(cmd->kck));
+		memcpy(cmd->kek, rekey_data->kek, sizeof(cmd->kek));
+		memcpy(cmd->replay_ctr, &rekey_data->replay_ctr,
+		       sizeof(cmd->replay_ctr));
+	} else {
+		cmd->flags = GTK_OFFLOAD_DISABLE_OPCODE;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "offload gtk rekey vdev: %d %d\n",
+		   arvif->vdev_id, enable);
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+}
+
+int ath11k_wmi_gtk_rekey_getinfo(struct ath11k *ar,
+				 struct ath11k_vif *arvif)
+{
+	struct wmi_gtk_rekey_offload_cmd *cmd;
+	int len;
+	struct sk_buff *skb;
+
+	len = sizeof(*cmd);
+	skb =  ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_gtk_rekey_offload_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_GTK_OFFLOAD_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = arvif->vdev_id;
+	cmd->flags = GTK_OFFLOAD_REQUEST_STATUS_OPCODE;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "get gtk rekey vdev_id: %d\n",
+		   arvif->vdev_id);
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_GTK_OFFLOAD_CMDID);
+}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index c2e5557..61dc5ea 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5850,6 +5850,41 @@ struct wmi_set_arp_ns_offload_cmd {
 	 */
 } __packed;
 
+#define GTK_OFFLOAD_OPCODE_MASK             0xFF000000
+#define GTK_OFFLOAD_ENABLE_OPCODE           0x01000000
+#define GTK_OFFLOAD_DISABLE_OPCODE          0x02000000
+#define GTK_OFFLOAD_REQUEST_STATUS_OPCODE   0x04000000
+
+#define GTK_OFFLOAD_KEK_BYTES       16
+#define GTK_OFFLOAD_KCK_BYTES       16
+#define GTK_REPLAY_COUNTER_BYTES    8
+#define WMI_MAX_KEY_LEN             32
+#define IGTK_PN_SIZE                6
+
+struct wmi_gtk_offload_status_event {
+	u32 vdev_id;
+	u32 flags;
+	u32 refresh_cnt;
+	u8 replay_counter[GTK_REPLAY_COUNTER_BYTES];
+	u8 igtk_key_index;
+	u8 igtk_key_length;
+	u8 igtk_key_rsc[IGTK_PN_SIZE];
+	u8 igtk_key[WMI_MAX_KEY_LEN];
+	u8 gtk_key_index;
+	u8 gtk_key_length;
+	u8 gtk_key_rsc[GTK_REPLAY_COUNTER_BYTES];
+	u8 gtk_key[WMI_MAX_KEY_LEN];
+} __packed;
+
+struct wmi_gtk_rekey_offload_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 flags;
+	u8 kek[GTK_OFFLOAD_KEK_BYTES];
+	u8 kck[GTK_OFFLOAD_KCK_BYTES];
+	u8 replay_ctr[GTK_REPLAY_COUNTER_BYTES];
+} __packed;
+
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len);
@@ -6017,4 +6052,8 @@ int ath11k_wmi_send_hw_data_filter_cmd(struct ath11k *ar, u32 vdev_id,
 				       u32 filter_bitmap, bool enable);
 int ath11k_wmi_arp_ns_offload(struct ath11k *ar,
 			      struct ath11k_vif *arvif, bool enable);
+int ath11k_wmi_gtk_rekey_offload(struct ath11k *ar,
+				 struct ath11k_vif *arvif, bool enable);
+int ath11k_wmi_gtk_rekey_getinfo(struct ath11k *ar,
+				 struct ath11k_vif *arvif);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index c1bef84..2632628 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -17,7 +17,9 @@
 
 static const struct wiphy_wowlan_support ath11k_wowlan_support = {
 	.flags = WIPHY_WOWLAN_DISCONNECT |
-		 WIPHY_WOWLAN_MAGIC_PKT,
+		 WIPHY_WOWLAN_MAGIC_PKT |
+		 WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
+		 WIPHY_WOWLAN_GTK_REKEY_FAILURE,
 	.pattern_min_len = WOW_MIN_PATTERN_SIZE,
 	.pattern_max_len = WOW_MAX_PATTERN_SIZE,
 	.max_pkt_offset = WOW_MAX_PKT_OFFSET,
@@ -573,11 +575,56 @@ static int ath11k_wow_arp_ns_offload(struct ath11k *ar, bool enable)
 	return 0;
 }
 
+static int ath11k_gtk_rekey_offload(struct ath11k *ar, bool enable)
+{
+	struct ath11k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif->vdev_type != WMI_VDEV_TYPE_STA ||
+		    !arvif->is_up ||
+		    !arvif->rekey_data.enable_offload)
+			continue;
+
+		/* get rekey info before disable rekey offload */
+		if (!enable) {
+			ret = ath11k_wmi_gtk_rekey_getinfo(ar, arvif);
+			if (ret) {
+				ath11k_warn(ar->ab, "failed to request rekey info vdev %i, ret %d\n",
+					    arvif->vdev_id, ret);
+				return ret;
+			}
+		}
+
+		ret = ath11k_wmi_gtk_rekey_offload(ar, arvif, enable);
+
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to offload gtk reky vdev %i: enable %d, ret %d\n",
+				    arvif->vdev_id, enable, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int ath11k_wow_protocol_offload(struct ath11k *ar, bool enable)
 {
 	int ret;
 
 	ret = ath11k_wow_arp_ns_offload(ar, enable);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to offload ARP and NS %d %d\n",
+			    enable, ret);
+		return ret;
+	}
+
+	ret = ath11k_gtk_rekey_offload(ar, enable);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to offload gtk rekey %d %d\n",
+			    enable, ret);
 
 	return ret;
 }
-- 
2.7.4

