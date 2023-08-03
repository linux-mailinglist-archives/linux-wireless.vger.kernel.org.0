Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06E76E118
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjHCHRf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 03:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjHCHRd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 03:17:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308412D64
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 00:17:31 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3737HMsA011441;
        Thu, 3 Aug 2023 07:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=WGAlEoyY+OSBjypnCF6TibvBXLV+x5w73qeS5RddZ8g=;
 b=pFggCdAcIdZE9Wr0M0OjVTEq3fYTPEd4QqVYPanKhkCGcEFDzb8eZFy00AzHIdjiXgVa
 eAFQWJxIrWbW84rNSIpSux/47AqvEUbJV34nOSLlQ/wjif25MGrG7wn03lm12g8aoZAz
 XTKc5eEgcDdCPYhrNn/VRwJ5Mbzxl+ug5rsTgHy2fljXMSCoewYpaplGo+3gyEWQHPPH
 YvMpEfTOtnlxG9M1wGNgGe0qL9v5FoaXr2F1uSsfYZMcjlNTSV3T67ImqEwh4DUzf547
 u0Sr2R7/cR1jpDqGFr1jD98lYfEPuxSsfyVS0VS5Fr2nEvV0m9nghREGJ4FLpTgCfOdt Rw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7vtv92us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 07:17:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3737HKW5026830
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 07:17:20 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 00:17:18 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, Wen Gong <quic_wgong@quicinc.com>
Subject: [PATCH v5 2/5] wifi: ath11k: store cur_regulatory_info for each radio
Date:   Thu, 3 Aug 2023 03:16:58 -0400
Message-ID: <20230803071701.15084-3-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803071701.15084-1-quic_wgong@quicinc.com>
References: <20230803071701.15084-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dZnVpb1XeFs34ZE9NFXFfzqbULvewGsH
X-Proofpoint-ORIG-GUID: dZnVpb1XeFs34ZE9NFXFfzqbULvewGsH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_05,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The regulatory info of WMI_REG_CHAN_LIST_CC_EXT_EVENTID is not saved
in ath11k now, the info should be saved in ath11k. Save the info for
each radio and support switch regulatory rules dynamically.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/mac.h  |   1 -
 drivers/net/wireless/ath/ath11k/reg.c  |   6 ++
 drivers/net/wireless/ath/ath11k/wmi.c  | 141 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath11k/wmi.h  |   5 +
 5 files changed, 113 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9d15b4390b9c..2e017141b62b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -923,6 +923,7 @@ struct ath11k_base {
 	 * This may or may not be used during the runtime
 	 */
 	struct ieee80211_regdomain *new_regd[MAX_RADIOS];
+	struct cur_regulatory_info *reg_info_store;
 
 	/* Current DFS Regulatory */
 	enum ath11k_dfs_region dfs_region;
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 0231783ad754..e4835e0b7998 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -158,7 +158,6 @@ struct ath11k_vif *ath11k_mac_get_vif_up(struct ath11k_base *ab);
 
 struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, u32 vdev_id);
 struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id);
-
 void ath11k_mac_drain_tx(struct ath11k *ar);
 void ath11k_mac_peer_cleanup_all(struct ath11k *ar);
 int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 516cbea37aa6..8106caf53a92 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -809,6 +809,12 @@ void ath11k_reg_free(struct ath11k_base *ab)
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
index 5a6578865b25..1fb445106872 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4749,6 +4749,11 @@ static int ath11k_wmi_tlv_ext_soc_hal_reg_caps_parse(struct ath11k_base *soc,
 		soc->pdevs[0].pdev_id = 0;
 	}
 
+	if (!soc->reg_info_store)
+		soc->reg_info_store = kcalloc(soc->num_radios,
+					      sizeof(*soc->reg_info_store),
+					      GFP_ATOMIC);
+
 	return 0;
 }
 
@@ -7070,33 +7075,54 @@ static bool ath11k_reg_is_world_alpha(char *alpha)
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
+		kfree(reg_info->reg_rules_2ghz_ptr);
 
-	if (id == WMI_REG_CHAN_LIST_CC_ID)
-		ret = ath11k_pull_reg_chan_list_update_ev(ab, skb, reg_info);
-	else
-		ret = ath11k_pull_reg_chan_list_ext_update_ev(ab, skb, reg_info);
+		kfree(reg_info->reg_rules_5ghz_ptr);
 
-	if (ret) {
-		ath11k_warn(ab, "failed to extract regulatory info from received event\n");
-		goto fallback;
+		for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
+			kfree(reg_info->reg_rules_6ghz_ap_ptr[i]);
+			for (j = 0; j < WMI_REG_MAX_CLIENT_TYPE; j++)
+				kfree(reg_info->reg_rules_6ghz_client_ptr[i][j]);
+		}
+
+		memset(reg_info, 0, sizeof(*reg_info));
 	}
+}
+
+static
+enum wmi_vdev_type ath11k_reg_get_ar_vdev_type(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+
+	/* Currently each struct ath11k maps to one struct ieee80211_hw/wiphy
+	 * and one struct ieee80211_regdomain, so it could only store one group
+	 * reg rules. It means muti-interface concurrency in the same ath11k is
+	 * not support for the regdomain. So get the vdev type of the first entry
+	 * now. After concurrency support for the regdomain, this should change.
+	 */
+	arvif = list_first_entry_or_null(&ar->arvifs, struct ath11k_vif, list);
+	if (arvif)
+		return arvif->vdev_type;
+
+	return WMI_VDEV_TYPE_UNSPEC;
+}
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg chan list id %d", id);
+int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
+				struct cur_regulatory_info *reg_info,
+				enum ieee80211_ap_reg_power power_type)
+{
+	struct ieee80211_regdomain *regd;
+	bool intersect = false;
+	int pdev_idx;
+	struct ath11k *ar;
+	enum wmi_vdev_type vdev_type;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg handle chan list");
 
 	if (reg_info->status_code != REG_SET_CC_STATUS_PASS) {
 		/* In case of failure to set the requested ctry,
@@ -7104,7 +7130,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 		 * and return from here.
 		 */
 		ath11k_warn(ab, "Failed to set the requested Country regulatory setting\n");
-		goto mem_free;
+		return -EINVAL;
 	}
 
 	pdev_idx = reg_info->phy_id;
@@ -7116,7 +7142,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags) &&
 	    ab->default_regd[pdev_idx]) {
 		spin_unlock(&ab->base_lock);
-		goto mem_free;
+		goto retfail;
 	}
 	spin_unlock(&ab->base_lock);
 
@@ -7127,7 +7153,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 		 */
 		if (ab->hw_params.single_pdev_only &&
 		    pdev_idx < ab->hw_params.num_rxmda_per_pdev)
-			goto mem_free;
+			return 0;
 		else
 			goto fallback;
 	}
@@ -7138,7 +7164,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
 	    !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
 		    (char *)reg_info->alpha2, 2))
-		goto mem_free;
+		goto retfail;
 
 	/* Intersect new rules with default regd if a new country setting was
 	 * requested, i.e a default regd was already set during initialization
@@ -7150,13 +7176,24 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	    !ath11k_reg_is_world_alpha((char *)reg_info->alpha2))
 		intersect = true;
 
-	regd = ath11k_reg_build_regd(ab, reg_info, intersect,
-				     WMI_VDEV_TYPE_AP, IEEE80211_REG_LPI_AP);
+	ar = ab->pdevs[pdev_idx].ar;
+	vdev_type = ath11k_reg_get_ar_vdev_type(ar);
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
@@ -7179,7 +7216,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	ab->dfs_region = reg_info->dfs_region;
 	spin_unlock(&ab->base_lock);
 
-	goto mem_free;
+	return 0;
 
 fallback:
 	/* Fallback to older reg (by sending previous country setting
@@ -7191,20 +7228,44 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	 */
 	/* TODO: This is rare, but still should also be handled */
 	WARN_ON(1);
-mem_free:
-	if (reg_info) {
-		kfree(reg_info->reg_rules_2ghz_ptr);
-		kfree(reg_info->reg_rules_5ghz_ptr);
-		if (reg_info->is_ext_reg_event) {
-			for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++)
-				kfree(reg_info->reg_rules_6ghz_ap_ptr[i]);
 
-			for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++)
-				for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++)
-					kfree(reg_info->reg_rules_6ghz_client_ptr[j][i]);
-		}
-		kfree(reg_info);
+retfail:
+
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
+		ath11k_warn(ab, "failed to extract regulatory info\n");
+		goto mem_free;
 	}
+
+	ret = ath11k_reg_handle_chan_list(ab, reg_info, IEEE80211_REG_UNSET_AP);
+	if (ret) {
+		ath11k_warn(ab, "failed to process regulatory info %d\n", ret);
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
index 100bb816b592..a34a04bd4612 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4975,6 +4975,7 @@ struct ath11k_targ_cap {
 };
 
 enum wmi_vdev_type {
+	WMI_VDEV_TYPE_UNSPEC =  0,
 	WMI_VDEV_TYPE_AP      = 1,
 	WMI_VDEV_TYPE_STA     = 2,
 	WMI_VDEV_TYPE_IBSS    = 3,
@@ -6505,4 +6506,8 @@ int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar);
 int ath11k_wmi_sta_keepalive(struct ath11k *ar,
 			     const struct wmi_sta_keepalive_arg *arg);
 
+void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info);
+int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
+				struct cur_regulatory_info *reg_info,
+				enum ieee80211_ap_reg_power power_type);
 #endif
-- 
2.40.1

