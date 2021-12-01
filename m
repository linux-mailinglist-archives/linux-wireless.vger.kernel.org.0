Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0B34647C8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 08:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347177AbhLAHV1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 02:21:27 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25786 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232535AbhLAHV0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 02:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638343086; x=1669879086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BI3+p8GiIRT8JMKUpL6ZylF63LhDqLtXXrqbjg8P1MU=;
  b=g6jRuGDN7lH1ytfpo6gSj9ULAPAgf8pwTrZlCyzYATU6NrWEq8WG7I4F
   27Y97LKa4khI8wbG6S/sNF3fBn+Gft00iQ3lJmaVuBL41RRcptUs1L8/t
   FZttiE6znaCSgz9/CiCXXaotAjlydNjQdntfSgvH++0wrfUrPr3d0LfkP
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Nov 2021 23:18:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 23:18:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 23:18:05 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 30 Nov 2021 23:18:04 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 2/3] ath11k: add configure country code for QCA6390 and WCN6855
Date:   Wed, 1 Dec 2021 02:17:44 -0500
Message-ID: <20211201071745.17746-3-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201071745.17746-1-quic_wgong@quicinc.com>
References: <20211201071745.17746-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware which
is used for QCA6390 and WCN6855.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 36 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 12 +++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index a3a8c49b3329..47361256bfeb 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2798,6 +2798,42 @@ ath11k_wmi_send_init_country_cmd(struct ath11k *ar,
 	return ret;
 }
 
+int ath11k_wmi_send_set_current_country_cmd(struct ath11k *ar,
+					    struct wmi_set_current_country_params *param)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_set_current_country_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_set_current_country_cmd *)skb->data;
+	cmd->tlv_header =
+		FIELD_PREP(WMI_TLV_TAG, WMI_TAG_SET_CURRENT_COUNTRY_CMD) |
+		FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+
+	cmd->pdev_id = ar->pdev->pdev_id;
+	memcpy(&cmd->new_alpha2, &param->alpha2, 3);
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_SET_CURRENT_COUNTRY_CMDID);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "set current country pdev id %d alpha2 %c%c\n",
+		   ar->pdev->pdev_id,
+		   param->alpha2[0],
+		   param->alpha2[1]);
+
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send WMI_SET_CURRENT_COUNTRY_CMDID: %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int
 ath11k_wmi_send_thermal_mitigation_param_cmd(struct ath11k *ar,
 					     struct thermal_mitigation_params *param)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8e8bac1b7370..49db414d0bf3 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3770,6 +3770,16 @@ struct stats_request_params {
 	u32 pdev_id;
 };
 
+struct wmi_set_current_country_params {
+	u8 alpha2[3];
+};
+
+struct wmi_set_current_country_cmd {
+	u32 tlv_header;
+	u32 pdev_id;
+	u32 new_alpha2;
+} __packed;
+
 enum set_init_cc_type {
 	WMI_COUNTRY_INFO_TYPE_ALPHA,
 	WMI_COUNTRY_INFO_TYPE_COUNTRY_CODE,
@@ -5433,6 +5443,8 @@ int ath11k_wmi_delba_send(struct ath11k *ar, u32 vdev_id, const u8 *mac,
 			  u32 tid, u32 initiator, u32 reason);
 int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 					    u32 vdev_id, u32 bcn_ctrl_op);
+int ath11k_wmi_send_set_current_country_cmd(struct ath11k *ar,
+					    struct wmi_set_current_country_params *param);
 int
 ath11k_wmi_send_init_country_cmd(struct ath11k *ar,
 				 struct wmi_init_country_params init_cc_param);
-- 
2.31.1

