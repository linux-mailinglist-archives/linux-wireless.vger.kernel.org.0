Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A04428BC3
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 13:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhJKLH5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 07:07:57 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:40889 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbhJKLH4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 07:07:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633950356; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ezeZl4XrLVsW1PG+y11ZDRYlks5U+Sk5/zTWfQIE2xk=; b=jNqlgIGMjKVGIn9gvfmyorfikc6tMTkl6En/qH4q48CGyKm4a8O1GU9s5oNOT5ryDgPX4mh7
 0Zb/8y+sFdQuwOqPPvTE6zOMgnoXT6b6y8L3AMcTiXjeSqmzWN+mXXDj6KI4C2fub80KnCj3
 OyKhil00Xj+LORryKun+q6oZU/c=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61641a94ff0285fb0a0d8bf1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 11:05:56
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F9C7C4360D; Mon, 11 Oct 2021 11:05:56 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6CFDC4360C;
        Mon, 11 Oct 2021 11:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B6CFDC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: enable power save in station mode
Date:   Mon, 11 Oct 2021 15:06:25 -0400
Message-Id: <20211011190625.4463-1-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable power save in station mode.

Run "iw dev wls1 set power_save off",  check there is no NULL Data frame
from sniffer. Run "iw dev wls1 set power_save on", check there is NULL
Data frame from sniffer.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  5 ++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 99 ++++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.c  | 33 ++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h  |  3 +-
 6 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 6120382..7e4b5b3 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -67,6 +67,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = true,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
+		.protocol_ps = false,
 		.cold_boot_calib = true,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
@@ -108,6 +109,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = true,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
+		.protocol_ps = false,
 		.cold_boot_calib = true,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
@@ -149,6 +151,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = false,
 		.supports_shadow_regs = true,
 		.idle_ps = true,
+		.protocol_ps = true,
 		.cold_boot_calib = false,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
@@ -187,6 +190,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = true,
 		.supports_shadow_regs = false,
 		.idle_ps = false,
+		.protocol_ps = false,
 		.cold_boot_calib = false,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
@@ -227,6 +231,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_monitor = false,
 		.supports_shadow_regs = true,
 		.idle_ps = true,
+		.protocol_ps = true,
 		.cold_boot_calib = false,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index f0a4b90..61e9684 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -276,6 +276,7 @@ struct ath11k_vif {
 	bool is_started;
 	bool is_up;
 	bool spectral_enabled;
+	bool ps;
 	u32 aid;
 	u8 bssid[ETH_ALEN];
 	struct cfg80211_bitrate_mask bitrate_mask;
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 7a5101d..d4ad6f2 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -167,6 +167,7 @@ struct ath11k_hw_params {
 	bool supports_monitor;
 	bool supports_shadow_regs;
 	bool idle_ps;
+	bool protocol_ps;
 	bool cold_boot_calib;
 	bool supports_suspend;
 	u32 hal_desc_sz;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d02823f..a254ef3 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -883,12 +883,93 @@ static int ath11k_monitor_vdev_up(struct ath11k *ar, int vdev_id)
 	return 0;
 }
 
+static int ath11k_mac_vif_setup_ps(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_conf *conf = &ar->hw->conf;
+	enum wmi_sta_powersave_param param;
+	enum wmi_sta_ps_mode psmode;
+	int ret;
+	int ps_timeout;
+	bool enable_ps;
+
+	lockdep_assert_held(&arvif->ar->conf_mutex);
+
+	if (arvif->vif->type != NL80211_IFTYPE_STATION)
+		return 0;
+
+	enable_ps = arvif->ps;
+
+	/* need to check if multiple vdev ps setting is supported */
+
+	if (!arvif->is_started) {
+		/* mac80211 can update vif powersave state while disconnected.
+		 * Firmware doesn't behave nicely and consumes more power than
+		 * necessary if PS is disabled on a non-started vdev. Hence
+		 * force-enable PS for non-running vdevs.
+		 */
+		psmode = WMI_STA_PS_MODE_ENABLED;
+	} else if (enable_ps) {
+		psmode = WMI_STA_PS_MODE_ENABLED;
+		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
+
+		ps_timeout = conf->dynamic_ps_timeout;
+		if (ps_timeout == 0) {
+			/* Firmware doesn't like 0 */
+			ps_timeout = ieee80211_tu_to_usec(
+				vif->bss_conf.beacon_int) / 1000;
+		}
+
+		ret = ath11k_wmi_set_sta_ps_param(ar, arvif->vdev_id, param,
+						  ps_timeout);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set inactivity time for vdev %d: %i\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	} else {
+		psmode = WMI_STA_PS_MODE_DISABLED;
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev %d psmode %s\n",
+		   arvif->vdev_id, psmode ? "enable" : "disable");
+	ret = ath11k_wmi_set_psmode(ar, arvif->vdev_id, psmode);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set PS Mode %d for vdev %d: %d\n",
+			    psmode, arvif->vdev_id, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ath11k_config_ps(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+	int ret = 0;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath11k_mac_vif_setup_ps(arvif);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to setup powersave: %d\n", ret);
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 {
-	/* mac80211 requires this op to be present and that's why
-	 * there's an empty function, this can be extended when
-	 * required.
-	 */
+	struct ath11k *ar = hw->priv;
+
+	mutex_lock(&ar->conf_mutex);
+	if (changed & IEEE80211_CONF_CHANGE_PS)
+		ath11k_config_ps(ar);
+	mutex_unlock(&ar->conf_mutex);
 
 	return 0;
 }
@@ -2610,6 +2691,16 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (changed & BSS_CHANGED_PS &&
+	    ar->ab->hw_params.protocol_ps) {
+		arvif->ps = vif->bss_conf.ps;
+
+		ret = ath11k_config_ps(ar);
+		if (ret)
+			ath11k_warn(ar->ab, "failed to setup ps on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+	}
+
 	if (changed & BSS_CHANGED_MCAST_RATE &&
 	    !ath11k_mac_vif_chan(arvif->vif, &def)) {
 		band = def.chan->band;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 27ae944..8f46864 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1419,6 +1419,39 @@ int ath11k_wmi_send_set_ap_ps_param_cmd(struct ath11k *ar, u8 *peer_addr,
 	return ret;
 }
 
+int ath11k_wmi_set_psmode(struct ath11k *ar, u32 vdev_id,
+			  enum wmi_sta_ps_mode psmode)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_sta_powersave_mode_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_sta_powersave_mode_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_STA_POWERSAVE_MODE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = vdev_id;
+	cmd->sta_ps_mode = psmode;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI set sta ps vdev_id %d ps %d\n",
+		   vdev_id, psmode);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_STA_POWERSAVE_MODE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_STA_POWERSAVE_PARAM_CMDID");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int ath11k_wmi_set_sta_ps_param(struct ath11k *ar, u32 vdev_id,
 				u32 param, u32 param_value)
 {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 0730bdb..e2cce86 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5600,7 +5600,8 @@ int ath11k_wmi_send_peer_create_cmd(struct ath11k *ar,
 				    struct peer_create_params *param);
 int ath11k_wmi_vdev_set_param_cmd(struct ath11k *ar, u32 vdev_id,
 				  u32 param_id, u32 param_value);
-
+int ath11k_wmi_set_psmode(struct ath11k *ar, u32 vdev_id,
+			  enum wmi_sta_ps_mode psmode);
 int ath11k_wmi_set_sta_ps_param(struct ath11k *ar, u32 vdev_id,
 				u32 param, u32 param_value);
 int ath11k_wmi_force_fw_hang_cmd(struct ath11k *ar, u32 type, u32 delay_time_ms);
-- 
2.7.4

