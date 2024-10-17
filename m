Return-Path: <linux-wireless+bounces-14117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFA49A1926
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 05:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931461F21771
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 03:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFAB12C484;
	Thu, 17 Oct 2024 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FELZes6/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6D42040
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134624; cv=none; b=N2Us1N9XsnkG3WZAcLwwDRXO/WUAxVx7QXhNIjKV3J4cHMXhjhD90pP7YD9ZNSC1aGVZhzZGZrqHuwGXbrZZHvd/sPQq4IDsMuzCVnns3QGf8MQbE1fhMTjY7KWlxubG6fYBJr2BYGQmhwV5/wh20Wcmom43YPEPSBp3NSZftF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134624; c=relaxed/simple;
	bh=p9cJrFoqitIgS24GXieYmbGn+cE/VGKqztK6yhgO1JU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqws7mnj1zczqodJMCHID762urTUZXE41AnYlxejVBdkJQsn2zooxQNwbDWlAnyQ8zp/VDOashcfIxDHgOrGSFmjctxYLeZzuIzXezZMB5ls23mIRzLMRbe5ETqW9bLkNruYjImGFTFcAUqCaNCDouZJaUbdpiZ83PNhN5vWOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FELZes6/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GG4557027254;
	Thu, 17 Oct 2024 03:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fydkGc78WyYO1/+0gSW16TF3eFcWVtdjI+5T0CYws7Q=; b=FELZes6/NTeygiaO
	zuoxj5cNM9WDjsylKA5fz9X3PLElf+ABl+qVhb2FuD3epdfeZwAY9YIIviGzkcW9
	qyYUi2HX3MFr4H2D0+U4PAV4shV21g1o+iyW5nRJVDgM4+OY2Sa1J+nyV+Y+5Hb2
	RQe+9nIfgVMukBgAVme5cbBZJ97Qc+BTO8vChwapAqWZtylDlj0CVwpUZUGVpP/p
	wNZc563N2fAXusuy3N6rLxqWLzj4Bomo53Nyrv6G0wl34lPmHWV2rstULeXcwuf9
	kEi62hpfLuoMFH3zdNn4ZOVC+DEHEVvCwuT77o0maC2ssPxWLE0VfXg814aeZOOu
	2zhrtg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8w6k5gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:10:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H3AF1S019613
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:10:15 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 20:10:13 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 1/4] wifi: ath12k: add configure country code for WCN7850
Date: Thu, 17 Oct 2024 11:09:24 +0800
Message-ID: <20241017030927.1695-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241017030927.1695-1-quic_kangyang@quicinc.com>
References: <20241017030927.1695-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: VDqtTWmsxbpPy5_Kc-GBCb58P4RFx6ue
X-Proofpoint-ORIG-GUID: VDqtTWmsxbpPy5_Kc-GBCb58P4RFx6ue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170021

From: Wen Gong <quic_wgong@quicinc.com>

Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware, which
is used for WCN7850 to update country code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 36 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h | 13 ++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index dced2aa9ba1a..28f0428fb172 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3084,6 +3084,42 @@ int ath12k_wmi_send_init_country_cmd(struct ath12k *ar,
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
index 6f55dbdf629d..220f530da569 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3945,6 +3945,16 @@ struct ath12k_wmi_eht_rate_set_params {
 #define MAX_6G_REG_RULES 5
 #define REG_US_5G_NUM_REG_RULES 4
 
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
@@ -5547,6 +5557,9 @@ int ath12k_wmi_send_bcn_offload_control_cmd(struct ath12k *ar,
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


