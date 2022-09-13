Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB15B6732
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 07:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiIMFQS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 01:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMFPs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 01:15:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5684BA74
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 22:15:45 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D4vubL014081;
        Tue, 13 Sep 2022 05:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Jac592/pwqk3VVMA9oZ8TAfvWs2CCvyE7u2HiSwPP9o=;
 b=YY6P4fDDu+Fpdf4MWJcPVq4pla8Xntg7jA4EUWofTbgS2kZvH97GG5cL84j/WKfiG5VN
 ctLrZgIbrBaVtNZ20cj2cOJLTnrgNyc6JckChZ3V8LO7DIaeULxhtfJjX65mEpY3Y2z4
 Wx4IZSTGJcFylJY1qvQgL9cGdjoqFQ3nruXogXrFA5eOfKx9QaTNYT9/8FSh4K33YxqX
 67gd4mgbh95CCf2txL9aInNgCc/zS928HKO2KNF1tnjmpqKdhMfXzU+1N4JvgWcHbI6r
 p5rydj0RJgKS7pGa+4y2tEZB48fzAH2z9IRVJ6xeFo41BhWhxruxQNTugG8y1Dej0roN zA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk636420-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D5FeZV028474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 05:15:40 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 22:15:39 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v3 04/15] wifi: ath11k: store cur_regulatory_info for each radio
Date:   Tue, 13 Sep 2022 01:15:07 -0400
Message-ID: <20220913051518.23051-5-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220913051518.23051-1-quic_wgong@quicinc.com>
References: <20220913051518.23051-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yPgZWHCuatDU7W88STcfW1jeYw3kimiH
X-Proofpoint-ORIG-GUID: yPgZWHCuatDU7W88STcfW1jeYw3kimiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209130023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The regulatory info of WMI_REG_CHAN_LIST_CC_EXT_EVENTID is not saved
in ath11k now, the info should be saved in ath11k. Save the info for
each radio and support switch regulatory rules dynamically.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/mac.c  |  11 +++
 drivers/net/wireless/ath/ath11k/mac.h  |   2 +-
 drivers/net/wireless/ath/ath11k/reg.c  |   6 ++
 drivers/net/wireless/ath/ath11k/wmi.c  | 120 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/wmi.h  |   5 ++
 6 files changed, 105 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9e88ccca5ca7..681a58aaa26b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -763,6 +763,7 @@ struct ath11k_base {
 	 * This may or may not be used during the runtime
 	 */
 	struct ieee80211_regdomain *new_regd[MAX_RADIOS];
+	struct cur_regulatory_info *reg_info_store;
 
 	/* Current DFS Regulatory */
 	enum ath11k_dfs_region dfs_region;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7180ac37b327..ae7e40332cef 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -618,6 +618,17 @@ struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, u32 vdev_id)
 	return NULL;
 }
 
+enum wmi_vdev_type ath11k_mac_get_ar_vdev_type(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+
+	list_for_each_entry(arvif, &ar->arvifs, list) {
+		return arvif->vdev_type;
+	}
+
+	return WMI_VDEV_TYPE_UNSPEC;
+}
+
 struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id)
 {
 	int i;
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 0e6c870b09c8..eb8273ffc2a7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -159,7 +159,7 @@ struct ath11k_vif *ath11k_mac_get_vif_up(struct ath11k_base *ab);
 
 struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, u32 vdev_id);
 struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id);
-
+enum wmi_vdev_type ath11k_mac_get_ar_vdev_type(struct ath11k *ar);
 void ath11k_mac_drain_tx(struct ath11k *ar);
 void ath11k_mac_peer_cleanup_all(struct ath11k *ar);
 int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 5870cf57813c..f23a351d3f1e 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -788,6 +788,12 @@ void ath11k_reg_free(struct ath11k_base *ab)
 {
 	int i;
 
+	for (i = 0; i < ab->num_radios; i++)
+		ath11k_reg_reset_info(&ab->reg_info_store[i]);
+
+	kfree(ab->reg_info_store);
+	ab->reg_info_store = NULL;
+
 	for (i = 0; i < ab->hw_params.max_radios; i++) {
 		kfree(ab->default_regd[i]);
 		kfree(ab->new_regd[i]);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index fa87cf0dc390..d2d0873fda83 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4408,6 +4408,11 @@ static int ath11k_wmi_tlv_ext_soc_hal_reg_caps_parse(struct ath11k_base *soc,
 		soc->pdevs[0].pdev_id = 0;
 	}
 
+	if (!soc->reg_info_store)
+		soc->reg_info_store = kcalloc(soc->num_radios,
+					      sizeof(*soc->reg_info_store),
+					      GFP_ATOMIC);
+
 	return 0;
 }
 
@@ -6787,31 +6792,34 @@ static bool ath11k_reg_is_world_alpha(char *alpha)
 	return false;
 }
 
-static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
-				      struct sk_buff *skb,
-				      enum wmi_reg_chan_list_cmd_type id)
+void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info)
 {
-	struct cur_regulatory_info *reg_info = NULL;
-	struct ieee80211_regdomain *regd = NULL;
-	bool intersect = false;
-	int ret = 0, pdev_idx, i, j;
-	struct ath11k *ar;
+	int i, j;
 
-	reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
-	if (!reg_info) {
-		ret = -ENOMEM;
-		goto fallback;
-	}
+	if (reg_info) {
+		kfree(reg_info->reg_rules_2g_ptr);
 
-	if (id == WMI_REG_CHAN_LIST_CC_ID)
-		ret = ath11k_pull_reg_chan_list_update_ev(ab, skb, reg_info);
-	else
-		ret = ath11k_pull_reg_chan_list_ext_update_ev(ab, skb, reg_info);
+		kfree(reg_info->reg_rules_5g_ptr);
 
-	if (ret) {
-		ath11k_warn(ab, "failed to extract regulatory info from received event\n");
-		goto fallback;
+		for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
+			kfree(reg_info->reg_rules_6g_ap_ptr[i]);
+			for (j = 0; j < WMI_REG_MAX_CLIENT_TYPE; j++)
+				kfree(reg_info->reg_rules_6g_client_ptr[i][j]);
+		}
+
+		memset(reg_info, 0, sizeof(*reg_info));
 	}
+}
+
+int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
+				struct cur_regulatory_info *reg_info,
+				enum ieee80211_ap_reg_power power_type)
+{
+	struct ieee80211_regdomain *regd;
+	bool intersect = false;
+	int pdev_idx;
+	struct ath11k *ar;
+	enum wmi_vdev_type vdev_type;
 
 	if (reg_info->status_code != REG_SET_CC_STATUS_PASS) {
 		/* In case of failure to set the requested ctry,
@@ -6819,7 +6827,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 		 * and return from here.
 		 */
 		ath11k_warn(ab, "Failed to set the requested Country regulatory setting\n");
-		goto mem_free;
+		return -EINVAL;
 	}
 
 	pdev_idx = reg_info->phy_id;
@@ -6831,7 +6839,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags) &&
 	    ab->default_regd[pdev_idx]) {
 		spin_unlock(&ab->base_lock);
-		goto mem_free;
+		goto retfail;
 	}
 	spin_unlock(&ab->base_lock);
 
@@ -6842,7 +6850,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 		 */
 		if (ab->hw_params.single_pdev_only &&
 		    pdev_idx < ab->hw_params.num_rxmda_per_pdev)
-			goto mem_free;
+			goto retfail;
 		else
 			goto fallback;
 	}
@@ -6853,7 +6861,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
 	    !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
 		    (char *)reg_info->alpha2, 2))
-		goto mem_free;
+		goto retfail;
 
 	/* Intersect new rules with default regd if a new country setting was
 	 * requested, i.e a default regd was already set during initialization
@@ -6865,13 +6873,24 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	    !ath11k_reg_is_world_alpha((char *)reg_info->alpha2))
 		intersect = true;
 
-	regd = ath11k_reg_build_regd(ab, reg_info, intersect,
-				     WMI_VDEV_TYPE_AP, IEEE80211_REG_UNSET_AP);
+	ar = ab->pdevs[pdev_idx].ar;
+	vdev_type = ath11k_mac_get_ar_vdev_type(ar);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "wmi handle chan list power type %d vdev type %d intersect %d\n",
+		   power_type, vdev_type, intersect);
+
+	regd = ath11k_reg_build_regd(ab, reg_info, intersect, vdev_type, power_type);
 	if (!regd) {
 		ath11k_warn(ab, "failed to build regd from reg_info\n");
 		goto fallback;
 	}
 
+	if (power_type == IEEE80211_REG_UNSET_AP) {
+		ath11k_reg_reset_info(&ab->reg_info_store[pdev_idx]);
+		ab->reg_info_store[pdev_idx] = *reg_info;
+	}
+
 	spin_lock(&ab->base_lock);
 	if (ab->default_regd[pdev_idx]) {
 		/* The initial rules from FW after WMI Init is to build
@@ -6894,7 +6913,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	ab->dfs_region = reg_info->dfs_region;
 	spin_unlock(&ab->base_lock);
 
-	goto mem_free;
+	return 0;
 
 fallback:
 	/* Fallback to older reg (by sending previous country setting
@@ -6906,20 +6925,43 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	 */
 	/* TODO: This is rare, but still should also be handled */
 	WARN_ON(1);
-mem_free:
-	if (reg_info) {
-		kfree(reg_info->reg_rules_2g_ptr);
-		kfree(reg_info->reg_rules_5g_ptr);
-		if (reg_info->is_ext_reg_event) {
-			for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++)
-				kfree(reg_info->reg_rules_6g_ap_ptr[i]);
+retfail:
 
-			for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++)
-				for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++)
-					kfree(reg_info->reg_rules_6g_client_ptr[j][i]);
-		}
-		kfree(reg_info);
+	return -EINVAL;
+}
+
+static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *skb,
+				      enum wmi_reg_chan_list_cmd_type id)
+{
+	struct cur_regulatory_info *reg_info;
+	int ret;
+
+	reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
+	if (!reg_info)
+		return -ENOMEM;
+
+	if (id == WMI_REG_CHAN_LIST_CC_ID)
+		ret = ath11k_pull_reg_chan_list_update_ev(ab, skb, reg_info);
+	else
+		ret = ath11k_pull_reg_chan_list_ext_update_ev(ab, skb, reg_info);
+
+	if (ret) {
+		ath11k_warn(ab, "failed to extract regulatory info from received event\n");
+		goto mem_free;
 	}
+
+	ret = ath11k_reg_handle_chan_list(ab, reg_info, IEEE80211_REG_UNSET_AP);
+	if (ret) {
+		ath11k_warn(ab, "failed to process regulatory info from received event\n");
+		goto mem_free;
+	}
+
+	kfree(reg_info);
+	return 0;
+
+mem_free:
+	ath11k_reg_reset_info(reg_info);
+	kfree(reg_info);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 9d36f5774fa9..754fef933cc7 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4761,6 +4761,7 @@ struct ath11k_targ_cap {
 };
 
 enum wmi_vdev_type {
+	WMI_VDEV_TYPE_UNSPEC =  0,
 	WMI_VDEV_TYPE_AP      = 1,
 	WMI_VDEV_TYPE_STA     = 2,
 	WMI_VDEV_TYPE_IBSS    = 3,
@@ -5728,4 +5729,8 @@ int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar);
 int ath11k_wmi_wow_enable(struct ath11k *ar);
 int ath11k_wmi_scan_prob_req_oui(struct ath11k *ar,
 				 const u8 mac_addr[ETH_ALEN]);
+void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info);
+int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
+				struct cur_regulatory_info *reg_info,
+				enum ieee80211_ap_reg_power power_type);
 #endif
-- 
2.31.1

