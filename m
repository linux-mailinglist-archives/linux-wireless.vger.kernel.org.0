Return-Path: <linux-wireless+bounces-26830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3399B3A851
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B782049C0
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59976341AC4;
	Thu, 28 Aug 2025 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VqntAi7L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA60338F22
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402606; cv=none; b=hylv7gc5VxuxBswWLznJZg92Qwx3NYDtIeUyRQYb+4f9P3H+39pBM76iH4V/UXbArVcbpcB4+qtLv09OZNWygzNe5AeyMJsDRxje05frB/sd2l2Fv/hT+U7JT8xpq0d/LQCXxSGDIEwAQ1HLOhNCrwfU0li9xeFy5k+qqLVFTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402606; c=relaxed/simple;
	bh=e7ot/6k3kyJhXEZchsxpQLzPkorkoivPPPwzjKidv0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pudz+txQqb7t7pQ0cOB+6DdHN/KVYVxfeHscCzztXOX3MHghB+8aMZK1mmq7std1SQSaA60vKwvXw/jp8YfaMmea1qk5mj+8yu7LjjsmycsWksUQvmjq6XRaq7oVjsZqW6H6guKJch64BvPUTD9Mfp0s4ghYpsBQPwiPEqTPgkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VqntAi7L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SBL4DP028921;
	Thu, 28 Aug 2025 17:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tkkqsTHXvSqK1KMgNDnSTOISU1tfG62VR7tx6QnegCc=; b=VqntAi7LbAXCAdub
	7vXtARGJcynXf6vqrFqxM4nPJET4bs2VogP3yqpT4j2CIjFRWlgjLHlNBzWH9/7E
	SUnqitk6jnXPBhRHUELZkop/1SdMTHWzZWJW0ncDn+cAOSmqesuSM3prcwd+9h5w
	azZA5LGwFssYRBkdl1Mss6UXolJsXyT2Iolgz0leGN9XoBaz2tbWsTFdSxVPG32h
	EFnLm8M/hf4F1tpuBaKzWCAkTTotVWXKIbf/wzaKp8dAJye46R7d7kb5H/IlMtpQ
	n3+BnMS5cTLhOS6gSlFr5O/FeC8zAVLlN/1OL1q/q2f9TxfT8DtIdoeNBmve8FYj
	C4Twbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tp5k13ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHab5o019780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:37 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:36 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 18/20] wifi: ath12k: Move HTT Rx specific code to newly introduced files
Date: Thu, 28 Aug 2025 23:05:51 +0530
Message-ID: <20250828173553.3341351-19-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=V9F90fni c=1 sm=1 tr=0 ts=68b093a6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=CSDw-C9IAAAA:8
 a=kwDPPlEwAAAA:8 a=Iwk81yimAAAA:8 a=vjkW6uPWAAAA:8 a=D_sfj51gmBRu9ZHEztoA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=wzwtrm5WU4lM03trS8pa:22 a=ewAuKO2E3cdpfbwcMUDL:22
 a=PqBb7rsBcpu_OT3Qf5tX:22 a=FTqP262Ndm71lHIshRHN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5NSBTYWx0ZWRfX9TDROPqaoaGv
 GdSw2rPhaDHjAPBo5FSfBmA8BmswzYHIRvkWC4V85fSDsh3ZshyPCIc5/t1ZJpcglcramr/6+mU
 yLx42LV6vib6sp4jYDnSEm801MiHqYdt5RCNY6LSUMuXUC8JdP4e/CgId2q1gF2m51mdZrACEp7
 E2msdbmjzNTmb7qreDAEyd57bvqEpWQTwXkA2vDIZJTXi3g9R/cYVMZHC/D8EmSTA/kyRtT72wF
 mo2nMvX9q6Chok3Burz3i4nbSEKaZx1EeICorbP9MKNd9QZpHFeug/NdOQqKXa7BQ1cltpkp2JE
 G2gONsRA1z978RoWOpzenWrmHusAqZvHrv49tNLV0Su4YieuiwRoyG+MkME8Bk5+6f7J4khS1US
 r+MLPVSq
X-Proofpoint-ORIG-GUID: 3UR-9Gq3jSm9pq6hlPwLXw9vs8AzuZ1V
X-Proofpoint-GUID: 3UR-9Gq3jSm9pq6hlPwLXw9vs8AzuZ1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280095

From: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>

WLAN Host driver interacts with the Firmware and vice versa using
Host-To-Target (HTT) interface.

HTT interface code is spread across multiple files (ex dp_tx.c, dp_rx.c
etc) and this interface is independent of the underlying architecture Tx
and Rx. Relocate HTT specific code from dp_rx.c to newly introduced file
dp_htt.c for HTT interface. This new file is compiled as part of the
common module ath12k.ko.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile |   1 +
 drivers/net/wireless/ath/ath12k/dp_htt.c | 644 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/dp_htt.h |   6 +
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 633 ----------------------
 drivers/net/wireless/ath/ath12k/dp_rx.h  |   6 -
 5 files changed, 651 insertions(+), 639 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.c

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index e72b52d5af6d..70d4daa48c90 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -10,6 +10,7 @@ ath12k-y += core.o \
 	    dp.o  \
 	    dp_tx.o \
 	    dp_rx.o \
+	    dp_htt.o \
 	    debug.o \
 	    ce.o \
 	    peer.o \
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.c b/drivers/net/wireless/ath/ath12k/dp_htt.c
new file mode 100644
index 000000000000..00847d579b95
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.c
@@ -0,0 +1,644 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "core.h"
+#include "peer.h"
+#include "htc.h"
+#include "dp_htt.h"
+#include "debugfs_htt_stats.h"
+
+static int ath12k_get_ppdu_user_index(struct htt_ppdu_stats *ppdu_stats,
+				      u16 peer_id)
+{
+	int i;
+
+	for (i = 0; i < HTT_PPDU_STATS_MAX_USERS - 1; i++) {
+		if (ppdu_stats->user_stats[i].is_valid_peer_id) {
+			if (peer_id == ppdu_stats->user_stats[i].peer_id)
+				return i;
+		} else {
+			return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ath12k_htt_tlv_ppdu_stats_parse(struct ath12k_base *ab,
+					   u16 tag, u16 len, const void *ptr,
+					   void *data)
+{
+	const struct htt_ppdu_stats_usr_cmpltn_ack_ba_status *ba_status;
+	const struct htt_ppdu_stats_usr_cmpltn_cmn *cmplt_cmn;
+	const struct htt_ppdu_stats_user_rate *user_rate;
+	struct htt_ppdu_stats_info *ppdu_info;
+	struct htt_ppdu_user_stats *user_stats;
+	int cur_user;
+	u16 peer_id;
+
+	ppdu_info = data;
+
+	switch (tag) {
+	case HTT_PPDU_STATS_TAG_COMMON:
+		if (len < sizeof(struct htt_ppdu_stats_common)) {
+			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
+				    len, tag);
+			return -EINVAL;
+		}
+		memcpy(&ppdu_info->ppdu_stats.common, ptr,
+		       sizeof(struct htt_ppdu_stats_common));
+		break;
+	case HTT_PPDU_STATS_TAG_USR_RATE:
+		if (len < sizeof(struct htt_ppdu_stats_user_rate)) {
+			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
+				    len, tag);
+			return -EINVAL;
+		}
+		user_rate = ptr;
+		peer_id = le16_to_cpu(user_rate->sw_peer_id);
+		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
+						      peer_id);
+		if (cur_user < 0)
+			return -EINVAL;
+		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
+		user_stats->peer_id = peer_id;
+		user_stats->is_valid_peer_id = true;
+		memcpy(&user_stats->rate, ptr,
+		       sizeof(struct htt_ppdu_stats_user_rate));
+		user_stats->tlv_flags |= BIT(tag);
+		break;
+	case HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON:
+		if (len < sizeof(struct htt_ppdu_stats_usr_cmpltn_cmn)) {
+			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
+				    len, tag);
+			return -EINVAL;
+		}
+
+		cmplt_cmn = ptr;
+		peer_id = le16_to_cpu(cmplt_cmn->sw_peer_id);
+		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
+						      peer_id);
+		if (cur_user < 0)
+			return -EINVAL;
+		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
+		user_stats->peer_id = peer_id;
+		user_stats->is_valid_peer_id = true;
+		memcpy(&user_stats->cmpltn_cmn, ptr,
+		       sizeof(struct htt_ppdu_stats_usr_cmpltn_cmn));
+		user_stats->tlv_flags |= BIT(tag);
+		break;
+	case HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS:
+		if (len <
+		    sizeof(struct htt_ppdu_stats_usr_cmpltn_ack_ba_status)) {
+			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
+				    len, tag);
+			return -EINVAL;
+		}
+
+		ba_status = ptr;
+		peer_id = le16_to_cpu(ba_status->sw_peer_id);
+		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
+						      peer_id);
+		if (cur_user < 0)
+			return -EINVAL;
+		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
+		user_stats->peer_id = peer_id;
+		user_stats->is_valid_peer_id = true;
+		memcpy(&user_stats->ack_ba, ptr,
+		       sizeof(struct htt_ppdu_stats_usr_cmpltn_ack_ba_status));
+		user_stats->tlv_flags |= BIT(tag);
+		break;
+	}
+	return 0;
+}
+
+int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
+			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
+				       const void *ptr, void *data),
+			   void *data)
+{
+	const struct htt_tlv *tlv;
+	const void *begin = ptr;
+	u16 tlv_tag, tlv_len;
+	int ret = -EINVAL;
+
+	while (len > 0) {
+		if (len < sizeof(*tlv)) {
+			ath12k_err(ab, "htt tlv parse failure at byte %zd (%zu bytes left, %zu expected)\n",
+				   ptr - begin, len, sizeof(*tlv));
+			return -EINVAL;
+		}
+		tlv = (struct htt_tlv *)ptr;
+		tlv_tag = le32_get_bits(tlv->header, HTT_TLV_TAG);
+		tlv_len = le32_get_bits(tlv->header, HTT_TLV_LEN);
+		ptr += sizeof(*tlv);
+		len -= sizeof(*tlv);
+
+		if (tlv_len > len) {
+			ath12k_err(ab, "htt tlv parse failure of tag %u at byte %zd (%zu bytes left, %u expected)\n",
+				   tlv_tag, ptr - begin, len, tlv_len);
+			return -EINVAL;
+		}
+		ret = iter(ab, tlv_tag, tlv_len, ptr, data);
+		if (ret == -ENOMEM)
+			return ret;
+
+		ptr += tlv_len;
+		len -= tlv_len;
+	}
+	return 0;
+}
+
+static void
+ath12k_update_per_peer_tx_stats(struct ath12k *ar,
+				struct htt_ppdu_stats *ppdu_stats, u8 user)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_peer *peer;
+	struct ath12k_link_sta *arsta;
+	struct htt_ppdu_stats_user_rate *user_rate;
+	struct ath12k_per_peer_tx_stats *peer_stats = &ar->peer_tx_stats;
+	struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
+	struct htt_ppdu_stats_common *common = &ppdu_stats->common;
+	int ret;
+	u8 flags, mcs, nss, bw, sgi, dcm, ppdu_type, rate_idx = 0;
+	u32 v, succ_bytes = 0;
+	u16 tones, rate = 0, succ_pkts = 0;
+	u32 tx_duration = 0;
+	u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
+	u16 tx_retry_failed = 0, tx_retry_count = 0;
+	bool is_ampdu = false, is_ofdma;
+
+	if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
+		return;
+
+	if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON)) {
+		is_ampdu =
+			HTT_USR_CMPLTN_IS_AMPDU(usr_stats->cmpltn_cmn.flags);
+		tx_retry_failed =
+			__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_tried) -
+			__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_success);
+		tx_retry_count =
+			HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
+			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
+	}
+
+	if (usr_stats->tlv_flags &
+	    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS)) {
+		succ_bytes = le32_to_cpu(usr_stats->ack_ba.success_bytes);
+		succ_pkts = le32_get_bits(usr_stats->ack_ba.info,
+					  HTT_PPDU_STATS_ACK_BA_INFO_NUM_MSDU_M);
+		tid = le32_get_bits(usr_stats->ack_ba.info,
+				    HTT_PPDU_STATS_ACK_BA_INFO_TID_NUM);
+	}
+
+	if (common->fes_duration_us)
+		tx_duration = le32_to_cpu(common->fes_duration_us);
+
+	user_rate = &usr_stats->rate;
+	flags = HTT_USR_RATE_PREAMBLE(user_rate->rate_flags);
+	bw = HTT_USR_RATE_BW(user_rate->rate_flags) - 2;
+	nss = HTT_USR_RATE_NSS(user_rate->rate_flags) + 1;
+	mcs = HTT_USR_RATE_MCS(user_rate->rate_flags);
+	sgi = HTT_USR_RATE_GI(user_rate->rate_flags);
+	dcm = HTT_USR_RATE_DCM(user_rate->rate_flags);
+
+	ppdu_type = HTT_USR_RATE_PPDU_TYPE(user_rate->info1);
+	is_ofdma = (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_OFDMA) ||
+		   (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO_OFDMA);
+
+	/* Note: If host configured fixed rates and in some other special
+	 * cases, the broadcast/management frames are sent in different rates.
+	 * Firmware rate's control to be skipped for this?
+	 */
+
+	if (flags == WMI_RATE_PREAMBLE_HE && mcs > ATH12K_HE_MCS_MAX) {
+		ath12k_warn(ab, "Invalid HE mcs %d peer stats",  mcs);
+		return;
+	}
+
+	if (flags == WMI_RATE_PREAMBLE_VHT && mcs > ATH12K_VHT_MCS_MAX) {
+		ath12k_warn(ab, "Invalid VHT mcs %d peer stats",  mcs);
+		return;
+	}
+
+	if (flags == WMI_RATE_PREAMBLE_HT && (mcs > ATH12K_HT_MCS_MAX || nss < 1)) {
+		ath12k_warn(ab, "Invalid HT mcs %d nss %d peer stats",
+			    mcs, nss);
+		return;
+	}
+
+	if (flags == WMI_RATE_PREAMBLE_CCK || flags == WMI_RATE_PREAMBLE_OFDM) {
+		ret = ath12k_mac_hw_ratecode_to_legacy_rate(mcs,
+							    flags,
+							    &rate_idx,
+							    &rate);
+		if (ret < 0)
+			return;
+	}
+
+	rcu_read_lock();
+	spin_lock_bh(&ab->base_lock);
+	peer = ath12k_peer_find_by_id(ab, usr_stats->peer_id);
+
+	if (!peer || !peer->sta) {
+		spin_unlock_bh(&ab->base_lock);
+		rcu_read_unlock();
+		return;
+	}
+
+	arsta = ath12k_peer_get_link_sta(ab, peer);
+	if (!arsta) {
+		spin_unlock_bh(&ab->base_lock);
+		rcu_read_unlock();
+		return;
+	}
+
+	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
+
+	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(bw);
+
+	switch (flags) {
+	case WMI_RATE_PREAMBLE_OFDM:
+		arsta->txrate.legacy = rate;
+		break;
+	case WMI_RATE_PREAMBLE_CCK:
+		arsta->txrate.legacy = rate;
+		break;
+	case WMI_RATE_PREAMBLE_HT:
+		arsta->txrate.mcs = mcs + 8 * (nss - 1);
+		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
+		if (sgi)
+			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case WMI_RATE_PREAMBLE_VHT:
+		arsta->txrate.mcs = mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		if (sgi)
+			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case WMI_RATE_PREAMBLE_HE:
+		arsta->txrate.mcs = mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
+		arsta->txrate.he_dcm = dcm;
+		arsta->txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
+		tones = le16_to_cpu(user_rate->ru_end) -
+			le16_to_cpu(user_rate->ru_start) + 1;
+		v = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
+		arsta->txrate.he_ru_alloc = v;
+		if (is_ofdma)
+			arsta->txrate.bw = RATE_INFO_BW_HE_RU;
+		break;
+	case WMI_RATE_PREAMBLE_EHT:
+		arsta->txrate.mcs = mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
+		arsta->txrate.he_dcm = dcm;
+		arsta->txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(sgi);
+		tones = le16_to_cpu(user_rate->ru_end) -
+			le16_to_cpu(user_rate->ru_start) + 1;
+		v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
+		arsta->txrate.eht_ru_alloc = v;
+		if (is_ofdma)
+			arsta->txrate.bw = RATE_INFO_BW_EHT_RU;
+		break;
+	}
+
+	arsta->tx_retry_failed += tx_retry_failed;
+	arsta->tx_retry_count += tx_retry_count;
+	arsta->txrate.nss = nss;
+	arsta->tx_duration += tx_duration;
+	memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
+
+	/* PPDU stats reported for mgmt packet doesn't have valid tx bytes.
+	 * So skip peer stats update for mgmt packets.
+	 */
+	if (tid < HTT_PPDU_STATS_NON_QOS_TID) {
+		memset(peer_stats, 0, sizeof(*peer_stats));
+		peer_stats->succ_pkts = succ_pkts;
+		peer_stats->succ_bytes = succ_bytes;
+		peer_stats->is_ampdu = is_ampdu;
+		peer_stats->duration = tx_duration;
+		peer_stats->ba_fails =
+			HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
+			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
+	}
+
+	spin_unlock_bh(&ab->base_lock);
+	rcu_read_unlock();
+}
+
+static void ath12k_htt_update_ppdu_stats(struct ath12k *ar,
+					 struct htt_ppdu_stats *ppdu_stats)
+{
+	u8 user;
+
+	for (user = 0; user < HTT_PPDU_STATS_MAX_USERS - 1; user++)
+		ath12k_update_per_peer_tx_stats(ar, ppdu_stats, user);
+}
+
+static
+struct htt_ppdu_stats_info *ath12k_dp_htt_get_ppdu_desc(struct ath12k *ar,
+							u32 ppdu_id)
+{
+	struct htt_ppdu_stats_info *ppdu_info;
+
+	lockdep_assert_held(&ar->data_lock);
+	if (!list_empty(&ar->ppdu_stats_info)) {
+		list_for_each_entry(ppdu_info, &ar->ppdu_stats_info, list) {
+			if (ppdu_info->ppdu_id == ppdu_id)
+				return ppdu_info;
+		}
+
+		if (ar->ppdu_stat_list_depth > HTT_PPDU_DESC_MAX_DEPTH) {
+			ppdu_info = list_first_entry(&ar->ppdu_stats_info,
+						     typeof(*ppdu_info), list);
+			list_del(&ppdu_info->list);
+			ar->ppdu_stat_list_depth--;
+			ath12k_htt_update_ppdu_stats(ar, &ppdu_info->ppdu_stats);
+			kfree(ppdu_info);
+		}
+	}
+
+	ppdu_info = kzalloc(sizeof(*ppdu_info), GFP_ATOMIC);
+	if (!ppdu_info)
+		return NULL;
+
+	list_add_tail(&ppdu_info->list, &ar->ppdu_stats_info);
+	ar->ppdu_stat_list_depth++;
+
+	return ppdu_info;
+}
+
+static void ath12k_copy_to_delay_stats(struct ath12k_peer *peer,
+				       struct htt_ppdu_user_stats *usr_stats)
+{
+	peer->ppdu_stats_delayba.sw_peer_id = le16_to_cpu(usr_stats->rate.sw_peer_id);
+	peer->ppdu_stats_delayba.info0 = le32_to_cpu(usr_stats->rate.info0);
+	peer->ppdu_stats_delayba.ru_end = le16_to_cpu(usr_stats->rate.ru_end);
+	peer->ppdu_stats_delayba.ru_start = le16_to_cpu(usr_stats->rate.ru_start);
+	peer->ppdu_stats_delayba.info1 = le32_to_cpu(usr_stats->rate.info1);
+	peer->ppdu_stats_delayba.rate_flags = le32_to_cpu(usr_stats->rate.rate_flags);
+	peer->ppdu_stats_delayba.resp_rate_flags =
+		le32_to_cpu(usr_stats->rate.resp_rate_flags);
+
+	peer->delayba_flag = true;
+}
+
+static void ath12k_copy_to_bar(struct ath12k_peer *peer,
+			       struct htt_ppdu_user_stats *usr_stats)
+{
+	usr_stats->rate.sw_peer_id = cpu_to_le16(peer->ppdu_stats_delayba.sw_peer_id);
+	usr_stats->rate.info0 = cpu_to_le32(peer->ppdu_stats_delayba.info0);
+	usr_stats->rate.ru_end = cpu_to_le16(peer->ppdu_stats_delayba.ru_end);
+	usr_stats->rate.ru_start = cpu_to_le16(peer->ppdu_stats_delayba.ru_start);
+	usr_stats->rate.info1 = cpu_to_le32(peer->ppdu_stats_delayba.info1);
+	usr_stats->rate.rate_flags = cpu_to_le32(peer->ppdu_stats_delayba.rate_flags);
+	usr_stats->rate.resp_rate_flags =
+		cpu_to_le32(peer->ppdu_stats_delayba.resp_rate_flags);
+
+	peer->delayba_flag = false;
+}
+
+static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
+				      struct sk_buff *skb)
+{
+	struct ath12k_htt_ppdu_stats_msg *msg;
+	struct htt_ppdu_stats_info *ppdu_info;
+	struct ath12k_peer *peer = NULL;
+	struct htt_ppdu_user_stats *usr_stats = NULL;
+	u32 peer_id = 0;
+	struct ath12k *ar;
+	int ret, i;
+	u8 pdev_id;
+	u32 ppdu_id, len;
+
+	msg = (struct ath12k_htt_ppdu_stats_msg *)skb->data;
+	len = le32_get_bits(msg->info, HTT_T2H_PPDU_STATS_INFO_PAYLOAD_SIZE);
+	if (len > (skb->len - struct_size(msg, data, 0))) {
+		ath12k_warn(ab,
+			    "HTT PPDU STATS event has unexpected payload size %u, should be smaller than %u\n",
+			    len, skb->len);
+		return -EINVAL;
+	}
+
+	pdev_id = le32_get_bits(msg->info, HTT_T2H_PPDU_STATS_INFO_PDEV_ID);
+	ppdu_id = le32_to_cpu(msg->ppdu_id);
+
+	rcu_read_lock();
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
+	if (!ar) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+	ppdu_info = ath12k_dp_htt_get_ppdu_desc(ar, ppdu_id);
+	if (!ppdu_info) {
+		spin_unlock_bh(&ar->data_lock);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ppdu_info->ppdu_id = ppdu_id;
+	ret = ath12k_dp_htt_tlv_iter(ab, msg->data, len,
+				     ath12k_htt_tlv_ppdu_stats_parse,
+				     (void *)ppdu_info);
+	if (ret) {
+		spin_unlock_bh(&ar->data_lock);
+		ath12k_warn(ab, "Failed to parse tlv %d\n", ret);
+		goto exit;
+	}
+
+	if (ppdu_info->ppdu_stats.common.num_users >= HTT_PPDU_STATS_MAX_USERS) {
+		spin_unlock_bh(&ar->data_lock);
+		ath12k_warn(ab,
+			    "HTT PPDU STATS event has unexpected num_users %u, should be smaller than %u\n",
+			    ppdu_info->ppdu_stats.common.num_users,
+			    HTT_PPDU_STATS_MAX_USERS);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	/* back up data rate tlv for all peers */
+	if (ppdu_info->frame_type == HTT_STATS_PPDU_FTYPE_DATA &&
+	    (ppdu_info->tlv_bitmap & (1 << HTT_PPDU_STATS_TAG_USR_COMMON)) &&
+	    ppdu_info->delay_ba) {
+		for (i = 0; i < ppdu_info->ppdu_stats.common.num_users; i++) {
+			peer_id = ppdu_info->ppdu_stats.user_stats[i].peer_id;
+			spin_lock_bh(&ab->base_lock);
+			peer = ath12k_peer_find_by_id(ab, peer_id);
+			if (!peer) {
+				spin_unlock_bh(&ab->base_lock);
+				continue;
+			}
+
+			usr_stats = &ppdu_info->ppdu_stats.user_stats[i];
+			if (usr_stats->delay_ba)
+				ath12k_copy_to_delay_stats(peer, usr_stats);
+			spin_unlock_bh(&ab->base_lock);
+		}
+	}
+
+	/* restore all peers' data rate tlv to mu-bar tlv */
+	if (ppdu_info->frame_type == HTT_STATS_PPDU_FTYPE_BAR &&
+	    (ppdu_info->tlv_bitmap & (1 << HTT_PPDU_STATS_TAG_USR_COMMON))) {
+		for (i = 0; i < ppdu_info->bar_num_users; i++) {
+			peer_id = ppdu_info->ppdu_stats.user_stats[i].peer_id;
+			spin_lock_bh(&ab->base_lock);
+			peer = ath12k_peer_find_by_id(ab, peer_id);
+			if (!peer) {
+				spin_unlock_bh(&ab->base_lock);
+				continue;
+			}
+
+			usr_stats = &ppdu_info->ppdu_stats.user_stats[i];
+			if (peer->delayba_flag)
+				ath12k_copy_to_bar(peer, usr_stats);
+			spin_unlock_bh(&ab->base_lock);
+		}
+	}
+
+	spin_unlock_bh(&ar->data_lock);
+
+exit:
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static void ath12k_htt_mlo_offset_event_handler(struct ath12k_base *ab,
+						struct sk_buff *skb)
+{
+	struct ath12k_htt_mlo_offset_msg *msg;
+	struct ath12k_pdev *pdev;
+	struct ath12k *ar;
+	u8 pdev_id;
+
+	msg = (struct ath12k_htt_mlo_offset_msg *)skb->data;
+	pdev_id = u32_get_bits(__le32_to_cpu(msg->info),
+			       HTT_T2H_MLO_OFFSET_INFO_PDEV_ID);
+
+	rcu_read_lock();
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
+	if (!ar) {
+		/* It is possible that the ar is not yet active (started).
+		 * The above function will only look for the active pdev
+		 * and hence %NULL return is possible. Just silently
+		 * discard this message
+		 */
+		goto exit;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+	pdev = ar->pdev;
+
+	pdev->timestamp.info = __le32_to_cpu(msg->info);
+	pdev->timestamp.sync_timestamp_lo_us = __le32_to_cpu(msg->sync_timestamp_lo_us);
+	pdev->timestamp.sync_timestamp_hi_us = __le32_to_cpu(msg->sync_timestamp_hi_us);
+	pdev->timestamp.mlo_offset_lo = __le32_to_cpu(msg->mlo_offset_lo);
+	pdev->timestamp.mlo_offset_hi = __le32_to_cpu(msg->mlo_offset_hi);
+	pdev->timestamp.mlo_offset_clks = __le32_to_cpu(msg->mlo_offset_clks);
+	pdev->timestamp.mlo_comp_clks = __le32_to_cpu(msg->mlo_comp_clks);
+	pdev->timestamp.mlo_comp_timer = __le32_to_cpu(msg->mlo_comp_timer);
+
+	spin_unlock_bh(&ar->data_lock);
+exit:
+	rcu_read_unlock();
+}
+
+void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
+				       struct sk_buff *skb)
+{
+	struct ath12k_dp *dp = &ab->dp;
+	struct htt_resp_msg *resp = (struct htt_resp_msg *)skb->data;
+	enum htt_t2h_msg_type type;
+	u16 peer_id;
+	u8 vdev_id;
+	u8 mac_addr[ETH_ALEN];
+	u16 peer_mac_h16;
+	u16 ast_hash = 0;
+	u16 hw_peer_id;
+
+	type = le32_get_bits(resp->version_msg.version, HTT_T2H_MSG_TYPE);
+
+	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "dp_htt rx msg type :0x%0x\n", type);
+
+	switch (type) {
+	case HTT_T2H_MSG_TYPE_VERSION_CONF:
+		dp->htt_tgt_ver_major = le32_get_bits(resp->version_msg.version,
+						      HTT_T2H_VERSION_CONF_MAJOR);
+		dp->htt_tgt_ver_minor = le32_get_bits(resp->version_msg.version,
+						      HTT_T2H_VERSION_CONF_MINOR);
+		complete(&dp->htt_tgt_version_received);
+		break;
+	/* TODO: remove unused peer map versions after testing */
+	case HTT_T2H_MSG_TYPE_PEER_MAP:
+		vdev_id = le32_get_bits(resp->peer_map_ev.info,
+					HTT_T2H_PEER_MAP_INFO_VDEV_ID);
+		peer_id = le32_get_bits(resp->peer_map_ev.info,
+					HTT_T2H_PEER_MAP_INFO_PEER_ID);
+		peer_mac_h16 = le32_get_bits(resp->peer_map_ev.info1,
+					     HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16);
+		ath12k_dp_get_mac_addr(le32_to_cpu(resp->peer_map_ev.mac_addr_l32),
+				       peer_mac_h16, mac_addr);
+		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, 0, 0);
+		break;
+	case HTT_T2H_MSG_TYPE_PEER_MAP2:
+		vdev_id = le32_get_bits(resp->peer_map_ev.info,
+					HTT_T2H_PEER_MAP_INFO_VDEV_ID);
+		peer_id = le32_get_bits(resp->peer_map_ev.info,
+					HTT_T2H_PEER_MAP_INFO_PEER_ID);
+		peer_mac_h16 = le32_get_bits(resp->peer_map_ev.info1,
+					     HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16);
+		ath12k_dp_get_mac_addr(le32_to_cpu(resp->peer_map_ev.mac_addr_l32),
+				       peer_mac_h16, mac_addr);
+		ast_hash = le32_get_bits(resp->peer_map_ev.info2,
+					 HTT_T2H_PEER_MAP_INFO2_AST_HASH_VAL);
+		hw_peer_id = le32_get_bits(resp->peer_map_ev.info1,
+					   HTT_T2H_PEER_MAP_INFO1_HW_PEER_ID);
+		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
+				      hw_peer_id);
+		break;
+	case HTT_T2H_MSG_TYPE_PEER_MAP3:
+		vdev_id = le32_get_bits(resp->peer_map_ev.info,
+					HTT_T2H_PEER_MAP_INFO_VDEV_ID);
+		peer_id = le32_get_bits(resp->peer_map_ev.info,
+					HTT_T2H_PEER_MAP_INFO_PEER_ID);
+		peer_mac_h16 = le32_get_bits(resp->peer_map_ev.info1,
+					     HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16);
+		ath12k_dp_get_mac_addr(le32_to_cpu(resp->peer_map_ev.mac_addr_l32),
+				       peer_mac_h16, mac_addr);
+		ast_hash = le32_get_bits(resp->peer_map_ev.info2,
+					 HTT_T2H_PEER_MAP3_INFO2_AST_HASH_VAL);
+		hw_peer_id = le32_get_bits(resp->peer_map_ev.info2,
+					   HTT_T2H_PEER_MAP3_INFO2_HW_PEER_ID);
+		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
+				      hw_peer_id);
+		break;
+	case HTT_T2H_MSG_TYPE_PEER_UNMAP:
+	case HTT_T2H_MSG_TYPE_PEER_UNMAP2:
+		peer_id = le32_get_bits(resp->peer_unmap_ev.info,
+					HTT_T2H_PEER_UNMAP_INFO_PEER_ID);
+		ath12k_peer_unmap_event(ab, peer_id);
+		break;
+	case HTT_T2H_MSG_TYPE_PPDU_STATS_IND:
+		ath12k_htt_pull_ppdu_stats(ab, skb);
+		break;
+	case HTT_T2H_MSG_TYPE_EXT_STATS_CONF:
+		ath12k_debugfs_htt_ext_stats_handler(ab, skb);
+		break;
+	case HTT_T2H_MSG_TYPE_MLO_TIMESTAMP_OFFSET_IND:
+		ath12k_htt_mlo_offset_event_handler(ab, skb);
+		break;
+	default:
+		ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "dp_htt event %d not handled\n",
+			   type);
+		break;
+	}
+
+	dev_kfree_skb_any(skb);
+}
+EXPORT_SYMBOL(ath12k_dp_htt_htc_t2h_msg_handler);
diff --git a/drivers/net/wireless/ath/ath12k/dp_htt.h b/drivers/net/wireless/ath/ath12k/dp_htt.h
index ce9064628d34..9ae3a750f608 100644
--- a/drivers/net/wireless/ath/ath12k/dp_htt.h
+++ b/drivers/net/wireless/ath/ath12k/dp_htt.h
@@ -1514,4 +1514,10 @@ struct htt_mac_addr {
 	__le32 mac_addr_h16;
 } __packed;
 
+int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
+			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
+				       const void *ptr, void *data),
+				       void *data);
+void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
+				       struct sk_buff *skb);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index d735eee9efee..e1a2f5f54adb 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -719,639 +719,6 @@ int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_link_vif *arvif,
 	return ret;
 }
 
-static int ath12k_get_ppdu_user_index(struct htt_ppdu_stats *ppdu_stats,
-				      u16 peer_id)
-{
-	int i;
-
-	for (i = 0; i < HTT_PPDU_STATS_MAX_USERS - 1; i++) {
-		if (ppdu_stats->user_stats[i].is_valid_peer_id) {
-			if (peer_id == ppdu_stats->user_stats[i].peer_id)
-				return i;
-		} else {
-			return i;
-		}
-	}
-
-	return -EINVAL;
-}
-
-static int ath12k_htt_tlv_ppdu_stats_parse(struct ath12k_base *ab,
-					   u16 tag, u16 len, const void *ptr,
-					   void *data)
-{
-	const struct htt_ppdu_stats_usr_cmpltn_ack_ba_status *ba_status;
-	const struct htt_ppdu_stats_usr_cmpltn_cmn *cmplt_cmn;
-	const struct htt_ppdu_stats_user_rate *user_rate;
-	struct htt_ppdu_stats_info *ppdu_info;
-	struct htt_ppdu_user_stats *user_stats;
-	int cur_user;
-	u16 peer_id;
-
-	ppdu_info = data;
-
-	switch (tag) {
-	case HTT_PPDU_STATS_TAG_COMMON:
-		if (len < sizeof(struct htt_ppdu_stats_common)) {
-			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
-				    len, tag);
-			return -EINVAL;
-		}
-		memcpy(&ppdu_info->ppdu_stats.common, ptr,
-		       sizeof(struct htt_ppdu_stats_common));
-		break;
-	case HTT_PPDU_STATS_TAG_USR_RATE:
-		if (len < sizeof(struct htt_ppdu_stats_user_rate)) {
-			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
-				    len, tag);
-			return -EINVAL;
-		}
-		user_rate = ptr;
-		peer_id = le16_to_cpu(user_rate->sw_peer_id);
-		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
-						      peer_id);
-		if (cur_user < 0)
-			return -EINVAL;
-		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
-		user_stats->peer_id = peer_id;
-		user_stats->is_valid_peer_id = true;
-		memcpy(&user_stats->rate, ptr,
-		       sizeof(struct htt_ppdu_stats_user_rate));
-		user_stats->tlv_flags |= BIT(tag);
-		break;
-	case HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON:
-		if (len < sizeof(struct htt_ppdu_stats_usr_cmpltn_cmn)) {
-			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
-				    len, tag);
-			return -EINVAL;
-		}
-
-		cmplt_cmn = ptr;
-		peer_id = le16_to_cpu(cmplt_cmn->sw_peer_id);
-		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
-						      peer_id);
-		if (cur_user < 0)
-			return -EINVAL;
-		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
-		user_stats->peer_id = peer_id;
-		user_stats->is_valid_peer_id = true;
-		memcpy(&user_stats->cmpltn_cmn, ptr,
-		       sizeof(struct htt_ppdu_stats_usr_cmpltn_cmn));
-		user_stats->tlv_flags |= BIT(tag);
-		break;
-	case HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS:
-		if (len <
-		    sizeof(struct htt_ppdu_stats_usr_cmpltn_ack_ba_status)) {
-			ath12k_warn(ab, "Invalid len %d for the tag 0x%x\n",
-				    len, tag);
-			return -EINVAL;
-		}
-
-		ba_status = ptr;
-		peer_id = le16_to_cpu(ba_status->sw_peer_id);
-		cur_user = ath12k_get_ppdu_user_index(&ppdu_info->ppdu_stats,
-						      peer_id);
-		if (cur_user < 0)
-			return -EINVAL;
-		user_stats = &ppdu_info->ppdu_stats.user_stats[cur_user];
-		user_stats->peer_id = peer_id;
-		user_stats->is_valid_peer_id = true;
-		memcpy(&user_stats->ack_ba, ptr,
-		       sizeof(struct htt_ppdu_stats_usr_cmpltn_ack_ba_status));
-		user_stats->tlv_flags |= BIT(tag);
-		break;
-	}
-	return 0;
-}
-
-int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
-			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
-				       const void *ptr, void *data),
-			   void *data)
-{
-	const struct htt_tlv *tlv;
-	const void *begin = ptr;
-	u16 tlv_tag, tlv_len;
-	int ret = -EINVAL;
-
-	while (len > 0) {
-		if (len < sizeof(*tlv)) {
-			ath12k_err(ab, "htt tlv parse failure at byte %zd (%zu bytes left, %zu expected)\n",
-				   ptr - begin, len, sizeof(*tlv));
-			return -EINVAL;
-		}
-		tlv = (struct htt_tlv *)ptr;
-		tlv_tag = le32_get_bits(tlv->header, HTT_TLV_TAG);
-		tlv_len = le32_get_bits(tlv->header, HTT_TLV_LEN);
-		ptr += sizeof(*tlv);
-		len -= sizeof(*tlv);
-
-		if (tlv_len > len) {
-			ath12k_err(ab, "htt tlv parse failure of tag %u at byte %zd (%zu bytes left, %u expected)\n",
-				   tlv_tag, ptr - begin, len, tlv_len);
-			return -EINVAL;
-		}
-		ret = iter(ab, tlv_tag, tlv_len, ptr, data);
-		if (ret == -ENOMEM)
-			return ret;
-
-		ptr += tlv_len;
-		len -= tlv_len;
-	}
-	return 0;
-}
-
-static void
-ath12k_update_per_peer_tx_stats(struct ath12k *ar,
-				struct htt_ppdu_stats *ppdu_stats, u8 user)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_peer *peer;
-	struct ath12k_link_sta *arsta;
-	struct htt_ppdu_stats_user_rate *user_rate;
-	struct ath12k_per_peer_tx_stats *peer_stats = &ar->peer_tx_stats;
-	struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
-	struct htt_ppdu_stats_common *common = &ppdu_stats->common;
-	int ret;
-	u8 flags, mcs, nss, bw, sgi, dcm, ppdu_type, rate_idx = 0;
-	u32 v, succ_bytes = 0;
-	u16 tones, rate = 0, succ_pkts = 0;
-	u32 tx_duration = 0;
-	u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
-	u16 tx_retry_failed = 0, tx_retry_count = 0;
-	bool is_ampdu = false, is_ofdma;
-
-	if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
-		return;
-
-	if (usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_COMMON)) {
-		is_ampdu =
-			HTT_USR_CMPLTN_IS_AMPDU(usr_stats->cmpltn_cmn.flags);
-		tx_retry_failed =
-			__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_tried) -
-			__le16_to_cpu(usr_stats->cmpltn_cmn.mpdu_success);
-		tx_retry_count =
-			HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
-			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
-	}
-
-	if (usr_stats->tlv_flags &
-	    BIT(HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS)) {
-		succ_bytes = le32_to_cpu(usr_stats->ack_ba.success_bytes);
-		succ_pkts = le32_get_bits(usr_stats->ack_ba.info,
-					  HTT_PPDU_STATS_ACK_BA_INFO_NUM_MSDU_M);
-		tid = le32_get_bits(usr_stats->ack_ba.info,
-				    HTT_PPDU_STATS_ACK_BA_INFO_TID_NUM);
-	}
-
-	if (common->fes_duration_us)
-		tx_duration = le32_to_cpu(common->fes_duration_us);
-
-	user_rate = &usr_stats->rate;
-	flags = HTT_USR_RATE_PREAMBLE(user_rate->rate_flags);
-	bw = HTT_USR_RATE_BW(user_rate->rate_flags) - 2;
-	nss = HTT_USR_RATE_NSS(user_rate->rate_flags) + 1;
-	mcs = HTT_USR_RATE_MCS(user_rate->rate_flags);
-	sgi = HTT_USR_RATE_GI(user_rate->rate_flags);
-	dcm = HTT_USR_RATE_DCM(user_rate->rate_flags);
-
-	ppdu_type = HTT_USR_RATE_PPDU_TYPE(user_rate->info1);
-	is_ofdma = (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_OFDMA) ||
-		   (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO_OFDMA);
-
-	/* Note: If host configured fixed rates and in some other special
-	 * cases, the broadcast/management frames are sent in different rates.
-	 * Firmware rate's control to be skipped for this?
-	 */
-
-	if (flags == WMI_RATE_PREAMBLE_HE && mcs > ATH12K_HE_MCS_MAX) {
-		ath12k_warn(ab, "Invalid HE mcs %d peer stats",  mcs);
-		return;
-	}
-
-	if (flags == WMI_RATE_PREAMBLE_VHT && mcs > ATH12K_VHT_MCS_MAX) {
-		ath12k_warn(ab, "Invalid VHT mcs %d peer stats",  mcs);
-		return;
-	}
-
-	if (flags == WMI_RATE_PREAMBLE_HT && (mcs > ATH12K_HT_MCS_MAX || nss < 1)) {
-		ath12k_warn(ab, "Invalid HT mcs %d nss %d peer stats",
-			    mcs, nss);
-		return;
-	}
-
-	if (flags == WMI_RATE_PREAMBLE_CCK || flags == WMI_RATE_PREAMBLE_OFDM) {
-		ret = ath12k_mac_hw_ratecode_to_legacy_rate(mcs,
-							    flags,
-							    &rate_idx,
-							    &rate);
-		if (ret < 0)
-			return;
-	}
-
-	rcu_read_lock();
-	spin_lock_bh(&ab->base_lock);
-	peer = ath12k_peer_find_by_id(ab, usr_stats->peer_id);
-
-	if (!peer || !peer->sta) {
-		spin_unlock_bh(&ab->base_lock);
-		rcu_read_unlock();
-		return;
-	}
-
-	arsta = ath12k_peer_get_link_sta(ab, peer);
-	if (!arsta) {
-		spin_unlock_bh(&ab->base_lock);
-		rcu_read_unlock();
-		return;
-	}
-
-	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
-
-	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(bw);
-
-	switch (flags) {
-	case WMI_RATE_PREAMBLE_OFDM:
-		arsta->txrate.legacy = rate;
-		break;
-	case WMI_RATE_PREAMBLE_CCK:
-		arsta->txrate.legacy = rate;
-		break;
-	case WMI_RATE_PREAMBLE_HT:
-		arsta->txrate.mcs = mcs + 8 * (nss - 1);
-		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
-		if (sgi)
-			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case WMI_RATE_PREAMBLE_VHT:
-		arsta->txrate.mcs = mcs;
-		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
-		if (sgi)
-			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case WMI_RATE_PREAMBLE_HE:
-		arsta->txrate.mcs = mcs;
-		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
-		arsta->txrate.he_dcm = dcm;
-		arsta->txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
-		tones = le16_to_cpu(user_rate->ru_end) -
-			le16_to_cpu(user_rate->ru_start) + 1;
-		v = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
-		arsta->txrate.he_ru_alloc = v;
-		if (is_ofdma)
-			arsta->txrate.bw = RATE_INFO_BW_HE_RU;
-		break;
-	case WMI_RATE_PREAMBLE_EHT:
-		arsta->txrate.mcs = mcs;
-		arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
-		arsta->txrate.he_dcm = dcm;
-		arsta->txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(sgi);
-		tones = le16_to_cpu(user_rate->ru_end) -
-			le16_to_cpu(user_rate->ru_start) + 1;
-		v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
-		arsta->txrate.eht_ru_alloc = v;
-		if (is_ofdma)
-			arsta->txrate.bw = RATE_INFO_BW_EHT_RU;
-		break;
-	}
-
-	arsta->tx_retry_failed += tx_retry_failed;
-	arsta->tx_retry_count += tx_retry_count;
-	arsta->txrate.nss = nss;
-	arsta->tx_duration += tx_duration;
-	memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
-
-	/* PPDU stats reported for mgmt packet doesn't have valid tx bytes.
-	 * So skip peer stats update for mgmt packets.
-	 */
-	if (tid < HTT_PPDU_STATS_NON_QOS_TID) {
-		memset(peer_stats, 0, sizeof(*peer_stats));
-		peer_stats->succ_pkts = succ_pkts;
-		peer_stats->succ_bytes = succ_bytes;
-		peer_stats->is_ampdu = is_ampdu;
-		peer_stats->duration = tx_duration;
-		peer_stats->ba_fails =
-			HTT_USR_CMPLTN_LONG_RETRY(usr_stats->cmpltn_cmn.flags) +
-			HTT_USR_CMPLTN_SHORT_RETRY(usr_stats->cmpltn_cmn.flags);
-	}
-
-	spin_unlock_bh(&ab->base_lock);
-	rcu_read_unlock();
-}
-
-static void ath12k_htt_update_ppdu_stats(struct ath12k *ar,
-					 struct htt_ppdu_stats *ppdu_stats)
-{
-	u8 user;
-
-	for (user = 0; user < HTT_PPDU_STATS_MAX_USERS - 1; user++)
-		ath12k_update_per_peer_tx_stats(ar, ppdu_stats, user);
-}
-
-static
-struct htt_ppdu_stats_info *ath12k_dp_htt_get_ppdu_desc(struct ath12k *ar,
-							u32 ppdu_id)
-{
-	struct htt_ppdu_stats_info *ppdu_info;
-
-	lockdep_assert_held(&ar->data_lock);
-	if (!list_empty(&ar->ppdu_stats_info)) {
-		list_for_each_entry(ppdu_info, &ar->ppdu_stats_info, list) {
-			if (ppdu_info->ppdu_id == ppdu_id)
-				return ppdu_info;
-		}
-
-		if (ar->ppdu_stat_list_depth > HTT_PPDU_DESC_MAX_DEPTH) {
-			ppdu_info = list_first_entry(&ar->ppdu_stats_info,
-						     typeof(*ppdu_info), list);
-			list_del(&ppdu_info->list);
-			ar->ppdu_stat_list_depth--;
-			ath12k_htt_update_ppdu_stats(ar, &ppdu_info->ppdu_stats);
-			kfree(ppdu_info);
-		}
-	}
-
-	ppdu_info = kzalloc(sizeof(*ppdu_info), GFP_ATOMIC);
-	if (!ppdu_info)
-		return NULL;
-
-	list_add_tail(&ppdu_info->list, &ar->ppdu_stats_info);
-	ar->ppdu_stat_list_depth++;
-
-	return ppdu_info;
-}
-
-static void ath12k_copy_to_delay_stats(struct ath12k_peer *peer,
-				       struct htt_ppdu_user_stats *usr_stats)
-{
-	peer->ppdu_stats_delayba.sw_peer_id = le16_to_cpu(usr_stats->rate.sw_peer_id);
-	peer->ppdu_stats_delayba.info0 = le32_to_cpu(usr_stats->rate.info0);
-	peer->ppdu_stats_delayba.ru_end = le16_to_cpu(usr_stats->rate.ru_end);
-	peer->ppdu_stats_delayba.ru_start = le16_to_cpu(usr_stats->rate.ru_start);
-	peer->ppdu_stats_delayba.info1 = le32_to_cpu(usr_stats->rate.info1);
-	peer->ppdu_stats_delayba.rate_flags = le32_to_cpu(usr_stats->rate.rate_flags);
-	peer->ppdu_stats_delayba.resp_rate_flags =
-		le32_to_cpu(usr_stats->rate.resp_rate_flags);
-
-	peer->delayba_flag = true;
-}
-
-static void ath12k_copy_to_bar(struct ath12k_peer *peer,
-			       struct htt_ppdu_user_stats *usr_stats)
-{
-	usr_stats->rate.sw_peer_id = cpu_to_le16(peer->ppdu_stats_delayba.sw_peer_id);
-	usr_stats->rate.info0 = cpu_to_le32(peer->ppdu_stats_delayba.info0);
-	usr_stats->rate.ru_end = cpu_to_le16(peer->ppdu_stats_delayba.ru_end);
-	usr_stats->rate.ru_start = cpu_to_le16(peer->ppdu_stats_delayba.ru_start);
-	usr_stats->rate.info1 = cpu_to_le32(peer->ppdu_stats_delayba.info1);
-	usr_stats->rate.rate_flags = cpu_to_le32(peer->ppdu_stats_delayba.rate_flags);
-	usr_stats->rate.resp_rate_flags =
-		cpu_to_le32(peer->ppdu_stats_delayba.resp_rate_flags);
-
-	peer->delayba_flag = false;
-}
-
-static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
-				      struct sk_buff *skb)
-{
-	struct ath12k_htt_ppdu_stats_msg *msg;
-	struct htt_ppdu_stats_info *ppdu_info;
-	struct ath12k_peer *peer = NULL;
-	struct htt_ppdu_user_stats *usr_stats = NULL;
-	u32 peer_id = 0;
-	struct ath12k *ar;
-	int ret, i;
-	u8 pdev_id;
-	u32 ppdu_id, len;
-
-	msg = (struct ath12k_htt_ppdu_stats_msg *)skb->data;
-	len = le32_get_bits(msg->info, HTT_T2H_PPDU_STATS_INFO_PAYLOAD_SIZE);
-	if (len > (skb->len - struct_size(msg, data, 0))) {
-		ath12k_warn(ab,
-			    "HTT PPDU STATS event has unexpected payload size %u, should be smaller than %u\n",
-			    len, skb->len);
-		return -EINVAL;
-	}
-
-	pdev_id = le32_get_bits(msg->info, HTT_T2H_PPDU_STATS_INFO_PDEV_ID);
-	ppdu_id = le32_to_cpu(msg->ppdu_id);
-
-	rcu_read_lock();
-	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
-	if (!ar) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	spin_lock_bh(&ar->data_lock);
-	ppdu_info = ath12k_dp_htt_get_ppdu_desc(ar, ppdu_id);
-	if (!ppdu_info) {
-		spin_unlock_bh(&ar->data_lock);
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	ppdu_info->ppdu_id = ppdu_id;
-	ret = ath12k_dp_htt_tlv_iter(ab, msg->data, len,
-				     ath12k_htt_tlv_ppdu_stats_parse,
-				     (void *)ppdu_info);
-	if (ret) {
-		spin_unlock_bh(&ar->data_lock);
-		ath12k_warn(ab, "Failed to parse tlv %d\n", ret);
-		goto exit;
-	}
-
-	if (ppdu_info->ppdu_stats.common.num_users >= HTT_PPDU_STATS_MAX_USERS) {
-		spin_unlock_bh(&ar->data_lock);
-		ath12k_warn(ab,
-			    "HTT PPDU STATS event has unexpected num_users %u, should be smaller than %u\n",
-			    ppdu_info->ppdu_stats.common.num_users,
-			    HTT_PPDU_STATS_MAX_USERS);
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	/* back up data rate tlv for all peers */
-	if (ppdu_info->frame_type == HTT_STATS_PPDU_FTYPE_DATA &&
-	    (ppdu_info->tlv_bitmap & (1 << HTT_PPDU_STATS_TAG_USR_COMMON)) &&
-	    ppdu_info->delay_ba) {
-		for (i = 0; i < ppdu_info->ppdu_stats.common.num_users; i++) {
-			peer_id = ppdu_info->ppdu_stats.user_stats[i].peer_id;
-			spin_lock_bh(&ab->base_lock);
-			peer = ath12k_peer_find_by_id(ab, peer_id);
-			if (!peer) {
-				spin_unlock_bh(&ab->base_lock);
-				continue;
-			}
-
-			usr_stats = &ppdu_info->ppdu_stats.user_stats[i];
-			if (usr_stats->delay_ba)
-				ath12k_copy_to_delay_stats(peer, usr_stats);
-			spin_unlock_bh(&ab->base_lock);
-		}
-	}
-
-	/* restore all peers' data rate tlv to mu-bar tlv */
-	if (ppdu_info->frame_type == HTT_STATS_PPDU_FTYPE_BAR &&
-	    (ppdu_info->tlv_bitmap & (1 << HTT_PPDU_STATS_TAG_USR_COMMON))) {
-		for (i = 0; i < ppdu_info->bar_num_users; i++) {
-			peer_id = ppdu_info->ppdu_stats.user_stats[i].peer_id;
-			spin_lock_bh(&ab->base_lock);
-			peer = ath12k_peer_find_by_id(ab, peer_id);
-			if (!peer) {
-				spin_unlock_bh(&ab->base_lock);
-				continue;
-			}
-
-			usr_stats = &ppdu_info->ppdu_stats.user_stats[i];
-			if (peer->delayba_flag)
-				ath12k_copy_to_bar(peer, usr_stats);
-			spin_unlock_bh(&ab->base_lock);
-		}
-	}
-
-	spin_unlock_bh(&ar->data_lock);
-
-exit:
-	rcu_read_unlock();
-
-	return ret;
-}
-
-static void ath12k_htt_mlo_offset_event_handler(struct ath12k_base *ab,
-						struct sk_buff *skb)
-{
-	struct ath12k_htt_mlo_offset_msg *msg;
-	struct ath12k_pdev *pdev;
-	struct ath12k *ar;
-	u8 pdev_id;
-
-	msg = (struct ath12k_htt_mlo_offset_msg *)skb->data;
-	pdev_id = u32_get_bits(__le32_to_cpu(msg->info),
-			       HTT_T2H_MLO_OFFSET_INFO_PDEV_ID);
-
-	rcu_read_lock();
-	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
-	if (!ar) {
-		/* It is possible that the ar is not yet active (started).
-		 * The above function will only look for the active pdev
-		 * and hence %NULL return is possible. Just silently
-		 * discard this message
-		 */
-		goto exit;
-	}
-
-	spin_lock_bh(&ar->data_lock);
-	pdev = ar->pdev;
-
-	pdev->timestamp.info = __le32_to_cpu(msg->info);
-	pdev->timestamp.sync_timestamp_lo_us = __le32_to_cpu(msg->sync_timestamp_lo_us);
-	pdev->timestamp.sync_timestamp_hi_us = __le32_to_cpu(msg->sync_timestamp_hi_us);
-	pdev->timestamp.mlo_offset_lo = __le32_to_cpu(msg->mlo_offset_lo);
-	pdev->timestamp.mlo_offset_hi = __le32_to_cpu(msg->mlo_offset_hi);
-	pdev->timestamp.mlo_offset_clks = __le32_to_cpu(msg->mlo_offset_clks);
-	pdev->timestamp.mlo_comp_clks = __le32_to_cpu(msg->mlo_comp_clks);
-	pdev->timestamp.mlo_comp_timer = __le32_to_cpu(msg->mlo_comp_timer);
-
-	spin_unlock_bh(&ar->data_lock);
-exit:
-	rcu_read_unlock();
-}
-
-void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
-				       struct sk_buff *skb)
-{
-	struct ath12k_dp *dp = &ab->dp;
-	struct htt_resp_msg *resp = (struct htt_resp_msg *)skb->data;
-	enum htt_t2h_msg_type type;
-	u16 peer_id;
-	u8 vdev_id;
-	u8 mac_addr[ETH_ALEN];
-	u16 peer_mac_h16;
-	u16 ast_hash = 0;
-	u16 hw_peer_id;
-
-	type = le32_get_bits(resp->version_msg.version, HTT_T2H_MSG_TYPE);
-
-	ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "dp_htt rx msg type :0x%0x\n", type);
-
-	switch (type) {
-	case HTT_T2H_MSG_TYPE_VERSION_CONF:
-		dp->htt_tgt_ver_major = le32_get_bits(resp->version_msg.version,
-						      HTT_T2H_VERSION_CONF_MAJOR);
-		dp->htt_tgt_ver_minor = le32_get_bits(resp->version_msg.version,
-						      HTT_T2H_VERSION_CONF_MINOR);
-		complete(&dp->htt_tgt_version_received);
-		break;
-	/* TODO: remove unused peer map versions after testing */
-	case HTT_T2H_MSG_TYPE_PEER_MAP:
-		vdev_id = le32_get_bits(resp->peer_map_ev.info,
-					HTT_T2H_PEER_MAP_INFO_VDEV_ID);
-		peer_id = le32_get_bits(resp->peer_map_ev.info,
-					HTT_T2H_PEER_MAP_INFO_PEER_ID);
-		peer_mac_h16 = le32_get_bits(resp->peer_map_ev.info1,
-					     HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16);
-		ath12k_dp_get_mac_addr(le32_to_cpu(resp->peer_map_ev.mac_addr_l32),
-				       peer_mac_h16, mac_addr);
-		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, 0, 0);
-		break;
-	case HTT_T2H_MSG_TYPE_PEER_MAP2:
-		vdev_id = le32_get_bits(resp->peer_map_ev.info,
-					HTT_T2H_PEER_MAP_INFO_VDEV_ID);
-		peer_id = le32_get_bits(resp->peer_map_ev.info,
-					HTT_T2H_PEER_MAP_INFO_PEER_ID);
-		peer_mac_h16 = le32_get_bits(resp->peer_map_ev.info1,
-					     HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16);
-		ath12k_dp_get_mac_addr(le32_to_cpu(resp->peer_map_ev.mac_addr_l32),
-				       peer_mac_h16, mac_addr);
-		ast_hash = le32_get_bits(resp->peer_map_ev.info2,
-					 HTT_T2H_PEER_MAP_INFO2_AST_HASH_VAL);
-		hw_peer_id = le32_get_bits(resp->peer_map_ev.info1,
-					   HTT_T2H_PEER_MAP_INFO1_HW_PEER_ID);
-		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
-				      hw_peer_id);
-		break;
-	case HTT_T2H_MSG_TYPE_PEER_MAP3:
-		vdev_id = le32_get_bits(resp->peer_map_ev.info,
-					HTT_T2H_PEER_MAP_INFO_VDEV_ID);
-		peer_id = le32_get_bits(resp->peer_map_ev.info,
-					HTT_T2H_PEER_MAP_INFO_PEER_ID);
-		peer_mac_h16 = le32_get_bits(resp->peer_map_ev.info1,
-					     HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16);
-		ath12k_dp_get_mac_addr(le32_to_cpu(resp->peer_map_ev.mac_addr_l32),
-				       peer_mac_h16, mac_addr);
-		ast_hash = le32_get_bits(resp->peer_map_ev.info2,
-					 HTT_T2H_PEER_MAP3_INFO2_AST_HASH_VAL);
-		hw_peer_id = le32_get_bits(resp->peer_map_ev.info2,
-					   HTT_T2H_PEER_MAP3_INFO2_HW_PEER_ID);
-		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
-				      hw_peer_id);
-		break;
-	case HTT_T2H_MSG_TYPE_PEER_UNMAP:
-	case HTT_T2H_MSG_TYPE_PEER_UNMAP2:
-		peer_id = le32_get_bits(resp->peer_unmap_ev.info,
-					HTT_T2H_PEER_UNMAP_INFO_PEER_ID);
-		ath12k_peer_unmap_event(ab, peer_id);
-		break;
-	case HTT_T2H_MSG_TYPE_PPDU_STATS_IND:
-		ath12k_htt_pull_ppdu_stats(ab, skb);
-		break;
-	case HTT_T2H_MSG_TYPE_EXT_STATS_CONF:
-		ath12k_debugfs_htt_ext_stats_handler(ab, skb);
-		break;
-	case HTT_T2H_MSG_TYPE_MLO_TIMESTAMP_OFFSET_IND:
-		ath12k_htt_mlo_offset_event_handler(ab, skb);
-		break;
-	default:
-		ath12k_dbg(ab, ATH12K_DBG_DP_HTT, "dp_htt event %d not handled\n",
-			   type);
-		break;
-	}
-
-	dev_kfree_skb_any(skb);
-}
-EXPORT_SYMBOL(ath12k_dp_htt_htc_t2h_msg_handler);
-
 struct sk_buff *ath12k_dp_rx_get_msdu_last_buf(struct sk_buff_head *msdu_list,
 					       struct sk_buff *first)
 {
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 7bf70cef4365..6f56a56db097 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -384,8 +384,6 @@ void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id,
 				u8 tid, u32 ba_win_sz, u16 ssn,
 				enum hal_pn_type pn_type);
-void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
-				       struct sk_buff *skb);
 int ath12k_dp_rx_pdev_reo_setup(struct ath12k_base *ab);
 void ath12k_dp_rx_pdev_reo_cleanup(struct ath12k_base *ab);
 int ath12k_dp_rx_htt_setup(struct ath12k_base *ab);
@@ -410,10 +408,6 @@ u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc);
 u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
 			    struct hal_rx_desc *desc);
-int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
-			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
-				       const void *ptr, void *data),
-			   void *data);
 void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab,  struct hal_rx_desc *rx_desc,
 			       struct ath12k_dp_rx_info *rx_info);
 
-- 
2.34.1


