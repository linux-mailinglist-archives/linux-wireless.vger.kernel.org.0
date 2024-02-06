Return-Path: <linux-wireless+bounces-3206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B2984B105
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 10:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4685A285EE5
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A4612D151;
	Tue,  6 Feb 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VHRzC2pJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BB12CDA2
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211325; cv=none; b=dJimwGCbG8/jvo7RziAwQG7QDRqvyQm9qYFWJ70zVuRB0XChaTBVu5XVd45XZRUrbT8Q6mV711PctJdIQjQU1G4mh9GkO+lvSbgdXwWP4maOvqJ37Vk/WvJRwCYIytNMgiuCQh6R4ntxRrNBCqU65ZlDcKjouuUydtE0vhWzxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211325; c=relaxed/simple;
	bh=W8T7WR8Y5m2V5w6tPKlT99nLKYCWkraIbvA0apBU8Mc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYbpNaoLh4PzKFxa40b1Jzo+ONsBaMcSaRztePwrS5ncG9rc7YekuyppEEopg/YBgUFvfhrYw1eCnwxVxOH96Y9nHEE5+CNgXNrhT4+yPyoFm1kyvYXkXPLjto/vBuWk9F0xcZvpm0TW6kKSoWwCD5Sq3tExcbosbo4XZvw5BFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VHRzC2pJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4166xQRE014451;
	Tue, 6 Feb 2024 09:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=y9x/L9zBRAyTkONnTlLEDtK2szL6cwTn1TVFewVFbA8=; b=VH
	RzC2pJ9zDmojfTndwt1pGvVBBn2fxsTQ5az+hsp3xOeOwah7vJP9Ap0tU8hzARB2
	+O+BA/jHBWx4OjnKnmy0cF0DXjKTZBVuzT9e75fFB3theGQ+rX8ceVFwpHj9GURk
	L4aJ59AIpLfhi8pZVzvueU80eQ8tZwpR0STI2q7y48FyPVKoKSgJ19HZR27icavZ
	d5kPY0ky0hTkJGorJEvTqHFhW7rQsecbvTPiMoIwJsnViEDH0NpnZTeQ5wSQ4ioj
	6+90aGUg+9SjjtXGAjYqwtIny5v3uZZc550mE2qknW25JUBsIgcGkM0+w0z0cPLr
	4Zq8SttR0byZp/foXezA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3e7g0ggx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 09:21:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4169LvIN021340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 09:21:57 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 01:21:55 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 10/12] wifi: ath12k: Modify set and get antenna mac ops for single wiphy
Date: Tue, 6 Feb 2024 14:49:52 +0530
Message-ID: <20240206091954.4144454-11-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206091954.4144454-1-quic_ramess@quicinc.com>
References: <20240206091954.4144454-1-quic_ramess@quicinc.com>
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
X-Proofpoint-GUID: u6ghTtS7jtMuDVEAtYnTINYiHk9OGl6b
X-Proofpoint-ORIG-GUID: u6ghTtS7jtMuDVEAtYnTINYiHk9OGl6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060065

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
---
 drivers/net/wireless/ath/ath12k/mac.c | 37 ++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 617dd55e7d4e..a85468cc63da 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5010,6 +5010,13 @@ static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
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
 
@@ -6309,16 +6316,22 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
 static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	int antennas_rx = 0, antennas_tx = 0;
 	struct ath12k *ar;
+	int i;
 
 	ar = ath12k_ah_to_ar(ah, 0);
 
-	mutex_lock(&ar->conf_mutex);
-
-	*tx_ant = ar->cfg_tx_chainmask;
-	*rx_ant = ar->cfg_rx_chainmask;
+	for (i = 0; i < ah->num_radio; i++) {
+		mutex_lock(&ar->conf_mutex);
+		antennas_rx = max_t(u32, antennas_rx, ar->cfg_rx_chainmask);
+		antennas_tx = max_t(u32, antennas_tx, ar->cfg_tx_chainmask);
+		mutex_unlock(&ar->conf_mutex);
+		ar++;
+	}
 
-	mutex_unlock(&ar->conf_mutex);
+	*tx_ant = antennas_tx;
+	*rx_ant = antennas_rx;
 
 	return 0;
 }
@@ -6327,13 +6340,19 @@ static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
-	int ret;
+	int ret = 0;
+	int i;
 
 	ar = ath12k_ah_to_ar(ah, 0);
 
-	mutex_lock(&ar->conf_mutex);
-	ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
-	mutex_unlock(&ar->conf_mutex);
+	for (i = 0; i < ah->num_radio; i++) {
+		mutex_lock(&ar->conf_mutex);
+		ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
+		mutex_unlock(&ar->conf_mutex);
+		if (ret)
+			break;
+		ar++;
+	}
 
 	return ret;
 }
-- 
2.25.1


