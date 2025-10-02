Return-Path: <linux-wireless+bounces-27769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4315FBB21B3
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 02:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC8C3C7E49
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2E7469D;
	Thu,  2 Oct 2025 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mLoNPIyK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C216AA41
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759363671; cv=none; b=dNUwF2OE2SOfA64O/vdQncSnc6qtsVc8whCN8IdtDwCo4YJJUbjcIThOCO9WldvqvSPQAqlEMPRsi1WsYmmjnw9UlqcaBu+UJ9Cp5d6ZVlubpebE54MtPNY9YqNvqxGME52X81M6YurjnLE2JGZkRF3xOaoY1WJ8ZYiyHPRAEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759363671; c=relaxed/simple;
	bh=FJpB2WKIfhuNaKTFugCEZ2d0v/OiSGKFEh4IqZlqbhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxIMgSVKNfncIfk0W04uiITB3gH8YKNJ8jmHaeHlNAtnwqY9p4jxyd5VxoRlgyZPqvxBluNr/g1tRiYtFJDXcW/pgm9Rz9M+OR2YDA6Q8p1DNyAuj7jbNNMKYUyxEnV+DNoqKRVlB0Dlo/OLuWkCQ4okLKWnRFA3YdGzNLfimQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mLoNPIyK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcPSE008917;
	Thu, 2 Oct 2025 00:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QcLA44Sh7+5osYfFI3KA1Od5a9Pwr4j27N37mg9Hngw=; b=mLoNPIyKMS1z7Nf7
	l348LX4Yxn1M65/KSrMm8Wwy9n3xsRs6k3HGpXziXKbHc9MBx6eI+a14jCike05r
	H2cDmSvNnVOzWbDU6Jy7yfWV2TDg9oPNLobm9sZxazJnJcoZt81vkUAr9jv6ueNR
	LsCUyMPfnYs8yagwrBPDyup0XbY/8JHW7PhTJYorrlK61NHbnUFRLZk4mkaZrhmq
	cfSJuBsNFfLhvYT3kb82SFBXfxWmcJhM+GjIUK+P0hcaxqQ7ghwAVlErLqK1xEIf
	A+pE4lAksjEMwcBVAii9yew2KPEalwvWBeTBFU1WlKSDG50mhYkduL+FK4TSPGeu
	El72Mg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr9mky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Oct 2025 00:07:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59207h7x013975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Oct 2025 00:07:43 GMT
Received: from ath12k-linux2.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 1 Oct 2025 17:07:43 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH ath-next V16 1/2] wifi: ath12k: fix VHT MCS assignment
Date: Wed, 1 Oct 2025 17:07:31 -0700
Message-ID: <20251002000732.1916364-2-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002000732.1916364-1-quic_pradeepc@quicinc.com>
References: <20251002000732.1916364-1-quic_pradeepc@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfX8myFKW6QqNE/
 K2iicB/Iw7FjbbrFYqT1hGnune9CapZQH7/0+NLaQMp7m2rJEugoOIBZwGlmafSnfVfBcjgq4lL
 YVJEJmTQyN9Q3EWRHOWdcd+wji5qIgw0ipKsGZ/KRzolhGgESjeBaDokUN/rXzSWCFh0khyMyxX
 wo+ScUNFm7/sZ/SIUz8qN1i5HIMCmelIZk8BpjHC6PF/jQ1wZvhp4LchotoSksu3k5n9+dB6+O/
 QSQsnxt3gPq2QUm8EoFwiPRM8VG/O6NvcS78KFqc1lfRLVHZ3fLptRGqo6Lq18laxy66Xo1lfVE
 zvwZiDGTzsH/jXqRDAwc4v+LnIY+5zVVajSgsstuPuMjXkQVjzDVZEdZkuS0IsK93fjnpwymXsL
 ihoSlnzYUvQsZjrHCiQSMZ5mEBt/sw==
X-Proofpoint-ORIG-GUID: bfWdL4i5czsvNfXdj_Wj-84DCKW0APjJ
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68ddc250 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=gQ9akJjMQTIzWUv7pj0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bfWdL4i5czsvNfXdj_Wj-84DCKW0APjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082

From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

While associating, firmware needs the peer's receive capability
to calculate its own VHT transmit MCS. Currently, the host
sends this information via mcs->rx_mcs_set field, but firmware
actually reads it from mcs->tx_mcs_set field. Thjis mismatch is
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
 drivers/net/wireless/ath/ath12k/wmi.c | 11 +++++++----
 drivers/net/wireless/ath/ath12k/wmi.h |  2 ++
 3 files changed, 12 insertions(+), 8 deletions(-)

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
index ff6b3d4ea820..2682d89afd44 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
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
index a8c3190e8ad9..6d9c645e3d5d 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
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
-- 
2.43.0


