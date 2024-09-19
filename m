Return-Path: <linux-wireless+bounces-13016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79C97C7D7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 12:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C6B20C46
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6A333D8;
	Thu, 19 Sep 2024 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HLSqXbpL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86731922F2
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726741120; cv=none; b=hHZRxhalt9gnE984KM7Dzi3QbMFzpWKUa/+JMnKc4HWA1er/WIAXov5wXtXGozmmXf3TrRt+/eOZhe2SonmUDTNxMe3JEfGOah5xUxD8E+hK51DXPwVJCjLEojpMNnQK7ffUnABYL+8/6u323do0ZcKXHZ0JZy8h595rFmPbc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726741120; c=relaxed/simple;
	bh=ewDynr+gvIH8vY2XvELcrR16A6ORPGp2ciuzfw0uYHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GpZUeQ7wDMIhU+o4hQPfa+Ss80KMXKCmGkBxcqhL+8BSzLyzokyeV1RgDqN0k94ZsXB+ESjRa5Dmd949gfbicM6wcYnYEBm2VQhdP3H1N8J4GEA5TQEDMiFMwJU4eNjgBPwdHJEXgKC7aIrDn/rCoEz6D173xCzVE7va6NDqy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HLSqXbpL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JA6vWr023247;
	Thu, 19 Sep 2024 10:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2BdgiGby0KnqaazWcRYjCK
	Ro2KEq9zcNE0LDjo294Kc=; b=HLSqXbpLpcM91pqQGAtWAZUvOJX53W603ZGFsx
	LOKW7KWK5IKQE/GkstES1ifRgU251pRSt6ZaJHv3R4jcGvg1MfRsjW0SVXwYZ8Fw
	zovrZew8BAmgCCUszwJqPubcMQQEm/yRA6/9SF21puFtbKKz9QBNKp3tBV9pzA+i
	05iV58KoMQW6Zr6n12ahP9CGTBfxoZ6Pq8Xw2IAcf89k2fdkFXxnzM56SpmVZQxE
	6qv5rNJvKdIUTembepDpdjENrUyXuhNrHI1wAw7KAZDxpy0IMaqvlZpkxxd1Fm9U
	HOmvx6Nyr3fJL7qIpzGaSlWm5XDtQ9ICWH2/idZ+9bqSZkJA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4gnvymd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 10:18:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48JAITLj004938
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 10:18:29 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Sep 2024 03:18:28 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH] wifi: ath12k: Support Pdev OBSS Stats
Date: Thu, 19 Sep 2024 15:48:12 +0530
Message-ID: <20240919101812.941145-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: FzR6btkTSGynAYVNMh1eTxR8yW2mU4w9
X-Proofpoint-ORIG-GUID: FzR6btkTSGynAYVNMh1eTxR8yW2mU4w9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190066

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request pdev OBSS stats from firmware through stats
type 23. These stats give information about PPDUs transmitted or
tried to be transmitted in Spatial Reuse Groups(SRG), Parameterized
Spatial Reuse(PSR) and non-PSR groups.

Sample output:
-------------
echo 23 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_PDEV_OBSS_PD_STATS_TLV:
num_spatial_reuse_tx = 0
num_spatial_reuse_opportunities = 0
num_non_srg_opportunities = 0
num_non_srg_ppdu_tried = 0
.....

HTT_PDEV_OBSS_PD_PER_AC_STATS:
Access Category 0 (best effort)
num_non_srg_ppdu_tried = 0
num_non_srg_ppdu_success = 0
num_srg_ppdu_tried = 0
num_srg_ppdu_success = 0

Access Category 1 (background)
num_non_srg_ppdu_tried = 0
num_non_srg_ppdu_success = 0
num_srg_ppdu_tried = 0
num_srg_ppdu_success = 0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
Depends-on:
[PATCH] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Link: https://lore.kernel.org/linux-wireless/20240730035154.3723773-1-quic_rdevanat@quicinc.com/

[PATCH 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
Link: https://lore.kernel.org/linux-wireless/20240913082949.573482-4-quic_rdevanat@quicinc.com/T/
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 68 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 24 +++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 2c17e080a0e6..28cb9cc999f5 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2431,6 +2431,71 @@ ath12k_htt_print_pdev_stats_cca_counters_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
+					struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_obss_pd_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u8 i;
+	static const char *access_cat_names[ATH12K_HTT_NUM_AC_WMM] = {"best effort",
+								      "background",
+								      "video", "voice"};
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_OBSS_PD_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "num_spatial_reuse_tx = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_sr_tx_transmissions));
+	len += scnprintf(buf + len, buf_len - len,
+			 "num_spatial_reuse_opportunities = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_spatial_reuse_opportunities));
+	len += scnprintf(buf + len, buf_len - len, "num_non_srg_opportunities = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_non_srg_opportunities));
+	len += scnprintf(buf + len, buf_len - len, "num_non_srg_ppdu_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_non_srg_ppdu_tried));
+	len += scnprintf(buf + len, buf_len - len, "num_non_srg_ppdu_success = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_non_srg_ppdu_success));
+	len += scnprintf(buf + len, buf_len - len, "num_srg_opportunities = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_srg_opportunities));
+	len += scnprintf(buf + len, buf_len - len, "num_srg_ppdu_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_srg_ppdu_tried));
+	len += scnprintf(buf + len, buf_len - len, "num_srg_ppdu_success = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_srg_ppdu_success));
+	len += scnprintf(buf + len, buf_len - len, "num_psr_opportunities = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_psr_opportunities));
+	len += scnprintf(buf + len, buf_len - len, "num_psr_ppdu_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_psr_ppdu_tried));
+	len += scnprintf(buf + len, buf_len - len, "num_psr_ppdu_success = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_psr_ppdu_success));
+	len += scnprintf(buf + len, buf_len - len, "min_duration_check_flush_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_obss_min_dur_check_flush_cnt));
+	len += scnprintf(buf + len, buf_len - len, "sr_ppdu_abort_flush_cnt = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->num_sr_ppdu_abort_flush_cnt));
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_OBSS_PD_PER_AC_STATS:\n");
+	for (i = 0; i < ATH12K_HTT_NUM_AC_WMM; i++) {
+		len += scnprintf(buf + len, buf_len - len, "Access Category %u (%s)\n",
+				 i, access_cat_names[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "num_non_srg_ppdu_tried = %u\n",
+				 le32_to_cpu(htt_stats_buf->num_non_srg_tried_per_ac[i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "num_non_srg_ppdu_success = %u\n",
+				 le32_to_cpu(htt_stats_buf->num_non_srg_success_ac[i]));
+		len += scnprintf(buf + len, buf_len - len, "num_srg_ppdu_tried = %u\n",
+				 le32_to_cpu(htt_stats_buf->num_srg_tried_per_ac[i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "num_srg_ppdu_success = %u\n\n",
+				 le32_to_cpu(htt_stats_buf->num_srg_success_per_ac[i]));
+	}
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -2601,6 +2666,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_CCA_COUNTERS_TAG:
 		ath12k_htt_print_pdev_stats_cca_counters_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PDEV_OBSS_PD_TAG:
+		ath12k_htt_print_pdev_obss_pd_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index b37ba1256ce5..597334830d02 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -134,6 +134,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_SFM_INFO		= 16,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -184,6 +185,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_PDEV_MPDU_STATS_TAG		= 74,
 	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG		= 86,
 	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG	= 87,
+	HTT_STATS_PDEV_OBSS_PD_TAG			= 88,
 	HTT_STATS_HW_WAR_TAG				= 89,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
@@ -1024,4 +1026,26 @@ struct ath12k_htt_pdev_cca_stats_hist_v1_tlv {
 	__le32 collection_interval;
 } __packed;
 
+struct ath12k_htt_pdev_obss_pd_stats_tlv {
+	__le32 num_obss_tx_ppdu_success;
+	__le32 num_obss_tx_ppdu_failure;
+	__le32 num_sr_tx_transmissions;
+	__le32 num_spatial_reuse_opportunities;
+	__le32 num_non_srg_opportunities;
+	__le32 num_non_srg_ppdu_tried;
+	__le32 num_non_srg_ppdu_success;
+	__le32 num_srg_opportunities;
+	__le32 num_srg_ppdu_tried;
+	__le32 num_srg_ppdu_success;
+	__le32 num_psr_opportunities;
+	__le32 num_psr_ppdu_tried;
+	__le32 num_psr_ppdu_success;
+	__le32 num_non_srg_tried_per_ac[ATH12K_HTT_NUM_AC_WMM];
+	__le32 num_non_srg_success_ac[ATH12K_HTT_NUM_AC_WMM];
+	__le32 num_srg_tried_per_ac[ATH12K_HTT_NUM_AC_WMM];
+	__le32 num_srg_success_per_ac[ATH12K_HTT_NUM_AC_WMM];
+	__le32 num_obss_min_dur_check_flush_cnt;
+	__le32 num_sr_ppdu_abort_flush_cnt;
+} __packed;
+
 #endif

base-commit: 92de67902177c2ea65000a87a6b24fed17d48a18
prerequisite-patch-id: 970109034faa25a7630720c0da29c875e821f9ec
prerequisite-patch-id: 0bda913781a634c055869a033aa9b34d10825a20
prerequisite-patch-id: 4d37990775694f110ce3e87096231fe8855f09f5
prerequisite-patch-id: 121409543edef60c5f6144dd7ae3a615a78520f7
prerequisite-patch-id: ecac67f6fce1dd4d5089dbc3da840e311f6a7218
-- 
2.25.1


