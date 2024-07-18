Return-Path: <linux-wireless+bounces-10341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAEB934849
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 08:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE311C21029
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 06:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3704C62E;
	Thu, 18 Jul 2024 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WPrqk5Vn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9EF12E75
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285247; cv=none; b=PGKKV5HYgafrUZZtSKYGV6loYQqRvbVvlie82iHSnW2pvRQB92KBxeBX2jC86eFI0MSM+uN5MIFGsubz7ylj+14rjtX7JYBUQQHpQP6G74uPTA4DDT14iuYBzDpAFYdRsYJyogDXBq8z0oEL6O92xgPzgaxp83gzhZxkWNHfEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285247; c=relaxed/simple;
	bh=BooAP0c2KK5JB6aO/6hWLVlGi18cHcqGmUS5U/pcwMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPNfIuROWOn44JC18DyM9QA/5Q24ZB66bxjK9lxf7ElGiqVSRC0o7Elrg49ypEvbqnxaMUQ2O4F75+tfdyuFNgs18C/Q7kGHYBxQPijyBjQERDJGtW+lXNB8V+d9qmyoVC/q5Cxg0b5KmfTI84Ut5JHyxWDsOyev7e0HXGFjjCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WPrqk5Vn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HNvP4E002464;
	Thu, 18 Jul 2024 06:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l24drcXUFZ4bKfYJ1QOAgpbpoys1oAAf7hNhb+WsQik=; b=WPrqk5VnV6JWn0GZ
	392Te28t1zjlA7rEooEqmKIXnG9FsDH/faEi+aXZpu7QlE30o6ay6FpZPuN7ALVa
	lhE7IGpsAVQuPhI4GDEwq4jKU3oZLf9riJIuQb5E/fbMPMGSd6BnvaGlV425x+hP
	mj5Qw6aFjSYTptOB1Npuq5qzbzZLlQ/ERg8Vvf2KOjPMp02AZm37P2cLZW/gCryP
	K0lhkvtwm99l55I+851NdV6cijt74wNDPVI5iEvBlzdNvcAkfyCSMbO8r/l/csU+
	yIVbQqsbgRcJxXClcsA2JMnY4+84kbXzWrAFm7diekXEZEU4MjlqAWmJLQgNi2VC
	mSET2w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfpmkwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:47:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I6lJTh003886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 06:47:19 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Jul 2024 23:47:18 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v2 2/3] wifi: ath12k: Dump PDEV receive rate HTT stats
Date: Thu, 18 Jul 2024 14:46:58 +0800
Message-ID: <20240718064659.109893-3-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718064659.109893-1-quic_lingbok@quicinc.com>
References: <20240718064659.109893-1-quic_lingbok@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n6J19yfLvf9n9Yjju3eC_5gic2tB5cLA
X-Proofpoint-GUID: n6J19yfLvf9n9Yjju3eC_5gic2tB5cLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_03,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=791
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180045

Support to dump PDEV receive rate stats through HTT debugfs stats type 10.

Sample output:
-----------------
echo 10 > /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats
HTT_RX_PDEV_RATE_STATS_TLV:
mac_id = 0
nsts = 0
rx_ldpc = 96
rts_cnt = 0
rssi_mgmt = 4294967240
rssi_data = 4294967250
rssi_comb = 4294967239
rssi_in_dbm = -46
rx_evm_nss_count = 0
rx_evm_pilot_count = 0
rx_11ax_su_ext = 0
rx_11ac_mumimo = 0
rx_11ax_mumimo = 0
rx_11ax_ofdma = 0
txbf = 0
rx_su_ndpa = 0
rx_mu_ndpa = 0
rx_br_poll = 0
rx_active_dur_us_low = 1000106
rx_active_dur_us_high = 0
rx_11ax_ul_ofdma = 0
ul_ofdma_rx_stbc = 0
ul_ofdma_rx_ldpc = 0
per_chain_rssi_pkt_type = 0x88
rx_nss =  0:40, 1:56, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_dcm =  0:0, 1:0, 2:0, 3:0, 4:0
rx_stbc =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
rx_bw =  0:1175, 1:0, 2:0, 3:0
rx_pream =  0:435, 1:644, 2:0, 3:0, 4:96, 5:0, 6:0
rx_11ax_su_txbf_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
rx_11ax_mu_txbf_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
rx_legacy_cck_rate =  0:641, 1:0, 2:3, 3:0
rx_legacy_ofdm_rate =  0:267, 1:0, 2:72, 3:0, 4:96, 5:0, 6:0, 7:0
ul_ofdma_rx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ul_ofdma_rx_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
ul_ofdma_rx_bw =  0:0, 1:0, 2:0, 3:0
rx_ulofdma_non_data_ppdu =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ulofdma_data_ppdu =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ulofdma_mpdu_ok =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ulofdma_mpdu_fail =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ulofdma_non_data_nusers =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ulofdma_data_nusers =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_11ax_dl_ofdma_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
rx_11ax_dl_ofdma_ru =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0
rx_ulmumimo_non_data_ppdu =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ulmumimo_data_ppdu =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ulmumimo_mpdu_ok =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ulmumimo_mpdu_fail =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_mcs =  0:0, 1:0, 2:0, 3:0, 4:28, 5:8, 6:37, 7:21, 8:2, 9:0, 10:0, 11:0, 12:0, 13:0
pilot_evm_db[0] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
pilot_evm_db[1] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
pilot_evm_db[2] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
pilot_evm_db[3] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
pilot_evm_db[4] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
pilot_evm_db[5] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
pilot_evm_db[6] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
pilot_evm_db[7] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
pilot_evm_db_mean = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rssi_chain_in_db[0] =  0: 196, 1: 29, 2: 29, 3: 29
rssi_chain_in_db[1] =  0: 196, 1: 29, 2: 29, 3: 29
rssi_chain_in_db[2] =  0: 128, 1: 128, 2: 128, 3: 128
rssi_chain_in_db[3] =  0: 128, 1: 128, 2: 128, 3: 128
rssi_chain_in_db[4] =  0: 128, 1: 128, 2: 128, 3: 128
rssi_chain_in_db[5] =  0: 128, 1: 128, 2: 128, 3: 128
rssi_chain_in_db[6] =  0: 128, 1: 128, 2: 128, 3: 128
rssi_chain_in_db[7] =  0: 128, 1: 128, 2: 128, 3: 128
rx_gi[0] =  0:0, 1:0, 2:0, 3:0, 4:28, 5:8, 6:37, 7:21, 8:2, 9:0, 10:0, 11:0
rx_gi[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
rx_gi[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
rx_gi[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ul_ofdma_rx_gi[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ul_ofdma_rx_gi[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ul_ofdma_rx_gi[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ul_ofdma_rx_gi[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
rx_ul_fd_rssi: nss[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ul_fd_rssi: nss[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ul_fd_rssi: nss[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ul_fd_rssi: nss[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ul_fd_rssi: nss[4] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ul_fd_rssi: nss[5] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ul_fd_rssi: nss[6] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_ul_fd_rssi: nss[7] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
rx_per_chain_rssi_in_dbm[0] = 0:-60, 1:29, 2:29, 3:29
rx_per_chain_rssi_in_dbm[1] = 0:-60, 1:29, 2:29, 3:29
rx_per_chain_rssi_in_dbm[2] = 0:-128, 1:-128, 2:-128, 3:-128
rx_per_chain_rssi_in_dbm[3] = 0:-128, 1:-128, 2:-128, 3:-128
rx_per_chain_rssi_in_dbm[4] = 0:-128, 1:-128, 2:-128, 3:-128
rx_per_chain_rssi_in_dbm[5] = 0:-128, 1:-128, 2:-128, 3:-128
rx_per_chain_rssi_in_dbm[6] = 0:-128, 1:-128, 2:-128, 3:-128
rx_per_chain_rssi_in_dbm[7] = 0:-128, 1:-128, 2:-128, 3:-128

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
v2:
1.use TAB to be consistent with existing code

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 222 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  82 +++++++
 2 files changed, 304 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 67e2c47fd2b0..3b1cedc9de60 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1648,6 +1648,225 @@ ath12k_htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static inline void
+ath12k_htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf, u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_rx_pdev_rate_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u8 i, j;
+	u32 mac_id_word;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id_word = le32_to_cpu(htt_stats_buf->mac_id_word);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_RATE_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "nsts = %u\n",
+			 le32_to_cpu(htt_stats_buf->nsts));
+	len += scnprintf(buf + len, buf_len - len, "rx_ldpc = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_ldpc));
+	len += scnprintf(buf + len, buf_len - len, "rts_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rts_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rssi_mgmt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rssi_mgmt));
+	len += scnprintf(buf + len, buf_len - len, "rssi_data = %u\n",
+			 le32_to_cpu(htt_stats_buf->rssi_data));
+	len += scnprintf(buf + len, buf_len - len, "rssi_comb = %u\n",
+			 le32_to_cpu(htt_stats_buf->rssi_comb));
+	len += scnprintf(buf + len, buf_len - len, "rssi_in_dbm = %d\n",
+			 le32_to_cpu(htt_stats_buf->rssi_in_dbm));
+	len += scnprintf(buf + len, buf_len - len, "rx_evm_nss_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->nss_count));
+	len += scnprintf(buf + len, buf_len - len, "rx_evm_pilot_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->pilot_count));
+	len += scnprintf(buf + len, buf_len - len, "rx_11ax_su_ext = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_11ax_su_ext));
+	len += scnprintf(buf + len, buf_len - len, "rx_11ac_mumimo = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_11ac_mumimo));
+	len += scnprintf(buf + len, buf_len - len, "rx_11ax_mumimo = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_11ax_mumimo));
+	len += scnprintf(buf + len, buf_len - len, "rx_11ax_ofdma = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_11ax_ofdma));
+	len += scnprintf(buf + len, buf_len - len, "txbf = %u\n",
+			 le32_to_cpu(htt_stats_buf->txbf));
+	len += scnprintf(buf + len, buf_len - len, "rx_su_ndpa = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_su_ndpa));
+	len += scnprintf(buf + len, buf_len - len, "rx_mu_ndpa = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_mu_ndpa));
+	len += scnprintf(buf + len, buf_len - len, "rx_br_poll = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_br_poll));
+	len += scnprintf(buf + len, buf_len - len, "rx_active_dur_us_low = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_active_dur_us_low));
+	len += scnprintf(buf + len, buf_len - len, "rx_active_dur_us_high = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_active_dur_us_high));
+	len += scnprintf(buf + len, buf_len - len, "rx_11ax_ul_ofdma = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_11ax_ul_ofdma));
+	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_stbc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ul_ofdma_rx_stbc));
+	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_ldpc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ul_ofdma_rx_ldpc));
+	len += scnprintf(buf + len, buf_len - len, "per_chain_rssi_pkt_type = %#x\n",
+			 le32_to_cpu(htt_stats_buf->per_chain_rssi_pkt_type));
+
+	len += print_array_to_buf(buf, len, "rx_nss", htt_stats_buf->rx_nss,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS, "\n");
+	len += print_array_to_buf(buf, len, "rx_dcm", htt_stats_buf->rx_dcm,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "rx_stbc", htt_stats_buf->rx_stbc,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "rx_bw", htt_stats_buf->rx_bw,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "rx_pream", htt_stats_buf->rx_pream,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES, "\n");
+	len += print_array_to_buf(buf, len, "rx_11ax_su_txbf_mcs",
+				  htt_stats_buf->rx_11ax_su_txbf_mcs,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "rx_11ax_mu_txbf_mcs",
+				  htt_stats_buf->rx_11ax_mu_txbf_mcs,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "rx_legacy_cck_rate",
+				  htt_stats_buf->rx_legacy_cck_rate,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS, "\n");
+	len += print_array_to_buf(buf, len, "rx_legacy_ofdm_rate",
+				  htt_stats_buf->rx_legacy_ofdm_rate,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS, "\n");
+	len += print_array_to_buf(buf, len, "ul_ofdma_rx_mcs",
+				  htt_stats_buf->ul_ofdma_rx_mcs,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "ul_ofdma_rx_nss",
+				  htt_stats_buf->ul_ofdma_rx_nss,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS, "\n");
+	len += print_array_to_buf(buf, len, "ul_ofdma_rx_bw",
+				  htt_stats_buf->ul_ofdma_rx_bw,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "rx_ulofdma_non_data_ppdu",
+				  htt_stats_buf->rx_ulofdma_non_data_ppdu,
+				  ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER, "\n");
+	len += print_array_to_buf(buf, len, "rx_ulofdma_data_ppdu",
+				  htt_stats_buf->rx_ulofdma_data_ppdu,
+				  ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER, "\n");
+	len += print_array_to_buf(buf, len, "rx_ulofdma_mpdu_ok",
+				  htt_stats_buf->rx_ulofdma_mpdu_ok,
+				  ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER, "\n");
+	len += print_array_to_buf(buf, len, "rx_ulofdma_mpdu_fail",
+				  htt_stats_buf->rx_ulofdma_mpdu_fail,
+				  ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER, "\n");
+	len += print_array_to_buf(buf, len, "rx_ulofdma_non_data_nusers",
+				  htt_stats_buf->rx_ulofdma_non_data_nusers,
+				  ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER, "\n");
+	len += print_array_to_buf(buf, len, "rx_ulofdma_data_nusers",
+				  htt_stats_buf->rx_ulofdma_data_nusers,
+				  ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER, "\n");
+	len += print_array_to_buf(buf, len, "rx_11ax_dl_ofdma_mcs",
+				  htt_stats_buf->rx_11ax_dl_ofdma_mcs,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "rx_11ax_dl_ofdma_ru",
+				  htt_stats_buf->rx_11ax_dl_ofdma_ru,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_RU_SIZE_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "rx_ulmumimo_non_data_ppdu",
+				  htt_stats_buf->rx_ulmumimo_non_data_ppdu,
+				  ATH12K_HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER, "\n");
+	len += print_array_to_buf(buf, len, "rx_ulmumimo_data_ppdu",
+				  htt_stats_buf->rx_ulmumimo_data_ppdu,
+				  ATH12K_HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER, "\n");
+	len += print_array_to_buf(buf, len, "rx_ulmumimo_mpdu_ok",
+				  htt_stats_buf->rx_ulmumimo_mpdu_ok,
+				  ATH12K_HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER, "\n");
+	len += print_array_to_buf(buf, len, "rx_ulmumimo_mpdu_fail",
+				  htt_stats_buf->rx_ulmumimo_mpdu_fail,
+				  ATH12K_HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER, "\n");
+
+	len += print_array_to_buf(buf, len, "rx_mcs",
+				  htt_stats_buf->rx_mcs,
+				  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, NULL);
+	for (j = 0; j < ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS; j++)
+		len += scnprintf(buf + len, buf_len - len, ", %u:%u",
+				 j + ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS,
+				 le32_to_cpu(htt_stats_buf->rx_mcs_ext[j]));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	for (j = 0; j < ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "pilot_evm_db[%u] =", j);
+		len += print_array_to_buf(buf, len, NULL,
+					  htt_stats_buf->rx_pil_evm_db[j],
+					  ATH12K_HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_NSS,
+					  "\n");
+	}
+
+	len += scnprintf(buf + len, buf_len - len, "pilot_evm_db_mean =");
+	for (i = 0; i < ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; i++)
+		len += scnprintf(buf + len,
+				 buf_len - len,
+				 " %u:%d,", i,
+				 le32_to_cpu(htt_stats_buf->rx_pilot_evm_db_mean[i]));
+	len--;
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	for (j = 0; j < ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "rssi_chain_in_db[%u] = ", j);
+		for (i = 0; i < ATH12K_HTT_RX_PDEV_STATS_NUM_BW_COUNTERS; i++)
+			len += scnprintf(buf + len,
+					 buf_len - len,
+					 " %u: %d,", i,
+					 htt_stats_buf->rssi_chain_in_db[j][i]);
+		len--;
+		len += scnprintf(buf + len, buf_len - len, "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_gi[%u] = ", j);
+		len += print_array_to_buf(buf, len, NULL,
+					  htt_stats_buf->rx_gi[j],
+					  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS,
+					  "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "ul_ofdma_rx_gi[%u] = ", j);
+		len += print_array_to_buf(buf, len, NULL,
+					  htt_stats_buf->ul_ofdma_rx_gi[j],
+					  ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS,
+					  "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_ul_fd_rssi: nss[%u] = ", j);
+		for (i = 0; i < ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER; i++)
+			len += scnprintf(buf + len,
+					 buf_len - len,
+					 " %u:%d,",
+					 i, htt_stats_buf->rx_ul_fd_rssi[j][i]);
+		len--;
+		len += scnprintf(buf + len, buf_len - len, "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_per_chain_rssi_in_dbm[%u] =", j);
+		for (i = 0; i < ATH12K_HTT_RX_PDEV_STATS_NUM_BW_COUNTERS; i++)
+			len += scnprintf(buf + len,
+					 buf_len - len,
+					 " %u:%d,",
+					 i,
+					 htt_stats_buf->rx_per_chain_rssi_in_dbm[j][i]);
+		len--;
+		len += scnprintf(buf + len, buf_len - len, "\n");
+	}
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -1756,6 +1975,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_PDEV_RATE_STATS_TAG:
 		ath12k_htt_print_tx_pdev_rate_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_RX_PDEV_RATE_STATS_TAG:
+		ath12k_htt_print_rx_pdev_rate_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 2c3c1dd9d207..a993b26c274c 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -130,6 +130,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM	= 6,
 	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO	= 8,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE	= 9,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_RX_RATE	= 10,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -153,6 +154,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_DE_ENQUEUE_DISCARD_TAG		= 22,
 	HTT_STATS_TX_DE_CMN_TAG				= 23,
 	HTT_STATS_TX_PDEV_RATE_STATS_TAG		= 34,
+	HTT_STATS_RX_PDEV_RATE_STATS_TAG		= 35,
 	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG	= 36,
 	HTT_STATS_TX_SCHED_CMN_TAG			= 37,
 	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,
@@ -394,6 +396,86 @@ struct ath12k_htt_tx_pdev_rate_stats_tlv {
 	__le32 tx_bw_320mhz;
 };
 
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS		4
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS		8
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS		12
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_GI_COUNTERS		4
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS		5
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_BW_COUNTERS		4
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS		8
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES		7
+#define ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER			8
+#define ATH12K_HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_NSS		16
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_RU_SIZE_COUNTERS		6
+#define ATH12K_HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER		8
+#define ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS		2
+
+struct ath12k_htt_rx_pdev_rate_stats_tlv {
+	__le32 mac_id_word;
+	__le32 nsts;
+	__le32 rx_ldpc;
+	__le32 rts_cnt;
+	__le32 rssi_mgmt;
+	__le32 rssi_data;
+	__le32 rssi_comb;
+	__le32 rx_mcs[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 rx_nss[ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 rx_dcm[ATH12K_HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS];
+	__le32 rx_stbc[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 rx_bw[ATH12K_HTT_RX_PDEV_STATS_NUM_BW_COUNTERS];
+	__le32 rx_pream[ATH12K_HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES];
+	u8 rssi_chain_in_db[ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+		     [ATH12K_HTT_RX_PDEV_STATS_NUM_BW_COUNTERS];
+	__le32 rx_gi[ATH12K_HTT_RX_PDEV_STATS_NUM_GI_COUNTERS]
+		[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 rssi_in_dbm;
+	__le32 rx_11ax_su_ext;
+	__le32 rx_11ac_mumimo;
+	__le32 rx_11ax_mumimo;
+	__le32 rx_11ax_ofdma;
+	__le32 txbf;
+	__le32 rx_legacy_cck_rate[ATH12K_HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS];
+	__le32 rx_legacy_ofdm_rate[ATH12K_HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS];
+	__le32 rx_active_dur_us_low;
+	__le32 rx_active_dur_us_high;
+	__le32 rx_11ax_ul_ofdma;
+	__le32 ul_ofdma_rx_mcs[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 ul_ofdma_rx_gi[ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+			  [ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 ul_ofdma_rx_nss[ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 ul_ofdma_rx_bw[ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
+	__le32 ul_ofdma_rx_stbc;
+	__le32 ul_ofdma_rx_ldpc;
+	__le32 rx_ulofdma_non_data_ppdu[ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
+	__le32 rx_ulofdma_data_ppdu[ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
+	__le32 rx_ulofdma_mpdu_ok[ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
+	__le32 rx_ulofdma_mpdu_fail[ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
+	__le32 nss_count;
+	__le32 pilot_count;
+	__le32 rx_pil_evm_db[ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+			   [ATH12K_HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_NSS];
+	__le32 rx_pilot_evm_db_mean[ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	s8 rx_ul_fd_rssi[ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+			[ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
+	__le32 per_chain_rssi_pkt_type;
+	s8 rx_per_chain_rssi_in_dbm[ATH12K_HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+				   [ATH12K_HTT_RX_PDEV_STATS_NUM_BW_COUNTERS];
+	__le32 rx_su_ndpa;
+	__le32 rx_11ax_su_txbf_mcs[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 rx_mu_ndpa;
+	__le32 rx_11ax_mu_txbf_mcs[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 rx_br_poll;
+	__le32 rx_11ax_dl_ofdma_mcs[ATH12K_HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 rx_11ax_dl_ofdma_ru[ATH12K_HTT_RX_PDEV_STATS_NUM_RU_SIZE_COUNTERS];
+	__le32 rx_ulmumimo_non_data_ppdu[ATH12K_HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER];
+	__le32 rx_ulmumimo_data_ppdu[ATH12K_HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER];
+	__le32 rx_ulmumimo_mpdu_ok[ATH12K_HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER];
+	__le32 rx_ulmumimo_mpdu_fail[ATH12K_HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER];
+	__le32 rx_ulofdma_non_data_nusers[ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
+	__le32 rx_ulofdma_data_nusers[ATH12K_HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
+	__le32 rx_mcs_ext[ATH12K_HTT_RX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
+};
+
 #define ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_MAC_ID	GENMASK(7, 0)
 #define ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_ID	GENMASK(15, 8)
 
-- 
2.34.1


