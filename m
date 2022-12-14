Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BC064CE4F
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 17:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiLNQru (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 11:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiLNQrs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 11:47:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE591DF0A
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 08:47:43 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEE3AB5020674;
        Wed, 14 Dec 2022 16:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=U4AwdnvWd8LGuMTLUPJ2M6QcPe2y3JpytTnuMB7eS1E=;
 b=QVOxgGUZGCdKrDp1Z2u9r8CEdcGiVK9G+3htuFM6maI8h0hYltOp4m5I8BI4gqoAoPQ2
 mTIg1m0PQVOlvTzdIAgeOhGmO1KKWC31x1MlpIWvSOYaKKvpv+NOcB/zvQXBCZk5IHlj
 m/Xzbu+SmugnDlgvoTHk5JqC7cyB8Lan3dP5YIAnif0xfGNdWq0gX26MBzU5K46dGEai
 N9eLPZNBbswvDhGeoYwo4uQnBjEi2aycuT9j6LrHPFayLqZgQduzAScfWde6HqFNju+Z
 JVt3U9nyErPHcng9Lfof5JWxBw00gkInhdPkv2En0mvd48OaPeViT87arjF3Qb44Ww7n 0g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rchrt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 16:47:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BEGldfh012597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 16:47:39 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 14 Dec 2022 08:47:37 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v2 1/3] wifi: ath11k: use proper regulatory reference for bands
Date:   Wed, 14 Dec 2022 22:16:37 +0530
Message-ID: <20221214164639.31542-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221214164639.31542-1-quic_adisi@quicinc.com>
References: <20221214164639.31542-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NqYAzCqOAgRK0a3UmzHoz4zWT9EfaccG
X-Proofpoint-ORIG-GUID: NqYAzCqOAgRK0a3UmzHoz4zWT9EfaccG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_07,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxlogscore=920 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140134
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, during regulatory event, 2 GHz/5 GHz is referred
to as 2G/5G including variable names. However, there is no
such entity as 2G or 5G.

Re-name such occurences to its proper name. No functional changes.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/reg.c | 20 ++++-----
 drivers/net/wireless/ath/ath11k/wmi.c | 58 ++++++++++++++-------------
 drivers/net/wireless/ath/ath11k/wmi.h | 28 ++++++-------
 3 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 6fae4e61ede7..c231abdf49cb 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -619,7 +619,7 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 	u32 flags;
 	char alpha2[3];
 
-	num_rules = reg_info->num_5g_reg_rules + reg_info->num_2g_reg_rules;
+	num_rules = reg_info->num_5ghz_reg_rules + reg_info->num_2ghz_reg_rules;
 
 	if (!num_rules)
 		goto ret;
@@ -644,20 +644,20 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 		   alpha2, ath11k_reg_get_regdom_str(tmp_regd->dfs_region),
 		   reg_info->dfs_region, num_rules);
 	/* Update reg_rules[] below. Firmware is expected to
-	 * send these rules in order(2G rules first and then 5G)
+	 * send these rules in order(2 GHz rules first and then 5 GHz)
 	 */
 	for (; i < num_rules; i++) {
-		if (reg_info->num_2g_reg_rules &&
-		    (i < reg_info->num_2g_reg_rules)) {
-			reg_rule = reg_info->reg_rules_2g_ptr + i;
+		if (reg_info->num_2ghz_reg_rules &&
+		    (i < reg_info->num_2ghz_reg_rules)) {
+			reg_rule = reg_info->reg_rules_2ghz_ptr + i;
 			max_bw = min_t(u16, reg_rule->max_bw,
-				       reg_info->max_bw_2g);
+				       reg_info->max_bw_2ghz);
 			flags = 0;
-		} else if (reg_info->num_5g_reg_rules &&
-			   (j < reg_info->num_5g_reg_rules)) {
-			reg_rule = reg_info->reg_rules_5g_ptr + j++;
+		} else if (reg_info->num_5ghz_reg_rules &&
+			   (j < reg_info->num_5ghz_reg_rules)) {
+			reg_rule = reg_info->reg_rules_5ghz_ptr + j++;
 			max_bw = min_t(u16, reg_rule->max_bw,
-				       reg_info->max_bw_5g);
+				       reg_info->max_bw_5ghz);
 
 			/* FW doesn't pass NL80211_RRF_AUTO_BW flag for
 			 * BW Auto correction, we can enable this by default
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2a8a3e3dcff6..fd84963d5860 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4951,7 +4951,7 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	const void **tb;
 	const struct wmi_reg_chan_list_cc_event *chan_list_event_hdr;
 	struct wmi_regulatory_rule_struct *wmi_reg_rule;
-	u32 num_2g_reg_rules, num_5g_reg_rules;
+	u32 num_2ghz_reg_rules, num_5ghz_reg_rules;
 	int ret;
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "processing regulatory channel list\n");
@@ -4970,10 +4970,10 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 		return -EPROTO;
 	}
 
-	reg_info->num_2g_reg_rules = chan_list_event_hdr->num_2g_reg_rules;
-	reg_info->num_5g_reg_rules = chan_list_event_hdr->num_5g_reg_rules;
+	reg_info->num_2ghz_reg_rules = chan_list_event_hdr->num_2ghz_reg_rules;
+	reg_info->num_5ghz_reg_rules = chan_list_event_hdr->num_5ghz_reg_rules;
 
-	if (!(reg_info->num_2g_reg_rules + reg_info->num_5g_reg_rules)) {
+	if (!(reg_info->num_2ghz_reg_rules + reg_info->num_5ghz_reg_rules)) {
 		ath11k_warn(ab, "No regulatory rules available in the event info\n");
 		kfree(tb);
 		return -EINVAL;
@@ -5000,46 +5000,48 @@ static int ath11k_pull_reg_chan_list_update_ev(struct ath11k_base *ab,
 	else if (chan_list_event_hdr->status_code == WMI_REG_SET_CC_STATUS_FAIL)
 		reg_info->status_code = REG_SET_CC_STATUS_FAIL;
 
-	reg_info->min_bw_2g = chan_list_event_hdr->min_bw_2g;
-	reg_info->max_bw_2g = chan_list_event_hdr->max_bw_2g;
-	reg_info->min_bw_5g = chan_list_event_hdr->min_bw_5g;
-	reg_info->max_bw_5g = chan_list_event_hdr->max_bw_5g;
+	reg_info->min_bw_2ghz = chan_list_event_hdr->min_bw_2ghz;
+	reg_info->max_bw_2ghz = chan_list_event_hdr->max_bw_2ghz;
+	reg_info->min_bw_5ghz = chan_list_event_hdr->min_bw_5ghz;
+	reg_info->max_bw_5ghz = chan_list_event_hdr->max_bw_5ghz;
 
-	num_2g_reg_rules = reg_info->num_2g_reg_rules;
-	num_5g_reg_rules = reg_info->num_5g_reg_rules;
+	num_2ghz_reg_rules = reg_info->num_2ghz_reg_rules;
+	num_5ghz_reg_rules = reg_info->num_5ghz_reg_rules;
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "%s:cc %s dsf %d BW: min_2g %d max_2g %d min_5g %d max_5g %d",
+		   "%s:cc %s dsf %d BW: min_2ghz %d max_2ghz %d min_5ghz %d max_5ghz %d",
 		   __func__, reg_info->alpha2, reg_info->dfs_region,
-		   reg_info->min_bw_2g, reg_info->max_bw_2g,
-		   reg_info->min_bw_5g, reg_info->max_bw_5g);
+		   reg_info->min_bw_2ghz, reg_info->max_bw_2ghz,
+		   reg_info->min_bw_5ghz, reg_info->max_bw_5ghz);
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "%s: num_2g_reg_rules %d num_5g_reg_rules %d", __func__,
-		   num_2g_reg_rules, num_5g_reg_rules);
+		   "%s: num_2ghz_reg_rules %d num_5ghz_reg_rules %d", __func__,
+		   num_2ghz_reg_rules, num_5ghz_reg_rules);
 
 	wmi_reg_rule =
 		(struct wmi_regulatory_rule_struct *)((u8 *)chan_list_event_hdr
 						+ sizeof(*chan_list_event_hdr)
 						+ sizeof(struct wmi_tlv));
 
-	if (num_2g_reg_rules) {
-		reg_info->reg_rules_2g_ptr = create_reg_rules_from_wmi(num_2g_reg_rules,
-								       wmi_reg_rule);
-		if (!reg_info->reg_rules_2g_ptr) {
+	if (num_2ghz_reg_rules) {
+		reg_info->reg_rules_2ghz_ptr =
+				create_reg_rules_from_wmi(num_2ghz_reg_rules,
+							  wmi_reg_rule);
+		if (!reg_info->reg_rules_2ghz_ptr) {
 			kfree(tb);
-			ath11k_warn(ab, "Unable to Allocate memory for 2g rules\n");
+			ath11k_warn(ab, "Unable to Allocate memory for 2 GHz rules\n");
 			return -ENOMEM;
 		}
 	}
 
-	if (num_5g_reg_rules) {
-		wmi_reg_rule += num_2g_reg_rules;
-		reg_info->reg_rules_5g_ptr = create_reg_rules_from_wmi(num_5g_reg_rules,
-								       wmi_reg_rule);
-		if (!reg_info->reg_rules_5g_ptr) {
+	if (num_5ghz_reg_rules) {
+		wmi_reg_rule += num_2ghz_reg_rules;
+		reg_info->reg_rules_5ghz_ptr =
+				create_reg_rules_from_wmi(num_5ghz_reg_rules,
+							  wmi_reg_rule);
+		if (!reg_info->reg_rules_5ghz_ptr) {
 			kfree(tb);
-			ath11k_warn(ab, "Unable to Allocate memory for 5g rules\n");
+			ath11k_warn(ab, "Unable to Allocate memory for 5 GHz rules\n");
 			return -ENOMEM;
 		}
 	}
@@ -6605,8 +6607,8 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *sk
 	WARN_ON(1);
 mem_free:
 	if (reg_info) {
-		kfree(reg_info->reg_rules_2g_ptr);
-		kfree(reg_info->reg_rules_5g_ptr);
+		kfree(reg_info->reg_rules_2ghz_ptr);
+		kfree(reg_info->reg_rules_5ghz_ptr);
 		kfree(reg_info);
 	}
 	return ret;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8f2c07d70a4a..94f90148c54f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4119,14 +4119,14 @@ struct cur_regulatory_info {
 	u8 alpha2[REG_ALPHA2_LEN + 1];
 	u32 dfs_region;
 	u32 phybitmap;
-	u32 min_bw_2g;
-	u32 max_bw_2g;
-	u32 min_bw_5g;
-	u32 max_bw_5g;
-	u32 num_2g_reg_rules;
-	u32 num_5g_reg_rules;
-	struct cur_reg_rule *reg_rules_2g_ptr;
-	struct cur_reg_rule *reg_rules_5g_ptr;
+	u32 min_bw_2ghz;
+	u32 max_bw_2ghz;
+	u32 min_bw_5ghz;
+	u32 max_bw_5ghz;
+	u32 num_2ghz_reg_rules;
+	u32 num_5ghz_reg_rules;
+	struct cur_reg_rule *reg_rules_2ghz_ptr;
+	struct cur_reg_rule *reg_rules_5ghz_ptr;
 };
 
 struct wmi_reg_chan_list_cc_event {
@@ -4138,12 +4138,12 @@ struct wmi_reg_chan_list_cc_event {
 	u32 domain_code;
 	u32 dfs_region;
 	u32 phybitmap;
-	u32 min_bw_2g;
-	u32 max_bw_2g;
-	u32 min_bw_5g;
-	u32 max_bw_5g;
-	u32 num_2g_reg_rules;
-	u32 num_5g_reg_rules;
+	u32 min_bw_2ghz;
+	u32 max_bw_2ghz;
+	u32 min_bw_5ghz;
+	u32 max_bw_5ghz;
+	u32 num_2ghz_reg_rules;
+	u32 num_5ghz_reg_rules;
 } __packed;
 
 struct wmi_regulatory_rule_struct {

base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
-- 
2.17.1

