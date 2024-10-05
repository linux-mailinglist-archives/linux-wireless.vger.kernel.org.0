Return-Path: <linux-wireless+bounces-13551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDC19915EF
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 12:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D101F23A15
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BF11369BC;
	Sat,  5 Oct 2024 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SK4DYzzB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8413F9C5
	for <linux-wireless@vger.kernel.org>; Sat,  5 Oct 2024 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728123529; cv=none; b=PIRvAtEN5PSTeB9jIuiD/GG/SU54l9kF4D40n5WPYe3cZcSJUg4w8IctMplIIEBExJgzsTotuUMI2Gum/hwAgDzePFZuzv5nW3ZGQxrcdZrO6QNgYJKBLn2calWUTGbZM4ismpzb6pEfhF/ihdbcytilj29rmWLivxqcUr/S2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728123529; c=relaxed/simple;
	bh=rp2T3Aw4G3PUqSvk84ptNETO0DV/sYRLb4HEOgwB6zY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8xkJ9rplmoJ1Zt8fiJ9l92nLhzxl6Obi1B7JHbpVwohn5YnZNE8FVz+nz8qE94+kq3GinqY4qYYlMYhKjcvMOgc9udWUMux7BoHHnlgrOm0FiG0ut9OfmexFjSO3wOafBl0BuHUxoNauzjyyaHSSZOZDt2tyo2RHUJOlU62Uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SK4DYzzB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4956RaoC026967;
	Sat, 5 Oct 2024 10:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p4i1PNPfz1nqvgx79DfVqLrBR4TyDVzuo0XkE14Kr4I=; b=SK4DYzzBxh8gHwiz
	dXXgQH5sqUE/QWukI/GStZtr+gt+PiTJq8q9cm40fNGkRPEyKlurucqwyK1/le/H
	oTQxlYYH0oelLIY3njSyhqaZgSDNhtsFZWE/boUTUpT8qTzbXVx4cLg/6cXuRI/H
	4rYetHg0sN/iBkpBJRGH43ReefahuwZpugzEcTqRwxE5hJKtCbbbaXwsPEr1q1gx
	Xn802i8CLdhi9BI0dc7JzbWrOAnwCjrwpcPWktqGFoMwmLQRx6BahnhTfBUVA0TG
	oZwNwS73ZKkUomtQjkuZ6kfWFbAY3UelxwN1ju6TQQf5Mc43Q/nJg9VIqWk8J982
	pP7Odg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xr5gcd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Oct 2024 10:18:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 495AIiPa019526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 10:18:44 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Oct 2024 03:18:42 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v2 4/4] wifi: ath12k: Support pdev CCA Stats
Date: Sat, 5 Oct 2024 15:48:16 +0530
Message-ID: <20241005101816.3314728-5-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241005101816.3314728-1-quic_rdevanat@quicinc.com>
References: <20241005101816.3314728-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: UoMFewI_8V8MFQFlzbzIAKO7QJS1jdUJ
X-Proofpoint-ORIG-GUID: UoMFewI_8V8MFQFlzbzIAKO7QJS1jdUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050076

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request CCA stats for physical devices from firmware
through HTT stats type 19. These stats give information about
channel number, number of records, counters' bitmap, collection
interval and different CCA counters.

Sample output:
-------------
echo 19 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_PDEV_CCA_STATS_HIST_TLV (1s):
chan_num = 5955
num_records = 10
valid_cca_counters_bitmap = 0xff
collection_interval = 1000

HTT_PDEV_STATS_CCA_COUNTERS_TLV:(in usec)
tx_frame_usec = 0
rx_frame_usec = 0
rx_clear_usec = 999955
my_rx_frame_usec = 0
usec_cnt = 999955
med_rx_idle_usec = 0
med_tx_idle_global_usec = 0
cca_obss_usec = 999955
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 67 +++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 23 +++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index ad2919bcb11c..bf6864711980 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2378,6 +2378,65 @@ ath12k_htt_print_tx_pdev_mu_mimo_mpdu_stats_tlv(const void *tag_buf, u16 tag_len
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_pdev_cca_stats_hist_tlv(const void *tag_buf, u16 tag_len,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_cca_stats_hist_v1_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_CCA_STATS_HIST_TLV :\n");
+	len += scnprintf(buf + len, buf_len - len, "chan_num = %u\n",
+			 le32_to_cpu(htt_stats_buf->chan_num));
+	len += scnprintf(buf + len, buf_len - len, "num_records = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_records));
+	len += scnprintf(buf + len, buf_len - len, "valid_cca_counters_bitmap = 0x%x\n",
+			 le32_to_cpu(htt_stats_buf->valid_cca_counters_bitmap));
+	len += scnprintf(buf + len, buf_len - len, "collection_interval = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->collection_interval));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_pdev_stats_cca_counters_tlv(const void *tag_buf, u16 tag_len,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_pdev_stats_cca_counters_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_PDEV_STATS_CCA_COUNTERS_TLV:(in usec)\n");
+	len += scnprintf(buf + len, buf_len - len, "tx_frame_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_frame_usec));
+	len += scnprintf(buf + len, buf_len - len, "rx_frame_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_frame_usec));
+	len += scnprintf(buf + len, buf_len - len, "rx_clear_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_clear_usec));
+	len += scnprintf(buf + len, buf_len - len, "my_rx_frame_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->my_rx_frame_usec));
+	len += scnprintf(buf + len, buf_len - len, "usec_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->usec_cnt));
+	len += scnprintf(buf + len, buf_len - len, "med_rx_idle_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->med_rx_idle_usec));
+	len += scnprintf(buf + len, buf_len - len, "med_tx_idle_global_usec = %u\n",
+			 le32_to_cpu(htt_stats_buf->med_tx_idle_global_usec));
+	len += scnprintf(buf + len, buf_len - len, "cca_obss_usec = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->cca_obss_usec));
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -2540,6 +2599,14 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_PDEV_MPDU_STATS_TAG:
 		ath12k_htt_print_tx_pdev_mu_mimo_mpdu_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PDEV_CCA_1SEC_HIST_TAG:
+	case HTT_STATS_PDEV_CCA_100MSEC_HIST_TAG:
+	case HTT_STATS_PDEV_CCA_STAT_CUMULATIVE_TAG:
+		ath12k_htt_print_pdev_cca_stats_hist_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PDEV_CCA_COUNTERS_TAG:
+		ath12k_htt_print_pdev_stats_cca_counters_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index bd764ddd5394..b37ba1256ce5 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -133,6 +133,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_SRNG_INFO		= 15,
 	ATH12K_DBG_HTT_EXT_STATS_SFM_INFO		= 16,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -176,6 +177,10 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_DE_COMPL_STATS_TAG			= 65,
 	HTT_STATS_WHAL_TX_TAG				= 66,
 	HTT_STATS_TX_PDEV_SIFS_HIST_TAG			= 67,
+	HTT_STATS_PDEV_CCA_1SEC_HIST_TAG		= 70,
+	HTT_STATS_PDEV_CCA_100MSEC_HIST_TAG		= 71,
+	HTT_STATS_PDEV_CCA_STAT_CUMULATIVE_TAG		= 72,
+	HTT_STATS_PDEV_CCA_COUNTERS_TAG			= 73,
 	HTT_STATS_TX_PDEV_MPDU_STATS_TAG		= 74,
 	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG		= 86,
 	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG	= 87,
@@ -1001,4 +1006,22 @@ struct ath12k_htt_tx_pdev_mpdu_stats_tlv {
 	__le32 tx_sched_mode;
 } __packed;
 
+struct ath12k_htt_pdev_stats_cca_counters_tlv {
+	__le32 tx_frame_usec;
+	__le32 rx_frame_usec;
+	__le32 rx_clear_usec;
+	__le32 my_rx_frame_usec;
+	__le32 usec_cnt;
+	__le32 med_rx_idle_usec;
+	__le32 med_tx_idle_global_usec;
+	__le32 cca_obss_usec;
+} __packed;
+
+struct ath12k_htt_pdev_cca_stats_hist_v1_tlv {
+	__le32 chan_num;
+	__le32 num_records;
+	__le32 valid_cca_counters_bitmap;
+	__le32 collection_interval;
+} __packed;
+
 #endif
-- 
2.25.1


