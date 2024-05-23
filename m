Return-Path: <linux-wireless+bounces-7980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6658CCB2C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 05:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9821C210D3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 03:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BAC3BBD5;
	Thu, 23 May 2024 03:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oF3ABSWz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F812B16A
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716435140; cv=none; b=b6I/VMA2UE0iexHAvTNPiLuZEWAyaumU9/gtFkUMxIrXVGutj4q1UvxtuThlw6N4USPs/zdpYw0kurF7TkRI3tkiwb2AnNELQS5ascsPOjtaVOiQISHE970O1iNUf6YRWsjWr/ZZPk0o1vMBsDJGCP77mQosRVPE7+nfXvhNKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716435140; c=relaxed/simple;
	bh=806rdnS1asVml3TdQVKI+usWjwmlumav1hXEOKQVQxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qp2fYTUV8p4chzisYIOP6yXUlNanv7aOXE1MKshDsWbtSqxNYKrpa8Mfa0Vk3q6wVz/8RpF53P41qbcNcTDH/tqXqxbE/ZMC3PAJojwjPHxMRXi7RP5jKCBhRtU1sgBYTrq+78FJPy8AShLa8I8o6e3bcb4croF34N0JhkPk+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oF3ABSWz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MKV4Cv013107;
	Thu, 23 May 2024 03:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=NBN+fVqAItuKnCGlMNtU49sdo2swJDQQdUObtZYsByA=; b=oF
	3ABSWzXCQTbp3iilmCduR5LqWs7nn2TQzMgrL55uygRrdXHjFBffFO1HJJ9ogiHk
	4+R957QNbwdxOrLRlV1+uwE44QyzSn6rVQ+wwPwdy3UHjEZZN2br7JgQuTPL3Nfa
	MuRUSMxUOCF+9aKJWVO439W292v066g6JyHWNFwwZu0q7oYZGj52kWQOnJwaqgo2
	8hr3PeJwAh9OC4OKUw41vqdHsL1hIA0dSXVoWRv1o8th/ZDfjIMHT2C4QAti1i+W
	CCq3pJ6LkQ6xXifCbn9LxlvZIwEDnm4U0sdDq2nIVFG2Aoz7qaztkj8B5uA4BzhE
	66yw4usWBGXSJ5A33Ugw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n3tkag9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:32:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44N3W5G4011897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 03:32:05 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 22 May 2024 20:32:03 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2 4/7] wifi: ath12k: implement hardware data filter
Date: Thu, 23 May 2024 11:31:40 +0800
Message-ID: <20240523033143.21677-5-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523033143.21677-1-quic_bqiang@quicinc.com>
References: <20240523033143.21677-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oFq8Fep7lLUjoEthunDSN_-6G3q80U4k
X-Proofpoint-ORIG-GUID: oFq8Fep7lLUjoEthunDSN_-6G3q80U4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_01,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=969
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230023

Host needs to set hardware data filter before entering WoW to
let firmware drop needless broadcast/multicast frames to avoid
frequent wakeup. Host clears hardware data filter when leaving WoW.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 31 +++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 21 +++++++++
 drivers/net/wireless/ath/ath12k/wow.c | 66 +++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 63ce1c76b82c..851f320e73c7 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7422,6 +7422,37 @@ void ath12k_wmi_detach(struct ath12k_base *ab)
 	ath12k_wmi_free_dbring_caps(ab);
 }
 
+int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar, struct wmi_hw_data_filter_arg *arg)
+{
+	struct wmi_hw_data_filter_cmd *cmd;
+	struct sk_buff *skb;
+	int len;
+
+	len = sizeof(*cmd);
+	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
+
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_hw_data_filter_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_HW_DATA_FILTER_CMD,
+						 sizeof(*cmd));
+	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
+	cmd->enable = cpu_to_le32(arg->enable ? 1 : 0);
+
+	/* Set all modes in case of disable */
+	if (arg->enable)
+		cmd->hw_filter_bitmap = cpu_to_le32(arg->hw_filter_bitmap);
+	else
+		cmd->hw_filter_bitmap = cpu_to_le32((u32)~0U);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "wmi hw data filter enable %d filter_bitmap 0x%x\n",
+		   arg->enable, arg->hw_filter_bitmap);
+
+	return ath12k_wmi_cmd_send(ar->wmi, skb, WMI_HW_DATA_FILTER_CMDID);
+}
+
 int ath12k_wmi_wow_host_wakeup_ind(struct ath12k *ar)
 {
 	struct wmi_wow_host_wakeup_cmd *cmd;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 6e5d9a25255e..477e2a37eb9c 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5297,6 +5297,25 @@ struct wmi_wow_nlo_config_cmd {
 	 */
 } __packed;
 
+/* Definition of HW data filtering */
+enum hw_data_filter_type {
+	WMI_HW_DATA_FILTER_DROP_NON_ARP_BC = BIT(0),
+	WMI_HW_DATA_FILTER_DROP_NON_ICMPV6_MC = BIT(1),
+};
+
+struct wmi_hw_data_filter_cmd {
+	__le32 tlv_header;
+	__le32 vdev_id;
+	__le32 enable;
+	__le32 hw_filter_bitmap;
+} __packed;
+
+struct wmi_hw_data_filter_arg {
+	u32 vdev_id;
+	bool enable;
+	u32 hw_filter_bitmap;
+};
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
@@ -5460,4 +5479,6 @@ int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
 				    u32 enable);
 int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
 			      struct wmi_pno_scan_req_arg  *pno_scan);
+int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar,
+				  struct wmi_hw_data_filter_arg *arg);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 330bd39f75c0..77658a01bb41 100644
--- a/drivers/net/wireless/ath/ath12k/wow.c
+++ b/drivers/net/wireless/ath/ath12k/wow.c
@@ -538,6 +538,59 @@ static int ath12k_wow_nlo_cleanup(struct ath12k *ar)
 	return 0;
 }
 
+static int ath12k_wow_set_hw_filter(struct ath12k *ar)
+{
+	struct wmi_hw_data_filter_arg arg;
+	struct ath12k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+			continue;
+
+		arg.vdev_id = arvif->vdev_id;
+		arg.enable = true;
+		arg.hw_filter_bitmap = WMI_HW_DATA_FILTER_DROP_NON_ICMPV6_MC;
+		ret = ath12k_wmi_hw_data_filter_cmd(ar, &arg);
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to set hw data filter on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ath12k_wow_clear_hw_filter(struct ath12k *ar)
+{
+	struct wmi_hw_data_filter_arg arg;
+	struct ath12k_vif *arvif;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
+			continue;
+
+		arg.vdev_id = arvif->vdev_id;
+		arg.enable = false;
+		arg.hw_filter_bitmap = 0;
+		ret = ath12k_wmi_hw_data_filter_cmd(ar, &arg);
+
+		if (ret) {
+			ath12k_warn(ar->ab, "failed to clear hw data filter on vdev %i: %d\n",
+				    arvif->vdev_id, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
@@ -567,6 +620,13 @@ int ath12k_wow_op_suspend(struct ieee80211_hw *hw,
 		goto cleanup;
 	}
 
+	ret = ath12k_wow_set_hw_filter(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set hw filter: %d\n",
+			    ret);
+		goto cleanup;
+	}
+
 	ret = ath12k_wow_enable(ar);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to start wow: %d\n", ret);
@@ -634,6 +694,12 @@ int ath12k_wow_op_resume(struct ieee80211_hw *hw)
 		goto exit;
 	}
 
+	ret = ath12k_wow_clear_hw_filter(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to clear hw filter: %d\n", ret);
+		goto exit;
+	}
+
 exit:
 	if (ret) {
 		switch (ah->state) {
-- 
2.25.1


