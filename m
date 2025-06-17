Return-Path: <linux-wireless+bounces-24168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991A1ADC055
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 06:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E213AC7B8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 04:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15B482FF;
	Tue, 17 Jun 2025 04:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FB9gXlzJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A30FCA6F
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 04:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134145; cv=none; b=d6Kz2KSoXgnlvxvglV66o9qoEv+XV00y7ILigKypq3yd2/10SZ848Xio1vahlr8xZaTyudkA2dNBFR3dARU0Ir/iyG3mwQSHnBxEc9hGxtYE81DFQ6o7oCqGKmUJ1I9LdNHyg5LjGwb+yO2xOz/h5rqKnOVo2+/PGNxJ5QppgE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134145; c=relaxed/simple;
	bh=BCwllwCFpxJeXGtK3iiHY9ghARccDLhsrdLtXENPy+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cxpfaxEXg9z2+lFbHwpbjcdP26UJ0kT5aPgyBg/q8DtqutdhAS80KD6YgNMh42N7/TG9Wj+0LnuX8PhopP2La6ieLhHiuQe7IV/NfRbPq5Kl6/C3EGsfVKaFLqk9EpJDW6vxqy/9sPqKzz1qA6CmVzS7lFW54X/L7VZaRV9Gcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FB9gXlzJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GI2up9005767;
	Tue, 17 Jun 2025 04:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TFtHlomxUhb+fVN6uvypKj
	U5ZiAYfyZWZ4BPYNO8LPk=; b=FB9gXlzJlV+eflAsv7VXmw2xM+fQQSFjdA5Vv5
	eMXhbq9NeDsJJXKowve6WnYugLSXHgdHQvwjEz+ZFn5djkLe/EQl1kB7xiiHtRmX
	7lV8NKpVTqEYLSbcjJVOfbyg81oZdEZeIJXkTpeMmz7r1LCtf6QFoIFem0gRnU3x
	QMHMH1roEcuHT6ECKJPgWO5RmNG5kG5JDOfxpzhB4/SmQ6hKeqAywO/6OWFXF09U
	9EOPzUWJrWJcqAq/5iY+MZUchzpr0d7A2vDVIqSfS6iFKXqbpkfqp8/p+bgRdEyv
	8ad58UOjJI1mF0qYGruSZzWP16ZOGDPECk9BNcr3b97CX/Tw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hcxtha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 04:22:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55H4MIuY028867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 04:22:18 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Jun 2025 21:22:16 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Saleemuddin Shaik
	<quic_saleemud@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH ath-next] wifi: ath12k: Add support for transmit histogram stats
Date: Tue, 17 Jun 2025 09:51:41 +0530
Message-ID: <20250617042141.215540-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAzNCBTYWx0ZWRfXw+r0ao7QjUac
 1LjvDUxLiWIP3/7jcdWkyOYTNP7zDilBjvTPz9uzVxapqJgEA7HwtETi2qT+Od0+kDNfxsGQcAn
 znv9Cl6W+xqRBsKglzOnvhpGPy1TiinRZKDeDbOLZcdxn63Qk3Q3POGU/3fCKJBQ243Z0b2D9aE
 WhZlPzdekkm9LFUFaz9mcDqbG8wVB9KD612ANajAkuMwfmJDCI5/WHsB7iSjOFip0VIvnwj3p1r
 k0ZBBCrbd6Fztj+9jzDT/61Da1Qfzg9CdfGSYUTlRPWszYYA14MFO1ags+MyoZ1iHmwwfc/q3k5
 WgJYymoB7LVjrxK2872FCGKqHGcn9aLVigBVorh+VFdwnOWhBmfJvXY0+/L+h4WOKhGt9elx7oL
 Roc7Az46vgYmUSV8ULEEzO/lTsjZKIaOkU/TaTvyo4H6icLePSqld4KPamYKmcGRioVZ8N6k
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=6850ed7b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=7xaFyXMt0exzL7mAYkQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: wSRmgSfF8H0-Ie6vlXV0cbMV2nGfdYBU
X-Proofpoint-GUID: wSRmgSfF8H0-Ie6vlXV0cbMV2nGfdYBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170034

From: Saleemuddin Shaik <quic_saleemud@quicinc.com>

Add support for transmit histogram stats under HTT stats type 9. These
stats give information about drop count, MCS drop rate, histogram
count, etc.

Note: WCN7850 firmware version -
WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3 does not support tag
HTT_STATS_TX_PDEV_HISTOGRAM_STATS_TAG(144), currently.

Sample output:
echo 9 > /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats
...
low_latency_rate_cnt =  0
su_burst_rate_drop_cnt = 0
su_burst_rate_drop_fail_cnt = 0
rate_retry_mcs_drop_cnt = 0

PER_HISTOGRAM_STATS
mcs_drop_rate =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
per_histogram_count =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0,
11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0,
21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0,
31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0, 38:0, 39:0, 40:0,
41:0, 42:0, 43:0, 44:0, 45:0, 46:0, 47:0, 48:0, 49:0, 50:0,
51:0, 52:0, 53:0, 54:0, 55:0, 56:0, 57:0, 58:0, 59:0, 60:0,
61:0, 62:0, 63:0, 64:0, 65:0, 66:0, 67:0, 68:0, 69:0, 70:0,
71:0, 72:0, 73:0, 74:0, 75:0, 76:0, 77:0, 78:0, 79:0, 80:0,
81:0, 82:0, 83:0, 84:0, 85:0, 86:0, 87:0, 88:0, 89:0, 90:0,
91:0, 92:0, 93:0, 94:0, 95:0, 96:0, 97:0, 98:0, 99:0, 100:0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saleemuddin Shaik <quic_saleemud@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 36 ++++++++++++++++++-
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 16 +++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index aeaf970339d4..c1da0ac682c3 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -4720,7 +4720,38 @@ ath12k_htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf, u16 tag_len,
 	len += print_array_to_buf(buf, len, "tx_pream", htt_stats_buf->tx_pream,
 				  ATH12K_HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES, "\n");
 	len += print_array_to_buf(buf, len, "tx_dcm", htt_stats_buf->tx_dcm,
-				  ATH12K_HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS, "\n");
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+ath12k_htt_print_histogram_stats_tlv(const void *tag_buf, u16 tag_len,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_histogram_stats_tlv *stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+
+	if (tag_len < sizeof(*stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "low_latency_rate_cnt =  %u\n",
+			 le32_to_cpu(stats_buf->low_latency_rate_cnt));
+	len += scnprintf(buf + len, buf_len - len, "su_burst_rate_drop_cnt = %u\n",
+			 le32_to_cpu(stats_buf->su_burst_rate_drop_cnt));
+	len += scnprintf(buf + len, buf_len - len, "su_burst_rate_drop_fail_cnt = %u\n",
+			 le32_to_cpu(stats_buf->su_burst_rate_drop_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rate_retry_mcs_drop_cnt = %u\n",
+			 le32_to_cpu(stats_buf->rate_retry_mcs_drop_cnt));
+
+	len += scnprintf(buf + len, buf_len - len, "\nPER_HISTOGRAM_STATS\n");
+	len += print_array_to_buf(buf, len, "mcs_drop_rate", stats_buf->mcs_drop_rate,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_DROP_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "per_histogram_count",
+				  stats_buf->per_histogram_cnt,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_PER_COUNTERS, "\n\n");
 
 	stats_req->buf_len = len;
 }
@@ -5277,6 +5308,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_PDEV_RATE_STATS_TAG:
 		ath12k_htt_print_tx_pdev_rate_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_PDEV_HISTOGRAM_STATS_TAG:
+		ath12k_htt_print_histogram_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_RX_PDEV_RATE_STATS_TAG:
 		ath12k_htt_print_rx_pdev_rate_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index c2a02cf8a38b..5fc5d8c00355 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -237,6 +237,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SELFGEN_BE_ERR_STATS_TAG		= 137,
 	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
 	HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG	= 139,
+	HTT_STATS_TX_PDEV_HISTOGRAM_STATS_TAG		= 144,
 	HTT_STATS_TXBF_OFDMA_AX_NDPA_STATS_TAG		= 147,
 	HTT_STATS_TXBF_OFDMA_AX_NDP_STATS_TAG		= 148,
 	HTT_STATS_TXBF_OFDMA_AX_BRP_STATS_TAG		= 149,
@@ -418,6 +419,12 @@ struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv {
 #define ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS   2
 #define ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS  2
 #define ATH12K_HTT_TX_PDEV_STATS_NUM_11AX_TRIGGER_TYPES   6
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_PER_COUNTERS	  101
+
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_DROP_COUNTERS \
+	(ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS + \
+	 ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS + \
+	 ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS)
 
 struct ath12k_htt_tx_pdev_rate_stats_tlv {
 	__le32 mac_id_word;
@@ -472,6 +479,15 @@ struct ath12k_htt_tx_pdev_rate_stats_tlv {
 	__le32 tx_bw_320mhz;
 };
 
+struct ath12k_htt_tx_histogram_stats_tlv {
+	__le32 rate_retry_mcs_drop_cnt;
+	__le32 mcs_drop_rate[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_DROP_COUNTERS];
+	__le32 per_histogram_cnt[ATH12K_HTT_TX_PDEV_STATS_NUM_PER_COUNTERS];
+	__le32 low_latency_rate_cnt;
+	__le32 su_burst_rate_drop_cnt;
+	__le32 su_burst_rate_drop_fail_cnt;
+};
+
 #define ATH12K_HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS		4
 #define ATH12K_HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS		8
 #define ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS		12

base-commit: 7fb79ce2693c94f8f74bf62ad25a97e4b61721b8
-- 
2.25.1


