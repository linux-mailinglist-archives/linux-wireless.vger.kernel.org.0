Return-Path: <linux-wireless+bounces-621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7335480C13D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 07:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281B9280C74
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 06:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60621F92C;
	Mon, 11 Dec 2023 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nHL311iL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFEED
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 22:22:32 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB5bT4e003430;
	Mon, 11 Dec 2023 06:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=D6VaiQ4QzY6erzgSF5OqBwwkc8K6/AdN2D6gSyU/EQ8=; b=nH
	L311iLe01Y8w0p1nMG8w/Of5arLFs5eYkAhWM5s/3ZXSoGGchqNXCudrupMw+b1d
	AXNHgi2er1JVIMH3DTRcoBMihMKZ0DpLfEKw1YKBFOlYPRah7MouSJL6MzkUu6cS
	RU5YvdGjYiNIoOsHwMOpBWpu0ywk0sT5hbkns+cH1QXfC1hR0T2mg4WJyk5Wxg4Y
	u3VMiuSspL/nfNzhodA3E4um0JXyYKigjM9930DklfL8BxMS8wzs2waOGeSuuplD
	5j83Yk5mU6vkiC46EeV/BQO1PvoDmRDZddks8DZzDB7/0w/IyGKj+4C3wZe2NP1Y
	xAduDcZTizoiuCARyXMQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnk5tee4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 06:22:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB6MToA003856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 06:22:29 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 10 Dec 2023 22:22:28 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v9 02/12] wifi: ath11k: store cur_regulatory_info for each radio
Date: Mon, 11 Dec 2023 14:22:06 +0800
Message-ID: <20231211062216.382164-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211062216.382164-1-quic_bqiang@quicinc.com>
References: <20231211062216.382164-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: pwSehNUKAmeOtUk9IpuIZWlVGryUlrsV
X-Proofpoint-GUID: pwSehNUKAmeOtUk9IpuIZWlVGryUlrsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110050

From: Wen Gong <quic_wgong@quicinc.com>

The regulatory info of WMI_REG_CHAN_LIST_CC_EXT_EVENTID is not saved
in ath11k now, the info should be saved in ath11k. Save the info for
each radio and support switch regulatory rules dynamically.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v9:
 1. add check to soc->reg_info_store in case memory allocation fails.
 2. remove irrelevant change w.r.t commit message.
v8:
 no change.
v7:
 1. fix ath11k-check warning
 2. fix memory leak.

 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/reg.c  |   6 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 153 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath11k/wmi.h  |   5 +
 4 files changed, 122 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 7e3b6779f4e9..cc91f7d3ca8e 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -922,6 +922,7 @@ struct ath11k_base {
 	 * This may or may not be used during the runtime
 	 */
 	struct ieee80211_regdomain *new_regd[MAX_RADIOS];
+	struct cur_regulatory_info *reg_info_store;
 
 	/* Current DFS Regulatory */
 	enum ath11k_dfs_region dfs_region;
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 8a6fe9b495bf..b860d2fd7e5c 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -821,6 +821,12 @@ void ath11k_reg_free(struct ath11k_base *ab)
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
index 75c79c99faa9..78bc2715e476 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4749,6 +4749,14 @@ static int ath11k_wmi_tlv_ext_soc_hal_reg_caps_parse(struct ath11k_base *soc,
 		soc->pdevs[0].pdev_id = 0;
 	}
 
+	if (!soc->reg_info_store) {
+		soc->reg_info_store = kcalloc(soc->num_radios,
+					      sizeof(*soc->reg_info_store),
+					      GFP_ATOMIC);
+		if (!soc->reg_info_store)
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -7071,33 +7079,54 @@ static bool ath11k_reg_is_world_alpha(char *alpha)
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
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg chan list id %d", id);
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
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg handle chan list");
 
 	if (reg_info->status_code != REG_SET_CC_STATUS_PASS) {
 		/* In case of failure to set the requested ctry,
@@ -7105,7 +7134,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 		 * and return from here.
 		 */
 		ath11k_warn(ab, "Failed to set the requested Country regulatory setting\n");
-		goto mem_free;
+		return -EINVAL;
 	}
 
 	pdev_idx = reg_info->phy_id;
@@ -7117,20 +7146,23 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags) &&
 	    ab->default_regd[pdev_idx]) {
 		spin_unlock(&ab->base_lock);
-		goto mem_free;
+		goto retfail;
 	}
 	spin_unlock(&ab->base_lock);
 
 	if (pdev_idx >= ab->num_radios) {
 		/* Process the event for phy0 only if single_pdev_only
 		 * is true. If pdev_idx is valid but not 0, discard the
-		 * event. Otherwise, it goes to fallback.
+		 * event. Otherwise, it goes to fallback. In either case
+		 * ath11k_reg_reset_info() needs to be called to avoid
+		 * memory leak issue.
 		 */
+		ath11k_reg_reset_info(reg_info);
+
 		if (ab->hw_params.single_pdev_only &&
 		    pdev_idx < ab->hw_params.num_rxmda_per_pdev)
-			goto mem_free;
-		else
-			goto fallback;
+			return 0;
+		goto fallback;
 	}
 
 	/* Avoid multiple overwrites to default regd, during core
@@ -7139,7 +7171,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
 	    !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
 		    (char *)reg_info->alpha2, 2))
-		goto mem_free;
+		goto retfail;
 
 	/* Intersect new rules with default regd if a new country setting was
 	 * requested, i.e a default regd was already set during initialization
@@ -7151,13 +7183,24 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
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
@@ -7180,7 +7223,7 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	ab->dfs_region = reg_info->dfs_region;
 	spin_unlock(&ab->base_lock);
 
-	goto mem_free;
+	return 0;
 
 fallback:
 	/* Fallback to older reg (by sending previous country setting
@@ -7192,20 +7235,44 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
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
+	}
+
+	ret = ath11k_reg_handle_chan_list(ab, reg_info, IEEE80211_REG_UNSET_AP);
+	if (ret) {
+		ath11k_warn(ab, "failed to process regulatory info %d\n", ret);
+		goto mem_free;
 	}
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
index ff0a9a92beeb..d46c70704774 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4951,6 +4951,7 @@ struct ath11k_targ_cap {
 };
 
 enum wmi_vdev_type {
+	WMI_VDEV_TYPE_UNSPEC =  0,
 	WMI_VDEV_TYPE_AP      = 1,
 	WMI_VDEV_TYPE_STA     = 2,
 	WMI_VDEV_TYPE_IBSS    = 3,
@@ -6480,4 +6481,8 @@ int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar);
 int ath11k_wmi_sta_keepalive(struct ath11k *ar,
 			     const struct wmi_sta_keepalive_arg *arg);
 
+void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info);
+int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
+				struct cur_regulatory_info *reg_info,
+				enum ieee80211_ap_reg_power power_type);
 #endif
-- 
2.25.1


