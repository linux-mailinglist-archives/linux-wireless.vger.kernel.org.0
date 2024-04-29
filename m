Return-Path: <linux-wireless+bounces-6998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE688B6042
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 19:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9CBB2039B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972001272B4;
	Mon, 29 Apr 2024 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V0NUsHIa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCB86AE3
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412320; cv=none; b=FSDndESNfHLk2UjXGWJB3yRpcWXL/wyVr2k+f2z68iIkKp5EtgZhEKlWvqkrHetQ8tXb7buqiXI9tbagxwbe+ZYVe9RlNUsKJs35PAVAyWaCzYLiJjWSo2rF3NxPcVM6jRDQ2052y7BrUejjAQVX6z+gTz5SuX7FS22agqlQ/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412320; c=relaxed/simple;
	bh=PJbf/yIS3qjkNlpa59dkkyCbrehMFkDFWgJcJBaA5lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcWrlmcx4oNVH6UkkXP384efMe4OVZT59VUGvwOvmreNuTYu3es5dnMjMoHFO34Hr3RjlOnq4W90MuIvGkuUHx0jfgR23+ghcTooH2hzy/izb6t+nk0OriSHCf2BXF6cVvZnpaWaJvuAniVIjIrq+HeOI39l91Rtdhey27MHe/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V0NUsHIa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TEMZsd027634;
	Mon, 29 Apr 2024 17:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=l8J6nR0
	oDVsLI2w41ksmTvWHnvc+fZY8Vy82KEjwCNw=; b=V0NUsHIaeuuaf0UTO1ZhSfr
	Q2+xR0/gRYRGkSrYu/1d2Qa+OzhNIRr9/MXm7DPsGifhNT9bUuOi+kXoSWVH6+l8
	zo3bgVIFWK2iIbSOmBpBQOw3qDvKhWUEqAFXyjg2b0aYv9tQpkvHgpzXR2zdAi9/
	PBkkXj9CpUtYsIcEnR/9WEGJAY74Ez2wG64eMnisyukJ5Y9yHiX5hTFTUgSpnaFX
	6ih8hls9DQyDCPn66uCp23giDxRFpm5eupKiaEbh9GcSAKmoz52++pUpT/6QUHQy
	aFENmpyzue9UQEyb2kTu1XUFnCQ+Af3+GjU23joRz4DdDq/rhySlIoT4S8JVW0A=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtd8kh3hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:38:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43THZNmB029386;
	Mon, 29 Apr 2024 17:38:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xrtekh4y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:38:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43THcRH5032198;
	Mon, 29 Apr 2024 17:38:27 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 43THcROf032188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 17:38:27 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 552FF4117D; Mon, 29 Apr 2024 23:08:26 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH 4/4] wifi: ath12k: Dump additional Tx PDEV HTT stats
Date: Mon, 29 Apr 2024 23:08:25 +0530
Message-Id: <20240429173825.2369355-5-quic_rgnanase@quicinc.com>
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
X-Proofpoint-GUID: G5KfW3q-B-xQ7smnOq4NIyHS5XB9Bjjw
X-Proofpoint-ORIG-GUID: G5KfW3q-B-xQ7smnOq4NIyHS5XB9Bjjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290113

Support to dump additional Tx PDEV stats through HTT stats debugfs.
Following stats dump are supported:
        1. PDEV control path stat to dump Tx management frame count
        2. Tx PDEV SIFS histogram stats
        3. Tx MU MIMO PPDU stats for 802.11ac, 802.11ax and 802.11be

Sample Output:
--------------
echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_TX_PDEV_STATS_CMN_TLV:
mac_id = 0
comp_delivered = 0
self_triggers = 13
......
......
HTT_TX_PDEV_STATS_CTRL_PATH_TX_STATS:
fw_tx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:1339, 9:0, 10:0, 11:0, 12:1, 13:0, 14:0, 15:0,

HTT_TX_PDEV_STATS_SIFS_HIST_TLV:
sifs_hist_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,

HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:
ac_mu_mimo_num_seq_posted_nr4 = 0
ac_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ac_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ac_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,

ac_mu_mimo_num_seq_posted_nr8 = 0
ac_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ac_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ac_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,

ax_mu_mimo_num_seq_posted_nr4 = 0
ax_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ax_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ax_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,

ax_mu_mimo_num_seq_posted_nr8 = 0
ax_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ax_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
ax_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,

be_mu_mimo_num_seq_posted_nr4 = 0
be_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
be_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
be_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,

be_mu_mimo_num_seq_posted_nr8 = 0
be_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
be_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
be_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0,

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 126 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  39 ++++++
 2 files changed, 165 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index d773456dae3a..50313af7ab7a 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -242,6 +242,123 @@ htt_print_tx_pdev_stats_sifs_tlv(const void *tag_buf,
 	stats_req->buf_len = len;
 }
 
+static inline void
+ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(const void *tag_buf,
+						struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv *htt_stats_buf = tag_buf;
+	char *mode;
+	u8 j, hw_mode, i, str_buf_len;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 stats_value;
+	u8 max_ppdu = ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST;
+	u8 max_sched = ATH12K_HTT_STATS_MAX_NUM_SCHED_STATUS;
+	char str_buf[ATH12K_HTT_MAX_STRING_LEN];
+
+	hw_mode = le32_to_cpu(htt_stats_buf->hw_mode);
+
+	switch (hw_mode) {
+	case ATH12K_HTT_STATS_HWMODE_AC:
+		len += scnprintf(buf + len, buf_len - len,
+				 "HTT_TX_PDEV_MU_PPDU_DISTRIBUTION_STATS:\n");
+		mode = "ac";
+		break;
+	case ATH12K_HTT_STATS_HWMODE_AX:
+		mode = "ax";
+		break;
+	case ATH12K_HTT_STATS_HWMODE_BE:
+		mode = "be";
+		break;
+	default:
+		return;
+	}
+
+	for (i = 0; i < ATH12K_HTT_STATS_NUM_NR_BINS ; i++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "%s_mu_mimo_num_seq_posted_nr%u = %u\n", mode,
+				 ((i + 1) * 4), htt_stats_buf->num_seq_posted[i]);
+		str_buf_len = 0;
+		memset(str_buf, 0x0, sizeof(str_buf));
+		for (j = 0; j < ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST ; j++) {
+			stats_value = le32_to_cpu(htt_stats_buf->num_ppdu_posted_per_burst
+						  [i * max_ppdu + j]);
+			str_buf_len += scnprintf(&str_buf[str_buf_len],
+						ATH12K_HTT_MAX_STRING_LEN - str_buf_len,
+						" %u:%u,", j, stats_value);
+		}
+		len += scnprintf(buf + len, buf_len - len,
+				 "%s_mu_mimo_num_ppdu_posted_per_burst_nr%u = %s\n",
+				 mode, ((i + 1) * 4), str_buf);
+		str_buf_len = 0;
+		memset(str_buf, 0x0, sizeof(str_buf));
+		for (j = 0; j < ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST ; j++) {
+			stats_value = le32_to_cpu(htt_stats_buf->num_ppdu_cmpl_per_burst
+						  [i * max_ppdu + j]);
+			str_buf_len += scnprintf(&str_buf[str_buf_len],
+						ATH12K_HTT_MAX_STRING_LEN - str_buf_len,
+						" %u:%u,", j, stats_value);
+		}
+		len += scnprintf(buf + len, buf_len - len,
+				 "%s_mu_mimo_num_ppdu_completed_per_burst_nr%u = %s\n",
+				 mode, ((i + 1) * 4), str_buf);
+		str_buf_len = 0;
+		memset(str_buf, 0x0, sizeof(str_buf));
+		for (j = 0; j < ATH12K_HTT_STATS_MAX_NUM_SCHED_STATUS ; j++) {
+			stats_value = le32_to_cpu(htt_stats_buf->num_seq_term_status
+						  [i * max_sched + j]);
+			str_buf_len += scnprintf(&str_buf[str_buf_len],
+						ATH12K_HTT_MAX_STRING_LEN - str_buf_len,
+						" %u:%u,", j, stats_value);
+		}
+		len += scnprintf(buf + len, buf_len - len,
+				 "%s_mu_mimo_num_seq_term_status_nr%u = %s\n\n",
+				 mode, ((i + 1) * 4), str_buf);
+	}
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+ath12k_htt_print_tx_pdev_stats_sifs_hist_tlv(const void *tag_buf,
+					     u16 tag_len,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_pdev_stats_sifs_hist_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      ATH12K_HTT_TX_PDEV_MAX_SIFS_BURST_HIST_STATS);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_STATS_SIFS_HIST_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "sifs_hist_status",
+				  htt_stats_buf->sifs_hist_status, num_elems);
+
+	stats_req->buf_len = len;
+}
+
+static inline void
+ath12k_htt_print_pdev_ctrl_path_tx_stats_tlv(const void *tag_buf,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_ctrl_path_tx_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_STATS_CTRL_PATH_TX_STATS:\n");
+	len += print_array_to_buf(buf, len, "fw_tx_mgmt_subtype",
+				 htt_stats_buf->fw_tx_mgmt_subtype,
+				 ATH12K_HTT_STATS_SUBTYPE_MAX);
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -261,6 +378,15 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_PDEV_FLUSH_TAG:
 		htt_print_tx_pdev_stats_flush_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_PDEV_SIFS_HIST_TAG:
+		ath12k_htt_print_tx_pdev_stats_sifs_hist_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG:
+		ath12k_htt_print_pdev_ctrl_path_tx_stats_tlv(tag_buf, stats_req);
+		break;
+	case HTT_STATS_MU_PPDU_DIST_TAG:
+		ath12k_htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(tag_buf, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 477ae75f8175..885630fdcb37 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -11,6 +11,8 @@
 #define ATH12K_HTT_STATS_COOKIE_LSB		GENMASK_ULL(31, 0)
 #define ATH12K_HTT_STATS_COOKIE_MSB		GENMASK_ULL(63, 32)
 #define ATH12K_HTT_STATS_MAGIC_VALUE		0xF0F0F0F0
+#define ATH12K_HTT_STATS_SUBTYPE_MAX		16
+#define ATH12K_HTT_MAX_STRING_LEN		256
 
 #define ATH12K_HTT_STATS_RESET_BITMAP32_OFFSET(_idx)	((_idx) & 0x1f)
 #define ATH12K_HTT_STATS_RESET_BITMAP64_OFFSET(_idx)	((_idx) & 0x3f)
@@ -133,6 +135,9 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_PDEV_UNDERRUN_TAG			= 1,
 	HTT_STATS_TX_PDEV_SIFS_TAG			= 2,
 	HTT_STATS_TX_PDEV_FLUSH_TAG			= 3,
+	HTT_STATS_TX_PDEV_SIFS_HIST_TAG			= 67,
+	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
+	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -142,6 +147,18 @@ enum ath12k_dbg_htt_tlv_tag {
 #define ATH12K_HTT_TX_PDEV_MAX_SIFS_BURST_STATS		9
 #define ATH12K_HTT_TX_PDEV_MAX_FLUSH_REASON_STATS	150
 
+/* MU MIMO distribution stats is a 2-dimensional array
+ * with dimension one denoting stats for nr4[0] or nr8[1]
+ */
+#define ATH12K_HTT_STATS_NUM_NR_BINS			2
+#define ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST	10
+#define ATH12K_HTT_TX_PDEV_MAX_SIFS_BURST_HIST_STATS	10
+#define ATH12K_HTT_STATS_MAX_NUM_SCHED_STATUS		9
+#define ATH12K_HTT_STATS_NUM_SCHED_STATUS_WORDS		\
+	(ATH12K_HTT_STATS_NUM_NR_BINS * ATH12K_HTT_STATS_MAX_NUM_SCHED_STATUS)
+#define ATH12K_HTT_STATS_MU_PPDU_PER_BURST_WORDS	\
+	(ATH12K_HTT_STATS_NUM_NR_BINS * ATH12K_HTT_STATS_MAX_NUM_MU_PPDU_PER_BURST)
+
 enum ath12k_htt_tx_pdev_underrun_enum {
 	HTT_STATS_TX_PDEV_NO_DATA_UNDERRUN		= 0,
 	HTT_STATS_TX_PDEV_DATA_UNDERRUN_BETWEEN_MPDU	= 1,
@@ -258,4 +275,26 @@ struct ath12k_htt_tx_pdev_stats_sifs_tlv {
 	DECLARE_FLEX_ARRAY(__le32, sifs_status);
 } __packed;
 
+struct ath12k_htt_pdev_ctrl_path_tx_stats_tlv {
+	__le32 fw_tx_mgmt_subtype[ATH12K_HTT_STATS_SUBTYPE_MAX];
+} __packed;
+
+struct ath12k_htt_tx_pdev_stats_sifs_hist_tlv {
+	DECLARE_FLEX_ARRAY(__le32, sifs_hist_status);
+} __packed;
+
+enum ath12k_htt_stats_hw_mode {
+	ATH12K_HTT_STATS_HWMODE_AC = 0,
+	ATH12K_HTT_STATS_HWMODE_AX = 1,
+	ATH12K_HTT_STATS_HWMODE_BE = 2,
+};
+
+struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv {
+	__le32 hw_mode;
+	__le32 num_seq_term_status[ATH12K_HTT_STATS_NUM_SCHED_STATUS_WORDS];
+	__le32 num_ppdu_cmpl_per_burst[ATH12K_HTT_STATS_MU_PPDU_PER_BURST_WORDS];
+	__le32 num_seq_posted[ATH12K_HTT_STATS_NUM_NR_BINS];
+	__le32 num_ppdu_posted_per_burst[ATH12K_HTT_STATS_MU_PPDU_PER_BURST_WORDS];
+} __packed;
+
 #endif
-- 
2.34.1


