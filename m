Return-Path: <linux-wireless+bounces-15779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230F19DB64B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 12:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C6AB2633D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83A197A6C;
	Thu, 28 Nov 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZPvEpHjL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5819415D
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792217; cv=none; b=Wv0ALghAAZHwAVOQx9sL6fu+a1eXC/QF46oqARP5mXkRvlFInOEQIMRI3ssqZCEqNjunoJz8LZrCsJXrxXX/vQXv3XDsWRVBCPQW4lrd2N5OMk3qeZVhtlgtRPFbbEXMgO5NweqLZ/On67e1ZTndguf2NbnfBvG/pUJr706em30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792217; c=relaxed/simple;
	bh=1SE1XRuw8KtpQ88eWjcyHqNB43RzShgM2Pj20f329XY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxCgVYdFDFG62UqigFM0ly37FA2AIhS8V5mBrheCK0s8OVwzkO3cp5l9gBXOldQs6RpDg+zBFJZnDcQNQrs5efGfNhohrbwatZr2qNyKB4gQr70YcC89Fdpv7Ilvr9xm+VoiyWG2ItUs/z+xCdAyKEuAqxbDCDhRDh6OABsOjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZPvEpHjL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS8Xubm022951;
	Thu, 28 Nov 2024 11:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	50NfGbjgIKks949vpzLv6bIciZVsrQes0ZCXkGyPaHk=; b=ZPvEpHjLUC8GoAZw
	l4dvJtk5tmidKrWaSttyMNdi+FnKmR/xocNuwqyOWPM36dsJK4iP4W3Ot7VUhwX3
	/97RHkLRn+rvGlkWnCSEPNi3FXoAKkVD3BeoZLFhAsCiAVD/kpxQldgv2WJZeHyF
	vob3T7Jy/T39gYOTZ+VJAPfxp/3z5G1+MHSmNCrcwBV0f0Pl6G0gtW2m63CnTBMe
	33cpcln+FEIIZf4qulg3Lwv7rJEVBvBG6w1xLotsmnNxWokBeUEjf6XSrtTOhLil
	t2r7nhnqBWXf8525rjqfj5NyE8/S1KJmzvplvIXzSkyi6VAOG1RnL3h98iE7GacY
	+dcD+g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xw2em8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 11:10:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASBADdY013073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 11:10:13 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Nov 2024 03:10:10 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: Support Transmit Buffer OFDMA Stats
Date: Thu, 28 Nov 2024 16:39:49 +0530
Message-ID: <20241128110949.3672364-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
References: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: N-XwWbHslDtKGTne7gUsiEGJacEQFMCx
X-Proofpoint-ORIG-GUID: N-XwWbHslDtKGTne7gUsiEGJacEQFMCx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411280088

From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

Add support to request OFDMA stats of transmit buffers from firmware through
HTT stats type 32. These stats give information about NDPA, NDP, BRP and
steering mechanisms.

Note: WCN7850 firmware version -
WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
support HTT stats type 32.

Sample output:
-------------
echo 32 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_TXBF_OFDMA_AX_NDPA_STATS_TLV:
ax_ofdma_ndpa_queued = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
ax_ofdma_ndpa_tried = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
.....

HTT_TXBF_OFDMA_AX_NDP_STATS_TLV:
ax_ofdma_ndp_queued = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
ax_ofdma_ndp_tried = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
.....

HTT_TXBF_OFDMA_AX_BRP_STATS_TLV:
ax_ofdma_brpoll_queued = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
ax_ofdma_brpoll_tied = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
.....

HTT_TXBF_OFDMA_AX_STEER_STATS_TLV:
ax_ofdma_num_ppdu_steer = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
ax_ofdma_num_usrs_prefetch = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
.....

HTT_TXBF_OFDMA_AX_STEER_MPDU_STATS_TLV:
rbo_steer_mpdus_tried = 0
rbo_steer_mpdus_failed = 0
sifs_steer_mpdus_tried = 0
sifs_steer_mpdus_failed = 0

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 250 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  67 +++++
 2 files changed, 317 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index d72eb22a719b..c43bf032270f 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2668,6 +2668,240 @@ ath12k_htt_print_pdev_tx_rate_txbf_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_txbf_ofdma_ax_ndpa_stats_tlv(const void *tag_buf, u16 tag_len,
+					      struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_txbf_ofdma_ax_ndpa_stats_tlv *stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	u32 num_elements;
+	u8 i;
+
+	if (tag_len < sizeof(*stats_buf))
+		return;
+
+	num_elements = le32_to_cpu(stats_buf->num_elems_ax_ndpa_arr);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TXBF_OFDMA_AX_NDPA_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ax_ofdma_ndpa_queued =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_ndpa[i].ax_ofdma_ndpa_queued));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_ndpa_tried =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_ndpa[i].ax_ofdma_ndpa_tried));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_ndpa_flushed =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_ndpa[i].ax_ofdma_ndpa_flush));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_ndpa_err =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_ndpa[i].ax_ofdma_ndpa_err));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_txbf_ofdma_ax_ndp_stats_tlv(const void *tag_buf, u16 tag_len,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_txbf_ofdma_ax_ndp_stats_tlv *stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	u32 num_elements;
+	u8 i;
+
+	if (tag_len < sizeof(*stats_buf))
+		return;
+
+	num_elements = le32_to_cpu(stats_buf->num_elems_ax_ndp_arr);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TXBF_OFDMA_AX_NDP_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ax_ofdma_ndp_queued =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_ndp[i].ax_ofdma_ndp_queued));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_ndp_tried =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_ndp[i].ax_ofdma_ndp_tried));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_ndp_flushed =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_ndp[i].ax_ofdma_ndp_flush));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_ndp_err =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_ndp[i].ax_ofdma_ndp_err));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_txbf_ofdma_ax_brp_stats_tlv(const void *tag_buf, u16 tag_len,
+					     struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_txbf_ofdma_ax_brp_stats_tlv *stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	u32 num_elements;
+	u8 i;
+
+	if (tag_len < sizeof(*stats_buf))
+		return;
+
+	num_elements = le32_to_cpu(stats_buf->num_elems_ax_brp_arr);
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_TXBF_OFDMA_AX_BRP_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ax_ofdma_brpoll_queued =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_brp[i].ax_ofdma_brp_queued));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_brpoll_tied =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_brp[i].ax_ofdma_brp_tried));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_brpoll_flushed =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_brp[i].ax_ofdma_brp_flushed));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_brp_err =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_brp[i].ax_ofdma_brp_err));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_brp_err_num_cbf_rcvd =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_brp[i].ax_ofdma_num_cbf_rcvd));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_txbf_ofdma_ax_steer_stats_tlv(const void *tag_buf, u16 tag_len,
+					       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_txbf_ofdma_ax_steer_stats_tlv *stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	u32 num_elements;
+	u8 i;
+
+	if (tag_len < sizeof(*stats_buf))
+		return;
+
+	num_elements = le32_to_cpu(stats_buf->num_elems_ax_steer_arr);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TXBF_OFDMA_AX_STEER_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ax_ofdma_num_ppdu_steer =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_steer[i].num_ppdu_steer));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_num_usrs_prefetch =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_steer[i].num_usr_prefetch));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_num_usrs_sound =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_steer[i].num_usr_sound));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\nax_ofdma_num_usrs_force_sound =");
+	for (i = 0; i < num_elements; i++)
+		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
+				 le32_to_cpu(stats_buf->ax_steer[i].num_usr_force_sound));
+	len--;
+	*(buf + len) = '\0';
+
+	len += scnprintf(buf + len, buf_len - len, "\n\n");
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_txbf_ofdma_ax_steer_mpdu_stats_tlv(const void *tag_buf, u16 tag_len,
+						    struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_txbf_ofdma_ax_steer_mpdu_stats_tlv *stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+
+	if (tag_len < sizeof(*stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TXBF_OFDMA_AX_STEER_MPDU_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "rbo_steer_mpdus_tried = %u\n",
+			 le32_to_cpu(stats_buf->ax_ofdma_rbo_steer_mpdus_tried));
+	len += scnprintf(buf + len, buf_len - len, "rbo_steer_mpdus_failed = %u\n",
+			 le32_to_cpu(stats_buf->ax_ofdma_rbo_steer_mpdus_failed));
+	len += scnprintf(buf + len, buf_len - len, "sifs_steer_mpdus_tried = %u\n",
+			 le32_to_cpu(stats_buf->ax_ofdma_sifs_steer_mpdus_tried));
+	len += scnprintf(buf + len, buf_len - len, "sifs_steer_mpdus_failed = %u\n\n",
+			 le32_to_cpu(stats_buf->ax_ofdma_sifs_steer_mpdus_failed));
+
+	stats_req->buf_len = len;
+}
+
 static void ath12k_htt_print_dlpager_entry(const struct ath12k_htt_pgs_info *pg_info,
 					   int idx, char *str_buf)
 {
@@ -3603,6 +3837,22 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG:
 		ath12k_htt_print_pdev_tx_rate_txbf_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TXBF_OFDMA_AX_NDPA_STATS_TAG:
+		ath12k_htt_print_txbf_ofdma_ax_ndpa_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TXBF_OFDMA_AX_NDP_STATS_TAG:
+		ath12k_htt_print_txbf_ofdma_ax_ndp_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TXBF_OFDMA_AX_BRP_STATS_TAG:
+		ath12k_htt_print_txbf_ofdma_ax_brp_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TXBF_OFDMA_AX_STEER_STATS_TAG:
+		ath12k_htt_print_txbf_ofdma_ax_steer_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_TXBF_OFDMA_AX_STEER_MPDU_STATS_TAG:
+		ath12k_htt_print_txbf_ofdma_ax_steer_mpdu_stats_tlv(tag_buf, len,
+								    stats_req);
+		break;
 	case HTT_STATS_DLPAGER_STATS_TAG:
 		ath12k_htt_print_dlpager_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 859f5c846016..a718f8dfe321 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -136,6 +136,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF	= 31,
+	ATH12K_DBG_HTT_EXT_STATS_TXBF_OFDMA		= 32,
 	ATH12K_DBG_HTT_EXT_STATS_DLPAGER_STATS		= 36,
 	ATH12K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	= 37,
 	ATH12K_DBG_HTT_EXT_VDEVS_TXRX_STATS		= 38,
@@ -214,9 +215,14 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_TX_SELFGEN_BE_ERR_STATS_TAG		= 137,
 	HTT_STATS_TX_SELFGEN_BE_STATS_TAG		= 138,
 	HTT_STATS_TX_SELFGEN_BE_SCHED_STATUS_STATS_TAG	= 139,
+	HTT_STATS_TXBF_OFDMA_AX_NDPA_STATS_TAG		= 147,
+	HTT_STATS_TXBF_OFDMA_AX_NDP_STATS_TAG		= 148,
+	HTT_STATS_TXBF_OFDMA_AX_BRP_STATS_TAG		= 149,
+	HTT_STATS_TXBF_OFDMA_AX_STEER_STATS_TAG		= 150,
 	HTT_STATS_DMAC_RESET_STATS_TAG			= 155,
 	HTT_STATS_PHY_TPC_STATS_TAG			= 157,
 	HTT_STATS_PDEV_SCHED_ALGO_OFDMA_STATS_TAG	= 165,
+	HTT_STATS_TXBF_OFDMA_AX_STEER_MPDU_STATS_TAG	= 172,
 	HTT_STATS_PDEV_MBSSID_CTRL_FRAME_STATS_TAG	= 176,
 
 	HTT_STATS_MAX_TAG,
@@ -1100,6 +1106,67 @@ struct ath12k_htt_pdev_txrate_txbf_stats_tlv {
 	__le32 txbf_flag_not_set_final_status;
 } __packed;
 
+struct ath12k_htt_txbf_ofdma_ax_ndpa_stats_elem_t {
+	__le32 ax_ofdma_ndpa_queued;
+	__le32 ax_ofdma_ndpa_tried;
+	__le32 ax_ofdma_ndpa_flush;
+	__le32 ax_ofdma_ndpa_err;
+} __packed;
+
+struct ath12k_htt_txbf_ofdma_ax_ndpa_stats_tlv {
+	__le32 num_elems_ax_ndpa_arr;
+	__le32 arr_elem_size_ax_ndpa;
+	DECLARE_FLEX_ARRAY(struct ath12k_htt_txbf_ofdma_ax_ndpa_stats_elem_t, ax_ndpa);
+} __packed;
+
+struct ath12k_htt_txbf_ofdma_ax_ndp_stats_elem_t {
+	__le32 ax_ofdma_ndp_queued;
+	__le32 ax_ofdma_ndp_tried;
+	__le32 ax_ofdma_ndp_flush;
+	__le32 ax_ofdma_ndp_err;
+} __packed;
+
+struct ath12k_htt_txbf_ofdma_ax_ndp_stats_tlv {
+	__le32 num_elems_ax_ndp_arr;
+	__le32 arr_elem_size_ax_ndp;
+	DECLARE_FLEX_ARRAY(struct ath12k_htt_txbf_ofdma_ax_ndp_stats_elem_t, ax_ndp);
+} __packed;
+
+struct ath12k_htt_txbf_ofdma_ax_brp_stats_elem_t {
+	__le32 ax_ofdma_brp_queued;
+	__le32 ax_ofdma_brp_tried;
+	__le32 ax_ofdma_brp_flushed;
+	__le32 ax_ofdma_brp_err;
+	__le32 ax_ofdma_num_cbf_rcvd;
+} __packed;
+
+struct ath12k_htt_txbf_ofdma_ax_brp_stats_tlv {
+	__le32 num_elems_ax_brp_arr;
+	__le32 arr_elem_size_ax_brp;
+	DECLARE_FLEX_ARRAY(struct ath12k_htt_txbf_ofdma_ax_brp_stats_elem_t, ax_brp);
+} __packed;
+
+struct ath12k_htt_txbf_ofdma_ax_steer_stats_elem_t {
+	__le32 num_ppdu_steer;
+	__le32 num_ppdu_ol;
+	__le32 num_usr_prefetch;
+	__le32 num_usr_sound;
+	__le32 num_usr_force_sound;
+} __packed;
+
+struct ath12k_htt_txbf_ofdma_ax_steer_stats_tlv {
+	__le32 num_elems_ax_steer_arr;
+	__le32 arr_elem_size_ax_steer;
+	DECLARE_FLEX_ARRAY(struct ath12k_htt_txbf_ofdma_ax_steer_stats_elem_t, ax_steer);
+} __packed;
+
+struct ath12k_htt_txbf_ofdma_ax_steer_mpdu_stats_tlv {
+	__le32 ax_ofdma_rbo_steer_mpdus_tried;
+	__le32 ax_ofdma_rbo_steer_mpdus_failed;
+	__le32 ax_ofdma_sifs_steer_mpdus_tried;
+	__le32 ax_ofdma_sifs_steer_mpdus_failed;
+} __packed;
+
 enum ath12k_htt_stats_page_lock_state {
 	ATH12K_HTT_STATS_PAGE_LOCKED	= 0,
 	ATH12K_HTT_STATS_PAGE_UNLOCKED	= 1,
-- 
2.25.1


