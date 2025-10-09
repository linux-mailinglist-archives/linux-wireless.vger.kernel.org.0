Return-Path: <linux-wireless+bounces-27925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E05DBCAE5C
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 23:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254871A61D06
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FAC280325;
	Thu,  9 Oct 2025 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MKh5oHhE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AA28134F
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044641; cv=none; b=HdcJpIco2Ll6EvVnVkG7o42cfPqL/Z1R2UNg7/WBeyI0QwcFVzMH4bpuHHTtOr1YxKAunjh8hscquUm+mIuvqPyYnY3BOB0B9qcnapkuyyuDDDnyoYdFXJfui1xZUduXRJJZMYusUP0VE3BRTLCQI9eDsCPU4WoDkP9p/a5OtwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044641; c=relaxed/simple;
	bh=kwG+In465JAv44jHDQLS1ih/6cATPcTBIHlnpjVml5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fE8SobUMbnjXAf0H+FxSq4MGmnFhkfToU4IEp6JoYK4qGHy9+qxEcbe6rsaMsBA8Wlgbp5KfVO6LGeJxYC352gLSDbFQzUDxp9traryzUNtSiyZZzbV1T7O/MI7sWmLicIIpd/QGVtfPdEsHTJghciaSjlL+ZkcP0oM6iFHIxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MKh5oHhE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599GZU9l031740;
	Thu, 9 Oct 2025 21:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4OyrjX9M+eaDDKGCBcaZ9qXgXVQoupo9+BYaim7sEa4=; b=MKh5oHhEHV0gyjCI
	wdwTU0kf1U1NOiBJ7iHAHp1ODKl1aXgS/phHjGMYeKHhbLS9klFW0v/Z02IWJJex
	Ybi/JlePVGwBT6fEPnFDKfWd5BOyjUPdnitjZmoQV1gFy2Dh0lDm9K+mUmnn8rs3
	wKEdsBLF6y8UlauixejIZ7sdtl6pecdT3ZWfp1u1gpQgr/hpEY2PrfhvNzSg1fIc
	gO0+7hkHBtDjp4juSHygHIuXhAOcdxUu0rdEwssgxJ2yk0oELskOTSNDdaAZMRa5
	qaDYyDHJJ2PLHRe+URn0BFZoDbqhXmocQ47v/MQlm/vY+S/SwdxJfR3MxwbhhxBY
	3/aj3w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49p9m0t96b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 21:17:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 599LHAh0021772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Oct 2025 21:17:10 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 9 Oct 2025 14:17:09 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [ath-next V17 1/2] wifi: ath12k: fix VHT MCS assignment
Date: Thu, 9 Oct 2025 14:16:55 -0700
Message-ID: <20251009211656.2386085-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
References: <20251009211656.2386085-1-quic_pradeepc@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=a/U9NESF c=1 sm=1 tr=0 ts=68e82657 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=6RPXMQUKQ7Vie2blHvEA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Hj-y1GsTEkTAcJmveiwZGCnwvnwYk2K3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA0NyBTYWx0ZWRfXx+dd8nQa/Ej9
 5AENKTYoVEXHC6d54DZoaKb25iAgnVakhNuM+Dbqlx0zmZBN2OxefZpWLlqAa3faGlBkVDmJAkM
 +5/A7LqvJPWsli2MPLbULkBrxdCVXOW9QkrwlBapZpK7HYjOH/FKuVjOyBagh5ymPo3ONtIrv5S
 O4Iwd8K41KjclfVmTWouDpvVqbA5cwNbSwwNe93cJfq29SZk+fXwf0xiT3c4YUDwehC8Si5PeYr
 KxZD+ZGp8WQ5f2dd0QQBmqu4kqYCiD/rD+AWJyPFo44nhrOjjFPGhUJ2jGZHXbLlYyMgPZ7Jm1P
 FelWuD7N1Td4V9Ppl6Wo+Iei4JW34ts4WhMKKxVBJ/G+9K+tpE1A5maBoyvdMybx45a/cD8hQ/p
 oHXyq3JH4zo1u8/Vs4QvraQJVu5mQA==
X-Proofpoint-ORIG-GUID: Hj-y1GsTEkTAcJmveiwZGCnwvnwYk2K3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510090047

From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

While associating, firmware needs the peer's receive capability
to calculate its own VHT transmit MCS. Currently, the host
sends this information via mcs->rx_mcs_set field, but firmware
actually reads it from mcs->tx_mcs_set field. This mismatch is
incorrect.

This issue has not caused failures so far because most peers
advertise identical TX and RX capabilities. Fix this by
assigning the value to tx_mcs_set as expected.

Additionally, the rate control mask is intended to limit our
transmit MCS, so it should also apply to the peer's receive
capability. Update the logic accordingly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c |  7 +++----
 drivers/net/wireless/ath/ath12k/wmi.c | 13 ++++++++-----
 drivers/net/wireless/ath/ath12k/wmi.h |  4 +++-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 1d7b60aa5cb0..0d425a1bc0ab 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2249,7 +2249,6 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	struct cfg80211_chan_def def;
 	enum nl80211_band band;
 	u16 *vht_mcs_mask;
-	u16 tx_mcs_map;
 	u8 ampdu_factor;
 	u8 max_nss, vht_mcs;
 	int i, vht_nss, nss_idx;
@@ -2340,10 +2339,10 @@ static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
 	arg->peer_nss = min(link_sta->rx_nss, max_nss);
 	arg->rx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.rx_highest);
 	arg->rx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.rx_mcs_map);
-	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
+	arg->rx_mcs_set = ath12k_peer_assoc_h_vht_limit(arg->rx_mcs_set, vht_mcs_mask);
 
-	tx_mcs_map = __le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map);
-	arg->tx_mcs_set = ath12k_peer_assoc_h_vht_limit(tx_mcs_map, vht_mcs_mask);
+	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
+	arg->tx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map);
 
 	/* In QCN9274 platform, VHT MCS rate 10 and 11 is enabled by default.
 	 * VHT MCS rate 10 and 11 is not supported in 11ac standard.
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ff6b3d4ea820..e76275bd6916 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -2367,10 +2367,13 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 	cmd->peer_bw_rxnss_override |= cpu_to_le32(arg->peer_bw_rxnss_override);
 
 	if (arg->vht_capable) {
-		mcs->rx_max_rate = cpu_to_le32(arg->rx_max_rate);
-		mcs->rx_mcs_set = cpu_to_le32(arg->rx_mcs_set);
-		mcs->tx_max_rate = cpu_to_le32(arg->tx_max_rate);
-		mcs->tx_mcs_set = cpu_to_le32(arg->tx_mcs_set);
+		/* Firmware interprets mcs->tx_mcs_set field as peer's
+		 * RX capability
+		 */
+		mcs->rx_max_rate = cpu_to_le32(arg->tx_max_rate);
+		mcs->rx_mcs_set = cpu_to_le32(arg->tx_mcs_set);
+		mcs->tx_max_rate = cpu_to_le32(arg->rx_max_rate);
+		mcs->tx_mcs_set = cpu_to_le32(arg->rx_mcs_set);
 	}
 
 	/* HE Rates */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index a8c3190e8ad9..4d620501179f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_WMI_H
@@ -4218,8 +4218,10 @@ struct wmi_unit_test_cmd {
 struct ath12k_wmi_vht_rate_set_params {
 	__le32 tlv_header;
 	__le32 rx_max_rate;
+	/* MCS at which the peer can transmit */
 	__le32 rx_mcs_set;
 	__le32 tx_max_rate;
+	/* MCS at which the peer can receive */
 	__le32 tx_mcs_set;
 	__le32 tx_max_mcs_nss;
 } __packed;

base-commit: 94aced6ed9e2630bae0b5631e384a5302c4b6783
-- 
2.43.0


