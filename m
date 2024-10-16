Return-Path: <linux-wireless+bounces-14033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BDB9A0166
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97FF283E24
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3218D624;
	Wed, 16 Oct 2024 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OxrP+iWG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A97156E4
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060013; cv=none; b=h/R7XDq9l4GUp4teuKeqgXd2Y6FzWL8oBZX6RZKJ2+TzMxJIqvPlKRRseh3BpnFQ/VJpj+Y/C7SD71yADWMVAQzd448Rq3XNHrIbb9FqUQwfLcHk43q3Y19YmPvedzfIw/qd6xoSjS+n2KvWYY17vExOsglGaVfA5fmq17t2a34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060013; c=relaxed/simple;
	bh=rMDH0jZGm6J8gLnRlr/BQ07aUp4yHdNMRXxrY+tHzGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7I3Y5fKjdVnU6DTQbt560NnyIZ9kSrjKcfsf6K5J1d8YfiGKgHNjLlWZ1fyI5F/nimY3gIphv7hB2YpbgyacL6LZKxRIm5E1wfLqtP0t5wtVflb0wUwhrLS8hluHCdM2c3pME53bjVc9ZbmIthhp7b3vu0jKG46msJ77PuKRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OxrP+iWG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G4F39c027096;
	Wed, 16 Oct 2024 06:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h2AIGmk6EhpsbhfUbtvxLVkFSim1KezQ+c+o1j1xPaU=; b=OxrP+iWGVBg23rmL
	ZOG+kUBJ8ROrCNBEbJgbAWWf70C39/p4MF1clZKkxyVXrzbMh4au1OZscx1fheem
	zwR7SJK93oWE3xYUdeqxB/91DPXNgO2BJSOWcA1nupCcGAFA4tpJ9l4YiPPryCFs
	mIZR4f88HQzi25vUQncSPP3xMjNRLqp4EV4nsXDX2fexDcOlbsfXo1FKWfycHkWd
	rymU4XkgoUFAr0oMV7Ih1G1qfFLtNe/Ot1ul+/AEwBFOvA3LNswgQdsXfk1mkyOe
	gP1JqP8d8iRJqJeja/u6wNmiSRRRQz4GNhl1PVpVc9SgdOjwdLYGsTHsbGZYoX2i
	FCKRjQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429m0fbje0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:26:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G6Qk64001774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 06:26:46 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 23:26:44 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 2/4] wifi: ath12k: Support phy counter and TPC stats
Date: Wed, 16 Oct 2024 11:56:15 +0530
Message-ID: <20241016062617.2726252-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016062617.2726252-1-quic_rdevanat@quicinc.com>
References: <20241016062617.2726252-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: PGugXlUVGPD1NZpNs3Xr8AtuLYKnLLt2
X-Proofpoint-ORIG-GUID: PGugXlUVGPD1NZpNs3Xr8AtuLYKnLLt2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160041

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request counters and Transmission Power Control
(TPC) stats through HTT stats type 37. These stats give
information about counters like received packet count, CRC pass
count, error count, transmit abort count, etc., about counter reset
like reset cause, channel frequency, number and mode, channel flags,
etc., about TPC like transmit power scale, maximum transmit power,
gain cap, EIRP, etc.

Note: MCC firmware version -
WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
support HTT stats type 37, i.e., the firmware does not respond to the
event requesting stats.

Sample output:
-------------
echo 37 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_PHY_STATS_TLV:
bdf_nf_chain[0] = -92
bdf_nf_chain[1] = -94
bdf_nf_chain[2] = -94
bdf_nf_chain[3] = -93
.....

HTT_PHY_COUNTERS_TLV:
rx_ofdma_timing_err_cnt = 18068
rx_cck_fail_cnt = 0
mactx_abort_cnt = 2612
macrx_abort_cnt = 0
.....

HTT_PHY_RESET_STATS_TLV:
pdev_id = 0
chan_mhz = 0
chan_band_center_freq1 = 0
chan_band_center_freq2 = 0
.....

HTT_PHY_RESET_COUNTERS_TLV:
pdev_id = 0
cf_active_low_fail_cnt = 0
cf_active_low_pass_cnt = 0
phy_off_through_vreg_cnt = 0
.....

HTT_PHY_TPC_STATS_TLV:
pdev_id = 0
tx_power_scale = 0
tx_power_scale_db = 0
min_negative_tx_power = 0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 249 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  98 +++++++
 2 files changed, 347 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 230941626b3d..0476a8f6c6bc 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2625,6 +2625,240 @@ ath12k_htt_print_dlpager_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_phy_stats_tlv(const void *tag_buf, u16 tag_len,
+			       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_phy_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u8 i;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PHY_STATS_TLV:\n");
+	for (i = 0; i < ATH12K_HTT_STATS_MAX_CHAINS; i++)
+		len += scnprintf(buf + len, buf_len - len, "bdf_nf_chain[%d] = %d\n",
+				 i, a_sle32_to_cpu(htt_stats_buf->nf_chain[i]));
+	for (i = 0; i < ATH12K_HTT_STATS_MAX_CHAINS; i++)
+		len += scnprintf(buf + len, buf_len - len, "runtime_nf_chain[%d] = %d\n",
+				 i, a_sle32_to_cpu(htt_stats_buf->runtime_nf_chain[i]));
+	len += scnprintf(buf + len, buf_len - len, "false_radar_cnt = %u / %u (mins)\n",
+			 le32_to_cpu(htt_stats_buf->false_radar_cnt),
+			 le32_to_cpu(htt_stats_buf->fw_run_time));
+	len += scnprintf(buf + len, buf_len - len, "radar_cs_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->radar_cs_cnt));
+	len += scnprintf(buf + len, buf_len - len, "ani_level = %d\n\n",
+			 a_sle32_to_cpu(htt_stats_buf->ani_level));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_phy_counters_tlv(const void *tag_buf, u16 tag_len,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_phy_counters_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PHY_COUNTERS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "rx_ofdma_timing_err_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_ofdma_timing_err_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_cck_fail_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_cck_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "mactx_abort_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mactx_abort_cnt));
+	len += scnprintf(buf + len, buf_len - len, "macrx_abort_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->macrx_abort_cnt));
+	len += scnprintf(buf + len, buf_len - len, "phytx_abort_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->phytx_abort_cnt));
+	len += scnprintf(buf + len, buf_len - len, "phyrx_abort_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->phyrx_abort_cnt));
+	len += scnprintf(buf + len, buf_len - len, "phyrx_defer_abort_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->phyrx_defer_abort_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_gain_adj_lstf_event_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_gain_adj_lstf_event_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_gain_adj_non_legacy_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_gain_adj_non_legacy_cnt));
+	len += print_array_to_buf(buf, len, "rx_pkt_cnt", htt_stats_buf->rx_pkt_cnt,
+				  ATH12K_HTT_MAX_RX_PKT_CNT, "\n");
+	len += print_array_to_buf(buf, len, "rx_pkt_crc_pass_cnt",
+				  htt_stats_buf->rx_pkt_crc_pass_cnt,
+				  ATH12K_HTT_MAX_RX_PKT_CRC_PASS_CNT, "\n");
+	len += print_array_to_buf(buf, len, "per_blk_err_cnt",
+				  htt_stats_buf->per_blk_err_cnt,
+				  ATH12K_HTT_MAX_PER_BLK_ERR_CNT, "\n");
+	len += print_array_to_buf(buf, len, "rx_ota_err_cnt",
+				  htt_stats_buf->rx_ota_err_cnt,
+				  ATH12K_HTT_MAX_RX_OTA_ERR_CNT, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_phy_reset_stats_tlv(const void *tag_buf, u16 tag_len,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_phy_reset_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PHY_RESET_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 le32_to_cpu(htt_stats_buf->pdev_id));
+	len += scnprintf(buf + len, buf_len - len, "chan_mhz = %u\n",
+			 le32_to_cpu(htt_stats_buf->chan_mhz));
+	len += scnprintf(buf + len, buf_len - len, "chan_band_center_freq1 = %u\n",
+			 le32_to_cpu(htt_stats_buf->chan_band_center_freq1));
+	len += scnprintf(buf + len, buf_len - len, "chan_band_center_freq2 = %u\n",
+			 le32_to_cpu(htt_stats_buf->chan_band_center_freq2));
+	len += scnprintf(buf + len, buf_len - len, "chan_phy_mode = %u\n",
+			 le32_to_cpu(htt_stats_buf->chan_phy_mode));
+	len += scnprintf(buf + len, buf_len - len, "chan_flags = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->chan_flags));
+	len += scnprintf(buf + len, buf_len - len, "chan_num = %u\n",
+			 le32_to_cpu(htt_stats_buf->chan_num));
+	len += scnprintf(buf + len, buf_len - len, "reset_cause = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->reset_cause));
+	len += scnprintf(buf + len, buf_len - len, "prev_reset_cause = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->prev_reset_cause));
+	len += scnprintf(buf + len, buf_len - len, "phy_warm_reset_src = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->phy_warm_reset_src));
+	len += scnprintf(buf + len, buf_len - len, "rx_gain_tbl_mode = %d\n",
+			 le32_to_cpu(htt_stats_buf->rx_gain_tbl_mode));
+	len += scnprintf(buf + len, buf_len - len, "xbar_val = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->xbar_val));
+	len += scnprintf(buf + len, buf_len - len, "force_calibration = %u\n",
+			 le32_to_cpu(htt_stats_buf->force_calibration));
+	len += scnprintf(buf + len, buf_len - len, "phyrf_mode = %u\n",
+			 le32_to_cpu(htt_stats_buf->phyrf_mode));
+	len += scnprintf(buf + len, buf_len - len, "phy_homechan = %u\n",
+			 le32_to_cpu(htt_stats_buf->phy_homechan));
+	len += scnprintf(buf + len, buf_len - len, "phy_tx_ch_mask = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->phy_tx_ch_mask));
+	len += scnprintf(buf + len, buf_len - len, "phy_rx_ch_mask = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->phy_rx_ch_mask));
+	len += scnprintf(buf + len, buf_len - len, "phybb_ini_mask = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->phybb_ini_mask));
+	len += scnprintf(buf + len, buf_len - len, "phyrf_ini_mask = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->phyrf_ini_mask));
+	len += scnprintf(buf + len, buf_len - len, "phy_dfs_en_mask = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->phy_dfs_en_mask));
+	len += scnprintf(buf + len, buf_len - len, "phy_sscan_en_mask = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->phy_sscan_en_mask));
+	len += scnprintf(buf + len, buf_len - len, "phy_synth_sel_mask = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->phy_synth_sel_mask));
+	len += scnprintf(buf + len, buf_len - len, "phy_adfs_freq = %u\n",
+			 le32_to_cpu(htt_stats_buf->phy_adfs_freq));
+	len += scnprintf(buf + len, buf_len - len, "cck_fir_settings = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->cck_fir_settings));
+	len += scnprintf(buf + len, buf_len - len, "phy_dyn_pri_chan = %u\n",
+			 le32_to_cpu(htt_stats_buf->phy_dyn_pri_chan));
+	len += scnprintf(buf + len, buf_len - len, "cca_thresh = 0x%0x\n",
+			 le32_to_cpu(htt_stats_buf->cca_thresh));
+	len += scnprintf(buf + len, buf_len - len, "dyn_cca_status = %u\n",
+			 le32_to_cpu(htt_stats_buf->dyn_cca_status));
+	len += scnprintf(buf + len, buf_len - len, "rxdesense_thresh_hw = 0x%x\n",
+			 le32_to_cpu(htt_stats_buf->rxdesense_thresh_hw));
+	len += scnprintf(buf + len, buf_len - len, "rxdesense_thresh_sw = 0x%x\n\n",
+			 le32_to_cpu(htt_stats_buf->rxdesense_thresh_sw));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_phy_reset_counters_tlv(const void *tag_buf, u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_phy_reset_counters_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PHY_RESET_COUNTERS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 le32_to_cpu(htt_stats_buf->pdev_id));
+	len += scnprintf(buf + len, buf_len - len, "cf_active_low_fail_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->cf_active_low_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "cf_active_low_pass_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->cf_active_low_pass_cnt));
+	len += scnprintf(buf + len, buf_len - len, "phy_off_through_vreg_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->phy_off_through_vreg_cnt));
+	len += scnprintf(buf + len, buf_len - len, "force_calibration_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->force_calibration_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rf_mode_switch_phy_off_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rf_mode_switch_phy_off_cnt));
+	len += scnprintf(buf + len, buf_len - len, "temperature_recal_cnt = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->temperature_recal_cnt));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_phy_tpc_stats_tlv(const void *tag_buf, u16 tag_len,
+				   struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_phy_tpc_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PHY_TPC_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 le32_to_cpu(htt_stats_buf->pdev_id));
+	len += scnprintf(buf + len, buf_len - len, "tx_power_scale = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_power_scale));
+	len += scnprintf(buf + len, buf_len - len, "tx_power_scale_db = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_power_scale_db));
+	len += scnprintf(buf + len, buf_len - len, "min_negative_tx_power = %d\n",
+			 le32_to_cpu(htt_stats_buf->min_negative_tx_power));
+	len += scnprintf(buf + len, buf_len - len, "reg_ctl_domain = %u\n",
+			 le32_to_cpu(htt_stats_buf->reg_ctl_domain));
+	len += scnprintf(buf + len, buf_len - len, "twice_max_rd_power = %u\n",
+			 le32_to_cpu(htt_stats_buf->twice_max_rd_power));
+	len += scnprintf(buf + len, buf_len - len, "max_tx_power = %u\n",
+			 le32_to_cpu(htt_stats_buf->max_tx_power));
+	len += scnprintf(buf + len, buf_len - len, "home_max_tx_power = %u\n",
+			 le32_to_cpu(htt_stats_buf->home_max_tx_power));
+	len += scnprintf(buf + len, buf_len - len, "psd_power = %d\n",
+			 le32_to_cpu(htt_stats_buf->psd_power));
+	len += scnprintf(buf + len, buf_len - len, "eirp_power = %u\n",
+			 le32_to_cpu(htt_stats_buf->eirp_power));
+	len += scnprintf(buf + len, buf_len - len, "power_type_6ghz = %u\n",
+			 le32_to_cpu(htt_stats_buf->power_type_6ghz));
+	len += print_array_to_buf(buf, len, "max_reg_allowed_power",
+				  htt_stats_buf->max_reg_allowed_power,
+				  ATH12K_HTT_STATS_MAX_CHAINS, "\n");
+	len += print_array_to_buf(buf, len, "max_reg_allowed_power_6ghz",
+				  htt_stats_buf->max_reg_allowed_power_6ghz,
+				  ATH12K_HTT_STATS_MAX_CHAINS, "\n");
+	len += print_array_to_buf(buf, len, "sub_band_cfreq",
+				  htt_stats_buf->sub_band_cfreq,
+				  ATH12K_HTT_MAX_CH_PWR_INFO_SIZE, "\n");
+	len += print_array_to_buf(buf, len, "sub_band_txpower",
+				  htt_stats_buf->sub_band_txpower,
+				  ATH12K_HTT_MAX_CH_PWR_INFO_SIZE, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
 static void
 ath12k_htt_print_ast_entry_tlv(const void *tag_buf, u16 tag_len,
 			       struct debug_htt_stats_req *stats_req)
@@ -3190,6 +3424,21 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_DLPAGER_STATS_TAG:
 		ath12k_htt_print_dlpager_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PHY_STATS_TAG:
+		ath12k_htt_print_phy_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PHY_COUNTERS_TAG:
+		ath12k_htt_print_phy_counters_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PHY_RESET_STATS_TAG:
+		ath12k_htt_print_phy_reset_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PHY_RESET_COUNTERS_TAG:
+		ath12k_htt_print_phy_reset_counters_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PHY_TPC_STATS_TAG:
+		ath12k_htt_print_phy_tpc_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_AST_ENTRY_TAG:
 		ath12k_htt_print_ast_entry_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 7d79cad91ec2..877c619093f2 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -136,6 +136,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
 	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
+	ATH12K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	= 37,
 	ATH12K_DBG_HTT_EXT_AST_ENTRIES			= 41,
 	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
 	ATH12K_DBG_HTT_DBG_PDEV_PUNCTURE_STATS		= 46,
@@ -199,6 +200,10 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SELFGEN_AC_SCHED_STATUS_STATS_TAG	= 111,
 	HTT_STATS_TX_SELFGEN_AX_SCHED_STATUS_STATS_TAG	= 112,
 	HTT_STATS_DLPAGER_STATS_TAG			= 120,
+	HTT_STATS_PHY_COUNTERS_TAG			= 121,
+	HTT_STATS_PHY_STATS_TAG				= 122,
+	HTT_STATS_PHY_RESET_COUNTERS_TAG		= 123,
+	HTT_STATS_PHY_RESET_STATS_TAG			= 124,
 	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
 	HTT_STATS_TX_PDEV_MUMIMO_GRP_STATS_TAG		= 130,
 	HTT_STATS_AST_ENTRY_TAG				= 132,
@@ -207,6 +212,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
 	HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG	= 139,
 	HTT_STATS_DMAC_RESET_STATS_TAG			= 155,
+	HTT_STATS_PHY_TPC_STATS_TAG			= 157,
 	HTT_STATS_PDEV_PUNCTURE_STATS_TAG		= 158,
 	HTT_STATS_PDEV_SCHED_ALGO_OFDMA_STATS_TAG	= 165,
 	HTT_STATS_PDEV_MBSSID_CTRL_FRAME_STATS_TAG	= 176,
@@ -1091,6 +1097,98 @@ struct ath12k_htt_dl_pager_stats_tlv {
 	struct ath12k_htt_pgs_info pgs_info[ATH12K_NUM_PG_LOCK_STATE][ATH12K_PAGER_MAX];
 } __packed;
 
+#define ATH12K_HTT_STATS_MAX_CHAINS		8
+#define ATH12K_HTT_MAX_RX_PKT_CNT		8
+#define ATH12K_HTT_MAX_RX_PKT_CRC_PASS_CNT	8
+#define ATH12K_HTT_MAX_PER_BLK_ERR_CNT		20
+#define ATH12K_HTT_MAX_RX_OTA_ERR_CNT		14
+#define ATH12K_HTT_MAX_CH_PWR_INFO_SIZE		16
+
+struct ath12k_htt_phy_stats_tlv {
+	a_sle32 nf_chain[ATH12K_HTT_STATS_MAX_CHAINS];
+	__le32 false_radar_cnt;
+	__le32 radar_cs_cnt;
+	a_sle32 ani_level;
+	__le32 fw_run_time;
+	a_sle32 runtime_nf_chain[ATH12K_HTT_STATS_MAX_CHAINS];
+} __packed;
+
+struct ath12k_htt_phy_counters_tlv {
+	__le32 rx_ofdma_timing_err_cnt;
+	__le32 rx_cck_fail_cnt;
+	__le32 mactx_abort_cnt;
+	__le32 macrx_abort_cnt;
+	__le32 phytx_abort_cnt;
+	__le32 phyrx_abort_cnt;
+	__le32 phyrx_defer_abort_cnt;
+	__le32 rx_gain_adj_lstf_event_cnt;
+	__le32 rx_gain_adj_non_legacy_cnt;
+	__le32 rx_pkt_cnt[ATH12K_HTT_MAX_RX_PKT_CNT];
+	__le32 rx_pkt_crc_pass_cnt[ATH12K_HTT_MAX_RX_PKT_CRC_PASS_CNT];
+	__le32 per_blk_err_cnt[ATH12K_HTT_MAX_PER_BLK_ERR_CNT];
+	__le32 rx_ota_err_cnt[ATH12K_HTT_MAX_RX_OTA_ERR_CNT];
+} __packed;
+
+struct ath12k_htt_phy_reset_stats_tlv {
+	__le32 pdev_id;
+	__le32 chan_mhz;
+	__le32 chan_band_center_freq1;
+	__le32 chan_band_center_freq2;
+	__le32 chan_phy_mode;
+	__le32 chan_flags;
+	__le32 chan_num;
+	__le32 reset_cause;
+	__le32 prev_reset_cause;
+	__le32 phy_warm_reset_src;
+	__le32 rx_gain_tbl_mode;
+	__le32 xbar_val;
+	__le32 force_calibration;
+	__le32 phyrf_mode;
+	__le32 phy_homechan;
+	__le32 phy_tx_ch_mask;
+	__le32 phy_rx_ch_mask;
+	__le32 phybb_ini_mask;
+	__le32 phyrf_ini_mask;
+	__le32 phy_dfs_en_mask;
+	__le32 phy_sscan_en_mask;
+	__le32 phy_synth_sel_mask;
+	__le32 phy_adfs_freq;
+	__le32 cck_fir_settings;
+	__le32 phy_dyn_pri_chan;
+	__le32 cca_thresh;
+	__le32 dyn_cca_status;
+	__le32 rxdesense_thresh_hw;
+	__le32 rxdesense_thresh_sw;
+} __packed;
+
+struct ath12k_htt_phy_reset_counters_tlv {
+	__le32 pdev_id;
+	__le32 cf_active_low_fail_cnt;
+	__le32 cf_active_low_pass_cnt;
+	__le32 phy_off_through_vreg_cnt;
+	__le32 force_calibration_cnt;
+	__le32 rf_mode_switch_phy_off_cnt;
+	__le32 temperature_recal_cnt;
+} __packed;
+
+struct ath12k_htt_phy_tpc_stats_tlv {
+	__le32 pdev_id;
+	__le32 tx_power_scale;
+	__le32 tx_power_scale_db;
+	__le32 min_negative_tx_power;
+	__le32 reg_ctl_domain;
+	__le32 max_reg_allowed_power[ATH12K_HTT_STATS_MAX_CHAINS];
+	__le32 max_reg_allowed_power_6ghz[ATH12K_HTT_STATS_MAX_CHAINS];
+	__le32 twice_max_rd_power;
+	__le32 max_tx_power;
+	__le32 home_max_tx_power;
+	__le32 psd_power;
+	__le32 eirp_power;
+	__le32 power_type_6ghz;
+	__le32 sub_band_cfreq[ATH12K_HTT_MAX_CH_PWR_INFO_SIZE];
+	__le32 sub_band_txpower[ATH12K_HTT_MAX_CH_PWR_INFO_SIZE];
+} __packed;
+
 struct ath12k_htt_dmac_reset_stats_tlv {
 	__le32 reset_count;
 	__le32 reset_time_lo_ms;
-- 
2.25.1


