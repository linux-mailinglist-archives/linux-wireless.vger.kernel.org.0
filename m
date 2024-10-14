Return-Path: <linux-wireless+bounces-13931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C861699C06D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 08:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF54280F47
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 06:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B5513A24D;
	Mon, 14 Oct 2024 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VIAuH4sv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BE17C91
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888803; cv=none; b=lsjcGULJFJFjhFAE3YVVH4hjKULMMrGjyJz877YOy2vb+lwSF6dk7coBslXH3VAVcIJ+APd+lmmUboMKBQHGDtv10KR1irba1oIeieBxMGQX3DXvXv/lkl1RHBK13JN3wOMh3MgkYvZ2uIKAXAxnr072TiOs7RxguNXk0G9OxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888803; c=relaxed/simple;
	bh=f7664dU/a6gFK69Y6v2ALVWujjTPELePfFeSIwKcbEM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A692jEvgp5L07R+IpJygVEEDiV5MnUZSIxU3O5FPHAJHwwf2zPdVzaYLXhOB/NZ4GSRLX+Ibcxb5L40Unx587uSrz6odjMW+KyWgQwIjApq/B3p2VBfayoF+t4GZoHncSx7Z7d5/vengmXbeK9ugKtRcNrC17WygltzpAeVF1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VIAuH4sv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49DLJvkK028069;
	Mon, 14 Oct 2024 06:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QBgFKLvzV+6/3uKVD5x2uy
	6/BElFgus6gprawF2aJmQ=; b=VIAuH4sv/MlYWeIxLY6Sw3NEBRyrqEK16Vv18r
	egYjen9msKdM0daNuqirknIUcJ65yPJY0A2D4gE1yn1JZ28Gq0ENt9st4IPix/lM
	ndmXqv/TFLgWCpvLT1zamELs0ZgKSU9ebMXjoR/l3SH19ZROZ362VQruiWEXfgLL
	ZdvnUb+j/uvrUhPxLS+F4ZGAOwaf0AX2bsZ8RNl6//KKMCmoHlfBiB3KwV4ZNL3M
	GcPNxCxwmYRZlpOr0g7NyCiPw/iyvEMf0VPVlP9TW4KzLgkcbHjQY/v4rKvLh79O
	TP5krztbe7LWokxBjUAeJD2WB0o2MAR/C77/MmZFyWo0/LSA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427hb33gtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 06:53:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49E6rGMr020078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 06:53:16 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 13 Oct 2024 23:53:14 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v3] wifi: ath12k: Support DMAC Reset Stats
Date: Mon, 14 Oct 2024 12:22:59 +0530
Message-ID: <20241014065259.3968727-1-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: EJnx0ZdhzJbwlMOR41PPkplXS-pwmS3H
X-Proofpoint-GUID: EJnx0ZdhzJbwlMOR41PPkplXS-pwmS3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140049

From: Rajat Soni <quic_rajson@quicinc.com>

Add support to request DMAC reset stats from firmware through HTT stats
type 45. These stats give debug SoC error stats such as reset count, reset
time, engage time and count, disengage time and count and destination
ring mask.

Sample output:
-------------
echo 45 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_DMAC_RESET_STATS_TLV:
reset_count = 1
reset_time_ms = 3013430342
disengage_time_ms = 3013430342
engage_time_ms = 3013430342
disengage_count = 1
engage_count = 1
drain_dest_ring_mask = 0x0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 49 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 15 ++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index b2be7dade79f..8e43e05422c2 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2502,6 +2502,52 @@ ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static u64 ath12k_le32hilo_to_u64(__le32 hi, __le32 lo)
+{
+	u64 hi64 = le32_to_cpu(hi);
+	u64 lo64 = le32_to_cpu(lo);
+
+	return (hi64 << 32) | lo64;
+}
+
+static void
+ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_dmac_reset_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u64 time;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_DMAC_RESET_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "reset_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->reset_count));
+	time = ath12k_le32hilo_to_u64(htt_stats_buf->reset_time_hi_ms,
+				      htt_stats_buf->reset_time_lo_ms);
+	len += scnprintf(buf + len, buf_len - len, "reset_time_ms = %llu\n", time);
+
+	time = ath12k_le32hilo_to_u64(htt_stats_buf->disengage_time_hi_ms,
+				      htt_stats_buf->disengage_time_lo_ms);
+	len += scnprintf(buf + len, buf_len - len, "disengage_time_ms = %llu\n", time);
+
+	time = ath12k_le32hilo_to_u64(htt_stats_buf->engage_time_hi_ms,
+				      htt_stats_buf->engage_time_lo_ms);
+	len += scnprintf(buf + len, buf_len - len, "engage_time_ms = %llu\n", time);
+
+	len += scnprintf(buf + len, buf_len - len, "disengage_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->disengage_count));
+	len += scnprintf(buf + len, buf_len - len, "engage_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->engage_count));
+	len += scnprintf(buf + len, buf_len - len, "drain_dest_ring_mask = 0x%x\n\n",
+			 le32_to_cpu(htt_stats_buf->drain_dest_ring_mask));
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -2675,6 +2721,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_OBSS_PD_TAG:
 		ath12k_htt_print_pdev_obss_pd_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_DMAC_RESET_STATS_TAG:
+		ath12k_htt_print_dmac_reset_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 597334830d02..120615fbe853 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -135,6 +135,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
+	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -196,6 +197,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SELFGEN_BE_ERR_STATS_TAG		= 137,
 	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
 	HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG	= 139,
+	HTT_STATS_DMAC_RESET_STATS_TAG			= 155,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -1048,4 +1050,17 @@ struct ath12k_htt_pdev_obss_pd_stats_tlv {
 	__le32 num_sr_ppdu_abort_flush_cnt;
 } __packed;
 
+struct ath12k_htt_dmac_reset_stats_tlv {
+	__le32 reset_count;
+	__le32 reset_time_lo_ms;
+	__le32 reset_time_hi_ms;
+	__le32 disengage_time_lo_ms;
+	__le32 disengage_time_hi_ms;
+	__le32 engage_time_lo_ms;
+	__le32 engage_time_hi_ms;
+	__le32 disengage_count;
+	__le32 engage_count;
+	__le32 drain_dest_ring_mask;
+} __packed;
+
 #endif

base-commit: 69eabe24843f238e79a6dbbd2b3fcc8eef39d6b8
-- 
2.25.1


