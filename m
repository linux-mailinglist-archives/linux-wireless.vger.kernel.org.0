Return-Path: <linux-wireless+bounces-10495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD99493BC18
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 07:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9881B283A35
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 05:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857217C91;
	Thu, 25 Jul 2024 05:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lp81u9TH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6D1CA9E
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721886176; cv=none; b=B2kx+kmxEWSNGTno+vDJq41kvJelqeTk4zTAIPIYCs3PDN3xTg0I8nt5ghgLN4DMozxu/OimtrNxCgTsUNXiWkzXuYq+QvfTJGM+Lh2byZrgdRL0tYdZJlHOUV7PTEXnTQHqA6/3OPx+oyOILrS6mvbwKB9sB4NnTjgJXd5ypgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721886176; c=relaxed/simple;
	bh=RvgtmBEXbWJfyyFg5N2tJxX68c8NQ8amP3pXlCyeB34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pVXRrMxD9JROY0+2j9TN5xvSimxCDULneE1NY2blR5ksBeYhkN9RVSEaZ6YVBijFBbK/XvqP9Z5MdTOfUO8S8BFSnDh8poy5MxctoAc5E9UsMkfJ9dW/esM1HyVFQ7KdeJtNSRGRheN+QjXZieBedhl9867aYtXQYK+qoG06I7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lp81u9TH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OL5Wko010739;
	Thu, 25 Jul 2024 05:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=B+UoGKYw4Hv4Bm9jT2/68czivVK4mDm2BVG
	lE1CaXSo=; b=Lp81u9THA01yWIcRfntlp+MR6k1+h5Qf8P/FhcwHVYPW6lC3jtc
	HKcLmATfhWluIV8jOz/8TenAnqMdbOcLtbIy94e3jxMKLRlrRPr+HdJhNvpqg+oH
	gW3cBfrZWdNh/tmLThrZrERSYs5bxyHXTbxOTJOLkp6cj7QP55P0lUgbWGII9TrW
	Do/knigfMvg/21spetNnTOqm9dtJ2tDFPqCkUoLKHYIYO06XedVWCQt6vQJ02hsF
	Op01DfxnU3klhvLLllM921ypm4wb1jpvanuy7fZ3sK4Sv8ThsTYyiaGCQfjKxU/M
	C7Nsazx13ojW3SI0gvOTLvVa89UG2Q8NbDw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g4jh3yqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 05:42:40 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46P5ga1E011262;
	Thu, 25 Jul 2024 05:42:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40g6ama8q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 05:42:36 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46P5gahV011257;
	Thu, 25 Jul 2024 05:42:36 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-rgnanase-blr.qualcomm.com [10.190.106.79])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 46P5ga0L011256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 05:42:36 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 2378837)
	id 3DF1D4113B; Thu, 25 Jul 2024 11:12:35 +0530 (+0530)
From: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Dinesh Karthikeyan <quic_dinek@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH] wifi: ath12k: Support Rx PDEV HTT stats
Date: Thu, 25 Jul 2024 11:12:27 +0530
Message-Id: <20240725054227.986851-1-quic_rgnanase@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4ct_vhrjS8Xt7Sv9qfVkWoRbQFRwwkij
X-Proofpoint-GUID: 4ct_vhrjS8Xt7Sv9qfVkWoRbQFRwwkij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_05,2024-07-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250035

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to parse and dump the Rx PDEV related stats such as
SOC stats, PHY error, MPDU error through htt stats type 2.

Sample output:
-------------
echo 2 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats

HTT_RX_PDEV_FW_STATS_TLV:
mac_id = 0
ppdu_recvd = 215
mpdu_cnt_fcs_ok = 215
mpdu_cnt_fcs_err = 0
tcp_msdu_cnt = 0
tcp_ack_msdu_cnt = 0
udp_msdu_cnt = 0
other_msdu_cnt = 215
fw_ring_mpdu_ind = 215
fw_ring_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:21, 5:1, 6:0, 7:0, 8:193, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
fw_ring_ctrl_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
fw_ring_mcast_data_msdu = 0
fw_ring_bcast_data_msdu = 0
fw_ring_ucast_data_msdu = 0
fw_ring_null_data_msdu = 0
fw_ring_mpdu_drop = 0
ofld_local_data_ind_cnt = 0
ofld_local_data_buf_recycle_cnt = 0
drx_local_data_ind_cnt = 0
drx_local_data_buf_recycle_cnt = 0
local_nondata_ind_cnt = 215
local_nondata_buf_recycle_cnt = 215
fw_status_buf_ring_refill_cnt = 215
fw_status_buf_ring_empty_cnt = 0
fw_pkt_buf_ring_refill_cnt = 215
fw_pkt_buf_ring_empty_cnt = 0
fw_link_buf_ring_refill_cnt = 215
fw_link_buf_ring_empty_cnt = 0
host_pkt_buf_ring_refill_cnt = 0
host_pkt_buf_ring_empty_cnt = 0
mon_pkt_buf_ring_refill_cnt = 0
mon_pkt_buf_ring_empty_cnt = 0
mon_status_buf_ring_refill_cnt = 0
mon_status_buf_ring_empty_cnt = 0
mon_desc_buf_ring_refill_cnt = 0
mon_desc_buf_ring_empty_cnt = 0
mon_dest_ring_update_cnt = 0
mon_dest_ring_full_cnt = 0
rx_suspend_cnt = 0
rx_resume_fail_cnt = 0
rx_ring_switch_cnt = 0
rx_ring_restore_cnt = 0
rx_flush_cnt = 0
rx_recovery_reset_cnt = 0

HTT_RX_PDEV_FW_RING_MPDU_ERR_TLV:
fw_ring_mpdu_err =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0

HTT_RX_PDEV_FW_MPDU_DROP_TLV:
fw_mpdu_drop =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0

HTT_RX_SOC_FW_STATS_TLV:
fw_reo_ring_data_msdu = 0
fw_to_host_data_msdu_bcmc = 0
fw_to_host_data_msdu_uc = 0
ofld_remote_data_buf_recycle_cnt = 0
ofld_remote_free_buf_indication_cnt = 0
ofld_buf_to_host_data_msdu_uc = 0
reo_fw_ring_to_host_data_msdu_uc = 0
wbm_sw_ring_reap = 0
wbm_forward_to_host_cnt = 0
wbm_target_recycle_cnt = 0
target_refill_ring_recycle_cnt = 0

HTT_RX_SOC_FW_REFILL_RING_EMPTY_TLV:
refill_ring_empty_cnt =  0:0, 1:0, 2:0, 3:0

HTT_RX_SOC_FW_REFILL_RING_NUM_REFILL_TLV:
refill_ring_num_refill =  0:0, 1:0, 2:0, 3:0

HTT_RX_SOC_FW_REFILL_RING_NUM_RXDMA_ERR_TLV:
rxdma_err =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0

HTT_RX_SOC_FW_REFILL_RING_NUM_REO_ERR_TLV:
reo_err =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0

HTT_RX_PDEV_FW_STATS_PHY_ERR_TLV:
mac_id_word = 0
total_phy_err_nct = 0
phy_errs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0, 38:0, 39:0, 40:0, 41:0, 42:0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/debugfs.h     |   2 +
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 342 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 138 +++++++
 3 files changed, 482 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
index 8d64ba03aa9a..00b34e00cdf2 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs.h
@@ -7,6 +7,8 @@
 #ifndef _ATH12K_DEBUGFS_H_
 #define _ATH12K_DEBUGFS_H_
 
+#define IEEE80211_MGMT_FRAME_SUBTYPE_MAX	16
+
 #ifdef CONFIG_ATH12K_DEBUGFS
 void ath12k_debugfs_soc_create(struct ath12k_base *ab);
 void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index f1b7e74aefe4..c2b0bb134c11 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1447,6 +1447,320 @@ ath12k_htt_print_tx_de_compl_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void htt_print_rx_pdev_fw_stats_tlv(const void *tag_buf, u16 tag_len,
+					   struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_pdev_fw_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_id_word;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id_word =  __le32_to_cpu(htt_stats_buf->mac_id_word);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %d\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "ppdu_recvd = %u\n",
+			 le32_to_cpu(htt_stats_buf->ppdu_recvd));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_cnt_fcs_ok = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_cnt_fcs_ok));
+	len += scnprintf(buf + len, buf_len - len, "mpdu_cnt_fcs_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->mpdu_cnt_fcs_err));
+	len += scnprintf(buf + len, buf_len - len, "tcp_msdu_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tcp_msdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "tcp_ack_msdu_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tcp_ack_msdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "udp_msdu_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->udp_msdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "other_msdu_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->other_msdu_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mpdu_ind = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_ring_mpdu_ind));
+
+	len += print_array_to_buf(buf, len, "fw_ring_mgmt_subtype",
+				  htt_stats_buf->fw_ring_mgmt_subtype,
+				  IEEE80211_MGMT_FRAME_SUBTYPE_MAX, "\n");
+
+	len += print_array_to_buf(buf, len, "fw_ring_ctrl_subtype",
+				  htt_stats_buf->fw_ring_ctrl_subtype,
+				  IEEE80211_MGMT_FRAME_SUBTYPE_MAX, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mcast_data_msdu = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_ring_mcast_data_msdu));
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_bcast_data_msdu = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_ring_bcast_data_msdu));
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_ucast_data_msdu = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_ring_ucast_data_msdu));
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_null_data_msdu = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_ring_null_data_msdu));
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mpdu_drop = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_ring_mpdu_drop));
+	len += scnprintf(buf + len, buf_len - len, "ofld_local_data_ind_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->ofld_local_data_ind_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ofld_local_data_buf_recycle_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->ofld_local_data_buf_recycle_cnt));
+	len += scnprintf(buf + len, buf_len - len, "drx_local_data_ind_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->drx_local_data_ind_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "drx_local_data_buf_recycle_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->drx_local_data_buf_recycle_cnt));
+	len += scnprintf(buf + len, buf_len - len, "local_nondata_ind_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->local_nondata_ind_cnt));
+	len += scnprintf(buf + len, buf_len - len, "local_nondata_buf_recycle_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->local_nondata_buf_recycle_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_status_buf_ring_refill_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_status_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_status_buf_ring_empty_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_status_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_pkt_buf_ring_refill_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_pkt_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_pkt_buf_ring_empty_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_pkt_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_link_buf_ring_refill_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_link_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "fw_link_buf_ring_empty_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_link_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "host_pkt_buf_ring_refill_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->host_pkt_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "host_pkt_buf_ring_empty_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->host_pkt_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_pkt_buf_ring_refill_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mon_pkt_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_pkt_buf_ring_empty_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mon_pkt_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "mon_status_buf_ring_refill_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mon_status_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_status_buf_ring_empty_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mon_status_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_desc_buf_ring_refill_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mon_desc_buf_ring_refill_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_desc_buf_ring_empty_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mon_desc_buf_ring_empty_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_dest_ring_update_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mon_dest_ring_update_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mon_dest_ring_full_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mon_dest_ring_full_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_suspend_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_suspend_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_resume_fail_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_resume_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_ring_switch_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_ring_switch_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_ring_restore_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_ring_restore_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_flush_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_flush_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_recovery_reset_cnt = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->rx_recovery_reset_cnt));
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_rx_pdev_fw_ring_mpdu_err_tlv(const void *tag_buf, u16 tag_len,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_pdev_fw_ring_mpdu_err_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      ATH12K_HTT_RX_STATS_RXDMA_MAX_ERR);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_PDEV_FW_RING_MPDU_ERR_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "fw_ring_mpdu_err",
+				  htt_stats_buf->fw_ring_mpdu_err,
+				  num_elems, "\n\n");
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_rx_pdev_fw_mpdu_drop_tlv(const void *tag_buf,
+				   u16 tag_len,
+				   struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_pdev_fw_mpdu_drop_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      ATH12K_HTT_RX_STATS_FW_DROP_REASON_MAX);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_FW_MPDU_DROP_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "fw_mpdu_drop",
+				  htt_stats_buf->fw_mpdu_drop,
+				  num_elems, "\n\n");
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_rx_soc_fw_stats_tlv(const void *tag_buf, u16 tag_len,
+			      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_soc_fw_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_SOC_FW_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "fw_reo_ring_data_msdu = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_reo_ring_data_msdu));
+	len += scnprintf(buf + len, buf_len - len, "fw_to_host_data_msdu_bcmc = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_to_host_data_msdu_bcmc));
+	len += scnprintf(buf + len, buf_len - len, "fw_to_host_data_msdu_uc = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw_to_host_data_msdu_uc));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ofld_remote_data_buf_recycle_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->ofld_remote_data_buf_recycle_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ofld_remote_free_buf_indication_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->ofld_remote_free_buf_indication_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ofld_buf_to_host_data_msdu_uc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ofld_buf_to_host_data_msdu_uc));
+	len += scnprintf(buf + len, buf_len - len,
+			 "reo_fw_ring_to_host_data_msdu_uc = %u\n",
+			 le32_to_cpu(htt_stats_buf->reo_fw_ring_to_host_data_msdu_uc));
+	len += scnprintf(buf + len, buf_len - len, "wbm_sw_ring_reap = %u\n",
+			 le32_to_cpu(htt_stats_buf->wbm_sw_ring_reap));
+	len += scnprintf(buf + len, buf_len - len, "wbm_forward_to_host_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->wbm_forward_to_host_cnt));
+	len += scnprintf(buf + len, buf_len - len, "wbm_target_recycle_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->wbm_target_recycle_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "target_refill_ring_recycle_cnt = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->target_refill_ring_recycle_cnt));
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_rx_soc_fw_refill_ring_empty_tlv(const void *tag_buf,
+					  u16 tag_len,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_soc_fw_refill_ring_empty_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+			      ATH12K_HTT_RX_STATS_REFILL_MAX_RING);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_SOC_FW_REFILL_RING_EMPTY_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "refill_ring_empty_cnt",
+				  htt_stats_buf->refill_ring_empty_cnt,
+				  num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_rx_soc_fw_refill_ring_num_refill_tlv(const void *tag_buf,
+					       u16 tag_len,
+					       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_soc_fw_refill_ring_num_refill_tlv *htt_stats_buf =
+									tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2),
+				    ATH12K_HTT_RX_STATS_REFILL_MAX_RING);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_SOC_FW_REFILL_RING_NUM_REFILL_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "refill_ring_num_refill",
+			   htt_stats_buf->refill_ring_num_refill,
+			   num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_rx_soc_fw_refill_ring_num_rxdma_err_tlv(const void *tag_buf,
+						  u16 tag_len,
+						  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_soc_fw_refill_ring_num_rxdma_err_tlv *htt_stats_buf =
+		tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2), ATH12K_HTT_RX_RXDMA_MAX_ERR_CODE);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_SOC_FW_REFILL_RING_NUM_RXDMA_ERR_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "rxdma_err", htt_stats_buf->rxdma_err,
+				  num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_rx_soc_fw_refill_ring_num_reo_err_tlv(const void *tag_buf,
+						u16 tag_len,
+						struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_soc_fw_refill_ring_num_reo_err_tlv *htt_stats_buf =
+									tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = min_t(u16, (tag_len >> 2), ATH12K_HTT_RX_REO_MAX_ERR_CODE);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_SOC_FW_REFILL_RING_NUM_REO_ERR_TLV:\n");
+
+	len += print_array_to_buf(buf, len, "reo_err", htt_stats_buf->reo_err,
+				  num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+htt_print_rx_pdev_fw_stats_phy_err_tlv(const void *tag_buf, u16 tag_len,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_pdev_fw_stats_phy_err_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_id_word;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id_word = __le32_to_cpu(htt_stats_buf->mac_id__word);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_PDEV_FW_STATS_PHY_ERR_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id_word = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "total_phy_err_nct = %u\n",
+			 le32_to_cpu(htt_stats_buf->total_phy_err_cnt));
+
+	len += print_array_to_buf(buf, len, "phy_errs", htt_stats_buf->phy_err,
+				  ATH12K_HTT_STATS_PHY_ERR_MAX, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -1552,6 +1866,34 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_DE_COMPL_STATS_TAG:
 		ath12k_htt_print_tx_de_compl_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_RX_REFILL_RXDMA_ERR_TAG:
+		htt_print_rx_soc_fw_refill_ring_num_rxdma_err_tlv(tag_buf, len,
+								  stats_req);
+		break;
+	case HTT_STATS_RX_REFILL_REO_ERR_TAG:
+		htt_print_rx_soc_fw_refill_ring_num_reo_err_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_RX_PDEV_FW_STATS_PHY_ERR_TAG:
+		htt_print_rx_pdev_fw_stats_phy_err_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_RX_PDEV_FW_STATS_TAG:
+		htt_print_rx_pdev_fw_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_RX_PDEV_FW_RING_MPDU_ERR_TAG:
+		htt_print_rx_pdev_fw_ring_mpdu_err_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_RX_PDEV_FW_MPDU_DROP_TAG:
+		htt_print_rx_pdev_fw_mpdu_drop_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_RX_SOC_FW_STATS_TAG:
+		htt_print_rx_soc_fw_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_RX_SOC_FW_REFILL_RING_EMPTY_TAG:
+		htt_print_rx_soc_fw_refill_ring_empty_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_RX_SOC_FW_REFILL_RING_NUM_REFILL_TAG:
+		htt_print_rx_soc_fw_refill_ring_num_refill_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index d52b26b23e65..c411e7da4e09 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -7,6 +7,8 @@
 #ifndef DEBUG_HTT_STATS_H
 #define DEBUG_HTT_STATS_H
 
+#include "debugfs.h"
+
 #define ATH12K_HTT_STATS_BUF_SIZE		(1024 * 512)
 #define ATH12K_HTT_STATS_COOKIE_LSB		GENMASK_ULL(31, 0)
 #define ATH12K_HTT_STATS_COOKIE_MSB		GENMASK_ULL(63, 32)
@@ -125,6 +127,7 @@ struct ath12k_htt_extd_stats_msg {
 enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_RESET		= 0,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX	= 1,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_RX	= 2,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED	= 4,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR	= 5,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM	= 6,
@@ -151,6 +154,12 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_DE_ENQUEUE_PACKETS_TAG		= 21,
 	HTT_STATS_TX_DE_ENQUEUE_DISCARD_TAG		= 22,
 	HTT_STATS_TX_DE_CMN_TAG				= 23,
+	HTT_STATS_RX_PDEV_FW_STATS_TAG			= 28,
+	HTT_STATS_RX_PDEV_FW_RING_MPDU_ERR_TAG		= 29,
+	HTT_STATS_RX_PDEV_FW_MPDU_DROP_TAG		= 30,
+	HTT_STATS_RX_SOC_FW_STATS_TAG			= 31,
+	HTT_STATS_RX_SOC_FW_REFILL_RING_EMPTY_TAG	= 32,
+	HTT_STATS_RX_SOC_FW_REFILL_RING_NUM_REFILL_TAG	= 33,
 	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG	= 36,
 	HTT_STATS_TX_SCHED_CMN_TAG			= 37,
 	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,
@@ -161,6 +170,9 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_DE_COMPL_STATS_TAG			= 65,
 	HTT_STATS_WHAL_TX_TAG				= 66,
 	HTT_STATS_TX_PDEV_SIFS_HIST_TAG			= 67,
+	HTT_STATS_RX_PDEV_FW_STATS_PHY_ERR_TAG          = 68,
+	HTT_STATS_RX_REFILL_RXDMA_ERR_TAG               = 77,
+	HTT_STATS_RX_REFILL_REO_ERR_TAG                 = 78,
 	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG		= 86,
 	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG	= 87,
 	HTT_STATS_HW_WAR_TAG				= 89,
@@ -690,4 +702,130 @@ struct ath12k_htt_tx_de_compl_stats_tlv {
 	__le32 tqm_bypass_frame;
 } __packed;
 
+struct ath12k_htt_rx_pdev_fw_stats_tlv {
+	__le32 mac_id_word;
+	__le32 ppdu_recvd;
+	__le32 mpdu_cnt_fcs_ok;
+	__le32 mpdu_cnt_fcs_err;
+	__le32 tcp_msdu_cnt;
+	__le32 tcp_ack_msdu_cnt;
+	__le32 udp_msdu_cnt;
+	__le32 other_msdu_cnt;
+	__le32 fw_ring_mpdu_ind;
+	__le32 fw_ring_mgmt_subtype[IEEE80211_MGMT_FRAME_SUBTYPE_MAX];
+	__le32 fw_ring_ctrl_subtype[IEEE80211_MGMT_FRAME_SUBTYPE_MAX];
+	__le32 fw_ring_mcast_data_msdu;
+	__le32 fw_ring_bcast_data_msdu;
+	__le32 fw_ring_ucast_data_msdu;
+	__le32 fw_ring_null_data_msdu;
+	__le32 fw_ring_mpdu_drop;
+	__le32 ofld_local_data_ind_cnt;
+	__le32 ofld_local_data_buf_recycle_cnt;
+	__le32 drx_local_data_ind_cnt;
+	__le32 drx_local_data_buf_recycle_cnt;
+	__le32 local_nondata_ind_cnt;
+	__le32 local_nondata_buf_recycle_cnt;
+
+	__le32 fw_status_buf_ring_refill_cnt;
+	__le32 fw_status_buf_ring_empty_cnt;
+	__le32 fw_pkt_buf_ring_refill_cnt;
+	__le32 fw_pkt_buf_ring_empty_cnt;
+	__le32 fw_link_buf_ring_refill_cnt;
+	__le32 fw_link_buf_ring_empty_cnt;
+	__le32 host_pkt_buf_ring_refill_cnt;
+	__le32 host_pkt_buf_ring_empty_cnt;
+	__le32 mon_pkt_buf_ring_refill_cnt;
+	__le32 mon_pkt_buf_ring_empty_cnt;
+	__le32 mon_status_buf_ring_refill_cnt;
+	__le32 mon_status_buf_ring_empty_cnt;
+	__le32 mon_desc_buf_ring_refill_cnt;
+	__le32 mon_desc_buf_ring_empty_cnt;
+	__le32 mon_dest_ring_update_cnt;
+	__le32 mon_dest_ring_full_cnt;
+
+	__le32 rx_suspend_cnt;
+	__le32 rx_suspend_fail_cnt;
+	__le32 rx_resume_cnt;
+	__le32 rx_resume_fail_cnt;
+	__le32 rx_ring_switch_cnt;
+	__le32 rx_ring_restore_cnt;
+	__le32 rx_flush_cnt;
+	__le32 rx_recovery_reset_cnt;
+} __packed;
+
+#define ATH12K_HTT_RX_STATS_RXDMA_MAX_ERR	16
+
+struct ath12k_htt_rx_pdev_fw_ring_mpdu_err_tlv {
+	DECLARE_FLEX_ARRAY(__le32, fw_ring_mpdu_err);
+} __packed;
+
+#define ATH12K_HTT_RX_STATS_FW_DROP_REASON_MAX	16
+struct ath12k_htt_rx_pdev_fw_mpdu_drop_tlv {
+	DECLARE_FLEX_ARRAY(__le32, fw_mpdu_drop);
+};
+
+struct ath12k_htt_rx_soc_fw_stats_tlv {
+	__le32 fw_reo_ring_data_msdu;
+	__le32 fw_to_host_data_msdu_bcmc;
+	__le32 fw_to_host_data_msdu_uc;
+	__le32 ofld_remote_data_buf_recycle_cnt;
+	__le32 ofld_remote_free_buf_indication_cnt;
+	__le32 ofld_buf_to_host_data_msdu_uc;
+	__le32 reo_fw_ring_to_host_data_msdu_uc;
+	__le32 wbm_sw_ring_reap;
+	__le32 wbm_forward_to_host_cnt;
+	__le32 wbm_target_recycle_cnt;
+	__le32 target_refill_ring_recycle_cnt;
+} __packed;
+
+#define ATH12K_HTT_RX_STATS_REFILL_MAX_RING	4
+
+struct ath12k_htt_rx_soc_fw_refill_ring_num_refill_tlv {
+	DECLARE_FLEX_ARRAY(__le32, refill_ring_num_refill);
+} __packed;
+
+struct ath12k_htt_rx_soc_fw_refill_ring_empty_tlv {
+	DECLARE_FLEX_ARRAY(__le32, refill_ring_empty_cnt);
+} __packed;
+
+#define ATH12K_HTT_RX_RXDMA_MAX_ERR_CODE	16
+struct ath12k_htt_rx_soc_fw_refill_ring_num_rxdma_err_tlv {
+	DECLARE_FLEX_ARRAY(__le32, rxdma_err);
+} __packed;
+
+enum ath12k_htt_rx_reo_error_code_enum {
+	HTT_RX_REO_QUEUE_DESC_ADDR_ZERO		= 0,
+	HTT_RX_REO_QUEUE_DESC_NOT_VALID		= 1,
+	HTT_RX_AMPDU_IN_NON_BA			= 2,
+	HTT_RX_NON_BA_DUPLICATE			= 3,
+	HTT_RX_BA_DUPLICATE			= 4,
+	HTT_RX_REGULAR_FRAME_2K_JUMP		= 5,
+	HTT_RX_BAR_FRAME_2K_JUMP		= 6,
+	HTT_RX_REGULAR_FRAME_OOR		= 7,
+	HTT_RX_BAR_FRAME_OOR			= 8,
+	HTT_RX_BAR_FRAME_NO_BA_SESSION		= 9,
+	HTT_RX_BAR_FRAME_SN_EQUALS_SSN		= 10,
+	HTT_RX_PN_CHECK_FAILED			= 11,
+	HTT_RX_2K_ERROR_HANDLING_FLAG_SET	= 12,
+	HTT_RX_PN_ERROR_HANDLING_FLAG_SET	= 13,
+	HTT_RX_QUEUE_DESCRIPTOR_BLOCKED_SET	= 14,
+	HTT_RX_REO_ERR_CODE_RVSD		= 15,
+
+	HTT_RX_REO_MAX_ERR_CODE
+};
+
+#define ATH12K_HTT_RX_REO_MAX_ERR_CODE		HTT_RX_REO_MAX_ERR_CODE
+
+struct ath12k_htt_rx_soc_fw_refill_ring_num_reo_err_tlv {
+	DECLARE_FLEX_ARRAY(__le32, reo_err);
+} __packed;
+
+#define ATH12K_HTT_STATS_PHY_ERR_MAX		43
+
+struct ath12k_htt_rx_pdev_fw_stats_phy_err_tlv {
+	__le32 mac_id__word;
+	__le32 total_phy_err_cnt;
+	__le32 phy_err[ATH12K_HTT_STATS_PHY_ERR_MAX];
+} __packed;
+
 #endif
-- 
2.17.1


