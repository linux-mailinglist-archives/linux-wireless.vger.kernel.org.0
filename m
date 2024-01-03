Return-Path: <linux-wireless+bounces-1423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F4822807
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 06:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDE81F23B33
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 05:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746261805A;
	Wed,  3 Jan 2024 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gb8Yn1Ex"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753A18041
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 05:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4034EbZ0020196;
	Wed, 3 Jan 2024 05:10:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=DQvc60BFqAFYMeUfTNr14pHYGe58JY3kOrro6lYItl4=; b=Gb
	8Yn1Ex0HfV5YBe4KE02gNeV0ZWpxUJCCc9ZySiCB8gDsietsbq3uUCRPqpWBPdys
	B5AvH63JNwFoA+kpAz8qXiMr3Q/9jTlnTZt2bdS7BRyArTfDRnepF2No5OgIDuQW
	q1k2I3zvFr7I79XS01fwK5OTtI+1pCX+CXKzoBQJelCy1mx2XwZ2Zu9vEnRE96mh
	MvSy9K7JW1Yzl75dfyK/kHF5lnrHQmukdzmlNTGybYsHdopSQFqVJX7C0TBDgGhP
	yv2oZACJ0f/sByJg17bAXAt6QZWc63i1V5ciDol62JkhtKwS3MeMUOL59vJ7gwo5
	/X6dTu8i5EA6p1ktKEKg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd0ckr4wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 05:10:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4035ASiA029651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 05:10:28 GMT
Received: from lingbok-Latitude-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jan 2024 21:10:27 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: ath12k: add processing for TWT disable event
Date: Wed, 3 Jan 2024 00:09:26 -0500
Message-ID: <20240103050926.14115-3-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103050926.14115-1-quic_lingbok@quicinc.com>
References: <20240103050926.14115-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RlJG2YrTVYqyBxq698lupdHVLcbJaHV_
X-Proofpoint-ORIG-GUID: RlJG2YrTVYqyBxq698lupdHVLcbJaHV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=904
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401030039

When ath12k send TWT disable command to firmware, firmware will return a
TWT disable event to ath12k. Through the analysis of TWT disable event
status, we can easily obtain the status of TWT disable command. It can be
more convenient to debug TWT.

This patch works with WCN7850 and QCN9274.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 35 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h |  5 ++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 3873a04a6ae1..719c7f22a2ee 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -164,6 +164,8 @@ static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
 	[WMI_TAG_TWT_ENABLE_COMPLETE_EVENT] = {
 		.min_len = sizeof(struct wmi_twt_enable_event) },
+	[WMI_TAG_TWT_DISABLE_COMPLETE_EVENT] = {
+		.min_len = sizeof(struct wmi_twt_disable_event) },
 };
 
 static __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
@@ -6693,6 +6695,35 @@ static void ath12k_wmi_twt_enable_event(struct ath12k_base *ab,
 	kfree(tb);
 }
 
+static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
+					 struct sk_buff *skb)
+{
+	const void **tb;
+	const struct wmi_twt_disable_event *ev;
+	int ret;
+
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath12k_warn(ab, "failed to parse wmi twt disable status event tlv: %d\n",
+			    ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_TWT_DISABLE_COMPLETE_EVENT];
+	if (!ev) {
+		ath12k_warn(ab, "failed to fetch twt disable wmi event\n");
+		goto exit;
+	}
+
+	ath12k_dbg(ab, ATH12K_DBG_MAC, "wmi twt disable event pdev id %d status %u\n",
+		   le32_to_cpu(ev->pdev_id),
+		   le32_to_cpu(ev->status));
+
+exit:
+	kfree(tb);
+}
+
 static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -6791,10 +6822,12 @@ static void ath12k_wmi_op_rx(struct ath12k_base *ab, struct sk_buff *skb)
 	case WMI_TWT_ENABLE_EVENTID:
 		ath12k_wmi_twt_enable_event(ab, skb);
 		break;
+	case WMI_TWT_DISABLE_EVENTID:
+		ath12k_wmi_twt_disable_event(ab, skb);
+		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
-	case WMI_TWT_DISABLE_EVENTID:
 	case WMI_PDEV_DMA_RING_CFG_RSP_EVENTID:
 		ath12k_dbg(ab, ATH12K_DBG_WMI,
 			   "ignoring unsupported event 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 3546d19a04b6..32bb420a568f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4802,6 +4802,11 @@ struct wmi_twt_enable_event {
 	__le32 status;
 } __packed;
 
+struct wmi_twt_disable_event {
+	__le32 pdev_id;
+	__le32 status;
+} __packed;
+
 void ath12k_wmi_init_qcn9274(struct ath12k_base *ab,
 			     struct ath12k_wmi_resource_config_arg *config);
 void ath12k_wmi_init_wcn7850(struct ath12k_base *ab,
-- 
2.34.1


