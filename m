Return-Path: <linux-wireless+bounces-15974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A769E6F57
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 14:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DFF169D18
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A08B224EA;
	Fri,  6 Dec 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m+4Nk//u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF31DDA3A
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733492053; cv=none; b=KdrOPAM0amklStoSzbUKmQxfxL4GfCwvHsgBZGIUL6O8nrSaaJ1Nc4wE9XvqdO14M9uq4Vt+WtNAQycB2kptBU46M0PL4y47sTEVEXsO9Rxqe59buGx8QQCAsMzYOdKyIQt4mukLLZuQ9GIS8DRNG0bEvAvz7M5WxC6WcQ/N5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733492053; c=relaxed/simple;
	bh=tA5zrE5W72a+GHAa8DroRRU128Lnd3rA9qi2p7J1MBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjtEqmObX7tfmPijQpr7ywU/FNYiXTtUuy0tc5zH7tgBoZQ480eJrqcRJj8Znm872AJA5c45pxHBVcKy740IQFLMXVvxZ4vMrRQlcoNqCsk/NlSU2kC7SNXmv6yAF7sFtzKUVCvBaFWHoyPQlLjzmTwKTQUbcB/py+6SvcBAu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m+4Nk//u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67pKmT006894;
	Fri, 6 Dec 2024 13:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YMdBYiK2VOMu987ralDyqYvYFRw+UKixQ3SraQmP0t4=; b=m+4Nk//u+4Xaa8wO
	uAYqfLk6hCr6GqChhjuVGmjMlGYDETUXmlymdss7IoBLqcOjW9dGDNNCRCwgNLf+
	BWIVI4iM1DbcryNgbkTqY7FsR6QUwMExDQKMvbfq9JFockfZ4QviOwy21HXGYmka
	YpiTCoNHTBByCcUCu/XDqx4q5uoIPkL53Q0c3jubQzSe+ZBovbiu35qnWdIV1pLd
	Fs5l40E0jWZqA5qUfeSRlVBqAYs9/SA/mAR70gBmMUGizgN83STNe9WYvsiblOUa
	43Td7kTSEV1MRtbPk13O06gP0AUt1aSJf27YezgAn5B3s3zLDh8clKJVbvrzQB9Q
	qRVwaA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ben8b6h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 13:34:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B6DY71U005620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 13:34:07 GMT
Received: from lingbok.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 6 Dec 2024 05:34:06 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 1/3] wifi: ath12k: Dump PDEV transmit rate HTT stats
Date: Fri, 6 Dec 2024 21:33:53 +0800
Message-ID: <20241206133355.1990-2-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20241206133355.1990-1-quic_lingbok@quicinc.com>
References: <20241206133355.1990-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Q3jNGAy-S6TBWVD3UK_n5pDgZ8GEelR4
X-Proofpoint-GUID: Q3jNGAy-S6TBWVD3UK_n5pDgZ8GEelR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060102

Support to dump PDEV transmit rate stats through HTT debugfs stats type 9.

Sample output:
-------------------------
echo 9 > /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats
HTT_TX_PDEV_RATE_STATS_TLV:
mac_id = 0
tx_ldpc = 1088
ac_mu_mimo_tx_ldpc = 0
ax_mu_mimo_tx_ldpc = 0
ofdma_tx_ldpc = 0
rts_cnt = 941
rts_success = 180
ack_rssi = 4294967168
Legacy CCK Rates: 1 Mbps: 830, 2 Mbps: 0, 5.5 Mbps: 0, 12 Mbps: 0
Legacy OFDM Rates: 6 Mbps: 942, 9 Mbps: 0, 12 Mbps: 0, 18 Mbps: 0
                   24 Mbps: 0, 36 Mbps: 0, 48 Mbps: 0, 54 Mbps: 0
HE LTF: 1x: 0, 2x: 957, 4x: 132
tx_mcs =  0:342, 1:260, 2:171, 3:148, 4:31, 5:34, 6:93, 7:10, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0
ax_mu_mimo_tx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ofdma_tx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
tx_nss = 1:754, 2:335, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
ac_mu_mimo_tx_nss = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
ax_mu_mimo_tx_nss = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
ofdma_tx_nss = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
tx_bw =  0:1089, 1:0, 2:0, 3:0, 4:0
tx_stbc =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
tx_gi[0] = 0:210, 1:260, 2:171, 3:148, 4:31, 5:34, 6:93, 7:10, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
tx_gi[1] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
tx_gi[2] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
tx_gi[3] = 0:132, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ac_mu_mimo_tx_gi[0] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ac_mu_mimo_tx_gi[1] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ac_mu_mimo_tx_gi[2] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ac_mu_mimo_tx_gi[3] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ax_mu_mimo_tx_gi[0] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ax_mu_mimo_tx_gi[1] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ax_mu_mimo_tx_gi[2] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ax_mu_mimo_tx_gi[3] = 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ofdma_tx_gi[0] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ofdma_tx_gi[1] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ofdma_tx_gi[2] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
ofdma_tx_gi[3] =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
tx_su_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
tx_mu_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ac_mu_mimo_tx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0
ac_mu_mimo_tx_bw =  0:0, 1:0, 2:0, 3:0
ax_mu_mimo_tx_bw =  0:0, 1:0, 2:0, 3:0
ofdma_tx_bw =  0:0, 1:0, 2:0, 3:0
tx_pream =  0:942, 1:830, 2:0, 3:0, 4:1850, 5:0, 6:0
tx_dcm =  0:131, 1:0, 2:0, 3:0, 4:0

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
v3:
1.no change

v2:
1.use TAB to be consistent with existing code

.../wireless/ath/ath12k/debugfs_htt_stats.c   | 204 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  68 ++++++
 2 files changed, 272 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index d8f137bfba7b..986564682cd5 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -3335,6 +3335,207 @@ ath12k_htt_print_pdev_mbssid_ctrl_frame_stats_tlv(const void *tag_buf, u16 tag_l
 	stats_req->buf_len = len;
 }
 
+static inline void
+ath12k_htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf, u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_pdev_rate_stats_tlv *htt_stats_buf = tag_buf;
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
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_RATE_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "tx_ldpc = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_ldpc));
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_tx_ldpc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_tx_ldpc));
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_tx_ldpc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_tx_ldpc));
+	len += scnprintf(buf + len, buf_len - len, "ofdma_tx_ldpc = %u\n",
+			 le32_to_cpu(htt_stats_buf->ofdma_tx_ldpc));
+	len += scnprintf(buf + len, buf_len - len, "rts_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rts_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rts_success = %u\n",
+			 le32_to_cpu(htt_stats_buf->rts_success));
+	len += scnprintf(buf + len, buf_len - len, "ack_rssi = %u\n",
+			 le32_to_cpu(htt_stats_buf->ack_rssi));
+	len += scnprintf(buf + len, buf_len - len,
+			 "Legacy CCK Rates: 1 Mbps: %u, 2 Mbps: %u, 5.5 Mbps: %u, 12 Mbps: %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_legacy_cck_rate[0]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_cck_rate[1]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_cck_rate[2]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_cck_rate[3]));
+	len += scnprintf(buf + len, buf_len - len,
+			 "Legacy OFDM Rates: 6 Mbps: %u, 9 Mbps: %u, 12 Mbps: %u, 18 Mbps: %u\n"
+			 "                   24 Mbps: %u, 36 Mbps: %u, 48 Mbps: %u, 54 Mbps: %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[0]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[1]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[2]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[3]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[4]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[5]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[6]),
+			 le32_to_cpu(htt_stats_buf->tx_legacy_ofdm_rate[7]));
+	len += scnprintf(buf + len, buf_len - len, "HE LTF: 1x: %u, 2x: %u, 4x: %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_he_ltf[1]),
+			 le32_to_cpu(htt_stats_buf->tx_he_ltf[2]),
+			 le32_to_cpu(htt_stats_buf->tx_he_ltf[3]));
+
+	len += print_array_to_buf(buf, len, "tx_mcs", htt_stats_buf->tx_mcs,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, NULL);
+	for (j = 0; j < ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS; j++)
+		len += scnprintf(buf + len, buf_len - len, ", %u:%u",
+				 j + ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+				 le32_to_cpu(htt_stats_buf->tx_mcs_ext[j]));
+	for (j = 0; j < ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS; j++)
+		len += scnprintf(buf + len, buf_len - len, ", %u:%u",
+				 j + ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS +
+				 ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS,
+				 le32_to_cpu(htt_stats_buf->tx_mcs_ext_2[j]));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += print_array_to_buf(buf, len, "ax_mu_mimo_tx_mcs",
+				  htt_stats_buf->ax_mu_mimo_tx_mcs,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, NULL);
+	for (j = 0; j < ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS; j++)
+		len += scnprintf(buf + len, buf_len - len, ", %u:%u",
+				 j + ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+				 le32_to_cpu(htt_stats_buf->ax_mu_mimo_tx_mcs_ext[j]));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += print_array_to_buf(buf, len, "ofdma_tx_mcs",
+				  htt_stats_buf->ofdma_tx_mcs,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, NULL);
+	for (j = 0; j < ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS; j++)
+		len += scnprintf(buf + len, buf_len - len, ", %u:%u",
+				 j + ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+				 le32_to_cpu(htt_stats_buf->ofdma_tx_mcs_ext[j]));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "tx_nss =");
+	for (j = 1; j <= ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,",
+				 j, le32_to_cpu(htt_stats_buf->tx_nss[j - 1]));
+	len--;
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_tx_nss =");
+	for (j = 1; j <= ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,",
+				 j, le32_to_cpu(htt_stats_buf->ac_mu_mimo_tx_nss[j - 1]));
+	len--;
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_tx_nss =");
+	for (j = 1; j <= ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,",
+				 j, le32_to_cpu(htt_stats_buf->ax_mu_mimo_tx_nss[j - 1]));
+	len--;
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "ofdma_tx_nss =");
+	for (j = 1; j <= ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,",
+				 j, le32_to_cpu(htt_stats_buf->ofdma_tx_nss[j - 1]));
+	len--;
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	len += print_array_to_buf(buf, len, "tx_bw", htt_stats_buf->tx_bw,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS, NULL);
+	len += scnprintf(buf + len, buf_len - len, ", %u:%u\n",
+			 ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS,
+			 le32_to_cpu(htt_stats_buf->tx_bw_320mhz));
+
+	len += print_array_to_buf(buf, len, "tx_stbc",
+				  htt_stats_buf->tx_stbc,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, NULL);
+	for (j = 0; j < ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS; j++)
+		len += scnprintf(buf + len, buf_len - len, ", %u:%u",
+				 j + ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+				 le32_to_cpu(htt_stats_buf->tx_stbc_ext[j]));
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	for (j = 0; j < ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		len += scnprintf(buf + len, (buf_len - len),
+				 "tx_gi[%u] =", j);
+		len += print_array_to_buf(buf, len, NULL, htt_stats_buf->tx_gi[j],
+					  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+					  NULL);
+		for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS; i++)
+			len += scnprintf(buf + len, buf_len - len, ", %u:%u",
+					 i + ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+					 le32_to_cpu(htt_stats_buf->tx_gi_ext[j][i]));
+		len += scnprintf(buf + len, buf_len - len, "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		len += scnprintf(buf + len, (buf_len - len),
+				 "ac_mu_mimo_tx_gi[%u] =", j);
+		len += print_array_to_buf(buf, len, NULL,
+					  htt_stats_buf->ac_mu_mimo_tx_gi[j],
+					  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+					  "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		len += scnprintf(buf + len, (buf_len - len),
+				 "ax_mu_mimo_tx_gi[%u] =", j);
+		len += print_array_to_buf(buf, len, NULL, htt_stats_buf->ax_mimo_tx_gi[j],
+					  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+					  NULL);
+		for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS; i++)
+			len += scnprintf(buf + len, buf_len - len, ", %u:%u",
+					 i + ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+					 le32_to_cpu(htt_stats_buf->ax_tx_gi_ext[j][i]));
+		len += scnprintf(buf + len, buf_len - len, "\n");
+	}
+
+	for (j = 0; j < ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		len += scnprintf(buf + len, (buf_len - len),
+				 "ofdma_tx_gi[%u] = ", j);
+		len += print_array_to_buf(buf, len, NULL, htt_stats_buf->ofdma_tx_gi[j],
+					  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+					  NULL);
+		for (i = 0; i < ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS; i++)
+			len += scnprintf(buf + len, buf_len - len, ", %u:%u",
+					 i + ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS,
+					 le32_to_cpu(htt_stats_buf->ofd_tx_gi_ext[j][i]));
+		len += scnprintf(buf + len, buf_len - len, "\n");
+	}
+
+	len += print_array_to_buf(buf, len, "tx_su_mcs", htt_stats_buf->tx_su_mcs,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "tx_mu_mcs", htt_stats_buf->tx_mu_mcs,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "ac_mu_mimo_tx_mcs",
+				  htt_stats_buf->ac_mu_mimo_tx_mcs,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "ac_mu_mimo_tx_bw",
+				  htt_stats_buf->ac_mu_mimo_tx_bw,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "ax_mu_mimo_tx_bw",
+				  htt_stats_buf->ax_mu_mimo_tx_bw,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "ofdma_tx_bw",
+				  htt_stats_buf->ofdma_tx_bw,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+	len += print_array_to_buf(buf, len, "tx_pream", htt_stats_buf->tx_pream,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES, "\n");
+	len += print_array_to_buf(buf, len, "tx_dcm", htt_stats_buf->tx_dcm,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS, "\n");
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -3545,6 +3746,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 		ath12k_htt_print_pdev_mbssid_ctrl_frame_stats_tlv(tag_buf, len,
 								  stats_req);
 		break;
+	case HTT_STATS_TX_PDEV_RATE_STATS_TAG:
+		ath12k_htt_print_tx_pdev_rate_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index cf3c88f8d1b2..3fb677f063f2 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -129,6 +129,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR		= 5,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM		= 6,
 	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO		= 8,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE   = 9,
 	ATH12K_DBG_HTT_EXT_STATS_TX_SELFGEN_INFO	= 12,
 	ATH12K_DBG_HTT_EXT_STATS_SRNG_INFO		= 15,
 	ATH12K_DBG_HTT_EXT_STATS_SFM_INFO		= 16,
@@ -169,6 +170,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_PDEV_MU_MIMO_STATS_TAG		= 25,
 	HTT_STATS_SFM_CMN_TAG				= 26,
 	HTT_STATS_SRING_STATS_TAG			= 27,
+	HTT_STATS_TX_PDEV_RATE_STATS_TAG        = 34,
 	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG	= 36,
 	HTT_STATS_TX_SCHED_CMN_TAG			= 37,
 	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,
@@ -375,6 +377,72 @@ struct ath12k_htt_tx_pdev_mu_ppdu_dist_stats_tlv {
 	__le32 num_ppdu_posted_per_burst[ATH12K_HTT_STATS_MU_PPDU_PER_BURST_WORDS];
 } __packed;
 
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS        12
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS          4
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS         5
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS          4
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS      8
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES       7
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_LEGACY_CCK_STATS     4
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS    8
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_LTF                  4
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS   2
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS  2
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_11AX_TRIGGER_TYPES   6
+
+struct ath12k_htt_tx_pdev_rate_stats_tlv {
+	__le32 mac_id_word;
+	__le32 tx_ldpc;
+	__le32 rts_cnt;
+	__le32 ack_rssi;
+	__le32 tx_mcs[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 tx_su_mcs[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 tx_mu_mcs[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 tx_nss[ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 tx_bw[ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
+	__le32 tx_stbc[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 tx_pream[ATH12K_HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES];
+	__le32 tx_gi[ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+		[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 tx_dcm[ATH12K_HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS];
+	__le32 rts_success;
+	__le32 tx_legacy_cck_rate[ATH12K_HTT_TX_PDEV_STATS_NUM_LEGACY_CCK_STATS];
+	__le32 tx_legacy_ofdm_rate[ATH12K_HTT_TX_PDEV_STATS_NUM_LEGACY_OFDM_STATS];
+	__le32 ac_mu_mimo_tx_ldpc;
+	__le32 ax_mu_mimo_tx_ldpc;
+	__le32 ofdma_tx_ldpc;
+	__le32 tx_he_ltf[ATH12K_HTT_TX_PDEV_STATS_NUM_LTF];
+	__le32 ac_mu_mimo_tx_mcs[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 ax_mu_mimo_tx_mcs[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 ofdma_tx_mcs[ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 ac_mu_mimo_tx_nss[ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 ax_mu_mimo_tx_nss[ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 ofdma_tx_nss[ATH12K_HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS];
+	__le32 ac_mu_mimo_tx_bw[ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
+	__le32 ax_mu_mimo_tx_bw[ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
+	__le32 ofdma_tx_bw[ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS];
+	__le32 ac_mu_mimo_tx_gi[ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+			    [ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 ax_mimo_tx_gi[ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+			    [ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 ofdma_tx_gi[ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+		       [ATH12K_HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS];
+	__le32 trigger_type_11ax[ATH12K_HTT_TX_PDEV_STATS_NUM_11AX_TRIGGER_TYPES];
+	__le32 tx_11ax_su_ext;
+	__le32 tx_mcs_ext[ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
+	__le32 tx_stbc_ext[ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
+	__le32 tx_gi_ext[ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+		     [ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
+	__le32 ax_mu_mimo_tx_mcs_ext[ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
+	__le32 ofdma_tx_mcs_ext[ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
+	__le32 ax_tx_gi_ext[ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+				[ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
+	__le32 ofd_tx_gi_ext[ATH12K_HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+			   [ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA_MCS_COUNTERS];
+	__le32 tx_mcs_ext_2[ATH12K_HTT_TX_PDEV_STATS_NUM_EXTRA2_MCS_COUNTERS];
+	__le32 tx_bw_320mhz;
+};
+
 #define ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_MAC_ID	GENMASK(7, 0)
 #define ATH12K_HTT_TX_PDEV_STATS_SCHED_PER_TXQ_ID	GENMASK(15, 8)
 
-- 
2.34.1


