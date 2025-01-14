Return-Path: <linux-wireless+bounces-17487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A17CA106DA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 13:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8CA18827CD
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18493232;
	Tue, 14 Jan 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iM/QOUre"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225435959
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858354; cv=none; b=kRLaE0fstKNmB+E1rr356vtN/ljNHMFuRu5v+I/1nMDcIJJxrrk3LVaNXmE6KLxBL588xTj1QFpjqebyzs5qAOCiOSuhHYQqHvpkun4VY8uIJkDstsx2Fmr+miYdTYStrVyTu35DlSahb2fcA3tn7/viuIfVuU0AF99l9rtZw7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858354; c=relaxed/simple;
	bh=LvnhSZAfxYWvBdh257LFdqTV6CkkMabvtmGEeqKuLZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKocw06RH0FA1diQy4GsZb+aKzqA2zdr+tOTxl2tTcVfLIQrCPvsDpCUk0ScvTfFt0tCBV9z+pQpnnFxjCTKkDVpnKwLl4yNc1zTkOrZpXOEoXlzHLW23jyum83BtTJG7MGxQRpMzXdMcuQ0zxrvEmYnXMUySdA7j5XkndFFl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iM/QOUre; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E6cfJE003433;
	Tue, 14 Jan 2025 12:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tuhe8cpuqTs5d4/grmcFKiwVKC7X7t4mwHNzHlqi3FE=; b=iM/QOUrelZ/pdyf6
	HQAhQWxDVEWkWgGUwGyAsq2k+n4mXXnIDxUiPgq/elT3c6glMe/ZJjNDgcQlIk4+
	b9PtKP2LzEGb4d5BlLKv35yyudzJTqOqlyxXPKRbLANeL6Q6wCcC7M2HeeIuxmZB
	SaavuBUXOTkwV1NU9tLClwe03OjA4abV9F9PM54oh/7IItY0JPICfXeSBjPVgdip
	cfdJhpzuDCuCE9VwY60sf4zx2R6MKXU8mAx8eANHsoywIh9n4xBC6tYUNZU4o4JK
	hd1I+NT3bGhVM+mdeSoF3LP5gunSg8m2qZDHH6Hdgbsfpa77ent9rp91jpMuZjLN
	y/NMvA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445jubgr2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 12:39:08 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50ECd69X029472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 12:39:07 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 04:39:05 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Dinesh Karthikeyan
	<quic_dinek@quicinc.com>,
        Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: [PATCH v4 1/5] wifi: ath12k: Support Sounding Stats
Date: Tue, 14 Jan 2025 18:08:31 +0530
Message-ID: <20250114123835.882926-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114123835.882926-1-quic_rdevanat@quicinc.com>
References: <20250114123835.882926-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 9HInjTaGR9T6y2CqZ6r2sVlm4_frS_si
X-Proofpoint-GUID: 9HInjTaGR9T6y2CqZ6r2sVlm4_frS_si
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140105

From: Dinesh Karthikeyan <quic_dinek@quicinc.com>

Add support to request sounding stats from firmware through HTT stats
type 22. These stats give sounding information of different Wi-Fi
standards, channel vector upload status and correlation details.

Sample output:
-------------
echo 22 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
HTT_TX_AC_SOUNDING_STATS_TLV:
ac_cbf_20 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
ac_cbf_40 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
.....
Sounding User_0 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0
Sounding User_1 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0
.....

HTT_TX_AX_SOUNDING_STATS_TLV:
ax_cbf_20 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
ax_cbf_40 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
.....
Sounding User_0 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0
Sounding User_1 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0
.....

HTT_TX_BE_SOUNDING_STATS_TLV:
be_cbf_20 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
be_cbf_40 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
.....
Sounding User_0 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0, 320MHz: 0
Sounding User_1 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0, 320MHz: 0
.....

CV UPLOAD HANDLER STATS:
cv_nc_mismatch_err = 0
cv_fcs_err = 0
cv_frag_idx_mismatch = 0
cv_invalid_peer_id = 0
.....

CV QUERY STATS:
cv_total_query = 0
cv_total_pattern_query = 0
cv_total_bw_query = 0
cv_invalid_bw_coding = 0
.....

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 265 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  78 ++++++
 2 files changed, 343 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
index 41e4ef2ef3af..7381e5a615d0 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
@@ -2511,6 +2511,268 @@ ath12k_htt_print_pdev_stats_cca_counters_tlv(const void *tag_buf, u16 tag_len,
 	stats_req->buf_len = len;
 }
 
+static void
+ath12k_htt_print_tx_sounding_stats_tlv(const void *tag_buf, u16 tag_len,
+				       struct debug_htt_stats_req *stats_req)
+{
+	const struct ath12k_htt_tx_sounding_stats_tlv *htt_stats_buf = tag_buf;
+	const __le32 *cbf_20, *cbf_40, *cbf_80, *cbf_160, *cbf_320;
+	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
+	u32 len = stats_req->buf_len;
+	u8 *buf = stats_req->buf;
+	u32 tx_sounding_mode;
+	u8 i, u;
+
+	if (tag_len < sizeof(*htt_stats_buf))
+		return;
+
+	cbf_20 = htt_stats_buf->cbf_20;
+	cbf_40 = htt_stats_buf->cbf_40;
+	cbf_80 = htt_stats_buf->cbf_80;
+	cbf_160 = htt_stats_buf->cbf_160;
+	cbf_320 = htt_stats_buf->cbf_320;
+	tx_sounding_mode = le32_to_cpu(htt_stats_buf->tx_sounding_mode);
+
+	if (tx_sounding_mode == ATH12K_HTT_TX_AC_SOUNDING_MODE) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "HTT_TX_AC_SOUNDING_STATS_TLV:\n");
+		len += scnprintf(buf + len, buf_len - len,
+				 "ac_cbf_20 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_20[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "ac_cbf_40 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_40[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "ac_cbf_80 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_80[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "ac_cbf_160 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_160[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+
+		for (u = 0, i = 0; u < ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS; u++) {
+			len += scnprintf(buf + len, buf_len - len,
+					 "Sounding User_%u = 20MHz: %u, ", u,
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+			len += scnprintf(buf + len, buf_len - len, "40MHz: %u, ",
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+			len += scnprintf(buf + len, buf_len - len, "80MHz: %u, ",
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+			len += scnprintf(buf + len, buf_len - len, "160MHz: %u\n",
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+		}
+	} else if (tx_sounding_mode == ATH12K_HTT_TX_AX_SOUNDING_MODE) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nHTT_TX_AX_SOUNDING_STATS_TLV:\n");
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_cbf_20 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_20[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_cbf_40 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_40[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_cbf_80 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_80[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_cbf_160 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_160[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+
+		for (u = 0, i = 0; u < ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS; u++) {
+			len += scnprintf(buf + len, buf_len - len,
+					 "Sounding User_%u = 20MHz: %u, ", u,
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+			len += scnprintf(buf + len, buf_len - len, "40MHz: %u, ",
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+			len += scnprintf(buf + len, buf_len - len, "80MHz: %u, ",
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+			len += scnprintf(buf + len, buf_len - len, "160MHz: %u\n",
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+		}
+	} else if (tx_sounding_mode == ATH12K_HTT_TX_BE_SOUNDING_MODE) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nHTT_TX_BE_SOUNDING_STATS_TLV:\n");
+		len += scnprintf(buf + len, buf_len - len,
+				 "be_cbf_20 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_20[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_20[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "be_cbf_40 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_40[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_40[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "be_cbf_80 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_80[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_80[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "be_cbf_160 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_160[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_160[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len,
+				 "be_cbf_320 = IBF: %u, SU_SIFS: %u, SU_RBO: %u, ",
+				 le32_to_cpu(cbf_320[ATH12K_HTT_IMPL_STEER_STATS]),
+				 le32_to_cpu(cbf_320[ATH12K_HTT_EXPL_SUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_320[ATH12K_HTT_EXPL_SURBO_STEER_STATS]));
+		len += scnprintf(buf + len, buf_len - len, "MU_SIFS: %u, MU_RBO: %u\n",
+				 le32_to_cpu(cbf_320[ATH12K_HTT_EXPL_MUSIFS_STEER_STATS]),
+				 le32_to_cpu(cbf_320[ATH12K_HTT_EXPL_MURBO_STEER_STATS]));
+		for (u = 0, i = 0; u < ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS; u++) {
+			len += scnprintf(buf + len, buf_len - len,
+					 "Sounding User_%u = 20MHz: %u, ", u,
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+			len += scnprintf(buf + len, buf_len - len, "40MHz: %u, ",
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+			len += scnprintf(buf + len, buf_len - len, "80MHz: %u, ",
+					 le32_to_cpu(htt_stats_buf->sounding[i++]));
+			len += scnprintf(buf + len, buf_len - len,
+					 "160MHz: %u, 320MHz: %u\n",
+					 le32_to_cpu(htt_stats_buf->sounding[i++]),
+					 le32_to_cpu(htt_stats_buf->sounding_320[u]));
+		}
+	} else if (tx_sounding_mode == ATH12K_HTT_TX_CMN_SOUNDING_MODE) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nCV UPLOAD HANDLER STATS:\n");
+		len += scnprintf(buf + len, buf_len - len, "cv_nc_mismatch_err = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_nc_mismatch_err));
+		len += scnprintf(buf + len, buf_len - len, "cv_fcs_err = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_fcs_err));
+		len += scnprintf(buf + len, buf_len - len, "cv_frag_idx_mismatch = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_frag_idx_mismatch));
+		len += scnprintf(buf + len, buf_len - len, "cv_invalid_peer_id = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_invalid_peer_id));
+		len += scnprintf(buf + len, buf_len - len, "cv_no_txbf_setup = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_no_txbf_setup));
+		len += scnprintf(buf + len, buf_len - len, "cv_expiry_in_update = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_expiry_in_update));
+		len += scnprintf(buf + len, buf_len - len, "cv_pkt_bw_exceed = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_pkt_bw_exceed));
+		len += scnprintf(buf + len, buf_len - len, "cv_dma_not_done_err = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_dma_not_done_err));
+		len += scnprintf(buf + len, buf_len - len, "cv_update_failed = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_update_failed));
+		len += scnprintf(buf + len, buf_len - len, "cv_dma_timeout_error = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_dma_timeout_error));
+		len += scnprintf(buf + len, buf_len - len, "cv_buf_ibf_uploads = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_buf_ibf_uploads));
+		len += scnprintf(buf + len, buf_len - len, "cv_buf_ebf_uploads = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_buf_ebf_uploads));
+		len += scnprintf(buf + len, buf_len - len, "cv_buf_received = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_buf_received));
+		len += scnprintf(buf + len, buf_len - len, "cv_buf_fed_back = %u\n\n",
+				 le32_to_cpu(htt_stats_buf->cv_buf_fed_back));
+
+		len += scnprintf(buf + len, buf_len - len, "CV QUERY STATS:\n");
+		len += scnprintf(buf + len, buf_len - len, "cv_total_query = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_total_query));
+		len += scnprintf(buf + len, buf_len - len,
+				 "cv_total_pattern_query = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_total_pattern_query));
+		len += scnprintf(buf + len, buf_len - len, "cv_total_bw_query = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_total_bw_query));
+		len += scnprintf(buf + len, buf_len - len, "cv_invalid_bw_coding = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_invalid_bw_coding));
+		len += scnprintf(buf + len, buf_len - len, "cv_forced_sounding = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_forced_sounding));
+		len += scnprintf(buf + len, buf_len - len,
+				 "cv_standalone_sounding = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_standalone_sounding));
+		len += scnprintf(buf + len, buf_len - len, "cv_nc_mismatch = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_nc_mismatch));
+		len += scnprintf(buf + len, buf_len - len, "cv_fb_type_mismatch = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_fb_type_mismatch));
+		len += scnprintf(buf + len, buf_len - len, "cv_ofdma_bw_mismatch = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_ofdma_bw_mismatch));
+		len += scnprintf(buf + len, buf_len - len, "cv_bw_mismatch = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_bw_mismatch));
+		len += scnprintf(buf + len, buf_len - len, "cv_pattern_mismatch = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_pattern_mismatch));
+		len += scnprintf(buf + len, buf_len - len, "cv_preamble_mismatch = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_preamble_mismatch));
+		len += scnprintf(buf + len, buf_len - len, "cv_nr_mismatch = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_nr_mismatch));
+		len += scnprintf(buf + len, buf_len - len,
+				 "cv_in_use_cnt_exceeded = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_in_use_cnt_exceeded));
+		len += scnprintf(buf + len, buf_len - len, "cv_ntbr_sounding = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_ntbr_sounding));
+		len += scnprintf(buf + len, buf_len - len,
+				 "cv_found_upload_in_progress = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_found_upload_in_progress));
+		len += scnprintf(buf + len, buf_len - len,
+				 "cv_expired_during_query = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_expired_during_query));
+		len += scnprintf(buf + len, buf_len - len, "cv_found = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_found));
+		len += scnprintf(buf + len, buf_len - len, "cv_not_found = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_not_found));
+		len += scnprintf(buf + len, buf_len - len, "cv_total_query_ibf = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_total_query_ibf));
+		len += scnprintf(buf + len, buf_len - len, "cv_found_ibf = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_found_ibf));
+		len += scnprintf(buf + len, buf_len - len, "cv_not_found_ibf = %u\n",
+				 le32_to_cpu(htt_stats_buf->cv_not_found_ibf));
+		len += scnprintf(buf + len, buf_len - len,
+				 "cv_expired_during_query_ibf = %u\n\n",
+				 le32_to_cpu(htt_stats_buf->cv_expired_during_query_ibf));
+	}
+
+	stats_req->buf_len = len;
+}
+
 static void
 ath12k_htt_print_pdev_obss_pd_stats_tlv(const void *tag_buf, u16 tag_len,
 					struct debug_htt_stats_req *stats_req)
@@ -3982,6 +4244,9 @@ static int ath12k_dbg_htt_ext_stats_parse(struct ath12k_base *ab,
 	case HTT_STATS_PDEV_CCA_COUNTERS_TAG:
 		ath12k_htt_print_pdev_stats_cca_counters_tlv(tag_buf, len, stats_req);
 		break;
+	case HTT_STATS_TX_SOUNDING_STATS_TAG:
+		ath12k_htt_print_tx_sounding_stats_tlv(tag_buf, len, stats_req);
+		break;
 	case HTT_STATS_PDEV_OBSS_PD_TAG:
 		ath12k_htt_print_pdev_obss_pd_stats_tlv(tag_buf, len, stats_req);
 		break;
diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
index 4b59976fbc35..238a45e0d296 100644
--- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
@@ -134,6 +134,7 @@ enum ath12k_dbg_htt_ext_stats_type {
 	ATH12K_DBG_HTT_EXT_STATS_SFM_INFO		= 16,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_MU		= 17,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_CCA_STATS		= 19,
+	ATH12K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO	= 22,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	= 23,
 	ATH12K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF	= 31,
 	ATH12K_DBG_HTT_EXT_STATS_TXBF_OFDMA		= 32,
@@ -195,6 +196,7 @@ enum ath12k_dbg_htt_tlv_tag {
 	HTT_STATS_PDEV_CCA_STAT_CUMULATIVE_TAG		= 72,
 	HTT_STATS_PDEV_CCA_COUNTERS_TAG			= 73,
 	HTT_STATS_TX_PDEV_MPDU_STATS_TAG		= 74,
+	HTT_STATS_TX_SOUNDING_STATS_TAG			= 80,
 	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG		= 86,
 	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG	= 87,
 	HTT_STATS_PDEV_OBSS_PD_TAG			= 88,
@@ -1058,6 +1060,82 @@ struct ath12k_htt_pdev_cca_stats_hist_v1_tlv {
 	__le32 collection_interval;
 } __packed;
 
+#define ATH12K_HTT_TX_CV_CORR_MAX_NUM_COLUMNS		8
+#define ATH12K_HTT_TX_NUM_AC_MUMIMO_USER_STATS		4
+#define ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS          8
+#define ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS		8
+#define ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS	4
+#define ATH12K_HTT_TX_NUM_MCS_CNTRS			12
+#define ATH12K_HTT_TX_NUM_EXTRA_MCS_CNTRS		2
+
+#define ATH12K_HTT_TX_NUM_OF_SOUNDING_STATS_WORDS \
+	(ATH12K_HTT_TX_PDEV_STATS_NUM_BW_COUNTERS * \
+	 ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS)
+
+enum ath12k_htt_txbf_sound_steer_modes {
+	ATH12K_HTT_IMPL_STEER_STATS		= 0,
+	ATH12K_HTT_EXPL_SUSIFS_STEER_STATS	= 1,
+	ATH12K_HTT_EXPL_SURBO_STEER_STATS	= 2,
+	ATH12K_HTT_EXPL_MUSIFS_STEER_STATS	= 3,
+	ATH12K_HTT_EXPL_MURBO_STEER_STATS	= 4,
+	ATH12K_HTT_TXBF_MAX_NUM_OF_MODES	= 5
+};
+
+enum ath12k_htt_stats_sounding_tx_mode {
+	ATH12K_HTT_TX_AC_SOUNDING_MODE		= 0,
+	ATH12K_HTT_TX_AX_SOUNDING_MODE		= 1,
+	ATH12K_HTT_TX_BE_SOUNDING_MODE		= 2,
+	ATH12K_HTT_TX_CMN_SOUNDING_MODE		= 3,
+};
+
+struct ath12k_htt_tx_sounding_stats_tlv {
+	__le32 tx_sounding_mode;
+	__le32 cbf_20[ATH12K_HTT_TXBF_MAX_NUM_OF_MODES];
+	__le32 cbf_40[ATH12K_HTT_TXBF_MAX_NUM_OF_MODES];
+	__le32 cbf_80[ATH12K_HTT_TXBF_MAX_NUM_OF_MODES];
+	__le32 cbf_160[ATH12K_HTT_TXBF_MAX_NUM_OF_MODES];
+	__le32 sounding[ATH12K_HTT_TX_NUM_OF_SOUNDING_STATS_WORDS];
+	__le32 cv_nc_mismatch_err;
+	__le32 cv_fcs_err;
+	__le32 cv_frag_idx_mismatch;
+	__le32 cv_invalid_peer_id;
+	__le32 cv_no_txbf_setup;
+	__le32 cv_expiry_in_update;
+	__le32 cv_pkt_bw_exceed;
+	__le32 cv_dma_not_done_err;
+	__le32 cv_update_failed;
+	__le32 cv_total_query;
+	__le32 cv_total_pattern_query;
+	__le32 cv_total_bw_query;
+	__le32 cv_invalid_bw_coding;
+	__le32 cv_forced_sounding;
+	__le32 cv_standalone_sounding;
+	__le32 cv_nc_mismatch;
+	__le32 cv_fb_type_mismatch;
+	__le32 cv_ofdma_bw_mismatch;
+	__le32 cv_bw_mismatch;
+	__le32 cv_pattern_mismatch;
+	__le32 cv_preamble_mismatch;
+	__le32 cv_nr_mismatch;
+	__le32 cv_in_use_cnt_exceeded;
+	__le32 cv_found;
+	__le32 cv_not_found;
+	__le32 sounding_320[ATH12K_HTT_TX_NUM_BE_MUMIMO_USER_STATS];
+	__le32 cbf_320[ATH12K_HTT_TXBF_MAX_NUM_OF_MODES];
+	__le32 cv_ntbr_sounding;
+	__le32 cv_found_upload_in_progress;
+	__le32 cv_expired_during_query;
+	__le32 cv_dma_timeout_error;
+	__le32 cv_buf_ibf_uploads;
+	__le32 cv_buf_ebf_uploads;
+	__le32 cv_buf_received;
+	__le32 cv_buf_fed_back;
+	__le32 cv_total_query_ibf;
+	__le32 cv_found_ibf;
+	__le32 cv_not_found_ibf;
+	__le32 cv_expired_during_query_ibf;
+} __packed;
+
 struct ath12k_htt_pdev_obss_pd_stats_tlv {
 	__le32 num_obss_tx_ppdu_success;
 	__le32 num_obss_tx_ppdu_failure;
-- 
2.25.1


