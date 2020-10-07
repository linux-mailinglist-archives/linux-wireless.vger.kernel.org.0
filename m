Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E82286946
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Oct 2020 22:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgJGUkt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Oct 2020 16:40:49 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:46886 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgJGUks (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Oct 2020 16:40:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602103246; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=rviyQ7fZXlqKPjtIpY8yWJH6Py4/CKSKGzMAnUwu59s=; b=cOd9ED9PRqWIE/Lw6LKLNFwUi4+cnm1Ty+fc4fA/X/NeEeBqvOKz6lf3z3+KoEQ9cf25xVRK
 lKWgVR4jCIUSvvg63TXz10n7l1bz1LWQ8eF3s9Hzjf39KbgR0yl56d3yNHdils9HEKuQ+pD+
 v89QAOsaOwRShYLq+6ad0BuH8ys=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f7e27ce588858a30438b1a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 07 Oct 2020 20:40:46
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BF0A9C433C8; Wed,  7 Oct 2020 20:40:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25ED8C433CA;
        Wed,  7 Oct 2020 20:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25ED8C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH] ath11k: FILS discovery and unsolicited broadcast probe response support
Date:   Wed,  7 Oct 2020 13:40:36 -0700
Message-Id: <20201007204036.19780-1-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds driver support for FILS discovery and unsolicited
broadcast probe response transmission features which are used for
in-band discovery in 6GHz band.
Currently this support is enabled only in 6GHz by setting hardware flags.

Changes include WMI commands to enable transmission, set packet
interval, set template, and handle events.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c |  57 ++++++++
 drivers/net/wireless/ath/ath11k/wmi.c | 203 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  47 ++++++
 3 files changed, 307 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3f63a7bd6b59..14733c48bdff 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1850,6 +1850,52 @@ static void ath11k_recalculate_mgmt_rate(struct ath11k *ar,
 		ath11k_warn(ar->ab, "failed to set beacon tx rate %d\n", ret);
 }
 
+static int ath11k_mac_fils_discovery(struct ath11k_vif *arvif,
+				     struct ieee80211_bss_conf *info)
+{
+	struct ath11k *ar = arvif->ar;
+	struct sk_buff *tmpl;
+	int ret;
+	u32 interval;
+	bool unsol_bcast_probe_resp_enabled = false;
+
+	if (info->fils_discovery.max_interval) {
+		interval = info->fils_discovery.max_interval;
+
+		tmpl = ieee80211_get_fils_discovery_tmpl(ar->hw, arvif->vif);
+		if (tmpl)
+			ret = ath11k_wmi_fils_discovery_tmpl(ar, arvif->vdev_id,
+							     tmpl);
+	} else if (info->unsol_bcast_probe_resp_interval) {
+		unsol_bcast_probe_resp_enabled = 1;
+		interval = info->unsol_bcast_probe_resp_interval;
+
+		tmpl = ieee80211_get_unsol_bcast_probe_resp_tmpl(ar->hw,
+								 arvif->vif);
+		if (tmpl)
+			ret = ath11k_wmi_probe_resp_tmpl(ar, arvif->vdev_id,
+							 tmpl);
+	} else { /* Disable */
+		return ath11k_wmi_fils_discovery(ar, arvif->vdev_id, 0, false);
+	}
+
+	if (!tmpl) {
+		ath11k_warn(ar->ab,
+			    "mac vdev %i failed to retrieve %s template\n",
+			    arvif->vdev_id, (unsol_bcast_probe_resp_enabled ?
+			    "unsolicited broadcast probe response" :
+			    "FILS discovery"));
+		return -EPERM;
+	}
+	kfree_skb(tmpl);
+
+	if (!ret)
+		ret = ath11k_wmi_fils_discovery(ar, arvif->vdev_id, interval,
+						unsol_bcast_probe_resp_enabled);
+
+	return ret;
+}
+
 static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
 					   struct ieee80211_bss_conf *info,
@@ -2111,6 +2157,10 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (changed & BSS_CHANGED_FILS_DISCOVERY ||
+	    changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP)
+		ath11k_mac_fils_discovery(arvif, info);
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -6256,6 +6306,13 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ar->hw->wiphy->num_iftype_ext_capab =
 		ARRAY_SIZE(ath11k_iftypes_ext_capa);
 
+	if (ar->supports_6ghz) {
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_FILS_DISCOVERY);
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_UNSOL_BCAST_PROBE_RESP);
+	}
+
 	ath11k_reg_init(ar);
 
 	if (!test_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags)) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8eca92520837..c9e241392de3 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -122,6 +122,10 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		= { .min_len = sizeof(struct wmi_stats_event) },
 	[WMI_TAG_PDEV_CTL_FAILSAFE_CHECK_EVENT]
 		= { .min_len = sizeof(struct wmi_pdev_ctl_failsafe_chk_event) },
+	[WMI_TAG_HOST_SWFDA_EVENT] = {
+		.min_len = sizeof(struct wmi_fils_discovery_event) },
+	[WMI_TAG_OFFLOAD_PRB_RSP_TX_STATUS_EVENT] = {
+		.min_len = sizeof(struct wmi_probe_resp_tx_status_event) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -3064,6 +3068,137 @@ int ath11k_wmi_send_bss_color_change_enable_cmd(struct ath11k *ar, u32 vdev_id,
 	return ret;
 }
 
+int ath11k_wmi_fils_discovery_tmpl(struct ath11k *ar, u32 vdev_id,
+				   struct sk_buff *tmpl)
+{
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	void *ptr;
+	int ret, len;
+	size_t aligned_len;
+	struct wmi_fils_discovery_tmpl_cmd *cmd;
+
+	aligned_len = roundup(tmpl->len, 4);
+	len = sizeof(*cmd) + TLV_HDR_SIZE + aligned_len;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI vdev %i set FILS discovery template\n", vdev_id);
+
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_fils_discovery_tmpl_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_FILS_DISCOVERY_TMPL_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->vdev_id = vdev_id;
+	cmd->buf_len = tmpl->len;
+	ptr = skb->data + sizeof(*cmd);
+
+	tlv = ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
+		      FIELD_PREP(WMI_TLV_LEN, aligned_len);
+	memcpy(tlv->value, tmpl->data, tmpl->len);
+
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_FILS_DISCOVERY_TMPL_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "WMI vdev %i failed to send FILS discovery template command\n",
+			    vdev_id);
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
+int ath11k_wmi_probe_resp_tmpl(struct ath11k *ar, u32 vdev_id,
+			       struct sk_buff *tmpl)
+{
+	struct wmi_probe_tmpl_cmd *cmd;
+	struct wmi_bcn_prb_info *probe_info;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	void *ptr;
+	int ret, len;
+	size_t aligned_len = roundup(tmpl->len, 4);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI vdev %i set probe response template\n", vdev_id);
+
+	len = sizeof(*cmd) + sizeof(*probe_info) + TLV_HDR_SIZE + aligned_len;
+
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_probe_tmpl_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_PRB_TMPL_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->vdev_id = vdev_id;
+	cmd->buf_len = tmpl->len;
+
+	ptr = skb->data + sizeof(*cmd);
+
+	probe_info = ptr;
+	len = sizeof(*probe_info);
+	probe_info->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+					    WMI_TAG_BCN_PRB_INFO) |
+				 FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+	probe_info->caps = 0;
+	probe_info->erp = 0;
+
+	ptr += sizeof(*probe_info);
+
+	tlv = ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_BYTE) |
+		      FIELD_PREP(WMI_TLV_LEN, aligned_len);
+	memcpy(tlv->value, tmpl->data, tmpl->len);
+
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_PRB_TMPL_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "WMI vdev %i failed to send probe response template command\n",
+			    vdev_id);
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
+int ath11k_wmi_fils_discovery(struct ath11k *ar, u32 vdev_id, u32 interval,
+			      bool unsol_bcast_probe_resp_enabled)
+{
+	struct sk_buff *skb;
+	int ret, len;
+	struct wmi_fils_discovery_cmd *cmd;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI vdev %i set %s interval to %u TU\n",
+		   vdev_id, unsol_bcast_probe_resp_enabled ?
+		   "unsolicited broadcast probe response" : "FILS discovery",
+		   interval);
+
+	len = sizeof(*cmd);
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_fils_discovery_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ENABLE_FILS_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+	cmd->vdev_id = vdev_id;
+	cmd->interval = interval;
+	cmd->config = unsol_bcast_probe_resp_enabled;
+
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_ENABLE_FILS_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "WMI vdev %i failed to send FILS discovery enable/disable command\n",
+			    vdev_id);
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
 static void
 ath11k_fill_band_to_mac_param(struct ath11k_base  *soc,
 			      struct wmi_host_pdev_band_to_mac *band_to_mac)
@@ -6429,6 +6564,68 @@ ath11k_wmi_pdev_temperature_event(struct ath11k_base *ab,
 	ath11k_thermal_event_temperature(ar, ev.temp);
 }
 
+static void ath11k_fils_discovery_event(struct ath11k_base *ab,
+					struct sk_buff *skb)
+{
+	const void **tb;
+	const struct wmi_fils_discovery_event *ev;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab,
+			    "failed to parse FILS discovery event tlv %d\n",
+			    ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_HOST_SWFDA_EVENT];
+	if (!ev) {
+		ath11k_warn(ab, "failed to fetch FILS discovery event\n");
+		kfree(tb);
+		return;
+	}
+
+	ath11k_warn(ab,
+		    "FILS discovery frame expected from host for vdev_id: %u, transmission scheduled at %u, next TBTT: %u\n",
+		    ev->vdev_id, ev->fils_tt, ev->tbtt);
+
+	kfree(tb);
+}
+
+static void ath11k_probe_resp_tx_status_event(struct ath11k_base *ab,
+					      struct sk_buff *skb)
+{
+	const void **tb;
+	const struct wmi_probe_resp_tx_status_event *ev;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab,
+			    "failed to parse probe response transmission status event tlv: %d\n",
+			    ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_OFFLOAD_PRB_RSP_TX_STATUS_EVENT];
+	if (!ev) {
+		ath11k_warn(ab,
+			    "failed to fetch probe response transmission status event");
+		kfree(tb);
+		return;
+	}
+
+	if (ev->tx_status)
+		ath11k_warn(ab,
+			    "Probe response transmission failed for vdev_id %u, status %u\n",
+			    ev->vdev_id, ev->tx_status);
+
+	kfree(tb);
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -6515,6 +6712,12 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_PDEV_DMA_RING_BUF_RELEASE_EVENTID:
 		ath11k_wmi_pdev_dma_ring_buf_release_event(ab, skb);
 		break;
+	case WMI_HOST_FILS_DISCOVERY_EVENTID:
+		ath11k_fils_discovery_event(ab, skb);
+		break;
+	case WMI_OFFLOAD_PROB_RESP_TX_STATUS_EVENTID:
+		ath11k_probe_resp_tx_status_event(ab, skb);
+		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_VDEV_DELETE_RESP_EVENTID:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 5a32ba0eb4f5..b722a87144b6 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -319,6 +319,7 @@ enum wmi_tlv_cmd_id {
 	WMI_BCN_OFFLOAD_CTRL_CMDID,
 	WMI_BSS_COLOR_CHANGE_ENABLE_CMDID,
 	WMI_VDEV_BCN_OFFLOAD_QUIET_CONFIG_CMDID,
+	WMI_FILS_DISCOVERY_TMPL_CMDID,
 	WMI_ADDBA_CLEAR_RESP_CMDID = WMI_TLV_CMD(WMI_GRP_BA_NEG),
 	WMI_ADDBA_SEND_CMDID,
 	WMI_ADDBA_STATUS_CMDID,
@@ -351,6 +352,8 @@ enum wmi_tlv_cmd_id {
 	WMI_ROAM_CONFIGURE_MAWC_CMDID,
 	WMI_ROAM_SET_MBO_PARAM_CMDID,
 	WMI_ROAM_PER_CONFIG_CMDID,
+	WMI_ROAM_BTM_CONFIG_CMDID,
+	WMI_ENABLE_FILS_CMDID,
 	WMI_OFL_SCAN_ADD_AP_PROFILE = WMI_TLV_CMD(WMI_GRP_OFL_SCAN),
 	WMI_OFL_SCAN_REMOVE_AP_PROFILE,
 	WMI_OFL_SCAN_PERIOD,
@@ -642,6 +645,8 @@ enum wmi_tlv_event_id {
 	WMI_MGMT_TX_COMPLETION_EVENTID,
 	WMI_MGMT_TX_BUNDLE_COMPLETION_EVENTID,
 	WMI_TBTTOFFSET_EXT_UPDATE_EVENTID,
+	WMI_OFFCHAN_DATA_TX_COMPLETION_EVENTID,
+	WMI_HOST_FILS_DISCOVERY_EVENTID,
 	WMI_TX_DELBA_COMPLETE_EVENTID = WMI_TLV_CMD(WMI_GRP_BA_NEG),
 	WMI_TX_ADDBA_COMPLETE_EVENTID,
 	WMI_BA_RSP_SSN_EVENTID,
@@ -1810,6 +1815,7 @@ enum wmi_tlv_tag {
 	/* TODO add all the missing cmds */
 	WMI_TAG_PDEV_PEER_PKTLOG_FILTER_CMD = 0x301,
 	WMI_TAG_PDEV_PEER_PKTLOG_FILTER_INFO,
+	WMI_TAG_FILS_DISCOVERY_TMPL_CMD = 0x344,
 	WMI_TAG_MAX
 };
 
@@ -4076,6 +4082,17 @@ struct wmi_peer_assoc_conf_arg {
 	const u8 *macaddr;
 };
 
+struct wmi_fils_discovery_event {
+	u32 vdev_id;
+	u32 fils_tt;
+	u32 tbtt;
+} __packed;
+
+struct wmi_probe_resp_tx_status_event {
+	u32 vdev_id;
+	u32 tx_status;
+} __packed;
+
 /*
  * PDEV statistics
  */
@@ -4908,6 +4925,30 @@ struct wmi_dma_buf_release_meta_data {
 	u32 ch_width;
 } __packed;
 
+enum wmi_fils_discovery_cmd_type {
+	WMI_FILS_DISCOVERY_CMD,
+	WMI_UNSOL_BCAST_PROBE_RESP,
+};
+
+struct wmi_fils_discovery_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 interval;
+	u32 config; /* enum wmi_fils_discovery_cmd_type */
+} __packed;
+
+struct wmi_fils_discovery_tmpl_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 buf_len;
+} __packed;
+
+struct wmi_probe_tmpl_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 buf_len;
+} __packed;
+
 struct target_resource_config {
 	u32 num_vdevs;
 	u32 num_peers;
@@ -5121,4 +5162,10 @@ int ath11k_wmi_vdev_spectral_enable(struct ath11k *ar, u32 vdev_id,
 				    u32 trigger, u32 enable);
 int ath11k_wmi_vdev_spectral_conf(struct ath11k *ar,
 				  struct ath11k_wmi_vdev_spectral_conf_param *param);
+int ath11k_wmi_fils_discovery_tmpl(struct ath11k *ar, u32 vdev_id,
+				   struct sk_buff *tmpl);
+int ath11k_wmi_fils_discovery(struct ath11k *ar, u32 vdev_id, u32 interval,
+			      bool unsol_bcast_probe_resp_enabled);
+int ath11k_wmi_probe_resp_tmpl(struct ath11k *ar, u32 vdev_id,
+			       struct sk_buff *tmpl);
 #endif

base-commit: 1c1faf94d06b5d2fb96a8bbc45f643ef78e4a296
-- 
2.25.0

