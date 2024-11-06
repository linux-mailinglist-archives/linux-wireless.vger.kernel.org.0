Return-Path: <linux-wireless+bounces-14953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C799BDE0D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 05:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E0D284CFF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 04:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD817B50B;
	Wed,  6 Nov 2024 04:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h3YfACyf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507818F2DD
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 04:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730868385; cv=none; b=QP8/4A2u+l3ys+EDFQCKYyPLmFTpUsY3Ag0KC+iNSzNpqiKDU7P4xjJawMpIXFNHBXVf54PxbhC5TB0g5SsFG+mztvPdDxoxrF7rbEPbedS7BROWG2fxrF17CPh9CWzkcjq32z8Uz0qDj8HCudT9qM/Ptf3SWOyFqc+M7HgyoB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730868385; c=relaxed/simple;
	bh=SHxQ9qSkj4nQKwR8MQLhcpKa91gg6JNxCcPHUAzCIRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLHdM003+VDErCpKrd4acXR9MKPUZehphD3u9zF8k+zdI+ncKPFFwFyzmY3+id2dlMmOIIjuaTq6xdiCC0/zNvtGaaClLwjLui2GoQ6Nh18yoKaM4EhFQJ2I6ZDkJv6dd3DuaWphG+2uAC1yo6HL+QPnrbyz4oTfWPk2R9RAvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h3YfACyf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A633nn2023364;
	Wed, 6 Nov 2024 04:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QKwjcxdYOJHZ1XbiIQnmlU9EZtBfUYE5UF8ERtCBz1c=; b=h3YfACyfyuDbi91L
	Fe77lRhKYgkH/pWeL0sXbGDu8KtdITtjkLeOICBJ5YH44/Nfgw11juyhHPpEHI2p
	HnnWnuHTj9RCjiEo2bJHNa74M+4lJzCQJi2sXxWEENYCjbQxdOoy2FZ+nlOebaL4
	5nISqHOrCk+GI7NtjXIpTobCJXaFw+IpbpDedCoU2535HMAO/u79AH5wfYEuJWPS
	LmkDHXXrUpeGkvyRc8Pr7Tmem/iPmhPLbPIUZciKMnrbEvLb8tpRt6wEQxal9bmH
	EqLnoc0/ClJi7BG53hIdlEJm0ovvu1dYaBINLfDc8IhtZLQi+SLcliHB8MdnXzd2
	xQt8ow==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r07hg655-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 04:46:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A64kDh5031567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 04:46:13 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 5 Nov 2024 20:46:11 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v4 4/4] wifi: ath12k: Support Transmit PER Rate Stats
Date: Wed, 6 Nov 2024 10:15:48 +0530
Message-ID: <20241106044548.3530128-5-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
References: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: nYX0XkaNTpOmMCkeBRY8NG8tHD4gyIDv
X-Proofpoint-ORIG-GUID: nYX0XkaNTpOmMCkeBRY8NG8tHD4gyIDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060036

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request per rate stats through HTT stats type
40. These stats give information about rates of PPDUs and
MPDUs for single user and for OFDMA and MUMIMO technologies
corresponding to multiple users.

Sample output:
-------------
echo 40 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_TX_PER_STATS:

PER_STATS_SU:

PER per BW:
ppdus_tried_su =  0:0  1:0  2:0  3:0  4:0
ppdus_ack_failed_su =  0:0  1:0  2:0  3:0  4:0
mpdus_tried_su =  0:0  1:0  2:0  3:0  4:0
mpdus_failed_su =  0:0 1:0 2:0 3:0 4:0

PER per NSS:
ppdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
ppdus_ack_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
mpdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0
mpdus_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0

PER per MCS:
ppdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
ppdus_ack_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
mpdus_tried_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
mpdus_failed_su =  0:0  1:0  2:0  3:0  4:0  5:0  6:0  7:0  8:0  9:0  10:0  11:0  12:0  13:0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 269 +++++++++++++++++-
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  68 ++++-
 2 files changed, 334 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 7dabf388267c..2a5c3920ee5f 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -48,6 +48,28 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
 					footer);
 }
 
+static const char *ath12k_htt_ax_tx_rx_ru_size_to_str(u8 ru_size)
+{
+	switch (ru_size) {
+	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_26:
+		return "26";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_52:
+		return "52";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_106:
+		return "106";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_242:
+		return "242";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_484:
+		return "484";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_996:
+		return "996";
+	case ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_996x2:
+		return "996x2";
+	default:
+		return "unknown";
+	}
+}
+
 static const char *ath12k_htt_be_tx_rx_ru_size_to_str(u8 ru_size)
 {
 	switch (ru_size) {
@@ -88,6 +110,17 @@ static const char *ath12k_htt_be_tx_rx_ru_size_to_str(u8 ru_size)
 	}
 }
 
+static const char*
+ath12k_tx_ru_size_to_str(enum ath12k_htt_stats_ru_type ru_type, u8 ru_size)
+{
+	if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_RU_ONLY)
+		return ath12k_htt_ax_tx_rx_ru_size_to_str(ru_size);
+	else if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_AND_MULTI_RU)
+		return ath12k_htt_be_tx_rx_ru_size_to_str(ru_size);
+	else
+		return "unknown";
+}
+
 static void
 htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
 				struct debug_htt_stats_req *stats_req)
@@ -2882,6 +2915,237 @@ ath12k_htt_print_soc_txrx_stats_common_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_tx_per_rate_stats_tlv(const void *tag_buf, u16 tag_len,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_per_rate_stats_tlv *stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	const char *mode_prefix;
+	int i;
+	u32 ru_size_cnt = 0;
+	u32 rc_mode;
+	u32 ru_type;
+
+	if (tag_len < sizeof(*stats_buf))
+		return;
+
+	rc_mode = le32_to_cpu(stats_buf->rc_mode);
+	ru_type = le32_to_cpu(stats_buf->ru_type);
+
+	switch (rc_mode) {
+	case ATH12K_HTT_STATS_RC_MODE_DLSU:
+		len += scnprintf(buf + len, buf_len - len, "HTT_TX_PER_STATS:\n");
+		len += scnprintf(buf + len, buf_len - len, "\nPER_STATS_SU:\n");
+		mode_prefix = "su";
+		break;
+	case ATH12K_HTT_STATS_RC_MODE_DLMUMIMO:
+		len += scnprintf(buf + len, buf_len - len, "\nPER_STATS_DL_MUMIMO:\n");
+		mode_prefix = "mu";
+		break;
+	case ATH12K_HTT_STATS_RC_MODE_DLOFDMA:
+		len += scnprintf(buf + len, buf_len - len, "\nPER_STATS_DL_OFDMA:\n");
+		mode_prefix = "ofdma";
+		if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_RU_ONLY)
+			ru_size_cnt = ATH12K_HTT_TX_RX_PDEV_STATS_NUM_AX_RU_SIZE_CNTRS;
+		else if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_AND_MULTI_RU)
+			ru_size_cnt = ATH12K_HTT_TX_RX_PDEV_NUM_BE_RU_SIZE_CNTRS;
+		break;
+	case ATH12K_HTT_STATS_RC_MODE_ULMUMIMO:
+		len += scnprintf(buf + len, buf_len - len, "HTT_RX_PER_STATS:\n");
+		len += scnprintf(buf + len, buf_len - len, "\nPER_STATS_UL_MUMIMO:\n");
+		mode_prefix = "ulmu";
+		break;
+	case ATH12K_HTT_STATS_RC_MODE_ULOFDMA:
+		len += scnprintf(buf + len, buf_len - len, "\nPER_STATS_UL_OFDMA:\n");
+		mode_prefix = "ulofdma";
+		if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_RU_ONLY)
+			ru_size_cnt = ATH12K_HTT_TX_RX_PDEV_STATS_NUM_AX_RU_SIZE_CNTRS;
+		else if (ru_type == ATH12K_HTT_STATS_RU_TYPE_SINGLE_AND_MULTI_RU)
+			ru_size_cnt = ATH12K_HTT_TX_RX_PDEV_NUM_BE_RU_SIZE_CNTRS;
+		break;
+	default:
+		return;
+	}
+
+	len += scnprintf(buf + len, buf_len - len, "\nPER per BW:\n");
+	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA ||
+	    rc_mode == ATH12K_HTT_STATS_RC_MODE_ULMUMIMO)
+		len += scnprintf(buf + len, buf_len - len, "data_ppdus_%s = ",
+				 mode_prefix);
+	else
+		len += scnprintf(buf + len, buf_len - len, "ppdus_tried_%s = ",
+				 mode_prefix);
+	for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_BW_CNTRS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,
+				 le32_to_cpu(stats_buf->per_bw[i].ppdus_tried));
+	len += scnprintf(buf + len, buf_len - len, " %u:%u\n", i,
+			 le32_to_cpu(stats_buf->per_bw320.ppdus_tried));
+
+	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA ||
+	    rc_mode == ATH12K_HTT_STATS_RC_MODE_ULMUMIMO)
+		len += scnprintf(buf + len, buf_len - len, "non_data_ppdus_%s = ",
+				 mode_prefix);
+	else
+		len += scnprintf(buf + len, buf_len - len, "ppdus_ack_failed_%s = ",
+				 mode_prefix);
+	for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_BW_CNTRS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,
+				 le32_to_cpu(stats_buf->per_bw[i].ppdus_ack_failed));
+	len += scnprintf(buf + len, buf_len - len, " %u:%u\n", i,
+			 le32_to_cpu(stats_buf->per_bw320.ppdus_ack_failed));
+
+	len += scnprintf(buf + len, buf_len - len, "mpdus_tried_%s = ", mode_prefix);
+	for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_BW_CNTRS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,
+				 le32_to_cpu(stats_buf->per_bw[i].mpdus_tried));
+	len += scnprintf(buf + len, buf_len - len, " %u:%u\n", i,
+			 le32_to_cpu(stats_buf->per_bw320.mpdus_tried));
+
+	len += scnprintf(buf + len, buf_len - len, "mpdus_failed_%s = ", mode_prefix);
+	for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_BW_CNTRS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u", i,
+				 le32_to_cpu(stats_buf->per_bw[i].mpdus_failed));
+	len += scnprintf(buf + len, buf_len - len, " %u:%u\n", i,
+			 le32_to_cpu(stats_buf->per_bw320.mpdus_failed));
+
+	len += scnprintf(buf + len, buf_len - len, "\nPER per NSS:\n");
+	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA ||
+	    rc_mode == ATH12K_HTT_STATS_RC_MODE_ULMUMIMO)
+		len += scnprintf(buf + len, buf_len - len, "data_ppdus_%s = ",
+				 mode_prefix);
+	else
+		len += scnprintf(buf + len, buf_len - len, "ppdus_tried_%s = ",
+				 mode_prefix);
+	for (i = 0; i < ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i + 1,
+				 le32_to_cpu(stats_buf->per_nss[i].ppdus_tried));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA ||
+	    rc_mode == ATH12K_HTT_STATS_RC_MODE_ULMUMIMO)
+		len += scnprintf(buf + len, buf_len - len, "non_data_ppdus_%s = ",
+				 mode_prefix);
+	else
+		len += scnprintf(buf + len, buf_len - len, "ppdus_ack_failed_%s = ",
+				 mode_prefix);
+	for (i = 0; i < ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i + 1,
+				 le32_to_cpu(stats_buf->per_nss[i].ppdus_ack_failed));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "mpdus_tried_%s = ", mode_prefix);
+	for (i = 0; i < ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i + 1,
+				 le32_to_cpu(stats_buf->per_nss[i].mpdus_tried));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "mpdus_failed_%s = ", mode_prefix);
+	for (i = 0; i < ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i + 1,
+				 le32_to_cpu(stats_buf->per_nss[i].mpdus_failed));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "\nPER per MCS:\n");
+	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA ||
+	    rc_mode == ATH12K_HTT_STATS_RC_MODE_ULMUMIMO)
+		len += scnprintf(buf + len, buf_len - len, "data_ppdus_%s = ",
+				 mode_prefix);
+	else
+		len += scnprintf(buf + len, buf_len - len, "ppdus_tried_%s = ",
+				 mode_prefix);
+	for (i = 0; i < ATH12K_HTT_TXBF_RATE_STAT_NUM_MCS_CNTRS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,
+				 le32_to_cpu(stats_buf->per_mcs[i].ppdus_tried));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA ||
+	    rc_mode == ATH12K_HTT_STATS_RC_MODE_ULMUMIMO)
+		len += scnprintf(buf + len, buf_len - len, "non_data_ppdus_%s = ",
+				 mode_prefix);
+	else
+		len += scnprintf(buf + len, buf_len - len, "ppdus_ack_failed_%s = ",
+				 mode_prefix);
+	for (i = 0; i < ATH12K_HTT_TXBF_RATE_STAT_NUM_MCS_CNTRS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,
+				 le32_to_cpu(stats_buf->per_mcs[i].ppdus_ack_failed));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "mpdus_tried_%s = ", mode_prefix);
+	for (i = 0; i < ATH12K_HTT_TXBF_RATE_STAT_NUM_MCS_CNTRS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,
+				 le32_to_cpu(stats_buf->per_mcs[i].mpdus_tried));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "mpdus_failed_%s = ", mode_prefix);
+	for (i = 0; i < ATH12K_HTT_TXBF_RATE_STAT_NUM_MCS_CNTRS; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u ", i,
+				 le32_to_cpu(stats_buf->per_mcs[i].mpdus_failed));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	if ((rc_mode == ATH12K_HTT_STATS_RC_MODE_DLOFDMA ||
+	     rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA) &&
+	     ru_type != ATH12K_HTT_STATS_RU_TYPE_INVALID) {
+		len += scnprintf(buf + len, buf_len - len, "\nPER per RU:\n");
+
+		if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA)
+			len += scnprintf(buf + len, buf_len - len, "data_ppdus_%s = ",
+					 mode_prefix);
+		else
+			len += scnprintf(buf + len, buf_len - len, "ppdus_tried_%s = ",
+					 mode_prefix);
+		for (i = 0; i < ru_size_cnt; i++)
+			len += scnprintf(buf + len, buf_len - len, " %s:%u ",
+					 ath12k_tx_ru_size_to_str(ru_type, i),
+					 le32_to_cpu(stats_buf->ru[i].ppdus_tried));
+		len += scnprintf(buf + len, buf_len - len, "\n");
+
+		if (rc_mode == ATH12K_HTT_STATS_RC_MODE_ULOFDMA)
+			len += scnprintf(buf + len, buf_len - len,
+					 "non_data_ppdus_%s = ", mode_prefix);
+		else
+			len += scnprintf(buf + len, buf_len - len,
+					 "ppdus_ack_failed_%s = ", mode_prefix);
+		for (i = 0; i < ru_size_cnt; i++)
+			len += scnprintf(buf + len, buf_len - len, " %s:%u ",
+					 ath12k_tx_ru_size_to_str(ru_type, i),
+					 le32_to_cpu(stats_buf->ru[i].ppdus_ack_failed));
+		len += scnprintf(buf + len, buf_len - len, "\n");
+
+		len += scnprintf(buf + len, buf_len - len, "mpdus_tried_%s = ",
+				 mode_prefix);
+		for (i = 0; i < ru_size_cnt; i++)
+			len += scnprintf(buf + len, buf_len - len, " %s:%u ",
+					 ath12k_tx_ru_size_to_str(ru_type, i),
+					 le32_to_cpu(stats_buf->ru[i].mpdus_tried));
+		len += scnprintf(buf + len, buf_len - len, "\n");
+
+		len += scnprintf(buf + len, buf_len - len, "mpdus_failed_%s = ",
+				 mode_prefix);
+		for (i = 0; i < ru_size_cnt; i++)
+			len += scnprintf(buf + len, buf_len - len, " %s:%u ",
+					 ath12k_tx_ru_size_to_str(ru_type, i),
+					 le32_to_cpu(stats_buf->ru[i].mpdus_failed));
+		len += scnprintf(buf + len, buf_len - len, "\n\n");
+	}
+
+	if (rc_mode == ATH12K_HTT_STATS_RC_MODE_DLMUMIMO) {
+		len += scnprintf(buf + len, buf_len - len, "\nlast_probed_bw  = %u\n",
+				 le32_to_cpu(stats_buf->last_probed_bw));
+		len += scnprintf(buf + len, buf_len - len, "last_probed_nss = %u\n",
+				 le32_to_cpu(stats_buf->last_probed_nss));
+		len += scnprintf(buf + len, buf_len - len, "last_probed_mcs = %u\n",
+				 le32_to_cpu(stats_buf->last_probed_mcs));
+		len += print_array_to_buf(buf, len, "MU Probe count per RC MODE",
+					  stats_buf->probe_cnt,
+					  ATH12K_HTT_RC_MODE_2D_COUNT, "\n\n");
+	}
+
+	stats_req->buf_len = len;
+}
+
 static void
 ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
 				      struct debug_htt_stats_req *stats_req)
@@ -3020,7 +3284,7 @@ ath12k_htt_print_tx_pdev_rate_stats_be_ofdma_tlv(const void *tag_buf, u16 tag_le
 	len += scnprintf(buf + len, buf_len - len, "\n");
 	len += print_array_to_buf_index(buf, len, "be_ofdma_tx_nss = ", 1,
 					htt_stats_buf->be_ofdma_tx_nss,
-					ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS,
+					ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS,
 					"\n");
 	len += print_array_to_buf(buf, len, "be_ofdma_tx_bw",
 				  htt_stats_buf->be_ofdma_tx_bw,
@@ -3230,6 +3494,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_SOC_TXRX_STATS_COMMON_TAG:
 		ath12k_htt_print_soc_txrx_stats_common_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PER_RATE_STATS_TAG:
+		ath12k_htt_print_tx_per_rate_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_DMAC_RESET_STATS_TAG:
 		ath12k_htt_print_dmac_reset_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index c07b60636c22..d199bed0a9d1 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -138,6 +138,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
 	ATH12K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	= 37,
 	ATH12K_DBG_HTT_EXT_VDEVS_TXRX_STATS		= 38,
+	ATH12K_DBG_HTT_EXT_PDEV_PER_STATS		= 40,
 	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
 	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
@@ -203,6 +204,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_PHY_RESET_COUNTERS_TAG		= 123,
 	HTT_STATS_PHY_RESET_STATS_TAG			= 124,
 	HTT_STATS_SOC_TXRX_STATS_COMMON_TAG		= 125,
+	HTT_STATS_PER_RATE_STATS_TAG			= 128,
 	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
 	HTT_STATS_TX_PDEV_MUMIMO_GRP_STATS_TAG		= 130,
 	HTT_STATS_TX_PDEV_RATE_STATS_BE_OFDMA_TAG	= 135,
@@ -1221,6 +1223,10 @@ struct ath12k_htt_pdev_sched_algo_ofdma_stats_tlv {
 	__le32 dlofdma_disabled_consec_no_mpdus_success[ATH12K_HTT_NUM_AC_WMM];
 } __packed;
 
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_BW_CNTRS		4
+#define ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS	8
+#define ATH12K_HTT_TXBF_RATE_STAT_NUM_MCS_CNTRS		14
+
 enum ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE {
 	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_26,
 	ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE_52,
@@ -1241,7 +1247,65 @@ enum ATH12K_HTT_TX_RX_PDEV_STATS_BE_RU_SIZE {
 	ATH12K_HTT_TX_RX_PDEV_NUM_BE_RU_SIZE_CNTRS,
 };
 
-#define ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS	8
+enum ATH12K_HTT_RC_MODE {
+	ATH12K_HTT_RC_MODE_SU_OL,
+	ATH12K_HTT_RC_MODE_SU_BF,
+	ATH12K_HTT_RC_MODE_MU1_INTF,
+	ATH12K_HTT_RC_MODE_MU2_INTF,
+	ATH12K_HTT_RC_MODE_MU3_INTF,
+	ATH12K_HTT_RC_MODE_MU4_INTF,
+	ATH12K_HTT_RC_MODE_MU5_INTF,
+	ATH12K_HTT_RC_MODE_MU6_INTF,
+	ATH12K_HTT_RC_MODE_MU7_INTF,
+	ATH12K_HTT_RC_MODE_2D_COUNT
+};
+
+enum ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE {
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_26,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_52,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_106,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_242,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_484,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_996,
+	ATH12K_HTT_TX_RX_PDEV_STATS_AX_RU_SIZE_996x2,
+	ATH12K_HTT_TX_RX_PDEV_STATS_NUM_AX_RU_SIZE_CNTRS
+};
+
+enum ath12k_htt_stats_rc_mode {
+	ATH12K_HTT_STATS_RC_MODE_DLSU     = 0,
+	ATH12K_HTT_STATS_RC_MODE_DLMUMIMO = 1,
+	ATH12K_HTT_STATS_RC_MODE_DLOFDMA  = 2,
+	ATH12K_HTT_STATS_RC_MODE_ULMUMIMO = 3,
+	ATH12K_HTT_STATS_RC_MODE_ULOFDMA  = 4,
+};
+
+enum ath12k_htt_stats_ru_type {
+	ATH12K_HTT_STATS_RU_TYPE_INVALID,
+	ATH12K_HTT_STATS_RU_TYPE_SINGLE_RU_ONLY,
+	ATH12K_HTT_STATS_RU_TYPE_SINGLE_AND_MULTI_RU,
+};
+
+struct ath12k_htt_tx_rate_stats {
+	__le32 ppdus_tried;
+	__le32 ppdus_ack_failed;
+	__le32 mpdus_tried;
+	__le32 mpdus_failed;
+} __packed;
+
+struct ath12k_htt_tx_per_rate_stats_tlv {
+	__le32 rc_mode;
+	__le32 last_probed_mcs;
+	__le32 last_probed_nss;
+	__le32 last_probed_bw;
+	struct ath12k_htt_tx_rate_stats per_bw[ATH12K_HTT_TX_PDEV_STATS_NUM_BW_CNTRS];
+	struct ath12k_htt_tx_rate_stats per_nss[ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS];
+	struct ath12k_htt_tx_rate_stats per_mcs[ATH12K_HTT_TXBF_RATE_STAT_NUM_MCS_CNTRS];
+	struct ath12k_htt_tx_rate_stats per_bw320;
+	__le32 probe_cnt[ATH12K_HTT_RC_MODE_2D_COUNT];
+	__le32 ru_type;
+	struct ath12k_htt_tx_rate_stats ru[ATH12K_HTT_TX_RX_PDEV_NUM_BE_RU_SIZE_CNTRS];
+} __packed;
+
 #define ATH12K_HTT_TX_PDEV_NUM_BE_MCS_CNTRS		16
 #define ATH12K_HTT_TX_PDEV_NUM_BE_BW_CNTRS		5
 #define ATH12K_HTT_TX_PDEV_NUM_EHT_SIG_MCS_CNTRS	4
@@ -1251,7 +1315,7 @@ struct ath12k_htt_tx_pdev_rate_stats_be_ofdma_tlv {
 	__le32 mac_id__word;
 	__le32 be_ofdma_tx_ldpc;
 	__le32 be_ofdma_tx_mcs[ATH12K_HTT_TX_PDEV_NUM_BE_MCS_CNTRS];
-	__le32 be_ofdma_tx_nss[ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 be_ofdma_tx_nss[ATH12K_HTT_PDEV_STAT_NUM_SPATIAL_STREAMS];
 	__le32 be_ofdma_tx_bw[ATH12K_HTT_TX_PDEV_NUM_BE_BW_CNTRS];
 	__le32 gi[ATH12K_HTT_TX_PDEV_NUM_GI_CNTRS][ATH12K_HTT_TX_PDEV_NUM_BE_MCS_CNTRS];
 	__le32 be_ofdma_tx_ru_size[ATH12K_HTT_TX_RX_PDEV_NUM_BE_RU_SIZE_CNTRS];
-- 
2.25.1


