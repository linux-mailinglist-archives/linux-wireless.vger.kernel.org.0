Return-Path: <linux-wireless+bounces-12837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706BD977AFC
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 10:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92891F25BE3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAD2185925;
	Fri, 13 Sep 2024 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VzLk9N8Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108321D6C6C
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216226; cv=none; b=rkYvwtR0EB1Y54+1xGK1h8Z7c9gLFUm9bK3y0c6+zWLx30+zmceS04QcwrCOsVZgAfKTTZehZSb5qf4phRGbcNxrQMpCi78VVNLQXMLH5Ef5BizCh7S0rZ/xFsmWomAgQmDwatGQmMeYTqjNP8cJkmVDaFMs8Knc7GSQlv4Aav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216226; c=relaxed/simple;
	bh=Q0oZ1dAe0hDdsJawahDyK1175gI2ny8kCJ9Cpaafdv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCOUdR5UpicLsO6RxSyCJ9Vo7JURQMHWjfSa2rEc+DRsXjg+laIC94CNxMXx3zA8arR+NpR0IMAH67/87G8Owq3KhmrDx0WBM54c4ig+bISfIbDn/4uSgX9049MC2MjZl8w9DUtOL7o0wfs/UsgYHu2AXjLDJ74Jas8l8XvqPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VzLk9N8Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMB9PZ025468;
	Fri, 13 Sep 2024 08:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G+Voihzvgn5uUhbOuMmNojnKI/b70VutQQ1ene5+FEQ=; b=VzLk9N8YRE+WMA44
	/YDm6i9wQdHBSZNzBukDAypw9tSD9B22tmGrs2hUzCYS1EptvIQhRh1HqtV5yrml
	wdGDWVHYriJVHQ3k4Xau0/nwy3WV12K7/kovkHUl9olsCgT//fc66vjLfXIC8esk
	9TPjLw5pr/IDZvCS+WIvv6gLBQZZIFXy+NWLqkCQGd3si7Yp73mH9XtgGAW3sQaz
	CsM62XKvsWrmZrxQOpGR9Y0EOAkjcoKkYuzM2hfhnB7lWj5YQNjFPvrr1VtQMa6Y
	7VyCEfJ+oeKwNxLd4hPqeqFW3XgAhfMYZ6mRH9xXWfVuAxnslMCRpr1jBdNxXP6a
	qrWFPA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy8p8468-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:30:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48D8UJxS004072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 08:30:19 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Sep 2024 01:30:17 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 2/4] wifi: ath12k: Support Ring and SFM stats
Date: Fri, 13 Sep 2024 13:59:47 +0530
Message-ID: <20240913082949.573482-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913082949.573482-1-quic_rdevanat@quicinc.com>
References: <20240913082949.573482-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: OFzo3K9ZGzxxM7Z_CMO5iQxYQtzeA11N
X-Proofpoint-ORIG-GUID: OFzo3K9ZGzxxM7Z_CMO5iQxYQtzeA11N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130058

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request ring and SFM stats from firmware through HTT stats
type 15 and 16 respectively. These stats give information such as ring
size, ring address, valid number of words in ring, etc., for stats type 15
and SFM buffer information, number of users, words used by users, etc.,
for stat type 16.

Sample output:
-------------
echo 15 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_STATS_STRING_TLV:
data = TCL_GSE_CMD_RING

HTT_SRING_STATS_TLV:
mac_id = 0
ring_id = 0
arena = 8
.....

echo 16 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_SFM_CMN_TLV:
mac_id = 0
buf_total = 1760
mem_empty = 32895
.....

HTT_STATS_STRING_TLV:
data = PMAC_SFM_CLIENT0_RXPCU0

HTT_SFM_CLIENT_TLV:
client_id = 0
buf_min = 148
buf_max = 445
.....

HTT_SFM_CLIENT_USER_TLV:
dwords_used_by_user_n =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0,
22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0,
34:0, 35:0, 36:0, 37:0, 38:0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 187 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  58 ++++++
 2 files changed, 245 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 446428d9cf0f..98610d0ce4a2 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1905,6 +1905,178 @@ ath12k_htt_print_tx_selfgen_be_sched_status_stats_tlv(const void *tag_buf, u16 t
 	stats->buf_len = len;
 }
 
+static void
+ath12k_htt_print_stats_string_tlv(const void *tag_buf, u16 tag_len,
+				  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_stats_string_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u8 i;
+	u16 index = 0;
+	u32 datum;
+	char data[ATH12K_HTT_MAX_STRING_LEN] = {0};
+
+	tag_len = tag_len >> 2;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_STATS_STRING_TLV:\n");
+	for (i = 0; i < tag_len; i++) {
+		datum = __le32_to_cpu(htt_stats_buf->data[i]);
+		index += scnprintf(&data[index], ATH12K_HTT_MAX_STRING_LEN - index,
+				   "%.*s", 4, (char *)&datum);
+		if (index >= ATH12K_HTT_MAX_STRING_LEN)
+			break;
+	}
+	len += scnprintf(buf + len, buf_len - len, "data = %s\n\n", data);
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_sring_stats_tlv(const void *tag_buf, u16 tag_len,
+				 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_sring_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 mac_id_word;
+	u32 avail_words;
+	u32 head_tail_ptr;
+	u32 sring_stat;
+	u32 tail_ptr;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	mac_id_word = __le32_to_cpu(htt_stats_buf->mac_id__ring_id__arena__ep);
+	avail_words = __le32_to_cpu(htt_stats_buf->num_avail_words__num_valid_words);
+	head_tail_ptr = __le32_to_cpu(htt_stats_buf->head_ptr__tail_ptr);
+	sring_stat = __le32_to_cpu(htt_stats_buf->consumer_empty__producer_full);
+	tail_ptr = __le32_to_cpu(htt_stats_buf->prefetch_count__internal_tail_ptr);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_SRING_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_SRING_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "ring_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_SRING_STATS_RING_ID));
+	len += scnprintf(buf + len, buf_len - len, "arena = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_SRING_STATS_ARENA));
+	len += scnprintf(buf + len, buf_len - len, "ep = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_SRING_STATS_EP));
+	len += scnprintf(buf + len, buf_len - len, "base_addr_lsb = 0x%x\n",
+			 le32_to_cpu(htt_stats_buf->base_addr_lsb));
+	len += scnprintf(buf + len, buf_len - len, "base_addr_msb = 0x%x\n",
+			 le32_to_cpu(htt_stats_buf->base_addr_msb));
+	len += scnprintf(buf + len, buf_len - len, "ring_size = %u\n",
+			 le32_to_cpu(htt_stats_buf->ring_size));
+	len += scnprintf(buf + len, buf_len - len, "elem_size = %u\n",
+			 le32_to_cpu(htt_stats_buf->elem_size));
+	len += scnprintf(buf + len, buf_len - len, "num_avail_words = %u\n",
+			 u32_get_bits(avail_words,
+				      ATH12K_HTT_SRING_STATS_NUM_AVAIL_WORDS));
+	len += scnprintf(buf + len, buf_len - len, "num_valid_words = %u\n",
+			 u32_get_bits(avail_words,
+				      ATH12K_HTT_SRING_STATS_NUM_VALID_WORDS));
+	len += scnprintf(buf + len, buf_len - len, "head_ptr = %u\n",
+			 u32_get_bits(head_tail_ptr, ATH12K_HTT_SRING_STATS_HEAD_PTR));
+	len += scnprintf(buf + len, buf_len - len, "tail_ptr = %u\n",
+			 u32_get_bits(head_tail_ptr, ATH12K_HTT_SRING_STATS_TAIL_PTR));
+	len += scnprintf(buf + len, buf_len - len, "consumer_empty = %u\n",
+			 u32_get_bits(sring_stat,
+				      ATH12K_HTT_SRING_STATS_CONSUMER_EMPTY));
+	len += scnprintf(buf + len, buf_len - len, "producer_full = %u\n",
+			 u32_get_bits(head_tail_ptr,
+				      ATH12K_HTT_SRING_STATS_PRODUCER_FULL));
+	len += scnprintf(buf + len, buf_len - len, "prefetch_count = %u\n",
+			 u32_get_bits(tail_ptr, ATH12K_HTT_SRING_STATS_PREFETCH_COUNT));
+	len += scnprintf(buf + len, buf_len - len, "internal_tail_ptr = %u\n\n",
+			 u32_get_bits(tail_ptr,
+				      ATH12K_HTT_SRING_STATS_INTERNAL_TAIL_PTR));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_sfm_cmn_tlv(const void *tag_buf, u16 tag_len,
+			     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_sfm_cmn_tlv *htt_stats_buf = tag_buf;
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
+	len += scnprintf(buf + len, buf_len - len, "HTT_SFM_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "buf_total = %u\n",
+			 le32_to_cpu(htt_stats_buf->buf_total));
+	len += scnprintf(buf + len, buf_len - len, "mem_empty = %u\n",
+			 le32_to_cpu(htt_stats_buf->mem_empty));
+	len += scnprintf(buf + len, buf_len - len, "deallocate_bufs = %u\n",
+			 le32_to_cpu(htt_stats_buf->deallocate_bufs));
+	len += scnprintf(buf + len, buf_len - len, "num_records = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->num_records));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_sfm_client_tlv(const void *tag_buf, u16 tag_len,
+				struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_sfm_client_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_SFM_CLIENT_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "client_id = %u\n",
+			 le32_to_cpu(htt_stats_buf->client_id));
+	len += scnprintf(buf + len, buf_len - len, "buf_min = %u\n",
+			 le32_to_cpu(htt_stats_buf->buf_min));
+	len += scnprintf(buf + len, buf_len - len, "buf_max = %u\n",
+			 le32_to_cpu(htt_stats_buf->buf_max));
+	len += scnprintf(buf + len, buf_len - len, "buf_busy = %u\n",
+			 le32_to_cpu(htt_stats_buf->buf_busy));
+	len += scnprintf(buf + len, buf_len - len, "buf_alloc = %u\n",
+			 le32_to_cpu(htt_stats_buf->buf_alloc));
+	len += scnprintf(buf + len, buf_len - len, "buf_avail = %u\n",
+			 le32_to_cpu(htt_stats_buf->buf_avail));
+	len += scnprintf(buf + len, buf_len - len, "num_users = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->num_users));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_sfm_client_user_tlv(const void *tag_buf, u16 tag_len,
+				     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_sfm_client_user_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u16 num_elems = tag_len >> 2;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_SFM_CLIENT_USER_TLV:\n");
+	len += print_array_to_buf(buf, len, "dwords_used_by_user_n",
+				  htt_stats_buf->dwords_used_by_user_n,
+				  num_elems, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -2043,6 +2215,21 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 		ath12k_htt_print_tx_selfgen_be_sched_status_stats_tlv(tag_buf, len,
 								      stats_req);
 		break;
+	case HTT_STATS_STRING_TAG:
+		ath12k_htt_print_stats_string_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_SRING_STATS_TAG:
+		ath12k_htt_print_sring_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_SFM_CMN_TAG:
+		ath12k_htt_print_sfm_cmn_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_SFM_CLIENT_TAG:
+		ath12k_htt_print_sfm_client_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_SFM_CLIENT_USER_TAG:
+		ath12k_htt_print_sfm_client_user_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 350e7b9c12b2..ed6eb5935e2d 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -130,6 +130,8 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM		= 6,
 	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO		= 8,
 	ATH12K_DBG_HTT_EXT_STATS_TX_SELFGEN_INFO	= 12,
+	ATH12K_DBG_HTT_EXT_STATS_SRNG_INFO		= 15,
+	ATH12K_DBG_HTT_EXT_STATS_SFM_INFO		= 16,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -140,6 +142,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_PDEV_UNDERRUN_TAG			= 1,
 	HTT_STATS_TX_PDEV_SIFS_TAG			= 2,
 	HTT_STATS_TX_PDEV_FLUSH_TAG			= 3,
+	HTT_STATS_STRING_TAG				= 5,
 	HTT_STATS_TX_TQM_GEN_MPDU_TAG			= 11,
 	HTT_STATS_TX_TQM_LIST_MPDU_TAG			= 12,
 	HTT_STATS_TX_TQM_LIST_MPDU_CNT_TAG		= 13,
@@ -152,9 +155,13 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_DE_ENQUEUE_PACKETS_TAG		= 21,
 	HTT_STATS_TX_DE_ENQUEUE_DISCARD_TAG		= 22,
 	HTT_STATS_TX_DE_CMN_TAG				= 23,
+	HTT_STATS_SFM_CMN_TAG				= 26,
+	HTT_STATS_SRING_STATS_TAG			= 27,
 	HTT_STATS_TX_PDEV_SCHEDULER_TXQ_STATS_TAG	= 36,
 	HTT_STATS_TX_SCHED_CMN_TAG			= 37,
 	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,
+	HTT_STATS_SFM_CLIENT_USER_TAG			= 41,
+	HTT_STATS_SFM_CLIENT_TAG			= 42,
 	HTT_STATS_TX_TQM_ERROR_STATS_TAG                = 43,
 	HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG		= 44,
 	HTT_STATS_TX_SELFGEN_AC_ERR_STATS_TAG		= 46,
@@ -864,4 +871,55 @@ struct ath12k_htt_tx_selfgen_be_sched_status_stats_tlv {
 	__le32 be_ulmumimo_trig_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
 } __packed;
 
+struct ath12k_htt_stats_string_tlv {
+	DECLARE_FLEX_ARRAY(__le32, data);
+} __packed;
+
+#define ATH12K_HTT_SRING_STATS_MAC_ID                  GENMASK(7, 0)
+#define ATH12K_HTT_SRING_STATS_RING_ID                 GENMASK(15, 8)
+#define ATH12K_HTT_SRING_STATS_ARENA                   GENMASK(23, 16)
+#define ATH12K_HTT_SRING_STATS_EP                      BIT(24)
+#define ATH12K_HTT_SRING_STATS_NUM_AVAIL_WORDS         GENMASK(15, 0)
+#define ATH12K_HTT_SRING_STATS_NUM_VALID_WORDS         GENMASK(31, 16)
+#define ATH12K_HTT_SRING_STATS_HEAD_PTR                GENMASK(15, 0)
+#define ATH12K_HTT_SRING_STATS_TAIL_PTR                GENMASK(31, 16)
+#define ATH12K_HTT_SRING_STATS_CONSUMER_EMPTY          GENMASK(15, 0)
+#define ATH12K_HTT_SRING_STATS_PRODUCER_FULL           GENMASK(31, 16)
+#define ATH12K_HTT_SRING_STATS_PREFETCH_COUNT          GENMASK(15, 0)
+#define ATH12K_HTT_SRING_STATS_INTERNAL_TAIL_PTR       GENMASK(31, 16)
+
+struct ath12k_htt_sring_stats_tlv {
+	__le32 mac_id__ring_id__arena__ep;
+	__le32 base_addr_lsb;
+	__le32 base_addr_msb;
+	__le32 ring_size;
+	__le32 elem_size;
+	__le32 num_avail_words__num_valid_words;
+	__le32 head_ptr__tail_ptr;
+	__le32 consumer_empty__producer_full;
+	__le32 prefetch_count__internal_tail_ptr;
+} __packed;
+
+struct ath12k_htt_sfm_cmn_tlv {
+	__le32 mac_id__word;
+	__le32 buf_total;
+	__le32 mem_empty;
+	__le32 deallocate_bufs;
+	__le32 num_records;
+} __packed;
+
+struct ath12k_htt_sfm_client_tlv {
+	__le32 client_id;
+	__le32 buf_min;
+	__le32 buf_max;
+	__le32 buf_busy;
+	__le32 buf_alloc;
+	__le32 buf_avail;
+	__le32 num_users;
+} __packed;
+
+struct ath12k_htt_sfm_client_user_tlv {
+	DECLARE_FLEX_ARRAY(__le32, dwords_used_by_user_n);
+} __packed;
+
 #endif
-- 
2.25.1


