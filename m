Return-Path: <linux-wireless+bounces-14913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382319BC4B7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 06:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5351C21230
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 05:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6776C61;
	Tue,  5 Nov 2024 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MOEctFjw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584421B5EA4
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730784567; cv=none; b=juo/kjoBYdn9njHVHU1GxwMak2fY2rVVmqnleHutu8zQrzDqYD2R01r3RcQsFPm6E2g1TewBZn0LtyGDNsiDZBtLvKzZBENoe0ZS/n6tyRV2M3zupyEAmSC7hsfuh5KYhclhz8/qREox/I6u4c7xxZLYt4LeheEb7pg9yYlzwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730784567; c=relaxed/simple;
	bh=5sScZ8KZYzono+bi5ebHZwP0P3v2Ppo4KW+MZ5hFuL4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VNxxySbdxQqttZBqC5SStAWfS+zvV1xJK6ioKFSFI6EINtv1l5wj6Z8KqX8AOokkdU+9ViNCPLoclHk8l4Vob8C8khu8ZyV2OOGoULVfmLoFBZARxre3Ogb3dpFi2BJbSu/HZzVOY93YtYKlcV0taGjRBFay3WCOyMediMKIcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MOEctFjw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4LIkD8000895;
	Tue, 5 Nov 2024 05:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dj3ldKZsAemyyzsKGob8C7
	VWKhM77qSznpi3dgmtS8Q=; b=MOEctFjwzsY2VHPD8Rh4TXQ2pDHI92hPAL8zdH
	4a7/6Y14mNx8yvKAaGwQjtDzhoi2n41w8n61PHkSLGwMO8ZwiLLuFxPmAQZpICCV
	H/0TDXDBkeUpRhBB4Qx9yKHvtPcSN/TfphVbW7Mx5EhIhWTXmYEMaAydoY9rLsGd
	LkBJbFBIOZe/P+uCU2j2En8OJ8pHI7/iFIcTvCd6ni/LqX/A7+C2wkJlzqnT11/M
	tKM4YPTQj+2xDxTYjYfWf1PkikrsV7sdijYhzXOckoJEdnFVZlLk9gb5+PUSPBu+
	KrBTmNzOLVl7BcAz1237xveSMFRi1FgJeCwoXdO8AX53eKKA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd2s6ej6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 05:29:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A55TKg8011693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 05:29:20 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 4 Nov 2024 21:29:19 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sidhanta Sahu
	<quic_sidhanta@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: Support MBSSID Control Frame Stats
Date: Tue, 5 Nov 2024 10:58:54 +0530
Message-ID: <20241105052854.2118987-1-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i8w3_EyQYllRE3DelJwGmJB_fpzSR4gv
X-Proofpoint-GUID: i8w3_EyQYllRE3DelJwGmJB_fpzSR4gv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411050038

From: Sidhanta Sahu <quic_sidhanta@quicinc.com>

Add support to request MBSSID control frame stats from firmware
through HTT stats type 54. These stats give information such as
basic trigger, BSR trigger, multi-user RTS and uplink MUMIMO
trigger within and across various BSS.

Note: WCN7850 firmware version -
WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
support HTT stats type 54.

Sample output:
-------------
echo 54 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_MBSSID_CTRL_FRAME_STATS_TLV:
mac_id = 0
basic_trigger_across_bss = 0
basic_trigger_within_bss = 0
bsr_trigger_across_bss = 0
bsr_trigger_within_bss = 0
mu_rts_across_bss = 0
mu_rts_within_bss = 0
ul_mumimo_trigger_across_bss = 0
ul_mumimo_trigger_within_bss = 0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sidhanta Sahu <quic_sidhanta@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
Depends-on:
[PATCH v3 0/4] wifi: ath12k: Support Pager, Counter, SoC, Transmit Rate Stats
Link: https://lore.kernel.org/all/20241105045406.2098436-1-quic_rdevanat@quicinc.com/
---
v2:
 - Updated patch dependencies. No change in code.
---

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 43 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 14 ++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index e185d4971e79..81c5e84b4a38 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -3297,6 +3297,45 @@ ath12k_htt_print_tx_pdev_rate_stats_be_ofdma_tlv(const void *tag_buf, u16 tag_le
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_pdev_mbssid_ctrl_frame_stats_tlv(const void *tag_buf, u16 tag_len,
+						  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_mbssid_ctrl_frame_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_id_word;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id_word = le32_to_cpu(htt_stats_buf->mac_id__word);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_MBSSID_CTRL_FRAME_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "basic_trigger_across_bss = %u\n",
+			 le32_to_cpu(htt_stats_buf->basic_trigger_across_bss));
+	len += scnprintf(buf + len, buf_len - len, "basic_trigger_within_bss = %u\n",
+			 le32_to_cpu(htt_stats_buf->basic_trigger_within_bss));
+	len += scnprintf(buf + len, buf_len - len, "bsr_trigger_across_bss = %u\n",
+			 le32_to_cpu(htt_stats_buf->bsr_trigger_across_bss));
+	len += scnprintf(buf + len, buf_len - len, "bsr_trigger_within_bss = %u\n",
+			 le32_to_cpu(htt_stats_buf->bsr_trigger_within_bss));
+	len += scnprintf(buf + len, buf_len - len, "mu_rts_across_bss = %u\n",
+			 le32_to_cpu(htt_stats_buf->mu_rts_across_bss));
+	len += scnprintf(buf + len, buf_len - len, "mu_rts_within_bss = %u\n",
+			 le32_to_cpu(htt_stats_buf->mu_rts_within_bss));
+	len += scnprintf(buf + len, buf_len - len, "ul_mumimo_trigger_across_bss = %u\n",
+			 le32_to_cpu(htt_stats_buf->ul_mumimo_trigger_across_bss));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ul_mumimo_trigger_within_bss = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->ul_mumimo_trigger_within_bss));
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -3503,6 +3542,10 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_PDEV_RATE_STATS_BE_OFDMA_TAG:
 		ath12k_htt_print_tx_pdev_rate_stats_be_ofdma_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PDEV_MBSSID_CTRL_FRAME_STATS_TAG:
+		ath12k_htt_print_pdev_mbssid_ctrl_frame_stats_tlv(tag_buf, len,
+								  stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index d199bed0a9d1..cf3c88f8d1b2 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -142,6 +142,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
 	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
+	ATH12K_DGB_HTT_EXT_STATS_PDEV_MBSSID_CTRL_FRAME	= 54,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -214,6 +215,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_DMAC_RESET_STATS_TAG			= 155,
 	HTT_STATS_PHY_TPC_STATS_TAG			= 157,
 	HTT_STATS_PDEV_SCHED_ALGO_OFDMA_STATS_TAG	= 165,
+	HTT_STATS_PDEV_MBSSID_CTRL_FRAME_STATS_TAG	= 176,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -1322,4 +1324,16 @@ struct ath12k_htt_tx_pdev_rate_stats_be_ofdma_tlv {
 	__le32 be_ofdma_eht_sig_mcs[ATH12K_HTT_TX_PDEV_NUM_EHT_SIG_MCS_CNTRS];
 } __packed;
 
+struct ath12k_htt_pdev_mbssid_ctrl_frame_tlv {
+	__le32 mac_id__word;
+	__le32 basic_trigger_across_bss;
+	__le32 basic_trigger_within_bss;
+	__le32 bsr_trigger_across_bss;
+	__le32 bsr_trigger_within_bss;
+	__le32 mu_rts_across_bss;
+	__le32 mu_rts_within_bss;
+	__le32 ul_mumimo_trigger_across_bss;
+	__le32 ul_mumimo_trigger_within_bss;
+} __packed;
+
 #endif

base-commit: d63fbff74ab1af1573c1dca20cfe1e876f8ffa62
prerequisite-patch-id: 0600221a9b42d9ccf36eb80b56c0be39abf0c966
prerequisite-patch-id: 449b08e50a8ccb41ad78babf452830b02e149897
prerequisite-patch-id: 306d8fa61e21551e249175fc09793e3839f60198
prerequisite-patch-id: b57b622e262da141b9de392cbe08284fe07b1b86
-- 
2.25.1


