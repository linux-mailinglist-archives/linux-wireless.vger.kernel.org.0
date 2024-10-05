Return-Path: <linux-wireless+bounces-13553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C96D991634
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 12:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484F31C21619
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 10:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567C485628;
	Sat,  5 Oct 2024 10:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a4zvPcUN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91431211C
	for <linux-wireless@vger.kernel.org>; Sat,  5 Oct 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124951; cv=none; b=ZoCNGnSiFoo7eOG89sK/CVQrUsrNr3yKH7CQzA6gws41HrWYZs/gS7zitMFu1LFnli3ruu4HvnuhFQsXVycm+WbmFskw5FbxJtsD4Rv9+arS31xwK4SsFewoZfx9cXX2nFEY5EEcuGJElmeGGMJ3CWilJffxoUwB0av7nICpfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124951; c=relaxed/simple;
	bh=dPGrMPtiYgvySe8ML/Abi3aGejlKZD23o9FgvOgs/MA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B0UDRikXNcPx7V5TAB5Gl68bs2T9vGStQcZYn4NkBhbjw0QOcMiWsqqK/8yZBAC7CgRG5T708bi/0dPKMSkF5vJbMTDsTpwl5DtMqRt7VJLO3dTY8IwvQoupQVJFWdBeMUfiHXJD/7ZJEoq2fLDc7l4QHlTHwzOX+407IZqaJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a4zvPcUN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49599gP8013549;
	Sat, 5 Oct 2024 10:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fnBcAwxkv5yMCHIFUP/uWZ
	S5VgvXkDojEJ6l6ZxTKTQ=; b=a4zvPcUNensfGE8GybfgHxWnp8xCoSjW5Sc2m1
	klXIHIjYG9khX4dMvEOyonT9t5RKWMrogiUiIWobJbn60GMhjt4yc3QFD8s7pkg4
	4W3JT10n+CdWl586Wd/IZd2GEUjjyx7Okl++po2dJjAg87j4rV0jSarGFpAGiZPO
	n5pbouNUeUUWwwA3cgLC2P9yiJXMzw7TNoACknaM+7eXiGwYKHdiI6MjkQRSoCei
	IX6mQijZRAwrr3SCaPW647nHZRl8D5MFQDNzFGUqlUcGDacwjSzYPE/a0yFn9nmH
	VVTmPdyGF3QMJJ7ZUbTJiZO+sXK/KhmZsqoHvXCn8nQrF6bA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xq9rddt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Oct 2024 10:42:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 495AgPOd003834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 10:42:25 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Oct 2024 03:42:23 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: Support Pdev OBSS Stats
Date: Sat, 5 Oct 2024 16:12:06 +0530
Message-ID: <20241005104206.3327143-1-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r8sOp4HADw4GkWikFEFamA-1ar6zWMXu
X-Proofpoint-GUID: r8sOp4HADw4GkWikFEFamA-1ar6zWMXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050079

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request pdev OBSS stats from firmware through stats
type 23. These stats give information about PPDUs transmitted or
tried to be transmitted in Spatial Reuse Groups(SRG), Parameterized
Spatial Reuse(PSR) and non-PSR groups.

Sample output:
-------------
echo 23 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_PDEV_OBSS_PD_STATS_TLV:
num_spatial_reuse_tx = 0
num_spatial_reuse_opportunities = 0
num_non_srg_opportunities = 0
num_non_srg_ppdu_tried = 0
.....

HTT_PDEV_OBSS_PD_PER_AC_STATS:
Access Category 0 (best effort)
num_non_srg_ppdu_tried = 0
num_non_srg_ppdu_success = 0
num_srg_ppdu_tried = 0
num_srg_ppdu_success = 0

Access Category 1 (background)
num_non_srg_ppdu_tried = 0
num_non_srg_ppdu_success = 0
num_srg_ppdu_tried = 0
num_srg_ppdu_success = 0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
v2:
 - Updated dependencies. No change in code.
---
Depends-on:
[PATCH v2] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Link: https://lore.kernel.org/all/20241004085915.1788951-1-quic_rdevanat@quicinc.com/

[PATCH v2 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
Link: https://lore.kernel.org/ath12k/20241005101816.3314728-1-quic_rdevanat@quicinc.com/
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 68 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 24 +++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index bf6864711980..d890679a3f16 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2437,6 +2437,71 @@ ath12k_htt_print_pdev_stats_cca_counters_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_obss_pd_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u8 i;
+	static const char *access_cat_names[ATH12K_HTT_NUM_AC_WMM] = {"best effort",
+								      "background",
+								      "video", "voice"};
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_OBSS_PD_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "num_spatial_reuse_tx = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_sr_tx_transmissions));
+	len += scnprintf(buf + len, buf_len - len,
+			 "num_spatial_reuse_opportunities = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_spatial_reuse_opportunities));
+	len += scnprintf(buf + len, buf_len - len, "num_non_srg_opportunities = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_non_srg_opportunities));
+	len += scnprintf(buf + len, buf_len - len, "num_non_srg_ppdu_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_non_srg_ppdu_tried));
+	len += scnprintf(buf + len, buf_len - len, "num_non_srg_ppdu_success = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_non_srg_ppdu_success));
+	len += scnprintf(buf + len, buf_len - len, "num_srg_opportunities = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_srg_opportunities));
+	len += scnprintf(buf + len, buf_len - len, "num_srg_ppdu_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_srg_ppdu_tried));
+	len += scnprintf(buf + len, buf_len - len, "num_srg_ppdu_success = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_srg_ppdu_success));
+	len += scnprintf(buf + len, buf_len - len, "num_psr_opportunities = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_psr_opportunities));
+	len += scnprintf(buf + len, buf_len - len, "num_psr_ppdu_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_psr_ppdu_tried));
+	len += scnprintf(buf + len, buf_len - len, "num_psr_ppdu_success = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_psr_ppdu_success));
+	len += scnprintf(buf + len, buf_len - len, "min_duration_check_flush_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_obss_min_dur_check_flush_cnt));
+	len += scnprintf(buf + len, buf_len - len, "sr_ppdu_abort_flush_cnt = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->num_sr_ppdu_abort_flush_cnt));
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_OBSS_PD_PER_AC_STATS:\n");
+	for (i = 0; i < ATH12K_HTT_NUM_AC_WMM; i++) {
+		len += scnprintf(buf + len, buf_len - len, "Access Category %u (%s)\n",
+				 i, access_cat_names[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "num_non_srg_ppdu_tried = %u\n",
+				 le32_to_cpu(htt_stats_buf->num_non_srg_tried_per_ac[i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "num_non_srg_ppdu_success = %u\n",
+				 le32_to_cpu(htt_stats_buf->num_non_srg_success_ac[i]));
+		len += scnprintf(buf + len, buf_len - len, "num_srg_ppdu_tried = %u\n",
+				 le32_to_cpu(htt_stats_buf->num_srg_tried_per_ac[i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "num_srg_ppdu_success = %u\n\n",
+				 le32_to_cpu(htt_stats_buf->num_srg_success_per_ac[i]));
+	}
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -2607,6 +2672,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_CCA_COUNTERS_TAG:
 		ath12k_htt_print_pdev_stats_cca_counters_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PDEV_OBSS_PD_TAG:
+		ath12k_htt_print_pdev_obss_pd_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index b37ba1256ce5..597334830d02 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -134,6 +134,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_SFM_INFO		= 16,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -184,6 +185,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_PDEV_MPDU_STATS_TAG		= 74,
 	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG		= 86,
 	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG	= 87,
+	HTT_STATS_PDEV_OBSS_PD_TAG			= 88,
 	HTT_STATS_HW_WAR_TAG				= 89,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
@@ -1024,4 +1026,26 @@ struct ath12k_htt_pdev_cca_stats_hist_v1_tlv {
 	__le32 collection_interval;
 } __packed;
 
+struct ath12k_htt_pdev_obss_pd_stats_tlv {
+	__le32 num_obss_tx_ppdu_success;
+	__le32 num_obss_tx_ppdu_failure;
+	__le32 num_sr_tx_transmissions;
+	__le32 num_spatial_reuse_opportunities;
+	__le32 num_non_srg_opportunities;
+	__le32 num_non_srg_ppdu_tried;
+	__le32 num_non_srg_ppdu_success;
+	__le32 num_srg_opportunities;
+	__le32 num_srg_ppdu_tried;
+	__le32 num_srg_ppdu_success;
+	__le32 num_psr_opportunities;
+	__le32 num_psr_ppdu_tried;
+	__le32 num_psr_ppdu_success;
+	__le32 num_non_srg_tried_per_ac[ATH12K_HTT_NUM_AC_WMM];
+	__le32 num_non_srg_success_ac[ATH12K_HTT_NUM_AC_WMM];
+	__le32 num_srg_tried_per_ac[ATH12K_HTT_NUM_AC_WMM];
+	__le32 num_srg_success_per_ac[ATH12K_HTT_NUM_AC_WMM];
+	__le32 num_obss_min_dur_check_flush_cnt;
+	__le32 num_sr_ppdu_abort_flush_cnt;
+} __packed;
+
 #endif

base-commit: 8ed36fe71fd60c851540839b105fd1fddc870c61
prerequisite-patch-id: faf46024c8b5c094e201d392109e7f94dcecdd49
prerequisite-patch-id: c4662f64bc7be141322b7e37145e52ea4ab4e182
prerequisite-patch-id: 4d37990775694f110ce3e87096231fe8855f09f5
prerequisite-patch-id: 5959fd18b497d29cad98d36dcce59a876ffe8ca2
prerequisite-patch-id: ecac67f6fce1dd4d5089dbc3da840e311f6a7218
-- 
2.25.1


