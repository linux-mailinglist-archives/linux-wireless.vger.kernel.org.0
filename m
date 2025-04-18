Return-Path: <linux-wireless+bounces-21700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36DAA93037
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 04:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A02C467C9C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 02:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226C269827;
	Fri, 18 Apr 2025 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LvulTO9D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2D2690C0;
	Fri, 18 Apr 2025 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944976; cv=none; b=IOSZMbf2JAq0q0C5Kr3kWCo3csgsszB+zPYfAU6cHafusFgakfE3yJHcXNaYBMg6p0I49SfVHt73SUvmX9ksSJ0MZnP9rpGyRPCYLVu+TPoDo60q81QVyZQ9Sg9hafCd6+AccZpknlbkFVuOm46lH8VFfgzAL79iaQa5/ybJkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944976; c=relaxed/simple;
	bh=sUbbU3NMXtLVCjO0mPYVUlYM/wRD3Mf0oSWQSsVmmjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EXPxPiViseDs8UAoCmpwYws1c0d92+WoQElwQ8L6eRvjA26jRvYNv+vY3E57F08ZEcykxzhvTx87HR8Tht5S3TNpZt8PJ1p5NmTszbHLMqDrZwdWPI9hcTE3Y29zinp306nWFLSgUNHjNKis3SzLmyfRr8RdcetybF+RoaFZYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LvulTO9D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I2HcrV013597;
	Fri, 18 Apr 2025 02:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ob4IoD2zAUO9wZ01HiVJoloQB5KSbq2Lf2oBO7RcGD4=; b=LvulTO9DCZQ+I8Lx
	dRoJ12BMzuNo+UtMxr831yeDmMlthVRFG6ahdGGjhGAnmUUlqPqJyKxCAQdBbkbn
	9x2xyp01JcxMnCjajtNx3hMan1hXSD4s+UlyDxjKKWxBnjyHCsTRdyIwNcap/V/3
	MAnET8PAQpAtXl2/hwsntbqBWi7JpIZWPLzNRyiElmN52Cp6hnJYLqxV3eVqujOP
	vkhR9HOhqTQuw/BczNhdqfPIUGtPaTCqlnkoqMVrkLMlQzLzsjYWpZsRxtPs5jE+
	+ZW7smxzfCwByKf+rwPtgJIe40jGScKR6LLb64POZyINkUMSl/PPgxU/1pRgWI+W
	ZEdi9w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjrppt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I2u4M5023044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 02:56:04 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Apr
 2025 19:56:02 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Fri, 18 Apr 2025 10:55:38 +0800
Subject: [PATCH ath-next 05/15] wifi: ath12k: move reg info handling
 outside
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250418-ath12k-6g-lp-vlp-v1-5-c869c86cad60@quicinc.com>
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
X-Proofpoint-GUID: BHQO8Rrzb_JZBEaVYcgxKYdqwOsq_YGv
X-Proofpoint-ORIG-GUID: BHQO8Rrzb_JZBEaVYcgxKYdqwOsq_YGv
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=6801bf45 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=bLiQCk9RTWAdsMjxWrwA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180020

The reg info is allocated in ath12k_reg_chan_list_event() but validated
in ath12k_reg_handle_chan_list(). Currently this is good since reg info
would be freed regardless of validation results. However in an upcoming
patch the reg info might need to be stored for later use if the result
is good. Since we can not tell the result from return value of
ath12k_reg_handle_chan_list(), we need to move validation out of it.

Add a new helper ath12k_reg_validate_reg_info() and call it in
ath12k_reg_chan_list_event(), based on the result we can choose to store
or free it in the following patch.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 31 +++++++++++++++++++------------
 drivers/net/wireless/ath/ath12k/reg.h |  8 ++++++++
 drivers/net/wireless/ath/ath12k/wmi.c | 33 +++++++++++++++++++++++++--------
 3 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 3bed5f68cd6b583fff52e9fce5227353e5e5a766..e3ad475328526cf6e9e5e312c7953f661a1e5e8d 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -949,14 +949,10 @@ void ath12k_reg_reset_reg_info(struct ath12k_reg_info *reg_info)
 	}
 }
 
-int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
-				struct ath12k_reg_info *reg_info,
-				enum wmi_vdev_type vdev_type,
-				enum ieee80211_ap_reg_power power_type)
+enum ath12k_reg_status ath12k_reg_validate_reg_info(struct ath12k_base *ab,
+						    struct ath12k_reg_info *reg_info)
 {
-	struct ieee80211_regdomain *regd = NULL;
-	struct ath12k *ar;
-	int pdev_idx;
+	int pdev_idx = reg_info->phy_id;
 
 	if (reg_info->status_code != REG_SET_CC_STATUS_PASS) {
 		/* In case of failure to set the requested country,
@@ -964,10 +960,9 @@ int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
 		 * and return from here.
 		 */
 		ath12k_warn(ab, "Failed to set the requested Country regulatory setting\n");
-		return 0;
+		return ATH12K_REG_STATUS_DROP;
 	}
 
-	pdev_idx = reg_info->phy_id;
 	if (pdev_idx >= ab->num_radios) {
 		/* Process the event for phy0 only if single_pdev_only
 		 * is true. If pdev_idx is valid but not 0, discard the
@@ -975,9 +970,9 @@ int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
 		 */
 		if (ab->hw_params->single_pdev_only &&
 		    pdev_idx < ab->hw_params->num_rxdma_per_pdev)
-			return 0;
+			return ATH12K_REG_STATUS_DROP;
 		else
-			return -EINVAL;
+			return ATH12K_REG_STATUS_FALLBACK;
 	}
 
 	/* Avoid multiple overwrites to default regd, during core
@@ -986,7 +981,19 @@ int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
 	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
 	    !memcmp(ab->default_regd[pdev_idx]->alpha2,
 		    reg_info->alpha2, 2))
-		return 0;
+		return ATH12K_REG_STATUS_DROP;
+
+	return ATH12K_REG_STATUS_VALID;
+}
+
+int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
+				struct ath12k_reg_info *reg_info,
+				enum wmi_vdev_type vdev_type,
+				enum ieee80211_ap_reg_power power_type)
+{
+	struct ieee80211_regdomain *regd = NULL;
+	int pdev_idx = reg_info->phy_id;
+	struct ath12k *ar;
 
 	regd = ath12k_reg_build_regd(ab, reg_info, vdev_type, power_type);
 	if (!regd)
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 9868daf3f1e56a4e112751b971d92fdad241427e..8af8e9ba462e90db3eb137885d0acd4b1cb2286e 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -92,6 +92,12 @@ enum ath12k_reg_phy_bitmap {
 	ATH12K_REG_PHY_BITMAP_NO11BE	= BIT(6),
 };
 
+enum ath12k_reg_status {
+	ATH12K_REG_STATUS_VALID,
+	ATH12K_REG_STATUS_DROP,
+	ATH12K_REG_STATUS_FALLBACK,
+};
+
 void ath12k_reg_init(struct ieee80211_hw *hw);
 void ath12k_reg_free(struct ath12k_base *ab);
 void ath12k_regd_update_work(struct work_struct *work);
@@ -109,4 +115,6 @@ int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
 				enum ieee80211_ap_reg_power power_type);
 enum wmi_reg_6g_ap_type
 ath12k_reg_ap_pwr_convert(enum ieee80211_ap_reg_power power_type);
+enum ath12k_reg_status ath12k_reg_validate_reg_info(struct ath12k_base *ab,
+						    struct ath12k_reg_info *reg_info);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index be66e88fb65a92f943f86c5fa597f13953aa02b2..42e275762563f84f4891ffd1be8e33917f1192d2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6129,7 +6129,22 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	ret = ath12k_pull_reg_chan_list_ext_update_ev(ab, skb, reg_info);
 	if (ret) {
 		ath12k_warn(ab, "failed to extract regulatory info from received event\n");
-		goto fallback;
+		goto mem_free;
+	}
+
+	ret = ath12k_reg_validate_reg_info(ab, reg_info);
+	if (ret == ATH12K_REG_STATUS_FALLBACK) {
+		ath12k_warn(ab, "failed to validate reg info %d\n", ret);
+		/* firmware has successfully switches to new regd but host can not
+		 * continue, so free reginfo and fallback to old regd
+		 */
+		goto mem_free;
+	} else if (ret == ATH12K_REG_STATUS_DROP) {
+		/* reg info is valid but we will not store it and
+		 * not going to create new regd for it
+		 */
+		ret = ATH12K_REG_STATUS_VALID;
+		goto mem_free;
 	}
 
 	ret = ath12k_reg_handle_chan_list(ab, reg_info, WMI_VDEV_TYPE_UNSPEC,
@@ -6139,7 +6154,14 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 		goto fallback;
 	}
 
-	goto mem_free;
+	goto out;
+
+mem_free:
+	ath12k_reg_reset_reg_info(reg_info);
+	kfree(reg_info);
+
+	if (ret == ATH12K_REG_STATUS_VALID)
+		return ret;
 
 fallback:
 	/* Fallback to older reg (by sending previous country setting
@@ -6152,12 +6174,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	/* TODO: This is rare, but still should also be handled */
 	WARN_ON(1);
 
-mem_free:
-	if (reg_info) {
-		ath12k_reg_reset_reg_info(reg_info);
-		kfree(reg_info);
-	}
-
+out:
 	return ret;
 }
 

-- 
2.34.1


