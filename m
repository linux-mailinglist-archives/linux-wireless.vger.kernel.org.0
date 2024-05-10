Return-Path: <linux-wireless+bounces-7432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B5A8C1E5D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 08:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE9F285475
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 06:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8E715E203;
	Fri, 10 May 2024 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R1TtGlOq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1274158A3A
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323692; cv=none; b=fzLwmkXBHoQPhvghD4KHa6GUIEp36OWmva43zAeblkoXTpuv/Beq4FlmsB3dZgaMZk3hmIdHLJsK90lMYa3CAua2v+NT1tfpPiiLVj7edWyTWZMRxD6mxDN3EPbclCKxIRviw9CSUrHFXZzKx9uu8DeuSONElf79nAqLJcydp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323692; c=relaxed/simple;
	bh=+79/0xX5KH78l+UtfDR+yxcteyqNOxPjc2y1k4kqT3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipkh+eLe6rcGQH3flX9jDCoZqXOGkdJL7uHe8ft4K15uDaJ3nzipzQERbsGjuh7MOVwNanwDbO/6qoyckIkW7Yhfk9402btjkuMSSS+n73vyOweyfOXU+MmInldcpKpFD7iu5gvXebIf8epCuqYQ3kyUKpjhAcGo16ubbvG+mNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R1TtGlOq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2tpTe025178;
	Fri, 10 May 2024 06:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=WOXCShSy/h3E2fFg04vIkPM4vk3ebhYHa6SlDGS/kOY=; b=R1
	TtGlOqZYXZkQZ4xWXAwKZ9XOQvhdOyhAo73lyzv6RGwQmuOQRC03szJFeRKyYxyr
	V3gGOIDhWvAy8k/JJWPZ25zqmlMcCArc28JFrm89+czqrNZ+6w6GVwS2El7ms4nA
	sSr1M+WktB7w/EN80dj85HpgnhoJ2r6EPnwPKTwDcQd3fLQQmyF7f4A1x2bCXMp5
	u9ghmIV7iS+1uorORDbKPiYaxXBrCTVNUJsIVdYCuGs4ylCe+9IP+SE8GYKDG4/I
	2XouxD78kCAh5FCcA5Z36qJZPdtQASQeMJ69nZYOCcSqUV0eZC/cYuKk2VFhHsS6
	UjOqaxMkgnGH8pKJK1dg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w28sfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 06:48:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A6m5bf004640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 06:48:05 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 May 2024 23:48:04 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 4/7] wifi: ath12k: implement hardware data filter
Date: Fri, 10 May 2024 14:47:45 +0800
Message-ID: <20240510064748.369452-5-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510064748.369452-1-quic_bqiang@quicinc.com>
References: <20240510064748.369452-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p2hYX0qjoxkEHacOXWzIiv39BfuAVkW6
X-Proofpoint-ORIG-GUID: p2hYX0qjoxkEHacOXWzIiv39BfuAVkW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=961
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100046

Host needs to set hardware data filter before entering WoW to
let firmware drop needless broadcast/multicast frames to avoid
frequent wakeup. Host clears hardware data filter when leaving WoW.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 31 +++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 21 +++++++++
 drivers/net/wireless/ath/ath12k/wow.c | 66 +++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index f337f2197578..b59949cc1a93 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -7392,6 +7392,37 @@ void ath12k_wmi_detach(struct ath12k_base *ab)
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
index 3d01562a43f6..96460116c072 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -5263,6 +5263,25 @@ struct wmi_wow_nlo_config_cmd {
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
@@ -5426,4 +5445,6 @@ int ath12k_wmi_wow_add_wakeup_event(struct ath12k *ar, u32 vdev_id,
 				    u32 enable);
 int ath12k_wmi_wow_config_pno(struct ath12k *ar, u32 vdev_id,
 			      struct wmi_pno_scan_req_arg  *pno_scan);
+int ath12k_wmi_hw_data_filter_cmd(struct ath12k *ar,
+				  struct wmi_hw_data_filter_arg *arg);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
index 6b61f5da7933..968bd884687f 100644
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


