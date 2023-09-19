Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADBD7A5AB0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjISHRp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 03:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjISHRo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 03:17:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C3A100
        for <linux-wireless@vger.kernel.org>; Tue, 19 Sep 2023 00:17:38 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6KGIq020556;
        Tue, 19 Sep 2023 07:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=CBWPy3RFJEuQFjlua+nn41CDyX9kSlehPYqxrltIKyY=;
 b=BUraxUtI232LxIOvKizZcLmf2C0Yu5viV/aPgWlZEHmPqglfsUEx+mz0ANUa1mhUpN1N
 BTuR3zGrIo0bSbCzYjmQVh+H11vgpKfXMYdfw5mUeMKlxj7WnycFS86UI0kiYpRZEKxW
 Eo6RHUGU9i1ZN40y9RM4Cwt9m4Q3v9qB4ABJU2Vzw2cOZ3n4rZnOk+ShZ6SZnYaf541T
 aC8DT8FeprU8i2irJ+0dwk9UQFAhIGqHbotrVPmEplrn+3O3GG3tqAt2Zx876kiq+cGf
 lTDznr/VM/HCQ7zc4L9gsueeEm4nC8/zddRl8R5OKK+0Ng/gSZ0UsyWk+5XPIpreA5Tx 8A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6mtsa98y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:17:36 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38J76CSQ002071;
        Tue, 19 Sep 2023 07:17:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 3t74xehge9-1;
        Tue, 19 Sep 2023 07:17:35 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38J7HZf1024497;
        Tue, 19 Sep 2023 07:17:35 GMT
Received: from aisr-linux.qualcomm.com (aisr-linux.qualcomm.com [10.201.124.194])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTP id 38J7HYlQ024462;
        Tue, 19 Sep 2023 07:17:35 +0000
Received: by aisr-linux.qualcomm.com (Postfix, from userid 4090849)
        id 63C24E020C5; Tue, 19 Sep 2023 12:47:33 +0530 (IST)
From:   Aishwarya R <quic_aisr@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Aishwarya R <quic_aisr@quicinc.com>
Subject: [PATCH 2/7] wifi: ath12k: build 6 GHz regd based on vdev type and 6 GHz power type
Date:   Tue, 19 Sep 2023 12:47:19 +0530
Message-Id: <20230919071724.15505-3-quic_aisr@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230919071724.15505-1-quic_aisr@quicinc.com>
References: <20230919071724.15505-1-quic_aisr@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8WXQqTO6fivhWBWzNUZQvVFm6bbOhg6m
X-Proofpoint-ORIG-GUID: 8WXQqTO6fivhWBWzNUZQvVFm6bbOhg6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=785
 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190060
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During bootup, WMI_REG_CHAN_LIST_CC_EXT_EVENTID event sent from firmware
at an early stage and it expects the 6 GHz power type for 6 GHz reg rules.
As power mode is not defined at this point host selects IEEE80211_REG_UNSET_AP
as default mode.

When interface is created, it updates regd rules accordingly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aishwarya R <quic_aisr@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 11 ++++
 drivers/net/wireless/ath/ath12k/mac.h |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c | 75 ++++++++++++++++-----------
 drivers/net/wireless/ath/ath12k/wmi.h |  1 +
 4 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ee792822b411..5b9af264d305 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -563,6 +563,17 @@ struct ath12k *ath12k_mac_get_ar_by_vdev_id(struct ath12k_base *ab, u32 vdev_id)
 	return NULL;
 }
 
+enum wmi_vdev_type ath12k_mac_get_ar_vdev_type(struct ath12k *ar)
+{
+	struct ath12k_vif *arvif;
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		return arvif->vdev_type;
+	}
+
+	return WMI_VDEV_TYPE_UNSPEC;
+}
+
 struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id)
 {
 	int i;
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 57f4295420bb..82f590004d05 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -66,6 +66,7 @@ struct ath12k_vif *ath12k_mac_get_arvif_by_vdev_id(struct ath12k_base *ab,
 						   u32 vdev_id);
 struct ath12k *ath12k_mac_get_ar_by_vdev_id(struct ath12k_base *ab, u32 vdev_id);
 struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id);
+enum wmi_vdev_type ath12k_mac_get_ar_vdev_type(struct ath12k *ar);
 
 void ath12k_mac_drain_tx(struct ath12k *ar);
 void ath12k_mac_peer_cleanup_all(struct ath12k *ar);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 1b9ce9a2ae96..211bdb915173 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5299,26 +5299,15 @@ static bool ath12k_reg_is_world_alpha(char *alpha)
 	return alpha[0] == '0' && alpha[1] == '0';
 }
 
-static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *skb)
+static int ath12k_reg_handle_chan_list(struct ath12k_base *ab,
+				       struct ath12k_reg_info *reg_info,
+				       enum ieee80211_ap_reg_power power_type)
 {
-	struct ath12k_reg_info *reg_info = NULL;
-	struct ieee80211_regdomain *regd = NULL;
+	struct ieee80211_regdomain *regd;
 	bool intersect = false;
-	int ret = 0, pdev_idx, i, j;
+	int pdev_idx;
 	struct ath12k *ar;
-
-	reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
-	if (!reg_info) {
-		ret = -ENOMEM;
-		goto fallback;
-	}
-
-	ret = ath12k_pull_reg_chan_list_ext_update_ev(ab, skb, reg_info);
-
-	if (ret) {
-		ath12k_warn(ab, "failed to extract regulatory info from received event\n");
-		goto fallback;
-	}
+	enum wmi_vdev_type vdev_type;
 
 	if (reg_info->status_code != REG_SET_CC_STATUS_PASS) {
 		/* In case of failure to set the requested ctry,
@@ -5326,7 +5315,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 		 * and return from here.
 		 */
 		ath12k_warn(ab, "Failed to set the requested Country regulatory setting\n");
-		goto mem_free;
+		return -EINVAL;
 	}
 
 	pdev_idx = reg_info->phy_id;
@@ -5338,9 +5327,8 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 		 */
 		if (ab->hw_params->single_pdev_only &&
 		    pdev_idx < ab->hw_params->num_rxmda_per_pdev)
-			goto mem_free;
-		else
-			goto fallback;
+			return -EINVAL;
+		goto fallback;
 	}
 
 	/* Avoid multiple overwrites to default regd, during core
@@ -5349,7 +5337,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
 	    !memcmp(ab->default_regd[pdev_idx]->alpha2,
 		    reg_info->alpha2, 2))
-		goto mem_free;
+		return -EINVAL;
 
 	/* Intersect new rules with default regd if a new country setting was
 	 * requested, i.e a default regd was already set during initialization
@@ -5361,8 +5349,13 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	    !ath12k_reg_is_world_alpha((char *)reg_info->alpha2))
 		intersect = true;
 
-	regd = ath12k_reg_build_regd(ab, reg_info, intersect,
-				     WMI_VDEV_TYPE_AP, IEEE80211_REG_UNSET_AP);
+	ar = ab->pdevs[pdev_idx].ar;
+	vdev_type = ath12k_mac_get_ar_vdev_type(ar);
+	ath12k_dbg(ab, ATH12K_DBG_WMI,
+		   "wmi handle chan list power type %d vdev type %d intersect %d\n",
+		    power_type, vdev_type, intersect);
+
+	regd = ath12k_reg_build_regd(ab, reg_info, intersect, vdev_type, power_type);
 	if (!regd) {
 		ath12k_warn(ab, "failed to build regd from reg_info\n");
 		goto fallback;
@@ -5394,7 +5387,7 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	ab->dfs_region = reg_info->dfs_region;
 	spin_unlock(&ab->base_lock);
 
-	goto mem_free;
+	return 0;
 
 fallback:
 	/* Fallback to older reg (by sending previous country setting
@@ -5406,17 +5399,39 @@ static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *sk
 	 */
 	/* TODO: This is rare, but still should also be handled */
 	WARN_ON(1);
+	return -EINVAL;
+}
+
+static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *skb)
+{
+	struct ath12k_reg_info *reg_info;
+	int ret, i, j;
+
+	reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
+	if (!reg_info)
+		return -ENOMEM;
+
+	ret = ath12k_pull_reg_chan_list_ext_update_ev(ab, skb, reg_info);
+
+	if (ret) {
+		ath12k_warn(ab, "failed to extract regulatory info from received event\n");
+		goto mem_free;
+	}
+
+	ret = ath12k_reg_handle_chan_list(ab, reg_info, IEEE80211_REG_UNSET_AP);
+	if (ret)
+		ath12k_warn(ab, "failed to process regulatory info from received event\n");
+
 mem_free:
 	if (reg_info) {
 		kfree(reg_info->reg_rules_2g_ptr);
 		kfree(reg_info->reg_rules_5g_ptr);
 		if (reg_info->is_ext_reg_event) {
-			for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++)
+			for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
 				kfree(reg_info->reg_rules_6g_ap_ptr[i]);
-
-			for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++)
-				for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++)
-					kfree(reg_info->reg_rules_6g_client_ptr[j][i]);
+				for (j = 0; j < WMI_REG_MAX_CLIENT_TYPE; j++)
+					kfree(reg_info->reg_rules_6g_client_ptr[i][j]);
+			}
 		}
 		kfree(reg_info);
 	}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 966e6ba4e162..c3b110af1272 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -4161,6 +4161,7 @@ struct ath12k_wmi_target_cap_arg {
 };
 
 enum wmi_vdev_type {
+	WMI_VDEV_TYPE_UNSPEC  = 0,
 	WMI_VDEV_TYPE_AP      = 1,
 	WMI_VDEV_TYPE_STA     = 2,
 	WMI_VDEV_TYPE_IBSS    = 3,
-- 
2.17.1

