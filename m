Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2056BB49A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 14:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjCON3a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjCON32 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 09:29:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BC4132EF
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 06:29:26 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FALMJo010097;
        Wed, 15 Mar 2023 13:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=IuS8CiINANoWXW3ZqLYC9o9ewOdKaPcsvL9bh4EgnHg=;
 b=NmCiNyj8ryfp7mW5SJDrywZ+LvFgrlgX2e8khp/UCRg+jlqFG/0+4qVP9xg4raqh6TAu
 ea+I9vGUD7qrJIjoA4ZmucXoh/l+QU9mUznBmzGkmAZ1nFoO73oXLBXr4f2NMIi8DPUS
 0PIXuzj4fpO2VjjFzv99G5ZKrIzSqSH8VV7g/W6tu5xDfK8kGv8lF+Bkqp0hi2ZU8T0C
 CJ/0CJneV7EsZafk2eTKukCvmu5Tmrxhkr26j+PaIk7bQWjJwatnuMh3ObpRHiTp3weB
 kDOUJT80m6tluKo9u7moIaZlhtRcNeEAjXmO2UrzJ1D6T1o5qqfaRNLWlL/I+ICmvixl Eg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2cshp08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FDTN6M023329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:23 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 06:29:21 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 1/9] wifi: mac80211: rework on 6 GHz power type definition
Date:   Wed, 15 Mar 2023 18:58:56 +0530
Message-ID: <20230315132904.31779-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230315132904.31779-1-quic_adisi@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ic_bRCxprSQ0DS5u9nm0-r8YEgNoEwrY
X-Proofpoint-ORIG-GUID: ic_bRCxprSQ0DS5u9nm0-r8YEgNoEwrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=891
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6 GHz regulatory domain introduces different modes for 6 GHz AP
operation - Low Power Indoor(LPI), Standard Power(SP) and Very Low
Power(VLP). 6 GHz non-AP STAs could be operated as either Regular
or Subordinate clients. We have separate definitions of AP and
client.

However, IEEE80211_REG_UNSET_* is not a defined power type.
Also due to IEEE80211_REG_UNSET_*, it is difficult to use
_MAX to size arrays.

Move IEEE80211_REG_UNSET_* to last after *_MAX for both AP and
client power mode enums.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/linux/ieee80211.h | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2463bdd2a382..24d4b5ef3de2 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2173,41 +2173,48 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 			      unsigned int max_vht_nss);
 
 /**
- * enum ieee80211_ap_reg_power - regulatory power for a Access Point
+ * enum ieee80211_ap_reg_power - regulatory power for an Access Point
  *
- * @IEEE80211_REG_UNSET_AP: Access Point has no regulatory power mode
  * @IEEE80211_REG_LPI: Indoor Access Point
- * @IEEE80211_REG_SP: Standard power Access Point
- * @IEEE80211_REG_VLP: Very low power Access Point
- * @IEEE80211_REG_AP_POWER_AFTER_LAST: internal
+ * @IEEE80211_REG_SP: Standard Power Access Point
+ * @IEEE80211_REG_VLP: Very Low Power Access Point
+ * @__IEEE80211_REG_AP_POWER_AFTER_LAST: internal use
  * @IEEE80211_REG_AP_POWER_MAX: maximum value
+ * @IEEE80211_REG_UNSET_AP: Access Point has no regulatory power
+ *	mode.
  */
 enum ieee80211_ap_reg_power {
-	IEEE80211_REG_UNSET_AP,
 	IEEE80211_REG_LPI_AP,
 	IEEE80211_REG_SP_AP,
 	IEEE80211_REG_VLP_AP,
-	IEEE80211_REG_AP_POWER_AFTER_LAST,
+
+	/* keep last */
+	__IEEE80211_REG_AP_POWER_AFTER_LAST,
 	IEEE80211_REG_AP_POWER_MAX =
-		IEEE80211_REG_AP_POWER_AFTER_LAST - 1,
+		__IEEE80211_REG_AP_POWER_AFTER_LAST - 1,
+	/* always last in order to use _MAX to size arrays */
+	IEEE80211_REG_UNSET_AP = 0xFF,
 };
 
 /**
  * enum ieee80211_client_reg_power - regulatory power for a client
  *
- * @IEEE80211_REG_UNSET_CLIENT: Client has no regulatory power mode
  * @IEEE80211_REG_DEFAULT_CLIENT: Default Client
  * @IEEE80211_REG_SUBORDINATE_CLIENT: Subordinate Client
- * @IEEE80211_REG_CLIENT_POWER_AFTER_LAST: internal
+ * @__IEEE80211_REG_CLIENT_POWER_AFTER_LAST: internal use
  * @IEEE80211_REG_CLIENT_POWER_MAX: maximum value
+ * @IEEE80211_REG_UNSET_CLIENT: Client has no regulatory power mode
  */
 enum ieee80211_client_reg_power {
-	IEEE80211_REG_UNSET_CLIENT,
 	IEEE80211_REG_DEFAULT_CLIENT,
 	IEEE80211_REG_SUBORDINATE_CLIENT,
-	IEEE80211_REG_CLIENT_POWER_AFTER_LAST,
+
+	/* keep last */
+	__IEEE80211_REG_CLIENT_POWER_AFTER_LAST,
 	IEEE80211_REG_CLIENT_POWER_MAX =
-		IEEE80211_REG_CLIENT_POWER_AFTER_LAST - 1,
+		__IEEE80211_REG_CLIENT_POWER_AFTER_LAST - 1,
+	/* always last in order to use _MAX to size arrays */
+	IEEE80211_REG_UNSET_CLIENT = 0XFF,
 };
 
 /* 802.11ax HE MAC capabilities */
-- 
2.17.1

