Return-Path: <linux-wireless+bounces-21697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157A8A93030
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 04:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E028E3528
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D923ED5A;
	Fri, 18 Apr 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p0c4tXlQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B22686B1;
	Fri, 18 Apr 2025 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944972; cv=none; b=iQthHSQHG5klUXhnJaSKYfivpzTun7rvFEGn6ZTTWIuzcOgbK86J7RFNclvPudNqSPrM068JcmFh2Ndfh04gzT9SFgevzR2FaTZOHLirIBk405D4tIfjh2oQ4UtPmHO8r0+oif2hKxTPCZLsAv+0eqU88KMKGMAkm5jYZHKdrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944972; c=relaxed/simple;
	bh=mldp0MXGNEqAUd3xfL4Mhrkv6zKafLDtq+EXsyMvJQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jfQSH4MlJBSMzezivwcSYRywSXSuBC/5ObTJCQG4d6YxTticFGNmE8wm1u4pmA8CCmn6ib2E6IH8BLAXkgXAAkU9OpJjXk1BwdnVehzzVVcRKrYKxA9r636sfcvGTjvpGMPxPfjV8Wzc/KezQHgRpEQJZjmRr2fpDkbYGRo9/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p0c4tXlQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2aA5N032057;
	Fri, 18 Apr 2025 02:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RhvdyRCnqas3+Td8DSrAas2M01r6+EfimoidA6JwQ1E=; b=p0c4tXlQQG3C3CTJ
	C2Gfl3bodD+RIex7njXRLhePJ1ShLeYiCB/cB5s7iFuznvisYouq2qWZVccmItYJ
	g6Ht1lnHAcrDLURTORbwJSELuUybdGx5RwSde+gtog+/t2h4c1XixTnmq7XW5spb
	C8U6QQdIaUMaKIOmPEUFRB5CA/K+Y9+9O2x+sdX19rczp26Bq3MTIazdQtPFPKGV
	ZpXben+HnUra5Kq9L2h0p5Blf3HYI6laM2tENtFaDYu8UqNUPT16Rp1cnK12vYLj
	yJ/lk6tygSXQUgbQCPkpZZ7PVgnJF4u65FVuhC5hdKFtm7fXQgjQQgeVKARvDsv2
	BI/mZw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wruca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2tx99020732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:55:59 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:55:57 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 18 Apr 2025 10:55:35 +0800
Subject: [PATCH ath-next 02/15] wifi: ath12k: refactor
 ath12k_reg_chan_list_event()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-2-c869c86cad60@quicinc.com>
References: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
In-Reply-To: <20250418-ath12k-6g-lp-vlp-v1-0-c869c86cad60@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=6801bf40 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=MctfVJ7kNpgt09kw6YkA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -DcZTUw_dEz6H5EUXuroeR2pZVZi7uZM
X-Proofpoint-GUID: -DcZTUw_dEz6H5EUXuroeR2pZVZi7uZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=997 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

ath12k_reg_chan_list_event() is doing quite some work: allocate/free
reg_info, parse chan list event and store required info in reg_info,
process reg_info, build regd and queue work item for later processing
etc, which makes it hard to read.

Refactor this function:

1. extract reg_info processing and regd building into a new helper
   ath12k_reg_handle_chan_list().
2. extract reg_info free into a new helper ath12k_reg_reset_reg_info().

Note the refactor also benefit some upcoming patches where these helpers
are getting called.

Also relocate these two helpers and the existing
ath12k_reg_is_world_alpha() to reg.c to reflect what they are doing.
And update fw to firmware while relocating.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 112 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/reg.h |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c | 105 +++----------------------------
 3 files changed, 123 insertions(+), 97 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 7048834e0d14f0c125dcae5f3c30d8070a9ada4f..21c5a8312a9e55a458aab5151ff9c017808659d7 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -879,6 +879,118 @@ void ath12k_regd_update_work(struct work_struct *work)
 	}
 }
 
+void ath12k_reg_reset_reg_info(struct ath12k_reg_info *reg_info)
+{
+	u8 i, j;
+
+	if (!reg_info)
+		return;
+
+	kfree(reg_info->reg_rules_2g_ptr);
+	kfree(reg_info->reg_rules_5g_ptr);
+
+	if (reg_info->is_ext_reg_event) {
+		for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
+			kfree(reg_info->reg_rules_6g_ap_ptr[i]);
+
+			for (j = 0; j < WMI_REG_MAX_CLIENT_TYPE; j++)
+				kfree(reg_info->reg_rules_6g_client_ptr[i][j]);
+		}
+	}
+}
+
+static bool ath12k_reg_is_world_alpha(char *alpha)
+{
+	if (alpha[0] == '0' && alpha[1] == '0')
+		return true;
+
+	if (alpha[0] == 'n' && alpha[1] == 'a')
+		return true;
+
+	return false;
+}
+
+int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
+				struct ath12k_reg_info *reg_info)
+{
+	struct ieee80211_regdomain *regd = NULL;
+	bool intersect = false;
+	struct ath12k *ar;
+	int pdev_idx;
+
+	if (reg_info->status_code != REG_SET_CC_STATUS_PASS) {
+		/* In case of failure to set the requested country,
+		 * firmware retains the current regd. We print a failure info
+		 * and return from here.
+		 */
+		ath12k_warn(ab, "Failed to set the requested Country regulatory setting\n");
+		return 0;
+	}
+
+	pdev_idx = reg_info->phy_id;
+	if (pdev_idx >= ab->num_radios) {
+		/* Process the event for phy0 only if single_pdev_only
+		 * is true. If pdev_idx is valid but not 0, discard the
+		 * event. Otherwise, it goes to fallback.
+		 */
+		if (ab->hw_params->single_pdev_only &&
+		    pdev_idx < ab->hw_params->num_rxdma_per_pdev)
+			return 0;
+		else
+			return -EINVAL;
+	}
+
+	/* Avoid multiple overwrites to default regd, during core
+	 * stop-start after mac registration.
+	 */
+	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
+	    !memcmp(ab->default_regd[pdev_idx]->alpha2,
+		    reg_info->alpha2, 2))
+		return 0;
+
+	/* Intersect new rules with default regd if a new country setting was
+	 * requested, i.e a default regd was already set during initialization
+	 * and the regd coming from this event has a valid country info.
+	 */
+	if (ab->default_regd[pdev_idx] &&
+	    !ath12k_reg_is_world_alpha((char *)
+		ab->default_regd[pdev_idx]->alpha2) &&
+	    !ath12k_reg_is_world_alpha((char *)reg_info->alpha2))
+		intersect = true;
+
+	regd = ath12k_reg_build_regd(ab, reg_info, intersect);
+	if (!regd)
+		return -EINVAL;
+
+	spin_lock_bh(&ab->base_lock);
+	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
+		/* Once mac is registered, ar is valid and all CC events from
+		 * firmware is considered to be received due to user requests
+		 * currently.
+		 * Free previously built regd before assigning the newly
+		 * generated regd to ar. NULL pointer handling will be
+		 * taken care by kfree itself.
+		 */
+		ar = ab->pdevs[pdev_idx].ar;
+		kfree(ab->new_regd[pdev_idx]);
+		ab->new_regd[pdev_idx] = regd;
+		queue_work(ab->workqueue, &ar->regd_update_work);
+	} else {
+		/* Multiple events for the same *ar is not expected. But we
+		 * can still clear any previously stored default_regd if we
+		 * are receiving this event for the same radio by mistake.
+		 * NULL pointer handling will be taken care by kfree itself.
+		 */
+		kfree(ab->default_regd[pdev_idx]);
+		/* This regd would be applied during mac registration */
+		ab->default_regd[pdev_idx] = regd;
+	}
+	ab->dfs_region = reg_info->dfs_region;
+	spin_unlock_bh(&ab->base_lock);
+
+	return 0;
+}
+
 void ath12k_reg_init(struct ieee80211_hw *hw)
 {
 	hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index b1eb584ff34c4c068195ae3aa660520be19e8243..f65cfaca7404cd72a9978c0ae6ca98be9d5f6b70 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -101,4 +101,7 @@ struct ieee80211_regdomain *ath12k_reg_build_regd(struct ath12k_base *ab,
 int ath12k_regd_update(struct ath12k *ar, bool init);
 int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait);
 
+void ath12k_reg_reset_reg_info(struct ath12k_reg_info *reg_info);
+int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
+				struct ath12k_reg_info *reg_info);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 256e05e28afdbee8267bd2ab25bb47cba4530e96..9bb6d99e7c16f327f5cb73777af9c545803420be 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6115,24 +6115,10 @@ static void ath12k_wmi_htc_tx_complete(struct ath12k_base *ab,
 	dev_kfree_skb(skb);
 }
 
-static bool ath12k_reg_is_world_alpha(char *alpha)
-{
-	if (alpha[0] == '0' && alpha[1] == '0')
-		return true;
-
-	if (alpha[0] == 'n' && alpha[1] == 'a')
-		return true;
-
-	return false;
-}
-
 static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *skb)
 {
-	struct ath12k_reg_info *reg_info = NULL;
-	struct ieee80211_regdomain *regd = NULL;
-	bool intersect = false;
-	int ret = 0, pdev_idx, i, j;
-	struct ath12k *ar;
+	struct ath12k_reg_info *reg_info;
+	int ret;
 
 	reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
 	if (!reg_info) {
@@ -6141,85 +6127,17 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	}
 
 	ret = ath12k_pull_reg_chan_list_ext_update_ev(ab, skb, reg_info);
-
 	if (ret) {
 		ath12k_warn(ab, "failed to extract regulatory info from received event\n");
 		goto fallback;
 	}
 
-	if (reg_info->status_code != REG_SET_CC_STATUS_PASS) {
-		/* In case of failure to set the requested ctry,
-		 * fw retains the current regd. We print a failure info
-		 * and return from here.
-		 */
-		ath12k_warn(ab, "Failed to set the requested Country regulatory setting\n");
-		goto mem_free;
-	}
-
-	pdev_idx = reg_info->phy_id;
-
-	if (pdev_idx >= ab->num_radios) {
-		/* Process the event for phy0 only if single_pdev_only
-		 * is true. If pdev_idx is valid but not 0, discard the
-		 * event. Otherwise, it goes to fallback.
-		 */
-		if (ab->hw_params->single_pdev_only &&
-		    pdev_idx < ab->hw_params->num_rxdma_per_pdev)
-			goto mem_free;
-		else
-			goto fallback;
-	}
-
-	/* Avoid multiple overwrites to default regd, during core
-	 * stop-start after mac registration.
-	 */
-	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
-	    !memcmp(ab->default_regd[pdev_idx]->alpha2,
-		    reg_info->alpha2, 2))
-		goto mem_free;
-
-	/* Intersect new rules with default regd if a new country setting was
-	 * requested, i.e a default regd was already set during initialization
-	 * and the regd coming from this event has a valid country info.
-	 */
-	if (ab->default_regd[pdev_idx] &&
-	    !ath12k_reg_is_world_alpha((char *)
-		ab->default_regd[pdev_idx]->alpha2) &&
-	    !ath12k_reg_is_world_alpha((char *)reg_info->alpha2))
-		intersect = true;
-
-	regd = ath12k_reg_build_regd(ab, reg_info, intersect);
-	if (!regd) {
-		ath12k_warn(ab, "failed to build regd from reg_info\n");
+	ret = ath12k_reg_handle_chan_list(ab, reg_info);
+	if (ret) {
+		ath12k_warn(ab, "failed to handle chan list %d\n", ret);
 		goto fallback;
 	}
 
-	spin_lock_bh(&ab->base_lock);
-	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags)) {
-		/* Once mac is registered, ar is valid and all CC events from
-		 * fw is considered to be received due to user requests
-		 * currently.
-		 * Free previously built regd before assigning the newly
-		 * generated regd to ar. NULL pointer handling will be
-		 * taken care by kfree itself.
-		 */
-		ar = ab->pdevs[pdev_idx].ar;
-		kfree(ab->new_regd[pdev_idx]);
-		ab->new_regd[pdev_idx] = regd;
-		queue_work(ab->workqueue, &ar->regd_update_work);
-	} else {
-		/* Multiple events for the same *ar is not expected. But we
-		 * can still clear any previously stored default_regd if we
-		 * are receiving this event for the same radio by mistake.
-		 * NULL pointer handling will be taken care by kfree itself.
-		 */
-		kfree(ab->default_regd[pdev_idx]);
-		/* This regd would be applied during mac registration */
-		ab->default_regd[pdev_idx] = regd;
-	}
-	ab->dfs_region = reg_info->dfs_region;
-	spin_unlock_bh(&ab->base_lock);
-
 	goto mem_free;
 
 fallback:
@@ -6232,20 +6150,13 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	 */
 	/* TODO: This is rare, but still should also be handled */
 	WARN_ON(1);
+
 mem_free:
 	if (reg_info) {
-		kfree(reg_info->reg_rules_2g_ptr);
-		kfree(reg_info->reg_rules_5g_ptr);
-		if (reg_info->is_ext_reg_event) {
-			for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++)
-				kfree(reg_info->reg_rules_6g_ap_ptr[i]);
-
-			for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++)
-				for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++)
-					kfree(reg_info->reg_rules_6g_client_ptr[j][i]);
-		}
+		ath12k_reg_reset_reg_info(reg_info);
 		kfree(reg_info);
 	}
+
 	return ret;
 }
 

-- 
2.34.1


