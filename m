Return-Path: <linux-wireless+bounces-13219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAD9986BF0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 07:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A97B1C21DCD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 05:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13BF38FA6;
	Thu, 26 Sep 2024 05:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j5KLyBCG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95AA175B1
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 05:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727327494; cv=none; b=Wuv4sATc1OxgcMVrwMgMBre7Y8z35poJx4zBnIgT/xkJCh4WUOuz0HskGZbPMo567a4FR2NWWvwjsXs+AZHzOjOaspAnJAbBFKvTgW4EdnXDkEEPmHF0p3P6K/3SBZQY4p/o+A0QZuK83nswPS7yxzRRdpjC9+qfvn/VLCVOBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727327494; c=relaxed/simple;
	bh=zFofxwckDai9AJJUr7kuc+68KmY0s3OsEq08d9inLsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PL1w5tLbGYWRUX2y0oPapEjAYBZaO9YEBoUIAXXYQfyI6hfWRveKmH68EJB8ZOXXdeP8l2m8GTXk2GSe4Ln8BBbfIGFem8/7CI5kQK09fffvVigZiQ7vt7We3jRF+DK0o54wjr1RHApLQJHHqPicGc3NUru/qTGevldzr2BxQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j5KLyBCG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PH5CCd027645;
	Thu, 26 Sep 2024 05:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4Ey0N/NAYSoksdCp8ztvWo
	LDlENbpHXPEwpOrq8o09A=; b=j5KLyBCGYCydH4dNRx3ES2Z6TLBnXYRMEW40W3
	HhqrlhXkyrHHdKthpGSrv8u1gUPWIeR9K9YqvFbrQ9/VpKjRCEVSclejrvj7iCQV
	9Q4/w+gl3BUcrs07HONv1lX3fNgqQbjQKl+cGHz2E5C+79fS9kXRkKDmlsHe1rQL
	rO67jQ64es+FsQG8PmfhE/Sfv/1B8tK+vCqX8NtwN9wVK98XzC1Efgg2VOJqtYPA
	gHn9Y4OcMlzKv2xvyxjVO8b+p3IFwEdlwuG7V5bBQOxRV9kOZTQgA8VWjZqbOra6
	OSFL/rkP5EQwVi2Fg+0iwbSUSv+J3X+2ITxsKyHyhS35MzrQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41spc2x7dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 05:11:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48Q5BRV4026867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 05:11:27 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 25 Sep 2024 22:11:25 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH] wifi: ath12k: Support DMAC Reset Stats
Date: Thu, 26 Sep 2024 10:41:10 +0530
Message-ID: <20240926051110.2477814-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: LBpzg9XWXoOrfOZWZW9jFcfvF2XdPUDe
X-Proofpoint-ORIG-GUID: LBpzg9XWXoOrfOZWZW9jFcfvF2XdPUDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260032

From: Rajat Soni <quic_rajson@quicinc.com>

Add support to request DMAC reset stats from firmware through HTT stats
type 45. These stats give debug SoC error stats such as reset count, reset
time, engage time and count, disengage time and count and destination
ring mask.

Sample output:
-------------
echo 45 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_DMAC_RESET_STATS_TLV:
reset_count = 1
reset_time_ms = 8036717648
disengage_time_ms = 8036717648
engage_time_ms = 8036717649
disengage_count = 1
engage_count = 1
drain_dest_ring_mask = 0x0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
Depends-on:
[PATCH] wifi: ath12k: Modify print_array_to_buf() to support arrays with 1-based semantics
Link: https://lore.kernel.org/linux-wireless/20240730035154.3723773-1-quic_rdevanat@quicinc.com/

[PATCH 0/4] wifi: ath12k: Support Ring, SFM, Transmit MU, SelfGen stats, CCA stats
Link: https://lore.kernel.org/linux-wireless/20240913082949.573482-4-quic_rdevanat@quicinc.com/T/

[PATCH] wifi: ath12k: Support Pdev OBSS Stats
Link: https://lore.kernel.org/linux-wireless/20240919101812.941145-1-quic_rdevanat@quicinc.com/
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 41 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 15 +++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 28cb9cc999f5..64aed7990dfd 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2496,6 +2496,44 @@ ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
+				      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_dmac_reset_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	unsigned long time;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_DMAC_RESET_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "reset_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->reset_count));
+	time = ((unsigned long)le32_to_cpu(htt_stats_buf->reset_time_hi_ms) << 32) |
+		le32_to_cpu(htt_stats_buf->reset_time_lo_ms);
+	len += scnprintf(buf + len, buf_len - len, "reset_time_ms = %ld\n", time);
+
+	time = ((unsigned long)le32_to_cpu(htt_stats_buf->disengage_time_hi_ms) << 32) |
+		le32_to_cpu(htt_stats_buf->disengage_time_lo_ms);
+	len += scnprintf(buf + len, buf_len - len, "disengage_time_ms = %ld\n", time);
+
+	time = ((unsigned long)le32_to_cpu(htt_stats_buf->engage_time_hi_ms) << 32) |
+		le32_to_cpu(htt_stats_buf->engage_time_lo_ms);
+	len += scnprintf(buf + len, buf_len - len, "engage_time_ms = %ld\n", time);
+
+	len += scnprintf(buf + len, buf_len - len, "disengage_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->disengage_count));
+	len += scnprintf(buf + len, buf_len - len, "engage_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->engage_count));
+	len += scnprintf(buf + len, buf_len - len, "drain_dest_ring_mask = 0x%x\n\n",
+			 le32_to_cpu(htt_stats_buf->drain_dest_ring_mask));
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -2669,6 +2707,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_OBSS_PD_TAG:
 		ath12k_htt_print_pdev_obss_pd_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_DMAC_RESET_STATS_TAG:
+		ath12k_htt_print_dmac_reset_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 597334830d02..120615fbe853 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -135,6 +135,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
+	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -196,6 +197,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SELFGEN_BE_ERR_STATS_TAG		= 137,
 	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
 	HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG	= 139,
+	HTT_STATS_DMAC_RESET_STATS_TAG			= 155,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -1048,4 +1050,17 @@ struct ath12k_htt_pdev_obss_pd_stats_tlv {
 	__le32 num_sr_ppdu_abort_flush_cnt;
 } __packed;
 
+struct ath12k_htt_dmac_reset_stats_tlv {
+	__le32 reset_count;
+	__le32 reset_time_lo_ms;
+	__le32 reset_time_hi_ms;
+	__le32 disengage_time_lo_ms;
+	__le32 disengage_time_hi_ms;
+	__le32 engage_time_lo_ms;
+	__le32 engage_time_hi_ms;
+	__le32 disengage_count;
+	__le32 engage_count;
+	__le32 drain_dest_ring_mask;
+} __packed;
+
 #endif

base-commit: d35bb26e150d7fb7434959fad9fcaeaac99906e6
prerequisite-patch-id: 970109034faa25a7630720c0da29c875e821f9ec
prerequisite-patch-id: 0bda913781a634c055869a033aa9b34d10825a20
prerequisite-patch-id: 4d37990775694f110ce3e87096231fe8855f09f5
prerequisite-patch-id: 121409543edef60c5f6144dd7ae3a615a78520f7
prerequisite-patch-id: ecac67f6fce1dd4d5089dbc3da840e311f6a7218
prerequisite-patch-id: 0537ae604d2617e42bef13bfb791aad4d11bf6e1
-- 
2.25.1


