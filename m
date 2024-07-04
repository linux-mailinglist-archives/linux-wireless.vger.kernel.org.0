Return-Path: <linux-wireless+bounces-9984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B739272A7
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 11:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCA72846AA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769151741CE;
	Thu,  4 Jul 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OSeamIqV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78B16F0D5
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083969; cv=none; b=PxDr8HMc0YHqMEO5NcI2JzHB2buCeyFgYdO5LEjSizO1XV3YTkgV+yxQ7KZEk1UicnZGV7/mL4obVdHp9q/w881iu2YsUBpg/i1s8GgTdZWy80KcLH0NKrGqwTtBx/TwsJnZELcSoulJh97UEJUYcndhkDmmHSwzubcny0x5+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083969; c=relaxed/simple;
	bh=8afgzW+8Rx4soWDXx0rMgShwxaauPDSu93KZnN3hEIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gfFGefF5z/fzujQJ+KA2UJWrrgzIzbOzFG6waNORkfKBzdPdmXBrhuDJRsSZpIwznUtiO5N1WCDM1dzJbHD2dppy3Jz4eDIMI9C+YKGIDgEYC2Z5Z5CsbRMd4IkCOTzo/EKQw3gMMgEfTfuTS19xOu9AvjFeNM5pdttp7T3msZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OSeamIqV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 463MmnNU009672;
	Thu, 4 Jul 2024 09:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=558fMOg/W+WRmnclHeiBPt
	6Tlv7NUiFux8bpAXDjJ60=; b=OSeamIqVrv87/2mkIzRjCwFWIs5bDUVZzbVpHq
	rUmrnFMqHLwMIuiJUZnl6y+PSC0McNhqCdwegPO0LqbZPcs80AV4s7E3z13cqloY
	sAsAQJyFTz1elNWaqABfkboFESofi4ac7nTanvW6uDS4O6c3E2minJa/hRwNs7XQ
	c4f8OAwQBerUNWCa5yGDS1TXsiHJgjOyZHoKTcGCPqxLxkpBAQKQb/JLDd1uOpLs
	CXRvKZHAyRjHcj5FWcJ9s3GgHgdwu4JENHq9NuEuet5uABaX3jSZWQJdqy8U8RZo
	JCaRCwPrZnKDjSOJrziEAg2SW5KUQ5yARM4LAxbGAxN3Ow3A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029uxk0ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 09:05:54 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46495rUo017687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 09:05:53 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 4 Jul 2024 02:05:51 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: Support Transmit DE stats
Date: Thu, 4 Jul 2024 14:35:35 +0530
Message-ID: <20240704090535.827680-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: DWKQHIS_I7WpqdR7zM_icRC2fkDw3xny
X-Proofpoint-ORIG-GUID: DWKQHIS_I7WpqdR7zM_icRC2fkDw3xny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_05,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040063

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request transmit DE stats from firmware through HTT stats
type 8. These stats give information about enqueued packets, discarded
packets, failed packets and other information such as power, bandwidth
information, number of retries, etc.

Sample output:
-------------
echo 8 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_TX_DE_CMN_STATS_TLV:
mac_id = 0
tcl2fw_entry_count = 0
not_to_fw = 0
.....

HTT_TX_DE_EAPOL_PACKETS_STATS_TLV:
m1_packets = 0
m2_packets = 0
m3_packets = 0
.....

HTT_TX_DE_CLASSIFY_STATS_TLV:
arp_packets = 0
igmp_packets = 0
dhcp_packets = 0
.....

HTT_TX_DE_CLASSIFY_FAILED_STATS_TLV:
ap_bss_peer_not_found = 0
ap_bcast_mcast_no_peer = 0
sta_delete_in_progress = 0
.....

HTT_TX_DE_CLASSIFY_STATUS_STATS_TLV:
eok = 0
classify_done = 0
lookup_failed = 0
.....

HTT_TX_DE_ENQUEUE_PACKETS_STATS_TLV:
enqueued_pkts = 0
to_tqm = 0
to_tqm_bypass = 0

HTT_TX_DE_ENQUEUE_DISCARD_STATS_TLV:
discarded_pkts = 0
local_frames = 0
is_ext_msdu = 0

HTT_TX_DE_COMPL_STATS_TLV:
tcl_dummy_frame = 0
tqm_dummy_frame = 0
tqm_notify_frame = 0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
v2:
 - Rebased on ToT

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 354 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 126 +++++++
 2 files changed, 480 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index ce80e7b5175b..f1b7e74aefe4 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1117,6 +1117,336 @@ ath12k_htt_print_tx_tqm_pdev_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_tx_de_cmn_stats_tlv(const void *tag_buf, u16 tag_len,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_de_cmn_stats_tlv *htt_stats_buf = tag_buf;
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
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_DE_CMN_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "tcl2fw_entry_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->tcl2fw_entry_count));
+	len += scnprintf(buf + len, buf_len - len, "not_to_fw = %u\n",
+			 le32_to_cpu(htt_stats_buf->not_to_fw));
+	len += scnprintf(buf + len, buf_len - len, "invalid_pdev_vdev_peer = %u\n",
+			 le32_to_cpu(htt_stats_buf->invalid_pdev_vdev_peer));
+	len += scnprintf(buf + len, buf_len - len, "tcl_res_invalid_addrx = %u\n",
+			 le32_to_cpu(htt_stats_buf->tcl_res_invalid_addrx));
+	len += scnprintf(buf + len, buf_len - len, "wbm2fw_entry_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->wbm2fw_entry_count));
+	len += scnprintf(buf + len, buf_len - len, "invalid_pdev = %u\n",
+			 le32_to_cpu(htt_stats_buf->invalid_pdev));
+	len += scnprintf(buf + len, buf_len - len, "tcl_res_addrx_timeout = %u\n",
+			 le32_to_cpu(htt_stats_buf->tcl_res_addrx_timeout));
+	len += scnprintf(buf + len, buf_len - len, "invalid_vdev = %u\n",
+			 le32_to_cpu(htt_stats_buf->invalid_vdev));
+	len += scnprintf(buf + len, buf_len - len, "invalid_tcl_exp_frame_desc = %u\n",
+			 le32_to_cpu(htt_stats_buf->invalid_tcl_exp_frame_desc));
+	len += scnprintf(buf + len, buf_len - len, "vdev_id_mismatch_count = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->vdev_id_mismatch_cnt));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_de_eapol_packets_stats_tlv(const void *tag_buf, u16 tag_len,
+					       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_de_eapol_packets_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_DE_EAPOL_PACKETS_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "m1_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->m1_packets));
+	len += scnprintf(buf + len, buf_len - len, "m2_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->m2_packets));
+	len += scnprintf(buf + len, buf_len - len, "m3_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->m3_packets));
+	len += scnprintf(buf + len, buf_len - len, "m4_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->m4_packets));
+	len += scnprintf(buf + len, buf_len - len, "g1_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->g1_packets));
+	len += scnprintf(buf + len, buf_len - len, "g2_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->g2_packets));
+	len += scnprintf(buf + len, buf_len - len, "rc4_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->rc4_packets));
+	len += scnprintf(buf + len, buf_len - len, "eap_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->eap_packets));
+	len += scnprintf(buf + len, buf_len - len, "eapol_start_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->eapol_start_packets));
+	len += scnprintf(buf + len, buf_len - len, "eapol_logoff_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->eapol_logoff_packets));
+	len += scnprintf(buf + len, buf_len - len, "eapol_encap_asf_packets = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->eapol_encap_asf_packets));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_de_classify_stats_tlv(const void *tag_buf, u16 tag_len,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_de_classify_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_DE_CLASSIFY_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "arp_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->arp_packets));
+	len += scnprintf(buf + len, buf_len - len, "igmp_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->igmp_packets));
+	len += scnprintf(buf + len, buf_len - len, "dhcp_packets = %u\n",
+			 le32_to_cpu(htt_stats_buf->dhcp_packets));
+	len += scnprintf(buf + len, buf_len - len, "host_inspected = %u\n",
+			 le32_to_cpu(htt_stats_buf->host_inspected));
+	len += scnprintf(buf + len, buf_len - len, "htt_included = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_included));
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_mcs = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_valid_mcs));
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_nss = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_valid_nss));
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_preamble_type = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_valid_preamble_type));
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_chainmask = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_valid_chainmask));
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_guard_interval = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_valid_guard_interval));
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_retries = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_valid_retries));
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_bw_info = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_valid_bw_info));
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_power = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_valid_power));
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_key_flags = 0x%x\n",
+			 le32_to_cpu(htt_stats_buf->htt_valid_key_flags));
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_no_encryption = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_valid_no_encryption));
+	len += scnprintf(buf + len, buf_len - len, "fse_entry_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_entry_count));
+	len += scnprintf(buf + len, buf_len - len, "fse_priority_be = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_priority_be));
+	len += scnprintf(buf + len, buf_len - len, "fse_priority_high = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_priority_high));
+	len += scnprintf(buf + len, buf_len - len, "fse_priority_low = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_priority_low));
+	len += scnprintf(buf + len, buf_len - len, "fse_traffic_ptrn_be = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_traffic_ptrn_be));
+	len += scnprintf(buf + len, buf_len - len, "fse_traffic_ptrn_over_sub = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_traffic_ptrn_over_sub));
+	len += scnprintf(buf + len, buf_len - len, "fse_traffic_ptrn_bursty = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_traffic_ptrn_bursty));
+	len += scnprintf(buf + len, buf_len - len, "fse_traffic_ptrn_interactive = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_traffic_ptrn_interactive));
+	len += scnprintf(buf + len, buf_len - len, "fse_traffic_ptrn_periodic = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_traffic_ptrn_periodic));
+	len += scnprintf(buf + len, buf_len - len, "fse_hwqueue_alloc = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_hwqueue_alloc));
+	len += scnprintf(buf + len, buf_len - len, "fse_hwqueue_created = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_hwqueue_created));
+	len += scnprintf(buf + len, buf_len - len, "fse_hwqueue_send_to_host = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_hwqueue_send_to_host));
+	len += scnprintf(buf + len, buf_len - len, "mcast_entry = %u\n",
+			 le32_to_cpu(htt_stats_buf->mcast_entry));
+	len += scnprintf(buf + len, buf_len - len, "bcast_entry = %u\n",
+			 le32_to_cpu(htt_stats_buf->bcast_entry));
+	len += scnprintf(buf + len, buf_len - len, "htt_update_peer_cache = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_update_peer_cache));
+	len += scnprintf(buf + len, buf_len - len, "htt_learning_frame = %u\n",
+			 le32_to_cpu(htt_stats_buf->htt_learning_frame));
+	len += scnprintf(buf + len, buf_len - len, "fse_invalid_peer = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_invalid_peer));
+	len += scnprintf(buf + len, buf_len - len, "mec_notify = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->mec_notify));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_de_classify_failed_stats_tlv(const void *tag_buf, u16 tag_len,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_de_classify_failed_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_DE_CLASSIFY_FAILED_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ap_bss_peer_not_found = %u\n",
+			 le32_to_cpu(htt_stats_buf->ap_bss_peer_not_found));
+	len += scnprintf(buf + len, buf_len - len, "ap_bcast_mcast_no_peer = %u\n",
+			 le32_to_cpu(htt_stats_buf->ap_bcast_mcast_no_peer));
+	len += scnprintf(buf + len, buf_len - len, "sta_delete_in_progress = %u\n",
+			 le32_to_cpu(htt_stats_buf->sta_delete_in_progress));
+	len += scnprintf(buf + len, buf_len - len, "ibss_no_bss_peer = %u\n",
+			 le32_to_cpu(htt_stats_buf->ibss_no_bss_peer));
+	len += scnprintf(buf + len, buf_len - len, "invalid_vdev_type = %u\n",
+			 le32_to_cpu(htt_stats_buf->invalid_vdev_type));
+	len += scnprintf(buf + len, buf_len - len, "invalid_ast_peer_entry = %u\n",
+			 le32_to_cpu(htt_stats_buf->invalid_ast_peer_entry));
+	len += scnprintf(buf + len, buf_len - len, "peer_entry_invalid = %u\n",
+			 le32_to_cpu(htt_stats_buf->peer_entry_invalid));
+	len += scnprintf(buf + len, buf_len - len, "ethertype_not_ip = %u\n",
+			 le32_to_cpu(htt_stats_buf->ethertype_not_ip));
+	len += scnprintf(buf + len, buf_len - len, "eapol_lookup_failed = %u\n",
+			 le32_to_cpu(htt_stats_buf->eapol_lookup_failed));
+	len += scnprintf(buf + len, buf_len - len, "qpeer_not_allow_data = %u\n",
+			 le32_to_cpu(htt_stats_buf->qpeer_not_allow_data));
+	len += scnprintf(buf + len, buf_len - len, "fse_tid_override = %u\n",
+			 le32_to_cpu(htt_stats_buf->fse_tid_override));
+	len += scnprintf(buf + len, buf_len - len, "ipv6_jumbogram_zero_length = %u\n",
+			 le32_to_cpu(htt_stats_buf->ipv6_jumbogram_zero_length));
+	len += scnprintf(buf + len, buf_len - len, "qos_to_non_qos_in_prog = %u\n",
+			 le32_to_cpu(htt_stats_buf->qos_to_non_qos_in_prog));
+	len += scnprintf(buf + len, buf_len - len, "ap_bcast_mcast_eapol = %u\n",
+			 le32_to_cpu(htt_stats_buf->ap_bcast_mcast_eapol));
+	len += scnprintf(buf + len, buf_len - len, "unicast_on_ap_bss_peer = %u\n",
+			 le32_to_cpu(htt_stats_buf->unicast_on_ap_bss_peer));
+	len += scnprintf(buf + len, buf_len - len, "ap_vdev_invalid = %u\n",
+			 le32_to_cpu(htt_stats_buf->ap_vdev_invalid));
+	len += scnprintf(buf + len, buf_len - len, "incomplete_llc = %u\n",
+			 le32_to_cpu(htt_stats_buf->incomplete_llc));
+	len += scnprintf(buf + len, buf_len - len, "eapol_duplicate_m3 = %u\n",
+			 le32_to_cpu(htt_stats_buf->eapol_duplicate_m3));
+	len += scnprintf(buf + len, buf_len - len, "eapol_duplicate_m4 = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->eapol_duplicate_m4));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_de_classify_status_stats_tlv(const void *tag_buf, u16 tag_len,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_de_classify_status_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_DE_CLASSIFY_STATUS_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "eok = %u\n",
+			 le32_to_cpu(htt_stats_buf->eok));
+	len += scnprintf(buf + len, buf_len - len, "classify_done = %u\n",
+			 le32_to_cpu(htt_stats_buf->classify_done));
+	len += scnprintf(buf + len, buf_len - len, "lookup_failed = %u\n",
+			 le32_to_cpu(htt_stats_buf->lookup_failed));
+	len += scnprintf(buf + len, buf_len - len, "send_host_dhcp = %u\n",
+			 le32_to_cpu(htt_stats_buf->send_host_dhcp));
+	len += scnprintf(buf + len, buf_len - len, "send_host_mcast = %u\n",
+			 le32_to_cpu(htt_stats_buf->send_host_mcast));
+	len += scnprintf(buf + len, buf_len - len, "send_host_unknown_dest = %u\n",
+			 le32_to_cpu(htt_stats_buf->send_host_unknown_dest));
+	len += scnprintf(buf + len, buf_len - len, "send_host = %u\n",
+			 le32_to_cpu(htt_stats_buf->send_host));
+	len += scnprintf(buf + len, buf_len - len, "status_invalid = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->status_invalid));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_de_enqueue_packets_stats_tlv(const void *tag_buf, u16 tag_len,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_de_enqueue_packets_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_DE_ENQUEUE_PACKETS_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "enqueued_pkts = %u\n",
+			 le32_to_cpu(htt_stats_buf->enqueued_pkts));
+	len += scnprintf(buf + len, buf_len - len, "to_tqm = %u\n",
+			 le32_to_cpu(htt_stats_buf->to_tqm));
+	len += scnprintf(buf + len, buf_len - len, "to_tqm_bypass = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->to_tqm_bypass));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_de_enqueue_discard_stats_tlv(const void *tag_buf, u16 tag_len,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_de_enqueue_discard_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_DE_ENQUEUE_DISCARD_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "discarded_pkts = %u\n",
+			 le32_to_cpu(htt_stats_buf->discarded_pkts));
+	len += scnprintf(buf + len, buf_len - len, "local_frames = %u\n",
+			 le32_to_cpu(htt_stats_buf->local_frames));
+	len += scnprintf(buf + len, buf_len - len, "is_ext_msdu = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->is_ext_msdu));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_de_compl_stats_tlv(const void *tag_buf, u16 tag_len,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_de_compl_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_DE_COMPL_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "tcl_dummy_frame = %u\n",
+			 le32_to_cpu(htt_stats_buf->tcl_dummy_frame));
+	len += scnprintf(buf + len, buf_len - len, "tqm_dummy_frame = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_dummy_frame));
+	len += scnprintf(buf + len, buf_len - len, "tqm_notify_frame = %u\n",
+			 le32_to_cpu(htt_stats_buf->tqm_notify_frame));
+	len += scnprintf(buf + len, buf_len - len, "fw2wbm_enq = %u\n",
+			 le32_to_cpu(htt_stats_buf->fw2wbm_enq));
+	len += scnprintf(buf + len, buf_len - len, "tqm_bypass_frame = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->tqm_bypass_frame));
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -1198,6 +1528,30 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_TQM_PDEV_TAG:
 		ath12k_htt_print_tx_tqm_pdev_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_DE_CMN_TAG:
+		ath12k_htt_print_tx_de_cmn_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_DE_EAPOL_PACKETS_TAG:
+		ath12k_htt_print_tx_de_eapol_packets_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_DE_CLASSIFY_STATS_TAG:
+		ath12k_htt_print_tx_de_classify_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_DE_CLASSIFY_FAILED_TAG:
+		ath12k_htt_print_tx_de_classify_failed_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_DE_CLASSIFY_STATUS_TAG:
+		ath12k_htt_print_tx_de_classify_status_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_DE_ENQUEUE_PACKETS_TAG:
+		ath12k_htt_print_tx_de_enqueue_packets_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_DE_ENQUEUE_DISCARD_TAG:
+		ath12k_htt_print_tx_de_enqueue_discard_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_DE_COMPL_STATS_TAG:
+		ath12k_htt_print_tx_de_compl_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 6294a082cf8a..d52b26b23e65 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -128,6 +128,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED	= 4,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR	= 5,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM	= 6,
+	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO	= 8,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -143,6 +144,13 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_TQM_LIST_MPDU_CNT_TAG		= 13,
 	HTT_STATS_TX_TQM_CMN_TAG			= 14,
 	HTT_STATS_TX_TQM_PDEV_TAG			= 15,
+	HTT_STATS_TX_DE_EAPOL_PACKETS_TAG		= 17,
+	HTT_STATS_TX_DE_CLASSIFY_FAILED_TAG		= 18,
+	HTT_STATS_TX_DE_CLASSIFY_STATS_TAG		= 19,
+	HTT_STATS_TX_DE_CLASSIFY_STATUS_TAG		= 20,
+	HTT_STATS_TX_DE_ENQUEUE_PACKETS_TAG		= 21,
+	HTT_STATS_TX_DE_ENQUEUE_DISCARD_TAG		= 22,
+	HTT_STATS_TX_DE_CMN_TAG				= 23,
 	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG	= 36,
 	HTT_STATS_TX_SCHED_CMN_TAG			= 37,
 	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,
@@ -150,6 +158,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG		= 44,
 	HTT_STATS_HW_INTR_MISC_TAG			= 54,
 	HTT_STATS_HW_PDEV_ERRS_TAG			= 56,
+	HTT_STATS_TX_DE_COMPL_STATS_TAG			= 65,
 	HTT_STATS_WHAL_TX_TAG				= 66,
 	HTT_STATS_TX_PDEV_SIFS_HIST_TAG			= 67,
 	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG		= 86,
@@ -564,4 +573,121 @@ struct ath12k_htt_tx_tqm_pdev_stats_tlv {
 	__le32 sched_nonudp_notify2;
 } __packed;
 
+struct ath12k_htt_tx_de_cmn_stats_tlv {
+	__le32 mac_id__word;
+	__le32 tcl2fw_entry_count;
+	__le32 not_to_fw;
+	__le32 invalid_pdev_vdev_peer;
+	__le32 tcl_res_invalid_addrx;
+	__le32 wbm2fw_entry_count;
+	__le32 invalid_pdev;
+	__le32 tcl_res_addrx_timeout;
+	__le32 invalid_vdev;
+	__le32 invalid_tcl_exp_frame_desc;
+	__le32 vdev_id_mismatch_cnt;
+} __packed;
+
+struct ath12k_htt_tx_de_eapol_packets_stats_tlv {
+	__le32 m1_packets;
+	__le32 m2_packets;
+	__le32 m3_packets;
+	__le32 m4_packets;
+	__le32 g1_packets;
+	__le32 g2_packets;
+	__le32 rc4_packets;
+	__le32 eap_packets;
+	__le32 eapol_start_packets;
+	__le32 eapol_logoff_packets;
+	__le32 eapol_encap_asf_packets;
+} __packed;
+
+struct ath12k_htt_tx_de_classify_stats_tlv {
+	__le32 arp_packets;
+	__le32 igmp_packets;
+	__le32 dhcp_packets;
+	__le32 host_inspected;
+	__le32 htt_included;
+	__le32 htt_valid_mcs;
+	__le32 htt_valid_nss;
+	__le32 htt_valid_preamble_type;
+	__le32 htt_valid_chainmask;
+	__le32 htt_valid_guard_interval;
+	__le32 htt_valid_retries;
+	__le32 htt_valid_bw_info;
+	__le32 htt_valid_power;
+	__le32 htt_valid_key_flags;
+	__le32 htt_valid_no_encryption;
+	__le32 fse_entry_count;
+	__le32 fse_priority_be;
+	__le32 fse_priority_high;
+	__le32 fse_priority_low;
+	__le32 fse_traffic_ptrn_be;
+	__le32 fse_traffic_ptrn_over_sub;
+	__le32 fse_traffic_ptrn_bursty;
+	__le32 fse_traffic_ptrn_interactive;
+	__le32 fse_traffic_ptrn_periodic;
+	__le32 fse_hwqueue_alloc;
+	__le32 fse_hwqueue_created;
+	__le32 fse_hwqueue_send_to_host;
+	__le32 mcast_entry;
+	__le32 bcast_entry;
+	__le32 htt_update_peer_cache;
+	__le32 htt_learning_frame;
+	__le32 fse_invalid_peer;
+	__le32 mec_notify;
+} __packed;
+
+struct ath12k_htt_tx_de_classify_failed_stats_tlv {
+	__le32 ap_bss_peer_not_found;
+	__le32 ap_bcast_mcast_no_peer;
+	__le32 sta_delete_in_progress;
+	__le32 ibss_no_bss_peer;
+	__le32 invalid_vdev_type;
+	__le32 invalid_ast_peer_entry;
+	__le32 peer_entry_invalid;
+	__le32 ethertype_not_ip;
+	__le32 eapol_lookup_failed;
+	__le32 qpeer_not_allow_data;
+	__le32 fse_tid_override;
+	__le32 ipv6_jumbogram_zero_length;
+	__le32 qos_to_non_qos_in_prog;
+	__le32 ap_bcast_mcast_eapol;
+	__le32 unicast_on_ap_bss_peer;
+	__le32 ap_vdev_invalid;
+	__le32 incomplete_llc;
+	__le32 eapol_duplicate_m3;
+	__le32 eapol_duplicate_m4;
+} __packed;
+
+struct ath12k_htt_tx_de_classify_status_stats_tlv {
+	__le32 eok;
+	__le32 classify_done;
+	__le32 lookup_failed;
+	__le32 send_host_dhcp;
+	__le32 send_host_mcast;
+	__le32 send_host_unknown_dest;
+	__le32 send_host;
+	__le32 status_invalid;
+} __packed;
+
+struct ath12k_htt_tx_de_enqueue_packets_stats_tlv {
+	__le32 enqueued_pkts;
+	__le32 to_tqm;
+	__le32 to_tqm_bypass;
+} __packed;
+
+struct ath12k_htt_tx_de_enqueue_discard_stats_tlv {
+	__le32 discarded_pkts;
+	__le32 local_frames;
+	__le32 is_ext_msdu;
+} __packed;
+
+struct ath12k_htt_tx_de_compl_stats_tlv {
+	__le32 tcl_dummy_frame;
+	__le32 tqm_dummy_frame;
+	__le32 tqm_notify_frame;
+	__le32 fw2wbm_enq;
+	__le32 tqm_bypass_frame;
+} __packed;
+
 #endif
-- 
2.25.1


