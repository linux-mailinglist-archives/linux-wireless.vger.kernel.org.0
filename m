Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B9A7B7C1B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbjJDJ2l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241796AbjJDJ2l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:28:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017A2AD
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:28:36 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948Kh6O030032;
        Wed, 4 Oct 2023 09:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=kLDz14lHunwK9akFb62TEBE7+9iOIMH+zi0jkz74IkI=;
 b=cxcT68tmEoBiJMeYlvwj9EPXzPOo7S9LNh3uVCtgFO5132aGPfHpBA+hS3J8fBK7Z3AH
 zQ1hs4jctn/5caJU+0rXo1CfW6vgodjOjZK/3hvF8SwQAGCjazKsGXGqnKq7k6mhsBql
 gMx2DircxpLYOsjubADHe2CubbDQMBeLxw4O2NSHK7gFqtSgJMlqouVC4/ISegMZdx35
 lnR09bNxnTNZIRnT6bdcdsYesAY2Uw6kjTyR9A8OkYBcRhsqtFmrTZZjxWy6fXZt8hmZ
 nFLhpWZxiREK7hluwmHCccumDcTdDynPQT7Nzpnhayex18ADta7r98FSFNlD9uqn0RIB tQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgynh8nrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 09:28:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3949SXUF002221
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 09:28:33 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 4 Oct 2023 02:28:31 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH] wifi: ath12k: add parsing of phy bitmap for reg rules
Date:   Wed, 4 Oct 2023 14:58:18 +0530
Message-ID: <20231004092818.25130-1-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ftj6Zbu2q66TmkVVPYhr3LInEkNZU7j-
X-Proofpoint-ORIG-GUID: Ftj6Zbu2q66TmkVVPYhr3LInEkNZU7j-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
For example, in a few countries HE/EHT Operation is not allowed. For such
countries, firmware indicates this via phy bitmap in each reg rule.

Currently, there is no logic to parse this info and then pass it on to the
cfg80211/regulatory.

Add parsing of this phy bitmap from the regulatory channel change event and
then accordingly map it to cfg80211/regulatory flags and pass it on to it.

While at it, correct typo in debug print: s/dsf/dfs.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 14 ++++++++++++++
 drivers/net/wireless/ath/ath12k/reg.h |  6 ++++++
 drivers/net/wireless/ath/ath12k/wmi.c |  5 +++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 6ede91ebc8e1..5c006256c82a 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -314,6 +314,19 @@ static u32 ath12k_map_fw_reg_flags(u16 reg_flags)
 	return flags;
 }
 
+static u32 ath12k_map_fw_phy_flags(u32 phy_flags)
+{
+	u32 flags = 0;
+
+	if (phy_flags & ATH12K_REG_PHY_BITMAP_NO11AX)
+		flags |= NL80211_RRF_NO_HE;
+
+	if (phy_flags & ATH12K_REG_PHY_BITMAP_NO11BE)
+		flags |= NL80211_RRF_NO_EHT;
+
+	return flags;
+}
+
 static bool
 ath12k_reg_can_intersect(struct ieee80211_reg_rule *rule1,
 			 struct ieee80211_reg_rule *rule2)
@@ -638,6 +651,7 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 		}
 
 		flags |= ath12k_map_fw_reg_flags(reg_rule->flags);
+		flags |= ath12k_map_fw_phy_flags(reg_info->phybitmap);
 
 		ath12k_reg_update_rule(tmp_regd->reg_rules + i,
 				       reg_rule->start_freq,
diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
index 56d009a47234..35569f03042d 100644
--- a/drivers/net/wireless/ath/ath12k/reg.h
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -83,6 +83,12 @@ struct ath12k_reg_info {
 		[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
 };
 
+/* Phy bitmaps */
+enum ath12k_reg_phy_bitmap {
+	ATH12K_REG_PHY_BITMAP_NO11AX	= BIT(5),
+	ATH12K_REG_PHY_BITMAP_NO11BE	= BIT(6),
+};
+
 void ath12k_reg_init(struct ath12k *ar);
 void ath12k_reg_free(struct ath12k_base *ab);
 void ath12k_regd_update_work(struct work_struct *work);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 80b3d51387b8..558ced12f7f7 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4611,10 +4611,11 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 	}
 
 	ath12k_dbg(ab, ATH12K_DBG_WMI,
-		   "%s:cc_ext %s dsf %d BW: min_2g %d max_2g %d min_5g %d max_5g %d",
+		   "%s:cc_ext %s dfs %d BW: min_2g %d max_2g %d min_5g %d max_5g %d, phy_bitmap: 0x%x",
 		   __func__, reg_info->alpha2, reg_info->dfs_region,
 		   reg_info->min_bw_2g, reg_info->max_bw_2g,
-		   reg_info->min_bw_5g, reg_info->max_bw_5g);
+		   reg_info->min_bw_5g, reg_info->max_bw_5g,
+		   reg_info->phybitmap);
 
 	ath12k_dbg(ab, ATH12K_DBG_WMI,
 		   "num_2g_reg_rules %d num_5g_reg_rules %d",
-- 
2.17.1

