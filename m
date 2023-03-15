Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8BB6BB49C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 14:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjCON3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjCON3d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 09:29:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2F2E0E1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 06:29:31 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FC4r1h003779;
        Wed, 15 Mar 2023 13:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kqO/erB5nXqTQ0RjoPSaCQr0/FRemTLyjK0d8hnSdic=;
 b=gt66MyCuBpt/wusZ/ZGMPZ8S/BIDmgxJhhonMiJd8l9Dm/0s/S1T9LVLbOQzQcKfreJ0
 /9ukw2KMPoHCnjtfHn0IIvL+Q5aSbQE6QT10fbWq2z36NYXLV2hEHPJ2IyTJKHT2F5cX
 quaqMXr9ONAlMAAEM2Qo5pMELtZ2TZXZ9bpLWbKa5+6pHwTsXhQ+MJzbH3PsLofqPRyK
 /j9xuLXql1shijv+mvmWje8WvhO0CQl7pTf93gSr78QRZI1mKpVtey76HGu9Cdq5XeVH
 fqnBHpcqaR8MWcnzP9E0rA3+impdbyCUqGGx1fCCMZjB1diMXBSKuKebJpXplpCWsFhp LA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c2sm0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FDTQpR028926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:26 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 06:29:25 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 3/9] wifi: mac80211: add combined power type definition for 6 GHz
Date:   Wed, 15 Mar 2023 18:58:58 +0530
Message-ID: <20230315132904.31779-4-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: t4TXh6W0_JPeICtTJ2LHxYwpQ6R-i_mb
X-Proofpoint-ORIG-GUID: t4TXh6W0_JPeICtTJ2LHxYwpQ6R-i_mb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6 GHz regulatory domain introduces different power modes for 6 GHz AP
operation - Low Power Indoor(LPI), Standard Power(SP) and Very Low
Power(VLP). 6 GHz STAs could be operated as either Regular or
Subordinate clients. We have separate definitions of AP and client.

However, during concurrency (multi-interfaces), it would be
difficult to keep different enum containers for different interface
types in order to track its power mode.

Add new combined power type definition for 6 GHz interfaces. Also add
support to convert existing AP/Client Power type to this new combined
power type enum.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h       | 19 ++++++++++++
 include/uapi/linux/nl80211.h | 38 +++++++++++++++++++++++
 net/wireless/util.c          | 60 ++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d64481d8d871..7bc9ff9c3f36 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6065,6 +6065,25 @@ ieee80211_frequency_to_channel(int freq)
 struct ieee80211_channel *
 ieee80211_get_channel_khz(struct wiphy *wiphy, u32 freq);
 
+/**
+ * ieee80211_ap_reg_power_to_reg_power_mode - convert AP specific 6 GHz power
+ *				type into combined 6 GHz power type
+ * @ap_type: AP's power mode
+ * Return: Power mode as referenced in &enum nl80211_regulatory_power_modes
+ */
+enum nl80211_regulatory_power_modes
+ieee80211_ap_reg_power_to_reg_power_mode(enum ieee80211_ap_reg_power ap_type);
+
+/**
+ * ieee80211_client_reg_power_to_reg_power_mode - convert Client specific 6 GHz
+ *				power type into combined 6 GHz power type
+ * @client_type: Client's power mode
+ * @ap_type: AP's power mode to which this client is associating
+ * Return: Power mode as referenced in &enum nl80211_regulatory_power_modes
+ */
+enum nl80211_regulatory_power_modes
+ieee80211_client_reg_power_to_reg_power_mode(enum ieee80211_client_reg_power client_type,
+					     enum ieee80211_ap_reg_power ap_type);
 /**
  * ieee80211_get_channel - get channel struct from wiphy for specified frequency
  *
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 844d2000b4e1..eddccd491fc9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4075,6 +4075,44 @@ enum nl80211_band_attr {
 
 #define NL80211_BAND_ATTR_HT_CAPA NL80211_BAND_ATTR_HT_CAPA
 
+/**
+ * enum nl80211_regulatory_power_modes - 6 GHz regulatory power
+ *					 modes
+ * @NL80211_REG_PWR_MODE_AP_SP: Low Power Indoor (Access Point)
+ * @NL80211_REG_PWR_MODE_AP_SP: Standard Power (Access Point)
+ * @NL80211_REG_PWR_MODE_AP_VLP: Very Low Power (Access Point)
+ * @NL80211_REG_PWR_MODE_REGULAR_CLIENT_LPI: Low Power Indoor (Regular
+ *					     or Default Client)
+ * @NL80211_REG_PWR_MODE_REGULAR_CLIENT_SP: Standard Power (Regular
+ *					    or Default Client)
+ * @NL80211_REG_PWR_MODE_REGULAR_CLIENT_VLP: Very Low Power (Regular
+ *					     or Default Client)
+ * @NL80211_REG_PWR_MODE_SUBORDINATE_CLIENT_LPI: Low Power Indoor
+ *						 (Subordinate Client)
+ * @NL80211_REG_PWR_MODE_SUBORDINATE_CLIENT_SP: Standard Power
+ *						(Subordinate Client)
+ * @NL80211_REG_PWR_MODE_SUBORDINATE_CLIENT_VLP: Very Low Power
+ *						 (Subordinate Client)
+ * @__NL80211_REG_PWR_MODE_LAST: Internal use
+ * @NL80211_REG_PWR_MODE_MAX: Max supported number of power
+ *			      modes
+ */
+enum nl80211_regulatory_power_modes {
+	NL80211_REG_PWR_MODE_AP_LPI,
+	NL80211_REG_PWR_MODE_AP_SP,
+	NL80211_REG_PWR_MODE_AP_VLP,
+	NL80211_REG_PWR_MODE_REGULAR_CLIENT_LPI,
+	NL80211_REG_PWR_MODE_REGULAR_CLIENT_SP,
+	NL80211_REG_PWR_MODE_REGULAR_CLIENT_VLP,
+	NL80211_REG_PWR_MODE_SUBORDINATE_CLIENT_LPI,
+	NL80211_REG_PWR_MODE_SUBORDINATE_CLIENT_SP,
+	NL80211_REG_PWR_MODE_SUBORDINATE_CLIENT_VLP,
+
+	/* keep last */
+	__NL80211_REG_PWR_MODE_LAST,
+	NL80211_REG_PWR_MODE_MAX = __NL80211_REG_PWR_MODE_LAST,
+};
+
 /**
  * enum nl80211_wmm_rule - regulatory wmm rule
  *
diff --git a/net/wireless/util.c b/net/wireless/util.c
index d1a89e82ead0..56a23e5797f4 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -190,6 +190,66 @@ struct ieee80211_channel *ieee80211_get_channel_khz(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(ieee80211_get_channel_khz);
 
+enum nl80211_regulatory_power_modes
+ieee80211_ap_reg_power_to_reg_power_mode(enum ieee80211_ap_reg_power ap_type)
+{
+	switch (ap_type) {
+	case IEEE80211_REG_LPI_AP:
+		return NL80211_REG_PWR_MODE_AP_LPI;
+	case IEEE80211_REG_SP_AP:
+		return NL80211_REG_PWR_MODE_AP_SP;
+	case IEEE80211_REG_VLP_AP:
+		return NL80211_REG_PWR_MODE_AP_VLP;
+	default:
+		return NL80211_REG_PWR_MODE_MAX;
+	}
+}
+EXPORT_SYMBOL(ieee80211_ap_reg_power_to_reg_power_mode);
+
+/* ieee80211_client_reg_power_to_reg_power_mode: Accepts the individual power type of
+ * a 6 GHz client and power type of AP to which the client is associating and returns
+ * the final combined power mode as enumerated in &enum nl80211_regulatory_power_modes.
+ *
+ * Unlike AP, for client there is no direct mapping because final power mode of
+ * operation of client is dependent upon the power type of AP.
+ * For example -
+ * If client is a Regular client and AP is Low Power Indoor then combined power mode
+ * will be Regular Low Power Indoor where as if AP is Standard Power, then it will be
+ * Regular Standard Power Mode.
+ */
+enum nl80211_regulatory_power_modes
+ieee80211_client_reg_power_to_reg_power_mode(enum ieee80211_client_reg_power client_type,
+					     enum ieee80211_ap_reg_power ap_type)
+{
+	switch (client_type) {
+	case IEEE80211_REG_DEFAULT_CLIENT:
+		switch (ap_type) {
+		case IEEE80211_REG_LPI_AP:
+			return NL80211_REG_PWR_MODE_REGULAR_CLIENT_LPI;
+		case IEEE80211_REG_SP_AP:
+			return NL80211_REG_PWR_MODE_REGULAR_CLIENT_SP;
+		case IEEE80211_REG_VLP_AP:
+			return NL80211_REG_PWR_MODE_REGULAR_CLIENT_VLP;
+		default:
+			return NL80211_REG_PWR_MODE_MAX;
+		}
+	case IEEE80211_REG_SUBORDINATE_CLIENT:
+		switch (ap_type) {
+		case IEEE80211_REG_LPI_AP:
+			return NL80211_REG_PWR_MODE_SUBORDINATE_CLIENT_LPI;
+		case IEEE80211_REG_SP_AP:
+			return NL80211_REG_PWR_MODE_SUBORDINATE_CLIENT_SP;
+		case IEEE80211_REG_VLP_AP:
+			return NL80211_REG_PWR_MODE_SUBORDINATE_CLIENT_VLP;
+		default:
+			return NL80211_REG_PWR_MODE_MAX;
+		}
+	default:
+		return NL80211_REG_PWR_MODE_MAX;
+	}
+}
+EXPORT_SYMBOL(ieee80211_client_reg_power_to_reg_power_mode);
+
 static void set_mandatory_flags_band(struct ieee80211_supported_band *sband)
 {
 	int i, want;
-- 
2.17.1

