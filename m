Return-Path: <linux-wireless+bounces-7000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1B28B6043
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 19:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8991C212E4
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E0F1272D3;
	Mon, 29 Apr 2024 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M4d0wYwD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B286AFE
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412321; cv=none; b=uig0RlppHg1e4JbM6G/XOEkIceVUK9YWFOPEHiRdzsyVpOhd5b4KA9OXSdxrq1DUgnpm2U2nJd5JMw4wx+3Cbd4KZovVPCJ3GiZEvyCdU7oJlJEnYLwJSPM8aDq6LJh4hzo+IHwf0kCxIAuZBNhVCB4uls4ZGBVt0l18NQ8IZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412321; c=relaxed/simple;
	bh=+AXLz9nkqsf0XKeYVE4NuQgnbB4pafrTU2gXSvG3is8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3ineyN1k1mv9mpPEEXWW61cX8I/RjURROU18xzWf5DcJ647GOABMZdzokEBi4I1YoNWBEoQxypk97L7IiRZXCY0S5bcd93EtiEKe/Ro4LNHsyJw/pJaT+KfXXCDxe4JFTn7sGWcqkvGShnqyU2WCCWtGMJNeepWDQpeia76xXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M4d0wYwD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TDh8G4003786;
	Mon, 29 Apr 2024 17:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=YmAs7Hu
	WgRkksPjBX6NLAPfpjBrce+VCg7VWkKM4hT8=; b=M4d0wYwD75j5+fULSeYlS5p
	NoQgbt4mFHEL+q37o85FloPiOmQ9vz/9KjmCyWTg6YM4eXdB8Wtp2D4QvrPvWsla
	6k8y6tG7+8p7Uvpe9Qz6INWnNO9/EmI+lZzRiwthl3Pwkx9RQmd5fB1iKEbW69/9
	3LyiQVmtvTVIJ/g/y2rY372TpVN9dgOeS5xJK/cnJj06xkkR0u/X4i+hvpGxNg2R
	vB76TF3hojpXa0ElHgPZHoGLkqLl42COS9H/hVlEkaHw2J73Mtb3V24WL1TIr0m7
	ov7Bv/p/hTZLUUFygCd9znueFLHyKpqWng3YVEp0c0UrEZ3WYO4C8iNJmjJJjmg=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtahba4vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:38:32 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43THcRjt032225;
	Mon, 29 Apr 2024 17:38:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xrtekh4y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:38:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43THcRNx032199;
	Mon, 29 Apr 2024 17:38:27 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 43THcRQ6032186
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:38:27 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 5231F41164; Mon, 29 Apr 2024 23:08:26 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH 3/4] wifi: ath12k: Add support to parse requested stats_type
Date: Mon, 29 Apr 2024 23:08:24 +0530
Message-Id: <20240429173825.2369355-4-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429173825.2369355-1-quic_rgnanase@quicinc.com>
References: <20240429173825.2369355-1-quic_rgnanase@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M3WlV3kRhPUWRc_U6SJJ9vHjmrHzd1AN
X-Proofpoint-ORIG-GUID: M3WlV3kRhPUWRc_U6SJJ9vHjmrHzd1AN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290113

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add extended htt stats parser and print the corresponding TLVs associated
with the requested htt_stats_type.
Add support for TX PDEV related htt stats.

Sample output:
-------------
echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_TX_PDEV_STATS_CMN_TLV:
mac_id = 0
comp_delivered = 0
self_triggers = 256
hw_queued = 275
hw_reaped = 275
underrun = 241
hw_paused = 0
hw_flush = 0
hw_filt = 1
tx_abort = 0
ppdu_ok = 246
mpdu_requeued = 0
tx_xretry = 0
data_rc = 3
mpdu_dropped_xretry = 0
illegal_rate_phy_err = 0
cont_xretry = 0
tx_timeout = 0
tx_time_dur_data = 0
pdev_resets = 0
phy_underrun = 0
txop_ovf = 0
seq_posted = 247
seq_failed_queueing = 0
seq_completed = 247
seq_restarted = 0
seq_txop_repost_stop = 0
next_seq_cancel = 0
dl_mu_mimo_seq_posted = 0
dl_mu_ofdma_seq_posted = 0
ul_mu_mimo_seq_posted = 0
ul_mu_ofdma_seq_posted = 0
mu_mimo_peer_blacklisted = 0
seq_qdepth_repost_stop = 0
seq_min_msdu_repost_stop = 0
mu_seq_min_msdu_repost_stop = 0
seq_switch_hw_paused = 0
next_seq_posted_dsr = 0
seq_posted_isr = 0
seq_ctrl_cached = 0
mpdu_count_tqm = 0
msdu_count_tqm = 0
mpdu_removed_tqm = 0
msdu_removed_tqm = 0
remove_mpdus_max_retries = 0
mpdus_sw_flush = 0
mpdus_hw_filter = 0
mpdus_truncated = 0
mpdus_ack_failed = 0
mpdus_expired = 0
mpdus_seq_hw_retry = 0
ack_tlv_proc = 0
coex_abort_mpdu_cnt_valid = 0
coex_abort_mpdu_cnt = 5
num_total_ppdus_tried_ota = 5
num_data_ppdus_tried_ota = 0
local_ctrl_mgmt_enqued = 247
local_ctrl_mgmt_freed = 247
local_data_enqued = 0
local_data_freed = 0
mpdu_tried = 0
isr_wait_seq_posted = 0
tx_active_dur_us_low = 0
tx_active_dur_us_high = 0
fes_offsets_err_cnt = 0

HTT_TX_PDEV_STATS_URRN_TLV:
urrn_stats =  0:0, 1:241, 2:0,

HTT_TX_PDEV_STATS_SIFS_TLV:
sifs_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,

HTT_TX_PDEV_STATS_FLUSH_TLV:
flush_errs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0,
11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0, 22:0,
23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0,
35:0, 36:0, 37:0, 38:0, 39:0, 40:0, 41:0, 42:0, 43:0, 44:0, 45:0, 46:0,
47:0, 48:0, 49:0, 50:0, 51:0, 52:0, 53:0, 54:0, 55:0, 56:0, 57:0, 58:0,
59:0, 60:0, 61:0, 62:0, 63:0, 64:0, 65:0, 66:0, 67:0, 68:0, 69:0, 70:0,
71:0, 72:0, 73:0, 74:0, 75:0, 76:0, 77:0, 78:0, 79:0, 80:0, 81:0, 82:0,
83:0, 84:0, 85:0, 86:0, 87:0, 88:0, 89:0, 90:0, 91:0, 92:0, 93:0, 94:0,
95:0, 96:0, 97:0, 98:0, 99:0, 100:0, 101:0, 102:0, 103:0, 104:0, 105:0,
106:0, 107:0, 108:0, 109:0, 110:0, 111:0, 112:0, 113:0, 114:0, 115:0,
116:0, 117:0, 118:0, 119:0, 120:0, 121:0, 122:0, 123:0, 124:0, 125:0,
126:0, 127:0,

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 312 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 211 ++++++++++++
 drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 +
 4 files changed, 533 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index d69586506d68..d773456dae3a 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -9,6 +9,318 @@
 #include "debug.h"
 #include "debugfs_htt_stats.h"
 #include "dp_tx.h"
+#include "dp_rx.h"
+
+static u32
+print_array_to_buf(u8 *buf, u32 offset, const char *header,
+		   const __le32 *array, u32 array_len)
+{
+	int index = 0;
+	u8 i;
+
+	if (header) {
+		index += scnprintf(buf + offset,
+				   ATH12K_HTT_STATS_BUF_SIZE - offset,
+				   "%s = ", header);
+	}
+	for (i = 0; i < array_len; i++) {
+		index += scnprintf(buf + offset + index,
+				   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
+				   " %u:%u,", i, le32_to_cpu(array[i]));
+	}
+	index += scnprintf(buf + offset + index,
+			   (ATH12K_HTT_STATS_BUF_SIZE - offset) - index,
+			   "\n\n");
+	return index;
+}
+
+static void
+htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf,
+				struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_pdev_stats_cmn_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_id_word = le32_to_cpu(htt_stats_buf->mac_id__word);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "comp_delivered = %u\n",
+			 le32_to_cpu(htt_stats_buf->comp_delivered));
+	len += scnprintf(buf + len, buf_len - len, "self_triggers = %u\n",
+			 le32_to_cpu(htt_stats_buf->self_triggers));
+	len += scnprintf(buf + len, buf_len - len, "hw_queued = %u\n",
+			 le32_to_cpu(htt_stats_buf->hw_queued));
+	len += scnprintf(buf + len, buf_len - len, "hw_reaped = %u\n",
+			 le32_to_cpu(htt_stats_buf->hw_reaped));
+	len += scnprintf(buf + len, buf_len - len, "underrun = %u\n",
+			 le32_to_cpu(htt_stats_buf->underrun));
+	len += scnprintf(buf + len, buf_len - len, "hw_paused = %u\n",
+			 le32_to_cpu(htt_stats_buf->hw_paused));
+	len += scnprintf(buf + len, buf_len - len, "hw_flush = %u\n",
+			 le32_to_cpu(htt_stats_buf->hw_flush));
+	len += scnprintf(buf + len, buf_len - len, "hw_filt = %u\n",
+			 le32_to_cpu(htt_stats_buf->hw_filt));
+	len += scnprintf(buf + len, buf_len - len, "tx_abort = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_abort));
+	len += scnprintf(buf + len, buf_len - len, "ppdu_ok = %u\n",
+			 le32_to_cpu(htt_stats_buf->ppdu_ok));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_requeued = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_requed));
+	len += scnprintf(buf + len, buf_len - len, "tx_xretry = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_xretry));
+	len += scnprintf(buf + len, buf_len - len, "data_rc = %u\n",
+			 le32_to_cpu(htt_stats_buf->data_rc));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_dropped_xretry = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_dropped_xretry));
+	len += scnprintf(buf + len, buf_len - len, "illegal_rate_phy_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->illgl_rate_phy_err));
+	len += scnprintf(buf + len, buf_len - len, "cont_xretry = %u\n",
+			 le32_to_cpu(htt_stats_buf->cont_xretry));
+	len += scnprintf(buf + len, buf_len - len, "tx_timeout = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_timeout));
+	len += scnprintf(buf + len, buf_len - len, "tx_time_dur_data = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_time_dur_data));
+	len += scnprintf(buf + len, buf_len - len, "pdev_resets = %u\n",
+			 le32_to_cpu(htt_stats_buf->pdev_resets));
+	len += scnprintf(buf + len, buf_len - len, "phy_underrun = %u\n",
+			 le32_to_cpu(htt_stats_buf->phy_underrun));
+	len += scnprintf(buf + len, buf_len - len, "txop_ovf = %u\n",
+			 le32_to_cpu(htt_stats_buf->txop_ovf));
+	len += scnprintf(buf + len, buf_len - len, "seq_posted = %u\n",
+			 le32_to_cpu(htt_stats_buf->seq_posted));
+	len += scnprintf(buf + len, buf_len - len, "seq_failed_queueing = %u\n",
+			 le32_to_cpu(htt_stats_buf->seq_failed_queueing));
+	len += scnprintf(buf + len, buf_len - len, "seq_completed = %u\n",
+			 le32_to_cpu(htt_stats_buf->seq_completed));
+	len += scnprintf(buf + len, buf_len - len, "seq_restarted = %u\n",
+			 le32_to_cpu(htt_stats_buf->seq_restarted));
+	len += scnprintf(buf + len, buf_len - len, "seq_txop_repost_stop = %u\n",
+			 le32_to_cpu(htt_stats_buf->seq_txop_repost_stop));
+	len += scnprintf(buf + len, buf_len - len, "next_seq_cancel = %u\n",
+			 le32_to_cpu(htt_stats_buf->next_seq_cancel));
+	len += scnprintf(buf + len, buf_len - len, "dl_mu_mimo_seq_posted = %u\n",
+			 le32_to_cpu(htt_stats_buf->mu_seq_posted));
+	len += scnprintf(buf + len, buf_len - len, "dl_mu_ofdma_seq_posted = %u\n",
+			 le32_to_cpu(htt_stats_buf->mu_ofdma_seq_posted));
+	len += scnprintf(buf + len, buf_len - len, "ul_mu_mimo_seq_posted = %u\n",
+			 le32_to_cpu(htt_stats_buf->ul_mumimo_seq_posted));
+	len += scnprintf(buf + len, buf_len - len, "ul_mu_ofdma_seq_posted = %u\n",
+			 le32_to_cpu(htt_stats_buf->ul_ofdma_seq_posted));
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_peer_blacklisted = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_mu_peer_blacklisted));
+	len += scnprintf(buf + len, buf_len - len, "seq_qdepth_repost_stop = %u\n",
+			 le32_to_cpu(htt_stats_buf->seq_qdepth_repost_stop));
+	len += scnprintf(buf + len, buf_len - len, "seq_min_msdu_repost_stop = %u\n",
+			 le32_to_cpu(htt_stats_buf->seq_min_msdu_repost_stop));
+	len += scnprintf(buf + len, buf_len - len, "mu_seq_min_msdu_repost_stop = %u\n",
+			 le32_to_cpu(htt_stats_buf->mu_seq_min_msdu_repost_stop));
+	len += scnprintf(buf + len, buf_len - len, "seq_switch_hw_paused = %u\n",
+			 le32_to_cpu(htt_stats_buf->seq_switch_hw_paused));
+	len += scnprintf(buf + len, buf_len - len, "next_seq_posted_dsr = %u\n",
+			 le32_to_cpu(htt_stats_buf->next_seq_posted_dsr));
+	len += scnprintf(buf + len, buf_len - len, "seq_posted_isr = %u\n",
+			 le32_to_cpu(htt_stats_buf->seq_posted_isr));
+	len += scnprintf(buf + len, buf_len - len, "seq_ctrl_cached = %u\n",
+			 le32_to_cpu(htt_stats_buf->seq_ctrl_cached));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_count_tqm = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_count_tqm));
+	len += scnprintf(buf + len, buf_len - len, "msdu_count_tqm = %u\n",
+			 le32_to_cpu(htt_stats_buf->msdu_count_tqm));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_removed_tqm = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_removed_tqm));
+	len += scnprintf(buf + len, buf_len - len, "msdu_removed_tqm = %u\n",
+			 le32_to_cpu(htt_stats_buf->msdu_removed_tqm));
+	len += scnprintf(buf + len, buf_len - len, "remove_mpdus_max_retries = %u\n",
+			 le32_to_cpu(htt_stats_buf->remove_mpdus_max_retries));
+	len += scnprintf(buf + len, buf_len - len, "mpdus_sw_flush = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdus_sw_flush));
+	len += scnprintf(buf + len, buf_len - len, "mpdus_hw_filter = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdus_hw_filter));
+	len += scnprintf(buf + len, buf_len - len, "mpdus_truncated = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdus_truncated));
+	len += scnprintf(buf + len, buf_len - len, "mpdus_ack_failed = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdus_ack_failed));
+	len += scnprintf(buf + len, buf_len - len, "mpdus_expired = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdus_expired));
+	len += scnprintf(buf + len, buf_len - len, "mpdus_seq_hw_retry = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdus_seq_hw_retry));
+	len += scnprintf(buf + len, buf_len - len, "ack_tlv_proc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ack_tlv_proc));
+	len += scnprintf(buf + len, buf_len - len, "coex_abort_mpdu_cnt_valid = %u\n",
+			 le32_to_cpu(htt_stats_buf->coex_abort_mpdu_cnt_valid));
+	len += scnprintf(buf + len, buf_len - len, "coex_abort_mpdu_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->coex_abort_mpdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "num_total_ppdus_tried_ota = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_total_ppdus_tried_ota));
+	len += scnprintf(buf + len, buf_len - len, "num_data_ppdus_tried_ota = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_data_ppdus_tried_ota));
+	len += scnprintf(buf + len, buf_len - len, "local_ctrl_mgmt_enqued = %u\n",
+			 le32_to_cpu(htt_stats_buf->local_ctrl_mgmt_enqued));
+	len += scnprintf(buf + len, buf_len - len, "local_ctrl_mgmt_freed = %u\n",
+			 le32_to_cpu(htt_stats_buf->local_ctrl_mgmt_freed));
+	len += scnprintf(buf + len, buf_len - len, "local_data_enqued = %u\n",
+			 le32_to_cpu(htt_stats_buf->local_data_enqued));
+	len += scnprintf(buf + len, buf_len - len, "local_data_freed = %u\n",
+			 le32_to_cpu(htt_stats_buf->local_data_freed));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_tried));
+	len += scnprintf(buf + len, buf_len - len, "isr_wait_seq_posted = %u\n",
+			 le32_to_cpu(htt_stats_buf->isr_wait_seq_posted));
+	len += scnprintf(buf + len, buf_len - len, "tx_active_dur_us_low = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_active_dur_us_low));
+	len += scnprintf(buf + len, buf_len - len, "tx_active_dur_us_high = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_active_dur_us_high));
+	len += scnprintf(buf + len, buf_len - len, "fes_offsets_err_cnt = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->fes_offsets_err_cnt));
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_tx_pdev_stats_urrn_tlv(const void *tag_buf,
+				 u16 tag_len,
+				 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_pdev_stats_urrn_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      HTT_TX_PDEV_MAX_URRN_STATS);
+
+	len += scnprintf(buf + len, buf_len - len,
+			"HTT_TX_PDEV_STATS_URRN_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "urrn_stats", htt_stats_buf->urrn_stats,
+				  num_elems);
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_tx_pdev_stats_flush_tlv(const void *tag_buf,
+				  u16 tag_len,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_pdev_stats_flush_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      ATH12K_HTT_TX_PDEV_MAX_FLUSH_REASON_STATS);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_STATS_FLUSH_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "flush_errs", htt_stats_buf->flush_errs,
+				  num_elems);
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_tx_pdev_stats_sifs_tlv(const void *tag_buf,
+				 u16 tag_len,
+				 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_pdev_stats_sifs_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      ATH12K_HTT_TX_PDEV_MAX_SIFS_BURST_STATS);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_STATS_SIFS_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "sifs_status", htt_stats_buf->sifs_status,
+				  num_elems);
+
+	stats_req->buf_len = len;
+}
+
+static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
+					  u16 tag, u16 len, const void *tag_buf,
+					  void *user_data)
+{
+	struct debug_htt_stats_req *stats_req = user_data;
+
+	switch (tag) {
+	case HTT_STATS_TX_PDEV_CMN_TAG:
+		htt_print_tx_pdev_stats_cmn_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_TX_PDEV_UNDERRUN_TAG:
+		htt_print_tx_pdev_stats_urrn_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_PDEV_SIFS_TAG:
+		htt_print_tx_pdev_stats_sifs_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_PDEV_FLUSH_TAG:
+		htt_print_tx_pdev_stats_flush_tlv(tag_buf, len, stats_req);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+void ath12k_debugfs_htt_ext_stats_handler(struct ath12k_base *ab,
+					  struct sk_buff *skb)
+{
+	struct ath12k_htt_extd_stats_msg *msg;
+	struct debug_htt_stats_req *stats_req;
+	struct ath12k *ar;
+	u32 len, pdev_id, stats_info;
+	u64 cookie;
+	int ret;
+	bool send_completion = false;
+
+	msg = (struct ath12k_htt_extd_stats_msg *)skb->data;
+	cookie = le64_to_cpu(msg->cookie);
+
+	if (u64_get_bits(cookie, ATH12K_HTT_STATS_COOKIE_MSB) !=
+			 ATH12K_HTT_STATS_MAGIC_VALUE) {
+		ath12k_warn(ab, "received invalid htt ext stats event\n");
+		return;
+	}
+
+	pdev_id = u64_get_bits(cookie, ATH12K_HTT_STATS_COOKIE_LSB);
+	rcu_read_lock();
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
+	if (!ar) {
+		ath12k_warn(ab, "failed to get ar for pdev_id %d\n", pdev_id);
+		goto exit;
+	}
+
+	stats_req = ar->debug.htt_stats.stats_req;
+	if (!stats_req)
+		goto exit;
+
+	spin_lock_bh(&ar->debug.htt_stats.lock);
+
+	stats_info = le32_to_cpu(msg->info1);
+	stats_req->done = u32_get_bits(stats_info, ATH12K_HTT_T2H_EXT_STATS_INFO1_DONE);
+	if (stats_req->done)
+		send_completion = true;
+
+	spin_unlock_bh(&ar->debug.htt_stats.lock);
+
+	len = u32_get_bits(stats_info, ATH12K_HTT_T2H_EXT_STATS_INFO1_LENGTH);
+	ret = ath12k_dp_htt_tlv_iter(ab, msg->data, len,
+				     ath12k_dbg_htt_ext_stats_parse,
+				     stats_req);
+	if (ret)
+		ath12k_warn(ab, "Failed to parse tlv %d\n", ret);
+
+	if (send_completion)
+		complete(&stats_req->htt_stats_rcvd);
+exit:
+	rcu_read_unlock();
+}
 
 static ssize_t ath12k_read_htt_stats_type(struct file *file,
 					  char __user *user_buf,
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index eade49d91720..477ae75f8175 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -21,14 +21,134 @@
 
 void ath12k_debugfs_htt_stats_init(struct ath12k *ar);
 
+#ifdef CONFIG_ATH12K_DEBUGFS
+void ath12k_debugfs_htt_ext_stats_handler(struct ath12k_base *ab,
+					  struct sk_buff *skb);
+#else /* CONFIG_ATH12K_DEBUGFS */
+static inline void ath12k_debugfs_htt_ext_stats_handler(struct ath12k_base *ab,
+							struct sk_buff *skb)
+{
+}
+#endif
+
+/**
+ * DOC: target -> host extended statistics upload
+ *
+ * The following field definitions describe the format of the HTT
+ * target to host stats upload confirmation message.
+ * The message contains a cookie echoed from the HTT host->target stats
+ * upload request, which identifies which request the confirmation is
+ * for, and a single stats can span over multiple HTT stats indication
+ * due to the HTT message size limitation so every HTT ext stats
+ * indication will have tag-length-value stats information elements.
+ * The tag-length header for each HTT stats IND message also includes a
+ * status field, to indicate whether the request for the stat type in
+ * question was fully met, partially met, unable to be met, or invalid
+ * (if the stat type in question is disabled in the target).
+ * A Done bit 1's indicate the end of the of stats info elements.
+ *
+ *
+ * |31                         16|15    12|11|10 8|7   5|4       0|
+ * |--------------------------------------------------------------|
+ * |                   reserved                   |    msg type   |
+ * |--------------------------------------------------------------|
+ * |                         cookie LSBs                          |
+ * |--------------------------------------------------------------|
+ * |                         cookie MSBs                          |
+ * |--------------------------------------------------------------|
+ * |      stats entry length     | rsvd   | D|  S |   stat type   |
+ * |--------------------------------------------------------------|
+ * |                   type-specific stats info                   |
+ * |                      (see debugfs_htt_stats.h)               |
+ * |--------------------------------------------------------------|
+ * Header fields:
+ *  - MSG_TYPE
+ *    Bits 7:0
+ *    Purpose: Identifies this is a extended statistics upload confirmation
+ *             message.
+ *    Value: 0x1c
+ *  - COOKIE_LSBS
+ *    Bits 31:0
+ *    Purpose: Provide a mechanism to match a target->host stats confirmation
+ *        message with its preceding host->target stats request message.
+ *    Value: MSBs of the opaque cookie specified by the host-side requestor
+ *  - COOKIE_MSBS
+ *    Bits 31:0
+ *    Purpose: Provide a mechanism to match a target->host stats confirmation
+ *        message with its preceding host->target stats request message.
+ *    Value: MSBs of the opaque cookie specified by the host-side requestor
+ *
+ * Stats Information Element tag-length header fields:
+ *  - STAT_TYPE
+ *    Bits 7:0
+ *    Purpose: identifies the type of statistics info held in the
+ *        following information element
+ *    Value: ath12k_dbg_htt_ext_stats_type
+ *  - STATUS
+ *    Bits 10:8
+ *    Purpose: indicate whether the requested stats are present
+ *    Value:
+ *       0 -> The requested stats have been delivered in full
+ *       1 -> The requested stats have been delivered in part
+ *       2 -> The requested stats could not be delivered (error case)
+ *       3 -> The requested stat type is either not recognized (invalid)
+ *  - DONE
+ *    Bits 11
+ *    Purpose:
+ *        Indicates the completion of the stats entry, this will be the last
+ *        stats conf HTT segment for the requested stats type.
+ *    Value:
+ *        0 -> the stats retrieval is ongoing
+ *        1 -> the stats retrieval is complete
+ *  - LENGTH
+ *    Bits 31:16
+ *    Purpose: indicate the stats information size
+ *    Value: This field specifies the number of bytes of stats information
+ *       that follows the element tag-length header.
+ *       It is expected but not required that this length is a multiple of
+ *       4 bytes.
+ */
+
+#define ATH12K_HTT_T2H_EXT_STATS_INFO1_DONE		BIT(11)
+#define ATH12K_HTT_T2H_EXT_STATS_INFO1_LENGTH		GENMASK(31, 16)
+
+struct ath12k_htt_extd_stats_msg {
+	__le32 info0;
+	__le64 cookie;
+	__le32 info1;
+	u8 data[];
+} __packed;
+
 /* htt_dbg_ext_stats_type */
 enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_RESET,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
 };
 
+enum ath12k_dbg_htt_tlv_tag {
+	HTT_STATS_TX_PDEV_CMN_TAG			= 0,
+	HTT_STATS_TX_PDEV_UNDERRUN_TAG			= 1,
+	HTT_STATS_TX_PDEV_SIFS_TAG			= 2,
+	HTT_STATS_TX_PDEV_FLUSH_TAG			= 3,
+
+	HTT_STATS_MAX_TAG,
+};
+
+#define ATH12K_HTT_STATS_MAC_ID				GENMASK(7, 0)
+
+#define ATH12K_HTT_TX_PDEV_MAX_SIFS_BURST_STATS		9
+#define ATH12K_HTT_TX_PDEV_MAX_FLUSH_REASON_STATS	150
+
+enum ath12k_htt_tx_pdev_underrun_enum {
+	HTT_STATS_TX_PDEV_NO_DATA_UNDERRUN		= 0,
+	HTT_STATS_TX_PDEV_DATA_UNDERRUN_BETWEEN_MPDU	= 1,
+	HTT_STATS_TX_PDEV_DATA_UNDERRUN_WITHIN_MPDU	= 2,
+	HTT_TX_PDEV_MAX_URRN_STATS			= 3,
+};
+
 enum ath12k_htt_stats_reset_cfg_param_alloc_pos {
 	ATH12K_HTT_STATS_RESET_PARAM_CFG_32_BYTES = 1,
 	ATH12K_HTT_STATS_RESET_PARAM_CFG_64_BYTES,
@@ -47,4 +167,95 @@ struct debug_htt_stats_req {
 	u8 buf[];
 };
 
+struct ath12k_htt_tx_pdev_stats_cmn_tlv {
+	__le32 mac_id__word;
+	__le32 hw_queued;
+	__le32 hw_reaped;
+	__le32 underrun;
+	__le32 hw_paused;
+	__le32 hw_flush;
+	__le32 hw_filt;
+	__le32 tx_abort;
+	__le32 mpdu_requed;
+	__le32 tx_xretry;
+	__le32 data_rc;
+	__le32 mpdu_dropped_xretry;
+	__le32 illgl_rate_phy_err;
+	__le32 cont_xretry;
+	__le32 tx_timeout;
+	__le32 pdev_resets;
+	__le32 phy_underrun;
+	__le32 txop_ovf;
+	__le32 seq_posted;
+	__le32 seq_failed_queueing;
+	__le32 seq_completed;
+	__le32 seq_restarted;
+	__le32 mu_seq_posted;
+	__le32 seq_switch_hw_paused;
+	__le32 next_seq_posted_dsr;
+	__le32 seq_posted_isr;
+	__le32 seq_ctrl_cached;
+	__le32 mpdu_count_tqm;
+	__le32 msdu_count_tqm;
+	__le32 mpdu_removed_tqm;
+	__le32 msdu_removed_tqm;
+	__le32 mpdus_sw_flush;
+	__le32 mpdus_hw_filter;
+	__le32 mpdus_truncated;
+	__le32 mpdus_ack_failed;
+	__le32 mpdus_expired;
+	__le32 mpdus_seq_hw_retry;
+	__le32 ack_tlv_proc;
+	__le32 coex_abort_mpdu_cnt_valid;
+	__le32 coex_abort_mpdu_cnt;
+	__le32 num_total_ppdus_tried_ota;
+	__le32 num_data_ppdus_tried_ota;
+	__le32 local_ctrl_mgmt_enqued;
+	__le32 local_ctrl_mgmt_freed;
+	__le32 local_data_enqued;
+	__le32 local_data_freed;
+	__le32 mpdu_tried;
+	__le32 isr_wait_seq_posted;
+
+	__le32 tx_active_dur_us_low;
+	__le32 tx_active_dur_us_high;
+	__le32 remove_mpdus_max_retries;
+	__le32 comp_delivered;
+	__le32 ppdu_ok;
+	__le32 self_triggers;
+	__le32 tx_time_dur_data;
+	__le32 seq_qdepth_repost_stop;
+	__le32 mu_seq_min_msdu_repost_stop;
+	__le32 seq_min_msdu_repost_stop;
+	__le32 seq_txop_repost_stop;
+	__le32 next_seq_cancel;
+	__le32 fes_offsets_err_cnt;
+	__le32 num_mu_peer_blacklisted;
+	__le32 mu_ofdma_seq_posted;
+	__le32 ul_mumimo_seq_posted;
+	__le32 ul_ofdma_seq_posted;
+
+	__le32 thermal_suspend_cnt;
+	__le32 dfs_suspend_cnt;
+	__le32 tx_abort_suspend_cnt;
+	__le32 tgt_specific_opaque_txq_suspend_info;
+	__le32 last_suspend_reason;
+} __packed;
+
+struct ath12k_htt_tx_pdev_stats_urrn_tlv {
+	DECLARE_FLEX_ARRAY(__le32, urrn_stats);
+} __packed;
+
+struct ath12k_htt_tx_pdev_stats_flush_tlv {
+	DECLARE_FLEX_ARRAY(__le32, flush_errs);
+} __packed;
+
+struct ath12k_htt_tx_pdev_stats_phy_err_tlv {
+	DECLARE_FLEX_ARRAY(__le32, phy_errs);
+} __packed;
+
+struct ath12k_htt_tx_pdev_stats_sifs_tlv {
+	DECLARE_FLEX_ARRAY(__le32, sifs_status);
+} __packed;
+
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 75df622f25d8..8ed03782bb05 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -17,6 +17,7 @@
 #include "dp_tx.h"
 #include "peer.h"
 #include "dp_mon.h"
+#include "debugfs_htt_stats.h"
 
 #define ATH12K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
 
@@ -1292,10 +1293,10 @@ static int ath12k_htt_tlv_ppdu_stats_parse(struct ath12k_base *ab,
 	return 0;
 }
 
-static int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
-				  int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
-					      const void *ptr, void *data),
-				  void *data)
+int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
+			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
+				       const void *ptr, void *data),
+			   void *data)
 {
 	const struct htt_tlv *tlv;
 	const void *begin = ptr;
@@ -1765,6 +1766,7 @@ void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 		ath12k_htt_pull_ppdu_stats(ab, skb);
 		break;
 	case HTT_T2H_MSG_TYPE_EXT_STATS_CONF:
+		ath12k_debugfs_htt_ext_stats_handler(ab, skb);
 		break;
 	case HTT_T2H_MSG_TYPE_MLO_TIMESTAMP_OFFSET_IND:
 		ath12k_htt_mlo_offset_event_handler(ab, skb);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 2ff421160181..eb1f92559179 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -139,4 +139,8 @@ ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu);
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
 
+int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
+			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
+				       const void *ptr, void *data),
+			   void *data);
 #endif /* ATH12K_DP_RX_H */
-- 
2.34.1


