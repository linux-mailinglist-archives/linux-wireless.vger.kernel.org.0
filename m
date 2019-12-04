Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797F6113397
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 19:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfLDSR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 13:17:59 -0500
Received: from nbd.name ([46.4.11.11]:40910 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729411AbfLDSR5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 13:17:57 -0500
Received: from p5dcfb666.dip0.t-ipconnect.de ([93.207.182.102] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1icZDk-0005Od-Fg; Wed, 04 Dec 2019 19:17:52 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 1/9] ath11k: add wmi helper for turning STA PS on/off
Date:   Wed,  4 Dec 2019 19:17:37 +0100
Message-Id: <20191204181745.27297-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204181745.27297-1-john@phrozen.org>
References: <20191204181745.27297-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a WMI call helper to set the powersave mode of a STA interface.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 30 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b05642617b78..bf3c246ce883 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1178,6 +1178,36 @@ int ath11k_wmi_pdev_set_param(struct ath11k *ar, u32 param_id,
 	return ret;
 }
 
+int ath11k_wmi_pdev_set_ps_mode(struct ath11k *ar, int vdev_id, u32 enable)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_pdev_set_ps_mode_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_pdev_set_ps_mode_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_STA_POWERSAVE_MODE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->vdev_id = vdev_id;
+	cmd->sta_ps_mode = enable;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_STA_POWERSAVE_MODE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_PDEV_SET_PARAM cmd\n");
+		dev_kfree_skb(skb);
+	}
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "WMI vdev set psmode %d vdev id %d\n",
+		   enable, vdev_id);
+
+	return ret;
+}
+
 int ath11k_wmi_pdev_suspend(struct ath11k *ar, u32 suspend_opt,
 			    u32 pdev_id)
 {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 4a518d406bc5..9919d8bf297b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2827,6 +2827,12 @@ struct wmi_pdev_set_param_cmd {
 	u32 param_value;
 } __packed;
 
+struct wmi_pdev_set_ps_mode_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 sta_ps_mode;
+} __packed;
+
 struct wmi_pdev_suspend_cmd {
 	u32 tlv_header;
 	u32 pdev_id;
@@ -4682,6 +4688,7 @@ int ath11k_wmi_set_peer_param(struct ath11k *ar, const u8 *peer_addr,
 			      u32 vdev_id, u32 param_id, u32 param_val);
 int ath11k_wmi_pdev_set_param(struct ath11k *ar, u32 param_id,
 			      u32 param_value, u8 pdev_id);
+int ath11k_wmi_pdev_set_ps_mode(struct ath11k *ar, int vdev_id, u32 enable);
 int ath11k_wmi_wait_for_unified_ready(struct ath11k_base *ab);
 int ath11k_wmi_cmd_init(struct ath11k_base *ab);
 int ath11k_wmi_wait_for_service_ready(struct ath11k_base *ab);
-- 
2.20.1

