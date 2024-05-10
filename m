Return-Path: <linux-wireless+bounces-7424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE698C1D93
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 07:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13447281810
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 05:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D915B152;
	Fri, 10 May 2024 05:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mIGLouoJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC6149C6A
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 05:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715317708; cv=none; b=c2/gnaLVl50l0gmT0CcJp2Ccy9g76ET4LAgaUzNqFkZGqlOL1ee3MFjFiFIIBu80GSSrv8JMRQ1BE12PMnf77Hg5+sh77+d7NzVHjsrZUEQPMe4mWXXq8QpZG37ii1C4zS7wdWeGzB14xPl/8RDTJDpRxqiEr5VrRdSYw2WVjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715317708; c=relaxed/simple;
	bh=OTPa/ezBkFrYShokGtEOFjt+h2EmWbg8tuFVy1ikhfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sax/E3aM4kZJETtThLoV9x78+mAj7pjn2Ngxsv6Lz7fYEFkx/BX00sINxo8MGp3kTh4b4rubwi4Z21vt5cLivEyuH8BAlFvR1lCqa6e09JUjIGi8NVixc/kpUCMLSgmmh2Ke4ZGSeSr9n8hclKdt0UZ3VHXQRT6jDQFZC2o7DDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mIGLouoJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2th5W000742;
	Fri, 10 May 2024 05:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=ECcDCvk
	QxXKd5fI3eSu3404fMwi7JW1/XM0h76p03OQ=; b=mIGLouoJq5JG53GnJq16XmO
	i2FKGUybg02zUReB0b39o32TfHk6IUSMecfZIUnx7XE91mj+TqmW0XkiOvq8qnKs
	QD47f5UwvY9jlJun/VOgOjMa9/1HaXRgGT2WiTejCpXouqEEkqv4UKhPaqAY+D/J
	2FUR2dUaptOFDMaME+SFMahLruiaXU2vL+Wq01WcoUJqvlhkYwWUNa4bYNMR0l3u
	cz/0cNYsBGG8YuMX6rrcrHN+npNZY7675e+VJ7+WaVUUyWjrCTdkcN+HtUpe2/72
	YmNdTToYtWxYPGi5NDVDbzQq/rNSC0Wf3PAnLGGRZoKQ951be/yv1CZsgZtqh5g=
	=
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w0rkgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:08:14 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44A58BC0031867;
	Fri, 10 May 2024 05:08:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3xwe3krc5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:08:11 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44A58BjT031861;
	Fri, 10 May 2024 05:08:11 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44A58A7d031856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 05:08:11 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 172C741198; Fri, 10 May 2024 10:38:09 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v2 5/5] wifi: ath12k: Dump additional Tx PDEV HTT stats
Date: Fri, 10 May 2024 10:38:06 +0530
Message-Id: <20240510050806.514126-6-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-GUID: ShGztngfHXhWSIEd20_3rc_wgGW6S_It
X-Proofpoint-ORIG-GUID: ShGztngfHXhWSIEd20_3rc_wgGW6S_It
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_03,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100034

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
fw_tx_mgmt_subtype =  0:1, 1:0, 2:0, 3:0, 4:38, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:1, 12:0, 13:7, 14:0, 15:0,

HTT_TX_PDEV_STATS_SIFS_HIST_TLV:
sifs_hist_status =  0:237, 1:185, 2:1, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,

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
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 126 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  39 ++++++
 2 files changed, 165 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 0be20e4f4097..b4b58e49c33b 100644
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


