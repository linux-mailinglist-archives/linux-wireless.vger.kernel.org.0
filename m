Return-Path: <linux-wireless+bounces-5018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864888817AF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E861C21455
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212F984A43;
	Wed, 20 Mar 2024 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IqlH0VIp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8358C85929
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961845; cv=none; b=JrI3G/ldAJz+Yywy8IaxvvR9hihw/lal+v1v7C3+cckEj+v1A1R4+CqeLk7cDhVdNfzLjTbfIX2wYecmv8k2Ep7YEfkEy6JjaAwHPerJ9YKwNSrpw7xkP4jpM82Oofxfa75vBDhGu+7mhpsDsEQ/5fTUQJEck/oyn60culhJNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961845; c=relaxed/simple;
	bh=lSoshHyvHGSq7A/JCvsVE7eSsdMBH9uiTkexl2vXJHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awhwOWBdXhEYg7k1uzcEP6Tbp8qrkhhE+zTYBMjxkXRS8icKt8IJlHfSKKd6AgNWnqCNaK71MxV6akqvr45uL6xRWLfFKCRhQUOQws6rMjwJfhtBBhEBFi5bHMKt7jtdm5W/niKRNM0xCkYZpCKiyTpfytcbbhNClO0h5WbAh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IqlH0VIp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KGVp7Y021300;
	Wed, 20 Mar 2024 19:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=HxUvI4C7R3EOQoQSqh77TdXKUby05m4zmtz893RyPEk=; b=Iq
	lH0VIpUKyd+VUwCkxhvD4/zAjcH6bdtHifkhjFtq3lNk9/sjE9gNMpuQn8B2cSvk
	FNZBeGM5DDa3drxvNKhprheL242Z2pOVly+Cgir0Pgi5RCPvZmrc0evSFeUZ2+3Q
	Em+yzf6QlfLJ8K5zD/JSb+/I3IpU841fYRKMD/JWoUsabHtWoL6E8LXAwu2jhXNl
	F1oul094l5m/BfsVIZ8txxeTqUbk/pvuy+KfC3an11uV1Mc7/ujYbQ7zgcF+oQEe
	2kuw0JbCMSLyt+UnWmWCiRnx7Gav8nUn8J7tFimq6d67SqLdki/8s5myvR9oBuzV
	Kopzlv2rzSXZVGL+On5Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyvrmsd5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 19:10:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KJALSj005441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 19:10:21 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 12:10:18 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v5 10/12] wifi: ath12k: Modify set and get antenna mac ops for single wiphy
Date: Thu, 21 Mar 2024 00:39:41 +0530
Message-ID: <20240320190943.3850106-11-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320190943.3850106-1-quic_ramess@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: QdpdFswS-tgWy9IEOh5cF7O1A_mz5FWi
X-Proofpoint-GUID: QdpdFswS-tgWy9IEOh5cF7O1A_mz5FWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403200154

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
index cb3318f94636..fffab1f75fc4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5199,6 +5199,13 @@ static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
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
 
@@ -6520,16 +6527,19 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
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
@@ -6538,13 +6548,16 @@ static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx
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


