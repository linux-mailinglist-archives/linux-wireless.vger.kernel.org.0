Return-Path: <linux-wireless+bounces-5734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E289453E
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 21:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3488C282A35
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA10481D1;
	Mon,  1 Apr 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GFVzas3G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6920DE7
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998341; cv=none; b=YBAqy1Qj6R4Nl+bfBhcF+nkpRKZwu+3qIRFp8y9NLsz93qnxiolXxeG7HaGR8c6UPUqa6Q3/PUBr2gTE9qAmzev1mHj6Uj0aLFttMMGjG/htOkTRKRzqSJYUvOmQYENZ38PnNs15+6Cbi5f9DfE2mBnAGxprhM3asQgjKd4xUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998341; c=relaxed/simple;
	bh=rsD84YOnKvf2lgyPri0ewpU67whkIPlIeJ5caZYah+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQwXpHZ8XX68auVKJgJtQNat7k3ZZbHHGl1z+yrfgAx0PUTcUAQzVp2kGtNNgPQffY7c9YXnp8y6ar7Yo60O6bBNBQnpAcu9nixd7tJZsdsTZKlT2q5UPYPh46ME9E3od1ywK3p5wYV/8SL3FHpMZGbQxIwqQwdFhNl5esMP9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GFVzas3G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431I7CtC020160;
	Mon, 1 Apr 2024 19:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=nanKbnJSsuowkVITDsuJPVgQfSSDbKZsutkB1IhlSxk=; b=GF
	Vzas3GwKn+3Y/fqbTrnp1tQ7xt3sFz0QCsy9z0mPjULAkiCQOWbVHz9bjVCdBEgz
	a70F3DNdjFx8pBR14r62fHvnk6TS9Fz+i9Rea2eGruxghVphZ8zXtF21SkjfOaub
	ldoOl9DrHCJc04C9q6ios5hV18SiB2nkd2WX1kvQNy4VjuJav+ixlv/YqT8OzSOR
	f9oqDsGr0p2QnPBgjwYhJBVstcKwnfc7A6GlSTO1RUe0TFDYyRPnd3GdrUTNCcBB
	oFviwBWXFNpS/Z1VdBHNQ1Sh3SbvUuvMvQBM5CAUU2Z7gnuacA3uCzPUtsikVszb
	FZQnrJadGwuy3d3Ou5MA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x81wdg40m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:05:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431J54HF004683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 19:05:04 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Apr 2024 12:05:00 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v6 02/12] wifi: ath12k: Modify add and remove chanctx ops for single wiphy support
Date: Tue, 2 Apr 2024 00:33:59 +0530
Message-ID: <20240401190409.2461819-3-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401190409.2461819-1-quic_ramess@quicinc.com>
References: <20240401190409.2461819-1-quic_ramess@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Mvwi3VA9xSY0ZxsVx438y0rVeD_DtEuu
X-Proofpoint-GUID: Mvwi3VA9xSY0ZxsVx438y0rVeD_DtEuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_13,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=802
 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404010134

From: Sriram R <quic_srirrama@quicinc.com>

Modify add and remove chanctx mac80211 ops to fetch the correct
radio(ar) based on channel context.

This change also introduces new helper function to fetch the
radio/ar based on channel context and ieee80211_chan which internally
uses the radio's low/high freq range.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  3 ++
 drivers/net/wireless/ath/ath12k/mac.c  | 50 ++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index f16bb7621a74..64ed12463402 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -598,6 +598,9 @@ struct ath12k {
 	bool monitor_vdev_created;
 	bool monitor_started;
 	int monitor_vdev_id;
+
+	u32 freq_low;
+	u32 freq_high;
 };
 
 struct ath12k_hw {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 94ab2e705f61..0fce3e7e06a4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -613,6 +613,35 @@ struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id)
 	return NULL;
 }
 
+static struct ath12k *ath12k_mac_get_ar_by_chan(struct ieee80211_hw *hw,
+						struct ieee80211_channel *channel)
+{
+	struct ath12k_hw *ah = hw->priv;
+	struct ath12k *ar;
+	int i;
+
+	ar = ah->radio;
+
+	if (ah->num_radio == 1)
+		return ar;
+
+	for_each_ar(ah, ar, i) {
+		if (channel->center_freq >= ar->freq_low &&
+		    channel->center_freq <= ar->freq_high)
+			return ar;
+	}
+	return NULL;
+}
+
+static struct ath12k *ath12k_get_ar_by_ctx(struct ieee80211_hw *hw,
+					   struct ieee80211_chanctx_conf *ctx)
+{
+	if (!ctx)
+		return NULL;
+
+	return ath12k_mac_get_ar_by_chan(hw, ctx->def.chan);
+}
+
 static void ath12k_pdev_caps_update(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -6229,11 +6258,13 @@ static int ath12k_mac_op_ampdu_action(struct ieee80211_hw *hw,
 static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 				     struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_ctx(hw, ctx);
+	if (!ar)
+		return -EINVAL;
+
 	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6257,11 +6288,13 @@ static int ath12k_mac_op_add_chanctx(struct ieee80211_hw *hw,
 static void ath12k_mac_op_remove_chanctx(struct ieee80211_hw *hw,
 					 struct ieee80211_chanctx_conf *ctx)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_ctx(hw, ctx);
+	if (!ar)
+		return;
+
 	ab = ar->ab;
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
@@ -6637,11 +6670,13 @@ static void ath12k_mac_op_change_chanctx(struct ieee80211_hw *hw,
 					 struct ieee80211_chanctx_conf *ctx,
 					 u32 changed)
 {
-	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar;
 	struct ath12k_base *ab;
 
-	ar = ath12k_ah_to_ar(ah, 0);
+	ar = ath12k_get_ar_by_ctx(hw, ctx);
+	if (!ar)
+		return;
+
 	ab = ar->ab;
 
 	mutex_lock(&ar->conf_mutex);
@@ -7643,6 +7678,9 @@ static void ath12k_mac_update_ch_list(struct ath12k *ar,
 		    band->channels[i].center_freq > freq_high)
 			band->channels[i].flags |= IEEE80211_CHAN_DISABLED;
 	}
+
+	ar->freq_low = freq_low;
+	ar->freq_high = freq_high;
 }
 
 static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
-- 
2.25.1


