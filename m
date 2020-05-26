Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62A91B9955
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 10:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgD0IFE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 04:05:04 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31434 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgD0IFD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 04:05:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587974701; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=maMpp1ty/u5Vx6UValdzYe1TI+FFIYhKo03VBLkpEhY=; b=VTi02bHjEPJPEj96g/D4zjfHefhbEKixiLW6ZVIkxqE4sQ6o+Mcsuuw7cq0Nab6A9nbPTT5E
 00UMnecBatVZB798CdEONetwfcVtj24R4x4AQhmCLO9ebICMcU8dplkWIGqk3gpj+JqMRDRe
 Jzb6MwQX0FMqqYeOc7cI6VuWd8Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea69223.7fa23d959260-smtp-out-n03;
 Mon, 27 Apr 2020 08:04:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8422DC433BA; Mon, 27 Apr 2020 08:04:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21227C433F2;
        Mon, 27 Apr 2020 08:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21227C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2 2/4] ath10k: add rx bitrate report for SDIO
Date:   Mon, 27 Apr 2020 16:04:14 +0800
Message-Id: <20200427080416.8265-3-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200427080416.8265-1-wgong@codeaurora.org>
References: <20200427080416.8265-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For SDIO chip, its rx indication is struct htt_rx_indication_hl, which
does not include the bitrate info as well as PCIe, for PCIe, it use
function ath10k_htt_rx_h_rates to parse the bitrate info in struct
rx_ppdu_start and then report it to mac80211 via ieee80211_rx_status.

SDIO does not have the same info as PCIe, then iw command can not get
the rx bitrate by "iw wlan0 station dump".

for example, it always show 6.0 MBit/s
localhost ~ # iw wlan0 link
Connected to 3c:28:6d:96:fd:69 (on wlan0)
	SSID: kukui_test
	freq: 5180
	RX: 111800 bytes (595 packets)
	TX: 35419 bytes (202 packets)
	signal: -41 dBm
	rx bitrate: 6.0 MBit/s

This patch is to send WMI_TLV_REQUEST_PEER_STATS_INFO_CMDID to firmware
for ath10k_sta_statistics and save the rx bitrate for WMI event
WMI_TLV_PEER_STATS_INFO_EVENTID.

This patch only effect SDIO chip, ath10k_mac_sta_get_peer_stats_info
has check for bitrate_statistics of hw_params, this patch only enable
it for "qca6174 hw3.2 sdio".

Tested with QCA6174 SDIO firmware WLAN.RMH.4.4.1-00042.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c    |   2 +
 drivers/net/wireless/ath/ath10k/core.h    |   3 +
 drivers/net/wireless/ath/ath10k/hw.h      |   3 +
 drivers/net/wireless/ath/ath10k/mac.c     |  40 ++++++++
 drivers/net/wireless/ath/ath10k/wmi-ops.h |  30 ++++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 118 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h | 100 ++++++++++++++++++
 drivers/net/wireless/ath/ath10k/wmi.h     |   8 ++
 8 files changed, 304 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index d96d178b4980..22b6937ac225 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -190,6 +190,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.uart_pin_workaround = true,
 		.tx_stats_over_pktlog = false,
 		.bmi_large_size_download = true,
+		.supports_peer_stats_info = true,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -3277,6 +3278,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
 	init_completion(&ar->thermal.wmi_sync);
 	init_completion(&ar->bss_survey_done);
 	init_completion(&ar->peer_delete_done);
+	init_completion(&ar->peer_stats_info_complete);
 
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath10k_scan_timeout_work);
 
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 07935d39d6d6..11d9132be4fd 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -504,6 +504,8 @@ struct ath10k_sta {
 	u32 tx_failed;
 	u32 last_tx_bitrate;
 
+	u32 rx_rate_code;
+	u32 rx_bitrate_kbps;
 	struct work_struct update_wk;
 	u64 rx_duration;
 	struct ath10k_htt_tx_stats *tx_stats;
@@ -1089,6 +1091,7 @@ struct ath10k {
 	int last_wmi_vdev_start_status;
 	struct completion vdev_setup_done;
 	struct completion vdev_delete_done;
+	struct completion peer_stats_info_complete;
 
 	struct workqueue_struct *workqueue;
 	/* Auxiliary workqueue */
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 2a7af5861788..d9907a4648a8 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -623,6 +623,9 @@ struct ath10k_hw_params {
 
 	/* tx stats support over pktlog */
 	bool tx_stats_over_pktlog;
+
+	/* provides bitrates for sta_statistics using WMI_TLV_PEER_STATS_INFO_EVENTID */
+	bool supports_peer_stats_info;
 };
 
 struct htt_rx_desc;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 0fb082c9d04b..d0401d3adde4 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8305,6 +8305,44 @@ static void ath10k_mac_op_sta_pre_rcu_remove(struct ieee80211_hw *hw,
 			peer->removed = true;
 }
 
+static void ath10k_mac_sta_get_peer_stats_info(struct ath10k *ar,
+					       struct ieee80211_sta *sta,
+					       struct station_info *sinfo)
+{
+	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
+	struct ath10k_peer *peer;
+	unsigned long time_left;
+	int ret;
+
+	if (!(ar->hw_params.supports_peer_stats_info &&
+	      arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA))
+		return;
+
+	spin_lock_bh(&ar->data_lock);
+	peer = ath10k_peer_find(ar, arsta->arvif->vdev_id, sta->addr);
+	spin_unlock_bh(&ar->data_lock);
+	if (!peer)
+		return;
+
+	reinit_completion(&ar->peer_stats_info_complete);
+
+	ret = ath10k_wmi_request_peer_stats_info(ar,
+						 arsta->arvif->vdev_id,
+						 WMI_REQUEST_ONE_PEER_STATS_INFO,
+						 arsta->arvif->bssid,
+						 0);
+	if (ret && ret != -EOPNOTSUPP) {
+		ath10k_warn(ar, "could not request peer stats info: %d\n", ret);
+		return;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->peer_stats_info_complete, 3 * HZ);
+	if (time_left == 0) {
+		ath10k_warn(ar, "timed out waiting peer stats info\n");
+		return;
+	}
+}
+
 static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_sta *sta,
@@ -8340,6 +8378,8 @@ static void ath10k_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->tx_failed = arsta->tx_failed;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 	}
+
+	ath10k_mac_sta_get_peer_stats_info(ar, sta, sinfo);
 }
 
 static const struct ieee80211_ops ath10k_ops = {
diff --git a/drivers/net/wireless/ath/ath10k/wmi-ops.h b/drivers/net/wireless/ath/ath10k/wmi-ops.h
index 1491c25518bb..6b730f59fd5b 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-ops.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-ops.h
@@ -126,6 +126,13 @@ struct wmi_ops {
 	struct sk_buff *(*gen_pdev_set_wmm)(struct ath10k *ar,
 					    const struct wmi_wmm_params_all_arg *arg);
 	struct sk_buff *(*gen_request_stats)(struct ath10k *ar, u32 stats_mask);
+	struct sk_buff *(*gen_request_peer_stats_info)(struct ath10k *ar,
+						       u32 vdev_id,
+						       enum
+						       wmi_peer_stats_info_request_type
+						       type,
+						       u8 *addr,
+						       u32 reset);
 	struct sk_buff *(*gen_force_fw_hang)(struct ath10k *ar,
 					     enum wmi_force_fw_hang_type type,
 					     u32 delay_ms);
@@ -1064,6 +1071,29 @@ ath10k_wmi_request_stats(struct ath10k *ar, u32 stats_mask)
 	return ath10k_wmi_cmd_send(ar, skb, ar->wmi.cmd->request_stats_cmdid);
 }
 
+static inline int
+ath10k_wmi_request_peer_stats_info(struct ath10k *ar,
+				   u32 vdev_id,
+				   enum wmi_peer_stats_info_request_type type,
+				   u8 *addr,
+				   u32 reset)
+{
+	struct sk_buff *skb;
+
+	if (!ar->wmi.ops->gen_request_peer_stats_info)
+		return -EOPNOTSUPP;
+
+	skb = ar->wmi.ops->gen_request_peer_stats_info(ar,
+						       vdev_id,
+						       type,
+						       addr,
+						       reset);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	return ath10k_wmi_cmd_send(ar, skb, ar->wmi.cmd->request_peer_stats_info_cmdid);
+}
+
 static inline int
 ath10k_wmi_force_fw_hang(struct ath10k *ar,
 			 enum wmi_force_fw_hang_type type, u32 delay_ms)
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 27aaa48615d2..eec1f1f27dec 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -219,6 +219,89 @@ static void ath10k_wmi_tlv_event_vdev_delete_resp(struct ath10k *ar,
 	complete(&ar->vdev_delete_done);
 }
 
+static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar, u16 tag, u16 len,
+						const void *ptr, void *data)
+{
+	const struct wmi_tlv_peer_stats_info *stat = ptr;
+	struct ieee80211_sta *sta;
+	struct ath10k_sta *arsta;
+
+	if (tag != WMI_TLV_TAG_STRUCT_PEER_STATS_INFO)
+		return -EPROTO;
+
+	ath10k_dbg(ar, ATH10K_DBG_WMI,
+		   "wmi tlv stats peer addr %pMF rx rate code 0x%x bit rate %d kbps\n",
+		   stat->peer_macaddr.addr,
+		   __le32_to_cpu(stat->last_rx_rate_code),
+		   __le32_to_cpu(stat->last_rx_bitrate_kbps));
+
+	ath10k_dbg(ar, ATH10K_DBG_WMI,
+		   "wmi tlv stats tx rate code 0x%x bit rate %d kbps\n",
+		   __le32_to_cpu(stat->last_tx_rate_code),
+		   __le32_to_cpu(stat->last_tx_bitrate_kbps));
+
+	sta = ieee80211_find_sta_by_ifaddr(ar->hw, stat->peer_macaddr.addr, NULL);
+	if (!sta) {
+		ath10k_warn(ar, "not found station for peer stats\n");
+		return -EINVAL;
+	}
+
+	arsta = (struct ath10k_sta *)sta->drv_priv;
+	arsta->rx_rate_code = __le32_to_cpu(stat->last_rx_rate_code);
+	arsta->rx_bitrate_kbps = __le32_to_cpu(stat->last_rx_bitrate_kbps);
+
+	return 0;
+}
+
+static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k *ar,
+						  struct sk_buff *skb)
+{
+	const void **tb;
+	const struct wmi_tlv_peer_stats_info_ev *ev;
+	const void *data;
+	u32 num_peer_stats;
+	int ret;
+
+	tb = ath10k_wmi_tlv_parse_alloc(ar, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath10k_warn(ar, "failed to parse tlv: %d\n", ret);
+		return ret;
+	}
+
+	ev = tb[WMI_TLV_TAG_STRUCT_PEER_STATS_INFO_EVENT];
+	data = tb[WMI_TLV_TAG_ARRAY_STRUCT];
+
+	if (!ev || !data) {
+		kfree(tb);
+		return -EPROTO;
+	}
+
+	num_peer_stats = __le32_to_cpu(ev->num_peers);
+
+	ath10k_dbg(ar, ATH10K_DBG_WMI,
+		   "wmi tlv peer stats info update peer vdev id %d peers %i more data %d\n",
+		   __le32_to_cpu(ev->vdev_id),
+		   num_peer_stats,
+		   __le32_to_cpu(ev->more_data));
+
+	ret = ath10k_wmi_tlv_iter(ar, data, ath10k_wmi_tlv_len(data),
+				  ath10k_wmi_tlv_parse_peer_stats_info, NULL);
+	if (ret)
+		ath10k_warn(ar, "failed to parse stats info tlv: %d\n", ret);
+
+	kfree(tb);
+	return 0;
+}
+
+static void ath10k_wmi_tlv_event_peer_stats_info(struct ath10k *ar,
+						 struct sk_buff *skb)
+{
+	ath10k_dbg(ar, ATH10K_DBG_WMI, "WMI_PEER_STATS_INFO_EVENTID\n");
+	ath10k_wmi_tlv_op_pull_peer_stats_info(ar, skb);
+	complete(&ar->peer_stats_info_complete);
+}
+
 static int ath10k_wmi_tlv_event_diag_data(struct ath10k *ar,
 					  struct sk_buff *skb)
 {
@@ -576,6 +659,9 @@ static void ath10k_wmi_tlv_op_rx(struct ath10k *ar, struct sk_buff *skb)
 	case WMI_TLV_UPDATE_STATS_EVENTID:
 		ath10k_wmi_event_update_stats(ar, skb);
 		break;
+	case WMI_TLV_PEER_STATS_INFO_EVENTID:
+		ath10k_wmi_tlv_event_peer_stats_info(ar, skb);
+		break;
 	case WMI_TLV_VDEV_START_RESP_EVENTID:
 		ath10k_wmi_event_vdev_start_resp(ar, skb);
 		break;
@@ -2897,6 +2983,36 @@ ath10k_wmi_tlv_op_gen_request_stats(struct ath10k *ar, u32 stats_mask)
 	return skb;
 }
 
+static struct sk_buff *
+ath10k_wmi_tlv_op_gen_request_peer_stats_info(struct ath10k *ar,
+					      u32 vdev_id,
+					      enum wmi_peer_stats_info_request_type type,
+					      u8 *addr,
+					      u32 reset)
+{
+	struct wmi_tlv_request_peer_stats_info *cmd;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+
+	skb = ath10k_wmi_alloc_skb(ar, sizeof(*tlv) + sizeof(*cmd));
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	tlv = (void *)skb->data;
+	tlv->tag = __cpu_to_le16(WMI_TLV_TAG_STRUCT_REQUEST_PEER_STATS_INFO_CMD);
+	tlv->len = __cpu_to_le16(sizeof(*cmd));
+	cmd = (void *)tlv->value;
+	cmd->vdev_id = __cpu_to_le32(vdev_id);
+	cmd->request_type = __cpu_to_le32(type);
+
+	if (type == WMI_REQUEST_ONE_PEER_STATS_INFO)
+		ether_addr_copy(cmd->peer_macaddr.addr, addr);
+
+	cmd->reset_after_request = reset;
+	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi tlv request peer stats info\n");
+	return skb;
+}
+
 static int
 ath10k_wmi_mgmt_tx_alloc_msdu_id(struct ath10k *ar, struct sk_buff *skb,
 				 dma_addr_t paddr)
@@ -4113,6 +4229,7 @@ static struct wmi_cmd_map wmi_tlv_cmd_map = {
 	.vdev_spectral_scan_configure_cmdid = WMI_TLV_SPECTRAL_SCAN_CONF_CMDID,
 	.vdev_spectral_scan_enable_cmdid = WMI_TLV_SPECTRAL_SCAN_ENABLE_CMDID,
 	.request_stats_cmdid = WMI_TLV_REQUEST_STATS_CMDID,
+	.request_peer_stats_info_cmdid = WMI_TLV_REQUEST_PEER_STATS_INFO_CMDID,
 	.set_arp_ns_offload_cmdid = WMI_TLV_SET_ARP_NS_OFFLOAD_CMDID,
 	.network_list_offload_config_cmdid =
 				WMI_TLV_NETWORK_LIST_OFFLOAD_CONFIG_CMDID,
@@ -4417,6 +4534,7 @@ static const struct wmi_ops wmi_tlv_ops = {
 	.gen_beacon_dma = ath10k_wmi_tlv_op_gen_beacon_dma,
 	.gen_pdev_set_wmm = ath10k_wmi_tlv_op_gen_pdev_set_wmm,
 	.gen_request_stats = ath10k_wmi_tlv_op_gen_request_stats,
+	.gen_request_peer_stats_info = ath10k_wmi_tlv_op_gen_request_peer_stats_info,
 	.gen_force_fw_hang = ath10k_wmi_tlv_op_gen_force_fw_hang,
 	/* .gen_mgmt_tx = not implemented; HTT is used */
 	.gen_mgmt_tx_send = ath10k_wmi_tlv_op_gen_mgmt_tx_send,
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.h b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
index cd400b19a64d..2153e2d9a955 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -198,6 +198,12 @@ enum wmi_tlv_cmd_id {
 	WMI_TLV_REQUEST_LINK_STATS_CMDID,
 	WMI_TLV_START_LINK_STATS_CMDID,
 	WMI_TLV_CLEAR_LINK_STATS_CMDID,
+	WMI_TLV_CGET_FW_MEM_DUMP_CMDID,
+	WMI_TLV_CDEBUG_MESG_FLUSH_CMDID,
+	WMI_TLV_CDIAG_EVENT_LOG_CONFIG_CMDID,
+	WMI_TLV_CREQUEST_WLAN_STATS_CMDID,
+	WMI_TLV_CREQUEST_RCPI_CMDID,
+	WMI_TLV_REQUEST_PEER_STATS_INFO_CMDID,
 	WMI_TLV_SET_ARP_NS_OFFLOAD_CMDID = WMI_TLV_CMD(WMI_TLV_GRP_ARP_NS_OFL),
 	WMI_TLV_ADD_PROACTIVE_ARP_RSP_PATTERN_CMDID,
 	WMI_TLV_DEL_PROACTIVE_ARP_RSP_PATTERN_CMDID,
@@ -338,6 +344,13 @@ enum wmi_tlv_event_id {
 	WMI_TLV_IFACE_LINK_STATS_EVENTID,
 	WMI_TLV_PEER_LINK_STATS_EVENTID,
 	WMI_TLV_RADIO_LINK_STATS_EVENTID,
+	WMI_TLV_UPDATE_FW_MEM_DUMP_EVENTID,
+	WMI_TLV_DIAG_EVENT_LOG_SUPPORTED_EVENTID,
+	WMI_TLV_INST_RSSI_STATS_EVENTID,
+	WMI_TLV_RADIO_TX_POWER_LEVEL_STATS_EVENTID,
+	WMI_TLV_REPORT_STATS_EVENTID,
+	WMI_TLV_UPDATE_RCPI_EVENTID,
+	WMI_TLV_PEER_STATS_INFO_EVENTID,
 	WMI_TLV_NLO_MATCH_EVENTID = WMI_TLV_EV(WMI_TLV_GRP_NLO_OFL),
 	WMI_TLV_NLO_SCAN_COMPLETE_EVENTID,
 	WMI_TLV_APFIND_EVENTID,
@@ -2082,6 +2095,85 @@ struct wmi_tlv_stats_ev {
 	__le32 num_peer_stats_extd;
 } __packed;
 
+struct wmi_tlv_peer_stats_info_ev {
+	__le32 vdev_id;
+	__le32 num_peers;
+	__le32 more_data;
+} __packed;
+
+#define WMI_TLV_MAX_CHAINS 8
+
+struct wmi_tlv_peer_stats_info {
+	struct wmi_mac_addr peer_macaddr;
+	struct {
+		/* lower 32 bits of the tx_bytes value */
+		__le32 low_32;
+		/* upper 32 bits of the tx_bytes value */
+		__le32 high_32;
+	} __packed tx_bytes;
+	struct {
+		/* lower 32 bits of the tx_packets value */
+		__le32 low_32;
+		/* upper 32 bits of the tx_packets value */
+		__le32 high_32;
+	} __packed tx_packets;
+	struct {
+		/* lower 32 bits of the rx_bytes value */
+		__le32 low_32;
+		/* upper 32 bits of the rx_bytes value */
+		__le32 high_32;
+	} __packed rx_bytes;
+	struct {
+		/* lower 32 bits of the rx_packets value */
+		__le32 low_32;
+		/* upper 32 bits of the rx_packets value */
+		__le32 high_32;
+	} __packed rx_packets;
+	__le32 tx_retries;
+	__le32 tx_failed;
+
+	/* rate information, it is output of WMI_ASSEMBLE_RATECODE_V1
+	 *  (in format of 0x1000RRRR)
+	 * The rate-code is a 4-bytes field in which,
+	 * for given rate, nss and preamble
+	 *
+	 * b'31-b'29 unused / reserved
+	 * b'28      indicate the version of rate-code (1 = RATECODE_V1)
+	 * b'27-b'11 unused / reserved
+	 * b'10-b'8  indicate the preamble (0 OFDM, 1 CCK, 2 HT, 3 VHT)
+	 * b'7-b'5   indicate the NSS (0 - 1x1, 1 - 2x2, 2 - 3x3, 3 - 4x4)
+	 * b'4-b'0   indicate the rate, which is indicated as follows:
+	 *	    OFDM :     0: OFDM 48 Mbps
+	 *		       1: OFDM 24 Mbps
+	 *		       2: OFDM 12 Mbps
+	 *		       3: OFDM 6 Mbps
+	 *		       4: OFDM 54 Mbps
+	 *		       5: OFDM 36 Mbps
+	 *		       6: OFDM 18 Mbps
+	 *		       7: OFDM 9 Mbps
+	 *	   CCK (pream == 1)
+	 *		       0: CCK 11 Mbps Long
+	 *		       1: CCK 5.5 Mbps Long
+	 *		       2: CCK 2 Mbps Long
+	 *		       3: CCK 1 Mbps Long
+	 *		       4: CCK 11 Mbps Short
+	 *		       5: CCK 5.5 Mbps Short
+	 *		       6: CCK 2 Mbps Short
+	 *	   HT/VHT (pream == 2/3)
+	 *		       0..7: MCS0..MCS7 (HT)
+	 *		       0..9: MCS0..MCS9 (11AC VHT)
+	 *		       0..11: MCS0..MCS11 (11AX VHT)
+	 * rate-code of the last transmission
+	 */
+	__le32 last_tx_rate_code;
+	__le32 last_rx_rate_code;
+	__le32 last_tx_bitrate_kbps;
+	__le32 last_rx_bitrate_kbps;
+	__le32 peer_rssi;
+	__le32 tx_succeed;
+	__le32 peer_rssi_per_chain[WMI_TLV_MAX_CHAINS];
+} __packed;
+
 struct wmi_tlv_p2p_noa_ev {
 	__le32 vdev_id;
 } __packed;
@@ -2098,6 +2190,14 @@ struct wmi_tlv_wow_add_del_event_cmd {
 	__le32 event_bitmap;
 } __packed;
 
+struct wmi_tlv_request_peer_stats_info {
+	__le32 request_type;
+	__le32 vdev_id;
+	/* peer MAC address */
+	struct wmi_mac_addr peer_macaddr;
+	__le32 reset_after_request;
+} __packed;
+
 /* Command to set/unset chip in quiet mode */
 struct wmi_tlv_set_quiet_cmd {
 	__le32 vdev_id;
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 46740e16f3ce..0f05405bebc0 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -940,6 +940,7 @@ struct wmi_cmd_map {
 	u32 vdev_spectral_scan_configure_cmdid;
 	u32 vdev_spectral_scan_enable_cmdid;
 	u32 request_stats_cmdid;
+	u32 request_peer_stats_info_cmdid;
 	u32 set_arp_ns_offload_cmdid;
 	u32 network_list_offload_config_cmdid;
 	u32 gtk_offload_cmdid;
@@ -4579,6 +4580,13 @@ struct wmi_request_stats_cmd {
 	struct wlan_inst_rssi_args inst_rssi_args;
 } __packed;
 
+enum wmi_peer_stats_info_request_type {
+	/* request stats of one specified peer */
+	WMI_REQUEST_ONE_PEER_STATS_INFO = 0x01,
+	/* request stats of all peers belong to specified VDEV */
+	WMI_REQUEST_VDEV_ALL_PEER_STATS_INFO = 0x02,
+};
+
 /* Suspend option */
 enum {
 	/* suspend */
-- 
2.23.0
