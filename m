Return-Path: <linux-wireless+bounces-5928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D9089A52D
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 21:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E23E1F22B30
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AA4174EC3;
	Fri,  5 Apr 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZXfTdph2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A56173353
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346363; cv=none; b=aoXG2C9xYxMMQCxLWSKV4LkMRO2HKiFHcjXo7/brfynvWSrfkH1y5oW3EmMC2K8NSm1NNkokpc/izrPzmdVfoO1Vs/euD361nOfnPZd3g2plpf6KfAWM3HMKNJPUmVNqbWU1kIB5/RaYL4m30iueo99PfJtEwk7irEHODOG6tG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346363; c=relaxed/simple;
	bh=YPlhxEzj333f6ajyZ+Cdw+gtEV3kSIK6LHx7GiQG6w0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkYaRi5inmhT8FQR6h+rM/GKcFktP4Z2o1uz3YiGobX/sEyAtNk9yOkv8ukw3CIiN7eEDmEupRGgV+DMwzng2ZMkCucfuNYrOEjZgSWNO8xEsXTmZ+HHzUjCwLJhpV+oQIPLdyG2HQGEmS5i3GnsLSjnLuje10lpYURR5PkT6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZXfTdph2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435Is7Rj012300;
	Fri, 5 Apr 2024 19:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=wLy8La/NFM4fggRVySYNQ+EWp0JN1ZURN5WiaEP2poU=; b=ZX
	fTdph2GPHb2wRHW9PhxfVUi4cXOm94PJMx0SMcQneRehZKDitJ542Z2dfMaV32CV
	0ni69Bhejf/zT+uONaxy4DJB6pJfC4hAomi6vZZnuOTCKdYAUrqA2K+/Ua8gyJ5L
	Oyk0ROy7qLR6m9e/zRse3iiaCbZPH7zkH6QN1msT5viSm9D18NCS//n7uA3PkMt4
	+4QwKsM77nTKiAxxejkuWo2ImLS15MrgCmjWdbzX08D0VgAur2zlRJ1q7NT3fASR
	5NvhHl1M7BfKRQU2ZFkURRrkcUgz9FvvnB727PPUfjcax5CA35sE+rxwKqo++9tr
	/75jo5cmaG55Tce53OWA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xahgt0y19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 19:45:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435Jjv5t011691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 19:45:57 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Apr 2024 12:45:54 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v7 10/12] wifi: ath12k: Modify set and get antenna mac ops for single wiphy
Date: Sat, 6 Apr 2024 01:15:17 +0530
Message-ID: <20240405194519.1337906-11-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405194519.1337906-1-quic_ramess@quicinc.com>
References: <20240405194519.1337906-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: VG2alNrfokH9iWj7VH6Q-nkbi6MEYXZP
X-Proofpoint-ORIG-GUID: VG2alNrfokH9iWj7VH6Q-nkbi6MEYXZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_21,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050138

From: Sriram R <quic_srirrama@quicinc.com>

As multiple radios are combined into a single wiphy, and
the current infrastructure supports only set/get antenna
for the wiphy, the max Tx/Rx antenna capability is advertised
during wiphy register.
Hence, When antenna set/get is received we adjust the set/get
based on max radio capability and set/get antenna accordingly.

Multi radio capability needs to introduced with interface
combination changes to support single wiphy model in cfg80211
which would help extend the wiphy specific get/set configs similar
to this to per hw level.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 39 ++++++++++++++++++---------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index c3ecf9b62139..77abd46a69d3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5210,6 +5210,13 @@ static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
 	if (ath12k_check_chain_mask(ar, rx_ant, false))
 		return -EINVAL;
 
+	/* Since we advertised the max cap of all radios combined during wiphy
+	 * registration, ensure we don't set the antenna config higher than the
+	 * limits
+	 */
+	tx_ant = min_t(u32, tx_ant, ar->pdev->cap.tx_chain_mask);
+	rx_ant = min_t(u32, rx_ant, ar->pdev->cap.rx_chain_mask);
+
 	ar->cfg_tx_chainmask = tx_ant;
 	ar->cfg_rx_chainmask = rx_ant;
 
@@ -6519,16 +6526,19 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	int antennas_rx = 0, antennas_tx = 0;
 	struct ath12k *ar;
+	int i;
 
-	ar = ath12k_ah_to_ar(ah, 0);
-
-	mutex_lock(&ar->conf_mutex);
-
-	*tx_ant = ar->cfg_tx_chainmask;
-	*rx_ant = ar->cfg_rx_chainmask;
+	for_each_ar(ah, ar, i) {
+		mutex_lock(&ar->conf_mutex);
+		antennas_rx = max_t(u32, antennas_rx, ar->cfg_rx_chainmask);
+		antennas_tx = max_t(u32, antennas_tx, ar->cfg_tx_chainmask);
+		mutex_unlock(&ar->conf_mutex);
+	}
 
-	mutex_unlock(&ar->conf_mutex);
+	*tx_ant = antennas_tx;
+	*rx_ant = antennas_rx;
 
 	return 0;
 }
@@ -6537,13 +6547,16 @@ static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
-	int ret;
-
-	ar = ath12k_ah_to_ar(ah, 0);
+	int ret = 0;
+	int i;
 
-	mutex_lock(&ar->conf_mutex);
-	ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
-	mutex_unlock(&ar->conf_mutex);
+	for_each_ar(ah, ar, i) {
+		mutex_lock(&ar->conf_mutex);
+		ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
+		mutex_unlock(&ar->conf_mutex);
+		if (ret)
+			break;
+	}
 
 	return ret;
 }
-- 
2.25.1


