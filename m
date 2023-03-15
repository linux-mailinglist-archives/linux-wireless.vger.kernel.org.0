Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977F46BB4A1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 14:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjCON3r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjCON3j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 09:29:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B73249E2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 06:29:38 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FBJflb002718;
        Wed, 15 Mar 2023 13:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ULgVJs53tRi1qRu/AgX/Rh48jRvgAJYldVOmCCkZAoI=;
 b=MJ55dJ8issZ1zjZ26y5/DSioA+w5KfQ1rtTNNtIdjW+S6SG6KuF7hmXAH7XUi/MGwin5
 n7Vr6nuIRt14A6yvUarjj+BsQ4ov0KtCEwH/uVpAB7kbt/8YgZEV14vmwPj4mRSXH6ln
 gHmmOarCGmYC96w/dqzJFhHfavEN/8Rh23f0ntS30B8IEtkJRxlElpYHwL2CZdgj3LUW
 1WYMAvIBMTrXqcpigF/907keo7+KV5zjFzEIZM4kwRMiS8R8MBjDy+s+CujQPpSMngec
 CPVC+jKNLdQV7IkOt4L9ke0QNlXo6Zgt+yepyhNJJCkqj9GyNuUEMKSKlMGbhZxS6xUq Og== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c89n5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FDTYjF023762
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:34 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 06:29:32 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 7/9] wifi: cfg80211: save 6 GHz power mode of the regulatory rules
Date:   Wed, 15 Mar 2023 18:59:02 +0530
Message-ID: <20230315132904.31779-8-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: miCXgJti9kzR1Tv3GMRUN9b0jam5hsYh
X-Proofpoint-ORIG-GUID: miCXgJti9kzR1Tv3GMRUN9b0jam5hsYh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently when user space demands the reg rules via NL80211_CMD_GET_REG
command, along with Power Spectral Denity (PSD) values, power mode
needs to be advertised since in 6 GHz AP beacon, Tx power envelope
should have PSD info as well which can be opted based on the power
mode. Similarly, via NL80211_CMD_SET_REG command, user space can try
to set regulatory rules and cfg80211 needs to store the incoming power
mode for the rule.

Add support for 6 GHz power mode advertisement in
NL80211_CMD_GET_REG command and saving 6 GHz power mode for reg rules
via NL80211_CMD_SET_REG command.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/uapi/linux/nl80211.h |  4 ++++
 net/wireless/nl80211.c       | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index bff81489fa8a..aa0fcf98aab1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4358,6 +4358,8 @@ enum nl80211_reg_type {
  *	If not present or 0 default CAC time will be used.
  * @NL80211_ATTR_POWER_RULE_PSD: power spectral density (in dBm).
  *	This could be negative.
+ * @NL80211_ATTR_REG_POWER_MODE: the regulatory power mode for 6 GHz rules.
+ *	Referenced from &enum nl80211_regulatory_power_modes
  * @NL80211_REG_RULE_ATTR_MAX: highest regulatory rule attribute number
  *	currently defined
  * @__NL80211_REG_RULE_ATTR_AFTER_LAST: internal use
@@ -4377,6 +4379,8 @@ enum nl80211_reg_rule_attr {
 
 	NL80211_ATTR_POWER_RULE_PSD,
 
+	NL80211_ATTR_REG_POWER_MODE,
+
 	/* keep last */
 	__NL80211_REG_RULE_ATTR_AFTER_LAST,
 	NL80211_REG_RULE_ATTR_MAX = __NL80211_REG_RULE_ATTR_AFTER_LAST - 1
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 042035f26e9f..cdb26aac24d1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8481,6 +8481,13 @@ static int nl80211_put_regdom(const struct ieee80211_regdomain *regdom,
 				reg_rule->dfs_cac_ms))
 			goto nla_put_failure;
 
+		/* Put power mode as well if its a 6 GHz reg rule */
+		if (freq_range->start_freq_khz >= MHZ_TO_KHZ(5925) &&
+		    freq_range->end_freq_khz <= MHZ_TO_KHZ(7125) &&
+		    nla_put_u8(msg, NL80211_ATTR_REG_POWER_MODE,
+			       reg_rule->power_mode))
+			goto nla_put_failure;
+
 		if ((reg_rule->flags & NL80211_RRF_PSD) &&
 		    nla_put_s8(msg, NL80211_ATTR_POWER_RULE_PSD,
 			       reg_rule->psd))
@@ -8660,6 +8667,10 @@ static const struct nla_policy reg_rule_policy[NL80211_REG_RULE_ATTR_MAX + 1] =
 	[NL80211_ATTR_POWER_RULE_MAX_EIRP]	= { .type = NLA_U32 },
 	[NL80211_ATTR_DFS_CAC_TIME]		= { .type = NLA_U32 },
 	[NL80211_ATTR_POWER_RULE_PSD]		= { .type = NLA_S8 },
+	[NL80211_ATTR_REG_POWER_MODE]		=
+			  NLA_POLICY_RANGE(NLA_U8,
+					   NL80211_REG_PWR_MODE_AP_LPI,
+					   NL80211_REG_PWR_MODE_MAX - 1),
 };
 
 static int parse_reg_rule(struct nlattr *tb[],
@@ -8707,6 +8718,15 @@ static int parse_reg_rule(struct nlattr *tb[],
 		reg_rule->dfs_cac_ms =
 			nla_get_u32(tb[NL80211_ATTR_DFS_CAC_TIME]);
 
+	if (freq_range->start_freq_khz >= MHZ_TO_KHZ(5925) &&
+	    freq_range->end_freq_khz <= MHZ_TO_KHZ(7125)) {
+		if (!tb[NL80211_ATTR_REG_POWER_MODE])
+			return -EINVAL;
+
+		reg_rule->power_mode =
+			nla_get_u8(tb[NL80211_ATTR_REG_POWER_MODE]);
+	}
+
 	return 0;
 }
 
-- 
2.17.1

