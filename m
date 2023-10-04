Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60F57B7C11
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbjJDJ1T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjJDJ1S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:27:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1754A7
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:27:15 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3946fJ0Q026552;
        Wed, 4 Oct 2023 09:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=TL/VZuhUuPOqA3p7Frj3xe/JUomdScXO27AxeCPEM2s=;
 b=OaXelCvmQVDwQKrA9b8xXHbf86pf2hUVecVOHq3TssH/J3INSttQuROb3fTJ2VEPmoSB
 +gosNB+PPe16j8rHES6dhhylPWEQ/AKdpvvuNuL/Xkzs1CKN/iGfRgaIWy0l4b8P0Plb
 9/+nZPGP8bt/VEvDs7nHy82CNs7rEm5+wEDL+8zzdEzo9x9xEBRUNjI+VSp9C6nLbG4s
 qd7cZUK7mwjyWR7FKWGk+Ir8yCcev+T/XqDGvhP8RjWHR85xPqPwZ908PoFRV2CH1MI0
 LZq/X7UKXTatBTNX/zT5s0ZxfW+EvS9FXLivYpVaGhPpE8BuskamJLG4agChYa3FVrLG tQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgbjgug8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 09:27:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3949RA4B026650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 09:27:10 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 02:27:08 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: ath11k: add parsing of phy bitmap for reg rules
Date:   Wed, 4 Oct 2023 14:56:55 +0530
Message-ID: <20231004092655.25020-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n6CrF58gvDrlCznk04yztdPNKXxni92C
X-Proofpoint-GUID: n6CrF58gvDrlCznk04yztdPNKXxni92C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Certain regulatory domains could put restrictions on phy mode operation.
For example, in a few countries HE Operation is not allowed. For such
countries, firmware indicates this via phy bitmap in each reg rule.

Currently, there is no logic to parse this info and then pass it on to the
cfg80211/regulatory.

Add parsing of this phy bitmap from the regulatory channel change event and
then accordingly map it to cfg80211/regulatory flags and pass it on to it.

While at it, correct typo in debug print s/dsf/dfs.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/reg.c | 11 +++++++++++
 drivers/net/wireless/ath/ath11k/reg.h |  3 +++
 drivers/net/wireless/ath/ath11k/wmi.c |  5 +++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 7f9fb968dac6..3c7debae800a 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -352,6 +352,16 @@ static u32 ath11k_map_fw_reg_flags(u16 reg_flags)
 	return flags;
 }
 
+static u32 ath11k_map_fw_phy_flags(u32 phy_flags)
+{
+	u32 flags = 0;
+
+	if (phy_flags & ATH11K_REG_PHY_BITMAP_NO11AX)
+		flags |= NL80211_RRF_NO_HE;
+
+	return flags;
+}
+
 static bool
 ath11k_reg_can_intersect(struct ieee80211_reg_rule *rule1,
 			 struct ieee80211_reg_rule *rule2)
@@ -685,6 +695,7 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 		}
 
 		flags |= ath11k_map_fw_reg_flags(reg_rule->flags);
+		flags |= ath11k_map_fw_phy_flags(reg_info->phybitmap);
 
 		ath11k_reg_update_rule(tmp_regd->reg_rules + i,
 				       reg_rule->start_freq,
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 2f284f26378d..84daa6543b6a 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -24,6 +24,9 @@ enum ath11k_dfs_region {
 	ATH11K_DFS_REG_UNDEF,
 };
 
+/* Phy bitmaps */
+#define ATH11K_REG_PHY_BITMAP_NO11AX	BIT(5)
+
 /* ATH11K Regulatory API's */
 void ath11k_reg_init(struct ath11k *ar);
 void ath11k_reg_free(struct ath11k_base *ab);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index e93601fe7bcb..1542c2b0a981 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5440,10 +5440,11 @@ static int ath11k_pull_reg_chan_list_ext_update_ev(struct ath11k_base *ab,
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
-		   "cc_ext %s dsf %d BW: min_2ghz %d max_2ghz %d min_5ghz %d max_5ghz %d",
+		   "cc_ext %s dfs %d BW: min_2ghz %d max_2ghz %d min_5ghz %d max_5ghz %d, phy_bitmap: 0x%x",
 		   reg_info->alpha2, reg_info->dfs_region,
 		   reg_info->min_bw_2ghz, reg_info->max_bw_2ghz,
-		   reg_info->min_bw_5ghz, reg_info->max_bw_5ghz);
+		   reg_info->min_bw_5ghz, reg_info->max_bw_5ghz,
+		   reg_info->phybitmap);
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI,
 		   "num_2ghz_reg_rules %d num_5ghz_reg_rules %d",

base-commit: 140accd3f29eee6507f8a51bc38e85c119aedf14
-- 
2.17.1

