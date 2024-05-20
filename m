Return-Path: <linux-wireless+bounces-7829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426648C97FE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 04:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8834EB20F63
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 02:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3400C2FD;
	Mon, 20 May 2024 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="STMI1J7o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD54BA47
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716172941; cv=none; b=Jm0KX5XJadldWBeVToe1XRpzokEhu0wAilgGJ/ujMC8iAP834lD+daWDqts5iU+f+wiTsBNSRivDAKQKYlVLGG0jF/yOZ3MnPx2+hJuPf1X1/efKQEw7aG12+UXxLDKQX0v6FeT6tqNniH2zkjVW/ONfhfJsmA5y8a0yUGIvBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716172941; c=relaxed/simple;
	bh=jXhp44oHjde1zt0mvPiPWpDNKx+Z+dRGwqoXKFxXcY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZJAFNWOAOXUcbPs5pPuSHB4AqjtIY/YqE8l/FfwSppy8PBKy5flhXces9Os+pm22QQELTUC4u+fCu/A5OwA/LaCOhye8fu/YQOCo2aPgwZydcEjumjNKRkLl7Afe7+eWM2iQYgltl+hM4bW0fDIS7vaesE9krCKxEFYZJY/I3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=STMI1J7o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44K0TIl8004473;
	Mon, 20 May 2024 02:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=nKCFsrcR4yZOeb4jho8fIQGCwfyYjMid173zLlgOo34=; b=ST
	MI1J7oxqgfUTiUdLoVwtiH2EHYKj81yqZ5r8BP4QknuObJjgAuBF+r1lBuDvBIGV
	XClnxw/ZEn7eWCmozOynBjoP55rJNx5srExFGF+/GZdqtDhmUXyZ3uNZ18Mr6mYO
	CiB7O5zxYTArGrzXhqDfL+4/dYDvaZqPi/lI8tGiVOMUr2uKYdgO/jekp4uYe8De
	MgIAdA5MQwG6r1lt6mrz9Cdus0cy2DEiXA6QGuAp1qMRapQxrLAHcOFXTAMW4Kwq
	9899SB4g056iXJVFLbOzY1xdE4DVQ/mv4FuHMt0MsUYOE6SyLPoJ49p0LOcYeTPX
	BZ2N9cAmyGsKlUPxX+Aw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6psat90b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 02:42:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K2g0Vd027676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 02:42:00 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 May 2024 19:41:59 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 1/2] wifi: ath11k: refactor setting country code logic
Date: Mon, 20 May 2024 10:41:47 +0800
Message-ID: <20240520024148.5472-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520024148.5472-1-quic_bqiang@quicinc.com>
References: <20240520024148.5472-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: cU8A7y68aRUKPshVtKCtXt2BOns0aN5J
X-Proofpoint-ORIG-GUID: cU8A7y68aRUKPshVtKCtXt2BOns0aN5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-19_12,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200019

ath11k_wmi_send_set_current_country_cmd() is called in several places
and all of them are just simply repeating the same logic.

Refactor to make code clean.

Compile tested only.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 19 ++++++++-----------
 drivers/net/wireless/ath/ath11k/mac.c  | 13 +++----------
 drivers/net/wireless/ath/ath11k/reg.c  | 14 ++++++++++----
 drivers/net/wireless/ath/ath11k/reg.h  |  4 ++--
 4 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index d4ef556852c2..748e3ad2bec3 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1978,23 +1978,20 @@ static void ath11k_update_11d(struct work_struct *work)
 	struct ath11k_base *ab = container_of(work, struct ath11k_base, update_11d_work);
 	struct ath11k *ar;
 	struct ath11k_pdev *pdev;
-	struct wmi_set_current_country_params set_current_param = {};
 	int ret, i;
 
-	spin_lock_bh(&ab->base_lock);
-	memcpy(&set_current_param.alpha2, &ab->new_alpha2, 2);
-	spin_unlock_bh(&ab->base_lock);
-
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "update 11d new cc %c%c\n",
-		   set_current_param.alpha2[0],
-		   set_current_param.alpha2[1]);
-
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
 
-		memcpy(&ar->alpha2, &set_current_param.alpha2, 2);
-		ret = ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
+		spin_lock_bh(&ab->base_lock);
+		memcpy(&ar->alpha2, &ab->new_alpha2, 2);
+		spin_unlock_bh(&ab->base_lock);
+
+		ath11k_dbg(ab, ATH11K_DBG_WMI, "update 11d new cc %c%c for pdev %d\n",
+			   ar->alpha2[0], ar->alpha2[1], i);
+
+		ret = ath11k_reg_set_cc(ar);
 		if (ret)
 			ath11k_warn(ar->ab,
 				    "pdev id %d failed set current country code: %d\n",
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 17b06c0cd062..84415187416d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8864,12 +8864,8 @@ ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
 		ieee80211_wake_queues(ar->hw);
 
 		if (ar->ab->hw_params.current_cc_support &&
-		    ar->alpha2[0] != 0 && ar->alpha2[1] != 0) {
-			struct wmi_set_current_country_params set_current_param = {};
-
-			memcpy(&set_current_param.alpha2, ar->alpha2, 2);
-			ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
-		}
+		    ar->alpha2[0] != 0 && ar->alpha2[1] != 0)
+			ath11k_reg_set_cc(ar);
 
 		if (ab->is_reset) {
 			recovery_count = atomic_inc_return(&ab->recovery_count);
@@ -10311,11 +10307,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	}
 
 	if (ab->hw_params.current_cc_support && ab->new_alpha2[0]) {
-		struct wmi_set_current_country_params set_current_param = {};
-
-		memcpy(&set_current_param.alpha2, ab->new_alpha2, 2);
 		memcpy(&ar->alpha2, ab->new_alpha2, 2);
-		ret = ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
+		ret = ath11k_reg_set_cc(ar);
 		if (ret)
 			ath11k_warn(ar->ab,
 				    "failed set cc code for mac register: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 4c3aefbbabbe..b0f289784dd3 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -49,7 +49,6 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct wmi_init_country_params init_country_param;
-	struct wmi_set_current_country_params set_current_param = {};
 	struct ath11k *ar = hw->priv;
 	int ret;
 
@@ -83,9 +82,8 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	 * reg info
 	 */
 	if (ar->ab->hw_params.current_cc_support) {
-		memcpy(&set_current_param.alpha2, request->alpha2, 2);
-		memcpy(&ar->alpha2, &set_current_param.alpha2, 2);
-		ret = ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
+		memcpy(&ar->alpha2, request->alpha2, 2);
+		ret = ath11k_reg_set_cc(ar);
 		if (ret)
 			ath11k_warn(ar->ab,
 				    "failed set current country code: %d\n", ret);
@@ -1017,3 +1015,11 @@ void ath11k_reg_free(struct ath11k_base *ab)
 		kfree(ab->new_regd[i]);
 	}
 }
+
+int ath11k_reg_set_cc(struct ath11k *ar)
+{
+	struct wmi_set_current_country_params set_current_param = {};
+
+	memcpy(&set_current_param.alpha2, ar->alpha2, 2);
+	return ath11k_wmi_send_set_current_country_cmd(ar, &set_current_param);
+}
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 64edb794260a..263ea9061948 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_REG_H
@@ -45,5 +45,5 @@ ath11k_reg_ap_pwr_convert(enum ieee80211_ap_reg_power power_type);
 int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
 				struct cur_regulatory_info *reg_info,
 				enum ieee80211_ap_reg_power power_type);
-
+int ath11k_reg_set_cc(struct ath11k *ar);
 #endif
-- 
2.25.1


