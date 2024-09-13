Return-Path: <linux-wireless+bounces-12839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0EE977B02
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 10:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E26B26AEF
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 08:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A932158DD2;
	Fri, 13 Sep 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aDVG5TVv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA161BD4F2
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216232; cv=none; b=WOK3+Cv09PPjK4vMvKaZTBjZWh9SFcEwZpsyY/IMpUFZ4LdiSC4U7nAJCgPQtarX5KmEupMII1QcwzLnmK+l/b9jAe+x0AcNIoeIqA+R31MfFSh5mVWXgvWuGgQqmsFEl93zIOLjBg/5y8vEnPLqEXzL7f10Lz21Wo3v84f0Y2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216232; c=relaxed/simple;
	bh=KRfE+3pywdXQHU/b+1naXzohsGxvjEwC1UWvSb2l4Zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKZNoQooEwqjAFy8UNpZvGJvHNvaIUgeOW8EbMnWb80TXiP+GGIFy0qk2PllRh5BYb4/7+FjX6uv8odYvkgFyvsDZ4E5fQi1YCyzvushveZrWKJEKcIUbv3zrUzUAvx3PbQkToOMhTXd+2Qjr10oVIDzYyxaXQghUyLbiJbByr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aDVG5TVv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMB20n004952;
	Fri, 13 Sep 2024 08:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	75w+aLmDL09ciy5t7ij2f4/ARbfOodq+cjb9H/ZBtt0=; b=aDVG5TVv3MXj015x
	I40RTbPIZ0JIsvGDs+sDtaQbehwn4PuxPzAXnOvis/Ck17d3C/qp9HdDsIcgr7Cv
	PK+ObmVGksO4v4QmtPnvnRZT/b9jnxt2LicnaWHnxZ1dWdRQjUI8fsnhuT3WlKSN
	5Cj2M5ZN1a+RzAUuHQ9eXjGFOBVRPVmuOExK9Gf5U7binU90Laa26m7/iWJxzFd0
	PPSkKFnWoYxaH9bTfh2/nmICAjhLL3dYXp85ovvQ66krBakAjl5waeYErxpWlICA
	f0Vl1Hy3OatPvGtcw8NEghS9lHztXkXdeWwRDEPtLEJ2wf0B/IEvouw4cdjJ+8CK
	lCsgvg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy7385th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:30:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48D8UQ2s004126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:30:26 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Sep 2024 01:30:23 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 4/4] wifi: ath12k: Support pdev CCA Stats
Date: Fri, 13 Sep 2024 13:59:49 +0530
Message-ID: <20240913082949.573482-5-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913082949.573482-1-quic_rdevanat@quicinc.com>
References: <20240913082949.573482-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Hg35ufA9SX1l88aCJuaxugJlJ9jw9xSL
X-Proofpoint-GUID: Hg35ufA9SX1l88aCJuaxugJlJ9jw9xSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409130058

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request CCA stats for physical devices from firmware
through HTT stats type 19. These stats give information about
channel number, number of records, counters' bitmap, collection
interval and different CCA counters.

Sample output:
-------------
echo 19 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_PDEV_CCA_STATS_HIST_TLV (1s):
chan_num = 5955
num_records = 10
valid_cca_counters_bitmap = 0xff
collection_interval = 1000

HTT_PDEV_STATS_CCA_COUNTERS_TLV:(in usec)
tx_frame_usec = 0
rx_frame_usec = 0
rx_clear_usec = 999955
my_rx_frame_usec = 0
usec_cnt = 999955
med_rx_idle_usec = 0
med_tx_idle_global_usec = 0
cca_obss_usec = 999955
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 67 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 23 +++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 43e159055a7e..2c17e080a0e6 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2372,6 +2372,65 @@ ath12k_htt_print_tx_pdev_mu_mimo_mpdu_stats_tlv(const void *tag_buf, u16 tag_len
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_pdev_cca_stats_hist_tlv(const void *tag_buf, u16 tag_len,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_cca_stats_hist_v1_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_CCA_STATS_HIST_TLV :\n");
+	len += scnprintf(buf + len, buf_len - len, "chan_num = %u\n",
+			 le32_to_cpu(htt_stats_buf->chan_num));
+	len += scnprintf(buf + len, buf_len - len, "num_records = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_records));
+	len += scnprintf(buf + len, buf_len - len, "valid_cca_counters_bitmap = 0x%x\n",
+			 le32_to_cpu(htt_stats_buf->valid_cca_counters_bitmap));
+	len += scnprintf(buf + len, buf_len - len, "collection_interval = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->collection_interval));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_pdev_stats_cca_counters_tlv(const void *tag_buf, u16 tag_len,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_stats_cca_counters_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_PDEV_STATS_CCA_COUNTERS_TLV:(in usec)\n");
+	len += scnprintf(buf + len, buf_len - len, "tx_frame_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_frame_usec));
+	len += scnprintf(buf + len, buf_len - len, "rx_frame_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_frame_usec));
+	len += scnprintf(buf + len, buf_len - len, "rx_clear_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_clear_usec));
+	len += scnprintf(buf + len, buf_len - len, "my_rx_frame_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->my_rx_frame_usec));
+	len += scnprintf(buf + len, buf_len - len, "usec_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->usec_cnt));
+	len += scnprintf(buf + len, buf_len - len, "med_rx_idle_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->med_rx_idle_usec));
+	len += scnprintf(buf + len, buf_len - len, "med_tx_idle_global_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->med_tx_idle_global_usec));
+	len += scnprintf(buf + len, buf_len - len, "cca_obss_usec = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->cca_obss_usec));
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -2534,6 +2593,14 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_PDEV_MPDU_STATS_TAG:
 		ath12k_htt_print_tx_pdev_mu_mimo_mpdu_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PDEV_CCA_1SEC_HIST_TAG:
+	case HTT_STATS_PDEV_CCA_100MSEC_HIST_TAG:
+	case HTT_STATS_PDEV_CCA_STAT_CUMULATIVE_TAG:
+		ath12k_htt_print_pdev_cca_stats_hist_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PDEV_CCA_COUNTERS_TAG:
+		ath12k_htt_print_pdev_stats_cca_counters_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index bd764ddd5394..b37ba1256ce5 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -133,6 +133,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_SRNG_INFO		= 15,
 	ATH12K_DBG_HTT_EXT_STATS_SFM_INFO		= 16,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -176,6 +177,10 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_DE_COMPL_STATS_TAG			= 65,
 	HTT_STATS_WHAL_TX_TAG				= 66,
 	HTT_STATS_TX_PDEV_SIFS_HIST_TAG			= 67,
+	HTT_STATS_PDEV_CCA_1SEC_HIST_TAG		= 70,
+	HTT_STATS_PDEV_CCA_100MSEC_HIST_TAG		= 71,
+	HTT_STATS_PDEV_CCA_STAT_CUMULATIVE_TAG		= 72,
+	HTT_STATS_PDEV_CCA_COUNTERS_TAG			= 73,
 	HTT_STATS_TX_PDEV_MPDU_STATS_TAG		= 74,
 	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG		= 86,
 	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG	= 87,
@@ -1001,4 +1006,22 @@ struct ath12k_htt_tx_pdev_mpdu_stats_tlv {
 	__le32 tx_sched_mode;
 } __packed;
 
+struct ath12k_htt_pdev_stats_cca_counters_tlv {
+	__le32 tx_frame_usec;
+	__le32 rx_frame_usec;
+	__le32 rx_clear_usec;
+	__le32 my_rx_frame_usec;
+	__le32 usec_cnt;
+	__le32 med_rx_idle_usec;
+	__le32 med_tx_idle_global_usec;
+	__le32 cca_obss_usec;
+} __packed;
+
+struct ath12k_htt_pdev_cca_stats_hist_v1_tlv {
+	__le32 chan_num;
+	__le32 num_records;
+	__le32 valid_cca_counters_bitmap;
+	__le32 collection_interval;
+} __packed;
+
 #endif
-- 
2.25.1


