Return-Path: <linux-wireless+bounces-13562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8A3991678
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 13:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302231C21452
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B624149013;
	Sat,  5 Oct 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bRzQKn39"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D0132103
	for <linux-wireless@vger.kernel.org>; Sat,  5 Oct 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127652; cv=none; b=QUK7+Uhj6EMafwSIMqAnlEhGVn2uwAFDNtEfv87cGs/sMKGoWu3w911NORm1r5ijRzXEMXHPnaXNWT8A7ssac37GYnqrmG8R2LETGWC5qMuacgCVc/Uh36Q5XBnIrccMmTqFUeh7Hdw+yRRspF+cW9U6AIvHG6VQl6P/V0zNFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127652; c=relaxed/simple;
	bh=5ePkbJbZNXPXmH3grAkWjcmURIQHw1C3eE+H/WlfmTs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c/TeImcLZK7tcD4H9jWohfbrdPJUTUjcca5XtGUv5ZA54rlJBwx9Ti9z+ADiwQZlGyOWlpNli72E07BkqLQj0lNJAHmAnxAmZKdkMIY7lxT7OynBV+YQfjeVRqvagOZ1ss4lnXg3vcaX+TFbrX9AaXcuClocp91ey9SydAL83X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bRzQKn39; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495AwgMc028719;
	Sat, 5 Oct 2024 11:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5HOkquft4CO27nngsUaabG
	KpL6aScG6VxhIedhbKSZU=; b=bRzQKn39Rbs7pQiPPLMlqBrNGiMD1AtvNzRqFE
	NBVARz6BqSKeHmUulyds010H50V5yUl/fXqbRpWwSiFIp/ApM4aoawJZ1YbTYhfa
	5cCmjkJwRZIMJ3IqSuMwfm+xm/Kl3Z6X3+mjrv7F9H4bnqbJZ1b5KuivLfdjlhKX
	cPWXJ+D29IUFMnhpWIJH5fug/CKc8uBU5dUt38EoEKKyM1AwwgN87mV5hvgcOsMC
	t6PpVL33u25jVX5TvClhi1E72k6QTttXcDcxM5dUbvpSjdSpvaAXRbkTP+zwG3J0
	EOWiy+hz7TfBgmEJp9Wh4Hq7/p66gcRGgN3tGM1/8pTC15fQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xq9rfcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Oct 2024 11:27:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 495BRQpl020172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 11:27:26 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Oct 2024 04:27:24 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sidhanta Sahu
	<quic_sidhanta@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH] wifi: ath12k: Support MBSSID Control Frame Stats
Date: Sat, 5 Oct 2024 16:56:51 +0530
Message-ID: <20241005112651.3379404-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dPyMeUpnwTgO8_G5Wg9kkhB4h8aivFli
X-Proofpoint-GUID: dPyMeUpnwTgO8_G5Wg9kkhB4h8aivFli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050085

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
[PATCH v2] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Link: https://lore.kernel.org/all/20241004085915.1788951-1-quic_rdevanat@quicinc.com/

[PATCH v2 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
Link: https://lore.kernel.org/ath12k/20241005101816.3314728-1-quic_rdevanat@quicinc.com/

[PATCH v2] wifi: ath12k: Support Pdev OBSS Stats
Link: https://lore.kernel.org/ath12k/20241005104206.3327143-1-quic_rdevanat@quicinc.com/

[PATCH v2] wifi: ath12k: Support DMAC Reset Stats
Link: https://lore.kernel.org/ath12k/20241005105207.3350790-1-quic_rdevanat@quicinc.com/

[PATCH v2 0/2] wifi: ath12k: Support pdev Rate, Scheduled Algorithm Stats
Link: https://lore.kernel.org/ath12k/20241005111506.3361688-1-quic_rdevanat@quicinc.com/

[PATCH v2 0/2] wifi: ath12k: Support AST and Puncture Stats
Link: https://lore.kernel.org/ath12k/20241005112234.3379043-1-quic_rdevanat@quicinc.com/
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 43 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 14 ++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 42d504d93c52..0d7ca78036ea 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2884,6 +2884,45 @@ ath12k_htt_print_tx_pdev_rate_stats_be_ofdma_tlv(const void *tag_buf, u16 tag_le
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
@@ -3072,6 +3111,10 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
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
index e6e2bcbe95a7..85838c01e925 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -140,6 +140,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_DBG_PDEV_PUNCTURE_STATS		= 46,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
 	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
+	ATH12K_DGB_HTT_EXT_STATS_PDEV_MBSSID_CTRL_FRAME	= 54,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -206,6 +207,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_DMAC_RESET_STATS_TAG			= 155,
 	HTT_STATS_PDEV_PUNCTURE_STATS_TAG		= 158,
 	HTT_STATS_PDEV_SCHED_ALGO_OFDMA_STATS_TAG	= 165,
+	HTT_STATS_PDEV_MBSSID_CTRL_FRAME_STATS_TAG	= 176,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -1178,4 +1180,16 @@ struct ath12k_htt_pdev_puncture_stats_tlv {
 	__le32 num_subbands_used_cnt[ATH12K_HTT_PUNCT_STATS_MAX_SUBBAND_CNT];
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

base-commit: 8ed36fe71fd60c851540839b105fd1fddc870c61
prerequisite-patch-id: faf46024c8b5c094e201d392109e7f94dcecdd49
prerequisite-patch-id: c4662f64bc7be141322b7e37145e52ea4ab4e182
prerequisite-patch-id: 4d37990775694f110ce3e87096231fe8855f09f5
prerequisite-patch-id: 5959fd18b497d29cad98d36dcce59a876ffe8ca2
prerequisite-patch-id: ecac67f6fce1dd4d5089dbc3da840e311f6a7218
prerequisite-patch-id: 0537ae604d2617e42bef13bfb791aad4d11bf6e1
prerequisite-patch-id: da5a4e5cc3097994bfcba4b37680c90b0675ccf9
prerequisite-patch-id: fcd0ce1adcc63e80c95e4636bd4614bd5b732ffa
prerequisite-patch-id: a6303524834f6e01b2ae1469ee437d586dd5d522
prerequisite-patch-id: d08cf80b89c5b8a8896f84449033a18455f3c394
prerequisite-patch-id: 00097b59822c40089419d22b97f109c26b7f0a10
-- 
2.25.1


