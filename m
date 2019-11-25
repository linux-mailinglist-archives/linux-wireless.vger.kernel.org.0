Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2A1091F7
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 17:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfKYQga (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 11:36:30 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:58702
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728941AbfKYQg3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 11:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574699789;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=tmE1i/jAx9PA6sDRWctoEIwOAOdgfHBFW96bgGh1uDs=;
        b=CaJfzWZKSjktisrPAFFXvE9QxAdFvKGiH+OLYql7e3KY4kassuyUgOqGctd0KLb+
        1Kym1k0uXvFQ2/W9Nt2Jd2xUfGPfYaNgE+eWHOfghLrEeti1zOotaUU6ChPfCQ5tz4o
        xLsHPZLRSOieq0cXU5So98vdwghIIqSojIAJgBeQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574699789;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=tmE1i/jAx9PA6sDRWctoEIwOAOdgfHBFW96bgGh1uDs=;
        b=UPJvWGtgC0z3DO4SHKwAxdMxqqNAckHeBlCq4EKIaj78Td61vfH7nLuPWLYtN4jC
        KkjbUv1GpumgMPKl14ETYAF14Y/qmTi5pWu3cMoqg93cWZ6EUcNAPIOrl/b2GP1G1x1
        0QLs/8K5GlFxeybiR4tmghfU+k1sUD1mmJVN1zWM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F581C76F4D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 8/8] ath11k: add spatial reuse support
Date:   Mon, 25 Nov 2019 16:36:29 +0000
Message-ID: <0101016ea36beb2a-aa21eabe-b10d-4c77-8994-2ee06f461d92-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
References: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.25-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Trigger the WMI call en/disabling OBSS PD when the bss config changes or we
assoc to an AP that broadcasts the IE.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 10 ++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 16 ++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 70945d121fba..c25817c51d87 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1612,6 +1612,12 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 					1);
 	if (ret)
 		ath11k_warn(ar->ab, "Unable to authorize BSS peer: %d\n", ret);
+
+	ret = ath11k_wmi_send_obss_spr_cmd(ar, arvif->vdev_id,
+					   &bss_conf->he_obss_pd);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to set vdev %i OBSS PD parameters: %d\n",
+			    arvif->vdev_id, ret);
 }
 
 static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
@@ -1916,6 +1922,10 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 			ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev_idx);
 	}
 
+	if (changed & BSS_CHANGED_HE_OBSS_PD)
+		ath11k_wmi_send_obss_spr_cmd(ar, arvif->vdev_id,
+					     &info->he_obss_pd);
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 7aa66e8eecb6..2c3c973f5f7c 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2541,6 +2541,41 @@ ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id)
 	return ret;
 }
 
+int
+ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar, u32 vdev_id,
+			     struct ieee80211_he_obss_pd *he_obss_pd)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_sc->ab;
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
+			    "Failed to send WMI_PDEV_OBSS_PD_SPATIAL_REUSE_CMDID");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
 static void
 ath11k_fill_band_to_mac_param(struct ath11k_base  *soc,
 			      struct wmi_host_pdev_band_to_mac *band_to_mac)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b5c53f2ac5cc..7d5690c65279 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -172,6 +172,8 @@ enum wmi_cmd_group {
 	WMI_GRP_WLM            = 0x3c,
 	WMI_GRP_11K_OFFLOAD    = 0x3d,
 	WMI_GRP_TWT            = 0x3e,
+	WMI_GRP_MOTION_DET     = 0x3f,
+	WMI_GRP_SPATIAL_REUSE  = 0x40,
 };
 
 #define WMI_CMD_GRP(grp_id) (((grp_id) << 12) | 0x1)
@@ -539,6 +541,9 @@ enum wmi_tlv_cmd_id {
 	WMI_TWT_DEL_DIALOG_CMDID,
 	WMI_TWT_PAUSE_DIALOG_CMDID,
 	WMI_TWT_RESUME_DIALOG_CMDID,
+	WMI_PDEV_OBSS_PD_SPATIAL_REUSE_CMDID =
+				WMI_TLV_CMD(WMI_GRP_SPATIAL_REUSE),
+	WMI_PDEV_OBSS_PD_SPATIAL_REUSE_SET_DEF_OBSS_THRESH_CMDID,
 };
 
 enum wmi_tlv_event_id {
@@ -4559,6 +4564,15 @@ struct wmi_twt_disable_params_cmd {
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
@@ -4746,4 +4760,6 @@ void ath11k_wmi_fw_stats_fill(struct ath11k *ar,
 int ath11k_wmi_simulate_radar(struct ath11k *ar);
 int ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id);
 int ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id);
+int ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar, u32 vdev_id,
+				 struct ieee80211_he_obss_pd *he_obss_pd);
 #endif
-- 
2.7.4

