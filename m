Return-Path: <linux-wireless+bounces-13937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC699C114
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 09:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F502830F3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 07:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DFA1482E5;
	Mon, 14 Oct 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OEZnqKMb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22F147C9B
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890266; cv=none; b=nfBrCoc/US0K4oy5ENeOTaV2s9KlPsKVZqSWW7V7BFDE9goaUIhrjRUJk4rmwcGREW6jiNG8v4tMdo/Ln73Sys4H3+roDFoXBjMYPoz3RpJF2ttcERhgetXyrzEMxkthfW1OZ2RpaZWuovSze7BeD5/LtYaKGWJZgmkCA1MzQh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890266; c=relaxed/simple;
	bh=CuideroGMCme1evanfr9RS47eGI9CWu6y8ONaSRtKAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmQ2tGqkWENsfcNghxazeozWP44fMokQ7cj9cavowLUh3EWXMRH+IGvoRYFiod7LoYrgKu666Z783RhuxIz5NmWAWnEo10djw30AiOy+3aGj5lPt8Kxtmoa/c2ryuFm7j0S+JQJ4oM4fWfow9BGnEtpheUiSJCKy0GV4kQx1dRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OEZnqKMb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49DNwCvp015497;
	Mon, 14 Oct 2024 07:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aecd1krOMX6DvmWMaziL4S4/kvUar6QbQsw0t8JQ0dY=; b=OEZnqKMb59tCpjeJ
	13RPYbBfI4DdTwlnRIJ1u17qlDIAapIRaK1zI0qREFfYPc+5fh8bERvBvAoBKlYl
	GEq3kK+ffC34z0tjX9HrKW2wr/8iMsZ6NA8srOMoAoaCDNP7HBKCIZL4anUggsUw
	kfN91bdyryIORE+oEZ0KF6VfzrAA5wzQTQyZl4L+ZmjhJclc/igjBr0JpTB7QPH0
	g5ZqTC9YFQrz/3mI9In2p1z0fG/oG983umU4IZ7wOp3XxLxW4RDoVaREQSLOZRy6
	RkTFnGrCIYBA7O7uw74OQmipru6l+htygoU1Mm1psNWGpcWS3X6Exbz+IbZoCb/2
	2Y5Oqw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427hvfugvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:17:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49E7Hdin010162
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 07:17:39 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Oct 2024 00:17:37 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>
Subject: [PATCH v3 1/2] wifi: ath12k: Support AST Entry Stats
Date: Mon, 14 Oct 2024 12:47:19 +0530
Message-ID: <20241014071720.3991199-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014071720.3991199-1-quic_rdevanat@quicinc.com>
References: <20241014071720.3991199-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0X7kK60w3oPdRnLKk19U3dYYTUUDmBWv
X-Proofpoint-ORIG-GUID: 0X7kK60w3oPdRnLKk19U3dYYTUUDmBWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140052

Add support to request Address Search Table(AST) entries stats
from firmware through HTT stats type 41. These stats give AST entries
related information such as software peer id, MAC address, pdev id,
vdev, id, next hop, etc.

Sample output:
-------------
echo 41 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_AST_ENTRY_TLV:
ast_index = 10
mac_addr = 00:00:00:01:00:00
sw_peer_id = 0
pdev_id = 3
vdev_id = 255
next_hop = 0
mcast = 0
monitor_direct = 0
mesh_sta = 0
mec = 0
intra_bss = 0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 56 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 18 ++++++
 drivers/net/wireless/ath/ath12k/dp.h          | 12 ++++
 3 files changed, 86 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 799b865b89e5..60f0260550bb 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2542,6 +2542,59 @@ ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_ast_entry_tlv(const void *tag_buf, u16 tag_len,
+			       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_ast_entry_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_addr_l32;
+	u32 mac_addr_h16;
+	u32 ast_info;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_addr_l32 = le32_to_cpu(htt_stats_buf->mac_addr.mac_addr_l32);
+	mac_addr_h16 = le32_to_cpu(htt_stats_buf->mac_addr.mac_addr_h16);
+	ast_info = le32_to_cpu(htt_stats_buf->info);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_AST_ENTRY_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ast_index = %u\n",
+			 le32_to_cpu(htt_stats_buf->ast_index));
+	len += scnprintf(buf + len, buf_len - len,
+			 "mac_addr = %02x:%02x:%02x:%02x:%02x:%02x\n",
+			 u32_get_bits(mac_addr_l32, ATH12K_HTT_MAC_ADDR_L32_0),
+			 u32_get_bits(mac_addr_l32, ATH12K_HTT_MAC_ADDR_L32_1),
+			 u32_get_bits(mac_addr_l32, ATH12K_HTT_MAC_ADDR_L32_2),
+			 u32_get_bits(mac_addr_l32, ATH12K_HTT_MAC_ADDR_L32_3),
+			 u32_get_bits(mac_addr_h16, ATH12K_HTT_MAC_ADDR_H16_0),
+			 u32_get_bits(mac_addr_h16, ATH12K_HTT_MAC_ADDR_H16_1));
+
+	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
+			 le32_to_cpu(htt_stats_buf->sw_peer_id));
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 u32_get_bits(ast_info, ATH12K_HTT_AST_PDEV_ID_INFO));
+	len += scnprintf(buf + len, buf_len - len, "vdev_id = %u\n",
+			 u32_get_bits(ast_info, ATH12K_HTT_AST_VDEV_ID_INFO));
+	len += scnprintf(buf + len, buf_len - len, "next_hop = %u\n",
+			 u32_get_bits(ast_info, ATH12K_HTT_AST_NEXT_HOP_INFO));
+	len += scnprintf(buf + len, buf_len - len, "mcast = %u\n",
+			 u32_get_bits(ast_info, ATH12K_HTT_AST_MCAST_INFO));
+	len += scnprintf(buf + len, buf_len - len, "monitor_direct = %u\n",
+			 u32_get_bits(ast_info, ATH12K_HTT_AST_MONITOR_DIRECT_INFO));
+	len += scnprintf(buf + len, buf_len - len, "mesh_sta = %u\n",
+			 u32_get_bits(ast_info, ATH12K_HTT_AST_MESH_STA_INFO));
+	len += scnprintf(buf + len, buf_len - len, "mec = %u\n",
+			 u32_get_bits(ast_info, ATH12K_HTT_AST_MEC_INFO));
+	len += scnprintf(buf + len, buf_len - len, "intra_bss = %u\n\n",
+			 u32_get_bits(ast_info, ATH12K_HTT_AST_INTRA_BSS_INFO));
+
+	stats_req->buf_len = len;
+}
+
 static u64 ath12k_le32hilo_to_u64(__le32 hi, __le32 lo)
 {
 	u64 hi64 = le32_to_cpu(hi);
@@ -2877,6 +2930,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_OBSS_PD_TAG:
 		ath12k_htt_print_pdev_obss_pd_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_AST_ENTRY_TAG:
+		ath12k_htt_print_ast_entry_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_DMAC_RESET_STATS_TAG:
 		ath12k_htt_print_dmac_reset_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index ac86cab234ec..6978c3243ee3 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -135,6 +135,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
+	ATH12K_DBG_HTT_EXT_AST_ENTRIES			= 41,
 	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
 	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
@@ -196,6 +197,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SELFGEN_AX_SCHED_STATUS_STATS_TAG	= 112,
 	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
 	HTT_STATS_TX_PDEV_MUMIMO_GRP_STATS_TAG		= 130,
+	HTT_STATS_AST_ENTRY_TAG				= 132,
 	HTT_STATS_TX_PDEV_RATE_STATS_BE_OFDMA_TAG	= 135,
 	HTT_STATS_TX_SELFGEN_BE_ERR_STATS_TAG		= 137,
 	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
@@ -1122,4 +1124,20 @@ struct ath12k_htt_tx_pdev_rate_stats_be_ofdma_tlv {
 	__le32 be_ofdma_eht_sig_mcs[ATH12K_HTT_TX_PDEV_NUM_EHT_SIG_MCS_CNTRS];
 } __packed;
 
+#define ATH12K_HTT_AST_PDEV_ID_INFO		GENMASK(1, 0)
+#define ATH12K_HTT_AST_VDEV_ID_INFO		GENMASK(9, 2)
+#define ATH12K_HTT_AST_NEXT_HOP_INFO		BIT(10)
+#define ATH12K_HTT_AST_MCAST_INFO		BIT(11)
+#define ATH12K_HTT_AST_MONITOR_DIRECT_INFO	BIT(12)
+#define ATH12K_HTT_AST_MESH_STA_INFO		BIT(13)
+#define ATH12K_HTT_AST_MEC_INFO			BIT(14)
+#define ATH12K_HTT_AST_INTRA_BSS_INFO		BIT(15)
+
+struct ath12k_htt_ast_entry_tlv {
+	__le32 sw_peer_id;
+	__le32 ast_index;
+	struct htt_mac_addr mac_addr;
+	__le32 info;
+} __packed;
+
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 07180eec8f26..83c509dcc44f 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1789,6 +1789,18 @@ enum vdev_stats_offload_timer_duration {
 	ATH12K_STATS_TIMER_DUR_2SEC = 3,
 };
 
+#define ATH12K_HTT_MAC_ADDR_L32_0	GENMASK(7, 0)
+#define ATH12K_HTT_MAC_ADDR_L32_1	GENMASK(15, 8)
+#define ATH12K_HTT_MAC_ADDR_L32_2	GENMASK(23, 16)
+#define ATH12K_HTT_MAC_ADDR_L32_3	GENMASK(31, 24)
+#define ATH12K_HTT_MAC_ADDR_H16_0	GENMASK(7, 0)
+#define ATH12K_HTT_MAC_ADDR_H16_1	GENMASK(15, 8)
+
+struct htt_mac_addr {
+	__le32 mac_addr_l32;
+	__le32 mac_addr_h16;
+} __packed;
+
 static inline void ath12k_dp_get_mac_addr(u32 addr_l32, u16 addr_h16, u8 *addr)
 {
 	memcpy(addr, &addr_l32, 4);
-- 
2.25.1


