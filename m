Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5714231ED
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 13:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbfETLCS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 07:02:18 -0400
Received: from nbd.name ([46.4.11.11]:47810 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732256AbfETLCQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 07:02:16 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSg3Y-0003rt-Lm; Mon, 20 May 2019 13:02:12 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH 7/7] ath11k: add spatial reuse support
Date:   Mon, 20 May 2019 13:02:04 +0200
Message-Id: <20190520110204.27588-8-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520110204.27588-1-john@phrozen.org>
References: <20190520110204.27588-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Trigger the WMI call en/disabling OBSS PD when the bss config changes or we
assoc to an AP that broadcasts the IE.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 10 ++++++++
 drivers/net/wireless/ath/ath11k/wmi.c | 35 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 16 ++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ead546a33726..1f92a8c9baa3 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1714,6 +1714,12 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 					1);
 	if (ret)
 		ath11k_warn(ar->ab, "Unable to authorize BSS peer: %d\n", ret);
+
+	ret = ath11k_wmi_send_obss_spr_cmd(ar, arvif->vdev_id,
+					   &ap_sta->he_obss_pd);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to set vdev %i OBSS PD parameters: %d\n",
+			    arvif->vdev_id, ret);
 }
 
 static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
@@ -1905,6 +1911,10 @@ static void ath11k_bss_info_changed(struct ieee80211_hw *hw,
 			ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev_idx);
 	}
 
+	if (changed & BSS_CHANGED_HE_OBSS_PD)
+		ath11k_wmi_send_obss_spr_cmd(ar, arvif->vdev_id,
+					     &info->he_obss_pd);
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8fb45e9c1175..50c84f9e9cbf 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2584,6 +2584,41 @@ ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id)
 	return ret;
 }
 
+int
+ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar, u32 vdev_id,
+			     struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_sc->sc;
+	struct wmi_obss_spatial_reuse_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (void *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_OBSS_SPATIAL_REUSE_SET_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+	cmd->vdev_id = vdev_id;
+	cmd->enable = he_obss_pd->enable;
+	cmd->obss_min = he_obss_pd->min_offset;
+	cmd->obss_max = he_obss_pd->max_offset;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb,
+				  WMI_PDEV_OBSS_PD_SPATIAL_REUSE_CMDID);
+	if (ret) {
+		ath11k_warn(ab,
+			"Failed to send WMI_PDEV_OBSS_PD_SPATIAL_REUSE_CMDID");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
 static inline void ath11k_fill_band_to_mac_param(struct ath11k_base  *soc,
 				struct wmi_host_pdev_band_to_mac *band_to_mac)
 {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index c74aa98439ca..10f2a83db327 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -172,6 +172,8 @@ enum wmi_cmd_group {
 	WMI_GRP_WLM,            /* 0x3c */
 	WMI_GRP_11K_OFFLOAD,    /* 0x3d */
 	WMI_GRP_TWT,            /* 0x3e */
+	WMI_GRP_MOTION_DET,     /* 0x3f */
+	WMI_GRP_SPATIAL_REUSE,  /* 0x40 */
 
 };
 
@@ -541,6 +543,9 @@ enum wmi_tlv_cmd_id {
 	WMI_TWT_DEL_DIALOG_CMDID,
 	WMI_TWT_PAUSE_DIALOG_CMDID,
 	WMI_TWT_RESUME_DIALOG_CMDID,
+	WMI_PDEV_OBSS_PD_SPATIAL_REUSE_CMDID =
+				WMI_TLV_CMD(WMI_GRP_SPATIAL_REUSE),
+	WMI_PDEV_OBSS_PD_SPATIAL_REUSE_SET_DEF_OBSS_THRESH_CMDID,
 };
 
 enum wmi_tlv_event_id {
@@ -5114,6 +5119,15 @@ struct wmi_twt_disable_params_cmd {
 	u32 pdev_id;
 };
 
+struct wmi_obss_spatial_reuse_params_cmd {
+	u32 tlv_header;
+	u32 pdev_id;
+	u32 enable;
+	s32 obss_min;
+	s32 obss_max;
+	u32 vdev_id;
+};
+
 struct target_resource_config {
 	u32 num_vdevs;
 	u32 num_peers;
@@ -5305,4 +5319,6 @@ void ath11k_wmi_fw_stats_fill(struct ath11k *ar,
 int ath11k_wmi_simulate_radar(struct ath11k *ar);
 int ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id);
 int ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id);
+int ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar, u32 vdev_id,
+				 struct ieee80211_he_obss_pd *he_obss_pd);
 #endif
-- 
2.20.1

