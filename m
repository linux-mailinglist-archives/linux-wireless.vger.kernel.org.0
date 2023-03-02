Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0C06A7C3D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Mar 2023 09:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCBIGz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Mar 2023 03:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCBIGr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Mar 2023 03:06:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3417435243
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 00:06:44 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32275Jmn016691;
        Thu, 2 Mar 2023 08:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rOvmt0cB/ko+XSpd34//hPJIH//J9McIfNZ5+MkZlTg=;
 b=O1yw1zAbQ5Rx/kb/4l3SzLsrqZ5u4u+4pz5d2s+TXYJ9Fcp56U1x5xcshsK4Ceh/RT8P
 6hyaRIoGC3s0/GGVrP9VLudcapldymN3xsWMUjoU2fFXd4grh3+uD7L3ougbWgcMddm5
 lKOwNJ3J3JTv/fL0EMM3l9R3+vE/WfWoY8MvVv9r8/uNISCiOsbZTpao7dEn4oF5vRDq
 h59LfVN7I5oipwA5dXLHeBnJgtTalAtUm/wyxxVYPH3gFxCieXzBz1tr5B/86Iw+CsI5
 k41ng7g16FQ2RugWBQ1ZclopVINkGdG6G5xtDfGKiDVaHDjNnP+UcYJMPkeMgQGYjgT0 SQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2q3jg4ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 08:06:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 322866a6016402
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 08:06:06 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 2 Mar 2023 00:06:04 -0800
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v2 7/7] wifi: cfg80211: save 6 GHz power mode of the regulatory rules
Date:   Thu, 2 Mar 2023 13:35:34 +0530
Message-ID: <20230302080534.22821-8-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230302080534.22821-1-quic_adisi@quicinc.com>
References: <20230302080534.22821-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HJQRQHcAT2gjX5y6XyS3gwc1WArmX4R_
X-Proofpoint-GUID: HJQRQHcAT2gjX5y6XyS3gwc1WArmX4R_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_04,2023-03-02_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 0f37376912c6..91f029d7085b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4336,6 +4336,8 @@ enum nl80211_reg_type {
  *	If not present or 0 default CAC time will be used.
  * @NL80211_ATTR_POWER_RULE_PSD: power spectral density (in dBm).
  *	This could be negative.
+ * @NL80211_ATTR_REG_POWER_MODE: the regulatory power mode for 6 GHz rules.
+ *	Referenced from &enum nl80211_regulatory_power_modes
  * @NL80211_REG_RULE_ATTR_MAX: highest regulatory rule attribute number
  *	currently defined
  * @__NL80211_REG_RULE_ATTR_AFTER_LAST: internal use
@@ -4355,6 +4357,8 @@ enum nl80211_reg_rule_attr {
 
 	NL80211_ATTR_POWER_RULE_PSD,
 
+	NL80211_ATTR_REG_POWER_MODE,
+
 	/* keep last */
 	__NL80211_REG_RULE_ATTR_AFTER_LAST,
 	NL80211_REG_RULE_ATTR_MAX = __NL80211_REG_RULE_ATTR_AFTER_LAST - 1
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 19688935251f..cbbf71028171 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8473,6 +8473,13 @@ static int nl80211_put_regdom(const struct ieee80211_regdomain *regdom,
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
@@ -8652,6 +8659,10 @@ static const struct nla_policy reg_rule_policy[NL80211_REG_RULE_ATTR_MAX + 1] =
 	[NL80211_ATTR_POWER_RULE_MAX_EIRP]	= { .type = NLA_U32 },
 	[NL80211_ATTR_DFS_CAC_TIME]		= { .type = NLA_U32 },
 	[NL80211_ATTR_POWER_RULE_PSD]		= { .type = NLA_S8 },
+	[NL80211_ATTR_REG_POWER_MODE]		=
+			  NLA_POLICY_RANGE(NLA_U8,
+					   NL80211_REG_PWR_MODE_AP_LPI,
+					   NL80211_REG_PWR_MODE_MAX - 1),
 };
 
 static int parse_reg_rule(struct nlattr *tb[],
@@ -8699,6 +8710,15 @@ static int parse_reg_rule(struct nlattr *tb[],
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

