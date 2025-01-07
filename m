Return-Path: <linux-wireless+bounces-17159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF512A0489F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 18:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A907916453C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA31C32EA;
	Tue,  7 Jan 2025 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ix6Ur7vY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A1A18DF6E
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272315; cv=none; b=GtI5mOiknJKCjyUxu8Mjlnn0CI0argxLoHgUSubO/EvMySA9ZagUNcCJ+2d7+738xJDimqgrBMYNzlkW7iXMu/LyjiK8xHM7Pjrzaw6L+NXkVLnLQZIw5A8qX3bSiVKrLal+dcmpNsPTIqZnrxnHGdpKrH1MxB/yzZPoM5CaTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272315; c=relaxed/simple;
	bh=YeXZoAHs932YkyktBvJV2q1SBtKPNHo/9JTe5RK8inA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8HSmh4EWyC6yvkGeLf0RiLCY49DgSwonbA16Xco+e3u9k+NfBaKtP3rkCuBZYKvo2HCyRQIJqyf7smxeYXN5q5GAbMYrzjtFfOMMw2huJeuxRWYppgIpTKRP0i7pyLwKu7s87cVAdQ7mYX4IgFJ7iHKmzqUGPiKluq0SyVkkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ix6Ur7vY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507Aff2a025752;
	Tue, 7 Jan 2025 17:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9524W5QiJiXDYEcWhjCt58Mr6APTPmjawGp7O7EmRZU=; b=Ix6Ur7vYzjU+s6yW
	iTw+wrBab0JGFsyHFx1Q1gsPObLijTLeRrqsPPMkODWsUyNQ9t7TnfaSAAvsD2/0
	48+NYUG3WsMQ6HNFR/5Ly+BazDlXCHk3A/SX/1e662nMw2wFcMYioLmE7CxQSknH
	1qE8skMmjubNTsTXGy8dBU6BZMBBlJ4nfdES4pu7rEAYY0VsZhGppZR+cfF+Hluw
	VjV3dxvR6bO32AVq0ImW1vFfBSPuqQ/d/pDqv/npEk6PaB7Yis/6zmC5vWuTy5+2
	mUrJkU5oXTt/r1zgul2JrBtiaEFHD3t3l5u9S50eyZ1zVUuP4TW58qtf9CGZmJRE
	KngxSw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4412r79382-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 17:51:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 507HpgBn021874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 17:51:42 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 09:51:40 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Ramasamy Kaliappan
	<quic_rkaliapp@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: update EMLSR capabilities of ML Station
Date: Tue, 7 Jan 2025 23:18:02 +0530
Message-ID: <20250107174802.1793252-4-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107174802.1793252-1-quic_ramess@quicinc.com>
References: <20250107174802.1793252-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JLE88H1OobBBV3gLUkMBX7v3YdpR6F_W
X-Proofpoint-ORIG-GUID: JLE88H1OobBBV3gLUkMBX7v3YdpR6F_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070148

From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>

When EMLSR operation is enabled for an ML Station, EMLSR transition
timeout, padding delay and transition delay should be updated to
Firmware. Above parameters will be used by Firmware to do EMLSR operation
such as sending EML operation mode notification frame, initial control
frame etc.
Obtain above parameters from EML capabilities information present in
ieee80211_sta object and update the same to Firmware in peer assoc WMI
command sent for ML station.
MLO is not enabled in WCN7850 and hence this change is not applicable to
it as of now. This can be a leverage once it is enabled in future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c |  3 +-
 drivers/net/wireless/ath/ath12k/wmi.c | 81 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h |  3 +-
 3 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6f10813d9378..14c9d76abdb6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <net/mac80211.h>
@@ -3045,6 +3045,7 @@ static void ath12k_peer_assoc_h_mlo(struct ath12k_link_sta *arsta,
 	ml->ml_peer_id = ahsta->ml_peer_id;
 	ml->ieee_link_id = arsta->link_id;
 	ml->num_partner_links = 0;
+	ml->eml_cap = sta->eml_cap;
 	links = ahsta->links_map;
 
 	rcu_read_lock();
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 562b0615ed06..d04473b4b399 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -2093,6 +2093,65 @@ static void ath12k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 		cmd->peer_flags &= cpu_to_le32(~WMI_PEER_HT);
 }
 
+#define EMLSR_PAD_DELAY_MAX	5
+#define EMLSR_TRANS_DELAY_MAX	6
+#define EML_TRANS_TIMEOUT_MAX	11
+#define TU_TO_USEC(t)		((t) << 10)  /* (t) x 1024 */
+
+static u32 ath12k_wmi_get_emlsr_pad_delay_us(u16 eml_cap)
+{
+	/* IEEE Std 802.11be-2024 Table 9-417i—Encoding of the EMLSR
+	 * Padding Delay subfield.
+	 */
+	u32 pad_delay = u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_PADDING_DELAY);
+	static const u32 pad_delay_us[EMLSR_PAD_DELAY_MAX] = {0, 32, 64, 128, 256};
+
+	if (pad_delay >= EMLSR_PAD_DELAY_MAX)
+		return 0;
+
+	return pad_delay_us[pad_delay];
+}
+
+static u32 ath12k_wmi_get_emlsr_trans_delay_us(u16 eml_cap)
+{
+	/* IEEE Std 802.11be-2024 Table 9-417j—Encoding of the EMLSR
+	 * Transition Delay subfield.
+	 */
+	u32 trans_delay = u16_get_bits(eml_cap,
+				       IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
+	static const u32 trans_delay_us[EMLSR_TRANS_DELAY_MAX] = {
+		0, 16, 32, 64, 128, 256
+	};
+
+	if (trans_delay >= EMLSR_TRANS_DELAY_MAX)
+		return 0;
+
+	return trans_delay_us[trans_delay];
+}
+
+static u32 ath12k_wmi_get_emlsr_trans_timeout_us(u16 eml_cap)
+{
+	/* IEEE Std 802.11be-2024 Table 9-417m—Encoding of the
+	 * Transition Timeout subfield.
+	 */
+	u8 timeout = u16_get_bits(eml_cap, IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
+	static const u32 trans_timeout_us[EML_TRANS_TIMEOUT_MAX] = {
+		0, 128, 256, 512,
+		TU_TO_USEC(1),
+		TU_TO_USEC((1U << 1)),
+		TU_TO_USEC((1U << 2)),
+		TU_TO_USEC((1U << 3)),
+		TU_TO_USEC((1U << 4)),
+		TU_TO_USEC((1U << 5)),
+		TU_TO_USEC((1U << 6)),
+	};
+
+	if (timeout >= EML_TRANS_TIMEOUT_MAX)
+		return 0;
+
+	return trans_timeout_us[timeout];
+}
+
 int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 				   struct ath12k_wmi_peer_assoc_arg *arg)
 {
@@ -2106,9 +2165,10 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	struct sk_buff *skb;
 	struct wmi_tlv *tlv;
 	void *ptr;
-	u32 peer_legacy_rates_align;
+	u32 peer_legacy_rates_align, eml_delay, eml_trans_timeout;
 	u32 peer_ht_rates_align;
 	int i, ret, len;
+	u16 eml_cap;
 	__le32 v;
 
 	peer_legacy_rates_align = roundup(arg->peer_legacy_rates.num_rates,
@@ -2280,6 +2340,23 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	ml_params->logical_link_idx = cpu_to_le32(arg->ml.logical_link_idx);
 	ml_params->ml_peer_id = cpu_to_le32(arg->ml.ml_peer_id);
 	ml_params->ieee_link_id = cpu_to_le32(arg->ml.ieee_link_id);
+
+	eml_cap = arg->ml.eml_cap;
+	if (u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_SUPP)) {
+		/* Padding delay */
+		eml_delay = ath12k_wmi_get_emlsr_pad_delay_us(eml_cap);
+		ml_params->emlsr_padding_delay_us = cpu_to_le32(eml_delay);
+		/* Transition delay */
+		eml_delay = ath12k_wmi_get_emlsr_trans_delay_us(eml_cap);
+		ml_params->emlsr_trans_delay_us = cpu_to_le32(eml_delay);
+		/* Transition timeout */
+		eml_trans_timeout = ath12k_wmi_get_emlsr_trans_timeout_us(eml_cap);
+		ml_params->emlsr_trans_timeout_us = cpu_to_le32(eml_trans_timeout);
+		ath12k_dbg(ar->ab, ATH12K_DBG_WMI, "wmi peer (%pM) emlsr padding delay %u, trans delay %u trans timeout %u",
+			   arg->peer_mac, ml_params->emlsr_padding_delay_us,
+			   ml_params->emlsr_trans_delay_us,
+			   ml_params->emlsr_trans_timeout_us);
+	}
 	ptr += sizeof(*ml_params);
 
 skip_ml_params:
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index b6a197389277..a6686f7792fb 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_WMI_H
@@ -3718,6 +3718,7 @@ struct peer_assoc_mlo_params {
 	u32 ieee_link_id;
 	u8 num_partner_links;
 	struct wmi_ml_partner_info partner_info[ATH12K_WMI_MLO_MAX_LINKS];
+	u16 eml_cap;
 };
 
 struct wmi_rate_set_arg {
-- 
2.34.1


