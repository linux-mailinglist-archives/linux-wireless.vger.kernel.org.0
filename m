Return-Path: <linux-wireless+bounces-4614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED57A87956E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 14:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94542804DE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FFB7AE40;
	Tue, 12 Mar 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lebN4CG2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4607A72D
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710251787; cv=none; b=Q5pDimR6aV7PtTbzhCiCJsjeebgt5v39Zp30//XjXG9FgI84ndfBn8qe8Grs55FtOQDRLUM6q94I59PN3EjnbPdzblgISrS2CLw0vhogheKRmsqBH4PhT9Jw65P3snyJYMqd5iouOnga5yaQxJoCSTM2Kq7sFauoJfiGOUSK0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710251787; c=relaxed/simple;
	bh=pP+F346gzmBNM+pUXvYb82j0uudNKIjxNnoKc1qiUac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Snm/lqN7hZbmiyilF81V3dzT7Sv3qrng2yYER68NQ331zU7CkB1uqsFMA0jnPW54dnXMugbmOoCXOMaw28yJrMcOAzPL89gkmGm7jt+ju6KWYZjLA8ikGt4Iu1NzC70HZwV6Gv7KOnr0nn380tXdWsS5YRjYqyBDaSom9fEnDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lebN4CG2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C9TR4g031824;
	Tue, 12 Mar 2024 13:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=DMtgGTXV36aVwnH5bQZ6aegQHKRDge1F8hNfJoSoY2E=; b=le
	bN4CG2QFRBjG42kIkIfvscxZujfgAWpRcbZVEJGNL5LB7JiMieKrgDOndFfuLrAS
	1IH3hRfp3W1KV1jXmTW2oesVn0GGZKjxOyONEF1xn80azH4lZAPRXdqR0q4VMPUU
	sAVRyq1GLcayVCxbZjqfCFKw9lLhkqqkCRH1CJVYKlMlhSn6xiMpUiIkc6uNql9l
	fyNuP8CrDSKf4lA68/1/8syZ0sqvTnw1W/aOHxuc1SCWDq9URFGs75PPKMHJHpbn
	zE0fuOTlVag4AQsYrCPnhGZgsqyKZmbK5PEpl6F/Z5755BF7/WH8iwz/gUsirXsn
	lQj41oDxB8PpoebgqStQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtmewghp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 13:56:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CDuLep002668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 13:56:21 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 06:56:20 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v4 03/12] wifi: ath12k: modify ath12k mac start/stop ops for single wiphy
Date: Tue, 12 Mar 2024 19:25:48 +0530
Message-ID: <20240312135557.1778379-4-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312135557.1778379-1-quic_ramess@quicinc.com>
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: _LKw3DnWLS7xLSE5CrfODYMV5UVtWYCJ
X-Proofpoint-GUID: _LKw3DnWLS7xLSE5CrfODYMV5UVtWYCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=811 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120107

From: Sriram R <quic_srirrama@quicinc.com>

When mac80211 does drv start/stop, apply the state change
for all the radios within the wiphy in ath12k.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 43 +++++++++++++++++++--------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 0f33f5615170..4afaba3ba934 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -243,6 +243,7 @@ static const u32 ath12k_smps_map[] = {
 
 static int ath12k_start_vdev_delay(struct ath12k *ar,
 				   struct ath12k_vif *arvif);
+static void ath12k_mac_stop(struct ath12k *ar);
 
 static const char *ath12k_mac_phymode_str(enum wmi_phy_mode mode)
 {
@@ -5472,23 +5473,39 @@ static int ath12k_mac_start(struct ath12k *ar)
 	return ret;
 }
 
+static void ath12k_drain_tx(struct ath12k_hw *ah)
+{
+	struct ath12k *ar;
+	int i;
+
+	for_each_ar(i, ah, ar)
+		ath12k_mac_drain_tx(ar);
+}
+
 static int ath12k_mac_op_start(struct ieee80211_hw *hw)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
-	struct ath12k_base *ab = ar->ab;
-	int ret;
+	struct ath12k *ar;
+	int ret, i;
 
-	ath12k_mac_drain_tx(ar);
+	ath12k_drain_tx(ah);
 
-	ret = ath12k_mac_start(ar);
-	if (ret) {
-		ath12k_err(ab, "fail to start mac operations in pdev idx %d ret %d\n",
-			   ar->pdev_idx, ret);
-		return ret;
+	for_each_ar(i, ah, ar) {
+		ret = ath12k_mac_start(ar);
+		if (ret) {
+			ath12k_err(ar->ab, "fail to start mac operations in pdev idx %d ret %d\n",
+				   ar->pdev_idx, ret);
+			goto fail_start;
+		}
 	}
 
 	return 0;
+fail_start:
+	for (; i > 0; i--) {
+		ar = ath12k_ah_to_ar(ah, i);
+		ath12k_mac_stop(ar);
+	}
+	return ret;
 }
 
 int ath12k_mac_rfkill_config(struct ath12k *ar)
@@ -5584,11 +5601,13 @@ static void ath12k_mac_stop(struct ath12k *ar)
 static void ath12k_mac_op_stop(struct ieee80211_hw *hw)
 {
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
-	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
+	struct ath12k *ar;
+	int i;
 
-	ath12k_mac_drain_tx(ar);
+	ath12k_drain_tx(ah);
 
-	ath12k_mac_stop(ar);
+	for_each_ar(i, ah, ar)
+		ath12k_mac_stop(ar);
 }
 
 static u8
-- 
2.25.1


