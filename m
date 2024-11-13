Return-Path: <linux-wireless+bounces-15236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04FA9C69F0
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 08:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FD51F2567D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD805175D38;
	Wed, 13 Nov 2024 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ACFofxEE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31981168483
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731482854; cv=none; b=rZPf2RcziUlJTRMW5V68WjBf0aPLKYe5PX6PhTjhvMURN3JkhoKBMNlY4djwupqBdI8Yw0ciKRzvWsUe6wjkCwUKBYapv9Xshxbj88YvsGuF9jFAXrnytU0nW42ifzBjBZhfTH7VQyzVUoQnf8j3eonxCPc3u7NdlGJA7Lz1hQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731482854; c=relaxed/simple;
	bh=01TG4NBQ1zQ2gHgxL8M/JAKRzb9a+6XEaZvIAnh4MTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anpHMWZzjtmUHIqRfrzqrgfTaaMlGjDuXNdKD0WB4PMe7ldXqMPcK7SN44pM4Jr2sql8az3TPbnLtjSibsAlQkb3W/pqdjaoa3ZH4cpWVXYrzFePULSHovlAPPT+Vpz9EVCfYpxEBUznH7CDMuslcOYjE70UtMGYbaFILJYP984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ACFofxEE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACNSpVl026688;
	Wed, 13 Nov 2024 07:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ca60k9ptV2PMib5Frt/zmiUqyuUN1KgHuSiPWdeQs5Q=; b=ACFofxEEPsErVcuj
	fBJJzJfLCjJFBkt1MxRjrRmC7Sf5K/k+5osmlkdJSAXolgPR+FgLk+/ZEubQhI9o
	2i8w6C5QZ+yAFmVOKMPS9jT8VUQF3CkDmUdpTNTu8ewcOmxV4a+hRfTwuON8W1pg
	E3o4mY9qqIRg5tjGr6xgI3oM/c+zqRGnPQbZAY0Aemf8xX2gyr+RJPXCP8k3jNkR
	i1Nc1gOGQ778PjH/JZE/9bSoWH30S+yxCTLVVbGw0WLHJ5b3dJS5V6MfCDqKZVF3
	ftbuAA2VRoQEDwvvG6fZT2ZfMNFAZh6Cb2WHQ1VT3/cGmOx1xxxyVjEl0navda69
	/NmDMw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vgqqs09m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 07:27:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD7RTIe031791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 07:27:29 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 23:27:27 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v5 1/4] wifi: ath12k: Support Downlink Pager Stats
Date: Wed, 13 Nov 2024 12:57:04 +0530
Message-ID: <20241113072707.3377341-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113072707.3377341-1-quic_rdevanat@quicinc.com>
References: <20241113072707.3377341-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NoBiM_T0SU8tpHP5ETI9DDfGDotUDdrX
X-Proofpoint-GUID: NoBiM_T0SU8tpHP5ETI9DDfGDotUDdrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130064

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request downlink pager stats from firmware through HTT
stats type 36. These stats give paging information like number of pages,
their timestamp, number of locked and free pages, synchronous and
asynchronous locked pages.

Note: MCC firmware version -
WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 responds to
the event requesting stats, but it does not give any data.

Sample output:
-------------
echo 36 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_DLPAGER_STATS_TLV:
ASYNC locked pages = 2
SYNC locked pages = 0
Total locked pages = 2
Total free pages = 127

LOCKED PAGES HISTORY
last_locked_page_idx = 0
Index - 0 ; Page Number - 8495 ; Num of pages - 1 ; Timestamp - 4031009360us
Index - 1 ; Page Number - 7219 ; Num of pages - 2 ; Timestamp - 885379515us
Index - 2 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
Index - 3 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
.....
UNLOCKED PAGES HISTORY
last_unlocked_page_idx = 0
Index - 0 ; Page Number - 7144 ; Num of pages - 2 ; Timestamp - 4032070008us
Index - 1 ; Page Number - 7214 ; Num of pages - 2 ; Timestamp - 885379512us
Index - 2 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
Index - 3 ; Page Number - 0 ; Num of pages - 0 ; Timestamp - 0us
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 88 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 31 +++++++
 2 files changed, 119 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 43ea87e981f4..bde3644a7c21 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2543,6 +2543,91 @@ ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void ath12k_htt_print_dlpager_entry(const struct ath12k_htt_pgs_info *pg_info,
+					   int idx, char *str_buf)
+{
+	u64 page_timestamp;
+	u32 ts_lo, ts_hi;
+	u16 index = 0;
+
+	ts_lo = le32_to_cpu(pg_info->ts_lsb);
+	ts_hi = le32_to_cpu(pg_info->ts_msb);
+	page_timestamp = ath12k_le32hilo_to_u64(pg_info->ts_msb, pg_info->ts_lsb);
+
+	index += snprintf(&str_buf[index], ATH12K_HTT_MAX_STRING_LEN - index,
+			  "Index - %u ; Page Number - %u ; ",
+			  idx, le32_to_cpu(pg_info->page_num));
+	index += snprintf(&str_buf[index], ATH12K_HTT_MAX_STRING_LEN - index,
+			  "Num of pages - %u ; Timestamp - %lluus\n",
+			  le32_to_cpu(pg_info->num_pgs), page_timestamp);
+}
+
+static void
+ath12k_htt_print_dlpager_stats_tlv(const void *tag_buf, u16 tag_len,
+				   struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_dl_pager_stats_tlv *stat_buf = tag_buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 dword_lock, dword_unlock;
+	int i;
+	u8 *buf = stats_req->buf;
+	u8 pg_locked;
+	u8 pg_unlock;
+	char str_buf[ATH12K_HTT_MAX_STRING_LEN] = {0};
+
+	if (tag_len < sizeof(*stat_buf))
+		return;
+
+	dword_lock = u32_get_bits(stat_buf->info2,
+				  ATH12K_HTT_DLPAGER_TOTAL_LOCK_PAGES_INFO2);
+	dword_unlock = u32_get_bits(stat_buf->info2,
+				    ATH12K_HTT_DLPAGER_TOTAL_FREE_PAGES_INFO2);
+
+	pg_locked = ATH12K_HTT_STATS_PAGE_LOCKED;
+	pg_unlock = ATH12K_HTT_STATS_PAGE_UNLOCKED;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_DLPAGER_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ASYNC locked pages = %u\n",
+			 le32_get_bits(stat_buf->info0,
+				       ATH12K_HTT_DLPAGER_ASYNC_LOCK_PG_CNT_INFO0));
+	len += scnprintf(buf + len, buf_len - len, "SYNC locked pages = %u\n",
+			 le32_get_bits(stat_buf->info0,
+				       ATH12K_HTT_DLPAGER_SYNC_LOCK_PG_CNT_INFO0));
+	len += scnprintf(buf + len, buf_len - len, "Total locked pages = %u\n",
+			 le32_get_bits(stat_buf->info1,
+				       ATH12K_HTT_DLPAGER_TOTAL_LOCK_PAGES_INFO1));
+	len += scnprintf(buf + len, buf_len - len, "Total free pages = %u\n",
+			 le32_get_bits(stat_buf->info1,
+				       ATH12K_HTT_DLPAGER_TOTAL_FREE_PAGES_INFO1));
+
+	len += scnprintf(buf + len, buf_len - len, "\nLOCKED PAGES HISTORY\n");
+	len += scnprintf(buf + len, buf_len - len, "last_locked_page_idx = %u\n",
+			 dword_lock ? dword_lock - 1 : (ATH12K_PAGER_MAX - 1));
+
+	for (i = 0; i < ATH12K_PAGER_MAX; i++) {
+		memset(str_buf, 0x0, ATH12K_HTT_MAX_STRING_LEN);
+		ath12k_htt_print_dlpager_entry(&stat_buf->pgs_info[pg_locked][i],
+					       i, str_buf);
+		len += scnprintf(buf + len, buf_len - len, "%s", str_buf);
+	}
+
+	len += scnprintf(buf + len, buf_len - len, "\nUNLOCKED PAGES HISTORY\n");
+	len += scnprintf(buf + len, buf_len - len, "last_unlocked_page_idx = %u\n",
+			 dword_unlock ? dword_unlock - 1 : ATH12K_PAGER_MAX - 1);
+
+	for (i = 0; i < ATH12K_PAGER_MAX; i++) {
+		memset(str_buf, 0x0, ATH12K_HTT_MAX_STRING_LEN);
+		ath12k_htt_print_dlpager_entry(&stat_buf->pgs_info[pg_unlock][i],
+					       i, str_buf);
+		len += scnprintf(buf + len, buf_len - len, "%s", str_buf);
+	}
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	stats_req->buf_len = len;
+}
+
 static void
 ath12k_htt_print_dmac_reset_stats_tlv(const void *tag_buf, u16 tag_len,
 				      struct debug_htt_stats_req *stats_req)
@@ -2870,6 +2955,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_OBSS_PD_TAG:
 		ath12k_htt_print_pdev_obss_pd_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_DLPAGER_STATS_TAG:
+		ath12k_htt_print_dlpager_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_DMAC_RESET_STATS_TAG:
 		ath12k_htt_print_dmac_reset_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index ac86cab234ec..dfb6538585d5 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -135,6 +135,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
+	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
 	ATH12K_DBG_HTT_EXT_STATS_SOC_ERROR		= 45,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_SCHED_ALGO	= 49,
 	ATH12K_DBG_HTT_EXT_STATS_MANDATORY_MUOFDMA	= 51,
@@ -194,6 +195,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
 	HTT_STATS_TX_SELFGEN_AC_SCHED_STATUS_STATS_TAG	= 111,
 	HTT_STATS_TX_SELFGEN_AX_SCHED_STATUS_STATS_TAG	= 112,
+	HTT_STATS_DLPAGER_STATS_TAG			= 120,
 	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
 	HTT_STATS_TX_PDEV_MUMIMO_GRP_STATS_TAG		= 130,
 	HTT_STATS_TX_PDEV_RATE_STATS_BE_OFDMA_TAG	= 135,
@@ -1054,6 +1056,35 @@ struct ath12k_htt_pdev_obss_pd_stats_tlv {
 	__le32 num_sr_ppdu_abort_flush_cnt;
 } __packed;
 
+enum ath12k_htt_stats_page_lock_state {
+	ATH12K_HTT_STATS_PAGE_LOCKED	= 0,
+	ATH12K_HTT_STATS_PAGE_UNLOCKED	= 1,
+	ATH12K_NUM_PG_LOCK_STATE
+};
+
+#define ATH12K_PAGER_MAX	10
+
+#define ATH12K_HTT_DLPAGER_ASYNC_LOCK_PG_CNT_INFO0	GENMASK(7, 0)
+#define ATH12K_HTT_DLPAGER_SYNC_LOCK_PG_CNT_INFO0	GENMASK(15, 8)
+#define ATH12K_HTT_DLPAGER_TOTAL_LOCK_PAGES_INFO1	GENMASK(15, 0)
+#define ATH12K_HTT_DLPAGER_TOTAL_FREE_PAGES_INFO1	GENMASK(31, 16)
+#define ATH12K_HTT_DLPAGER_TOTAL_LOCK_PAGES_INFO2	GENMASK(15, 0)
+#define ATH12K_HTT_DLPAGER_TOTAL_FREE_PAGES_INFO2	GENMASK(31, 16)
+
+struct ath12k_htt_pgs_info {
+	__le32 page_num;
+	__le32 num_pgs;
+	__le32 ts_lsb;
+	__le32 ts_msb;
+} __packed;
+
+struct ath12k_htt_dl_pager_stats_tlv {
+	__le32 info0;
+	__le32 info1;
+	__le32 info2;
+	struct ath12k_htt_pgs_info pgs_info[ATH12K_NUM_PG_LOCK_STATE][ATH12K_PAGER_MAX];
+} __packed;
+
 struct ath12k_htt_dmac_reset_stats_tlv {
 	__le32 reset_count;
 	__le32 reset_time_lo_ms;
-- 
2.25.1


