Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09590428C22
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 13:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhJKLje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 07:39:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52628 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhJKLje (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 07:39:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633952254; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4m4L7rzhSuWR0C4WClTZFH5QOYDfAt/iDpCC9ehNhZU=; b=SHQG73ubAZLIxflysTeUZmdnygUo82DscYPv3UJ7HG2VeBWcRLET/hAn2RBIshHkFOl5TGuj
 Aq9jIL6maHgiYJs2ZVhpE/ppJQ/IPsa7QL2LQN7GtRq03c/qMcHKg2IH0qYzibOFN3sVgvun
 fMKRmWEa2WwbTXso2lluR+/YQ3g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 616421f9446c6db0cb56e133 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 11:37:29
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71C6CC43616; Mon, 11 Oct 2021 11:37:28 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29745C4338F;
        Mon, 11 Oct 2021 11:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 29745C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/6] ath11k: implement hw data filter
Date:   Mon, 11 Oct 2021 15:37:47 -0400
Message-Id: <20211011193750.4891-4-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011193750.4891-1-cjhuang@codeaurora.org>
References: <20211011193750.4891-1-cjhuang@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host needs to set hw data filter before entering WoW to
let firmware drop needless bc/mc frames to avoid frequent wakeup.
Host clears hw data filter when leaving WoW.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 32 ++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 15 +++++++++
 drivers/net/wireless/ath/ath11k/wow.c | 57 ++++++++++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 9f466fe..be880dc 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8348,6 +8348,38 @@ void ath11k_wmi_detach(struct ath11k_base *ab)
 	ath11k_wmi_free_dbring_caps(ab);
 }
 
+int ath11k_wmi_send_hw_data_filter_cmd(struct ath11k *ar, u32 vdev_id,
+				       u32 filter_bitmap, bool enable)
+{
+	struct wmi_hw_data_filter_cmd *cmd;
+	struct sk_buff *skb;
+	int len;
+
+	len = sizeof(*cmd);
+	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_hw_data_filter_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_HW_DATA_FILTER_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->vdev_id = vdev_id;
+	cmd->enable = enable;
+	/* Set all modes in case of disable */
+	if (cmd->enable)
+		cmd->hw_filter_bitmap = filter_bitmap;
+	else
+		cmd->hw_filter_bitmap = ((u32)~0U);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi set hw filter enable %d, filter_bitmap:0x%x\n",
+		   enable, filter_bitmap);
+
+	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
+}
+
 int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar)
 {
 	struct wmi_wow_host_wakeup_ind *cmd;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 6d3dfb9..1301b17 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5400,6 +5400,19 @@ struct ath11k_wmi_base {
 	struct ath11k_targ_cap *targ_cap;
 };
 
+/* Definition of HW data filtering */
+enum hw_data_filter_type {
+	WMI_HW_DATA_FILTER_DROP_NON_ARP_BC = BIT(0),
+	WMI_HW_DATA_FILTER_DROP_NON_ICMPV6_MC = BIT(1),
+};
+
+struct wmi_hw_data_filter_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	u32 enable;
+	u32 hw_filter_bitmap;
+} __packed;
+
 /* WOW structures */
 enum wmi_wow_wakeup_event {
 	WOW_BMISS_EVENT = 0,
@@ -5956,4 +5969,6 @@ int ath11k_wmi_wow_add_pattern(struct ath11k *ar, u32 vdev_id, u32 pattern_id,
 int ath11k_wmi_wow_add_wakeup_event(struct ath11k *ar, u32 vdev_id,
 				    enum wmi_wow_wakeup_event event,
 				    u32 enable);
+int ath11k_wmi_send_hw_data_filter_cmd(struct ath11k *ar, u32 vdev_id,
+				       u32 filter_bitmap, bool enable);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wow.c b/drivers/net/wireless/ath/ath11k/wow.c
index 839c58e7..35f1c5c 100644
--- a/drivers/net/wireless/ath/ath11k/wow.c
+++ b/drivers/net/wireless/ath/ath11k/wow.c
@@ -507,6 +507,48 @@ static int ath11k_wow_nlo_cleanup(struct ath11k *ar)
 	return 0;
 }
 
+static int ath11k_wow_set_hw_filter(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath11k_wmi_send_hw_data_filter_cmd(ar, arvif->vdev_id,
+							 WMI_HW_DATA_FILTER_DROP_NON_ICMPV6_MC |
+							 WMI_HW_DATA_FILTER_DROP_NON_ARP_BC,
+							 true);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set hw data filter on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ath11k_wow_clear_hw_filter(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		ret = ath11k_wmi_send_hw_data_filter_cmd(ar, arvif->vdev_id, 0, false);
+
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to clear hw data filter on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
@@ -535,6 +577,13 @@ int ath11k_wow_op_suspend(struct ieee80211_hw *hw,
 		goto cleanup;
 	}
 
+	ret = ath11k_wow_set_hw_filter(ar);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set hw filter: %d\n",
+			    ret);
+		goto cleanup;
+	}
+
 	ret = ath11k_wow_enable(ar->ab);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to start wow: %d\n", ret);
@@ -598,8 +647,14 @@ int ath11k_wow_op_resume(struct ieee80211_hw *hw)
 	}
 
 	ret = ath11k_wow_nlo_cleanup(ar);
-	if (ret)
+	if (ret) {
 		ath11k_warn(ar->ab, "failed to cleanup nlo: %d\n", ret);
+		goto exit;
+	}
+
+	ret = ath11k_wow_clear_hw_filter(ar);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to clear hw filter: %d\n", ret);
 
 exit:
 	if (ret) {
-- 
2.7.4

