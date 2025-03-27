Return-Path: <linux-wireless+bounces-20873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9246A72886
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 02:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF39189AD16
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 01:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051F3A1DB;
	Thu, 27 Mar 2025 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oYQ71hLl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2334D450F2
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 01:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040580; cv=none; b=g+M0C2LFYjmQQQeNloJbNDY37mZ9rkngkWlXnKS0SHOGZ/1R6CvXt8p549JurPrqljDhwcxIxVI6wDz4juKWnO1qalRTS5BZZc9lGONC6Xgc4IMBHhu00dtNWmt0udDPXWJsoNVOMy+G/EDeHaEavmpwWbXX/lmn+YwQto6ToPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040580; c=relaxed/simple;
	bh=1VwEoDT+I5KkGDudMWQcpydDUMrBMYlhYPfyaAmcWxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KehafzW0tVHRzIVhiI51wUl92MDr/EPmHRwf0aDkHJLe7NfMR4Pf20vGH2bBM0yxaiaoAPGMpFKwOBn1+gYOpPTFvqiEj2/v5fulryrj3kryaFYys8ZEvqusTAVLLl1i/RTz/pFUlouRr5W4NfpPWrAr8MEtEXlexeKDPEurfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oYQ71hLl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QGA2Qc012104;
	Thu, 27 Mar 2025 01:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3uvI1bm2Ie6UoM19tKVGVCz49oDY61WJTbUbX5+2Asw=; b=oYQ71hLlRss9HiRR
	M3hepbuyrUq9js1DsCNPO9FxXmnGZCqdG7axnxaxQ1A/yRZXG/rLY7YeClvC6SHU
	gQSV5tyeO97tib3LwdzF4wd/Wy/9PYrgNKv2JniMsj0baNF2B4HUicrqnF1EA8KR
	SAdc+eIdCl1f/ksT09fhHQA8yEMlDV+/lWc5wWJgFnM9vFyLDMMFYkfALzMeaDYi
	Bz7VfSC0KjgnKC5noQCC925CEdCfjtLArUncrL/2NX+P11AJGCx5M6PnoD671I2M
	Dv5sQr5H6j2EFHUGgt45NdZK/WcaZrmxwp6X8jWNdzxSZb/J46Qde0BXVTExfR4W
	sV/70g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mmuthbd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 01:56:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R1uFGs004260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 01:56:15 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Mar 2025 18:56:14 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>, <quic_kangyang@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v13 1/4] wifi: ath12k: add configure country code for WCN7850
Date: Thu, 27 Mar 2025 09:55:42 +0800
Message-ID: <20250327015546.1501-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250327015546.1501-1-quic_kangyang@quicinc.com>
References: <20250327015546.1501-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zAlaTQx8kJoQjFHxs1sB65Nh6Folx3r1
X-Authority-Analysis: v=2.4 cv=MqlS63ae c=1 sm=1 tr=0 ts=67e4b03f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=dteaqZCelaTq9PlF0Q8A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zAlaTQx8kJoQjFHxs1sB65Nh6Folx3r1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270012

From: Wen Gong <quic_wgong@quicinc.com>

Currently, WMI_SET_INIT_COUNTRY_CMDID is used to set country code for
WCN7850 and QCN9274.

But WMI_SET_INIT_COUNTRY_CMDID is not the correct command for WCN7850.

Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware, which
is used for WCN7850 to update country code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 13 ++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 04dd307ebfc4..c9022ecbade4 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3332,6 +3332,42 @@ int ath12k_wmi_send_init_country_cmd(struct ath12k *ar,
 	return ret;
 }
 
+int ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
+					    struct wmi_set_current_country_arg *arg)
+{
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_set_current_country_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_set_current_country_cmd *)skb->data;
+	cmd->tlv_header =
+		ath12k_wmi_tlv_cmd_hdr(WMI_TAG_SET_CURRENT_COUNTRY_CMD,
+				       sizeof(*cmd));
+
+	cmd->pdev_id = cpu_to_le32(ar->pdev->pdev_id);
+	memcpy(&cmd->new_alpha2, &arg->alpha2, sizeof(arg->alpha2));
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_SET_CURRENT_COUNTRY_CMDID);
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "set current country pdev id %d alpha2 %c%c\n",
+		   ar->pdev->pdev_id,
+		   arg->alpha2[0],
+		   arg->alpha2[1]);
+
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to send WMI_SET_CURRENT_COUNTRY_CMDID: %d\n", ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int
 ath12k_wmi_send_twt_enable_cmd(struct ath12k *ar, u32 pdev_id)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 1ba33e30ddd2..8a8504ccdc02 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4110,6 +4110,16 @@ struct ath12k_wmi_eht_rate_set_params {
 #define REG_ALPHA2_LEN 2
 #define MAX_6G_REG_RULES 5
 
+struct wmi_set_current_country_arg {
+	u8 alpha2[REG_ALPHA2_LEN];
+};
+
+struct wmi_set_current_country_cmd {
+	__le32 tlv_header;
+	__le32 pdev_id;
+	__le32 new_alpha2;
+} __packed;
+
 enum wmi_start_event_param {
 	WMI_VDEV_START_RESP_EVENT = 0,
 	WMI_VDEV_RESTART_RESP_EVENT,
@@ -5990,6 +6000,9 @@ int ath12k_wmi_send_bcn_offload_control_cmd(struct ath12k *ar,
 					    u32 vdev_id, u32 bcn_ctrl_op);
 int ath12k_wmi_send_init_country_cmd(struct ath12k *ar,
 				     struct ath12k_wmi_init_country_arg *arg);
+int
+ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
+					struct wmi_set_current_country_arg *arg);
 int ath12k_wmi_peer_rx_reorder_queue_setup(struct ath12k *ar,
 					   int vdev_id, const u8 *addr,
 					   dma_addr_t paddr, u8 tid,
-- 
2.34.1


