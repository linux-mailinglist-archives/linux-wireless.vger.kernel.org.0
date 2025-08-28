Return-Path: <linux-wireless+bounces-26831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F647B3A852
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0B31BA5DB1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F1338F22;
	Thu, 28 Aug 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P8yHxVMN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E67341AC3
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402607; cv=none; b=LdKq9CH7JDVtyqTy+/mdHQ6xGb+2uNprWiBlboq5UtquGS3gQGRNJ8PljBD5y8n4YXCeFzTyDTzHjCRNUtIccSDCslwJopcTw2eDG8XRyQqWe13Hg1DgxJQb9y/6rTzYDKpINYlVLz/cjqfMKNPMcgoMS/i75RFCEUauwOjKMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402607; c=relaxed/simple;
	bh=opI6JTY+sJc/khml81O6k6mLxniu2k8inzG//G/q6Ro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNjkEBcj03TlURPYTHVqhLiqBidPEhmdRQex1ik6TN1QgzUO6oo//nqENBMIg9oWYWPH8HAzsLc0t+BrabkTitfFKzLgG8qkYezYZQknSjyT4ONpXH3yGU92ymPKS5MZSuhNw1Bx1p/yTl7VW+Kw0LXLvpFnZyL2GXgb8nB0EIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P8yHxVMN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAE6Cw007255;
	Thu, 28 Aug 2025 17:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SEh0ICVJiF553mOHqN8i1M4Oxb/v9J4HYMLs5wY5Tic=; b=P8yHxVMNMEoNR75z
	dUupBNh2dXNC5m7VQM2Y5nTl6h/EJsPEOo4I/8/pCqI1c37mRLoK3RqvVu8HDLT+
	rHm1ApgW8yXrcPSQkEDS1HErsGWpNJ2r1meDctF3pOfT9B1odyRDj6nRg/i/kF+5
	i3BJmT1MV6CSmuY3KS32TjPQrz8O5PLcE+QFud0iC06zEfoxIoP9RG3/IRi4QlgE
	MguHDL61InGnvrYl4uW/ltq3MJMEezqzcTGgyKJmoyxG4OqD8zOPP2Ovzkkzjg9j
	wU2t8VHgHSnPhBjmsLanG86ARIy0sbNP+KCuYvpq31z/COh8kQ+MIbAisfq2Sfua
	ieS7fA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67h9hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaeJj019806
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:40 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:39 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 20/20] wifi: ath12k: Move HTT specific code from dp.c to newly introduced files
Date: Thu, 28 Aug 2025 23:05:53 +0530
Message-ID: <20250828173553.3341351-21-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfXwDChspDqwpEy
 lqRhEdjwkdhcRPIMeKWP+AEektYVfyDjlQ7qMOHYfgiF8JxPGMx/YbujDAhaaoxBcf/QuF2pLrA
 toxabUjPjDZnvMu+08eDRWuHUhSCo/WJympVwYo8AvhpVyc/eQbJqwv3yEA5AJKQ5lgxTO90y+u
 /v1aNPNh4I8LRhIOQU+kSctH36eVkspOiUoUmZh9T3i1DoHj/X8Ittnt0mGxhd91pmF2qtMxaXt
 tOmZIAabOqKhjPrHldh9Bka3YAKSQMipxC0msKGXjk8sOAWkULmObroebGYKBvCFzpx0H7L0LDi
 /a2rXzl+eDtPqcI1YKcovJiWLfObyadvpf/wujWbX/FS5qch0tknIDNHXn6l1e2QWE3PfCExKtE
 nsktwLFh
X-Proofpoint-GUID: Spcc2L0IOAUYKGTBvNsHXkdSy3CnL1To
X-Proofpoint-ORIG-GUID: Spcc2L0IOAUYKGTBvNsHXkdSy3CnL1To
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b093a9 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=KFaOQ6OXsHnzEyzz7ZwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

WLAN Host driver interacts with the Firmware and vice versa using
Host-To-Target (HTT) interface.

Relocate HTT specific code from dp.c to newly introduced file dp_htt.c
for HTT interface.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c     | 29 ----------------------
 drivers/net/wireless/ath/ath12k/dp.h     |  1 -
 drivers/net/wireless/ath/ath12k/dp_htt.c | 31 ++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/dp_htt.h |  3 +++
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index d0bdf058633f..8909415df2e2 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -19,12 +19,6 @@ enum ath12k_dp_desc_type {
 	ATH12K_DP_RX_DESC,
 };
 
-static void ath12k_dp_htt_htc_tx_complete(struct ath12k_base *ab,
-					  struct sk_buff *skb)
-{
-	dev_kfree_skb_any(skb);
-}
-
 void ath12k_dp_peer_cleanup(struct ath12k *ar, int vdev_id, const u8 *addr)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -957,29 +951,6 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
 	return ret;
 }
 
-int ath12k_dp_htt_connect(struct ath12k_dp *dp)
-{
-	struct ath12k_htc_svc_conn_req conn_req = {};
-	struct ath12k_htc_svc_conn_resp conn_resp = {};
-	int status;
-
-	conn_req.ep_ops.ep_tx_complete = ath12k_dp_htt_htc_tx_complete;
-	conn_req.ep_ops.ep_rx_complete = ath12k_dp_htt_htc_t2h_msg_handler;
-
-	/* connect to control service */
-	conn_req.service_id = ATH12K_HTC_SVC_ID_HTT_DATA_MSG;
-
-	status = ath12k_htc_connect_service(&dp->ab->htc, &conn_req,
-					    &conn_resp);
-
-	if (status)
-		return status;
-
-	dp->eid = conn_resp.eid;
-
-	return 0;
-}
-
 static void ath12k_dp_update_vdev_search(struct ath12k_link_vif *arvif)
 {
 	switch (arvif->ahvif->vdev_type) {
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index ad93e63e3344..18a3287945b7 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -432,7 +432,6 @@ static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
 	memcpy(addr + 4, &addr_h16, ETH_ALEN - 4);
 }
 
-int ath12k_dp_htt_connect(struct ath12k_dp *dp);
 void ath12k_dp_vdev_tx_attach(struct ath12k *ar, struct ath12k_link_vif *arvif);
 void ath12k_dp_free(struct ath12k_base *ab);
 int ath12k_dp_alloc(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
index 45aa8ae86a14..6ab5b2d8aac9 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.c
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -11,6 +11,35 @@
 #include "debugfs_htt_stats.h"
 #include "debugfs.h"
 
+static void ath12k_dp_htt_htc_tx_complete(struct ath12k_base *ab,
+					  struct sk_buff *skb)
+{
+	dev_kfree_skb_any(skb);
+}
+
+int ath12k_dp_htt_connect(struct ath12k_dp *dp)
+{
+	struct ath12k_htc_svc_conn_req conn_req = {};
+	struct ath12k_htc_svc_conn_resp conn_resp = {};
+	int status;
+
+	conn_req.ep_ops.ep_tx_complete = ath12k_dp_htt_htc_tx_complete;
+	conn_req.ep_ops.ep_rx_complete = ath12k_dp_htt_htc_t2h_msg_handler;
+
+	/* connect to control service */
+	conn_req.service_id = ATH12K_HTC_SVC_ID_HTT_DATA_MSG;
+
+	status = ath12k_htc_connect_service(&dp->ab->htc, &conn_req,
+					    &conn_resp);
+
+	if (status)
+		return status;
+
+	dp->eid = conn_resp.eid;
+
+	return 0;
+}
+
 static int ath12k_get_ppdu_user_index(struct htt_ppdu_stats *ppdu_stats,
 				      u16 peer_id)
 {
@@ -818,8 +847,6 @@ int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
 	return ret;
 }
 
-#define HTT_TARGET_VERSION_TIMEOUT_HZ (3 * HZ)
-
 int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.h b/drivers/net/wireless/ath/ath12k/dp_htt.h
index b13af1c69253..6020e632f74e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.h
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.h
@@ -36,6 +36,8 @@ struct ath12k_dp;
 
 #define HTT_TX_WBM_COMP_INFO2_ACK_RSSI		GENMASK(31, 24)
 
+#define HTT_TARGET_VERSION_TIMEOUT_HZ (3 * HZ)
+
 struct htt_tx_wbm_completion {
 	__le32 rsvd0[2];
 	__le32 info0;
@@ -1514,6 +1516,7 @@ struct htt_mac_addr {
 	__le32 mac_addr_h16;
 } __packed;
 
+int ath12k_dp_htt_connect(struct ath12k_dp *dp);
 int ath12k_dp_tx_htt_srng_setup(struct ath12k_base *ab, u32 ring_id,
 				int mac_id, enum hal_ring_type ring_type);
 
-- 
2.34.1


