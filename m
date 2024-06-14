Return-Path: <linux-wireless+bounces-8997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A1D9083B0
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 08:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587E4B23BF6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3636A144D38;
	Fri, 14 Jun 2024 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MjTODkh8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47914830A
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718346864; cv=none; b=NtHb9Pzx10t+fqDJZfHpLvt/ul2EFtCa3/4oYe84gULHluTltlp2ay7Spjdhr129YLFzyS7Z7tFJq4Rr1keE/RecNBhC+gqUp17cuDPsJEL4EUov7xveNlEA70dbvpDEZ5BvIsTaYWstDcnIEVFG1oDmUl1FZ+EaW4MvgefiGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718346864; c=relaxed/simple;
	bh=xn52Mqz+U9ktAS0doWUBapgesAGM4tmNzIDUFB4BoHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/AEO2nqD9SNnqYuaM3nlufNr3MApwFT6kKnV0SGVMrFnnTyiYIlK5LDcyJTbJILWgK6lzT2vlyUJwicv/GdMcxszMNEqGMHWyIbqHhbmeAjcFHn/8Q1bL038gkGR9CrACrL7y4UiE7Q//Po0sruAI1+zVdyEpoU6IejIFXp8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MjTODkh8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGP4E018602;
	Fri, 14 Jun 2024 06:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ro/VjG7Rnlo
	kZZCHLFqVS3Rzv/2lyJt7/nH2TsWcudk=; b=MjTODkh8jsiGWcwvSc8CI7VWQ8W
	To82EWrCrhJiLcDsuKLz7tjLkhVZ/XuXegzOMgMOPfAkPB9pW3I6zEWuDQ/oZq+0
	KW0BH8Ja4lsj69rlUckw9l6dlmrB99H4TMH0+4HBwXl/pmeAvistysbBZFKRKJJs
	5mcmzpokPN7Q0FdcHkmcg/wLUg7i1kHduxYgoB0R3UPdEBmAysinvr2JvScIjye1
	swb3kM3RDOeTSyTIQga/eX9tFO0bmSbR71sia49fWl8Uioo8Cg795FKB4Y9uOve3
	5PnY0Pds6RuwxpfjoR7knvrTGIT/XhDS8KUd4KYoUNNHV+oNP+rIgkORabQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q416ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 06:34:18 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 45E6YBAJ026770;
	Fri, 14 Jun 2024 06:34:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3yn1s6n07w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 06:34:15 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45E6YFOZ026829;
	Fri, 14 Jun 2024 06:34:15 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 45E6YF9K026828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 06:34:15 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 4C5DA4112C; Fri, 14 Jun 2024 12:04:14 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH v5 4/4] wifi: ath12k: Dump additional Tx PDEV HTT stats
Date: Fri, 14 Jun 2024 12:04:04 +0530
Message-Id: <20240614063404.2659089-5-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614063404.2659089-1-quic_rgnanase@quicinc.com>
References: <20240614063404.2659089-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-GUID: c9lZbWnDqe6hezdJHLkINLpKity-TSYR
X-Proofpoint-ORIG-GUID: c9lZbWnDqe6hezdJHLkINLpKity-TSYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140043

Support to dump additional Tx PDEV stats through HTT stats debugfs.
Following stats dump are supported:
        1. PDEV control path stat to dump Tx management frame count
        2. Tx PDEV SIFS histogram stats
        3. Tx MU MIMO PPDU stats for 802.11ac, 802.11ax and 802.11be

Sample Output:
---------------
echo 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats

HTT_TX_PDEV_STATS_CMN_TLV:
mac_id = 0
comp_delivered = 0
self_triggers = 13
......
......
HTT_TX_PDEV_STATS_CTRL_PATH_TX_STATS:
fw_tx_mgmt_subtype =  0:1, 1:0, 2:0, 3:0, 4:38, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:1, 12:0, 13:7, 14:0, 15:0

HTT_TX_PDEV_STATS_SIFS_HIST_TLV:
sifs_hist_status =  0:237, 1:185, 2:1, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0

HTT_TX_PDEV_AC_MU_PPDU_DISTRIBUTION_STATS:
ac_mu_mimo_num_seq_posted_nr4 = 0
ac_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
ac_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
ac_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0

ac_mu_mimo_num_seq_posted_nr8 = 0
ac_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
ac_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
ac_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0

HTT_TX_PDEV_AX_MU_PPDU_DISTRIBUTION_STATS:
ax_mu_mimo_num_seq_posted_nr4 = 0
ax_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
ax_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
ax_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0

ax_mu_mimo_num_seq_posted_nr8 = 0
ax_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
ax_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
ax_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0

HTT_TX_PDEV_BE_MU_PPDU_DISTRIBUTION_STATS:
be_mu_mimo_num_seq_posted_nr4 = 0
be_mu_mimo_num_ppdu_posted_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
be_mu_mimo_num_ppdu_completed_per_burst_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
be_mu_mimo_num_seq_term_status_nr4 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0

be_mu_mimo_num_seq_posted_nr8 = 0
be_mu_mimo_num_ppdu_posted_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
be_mu_mimo_num_ppdu_completed_per_burst_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0
be_mu_mimo_num_seq_term_status_nr8 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 142 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  39 +++++
 2 files changed, 181 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index dd7db007b60b..03476868df50 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -249,6 +249,139 @@ htt_print_tx_pdev_stats_sifs_tlv(const void *tag_buf,
 	stats_req->buf_len = len;
 }
 
+static void
+htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(const void *tag_buf, u16 tag_len,
+					 struct debug_htt_stats_req *stats_req)
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
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	hw_mode = le32_to_cpu(htt_stats_buf->hw_mode);
+
+	switch (hw_mode) {
+	case ATH12K_HTT_STATS_HWMODE_AC:
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nHTT_TX_PDEV_AC_MU_PPDU_DISTRIBUTION_STATS:\n");
+		mode = "ac";
+		break;
+	case ATH12K_HTT_STATS_HWMODE_AX:
+		len += scnprintf(buf + len, buf_len - len,
+				 "HTT_TX_PDEV_AX_MU_PPDU_DISTRIBUTION_STATS:\n");
+		mode = "ax";
+		break;
+	case ATH12K_HTT_STATS_HWMODE_BE:
+		len += scnprintf(buf + len, buf_len - len,
+				 "HTT_TX_PDEV_BE_MU_PPDU_DISTRIBUTION_STATS:\n");
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
+		/* To overwrite the last trailing comma */
+		str_buf[str_buf_len - 1] = '\0';
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
+		/* To overwrite the last trailing comma */
+		str_buf[str_buf_len - 1] = '\0';
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
+		/* To overwrite the last trailing comma */
+		str_buf[str_buf_len - 1] = '\0';
+		len += scnprintf(buf + len, buf_len - len,
+				 "%s_mu_mimo_num_seq_term_status_nr%u = %s\n\n",
+				 mode, ((i + 1) * 4), str_buf);
+	}
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_tx_pdev_stats_sifs_hist_tlv(const void *tag_buf,
+				      u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_pdev_stats_sifs_hist_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      ATH12K_HTT_TX_PDEV_MAX_SIFS_BURST_HIST_STATS);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "\nHTT_TX_PDEV_STATS_SIFS_HIST_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "sifs_hist_status",
+				  htt_stats_buf->sifs_hist_status, num_elems);
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_pdev_ctrl_path_tx_stats_tlv(const void *tag_buf, u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_ctrl_path_tx_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "\nHTT_TX_PDEV_STATS_CTRL_PATH_TX_STATS:\n");
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
@@ -268,6 +401,15 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_PDEV_FLUSH_TAG:
 		htt_print_tx_pdev_stats_flush_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_PDEV_SIFS_HIST_TAG:
+		htt_print_tx_pdev_stats_sifs_hist_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG:
+		htt_print_pdev_ctrl_path_tx_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_MU_PPDU_DIST_TAG:
+		htt_print_tx_pdev_mu_ppdu_dist_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 83060c54d00b..878d9cf6e7cb 100644
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


