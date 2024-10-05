Return-Path: <linux-wireless+bounces-13550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1789915ED
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 12:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3775A1F23656
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AC513AD2B;
	Sat,  5 Oct 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dMPwUyvY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40383F9C5
	for <linux-wireless@vger.kernel.org>; Sat,  5 Oct 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728123526; cv=none; b=ojML7c0lI9Xu2pixqEt0F5DnBigqf1mRMXYowhYd/m6JvQv/Sh0lI9pOEJH9kkpmxRuCPDwLSZPJhMKlaOSj2D7534VwACyoqWdI19yJp5z4U1ofj14b8uq0M9AxYgDkz0UvFL+FbWdGZyQNBJH2DvhsL3jW5SStdiLe1Hv4DF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728123526; c=relaxed/simple;
	bh=8Lip4zT6Z3udsOGzQV6N0fTYVx7PBnFlKye8TPoKDFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwY4ECWADFUSj+vd4EMzPP5ytYrehJZVQPwV6doTJ7rlJakfe789B1T/PFh3fEdn/4lnKOctaFfksDK94XxJdWDpeUjaHcVd/FaOA3xfrUKwiLxKfbjtCUum48DEM5bGWcuc6U39DMBYnCf3zW3wLLZ+a2p5p8nV18BRvJY72es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dMPwUyvY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4958KKs4016645;
	Sat, 5 Oct 2024 10:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	151iIUgZc1isbgUgpMqIA0uMCLaDk642XpWJKQ7+Pl0=; b=dMPwUyvYrnILl8WB
	Znr30n7RqCsVnktCM31EgOJtrI+HNycDSwjXgqw8JjPhTG5mN4h/Xt8L+Rfamric
	HawNbquSlJMYWqRDjMumNrjnvtr/KghfbHxpERwAcvIei8ohdn2OKx35MHrSQMNg
	9kVjAk3tjf3Zml6B4ieMDFMOma8o1m1wQjxWrjm0rNjmfLcBYgm6UF8Cfar6wHxz
	LZxXBtNg0ADDIiP6I7NFgTNM8osa/YgpOiKFWgoqREQM5aIR35IWcQAjI7lcKiWj
	sxJD4eIj1FENd7q++F0HHk5r1JUN6TsuCu/IeZel8oA3xT1t5leNkxmNXSQOMkKl
	bW7Kfg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xs80ck8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Oct 2024 10:18:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 495AIcvf029180
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 10:18:38 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Oct 2024 03:18:36 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v2 1/4] wifi: ath12k: Support Self-Generated Transmit stats
Date: Sat, 5 Oct 2024 15:48:13 +0530
Message-ID: <20241005101816.3314728-2-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: Fq8YwsTkEPTKe-W2wUXcHPu7f53BxII-
X-Proofpoint-ORIG-GUID: Fq8YwsTkEPTKe-W2wUXcHPu7f53BxII-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050076

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request transmit selfgen stats from firmware through HTT stats
type 12. These stats give information about single user NDP packets, multi-
user MIMO NDP packets, OFDMA triggers, etc.

Sample output:
-------------
echo 12 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_TX_SELFGEN_CMN_STATS_TLV:
mac_id = 0
su_bar = 0
rts = 0
.....

HTT_TX_SELFGEN_AC_STATS_TLV:
ac_su_ndpa_tried = 0
ac_su_ndp_tried = 0
ac_mu_mimo_ndpa_tried = 0
.....

HTT_TX_SELFGEN_AX_STATS_TLV:
ax_su_ndpa_tried = 0
ax_su_ndp_tried = 0
ax_mu_mimo_ndpa_tried = 0
.....

HTT_TX_SELFGEN_BE_STATS_TLV:
be_su_ndpa_queued = 0
be_su_ndpa_tried = 0
be_su_ndp_queued = 0
.....

HTT_TX_SELFGEN_AC_ERR_STATS_TLV:
ac_su_ndp_err = 0
ac_su_ndpa_err = 0
ac_mu_mimo_ndpa_err = 0
.....

HTT_TX_SELFGEN_AX_ERR_STATS_TLV:
ax_su_ndp_err = 0
ax_su_ndpa_err = 0
ax_mu_mimo_ndpa_err = 0
.....

HTT_TX_SELFGEN_BE_ERR_STATS_TLV:
be_su_ndp_err = 0
be_su_ndp_flushed = 0
be_su_ndpa_err = 0
.....

HTT_TX_SELFGEN_AC_SCHED_STATUS_STATS_TLV:
ac_su_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
ac_su_ndp_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
ac_mu_mimo_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
.....

HTT_TX_SELFGEN_AX_SCHED_STATUS_STATS_TLV:
ax_su_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
ax_su_ndp_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
ax_mu_mimo_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
.....

HTT_TX_SELFGEN_BE_SCHED_STATUS_STATS_TLV:
be_su_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
be_su_ndp_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
be_mu_mimo_ndpa_sch_status =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 489 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 186 ++++++-
 2 files changed, 669 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index ec7add76ec85..48fa7f89426d 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -1455,6 +1455,462 @@ ath12k_htt_print_tx_de_compl_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_tx_selfgen_cmn_stats_tlv(const void *tag_buf, u16 tag_len,
+					  struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_selfgen_cmn_stats_tlv *htt_stats_buf = tag_buf;
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
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_CMN_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 u32_get_bits(mac_id_word, ATH12K_HTT_STATS_MAC_ID));
+	len += scnprintf(buf + len, buf_len - len, "su_bar = %u\n",
+			 le32_to_cpu(htt_stats_buf->su_bar));
+	len += scnprintf(buf + len, buf_len - len, "rts = %u\n",
+			 le32_to_cpu(htt_stats_buf->rts));
+	len += scnprintf(buf + len, buf_len - len, "cts2self = %u\n",
+			 le32_to_cpu(htt_stats_buf->cts2self));
+	len += scnprintf(buf + len, buf_len - len, "qos_null = %u\n",
+			 le32_to_cpu(htt_stats_buf->qos_null));
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_1 = %u\n",
+			 le32_to_cpu(htt_stats_buf->delayed_bar_1));
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_2 = %u\n",
+			 le32_to_cpu(htt_stats_buf->delayed_bar_2));
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_3 = %u\n",
+			 le32_to_cpu(htt_stats_buf->delayed_bar_3));
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_4 = %u\n",
+			 le32_to_cpu(htt_stats_buf->delayed_bar_4));
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_5 = %u\n",
+			 le32_to_cpu(htt_stats_buf->delayed_bar_5));
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_6 = %u\n",
+			 le32_to_cpu(htt_stats_buf->delayed_bar_6));
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_7 = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->delayed_bar_7));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_selfgen_ac_stats_tlv(const void *tag_buf, u16 tag_len,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_selfgen_ac_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_AC_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ac_su_ndpa_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_su_ndpa));
+	len += scnprintf(buf + len, buf_len - len, "ac_su_ndp_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_su_ndp));
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_ndpa_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_ndpa));
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_ndp_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_ndp));
+	len += print_array_to_buf_index(buf, len, "ac_mu_mimo_brpollX_tried = ", 1,
+					htt_stats_buf->ac_mu_mimo_brpoll,
+					ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_selfgen_ax_stats_tlv(const void *tag_buf, u16 tag_len,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_selfgen_ax_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_AX_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ax_su_ndpa_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_su_ndpa));
+	len += scnprintf(buf + len, buf_len - len, "ax_su_ndp_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_su_ndp));
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_ndpa_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_ndpa));
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_ndp_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_ndp));
+	len += print_array_to_buf_index(buf, len, "ax_mu_mimo_brpollX_tried = ", 1,
+					htt_stats_buf->ax_mu_mimo_brpoll,
+					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS, "\n");
+	len += scnprintf(buf + len, buf_len - len, "ax_basic_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_basic_trigger));
+	len += scnprintf(buf + len, buf_len - len, "ax_ulmumimo_total_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_ulmumimo_trigger));
+	len += scnprintf(buf + len, buf_len - len, "ax_bsr_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_bsr_trigger));
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_bar_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_mu_bar_trigger));
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_rts_trigger = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->ax_mu_rts_trigger));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_selfgen_be_stats_tlv(const void *tag_buf, u16 tag_len,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_selfgen_be_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_BE_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "be_su_ndpa_queued = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_su_ndpa_queued));
+	len += scnprintf(buf + len, buf_len - len, "be_su_ndpa_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_su_ndpa));
+	len += scnprintf(buf + len, buf_len - len, "be_su_ndp_queued = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_su_ndp_queued));
+	len += scnprintf(buf + len, buf_len - len, "be_su_ndp_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_su_ndp));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_mimo_ndpa_queued = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_mimo_ndpa_queued));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_mimo_ndpa_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_mimo_ndpa));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_mimo_ndp_queued = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_mimo_ndp_queued));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_mimo_ndp_tried = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_mimo_ndp));
+	len += print_array_to_buf_index(buf, len, "be_mu_mimo_brpollX_queued = ", 1,
+					htt_stats_buf->be_mu_mimo_brpoll_queued,
+					ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS - 1,
+					"\n");
+	len += print_array_to_buf_index(buf, len, "be_mu_mimo_brpollX_tried = ", 1,
+					htt_stats_buf->be_mu_mimo_brpoll,
+					ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS - 1,
+					"\n");
+	len += print_array_to_buf(buf, len, "be_ul_mumimo_trigger = ",
+				  htt_stats_buf->be_ul_mumimo_trigger,
+				  ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS, "\n");
+	len += scnprintf(buf + len, buf_len - len, "be_basic_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_basic_trigger));
+	len += scnprintf(buf + len, buf_len - len, "be_ulmumimo_total_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_ulmumimo_trigger));
+	len += scnprintf(buf + len, buf_len - len, "be_bsr_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_bsr_trigger));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_bar_trigger = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_bar_trigger));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_rts_trigger = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_rts_trigger));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_selfgen_ac_err_stats_tlv(const void *tag_buf, u16 tag_len,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_selfgen_ac_err_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_AC_ERR_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ac_su_ndp_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_su_ndp_err));
+	len += scnprintf(buf + len, buf_len - len, "ac_su_ndpa_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_su_ndpa_err));
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_ndpa_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_ndpa_err));
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_ndp_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_ndp_err));
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_brp1_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_brp1_err));
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_brp2_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_brp2_err));
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_brp3_err = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->ac_mu_mimo_brp3_err));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_selfgen_ax_err_stats_tlv(const void *tag_buf, u16 tag_len,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_selfgen_ax_err_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_AX_ERR_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ax_su_ndp_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_su_ndp_err));
+	len += scnprintf(buf + len, buf_len - len, "ax_su_ndpa_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_su_ndpa_err));
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_ndpa_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_ndpa_err));
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_ndp_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_ndp_err));
+	len += print_array_to_buf_index(buf, len, "ax_mu_mimo_brpX_err", 1,
+					htt_stats_buf->ax_mu_mimo_brp_err,
+					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS - 1,
+					"\n");
+	len += scnprintf(buf + len, buf_len - len, "ax_basic_trigger_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_basic_trigger_err));
+	len += scnprintf(buf + len, buf_len - len, "ax_ulmumimo_total_trigger_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_ulmumimo_trigger_err));
+	len += scnprintf(buf + len, buf_len - len, "ax_bsr_trigger_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_bsr_trigger_err));
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_bar_trigger_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->ax_mu_bar_trigger_err));
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_rts_trigger_err = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->ax_mu_rts_trigger_err));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_selfgen_be_err_stats_tlv(const void *tag_buf, u16 tag_len,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_selfgen_be_err_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_BE_ERR_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "be_su_ndp_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_su_ndp_err));
+	len += scnprintf(buf + len, buf_len - len, "be_su_ndp_flushed = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_su_ndp_flushed));
+	len += scnprintf(buf + len, buf_len - len, "be_su_ndpa_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_su_ndpa_err));
+	len += scnprintf(buf + len, buf_len - len, "be_su_ndpa_flushed = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_su_ndpa_flushed));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_mimo_ndpa_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_mimo_ndpa_err));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_mimo_ndpa_flushed = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_mimo_ndpa_flushed));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_mimo_ndp_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_mimo_ndp_err));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_mimo_ndp_flushed = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_mimo_ndp_flushed));
+	len += print_array_to_buf_index(buf, len, "be_mu_mimo_brpX_err", 1,
+					htt_stats_buf->be_mu_mimo_brp_err,
+					ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS - 1,
+					"\n");
+	len += print_array_to_buf_index(buf, len, "be_mu_mimo_brpollX_flushed", 1,
+					htt_stats_buf->be_mu_mimo_brpoll_flushed,
+					ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS - 1,
+					"\n");
+	len += print_array_to_buf(buf, len, "be_mu_mimo_num_cbf_rcvd_on_brp_err",
+				  htt_stats_buf->be_mu_mimo_brp_err_num_cbf_rxd,
+				  ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS, "\n");
+	len += print_array_to_buf(buf, len, "be_ul_mumimo_trigger_err",
+				  htt_stats_buf->be_ul_mumimo_trigger_err,
+				  ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS, "\n");
+	len += scnprintf(buf + len, buf_len - len, "be_basic_trigger_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_basic_trigger_err));
+	len += scnprintf(buf + len, buf_len - len, "be_ulmumimo_total_trig_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_ulmumimo_trigger_err));
+	len += scnprintf(buf + len, buf_len - len, "be_bsr_trigger_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_bsr_trigger_err));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_bar_trigger_err = %u\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_bar_trigger_err));
+	len += scnprintf(buf + len, buf_len - len, "be_mu_rts_trigger_err = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->be_mu_rts_trigger_err));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_selfgen_ac_sched_status_stats_tlv(const void *tag_buf, u16 tag_len,
+						      struct debug_htt_stats_req *stats)
+{
+	const struct ath12k_htt_tx_selfgen_ac_sched_status_stats_tlv *htt_stats_buf =
+		     tag_buf;
+	u8 *buf = stats->buf;
+	u32 len = stats->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_SELFGEN_AC_SCHED_STATUS_STATS_TLV:\n");
+	len += print_array_to_buf(buf, len, "ac_su_ndpa_sch_status",
+				  htt_stats_buf->ac_su_ndpa_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ac_su_ndp_sch_status",
+				  htt_stats_buf->ac_su_ndp_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ac_mu_mimo_ndpa_sch_status",
+				  htt_stats_buf->ac_mu_mimo_ndpa_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ac_mu_mimo_ndp_sch_status",
+				  htt_stats_buf->ac_mu_mimo_ndp_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ac_mu_mimo_brp_sch_status",
+				  htt_stats_buf->ac_mu_mimo_brp_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ac_su_ndp_sch_flag_err",
+				  htt_stats_buf->ac_su_ndp_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "ac_mu_mimo_ndp_sch_flag_err",
+				  htt_stats_buf->ac_mu_mimo_ndp_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "ac_mu_mimo_brp_sch_flag_err",
+				  htt_stats_buf->ac_mu_mimo_brp_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n\n");
+
+	stats->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_selfgen_ax_sched_status_stats_tlv(const void *tag_buf, u16 tag_len,
+						      struct debug_htt_stats_req *stats)
+{
+	const struct ath12k_htt_tx_selfgen_ax_sched_status_stats_tlv *htt_stats_buf =
+		     tag_buf;
+	u8 *buf = stats->buf;
+	u32 len = stats->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_SELFGEN_AX_SCHED_STATUS_STATS_TLV:\n");
+	len += print_array_to_buf(buf, len, "ax_su_ndpa_sch_status",
+				  htt_stats_buf->ax_su_ndpa_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ax_su_ndp_sch_status",
+				  htt_stats_buf->ax_su_ndp_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ax_mu_mimo_ndpa_sch_status",
+				  htt_stats_buf->ax_mu_mimo_ndpa_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ax_mu_mimo_ndp_sch_status",
+				  htt_stats_buf->ax_mu_mimo_ndp_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ax_mu_brp_sch_status",
+				  htt_stats_buf->ax_mu_brp_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ax_mu_bar_sch_status",
+				  htt_stats_buf->ax_mu_bar_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ax_basic_trig_sch_status",
+				  htt_stats_buf->ax_basic_trig_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ax_su_ndp_sch_flag_err",
+				  htt_stats_buf->ax_su_ndp_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "ax_mu_mimo_ndp_sch_flag_err",
+				  htt_stats_buf->ax_mu_mimo_ndp_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "ax_mu_brp_sch_flag_err",
+				  htt_stats_buf->ax_mu_brp_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "ax_mu_bar_sch_flag_err",
+				  htt_stats_buf->ax_mu_bar_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "ax_basic_trig_sch_flag_err",
+				  htt_stats_buf->ax_basic_trig_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "ax_ulmumimo_trig_sch_status",
+				  htt_stats_buf->ax_ulmumimo_trig_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "ax_ulmumimo_trig_sch_flag_err",
+				  htt_stats_buf->ax_ulmumimo_trig_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n\n");
+
+	stats->buf_len = len;
+}
+
+static void
+ath12k_htt_print_tx_selfgen_be_sched_status_stats_tlv(const void *tag_buf, u16 tag_len,
+						      struct debug_htt_stats_req *stats)
+{
+	const struct ath12k_htt_tx_selfgen_be_sched_status_stats_tlv *htt_stats_buf =
+		     tag_buf;
+	u8 *buf = stats->buf;
+	u32 len = stats->buf_len;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_SELFGEN_BE_SCHED_STATUS_STATS_TLV:\n");
+	len += print_array_to_buf(buf, len, "be_su_ndpa_sch_status",
+				  htt_stats_buf->be_su_ndpa_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "be_su_ndp_sch_status",
+				  htt_stats_buf->be_su_ndp_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "be_mu_mimo_ndpa_sch_status",
+				  htt_stats_buf->be_mu_mimo_ndpa_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "be_mu_mimo_ndp_sch_status",
+				  htt_stats_buf->be_mu_mimo_ndp_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "be_mu_brp_sch_status",
+				  htt_stats_buf->be_mu_brp_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "be_mu_bar_sch_status",
+				  htt_stats_buf->be_mu_bar_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "be_basic_trig_sch_status",
+				  htt_stats_buf->be_basic_trig_sch_status,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "be_su_ndp_sch_flag_err",
+				  htt_stats_buf->be_su_ndp_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "be_mu_mimo_ndp_sch_flag_err",
+				  htt_stats_buf->be_mu_mimo_ndp_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "be_mu_brp_sch_flag_err",
+				  htt_stats_buf->be_mu_brp_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "be_mu_bar_sch_flag_err",
+				  htt_stats_buf->be_mu_bar_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "be_basic_trig_sch_flag_err",
+				  htt_stats_buf->be_basic_trig_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n");
+	len += print_array_to_buf(buf, len, "be_basic_trig_sch_flag_err",
+				  htt_stats_buf->be_basic_trig_sch_flag_err,
+				  ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS, "\n");
+	len += print_array_to_buf(buf, len, "be_ulmumimo_trig_sch_flag_err",
+				  htt_stats_buf->be_ulmumimo_trig_sch_flag_err,
+				  ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS, "\n\n");
+
+	stats->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -1560,6 +2016,39 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_TX_DE_COMPL_STATS_TAG:
 		ath12k_htt_print_tx_de_compl_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_SELFGEN_CMN_STATS_TAG:
+		ath12k_htt_print_tx_selfgen_cmn_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_SELFGEN_AC_STATS_TAG:
+		ath12k_htt_print_tx_selfgen_ac_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_SELFGEN_AX_STATS_TAG:
+		ath12k_htt_print_tx_selfgen_ax_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_SELFGEN_BE_STATS_TAG:
+		ath12k_htt_print_tx_selfgen_be_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_SELFGEN_AC_ERR_STATS_TAG:
+		ath12k_htt_print_tx_selfgen_ac_err_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_SELFGEN_AX_ERR_STATS_TAG:
+		ath12k_htt_print_tx_selfgen_ax_err_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_SELFGEN_BE_ERR_STATS_TAG:
+		ath12k_htt_print_tx_selfgen_be_err_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TX_SELFGEN_AC_SCHED_STATUS_STATS_TAG:
+		ath12k_htt_print_tx_selfgen_ac_sched_status_stats_tlv(tag_buf, len,
+								      stats_req);
+		break;
+	case HTT_STATS_TX_SELFGEN_AX_SCHED_STATUS_STATS_TAG:
+		ath12k_htt_print_tx_selfgen_ax_sched_status_stats_tlv(tag_buf, len,
+								      stats_req);
+		break;
+	case HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG:
+		ath12k_htt_print_tx_selfgen_be_sched_status_stats_tlv(tag_buf, len,
+								      stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index d52b26b23e65..350e7b9c12b2 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -123,12 +123,13 @@ struct ath12k_htt_extd_stats_msg {
 
 /* htt_dbg_ext_stats_type */
 enum ath12k_dbg_htt_ext_stats_type {
-	ATH12K_DBG_HTT_EXT_STATS_RESET		= 0,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX	= 1,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED	= 4,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR	= 5,
-	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM	= 6,
-	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO	= 8,
+	ATH12K_DBG_HTT_EXT_STATS_RESET			= 0,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX		= 1,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_SCHED		= 4,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_ERROR		= 5,
+	ATH12K_DBG_HTT_EXT_STATS_PDEV_TQM		= 6,
+	ATH12K_DBG_HTT_EXT_STATS_TX_DE_INFO		= 8,
+	ATH12K_DBG_HTT_EXT_STATS_TX_SELFGEN_INFO	= 12,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -156,6 +157,11 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_SCHED_TXQ_CMD_POSTED_TAG		= 39,
 	HTT_STATS_TX_TQM_ERROR_STATS_TAG                = 43,
 	HTT_STATS_SCHED_TXQ_CMD_REAPED_TAG		= 44,
+	HTT_STATS_TX_SELFGEN_AC_ERR_STATS_TAG		= 46,
+	HTT_STATS_TX_SELFGEN_CMN_STATS_TAG		= 47,
+	HTT_STATS_TX_SELFGEN_AC_STATS_TAG		= 48,
+	HTT_STATS_TX_SELFGEN_AX_STATS_TAG		= 49,
+	HTT_STATS_TX_SELFGEN_AX_ERR_STATS_TAG		= 50,
 	HTT_STATS_HW_INTR_MISC_TAG			= 54,
 	HTT_STATS_HW_PDEV_ERRS_TAG			= 56,
 	HTT_STATS_TX_DE_COMPL_STATS_TAG			= 65,
@@ -166,7 +172,12 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_HW_WAR_TAG				= 89,
 	HTT_STATS_SCHED_TXQ_SUPERCYCLE_TRIGGER_TAG	= 100,
 	HTT_STATS_PDEV_CTRL_PATH_TX_STATS_TAG		= 102,
+	HTT_STATS_TX_SELFGEN_AC_SCHED_STATUS_STATS_TAG	= 111,
+	HTT_STATS_TX_SELFGEN_AX_SCHED_STATUS_STATS_TAG	= 112,
 	HTT_STATS_MU_PPDU_DIST_TAG			= 129,
+	HTT_STATS_TX_SELFGEN_BE_ERR_STATS_TAG		= 137,
+	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
+	HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG	= 139,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -690,4 +701,167 @@ struct ath12k_htt_tx_de_compl_stats_tlv {
 	__le32 tqm_bypass_frame;
 } __packed;
 
+#define ATH12K_HTT_NUM_AC_WMM				0x4
+#define ATH12K_HTT_MAX_NUM_SBT_INTR			4
+#define ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS		4
+#define ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS		8
+#define ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS		8
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS	7
+
+struct ath12k_htt_tx_selfgen_cmn_stats_tlv {
+	__le32 mac_id__word;
+	__le32 su_bar;
+	__le32 rts;
+	__le32 cts2self;
+	__le32 qos_null;
+	__le32 delayed_bar_1;
+	__le32 delayed_bar_2;
+	__le32 delayed_bar_3;
+	__le32 delayed_bar_4;
+	__le32 delayed_bar_5;
+	__le32 delayed_bar_6;
+	__le32 delayed_bar_7;
+} __packed;
+
+struct ath12k_htt_tx_selfgen_ac_stats_tlv {
+	__le32 ac_su_ndpa;
+	__le32 ac_su_ndp;
+	__le32 ac_mu_mimo_ndpa;
+	__le32 ac_mu_mimo_ndp;
+	__le32 ac_mu_mimo_brpoll[ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS - 1];
+} __packed;
+
+struct ath12k_htt_tx_selfgen_ax_stats_tlv {
+	__le32 ax_su_ndpa;
+	__le32 ax_su_ndp;
+	__le32 ax_mu_mimo_ndpa;
+	__le32 ax_mu_mimo_ndp;
+	__le32 ax_mu_mimo_brpoll[ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS - 1];
+	__le32 ax_basic_trigger;
+	__le32 ax_bsr_trigger;
+	__le32 ax_mu_bar_trigger;
+	__le32 ax_mu_rts_trigger;
+	__le32 ax_ulmumimo_trigger;
+} __packed;
+
+struct ath12k_htt_tx_selfgen_be_stats_tlv {
+	__le32 be_su_ndpa;
+	__le32 be_su_ndp;
+	__le32 be_mu_mimo_ndpa;
+	__le32 be_mu_mimo_ndp;
+	__le32 be_mu_mimo_brpoll[ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS - 1];
+	__le32 be_basic_trigger;
+	__le32 be_bsr_trigger;
+	__le32 be_mu_bar_trigger;
+	__le32 be_mu_rts_trigger;
+	__le32 be_ulmumimo_trigger;
+	__le32 be_su_ndpa_queued;
+	__le32 be_su_ndp_queued;
+	__le32 be_mu_mimo_ndpa_queued;
+	__le32 be_mu_mimo_ndp_queued;
+	__le32 be_mu_mimo_brpoll_queued[ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS - 1];
+	__le32 be_ul_mumimo_trigger[ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS];
+} __packed;
+
+struct ath12k_htt_tx_selfgen_ac_err_stats_tlv {
+	__le32 ac_su_ndp_err;
+	__le32 ac_su_ndpa_err;
+	__le32 ac_mu_mimo_ndpa_err;
+	__le32 ac_mu_mimo_ndp_err;
+	__le32 ac_mu_mimo_brp1_err;
+	__le32 ac_mu_mimo_brp2_err;
+	__le32 ac_mu_mimo_brp3_err;
+} __packed;
+
+struct ath12k_htt_tx_selfgen_ax_err_stats_tlv {
+	__le32 ax_su_ndp_err;
+	__le32 ax_su_ndpa_err;
+	__le32 ax_mu_mimo_ndpa_err;
+	__le32 ax_mu_mimo_ndp_err;
+	__le32 ax_mu_mimo_brp_err[ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS - 1];
+	__le32 ax_basic_trigger_err;
+	__le32 ax_bsr_trigger_err;
+	__le32 ax_mu_bar_trigger_err;
+	__le32 ax_mu_rts_trigger_err;
+	__le32 ax_ulmumimo_trigger_err;
+} __packed;
+
+struct ath12k_htt_tx_selfgen_be_err_stats_tlv {
+	__le32 be_su_ndp_err;
+	__le32 be_su_ndpa_err;
+	__le32 be_mu_mimo_ndpa_err;
+	__le32 be_mu_mimo_ndp_err;
+	__le32 be_mu_mimo_brp_err[ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS - 1];
+	__le32 be_basic_trigger_err;
+	__le32 be_bsr_trigger_err;
+	__le32 be_mu_bar_trigger_err;
+	__le32 be_mu_rts_trigger_err;
+	__le32 be_ulmumimo_trigger_err;
+	__le32 be_mu_mimo_brp_err_num_cbf_rxd[ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS];
+	__le32 be_su_ndpa_flushed;
+	__le32 be_su_ndp_flushed;
+	__le32 be_mu_mimo_ndpa_flushed;
+	__le32 be_mu_mimo_ndp_flushed;
+	__le32 be_mu_mimo_brpoll_flushed[ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS - 1];
+	__le32 be_ul_mumimo_trigger_err[ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS];
+} __packed;
+
+enum ath12k_htt_tx_selfgen_sch_tsflag_error_stats {
+	ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_FLUSH_RCVD_ERR,
+	ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_FILT_SCHED_CMD_ERR,
+	ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_RESP_MISMATCH_ERR,
+	ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_RESP_CBF_MIMO_CTRL_MISMATCH_ERR,
+	ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_RESP_CBF_BW_MISMATCH_ERR,
+	ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_RETRY_COUNT_FAIL_ERR,
+	ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_RESP_TOO_LATE_RECEIVED_ERR,
+	ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_SIFS_STALL_NO_NEXT_CMD_ERR,
+
+	ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS
+};
+
+struct ath12k_htt_tx_selfgen_ac_sched_status_stats_tlv {
+	__le32 ac_su_ndpa_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ac_su_ndp_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ac_su_ndp_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 ac_mu_mimo_ndpa_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ac_mu_mimo_ndp_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ac_mu_mimo_ndp_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 ac_mu_mimo_brp_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ac_mu_mimo_brp_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+} __packed;
+
+struct ath12k_htt_tx_selfgen_ax_sched_status_stats_tlv {
+	__le32 ax_su_ndpa_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ax_su_ndp_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ax_su_ndp_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 ax_mu_mimo_ndpa_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ax_mu_mimo_ndp_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ax_mu_mimo_ndp_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 ax_mu_brp_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ax_mu_brp_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 ax_mu_bar_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ax_mu_bar_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 ax_basic_trig_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ax_basic_trig_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 ax_ulmumimo_trig_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 ax_ulmumimo_trig_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+} __packed;
+
+struct ath12k_htt_tx_selfgen_be_sched_status_stats_tlv {
+	__le32 be_su_ndpa_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 be_su_ndp_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 be_su_ndp_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 be_mu_mimo_ndpa_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 be_mu_mimo_ndp_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 be_mu_mimo_ndp_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 be_mu_brp_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 be_mu_brp_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 be_mu_bar_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 be_mu_bar_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 be_basic_trig_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 be_basic_trig_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+	__le32 be_ulmumimo_trig_sch_status[ATH12K_HTT_TX_PDEV_STATS_NUM_TX_ERR_STATUS];
+	__le32 be_ulmumimo_trig_sch_flag_err[ATH12K_HTT_TX_SELFGEN_SCH_TSFLAG_ERR_STATS];
+} __packed;
+
 #endif
-- 
2.25.1


