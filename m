Return-Path: <linux-wireless+bounces-28236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A565C07AF0
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 20:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B181C247DD
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1824BBEC;
	Fri, 24 Oct 2025 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BfFOD3Va"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FEF344037
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329784; cv=none; b=cKy3NhpvDBdH3x9vtJVodKGm5sOou+bXd6wPAyBH15lL2GuPSIU1uUKw4MIcrTFF70F3VhCc9eeUaRdoOAB9HVh2YCloItM2Fpbyff05BxXF+yeO63v3d+cKwgP8PZBU+5cR8mEDYMHoaz8rSRc7yX2F9ne/zn+rFp5dNtfu8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329784; c=relaxed/simple;
	bh=kYGFSTQMa5rYg6SCXR8hY1Iv9NwfVEYjUwIclqw3aZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TI0pDnrL9Tr+Mz0vRSnyTw68bEY+eOxtwsDtCu4GNLElCUEhjcnKxYHrZUHIt256yy+Sgjug/u0RNM3pmmamm6XuB05ZwduW7ja98qv+WhQHT2rvvuu3VWnagUeQDWK4SRM7qTPqLQiU9IHTLlckb0dxgUBQ9kNaB2zmfHMQm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BfFOD3Va; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9HuY028223;
	Fri, 24 Oct 2025 18:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+/pH9nFi6m8bAxoLzJ10u4Q1VOPz4fr3mkLB/CyxbKs=; b=BfFOD3VafmWOeLr8
	nWc2pxQuYpcnlkcsQ1I4tST7N9eR6c93wESqgPabKimsssafPJFHLzUs9zE2WtBt
	DVy+7yCEcHJXyuF3bX997Wt6BapX7LVexVwrqVa6qsrJwP4bwWyNf9PGwteBBjUu
	qIcaPxxZwVe18uyu98Tu3lvjhcjsGmWnho1KbKPtGmoIjb9vtfDPfaGbfyvuSnHV
	J617kJux8EOZYxMancbi7/kWLgH+3iJ5uHEF9wF2owWahoTY9uMiIYD+MbRr2N4i
	/UjFNmK6lHB9UInR1CTtONDkbMLM+4A8Y9+L4ZvrR48i4zpVSVR2JjM/wexgKgiI
	eUpSdA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qpvkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59OIGJea007004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 18:16:19 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Fri, 24 Oct 2025 11:16:18 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 9/9] wifi: ath12k: Add lockdep warn for RCU
Date: Fri, 24 Oct 2025 23:45:48 +0530
Message-ID: <20251024181548.3255166-10-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
References: <20251024181548.3255166-1-quic_rdeuri@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX1adU5iCm8WNq
 yOPuKqqeF9JX9vN55dVU5qR29w/CJxcNP479XNSNIIsxQyJAIClHYlzKoUyM/PvI8c2MqJNzr+v
 qGC/NlfMxkGqjaSsfeXbjNOqaDy6qx3+Qc2XH0c/O6Z6lSHv/SGA75N4KoyrpGpeyLlxzP8LuNJ
 sOtzRGqY2sFmB/5nTjr6uBKiB+FcKH5N8TXviXSi4VQtKdsZckcIl6kf2vxZFjv9xQQEoXPTFmQ
 yn7s6i9Ezs2+w9EVVJ/eCaSNTzXs/0Nty0vGgqcUJ8bP2puttyVPm2IcXONb5/MbLKQpmd7Akfb
 al8gTXMYw8IaU11lF7W5wv7+dSTziPCWBXoMD9J9TBL7izYJ4A9Qig0FprOpHBM/Tt9D8Lz73SN
 0zzRxWOjYrzTCIB0gPCPO+9Tf/2xig==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68fbc273 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=eG82KGEsS7oeUIB4lrIA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Gk46W9JyeORcM5OMRVxyKqKCfvBSrksc
X-Proofpoint-ORIG-GUID: Gk46W9JyeORcM5OMRVxyKqKCfvBSrksc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

Add RCU_LOCKDEP_WARN() in following functions:

  - ath12k_dp_link_peer_to_link_sta()
  - ath12k_wifi7_dp_rx_h_mpdu()

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_peer.c     | 3 +++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index 61478e66d9af..a06113bedf0d 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -182,6 +182,9 @@ struct ath12k_link_sta *ath12k_dp_link_peer_to_link_sta(struct ath12k_base *ab,
 	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
 
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+			 "ath12k_dp_link_peer to ath12k_link_sta called without rcu lock");
+
 	if (!peer->sta)
 		return NULL;
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 87875486fb4a..d24d0f12742e 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -323,6 +323,9 @@ static void ath12k_wifi7_dp_rx_h_mpdu(struct ath12k_pdev_dp *dp_pdev,
 	struct ieee80211_rx_status *rx_status = rx_info->rx_status;
 	u32 err_bitmap = rx_info->err_bitmap;
 
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+			 "dp_rx_h_mpdu called without rcu lock");
+
 	/* PN for multicast packets will be checked in mac80211 */
 	rxcb = ATH12K_SKB_RXCB(msdu);
 	rxcb->is_mcbc = rx_info->is_mcbc;
-- 
2.34.1


