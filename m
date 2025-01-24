Return-Path: <linux-wireless+bounces-17889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBC8A1B046
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 07:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2691918893E6
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 06:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7532A1E495;
	Fri, 24 Jan 2025 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kosIENLa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DDD1D8DE4
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737699246; cv=none; b=tnFIqmRQVeJWLxbldSBzCgfUJPmvresHwzkaclGaHC6sMV1tM57t1+ROIXva+lFw12UK27WCgUAOYjx85rwQ2BO7CfpZ4gDCxv9ph/4E2Ij8LbpscmB7JnKa7tUEPIKzugSNfpHYMNAXFDYeaRFVtcLgOyX5A1Ho9ChD0LLFu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737699246; c=relaxed/simple;
	bh=HF507TlUiYMOBCJNcqAbCzRSmAqOrDP3c4cVvfTEGYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=An/QE+rv3TtylAfetwJkpFWxQIg19gH53RZsf7BPaf2jWw9Z0PxaSizFu5QandWpOthe4LCtYVtb1uhk1hK+7gvorb1w3fKu2IX4c0tvCxHf+duNPEwGkdDd6Jieqak+obXgmOwMeHCqVbfce0Xfx77xFS2BnwJBPwNg6pL6KTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kosIENLa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O4WtKh008985;
	Fri, 24 Jan 2025 06:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jkl0Z7sUV8WZzPI7aA1IGm
	8DjIikxT32pn7K/4R1XLA=; b=kosIENLah3l98B86CMVu2BenjPS0fdwwJ7X6Ef
	NeIlLP5VTYC2eZ8sHu4BloPMXyv1Cydr01f56Q6JpnqFFHdbLtJTvJYYAwsfN2U5
	YwC3DdIcL/qrp4S56O+My2B5VtlTbPbQJk5ct+hFf7SK62YVkHPd/Gszsh5WTrH7
	f8CtFpTy42xQ52fAw9WLBMn5Fx6uMe7Zm+/6H+miUTmwhbCg14FLfZ8CaqI4zD3v
	+EzAZnYCF90JgsbCvH3viyZeKu+y3S6KflqTIQMRddo4fzn8zQeoMrEqe/g0YBGS
	o4f9z3yxDZgGDcmPIUDPSK5qfKvEyhVpGQ4LdvjlCnWWKcbA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c3xa85y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 06:13:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O6DwNX031493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 06:13:58 GMT
Received: from yuzha-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 22:13:57 -0800
From: "Yu Zhang(Yuriy)" <quic_yuzha@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_yuzha@quicinc.com>
Subject: [PATCH] wifi: ath11k: add support for MU EDCA
Date: Fri, 24 Jan 2025 14:13:43 +0800
Message-ID: <20250124061343.2263467-1-quic_yuzha@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iU3l9DJg880EjKppPVVYhSmqJldN9Q5l
X-Proofpoint-ORIG-GUID: iU3l9DJg880EjKppPVVYhSmqJldN9Q5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_02,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501240042

The current code does not have the MU EDCA feature, so it cannot support
the use of EDCA by STA in specific UL MU HE TB PPDU transmissions. Refer
to IEEE Std 802.11ax-2021 "9.4.2.251 MU EDCA Parameter Set element",
"26.2.7 EDCA operation using MU EDCA parameters".

Add ath11k_mac_op_conf_tx_mu_edca() to construct the MU EDCA parameters
received from mac80211 into WMI WMM parameters，and send to the firmware
according to the different WMM type flags.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04523-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Yu Zhang(Yuriy) <quic_yuzha@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h |  3 +-
 drivers/net/wireless/ath/ath11k/mac.c  | 53 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.c  | 11 +++---
 drivers/net/wireless/ath/ath11k/wmi.h  | 10 ++++-
 4 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a9dc7fe7765a..92b14fc43cb6 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_CORE_H
@@ -370,6 +370,7 @@ struct ath11k_vif {
 	struct ieee80211_vif *vif;
 
 	struct wmi_wmm_params_all_arg wmm_params;
+	struct wmi_wmm_params_all_arg muedca_params;
 	struct list_head list;
 	union {
 		struct {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 31ae9b384a29..85864f7dd076 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -5204,6 +5204,45 @@ static int ath11k_conf_tx_uapsd(struct ath11k *ar, struct ieee80211_vif *vif,
 	return ret;
 }
 
+static int ath11k_mac_op_conf_tx_mu_edca(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 unsigned int link_id, u16 ac,
+					 const struct ieee80211_tx_queue_params *params)
+{
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	struct ath11k *ar = hw->priv;
+	struct wmi_wmm_params_arg *p;
+	int ret;
+
+	switch (ac) {
+	case IEEE80211_AC_VO:
+		p = &arvif->muedca_params.ac_vo;
+		break;
+	case IEEE80211_AC_VI:
+		p = &arvif->muedca_params.ac_vi;
+		break;
+	case IEEE80211_AC_BE:
+		p = &arvif->muedca_params.ac_be;
+		break;
+	case IEEE80211_AC_BK:
+		p = &arvif->muedca_params.ac_bk;
+		break;
+	default:
+		ath11k_warn(ar->ab, "error ac: %d", ac);
+		return -EINVAL;
+	}
+
+	p->cwmin = u8_get_bits(params->mu_edca_param_rec.ecw_min_max, GENMASK(3, 0));
+	p->cwmax = u8_get_bits(params->mu_edca_param_rec.ecw_min_max, GENMASK(7, 4));
+	p->aifs = u8_get_bits(params->mu_edca_param_rec.aifsn, GENMASK(3, 0));
+	p->txop = params->mu_edca_param_rec.mu_edca_timer;
+
+	ret = ath11k_wmi_send_wmm_update_cmd_tlv(ar, arvif->vdev_id,
+						 &arvif->muedca_params,
+						 WMI_WMM_PARAM_TYPE_11AX_MU_EDCA);
+	return ret;
+}
+
 static int ath11k_mac_op_conf_tx(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 unsigned int link_id, u16 ac,
@@ -5242,12 +5281,22 @@ static int ath11k_mac_op_conf_tx(struct ieee80211_hw *hw,
 	p->txop = params->txop;
 
 	ret = ath11k_wmi_send_wmm_update_cmd_tlv(ar, arvif->vdev_id,
-						 &arvif->wmm_params);
+						 &arvif->wmm_params,
+						 WMI_WMM_PARAM_TYPE_LEGACY);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to set wmm params: %d\n", ret);
 		goto exit;
 	}
 
+	if (params->mu_edca) {
+		ret = ath11k_mac_op_conf_tx_mu_edca(hw, vif, link_id, ac,
+						    params);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set mu_edca params: %d\n", ret);
+			goto exit;
+		}
+	}
+
 	ret = ath11k_conf_tx_uapsd(ar, vif, ac, params->uapsd);
 
 	if (ret)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 87abfa547529..d7f852bebf4a 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -2662,7 +2662,8 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 }
 
 int ath11k_wmi_send_wmm_update_cmd_tlv(struct ath11k *ar, u32 vdev_id,
-				       struct wmi_wmm_params_all_arg *param)
+				       struct wmi_wmm_params_all_arg *param,
+				       enum wmi_wmm_params_type wmm_param_type)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_vdev_set_wmm_params_cmd *cmd;
@@ -2681,7 +2682,7 @@ int ath11k_wmi_send_wmm_update_cmd_tlv(struct ath11k *ar, u32 vdev_id,
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
 
 	cmd->vdev_id = vdev_id;
-	cmd->wmm_param_type = 0;
+	cmd->wmm_param_type = wmm_param_type;
 
 	for (ac = 0; ac < WME_NUM_AC; ac++) {
 		switch (ac) {
@@ -2714,8 +2715,8 @@ int ath11k_wmi_send_wmm_update_cmd_tlv(struct ath11k *ar, u32 vdev_id,
 		wmm_param->no_ack = wmi_wmm_arg->no_ack;
 
 		ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-			   "wmm set ac %d aifs %d cwmin %d cwmax %d txop %d acm %d no_ack %d\n",
-			   ac, wmm_param->aifs, wmm_param->cwmin,
+			   "wmm set type %d ac %d aifs %d cwmin %d cwmax %d txop %d acm %d no_ack %d\n",
+			   wmm_param_type, ac, wmm_param->aifs, wmm_param->cwmin,
 			   wmm_param->cwmax, wmm_param->txoplimit,
 			   wmm_param->acm, wmm_param->no_ack);
 	}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8982b909c821..508bd496488a 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_WMI_H
@@ -6346,6 +6346,11 @@ enum wmi_sta_keepalive_method {
 #define WMI_STA_KEEPALIVE_INTERVAL_DEFAULT	30
 #define WMI_STA_KEEPALIVE_INTERVAL_DISABLE	0
 
+enum wmi_wmm_params_type {
+	WMI_WMM_PARAM_TYPE_LEGACY = 0,
+	WMI_WMM_PARAM_TYPE_11AX_MU_EDCA = 1,
+};
+
 const void **ath11k_wmi_tlv_parse_alloc(struct ath11k_base *ab,
 					struct sk_buff *skb, gfp_t gfp);
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
@@ -6402,7 +6407,8 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 int ath11k_wmi_send_scan_stop_cmd(struct ath11k *ar,
 				  struct scan_cancel_param *param);
 int ath11k_wmi_send_wmm_update_cmd_tlv(struct ath11k *ar, u32 vdev_id,
-				       struct wmi_wmm_params_all_arg *param);
+				       struct wmi_wmm_params_all_arg *param,
+				       enum wmi_wmm_params_type wmm_param_type);
 int ath11k_wmi_pdev_suspend(struct ath11k *ar, u32 suspend_opt,
 			    u32 pdev_id);
 int ath11k_wmi_pdev_resume(struct ath11k *ar, u32 pdev_id);
-- 
2.34.1


