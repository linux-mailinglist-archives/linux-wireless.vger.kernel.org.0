Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295037A75C7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjITIYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 04:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjITIYY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 04:24:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB28B4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 01:24:18 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K8Js73026663;
        Wed, 20 Sep 2023 08:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=CpNT8heJ7aGAtiWW0n0yahqdyaAamH853Xu0erlyh/4=;
 b=ofD7JhZsmesc3VzS3toSPDScanLlC6tyn0PtOfw2JpTKW1Rych/4tlvuU1T80C+WIN8K
 E/IaHR7c5DivzeUCMay1YvyaudI+YL6WGmtuWDYRkuLh48kljT94BJPnFs4X5RlUBcJS
 0DHlnVpbITofC7LuBiITfO0rlyABhXRB+XcQ47XEi6aIaXFY638WBaqewVSXySud3IqV
 4fTwA28i9WoIgnKDAZprafmm1gdJyP8k43j4e81fFvMr0t4gdV8/KKVtVMOE9icKQhY6
 ub3dzrM/pJ5Ek8jUtHNn4A6lr209k5nKzyCIGUS1AhpY9mPlZFsbnm/GPAl2B5TOThfq mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7qj90pu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 08:24:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38K8OED4005501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 08:24:14 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 20 Sep 2023 01:24:12 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>,
        <quic_jjohnson@quicinc.com>, <quic_wgong@quicinc.com>
Subject: [PATCH v6 04/13] wifi: ath11k: update regulatory rules when interface added
Date:   Wed, 20 Sep 2023 04:23:40 -0400
Message-ID: <20230920082349.29111-5-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230920082349.29111-1-quic_wgong@quicinc.com>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w9dIwEBegsjZJeZR-2R5tVKT4Jkv0_jA
X-Proofpoint-ORIG-GUID: w9dIwEBegsjZJeZR-2R5tVKT4Jkv0_jA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_02,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are two power types for 6 GHz regulatory, one is AP, another
is client.

When wlan boot up, WMI_REG_CHAN_LIST_CC_EXT_EVENTID is sent from
firmware at an early stage, the interface mode is not decided at
this point, then ath11k select reg rules of AP type as default.

After interface is created, it is exactly decided the interface
type such as AP/mesh point/station. Then ath11k need to update
reg rules to the exact power type matched to the interface type.

The client power type is used for station interface, and AP power
type is used for AP/mesh point interface.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 14 ++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c071bf5841af..0512c8b0661c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6714,6 +6714,12 @@ static int ath11k_mac_vdev_delete(struct ath11k *ar, struct ath11k_vif *arvif)
 	return ret;
 }
 
+bool ath11k_mac_supports_6ghz_cc_ext(struct ath11k *ar)
+{
+	return (test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
+			 ar->ab->wmi_ab.svc_map)) && ar->supports_6ghz;
+}
+
 static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
@@ -6939,6 +6945,14 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				    ret);
 	}
 
+	if (ath11k_mac_supports_6ghz_cc_ext(ar)) {
+		struct cur_regulatory_info *reg_info;
+
+		reg_info = &ab->reg_info_store[ar->pdev_idx];
+		ath11k_dbg(ab, ATH11K_DBG_MAC, "mac interface added to change reg rules\n");
+		ath11k_reg_handle_chan_list(ab, reg_info, IEEE80211_REG_LPI_AP);
+	}
+
 	mutex_unlock(&ar->conf_mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index e4835e0b7998..94c5c61ae2bb 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -155,7 +155,7 @@ struct ath11k_vif *ath11k_mac_get_arvif_by_vdev_id(struct ath11k_base *ab,
 u8 ath11k_mac_get_target_pdev_id(struct ath11k *ar);
 u8 ath11k_mac_get_target_pdev_id_from_vif(struct ath11k_vif *arvif);
 struct ath11k_vif *ath11k_mac_get_vif_up(struct ath11k_base *ab);
-
+bool ath11k_mac_supports_6ghz_cc_ext(struct ath11k *ar);
 struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, u32 vdev_id);
 struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id);
 void ath11k_mac_drain_tx(struct ath11k *ar);
-- 
2.40.1

