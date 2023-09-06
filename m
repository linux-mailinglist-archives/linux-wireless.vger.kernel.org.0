Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC579372C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Sep 2023 10:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjIFIap (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Sep 2023 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjIFIam (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Sep 2023 04:30:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98909CF1
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 01:30:30 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3867Jieo006829;
        Wed, 6 Sep 2023 08:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=HkERTn2eEuq05UoX01AQweRf69Kn94kcdYhZj2C5NEU=;
 b=KHVSfeArZ5+a7ZRPeY6a8Yw8n75LewaFft8rB5n/nmHcc3vl828sE5Rx0E1nW2giSPZ0
 CcWzF5KtgLATS1LMxFyhfBoHMBOtJr8t//71pfdaHeyA+GJMosMOObsbQpcnXdw5+832
 4f+uwIp5A4ltW4aj5hvqX8neBJ4cS0UcAy2r7zW5qd8ui4ZPocTJF85MAoioXNnVIfyJ
 cSHk7jckax5zM1HRoE4i44xCrA90pBoSi9CgKGIm38bmwIW3SzTtVsWdSLv/rUEFsvCZ
 I82UZlo+OeOh8Y5TOnO/ZC6Pd70BUaZ8RRVH/C2xmpv815wYsJebCSRitl5vqvBJfArn 7w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxfrkgr5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 08:30:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3868UGFw024248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 08:30:16 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 6 Sep 2023 01:30:14 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 3/4] wifi: ath12k: avoid firmware crash when reg set for WCN7850
Date:   Wed, 6 Sep 2023 04:29:47 -0400
Message-ID: <20230906082948.18452-4-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906082948.18452-1-quic_wgong@quicinc.com>
References: <20230906082948.18452-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ci6tzCi5pjR56WMcOZL121rQHRg28fS3
X-Proofpoint-ORIG-GUID: ci6tzCi5pjR56WMcOZL121rQHRg28fS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_01,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the NL80211_REGDOM_SET_BY_USER hint from cfg80211, it set the new
alpha2 code to ath12k, then ath12k send WMI_SET_INIT_COUNTRY_CMDID to
firmware for all chips currently. When test with WCN7850 chips,
this WMI CMD leads firmware crash.

For AP based chips(QCN92xx), WMI_SET_INIT_COUNTRY_CMDID is the correct
command use. However, for STATION based chips(WCN7850), it need to use
another WMI CMD, WMI_SET_CURRENT_COUNTRY_CMDID.

Add flag current_cc_support in hardware parameters. It is used to
distinguish AP/STA platform. After that, the firmware will work
normal and the regulatory feature works well for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  |  3 +++
 drivers/net/wireless/ath/ath12k/hw.h  |  1 +
 drivers/net/wireless/ath/ath12k/reg.c | 29 ++++++++++++++++++---------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 5991cc91cd00..c9ed4c0e0da5 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -907,6 +907,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_ops = &hal_qcn9274_ops,
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+		.current_cc_support = false,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -964,6 +965,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01) |
 					   BIT(CNSS_PCIE_PERST_NO_PULL_V01),
+		.current_cc_support = true,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1019,6 +1021,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.hal_ops = &hal_qcn9274_ops,
 
 		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+		.current_cc_support = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index e6c4223c283c..292c07bb1a8b 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -173,6 +173,7 @@ struct ath12k_hw_params {
 	bool tcl_ring_retry:1;
 	bool reoq_lut_support:1;
 	bool supports_shadow_regs:1;
+	bool current_cc_support:1;
 
 	u32 hal_desc_sz;
 	u32 num_tcl_banks;
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index c2f2fcce9fb1..97c93a4901e6 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -48,6 +48,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct ath12k_wmi_init_country_arg arg;
+	struct wmi_set_current_country_params set_current_param = {};
 	struct ath12k *ar = hw->priv;
 	int ret;
 
@@ -76,18 +77,26 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 		return;
 	}
 
-	/* Set the country code to the firmware and wait for
-	 * the WMI_REG_CHAN_LIST_CC EVENT for updating the
-	 * reg info
+	/* Set the country code to the firmware. ath12k will subsequently receive
+	 * the WMI_REG_CHAN_LIST_CC EVENT for updating the regulatory info.
 	 */
-	arg.flags = ALPHA_IS_SET;
-	memcpy(&arg.cc_info.alpha2, request->alpha2, 2);
-	arg.cc_info.alpha2[2] = 0;
+	if (ar->ab->hw_params->current_cc_support) {
+		memcpy(&set_current_param.alpha2, request->alpha2, 2);
 
-	ret = ath12k_wmi_send_init_country_cmd(ar, &arg);
-	if (ret)
-		ath12k_warn(ar->ab,
-			    "INIT Country code set to fw failed : %d\n", ret);
+		ret = ath12k_wmi_send_set_current_country_cmd(ar, &set_current_param);
+		if (ret)
+			ath12k_warn(ar->ab,
+				    "failed set current country code: %d\n", ret);
+	} else {
+		arg.flags = ALPHA_IS_SET;
+		memcpy(&arg.cc_info.alpha2, request->alpha2, 2);
+		arg.cc_info.alpha2[2] = 0;
+
+		ret = ath12k_wmi_send_init_country_cmd(ar, &arg);
+		if (ret)
+			ath12k_warn(ar->ab,
+				    "INIT Country code set to fw failed : %d\n", ret);
+	}
 
 	ath12k_mac_11d_scan_stop(ar);
 	ar->regdom_set_by_user = true;
-- 
2.40.1

