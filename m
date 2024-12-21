Return-Path: <linux-wireless+bounces-16670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDED99F9E3E
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 05:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445037A2EE6
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 04:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680A61D88CA;
	Sat, 21 Dec 2024 04:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Db+maosc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3911E9B0E
	for <linux-wireless@vger.kernel.org>; Sat, 21 Dec 2024 04:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734755473; cv=none; b=e6fGgpy1pgUxWiLlZ02eNwcAUX1Oh5VNkI0GCjOMSiuiAdNYL+liuZsraZsjFQwQEIrkzWM6HXNyjo+m6Q2pv6hluu0vuGnedTNYItNjhKlbqVJNJeSL0x9cZCbdyVXZnhXUxLfNgP6WlXsbtSrSSeh91q+JrtCOj1Jk/tGsJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734755473; c=relaxed/simple;
	bh=72nv7hCRqqe8+yjzu4gCmOn3yENDii5iDGPEb6t4ZRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCsS43+yMY0in98OS5wVa8Aepdx8MZX71oA8+RetlkapvEanLeMBlS2cLx2DlI+/U3C87kY2FJSZSYEYBh4m2qVK8OW5GmVlm7Quz8DAKHi3e9zzl4IODh0cMpgREvImO3V3vckacQUZqXWmspyBRi6z0a6AKbE9/6bBFJAd6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Db+maosc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL28llS031416;
	Sat, 21 Dec 2024 04:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SqAw2TxIxPHAeJOMdvLSqecWSyqJN6CmDyY+byX0Mws=; b=Db+maoscwlu5Qh/t
	tk+OAsxtN3/HeO29jUSK+RwUwcgeetL4KIICc5OiOQ+gJ/fAlJGQY+jAO/d3OOja
	+pvW54si1It+zPdOalRzZ70Mpxw6HY52047qOSoOsEq/9xXmZ9MBRbYRF+PwB8o3
	RF38B4InM3dZ/ExW7dP0NHo4hknG5UHOBAD5IDxiRumJTxCsnhCDpTDl3QT9SYDM
	qKnjYgKR7/WRHAaDP0R0QEWKwlClBRRMIh6oFNoumPUst4eEfldA9tgvtvCPPn0+
	XlNNvnnaGz3YTgXT+rRVT7zuQCTQORsX8ETViUUMJMAp0JgGa1BvkmTWKPSsWhtp
	wdSXpQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43nmmqg9ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:31:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BL4V9dw016287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 04:31:09 GMT
Received: from hu-ppranees-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Dec 2024 20:31:07 -0800
From: P Praneesh <quic_ppranees@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
Subject: [PATCH 03/14] wifi: ath12k: Avoid multiple times configuring monitor filter
Date: Sat, 21 Dec 2024 10:00:03 +0530
Message-ID: <20241221043014.1252841-4-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
References: <20241221043014.1252841-1-quic_ppranees@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1MhncpIhVHoWlUlUt-Mo6MG75ReoEPYQ
X-Proofpoint-ORIG-GUID: 1MhncpIhVHoWlUlUt-Mo6MG75ReoEPYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=955 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210035

ath12k_mac_op_configure_filter() gets called multiple times during
interface bringup. Applying filter configuration from this function leads
to writing same filter configurations multiple times.

Fix it by moving the filter configuration to ath12k_mac_op_start().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 55 ++++++++++++++-------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6f10813d9378..2cb6e9b529d7 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7237,8 +7237,34 @@ void ath12k_mac_drain_tx(struct ath12k *ar)
 
 static int ath12k_mac_config_mon_status_default(struct ath12k *ar, bool enable)
 {
-	return -EOPNOTSUPP;
-	/* TODO: Need to support new monitor mode */
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
+	struct ath12k_base *ab = ar->ab;
+	u32 ring_id, i;
+	int ret = 0;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	if (!ab->hw_params->rxdma1_enable)
+		return ret;
+
+	if (enable)
+		tlv_filter = ath12k_mac_mon_status_filter_default;
+
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+		ring_id = ar->dp.rxdma_mon_dst_ring[i].ring_id;
+		ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id,
+						       ar->dp.mac_id + i,
+						       HAL_RXDMA_MONITOR_DST,
+						       DP_RXDMA_REFILL_RING_SIZE,
+						       &tlv_filter);
+		if (ret) {
+			ath12k_err(ab,
+				   "failed to setup filter for monitor buf %d\n",
+				   ret);
+		}
+	}
+
+	return ret;
 }
 
 static int ath12k_mac_start(struct ath12k *ar)
@@ -8363,29 +8389,6 @@ static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	FIF_PROBE_REQ |				\
 	FIF_FCSFAIL)
 
-static void ath12k_mac_configure_filter(struct ath12k *ar,
-					unsigned int total_flags)
-{
-	bool reset_flag;
-	int ret;
-
-	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
-
-	ar->filter_flags = total_flags;
-
-	/* For monitor mode */
-	reset_flag = !(ar->filter_flags & FIF_BCN_PRBRESP_PROMISC);
-
-	ret = ath12k_dp_tx_htt_monitor_mode_ring_config(ar, reset_flag);
-	if (ret)
-		ath12k_warn(ar->ab,
-			    "fail to set monitor filter: %d\n", ret);
-
-	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
-		   "total_flags:0x%x, reset_flag:%d\n",
-		   total_flags, reset_flag);
-}
-
 static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 					   unsigned int changed_flags,
 					   unsigned int *total_flags,
@@ -8399,7 +8402,7 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 	ar = ath12k_ah_to_ar(ah, 0);
 
 	*total_flags &= SUPPORTED_FILTERS;
-	ath12k_mac_configure_filter(ar, *total_flags);
+	ar->filter_flags = *total_flags;
 }
 
 static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
-- 
2.34.1


