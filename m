Return-Path: <linux-wireless+bounces-24172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21E0ADC176
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 07:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B0016A834
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 05:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E423ED5A;
	Tue, 17 Jun 2025 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XQuqQXff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130223E35F
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 05:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137158; cv=none; b=DKo3GxLDmTQjURPgbYeiguSRyrEooSZSmB2bdjK9N1aPq7Z1PYXw9W7DCdZBryFiCCFKZcJBZGoAKVYc3Y5i7y4NBEI/v/SYl4+tbUhEG02SNsQJmzPsJZEkE60KuqJnyPjbPNYbH2vVUtOZnDUhV90/+JHPjPQ3enoUyPEijz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137158; c=relaxed/simple;
	bh=vpQwOPpy6HRr2JbyoVTaLulExRFBQ3fulEMZN14paPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOIo6ob+KvrE3ixjGo90KnM0+giwRWvBU4nbW+An56pcEPNFK2VJBrvoXClx0yU2rAxK785dKGzDz/LiKmCFjuRGCVY49Utfs/kJiFDlsJOUYwQUxJsA6oReALZEIbH8lRiDXzn7qxIJ1O+iHdEK5DWz/DxCzikUaaefTmXLabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XQuqQXff; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GKBDg7014469;
	Tue, 17 Jun 2025 05:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wNf6M51YTEHw5/jzdb7dMQIabef2ccclwUwj/pSpdwY=; b=XQuqQXffrmBWNJey
	35HOSxs6aYFF5mha3JRKlgkuQJnSu/ie4Wbu7+odGGLt6REVEMRKlPnzmWw1qRtJ
	XqIz2KoQkYS0lOdjYrunBLbxZUTGDrRCQkNljGI0Mg44LQDsdahEyhjjDtj0QSnR
	M+Icg6KRz/rEh5NZ5Dl62Nz7URBI17scGzPhU/+KbRCXZowFtOjWt5cjuk3yj+Tp
	jTaNJB95DNxwENWE000Hme4aZJoO9bUKfqTkzrAabDhvNW+o+/wxw0jOiJo0JHob
	zhGJMR0WRCo/vNHSZtjFhME27cnon3XZBLvzj+Gd9OjNf9BERSddVgFExBcBTnmX
	RLpAwQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47akuwaagt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 05:12:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55H5CV6A030565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 05:12:31 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 16 Jun 2025 22:12:28 -0700
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Maharaja Kennadyrajan
	<quic_mkenna@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH ath-next 2/2] wifi: ath12k: Add support to RTT stats
Date: Tue, 17 Jun 2025 10:41:36 +0530
Message-ID: <20250617051136.264193-3-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617051136.264193-1-quic_rdevanat@quicinc.com>
References: <20250617051136.264193-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: k5dXYRCHv3_XV-quClcyDc_nbDvqWzfs
X-Authority-Analysis: v=2.4 cv=He0UTjE8 c=1 sm=1 tr=0 ts=6850f93f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=w2mKb6LnFITlTI3dxoQA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: k5dXYRCHv3_XV-quClcyDc_nbDvqWzfs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAzOSBTYWx0ZWRfX4wR+i8VR9ZjR
 bEjPx8XQIAQSP2bGA8js7lCQdC8wPnSH+rh9bO51GdvKIHb5r8LyoJbnMMPQfbl/LsiwtUzVm6g
 iP75sJnzIMw92RBSNcR1hiFAbBHyuR/6IM6vzDuWlBe+t1BHk1RonePVueJtgpGXcVcMIhrIx6a
 SZw82di9L26FMgHmwm3u8dA4ZO5Rlnxm+JJqM9zBhhhgGPcRXHkeblprefRBB7a/Oc1kv7/z0wn
 11dVxZ8la05yg59NlHoSAlBgCPoD+2fk/jxbW1Akjnj4rXIaRiLknfmDzMvqbXZmDBe5x44QZra
 LV76QHG20eQzX49QatmZzJ0NR5ZFpDd+e/iMPfAghb85n6X+QwxlkL2DUzx8brTHtauHUFHDHs/
 ALkiiDAH2fjCcUpAT/eMabPdznGk8Ha5HTx/NiLKhCEOpd7hzg0csPF2V6yEMuncl681mCzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170039

From: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>

Add support to request RTT stats from firmware through HTT stats type 65
and 66. HTT stats type 65 support RTT response stats, RTT hardware stats,
RTT to-be-read self-generated stats and RTT command-result stats and HTT
stats type 66 support RTT initiator stats and RTT hardware stats. These
stats give information about number of scheduled commands, responder
allocation and termination count, initiator termination count, PASN
authentication drop and receive counts, etc.

Note: WCN firmware version -
WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3 does not support
tags HTT_STATS_PDEV_RTT_RESP_STATS_TAG(194),
HTT_STATS_PDEV_RTT_INIT_STATS_TAG(195),
HTT_STATS_PDEV_RTT_HW_STATS_TAG(196),
HTT_STATS_PDEV_RTT_TBR_SELFGEN_QUEUED_STATS_TAG(197) and
HTT_STATS_PDEV_RTT_TBR_CMD_RESULT_STATS_TAG(198), currently.

Sample output:
echo 65 > /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats
HTT_PDEV_RTT_RESP_STATS_TLV:
pdev_id = 0
tx_11mc_ftm_suc = 0
tx_11mc_ftm_suc_retry = 0
tx_11mc_ftm_fail = 0
.....

HTT_STATS_PDEV_RTT_HW_STATS_TAG:
ista_ranging_ndpa_cnt = 0
ista_ranging_ndp_cnt = 0
ista_ranging_i2r_lmr_cnt = 0
rtsa_ranging_resp_cnt = 0
.....

HTT_STATS_PDEV_RTT_TBR_SELFGEN_QUEUED_STATS_TAG:
SU poll = 0
SU sound = 0
.....
MU poll = 0
MU sound = 0
.....

HTT_STATS_PDEV_RTT_TBR_CMD_RESULT_STATS_TAG:
num_sch_cmd_status_0:
SU frame_SGEN_TF_POLL = 0
SU frame_SGEN_TF_SOUND = 0
SU frame_SGEN_TBR_NDPA = 0
SU frame_SGEN_TBR_NDP = 0
SU frame_SGEN_TBR_LMR = 0
SU frame_SGEN_TF_REPORT = 0
MU frame_SGEN_TF_POLL = 0
.....

echo 66 > /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:58\:00.0/mac0/htt_stats
HTT_PDEV_RTT_INIT_STATS_TLV:
pdev_id = 0
tx_11mc_ftmr_cnt = 0
tx_11mc_ftmr_fail = 0
tx_11mc_ftmr_suc_retry = 0
rx_11mc_ftm_cnt = 0
rx_11az_ftm_cnt = 0
.....

HTT_STATS_PDEV_RTT_HW_STATS_TAG:
ista_ranging_ndpa_cnt = 0
ista_ranging_ndp_cnt = 0
ista_ranging_i2r_lmr_cnt = 0
rtsa_ranging_resp_cnt = 0
rtsa_ranging_ndp_cnt = 0
rsta_ranging_lmr_cnt = 0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 420 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 155 +++++++
 2 files changed, 575 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 3bc3bc3f47a0..76cbaaff0ca3 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -5102,6 +5102,410 @@ ath12k_htt_print_mlo_ipc_stats_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_pdev_rtt_resp_stats_tlv(const void *tag_buf, u16 tag_len,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_stats_pdev_rtt_resp_stats_tlv *sbuf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+
+	if (tag_len < sizeof(*sbuf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_RTT_RESP_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 le32_to_cpu(sbuf->pdev_id));
+	len += scnprintf(buf + len, buf_len - len, "tx_11mc_ftm_suc = %u\n",
+			 le32_to_cpu(sbuf->tx_11mc_ftm_suc));
+	len += scnprintf(buf + len, buf_len - len, "tx_11mc_ftm_suc_retry = %u\n",
+			 le32_to_cpu(sbuf->tx_11mc_ftm_suc_retry));
+	len += scnprintf(buf + len, buf_len - len, "tx_11mc_ftm_fail = %u\n",
+			 le32_to_cpu(sbuf->tx_11mc_ftm_fail));
+	len += scnprintf(buf + len, buf_len - len, "rx_11mc_ftmr_cnt = %u\n",
+			 le32_to_cpu(sbuf->rx_11mc_ftmr_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_11mc_ftmr_dup_cnt = %u\n",
+			 le32_to_cpu(sbuf->rx_11mc_ftmr_dup_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_11mc_iftmr_cnt = %u\n",
+			 le32_to_cpu(sbuf->rx_11mc_iftmr_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_11mc_iftmr_dup_cnt = %u\n",
+			 le32_to_cpu(sbuf->rx_11mc_iftmr_dup_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ftmr_drop_11mc_resp_role_not_enabled_cnt = %u\n",
+			 le32_to_cpu(sbuf->ftmr_drop_11mc_resp_role_not_enabled_cnt));
+	len += scnprintf(buf + len, buf_len - len, "tx_11az_ftm_successful = %u\n",
+			 le32_to_cpu(sbuf->tx_11az_ftm_successful));
+	len += scnprintf(buf + len, buf_len - len, "tx_11az_ftm_failed = %u\n",
+			 le32_to_cpu(sbuf->tx_11az_ftm_failed));
+	len += scnprintf(buf + len, buf_len - len, "rx_11az_ftmr_cnt = %u\n",
+			 le32_to_cpu(sbuf->rx_11az_ftmr_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_11az_ftmr_dup_cnt = %u\n",
+			 le32_to_cpu(sbuf->rx_11az_ftmr_dup_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_11az_iftmr_dup_cnt = %u\n",
+			 le32_to_cpu(sbuf->rx_11az_iftmr_dup_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "initiator_active_responder_rejected_cnt = %u\n",
+			 le32_to_cpu(sbuf->initiator_active_responder_rejected_cnt));
+	len += scnprintf(buf + len, buf_len - len, "malformed_ftmr = %u\n",
+			 le32_to_cpu(sbuf->malformed_ftmr));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ftmr_drop_ntb_resp_role_not_enabled_cnt = %u\n",
+			 le32_to_cpu(sbuf->ftmr_drop_ntb_resp_role_not_enabled_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ftmr_drop_tb_resp_role_not_enabled_cnt = %u\n",
+			 le32_to_cpu(sbuf->ftmr_drop_tb_resp_role_not_enabled_cnt));
+	len += scnprintf(buf + len, buf_len - len, "responder_alloc_cnt = %u\n",
+			 le32_to_cpu(sbuf->responder_alloc_cnt));
+	len += scnprintf(buf + len, buf_len - len, "responder_alloc_failure = %u\n",
+			 le32_to_cpu(sbuf->responder_alloc_failure));
+	len += scnprintf(buf + len, buf_len - len, "responder_terminate_cnt = %u\n",
+			 le32_to_cpu(sbuf->responder_terminate_cnt));
+	len += scnprintf(buf + len, buf_len - len, "active_rsta_open = %u\n",
+			 le32_to_cpu(sbuf->active_rsta_open));
+	len += scnprintf(buf + len, buf_len - len, "active_rsta_mac = %u\n",
+			 le32_to_cpu(sbuf->active_rsta_mac));
+	len += scnprintf(buf + len, buf_len - len, "active_rsta_mac_phy = %u\n",
+			 le32_to_cpu(sbuf->active_rsta_mac_phy));
+	len += scnprintf(buf + len, buf_len - len, "pn_check_failure_cnt = %u\n",
+			 le32_to_cpu(sbuf->pn_check_failure_cnt));
+	len += scnprintf(buf + len, buf_len - len, "num_assoc_ranging_peers = %u\n",
+			 le32_to_cpu(sbuf->num_assoc_ranging_peers));
+	len += scnprintf(buf + len, buf_len - len, "num_unassoc_ranging_peers = %u\n",
+			 le32_to_cpu(sbuf->num_unassoc_ranging_peers));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m1_auth_recv_cnt = %u\n",
+			 le32_to_cpu(sbuf->pasn_m1_auth_recv_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m1_auth_drop_cnt = %u\n",
+			 le32_to_cpu(sbuf->pasn_m1_auth_drop_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m2_auth_recv_cnt = %u\n",
+			 le32_to_cpu(sbuf->pasn_m2_auth_recv_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m2_auth_tx_fail_cnt = %u\n",
+			 le32_to_cpu(sbuf->pasn_m2_auth_tx_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m3_auth_recv_cnt = %u\n",
+			 le32_to_cpu(sbuf->pasn_m3_auth_recv_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m3_auth_drop_cnt = %u\n",
+			 le32_to_cpu(sbuf->pasn_m3_auth_drop_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_peer_create_request_cnt = %u\n",
+			 le32_to_cpu(sbuf->pasn_peer_create_request_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_peer_created_cnt = %u\n",
+			 le32_to_cpu(sbuf->pasn_peer_created_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_peer_create_timeout_cnt = %u\n",
+			 le32_to_cpu(sbuf->pasn_peer_create_timeout_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "sec_ranging_not_supported_mfp_not_setup = %u\n",
+			 le32_to_cpu(sbuf->sec_ranging_not_supported_mfp_not_setup));
+	len += scnprintf(buf + len, buf_len - len,
+			 "non_sec_ranging_discarded_for_assoc_peer_with_mfpr_set = %u\n",
+			 le32_to_cpu(sbuf->non_sec_ranging_discarded_for_assoc_peer));
+	len += scnprintf(buf + len, buf_len - len,
+			 "open_ranging_discarded_with_URNM_MFPR_set_for_pasn_peer = %u\n",
+			 le32_to_cpu(sbuf->open_ranging_discarded_set_for_pasn_peer));
+	len += scnprintf(buf + len, buf_len - len,
+			 "unassoc_non_pasn_ranging_not_supported_with_URNM_MFPR = %u\n",
+			 le32_to_cpu(sbuf->unassoc_non_pasn_ranging_not_supported));
+	len += scnprintf(buf + len, buf_len - len, "invalid_ftm_request_params = %u\n",
+			 le32_to_cpu(sbuf->invalid_ftm_request_params));
+	len += scnprintf(buf + len, buf_len - len,
+			 "requested_bw_format_not_supported = %u\n",
+			 le32_to_cpu(sbuf->requested_bw_format_not_supported));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ntb_unsec_unassoc_mode_ranging_peer_alloc_failed = %u\n",
+			 le32_to_cpu(sbuf->ntb_unsec_unassoc_ranging_peer_alloc_failed));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tb_unassoc_unsec_mode_pasn_peer_creation_failed = %u\n",
+			 le32_to_cpu(sbuf->tb_unassoc_unsec_pasn_peer_creation_failed));
+	len += scnprintf(buf + len, buf_len - len,
+			 "num_ranging_sequences_processed = %u\n",
+			 le32_to_cpu(sbuf->num_ranging_sequences_processed));
+	len += scnprintf(buf + len, buf_len - len, "ndp_rx_cnt = %u\n",
+			 le32_to_cpu(sbuf->ndp_rx_cnt));
+	len += scnprintf(buf + len, buf_len - len, "num_req_bw_20_MHz = %u\n",
+			 le32_to_cpu(sbuf->num_req_bw_20_mhz));
+	len += scnprintf(buf + len, buf_len - len, "num_req_bw_40_MHz = %u\n",
+			 le32_to_cpu(sbuf->num_req_bw_40_mhz));
+	len += scnprintf(buf + len, buf_len - len, "num_req_bw_80_MHz = %u\n",
+			 le32_to_cpu(sbuf->num_req_bw_80_mhz));
+	len += scnprintf(buf + len, buf_len - len, "num_req_bw_160_MHz = %u\n",
+			 le32_to_cpu(sbuf->num_req_bw_160_mhz));
+	len += scnprintf(buf + len, buf_len - len, "ntb_tx_ndp = %u\n",
+			 le32_to_cpu(sbuf->ntb_tx_ndp));
+	len += scnprintf(buf + len, buf_len - len, "num_ntb_ranging_NDPAs_recv = %u\n",
+			 le32_to_cpu(sbuf->num_ntb_ranging_ndpas_recv));
+	len += scnprintf(buf + len, buf_len - len, "recv_lmr = %u\n",
+			 le32_to_cpu(sbuf->recv_lmr));
+	len += scnprintf(buf + len, buf_len - len, "invalid_ftmr_cnt = %u\n",
+			 le32_to_cpu(sbuf->invalid_ftmr_cnt));
+	len += scnprintf(buf + len, buf_len - len, "max_time_bw_meas_exp_cnt = %u\n\n",
+			 le32_to_cpu(sbuf->max_time_bw_meas_exp_cnt));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_pdev_rtt_init_stats_tlv(const void *tag_buf, u16 tag_len,
+					 struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_stats_pdev_rtt_init_stats_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf, i;
+	__le32 sch_fail;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_RTT_INIT_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 le32_to_cpu(htt_stats_buf->pdev_id));
+	len += scnprintf(buf + len, buf_len - len, "tx_11mc_ftmr_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_11mc_ftmr_cnt));
+	len += scnprintf(buf + len, buf_len - len, "tx_11mc_ftmr_fail = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_11mc_ftmr_fail));
+	len += scnprintf(buf + len, buf_len - len, "tx_11mc_ftmr_suc_retry = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_11mc_ftmr_suc_retry));
+	len += scnprintf(buf + len, buf_len - len, "rx_11mc_ftm_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_11mc_ftm_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rx_11az_ftm_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rx_11az_ftm_cnt));
+	len += scnprintf(buf + len, buf_len - len, "initiator_terminate_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->initiator_terminate_cnt));
+	len += scnprintf(buf + len, buf_len - len, "tx_meas_req_count = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_meas_req_count));
+	len += scnprintf(buf + len, buf_len - len, "tx_11az_ftmr_start = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_11az_ftmr_start));
+	len += scnprintf(buf + len, buf_len - len, "tx_11az_ftmr_stop = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_11az_ftmr_stop));
+	len += scnprintf(buf + len, buf_len - len, "tx_11az_ftmr_fail = %u\n",
+			 le32_to_cpu(htt_stats_buf->tx_11az_ftmr_fail));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ftmr_tx_failed_null_11az_peer = %u\n",
+			 le32_to_cpu(htt_stats_buf->ftmr_tx_failed_null_11az_peer));
+	len += scnprintf(buf + len, buf_len - len, "ftmr_retry_timeout = %u\n",
+			 le32_to_cpu(htt_stats_buf->ftmr_retry_timeout));
+	len += scnprintf(buf + len, buf_len - len, "ftm_parse_failure = %u\n",
+			 le32_to_cpu(htt_stats_buf->ftm_parse_failure));
+	len += scnprintf(buf + len, buf_len - len, "incompatible_ftm_params = %u\n",
+			 le32_to_cpu(htt_stats_buf->incompatible_ftm_params));
+	len += scnprintf(buf + len, buf_len - len,
+			 "ranging_negotiation_successful_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->ranging_negotiation_successful_cnt));
+	len += scnprintf(buf + len, buf_len - len, "active_ista = %u\n",
+			 le32_to_cpu(htt_stats_buf->active_ista));
+	len += scnprintf(buf + len, buf_len - len, "init_role_not_enabled = %u\n",
+			 le32_to_cpu(htt_stats_buf->init_role_not_enabled));
+	len += scnprintf(buf + len, buf_len - len, "invalid_preamble = %u\n",
+			 le32_to_cpu(htt_stats_buf->invalid_preamble));
+	len += scnprintf(buf + len, buf_len - len, "invalid_chan_bw_format = %u\n",
+			 le32_to_cpu(htt_stats_buf->invalid_chan_bw_format));
+	len += scnprintf(buf + len, buf_len - len, "mgmt_buff_alloc_fail_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->mgmt_buff_alloc_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "sec_ranging_req_in_open_mode = %u\n",
+			 le32_to_cpu(htt_stats_buf->sec_ranging_req_in_open_mode));
+	len += scnprintf(buf + len, buf_len - len, "max_time_bw_meas_exp_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->max_time_bw_meas_exp_cnt));
+	len += scnprintf(buf + len, buf_len - len, "num_tb_ranging_requests = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_tb_ranging_requests));
+	len += scnprintf(buf + len, buf_len - len, "tb_meas_duration_expiry_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tb_meas_duration_expiry_cnt));
+	len += scnprintf(buf + len, buf_len - len, "ntbr_triggered_successfully = %u\n",
+			 le32_to_cpu(htt_stats_buf->ntbr_triggered_successfully));
+	len += scnprintf(buf + len, buf_len - len, "ntbr_trigger_failed = %u\n",
+			 le32_to_cpu(htt_stats_buf->ntbr_trigger_failed));
+	len += scnprintf(buf + len, buf_len - len, "invalid_or_no_vreg_idx = %u\n",
+			 le32_to_cpu(htt_stats_buf->invalid_or_no_vreg_idx));
+	len += scnprintf(buf + len, buf_len - len, "set_vreg_params_failed = %u\n",
+			 le32_to_cpu(htt_stats_buf->set_vreg_params_failed));
+	len += scnprintf(buf + len, buf_len - len, "sac_mismatch = %u\n",
+			 le32_to_cpu(htt_stats_buf->sac_mismatch));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m1_auth_recv_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->pasn_m1_auth_recv_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m1_auth_tx_fail_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->pasn_m1_auth_tx_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m2_auth_recv_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->pasn_m2_auth_recv_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m2_auth_drop_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->pasn_m2_auth_drop_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m3_auth_recv_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->pasn_m3_auth_recv_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_m3_auth_tx_fail_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->pasn_m3_auth_tx_fail_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_peer_create_request_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->pasn_peer_create_request_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_peer_created_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->pasn_peer_created_cnt));
+	len += scnprintf(buf + len, buf_len - len, "pasn_peer_create_timeout_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->pasn_peer_create_timeout_cnt));
+	len += scnprintf(buf + len, buf_len - len, "ntbr_ndpa_failed = %u\n",
+			 le32_to_cpu(htt_stats_buf->ntbr_ndpa_failed));
+	len += scnprintf(buf + len, buf_len - len, "ntbr_sequence_successful = %u\n",
+			 le32_to_cpu(htt_stats_buf->ntbr_sequence_successful));
+	len += scnprintf(buf + len, buf_len - len, "ntbr_ndp_failed = %u\n",
+			 le32_to_cpu(htt_stats_buf->ntbr_ndp_failed));
+	len += scnprintf(buf + len, buf_len - len, "num_tb_ranging_NDPAs_recv = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_tb_ranging_ndpas_recv));
+	len += scnprintf(buf + len, buf_len - len, "ndp_rx_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->ndp_rx_cnt));
+	len += scnprintf(buf + len, buf_len - len, "num_trigger_frames_received = %u\n",
+			 le32_to_cpu(htt_stats_buf->num_trigger_frames_received));
+	for (i = 0; i < (ATH12K_HTT_SCH_CMD_STATUS_CNT - 1); i++)
+		len += scnprintf(buf + len, buf_len - len,
+				 "num_sch_cmd_status_%d = %u\n", i,
+				 le32_to_cpu(htt_stats_buf->sch_cmd_status_cnts[i]));
+	sch_fail = htt_stats_buf->sch_cmd_status_cnts[ATH12K_HTT_SCH_CMD_STATUS_CNT - 1];
+	len += scnprintf(buf + len, buf_len - len,
+			 "num_sch_cmd_status_other_failure = %u\n",
+			 le32_to_cpu(sch_fail));
+	len += scnprintf(buf + len, buf_len - len, "lmr_timeout = %u\n",
+			 le32_to_cpu(htt_stats_buf->lmr_timeout));
+	len += scnprintf(buf + len, buf_len - len, "lmr_recv = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->lmr_recv));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_pdev_rtt_hw_stats_tlv(const void *tag_buf, u16 tag_len,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_stats_pdev_rtt_hw_stats_tlv *htt_stats_buf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len, "HTT_STATS_PDEV_RTT_HW_STATS_TAG:\n");
+	len += scnprintf(buf + len, buf_len - len, "ista_ranging_ndpa_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->ista_ranging_ndpa_cnt));
+	len += scnprintf(buf + len, buf_len - len, "ista_ranging_ndp_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->ista_ranging_ndp_cnt));
+	len += scnprintf(buf + len, buf_len - len, "ista_ranging_i2r_lmr_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->ista_ranging_i2r_lmr_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rtsa_ranging_resp_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rtsa_ranging_resp_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rtsa_ranging_ndp_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rtsa_ranging_ndp_cnt));
+	len += scnprintf(buf + len, buf_len - len, "rsta_ranging_lmr_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->rsta_ranging_lmr_cnt));
+	len += scnprintf(buf + len, buf_len - len, "tb_ranging_cts2s_rcvd_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tb_ranging_cts2s_rcvd_cnt));
+	len += scnprintf(buf + len, buf_len - len, "tb_ranging_ndp_rcvd_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tb_ranging_ndp_rcvd_cnt));
+	len += scnprintf(buf + len, buf_len - len, "tb_ranging_lmr_rcvd_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tb_ranging_lmr_rcvd_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tb_ranging_tf_poll_resp_sent_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tb_ranging_tf_poll_resp_sent_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tb_ranging_tf_sound_resp_sent_cnt = %u\n",
+			 le32_to_cpu(htt_stats_buf->tb_ranging_tf_sound_resp_sent_cnt));
+	len += scnprintf(buf + len, buf_len - len,
+			 "tb_ranging_tf_report_resp_sent_cnt = %u\n\n",
+			 le32_to_cpu(htt_stats_buf->tb_ranging_tf_report_resp_sent_cnt));
+
+	stats_req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_pdev_rtt_tbr_selfgen_queued_stats_tlv(const void *tag_buf, u16 tag_len,
+						       struct debug_htt_stats_req *req)
+{
+	const struct ath12k_htt_stats_pdev_rtt_tbr_tlv *sbuf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = req->buf_len;
+	u8 *buf = req->buf;
+
+	if (tag_len < sizeof(*sbuf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_STATS_PDEV_RTT_TBR_SELFGEN_QUEUED_STATS_TAG:\n");
+	len += scnprintf(buf + len, buf_len - len, "SU poll = %u\n",
+			 le32_to_cpu(sbuf->su_ftype[ATH12K_HTT_FTYPE_TF_POLL]));
+	len += scnprintf(buf + len, buf_len - len, "SU sound = %u\n",
+			 le32_to_cpu(sbuf->su_ftype[ATH12K_HTT_FTYPE_TF_SOUND]));
+	len += scnprintf(buf + len, buf_len - len, "SU NDPA = %u\n",
+			 le32_to_cpu(sbuf->su_ftype[ATH12K_HTT_FTYPE_TBR_NDPA]));
+	len += scnprintf(buf + len, buf_len - len, "SU NDP = %u\n",
+			 le32_to_cpu(sbuf->su_ftype[ATH12K_HTT_FTYPE_TBR_NDP]));
+	len += scnprintf(buf + len, buf_len - len, "SU LMR = %u\n",
+			 le32_to_cpu(sbuf->su_ftype[ATH12K_HTT_FTYPE_TBR_LMR]));
+	len += scnprintf(buf + len, buf_len - len, "SU TF_REPORT = %u\n",
+			 le32_to_cpu(sbuf->su_ftype[ATH12K_HTT_FTYPE_TF_RPRT]));
+	len += scnprintf(buf + len, buf_len - len, "MU poll = %u\n",
+			 le32_to_cpu(sbuf->mu_ftype[ATH12K_HTT_FTYPE_TF_POLL]));
+	len += scnprintf(buf + len, buf_len - len, "MU sound = %u\n",
+			 le32_to_cpu(sbuf->mu_ftype[ATH12K_HTT_FTYPE_TF_SOUND]));
+	len += scnprintf(buf + len, buf_len - len, "MU NDPA = %u\n",
+			 le32_to_cpu(sbuf->mu_ftype[ATH12K_HTT_FTYPE_TBR_NDPA]));
+	len += scnprintf(buf + len, buf_len - len, "MU NDP = %u\n",
+			 le32_to_cpu(sbuf->mu_ftype[ATH12K_HTT_FTYPE_TBR_NDP]));
+	len += scnprintf(buf + len, buf_len - len, "MU LMR = %u\n",
+			 le32_to_cpu(sbuf->mu_ftype[ATH12K_HTT_FTYPE_TBR_LMR]));
+	len += scnprintf(buf + len, buf_len - len, "MU TF_REPORT = %u\n\n",
+			 le32_to_cpu(sbuf->mu_ftype[ATH12K_HTT_FTYPE_TF_RPRT]));
+
+	req->buf_len = len;
+}
+
+static void
+ath12k_htt_print_pdev_rtt_tbr_cmd_res_stats_tlv(const void *tag_buf, u16 tag_len,
+						struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_stats_pdev_rtt_tbr_cmd_result_stats_tlv *sbuf = tag_buf;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf, i;
+
+	if (tag_len < sizeof(*sbuf))
+		return;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_STATS_PDEV_RTT_TBR_CMD_RESULT_STATS_TAG:\n");
+	for (i = 0; i < le32_to_cpu(sbuf->tbr_num_sch_cmd_result_buckets); i++) {
+		len += scnprintf(buf + len, buf_len - len, "num_sch_cmd_status_%u:\n", i);
+		len += scnprintf(buf + len, buf_len - len,
+				 "SU frame_SGEN_TF_POLL = %u\n",
+				 le32_to_cpu(sbuf->su_res[ATH12K_HTT_FTYPE_TF_POLL][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "SU frame_SGEN_TF_SOUND = %u\n",
+				 le32_to_cpu(sbuf->su_res[ATH12K_HTT_FTYPE_TF_SOUND][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "SU frame_SGEN_TBR_NDPA = %u\n",
+				 le32_to_cpu(sbuf->su_res[ATH12K_HTT_FTYPE_TBR_NDPA][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "SU frame_SGEN_TBR_NDP = %u\n",
+				 le32_to_cpu(sbuf->su_res[ATH12K_HTT_FTYPE_TBR_NDP][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "SU frame_SGEN_TBR_LMR = %u\n",
+				 le32_to_cpu(sbuf->su_res[ATH12K_HTT_FTYPE_TBR_LMR][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "SU frame_SGEN_TF_REPORT = %u\n",
+				 le32_to_cpu(sbuf->su_res[ATH12K_HTT_FTYPE_TF_RPRT][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "MU frame_SGEN_TF_POLL = %u\n",
+				 le32_to_cpu(sbuf->mu_res[ATH12K_HTT_FTYPE_TF_POLL][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "MU frame_SGEN_TF_SOUND = %u\n",
+				 le32_to_cpu(sbuf->mu_res[ATH12K_HTT_FTYPE_TF_SOUND][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "MU frame_SGEN_TBR_NDPA = %u\n",
+				 le32_to_cpu(sbuf->mu_res[ATH12K_HTT_FTYPE_TBR_NDPA][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "MU frame_SGEN_TBR_NDP = %u\n",
+				 le32_to_cpu(sbuf->mu_res[ATH12K_HTT_FTYPE_TBR_NDP][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "MU frame_SGEN_TBR_LMR = %u\n",
+				 le32_to_cpu(sbuf->mu_res[ATH12K_HTT_FTYPE_TBR_LMR][i]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "MU frame_SGEN_TF_REPORT = %u\n\n",
+				 le32_to_cpu(sbuf->mu_res[ATH12K_HTT_FTYPE_TF_RPRT][i]));
+	}
+
+	stats_req->buf_len = len;
+}
+
 static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 					  u16 tag, u16 len, const void *tag_buf,
 					  void *user_data)
@@ -5379,6 +5783,22 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_MLO_IPC_STATS_TAG:
 		ath12k_htt_print_mlo_ipc_stats_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_PDEV_RTT_RESP_STATS_TAG:
+		ath12k_htt_print_pdev_rtt_resp_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PDEV_RTT_INIT_STATS_TAG:
+		ath12k_htt_print_pdev_rtt_init_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PDEV_RTT_HW_STATS_TAG:
+		ath12k_htt_print_pdev_rtt_hw_stats_tlv(tag_buf, len, stats_req);
+		break;
+	case HTT_STATS_PDEV_RTT_TBR_SELFGEN_QUEUED_STATS_TAG:
+		ath12k_htt_print_pdev_rtt_tbr_selfgen_queued_stats_tlv(tag_buf, len,
+								       stats_req);
+		break;
+	case HTT_STATS_PDEV_RTT_TBR_CMD_RESULT_STATS_TAG:
+		ath12k_htt_print_pdev_rtt_tbr_cmd_res_stats_tlv(tag_buf, len, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 42163ca09fee..e1a48399fac3 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -158,6 +158,8 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_PDEV_TDMA_STATS				= 57,
 	ATH12K_DBG_HTT_MLO_SCHED_STATS				= 63,
 	ATH12K_DBG_HTT_PDEV_MLO_IPC_STATS			= 64,
+	ATH12K_DBG_HTT_EXT_PDEV_RTT_RESP_STATS			= 65,
+	ATH12K_DBG_HTT_EXT_PDEV_RTT_INITIATOR_STATS		= 66,
 
 	/* keep this last */
 	ATH12K_DBG_HTT_NUM_EXT_STATS,
@@ -253,6 +255,11 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_PDEV_TDMA_TAG				= 187,
 	HTT_STATS_MLO_SCHED_STATS_TAG			= 190,
 	HTT_STATS_PDEV_MLO_IPC_STATS_TAG		= 191,
+	HTT_STATS_PDEV_RTT_RESP_STATS_TAG		= 194,
+	HTT_STATS_PDEV_RTT_INIT_STATS_TAG		= 195,
+	HTT_STATS_PDEV_RTT_HW_STATS_TAG			= 196,
+	HTT_STATS_PDEV_RTT_TBR_SELFGEN_QUEUED_STATS_TAG	= 197,
+	HTT_STATS_PDEV_RTT_TBR_CMD_RESULT_STATS_TAG	= 198,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -1902,4 +1909,152 @@ struct ath12k_htt_pdev_mlo_ipc_stats_tlv {
 	__le32 mlo_ipc_ring_cnt[ATH12K_HTT_HWMLO_MAX_LINKS][ATH12K_HTT_MLO_MAX_IPC_RINGS];
 } __packed;
 
+struct ath12k_htt_stats_pdev_rtt_resp_stats_tlv {
+	__le32 pdev_id;
+	__le32 tx_11mc_ftm_suc;
+	__le32 tx_11mc_ftm_suc_retry;
+	__le32 tx_11mc_ftm_fail;
+	__le32 rx_11mc_ftmr_cnt;
+	__le32 rx_11mc_ftmr_dup_cnt;
+	__le32 rx_11mc_iftmr_cnt;
+	__le32 rx_11mc_iftmr_dup_cnt;
+	__le32 ftmr_drop_11mc_resp_role_not_enabled_cnt;
+	__le32 initiator_active_responder_rejected_cnt;
+	__le32 responder_terminate_cnt;
+	__le32 active_rsta_open;
+	__le32 active_rsta_mac;
+	__le32 active_rsta_mac_phy;
+	__le32 num_assoc_ranging_peers;
+	__le32 num_unassoc_ranging_peers;
+	__le32 responder_alloc_cnt;
+	__le32 responder_alloc_failure;
+	__le32 pn_check_failure_cnt;
+	__le32 pasn_m1_auth_recv_cnt;
+	__le32 pasn_m1_auth_drop_cnt;
+	__le32 pasn_m2_auth_recv_cnt;
+	__le32 pasn_m2_auth_tx_fail_cnt;
+	__le32 pasn_m3_auth_recv_cnt;
+	__le32 pasn_m3_auth_drop_cnt;
+	__le32 pasn_peer_create_request_cnt;
+	__le32 pasn_peer_create_timeout_cnt;
+	__le32 pasn_peer_created_cnt;
+	__le32 sec_ranging_not_supported_mfp_not_setup;
+	__le32 non_sec_ranging_discarded_for_assoc_peer;
+	__le32 open_ranging_discarded_set_for_pasn_peer;
+	__le32 unassoc_non_pasn_ranging_not_supported;
+	__le32 num_req_bw_20_mhz;
+	__le32 num_req_bw_40_mhz;
+	__le32 num_req_bw_80_mhz;
+	__le32 num_req_bw_160_mhz;
+	__le32 tx_11az_ftm_successful;
+	__le32 tx_11az_ftm_failed;
+	__le32 rx_11az_ftmr_cnt;
+	__le32 rx_11az_ftmr_dup_cnt;
+	__le32 rx_11az_iftmr_dup_cnt;
+	__le32 malformed_ftmr;
+	__le32 ftmr_drop_ntb_resp_role_not_enabled_cnt;
+	__le32 ftmr_drop_tb_resp_role_not_enabled_cnt;
+	__le32 invalid_ftm_request_params;
+	__le32 requested_bw_format_not_supported;
+	__le32 ntb_unsec_unassoc_ranging_peer_alloc_failed;
+	__le32 tb_unassoc_unsec_pasn_peer_creation_failed;
+	__le32 num_ranging_sequences_processed;
+	__le32 ntb_tx_ndp;
+	__le32 ndp_rx_cnt;
+	__le32 num_ntb_ranging_ndpas_recv;
+	__le32 recv_lmr;
+	__le32 invalid_ftmr_cnt;
+	__le32 max_time_bw_meas_exp_cnt;
+} __packed;
+
+#define ATH12K_HTT_MAX_SCH_CMD_RESULT	25
+#define ATH12K_HTT_SCH_CMD_STATUS_CNT	9
+
+struct ath12k_htt_stats_pdev_rtt_init_stats_tlv {
+	__le32 pdev_id;
+	__le32 tx_11mc_ftmr_cnt;
+	__le32 tx_11mc_ftmr_fail;
+	__le32 tx_11mc_ftmr_suc_retry;
+	__le32 rx_11mc_ftm_cnt;
+	__le32 tx_meas_req_count;
+	__le32 init_role_not_enabled;
+	__le32 initiator_terminate_cnt;
+	__le32 tx_11az_ftmr_fail;
+	__le32 tx_11az_ftmr_start;
+	__le32 tx_11az_ftmr_stop;
+	__le32 rx_11az_ftm_cnt;
+	__le32 active_ista;
+	__le32 invalid_preamble;
+	__le32 invalid_chan_bw_format;
+	__le32 mgmt_buff_alloc_fail_cnt;
+	__le32 ftm_parse_failure;
+	__le32 ranging_negotiation_successful_cnt;
+	__le32 incompatible_ftm_params;
+	__le32 sec_ranging_req_in_open_mode;
+	__le32 ftmr_tx_failed_null_11az_peer;
+	__le32 ftmr_retry_timeout;
+	__le32 max_time_bw_meas_exp_cnt;
+	__le32 tb_meas_duration_expiry_cnt;
+	__le32 num_tb_ranging_requests;
+	__le32 ntbr_triggered_successfully;
+	__le32 ntbr_trigger_failed;
+	__le32 invalid_or_no_vreg_idx;
+	__le32 set_vreg_params_failed;
+	__le32 sac_mismatch;
+	__le32 pasn_m1_auth_recv_cnt;
+	__le32 pasn_m1_auth_tx_fail_cnt;
+	__le32 pasn_m2_auth_recv_cnt;
+	__le32 pasn_m2_auth_drop_cnt;
+	__le32 pasn_m3_auth_recv_cnt;
+	__le32 pasn_m3_auth_tx_fail_cnt;
+	__le32 pasn_peer_create_request_cnt;
+	__le32 pasn_peer_create_timeout_cnt;
+	__le32 pasn_peer_created_cnt;
+	__le32 ntbr_ndpa_failed;
+	__le32 ntbr_sequence_successful;
+	__le32 ntbr_ndp_failed;
+	__le32 sch_cmd_status_cnts[ATH12K_HTT_SCH_CMD_STATUS_CNT];
+	__le32 lmr_timeout;
+	__le32 lmr_recv;
+	__le32 num_trigger_frames_received;
+	__le32 num_tb_ranging_ndpas_recv;
+	__le32 ndp_rx_cnt;
+} __packed;
+
+struct ath12k_htt_stats_pdev_rtt_hw_stats_tlv {
+	__le32 ista_ranging_ndpa_cnt;
+	__le32 ista_ranging_ndp_cnt;
+	__le32 ista_ranging_i2r_lmr_cnt;
+	__le32 rtsa_ranging_resp_cnt;
+	__le32 rtsa_ranging_ndp_cnt;
+	__le32 rsta_ranging_lmr_cnt;
+	__le32 tb_ranging_cts2s_rcvd_cnt;
+	__le32 tb_ranging_ndp_rcvd_cnt;
+	__le32 tb_ranging_lmr_rcvd_cnt;
+	__le32 tb_ranging_tf_poll_resp_sent_cnt;
+	__le32 tb_ranging_tf_sound_resp_sent_cnt;
+	__le32 tb_ranging_tf_report_resp_sent_cnt;
+} __packed;
+
+enum ath12k_htt_stats_txsend_ftype_t {
+	ATH12K_HTT_FTYPE_TF_POLL,
+	ATH12K_HTT_FTYPE_TF_SOUND,
+	ATH12K_HTT_FTYPE_TBR_NDPA,
+	ATH12K_HTT_FTYPE_TBR_NDP,
+	ATH12K_HTT_FTYPE_TBR_LMR,
+	ATH12K_HTT_FTYPE_TF_RPRT,
+	ATH12K_HTT_FTYPE_MAX
+};
+
+struct ath12k_htt_stats_pdev_rtt_tbr_tlv {
+	__le32 su_ftype[ATH12K_HTT_FTYPE_MAX];
+	__le32 mu_ftype[ATH12K_HTT_FTYPE_MAX];
+} __packed;
+
+struct ath12k_htt_stats_pdev_rtt_tbr_cmd_result_stats_tlv {
+	__le32 tbr_num_sch_cmd_result_buckets;
+	__le32 su_res[ATH12K_HTT_FTYPE_MAX][ATH12K_HTT_MAX_SCH_CMD_RESULT];
+	__le32 mu_res[ATH12K_HTT_FTYPE_MAX][ATH12K_HTT_MAX_SCH_CMD_RESULT];
+} __packed;
+
 #endif
-- 
2.25.1


