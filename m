Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5E6E93B4
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjDTMJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjDTMJR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:09:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE621706
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:09:16 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KC2F4Y011443;
        Thu, 20 Apr 2023 12:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4rD4Xw+UbZjzwLecppcLdIPwKGeRQ7L1flYMghdCPH4=;
 b=SQ4gfBHDuHLIrXChlrWeLE5ZN+stY3y1J7BQC2nXsO1DxcQa9sKMLBOV0fHtPbORumbI
 dxnNP/Po+uz+XsRtr4uqjxdHXY4xF5z1Yj+6yntxyH2XCGWYON+yF5gk5zDOkDwW/EYl
 RO0vqA2DonB2R2XrDeIbS1upW+VLT5aNqMXsMu9aE8U/F3+2FlIn29kG7exOPkJ52zYP
 Cc4WC36TLnMULQBsZoKbxJQM+5dRRLqyfa1pFw1yel2jUr7Nz+SkMF8JgKd9cSvRYggk
 vJU6BGzHvro7/BLOJzkuDiKHnFc9FtVIgEpyCM7hkET+Avdd8cs4f3gejLvO7Ihg8hkL Tg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2xuhrxeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:09:14 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33KC9EuH025019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:09:14 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 20 Apr 2023 05:09:12 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 1/4] wifi: ath11k: remove unused function ath11k_tm_event_wmi
Date:   Thu, 20 Apr 2023 17:38:37 +0530
Message-ID: <20230420120840.18712-2-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230420120840.18712-1-quic_rajkbhag@quicinc.com>
References: <20230420120840.18712-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c0tWztBnNVAVPj3f6O1MoKKXUQwLsGgh
X-Proofpoint-GUID: c0tWztBnNVAVPj3f6O1MoKKXUQwLsGgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_08,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>

The function ath11k_tm_event_wmi() is only defined and it is not used
anywhere. Hence remove unused function ath11k_tm_event_wmi().

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/testmode.c | 64 +---------------------
 drivers/net/wireless/ath/ath11k/testmode.h |  8 +--
 2 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index 4bf1931adbaa..ebeca5eb6a67 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "testmode.h"
@@ -20,69 +21,6 @@ static const struct nla_policy ath11k_tm_policy[ATH11K_TM_ATTR_MAX + 1] = {
 	[ATH11K_TM_ATTR_VERSION_MINOR]	= { .type = NLA_U32 },
 };
 
-/* Returns true if callee consumes the skb and the skb should be discarded.
- * Returns false if skb is not used. Does not sleep.
- */
-bool ath11k_tm_event_wmi(struct ath11k *ar, u32 cmd_id, struct sk_buff *skb)
-{
-	struct sk_buff *nl_skb;
-	bool consumed;
-	int ret;
-
-	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
-		   "testmode event wmi cmd_id %d skb %pK skb->len %d\n",
-		   cmd_id, skb, skb->len);
-
-	ath11k_dbg_dump(ar->ab, ATH11K_DBG_TESTMODE, NULL, "", skb->data, skb->len);
-
-	spin_lock_bh(&ar->data_lock);
-
-	consumed = true;
-
-	nl_skb = cfg80211_testmode_alloc_event_skb(ar->hw->wiphy,
-						   2 * sizeof(u32) + skb->len,
-						   GFP_ATOMIC);
-	if (!nl_skb) {
-		ath11k_warn(ar->ab,
-			    "failed to allocate skb for testmode wmi event\n");
-		goto out;
-	}
-
-	ret = nla_put_u32(nl_skb, ATH11K_TM_ATTR_CMD, ATH11K_TM_CMD_WMI);
-	if (ret) {
-		ath11k_warn(ar->ab,
-			    "failed to put testmode wmi event cmd attribute: %d\n",
-			    ret);
-		kfree_skb(nl_skb);
-		goto out;
-	}
-
-	ret = nla_put_u32(nl_skb, ATH11K_TM_ATTR_WMI_CMDID, cmd_id);
-	if (ret) {
-		ath11k_warn(ar->ab,
-			    "failed to put testmode wmi even cmd_id: %d\n",
-			    ret);
-		kfree_skb(nl_skb);
-		goto out;
-	}
-
-	ret = nla_put(nl_skb, ATH11K_TM_ATTR_DATA, skb->len, skb->data);
-	if (ret) {
-		ath11k_warn(ar->ab,
-			    "failed to copy skb to testmode wmi event: %d\n",
-			    ret);
-		kfree_skb(nl_skb);
-		goto out;
-	}
-
-	cfg80211_testmode_event(nl_skb, GFP_ATOMIC);
-
-out:
-	spin_unlock_bh(&ar->data_lock);
-
-	return consumed;
-}
-
 static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
 {
 	struct sk_buff *skb;
diff --git a/drivers/net/wireless/ath/ath11k/testmode.h b/drivers/net/wireless/ath/ath11k/testmode.h
index aaa122ed9069..ffdb0c30b276 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.h
+++ b/drivers/net/wireless/ath/ath11k/testmode.h
@@ -1,24 +1,18 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include "core.h"
 
 #ifdef CONFIG_NL80211_TESTMODE
 
-bool ath11k_tm_event_wmi(struct ath11k *ar, u32 cmd_id, struct sk_buff *skb);
 int ath11k_tm_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  void *data, int len);
 
 #else
 
-static inline bool ath11k_tm_event_wmi(struct ath11k *ar, u32 cmd_id,
-				       struct sk_buff *skb)
-{
-	return false;
-}
-
 static inline int ath11k_tm_cmd(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				void *data, int len)
-- 
2.17.1

