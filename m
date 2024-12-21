Return-Path: <linux-wireless+bounces-16676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E469F9E44
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 05:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579E27A2EFF
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 04:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69611DF25A;
	Sat, 21 Dec 2024 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MGrESmbe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE371E9B0C
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734755489; cv=none; b=nI++4tbl1dMo2C2uY514PG+thyoOYN4QkIBsknNBWRxcL2vXQlDtcceqk2jcAtr0KFFUEYfqlyGywcHtLYCM4Zn/sP1Vs8dVbAiUHyU7o4duR4uRfzcK6l0XMMoYqYo7ZKFIS/9FR7GCNawmVXGFEFiIoYAYsSZdrXltpktEdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734755489; c=relaxed/simple;
	bh=7C9cDEkkXCHdRluIbg+1BXMeagM8ffkr5hdl0tmqyto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTxCpsmQ2fnZge+VK+aykX3x3xeDzIc3W12lXo6uUc5qGpMA5HFLxHE2w8Hjw0QJVE1GAo//GEUxpqnqk1XmatWWzIT5wBoPROl/GEe9BQYNJ3lCXu3P8hWA1X1meRF7j1J0nm3e+Vu+FocF+GFKbc9Tbblw9WgKZBJJ9hgor98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MGrESmbe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL0gipv008108;
	Sat, 21 Dec 2024 04:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dccjv2Y3itawRQQPxPPPGJMQ2p6nAnYcz5vTo87rU9k=; b=MGrESmbeVg/59648
	VJtOxZ3DPIbke5devhK+FrMQp/cbV4AzN5XdTv5+VIB6OAfCh0sKiRpn2Vl3RvZf
	wujfziDi9X6OGUuECBWm7gd9rbp9p5aF/iqcbZjw72REr4TfN3xt54eE4KdnG9lf
	HvF6wKek157GGS24pYYFUPLSksWZTOoXmiQ79SCHCJFQ66FJYGwFpqGpYpHG1Qt0
	w/OvCjyNMDMYNi33Y/4wqPsZvPdKg4yo4+vxdpk8F1eGy3PmfNPipFWq6nXr0tTI
	db4DWxDabv61s0gwb1YRBsm4AGTJSj0Os1IPqM8uoExDhY30KBTobjHjda0NVd+j
	qvS8OQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43nkcc8cf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:31:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BL4VPTC013451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:31:25 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 20:31:23 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 09/14] wifi: ath12k: Handle end reason for the monitor destination ring
Date: Sat, 21 Dec 2024 10:00:09 +0530
Message-ID: <20241221043014.1252841-10-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
References: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
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
X-Proofpoint-ORIG-GUID: meV-FdoBCMmHbe1cQO17uHAsmZLa-WbM
X-Proofpoint-GUID: meV-FdoBCMmHbe1cQO17uHAsmZLa-WbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=897 priorityscore=1501
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210035

Currently, the monitor destination ring's descriptor includes a 2-bit
field for the end reason. Out of all the end reason values, hardware uses
HAL_MON_FLUSH_DETECTED and HAL_MON_PPDU_TRUNCATED to indicate buffers that
should not be processed due to system level errors. Driver should not
process entries with these end reasons, as they contain junk values.
However, the current code lacks end reason-specific checks for the monitor
destination ring, leading to the processing of invalid buffers.
Fix this by adding checks for these two end reasons during the reaping
phase. Free the skb if either HAL_MON_FLUSH_DETECTED or
HAL_MON_PPDU_TRUNCATED is detected, preventing the driver from processing
invalid entries.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c   | 17 ++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_desc.h |  3 +--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index bf43ef2b6b39..dbf5afd88ad5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2329,7 +2329,7 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	struct sk_buff_head skb_list;
 	u64 cookie;
 	int num_buffs_reaped = 0, srng_id, buf_id;
-	u32 hal_status, end_offset, info0;
+	u32 hal_status, end_offset, info0, end_reason;
 	u8 pdev_idx = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, ar->pdev_idx);
 
 	__skb_queue_head_init(&skb_list);
@@ -2373,6 +2373,21 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 				 skb->len + skb_tailroom(skb),
 				 DMA_FROM_DEVICE);
 
+		end_reason = u32_get_bits(info0, HAL_MON_DEST_INFO0_END_REASON);
+
+		/* HAL_MON_FLUSH_DETECTED implies that an rx flush received at the end of
+		 * rx PPDU and HAL_MON_PPDU_TRUNCATED implies that the PPDU got
+		 * truncated due to a system level error. In both the cases, buffer data
+		 * can be discarded
+		 */
+		if ((end_reason == HAL_MON_FLUSH_DETECTED) ||
+		    (end_reason == HAL_MON_PPDU_TRUNCATED)) {
+			ath12k_dbg(ab, ATH12K_DBG_DATA,
+				   "Monitor dest descriptor end reason %d", end_reason);
+			dev_kfree_skb_any(skb);
+			goto move_next;
+		}
+
 		end_offset = u32_get_bits(info0, HAL_MON_DEST_INFO0_END_OFFSET);
 		if (likely(end_offset <= DP_RX_BUFFER_SIZE)) {
 			skb_put(skb, end_offset);
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index a102d27e5785..3e8983b85de8 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -2969,8 +2969,7 @@ struct hal_mon_buf_ring {
 #define HAL_MON_DEST_COOKIE_BUF_ID      GENMASK(17, 0)
 
 #define HAL_MON_DEST_INFO0_END_OFFSET		GENMASK(11, 0)
-#define HAL_MON_DEST_INFO0_FLUSH_DETECTED	BIT(16)
-#define HAL_MON_DEST_INFO0_END_OF_PPDU		BIT(17)
+#define HAL_MON_DEST_INFO0_END_REASON		GENMASK(17, 16)
 #define HAL_MON_DEST_INFO0_INITIATOR		BIT(18)
 #define HAL_MON_DEST_INFO0_EMPTY_DESC		BIT(19)
 #define HAL_MON_DEST_INFO0_RING_ID		GENMASK(27, 20)
-- 
2.34.1


