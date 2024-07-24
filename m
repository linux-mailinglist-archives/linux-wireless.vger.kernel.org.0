Return-Path: <linux-wireless+bounces-10464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF593ABEF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 06:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6943B21E00
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 04:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D71CAA1;
	Wed, 24 Jul 2024 04:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KIoAWjMI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D768A1C6A7
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 04:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721795324; cv=none; b=E/d1wZSHbnYnN7ZJHe++nCfpQDzK1Wn7/xBhmJ6DVwIL5BI//d492q1Jp3jr81s9O20zMmjgIaR2OMMKz2Rn9rl8f0uUx2ODOYT+e9HrM3zsa7XLxiB8DehKUyWtEipPhbeeaYz9yXZufmTJBGNoOHDWk6vvpweH+cQ5qOhJeuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721795324; c=relaxed/simple;
	bh=V3qVXI6lJI/bC0I/16So/KO18VHrrx9/eU03AUFQCVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nr6H+XxvY60vi15kkzx/dFA+u6YSRv8HXQf24SLRZCbLWYFpopU7jUSA2AUTY+nrbEjhvKyArWnvllUUn3e2kcDfoOskmYnmp2b9VewZPvZS4BpFJtSHbKxsXZrLArTwV1zqhouPTQBw1sGLUWBdda4i4nU3LEAUAai8sZN67pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KIoAWjMI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NHevIX011010;
	Wed, 24 Jul 2024 04:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PrL5RGX2RLMZA5pLUV+dy6xuSDchD52B0Hv
	Pp81FacE=; b=KIoAWjMInI4ka999uOXp7RTqzWJrrSRbCrvQzPZcknaPQm6DgEA
	ixO9MLW0Y1um0tGbzS8TUzOdRQfH51ujiq6XRzKObbY305hMuyrLLXAmYzYkFBkD
	L27rdOtO21Q0LMjoHcbOtWmS4VPmTBoGl3PMhuHQiwIcYrqIisC4R9f/Aeny57D/
	qiB6+Dj4jFDM6wWlizxMHMM8kMrVuifjHbiTlGmKJo5a53zXSzteDAzM1jhaQ61b
	QFhJLEvY/bElT13ZyGY4tPwkDPMFUAkfu/ieHpNFPy6Rp5fQaoe5GjI/w/1ZwWQn
	U0puNs/jHU2vd+wShbobD6DlQUGZU9WIOUw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g2kn16hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 04:28:37 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46O4SXRK023169;
	Wed, 24 Jul 2024 04:28:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 40g6aky655-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 04:28:33 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46O4SX9F023163;
	Wed, 24 Jul 2024 04:28:33 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 46O4SXFq023162
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 04:28:33 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 9A86441107; Wed, 24 Jul 2024 09:58:32 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>
Subject: [PATCH] wifi: ath12k: Support transmit hardware queue stats
Date: Wed, 24 Jul 2024 09:58:09 +0530
Message-Id: <20240724042809.3716580-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: 0IwsTDMeT9iucij5mDUbReYB3DAI6Ap2
X-Proofpoint-GUID: 0IwsTDMeT9iucij5mDUbReYB3DAI6Ap2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_02,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240032

Add support to request firmware hardware stats through HTT
stats and display the stats information in debugfs.

Sample Output:
-------------
echo 3 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_reset
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats

HTT_TX_HWQ_STATS_CMN_TLV:
mac_id = 0
hwq_id = 0
xretry = 0
underrun_cnt = 42
flush_cnt = 0
filt_cnt = 0
null_mpdu_bmap = 0
user_ack_failure = 42
ack_tlv_proc = 0
sched_id_proc = 0
null_mpdu_tx_count = 42
mpdu_bmap_not_recvd = 0
num_bar = 0
rts = 0
cts2self = 0
qos_null = 0
mpdu_tried_cnt = 0
mpdu_queued_cnt = 42
mpdu_ack_fail_cnt = 0
mpdu_filt_cnt = 0
false_mpdu_ack_count = 0
txq_timeout = 0

HTT_TX_HWQ_CMD_RESULT_STATS_TLV:
cmd_result =  0:42, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0

HTT_TX_HWQ_CMD_STALL_STATS_TLV:
cmd_stall_status =  0:0, 1:0, 2:0, 3:0, 4:0

HTT_TX_HWQ_FES_RESULT_STATS_TLV:
fes_result =  0:42, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0

HTT_TX_HWQ_STATS_CMN_TLV:
mac_id = 0
hwq_id = 1
xretry = 0
underrun_cnt = 0
flush_cnt = 0
filt_cnt = 0
null_mpdu_bmap = 0
user_ack_failure = 0
ack_tlv_proc = 0
sched_id_proc = 0
null_mpdu_tx_count = 0
mpdu_bmap_not_recvd = 0
num_bar = 0
rts = 0
cts2self = 0
qos_null = 0
mpdu_tried_cnt = 0
mpdu_queued_cnt = 0
mpdu_ack_fail_cnt = 0
mpdu_filt_cnt = 0
false_mpdu_ack_count = 0
txq_timeout = 0

.....
.....

HTT_TX_HWQ_STATS_CMN_TLV:
mac_id = 0
hwq_id = 20
xretry = 0
underrun_cnt = 0
.....
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 164 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  46 +++++
 2 files changed, 210 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index f1b7e74aefe4..2d56d4d01c26 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1447,6 +1447,134 @@ ath12k_htt_print_tx_de_compl_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+htt_print_tx_hwq_stats_cmn_tlv(const void *tag_buf, u16 tag_len,
+			       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_hwq_stats_cmn_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_id_word;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id_word = le32_to_cpu(htt_stats_buf->mac_id__hwq_id__word);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_HWQ_STATS_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "hwq_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_HWQ_ID));
+	len += scnprintf(buf + len, buf_len - len, "xretry = %u\n",
+			 le32_to_cpu(htt_stats_buf->xretry));
+	len += scnprintf(buf + len, buf_len - len, "underrun_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->underrun_cnt));
+	len += scnprintf(buf + len, buf_len - len, "flush_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->flush_cnt));
+	len += scnprintf(buf + len, buf_len - len, "filt_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->filt_cnt));
+	len += scnprintf(buf + len, buf_len - len, "null_mpdu_bmap = %u\n",
+			 le32_to_cpu(htt_stats_buf->null_mpdu_bmap));
+	len += scnprintf(buf + len, buf_len - len, "user_ack_failure = %u\n",
+			 le32_to_cpu(htt_stats_buf->user_ack_failure));
+	len += scnprintf(buf + len, buf_len - len, "ack_tlv_proc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ack_tlv_proc));
+	len += scnprintf(buf + len, buf_len - len, "sched_id_proc = %u\n",
+			 le32_to_cpu(htt_stats_buf->sched_id_proc));
+	len += scnprintf(buf + len, buf_len - len, "null_mpdu_tx_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->null_mpdu_tx_count));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_bmap_not_recvd = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_bmap_not_recvd));
+	len += scnprintf(buf + len, buf_len - len, "num_bar = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_bar));
+	len += scnprintf(buf + len, buf_len - len, "rts = %u\n",
+			 le32_to_cpu(htt_stats_buf->rts));
+	len += scnprintf(buf + len, buf_len - len, "cts2self = %u\n",
+			 le32_to_cpu(htt_stats_buf->cts2self));
+	len += scnprintf(buf + len, buf_len - len, "qos_null = %u\n",
+			 le32_to_cpu(htt_stats_buf->qos_null));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_tried_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_tried_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_queued_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_queued_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_ack_fail_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_ack_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_filt_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_filt_cnt));
+	len += scnprintf(buf + len, buf_len - len, "false_mpdu_ack_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->false_mpdu_ack_count));
+	len += scnprintf(buf + len, buf_len - len, "txq_timeout = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->txq_timeout));
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_tx_hwq_cmd_result_stats_tlv(const void *tag_buf,
+				      u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_hwq_cmd_result_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+				    ATH12K_HTT_TX_HWQ_MAX_CMD_RESULT_STATS);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_HWQ_CMD_RESULT_STATS_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "cmd_result", htt_stats_buf->cmd_result,
+				  num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_tx_hwq_cmd_stall_stats_tlv(const void *tag_buf,
+				     u16 tag_len,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_hwq_cmd_stall_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+				    ATH12K_HTT_TX_HWQ_MAX_CMD_STALL_STATS);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_HWQ_CMD_STALL_STATS_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "cmd_stall_status",
+				  htt_stats_buf->cmd_stall_status,
+				  num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_tx_hwq_fes_result_stats_tlv(const void *tag_buf,
+				      u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_hwq_fes_result_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+				    ATH12K_HTT_TX_HWQ_MAX_FES_RESULT_STATS);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_HWQ_FES_RESULT_STATS_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "fes_result", htt_stats_buf->fes_result,
+				  num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -1552,6 +1680,18 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_DE_COMPL_STATS_TAG:
 		ath12k_htt_print_tx_de_compl_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_HWQ_CMN_TAG:
+		htt_print_tx_hwq_stats_cmn_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_HWQ_CMD_RESULT_TAG:
+		htt_print_tx_hwq_cmd_result_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_HWQ_CMD_STALL_TAG:
+		htt_print_tx_hwq_cmd_stall_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_HWQ_FES_STATUS_TAG:
+		htt_print_tx_hwq_fes_result_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
@@ -1683,6 +1823,24 @@ static const struct file_operations fops_htt_stats_type = {
 	.llseek = default_llseek,
 };
 
+static int ath12k_prep_htt_stats_cfg_params(struct ath12k *ar,
+					    enum ath12k_dbg_htt_ext_stats_type type,
+					    struct htt_ext_stats_cfg_params *cfg_params)
+{
+	if (!cfg_params)
+		return -EINVAL;
+
+	switch (type) {
+	case ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_HWQ:
+		cfg_params->cfg0 = HTT_STAT_DEFAULT_CFG0_ALL_HWQS;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int ath12k_debugfs_htt_stats_req(struct ath12k *ar)
 {
 	struct debug_htt_stats_req *stats_req = ar->debug.htt_stats.stats_req;
@@ -1703,6 +1861,12 @@ static int ath12k_debugfs_htt_stats_req(struct ath12k *ar)
 				 ATH12K_HTT_STATS_COOKIE_MSB);
 	cookie |= u64_encode_bits(pdev_id, ATH12K_HTT_STATS_COOKIE_LSB);
 
+	ret = ath12k_prep_htt_stats_cfg_params(ar, type, &cfg_params);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to set htt stats cfg params: %d\n", ret);
+		return ret;
+	}
+
 	if (stats_req->override_cfg_param) {
 		cfg_params.cfg0 = stats_req->cfg_param[0];
 		cfg_params.cfg1 = stats_req->cfg_param[1];
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index d52b26b23e65..525a8c615bfd 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -125,6 +125,7 @@ struct ath12k_htt_extd_stats_msg {
 enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_RESET		= 0,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX	= 1,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_HWQ	= 3,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED	= 4,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR	= 5,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM	= 6,
@@ -139,6 +140,10 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_PDEV_UNDERRUN_TAG			= 1,
 	HTT_STATS_TX_PDEV_SIFS_TAG			= 2,
 	HTT_STATS_TX_PDEV_FLUSH_TAG			= 3,
+	HTT_STATS_TX_HWQ_CMN_TAG			= 6,
+	HTT_STATS_TX_HWQ_CMD_RESULT_TAG			= 8,
+	HTT_STATS_TX_HWQ_CMD_STALL_TAG			= 9,
+	HTT_STATS_TX_HWQ_FES_STATUS_TAG			= 10,
 	HTT_STATS_TX_TQM_GEN_MPDU_TAG			= 11,
 	HTT_STATS_TX_TQM_LIST_MPDU_TAG			= 12,
 	HTT_STATS_TX_TQM_LIST_MPDU_CNT_TAG		= 13,
@@ -172,6 +177,7 @@ enum ath12k_dbg_htt_tlv_tag {
 };
 
 #define ATH12K_HTT_STATS_MAC_ID				GENMASK(7, 0)
+#define ATH12K_HTT_STATS_HWQ_ID				GENMASK(15, 8)
 
 #define ATH12K_HTT_TX_PDEV_MAX_SIFS_BURST_STATS		9
 #define ATH12K_HTT_TX_PDEV_MAX_FLUSH_REASON_STATS	150
@@ -690,4 +696,44 @@ struct ath12k_htt_tx_de_compl_stats_tlv {
 	__le32 tqm_bypass_frame;
 } __packed;
 
+#define ATH12K_HTT_TX_HWQ_MAX_CMD_RESULT_STATS		13
+#define ATH12K_HTT_TX_HWQ_MAX_CMD_STALL_STATS		5
+#define ATH12K_HTT_TX_HWQ_MAX_FES_RESULT_STATS		10
+
+struct ath12k_htt_tx_hwq_stats_cmn_tlv {
+	__le32 mac_id__hwq_id__word;
+	__le32 xretry;
+	__le32 underrun_cnt;
+	__le32 flush_cnt;
+	__le32 filt_cnt;
+	__le32 null_mpdu_bmap;
+	__le32 user_ack_failure;
+	__le32 ack_tlv_proc;
+	__le32 sched_id_proc;
+	__le32 null_mpdu_tx_count;
+	__le32 mpdu_bmap_not_recvd;
+	__le32 num_bar;
+	__le32 rts;
+	__le32 cts2self;
+	__le32 qos_null;
+	__le32 mpdu_tried_cnt;
+	__le32 mpdu_queued_cnt;
+	__le32 mpdu_ack_fail_cnt;
+	__le32 mpdu_filt_cnt;
+	__le32 false_mpdu_ack_count;
+	__le32 txq_timeout;
+} __packed;
+
+struct ath12k_htt_tx_hwq_cmd_result_stats_tlv {
+	DECLARE_FLEX_ARRAY(__le32, cmd_result);
+} __packed;
+
+struct ath12k_htt_tx_hwq_cmd_stall_stats_tlv {
+	DECLARE_FLEX_ARRAY(__le32, cmd_stall_status);
+} __packed;
+
+struct ath12k_htt_tx_hwq_fes_result_stats_tlv {
+	DECLARE_FLEX_ARRAY(__le32, fes_result);
+} __packed;
+
 #endif

base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
-- 
2.34.1


