Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B96BB49B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 14:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjCON3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 09:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjCON3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 09:29:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA523800A
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 06:29:28 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FALtAS028808;
        Wed, 15 Mar 2023 13:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6JxMriThy8rHyVmNmNdnGa3RIbvkTohNhIII6hIdg0Q=;
 b=YRshfPw/GTqbIb2IL9hZRR2RKc+91bXh5avbbZBDwbUvnY0T+5BYLyjEpyFvLUiX8l3e
 q1q7493o0V9kC7mdfXf+GT5IsnfqOqWrrzLO3yQt8+jmUoqPYRg50d28JdwJpkNStr3f
 a6Z6O4xqH02xzlFd+6azTGdATUMHB+bbEZGnyDgV9XiKLSz/8ufm2p5GZ22IFxVT+CDj
 vN0ZcsMS21j1wHfbGOafGKapUrWH5tWuBZX8oL+IQqeOH/hIOrg8ZC/S9CB0N9Bcd1uT
 BY23BWtE9BGVJdxqIv0swDuhfsqY/qu2BacVd35ZdVDhDjd60yiLyas0nNM/n4dMz88c Gg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2c21nks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FDTPJ0000806
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:25 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 06:29:23 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Wen Gong <quic_wgong@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 2/9] wifi: cfg80211: save Power Spectral Density (PSD) of the regulatory rule
Date:   Wed, 15 Mar 2023 18:58:57 +0530
Message-ID: <20230315132904.31779-3-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: vf_bdy-7E0IFp9SdzNe_SdmVl3QFi6Xq
X-Proofpoint-ORIG-GUID: vf_bdy-7E0IFp9SdzNe_SdmVl3QFi6Xq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

6 GHz regulatory domains introduces Power Spectral Density (PSD).
The PSD value of the regulatory rule should be taken into effect
for the ieee80211_channels falling into that particular regulatory
rule. Save the values in the channel which has PSD value and add
nl80211 attributes accordingly to handle it.

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Co-developed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h       |  5 +++++
 include/net/regulatory.h     |  1 +
 include/uapi/linux/nl80211.h |  9 +++++++++
 net/wireless/nl80211.c       | 18 ++++++++++++++++++
 net/wireless/reg.c           | 17 +++++++++++++++++
 5 files changed, 50 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7cebba1c4135..d64481d8d871 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -115,6 +115,8 @@ struct wiphy;
  *	This may be due to the driver or due to regulatory bandwidth
  *	restrictions.
  * @IEEE80211_CHAN_NO_EHT: EHT operation is not permitted on this channel.
+ * @IEEE80211_CHAN_PSD: power spectral density (in dBm)
+ *	on this channel
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED		= 1<<0,
@@ -138,6 +140,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_16MHZ		= 1<<18,
 	IEEE80211_CHAN_NO_320MHZ	= 1<<19,
 	IEEE80211_CHAN_NO_EHT		= 1<<20,
+	IEEE80211_CHAN_PSD              = 1<<21,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
@@ -171,6 +174,7 @@ enum ieee80211_channel_flags {
  *	on this channel.
  * @dfs_state_entered: timestamp (jiffies) when the dfs state was entered.
  * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS channels.
+ * @psd: power spectral density (in dBm)
  */
 struct ieee80211_channel {
 	enum nl80211_band band;
@@ -187,6 +191,7 @@ struct ieee80211_channel {
 	enum nl80211_dfs_state dfs_state;
 	unsigned long dfs_state_entered;
 	unsigned int dfs_cac_ms;
+	s8 psd;
 };
 
 /**
diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index 896191f420d5..c2bf0b39fd1e 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -224,6 +224,7 @@ struct ieee80211_reg_rule {
 	u32 flags;
 	u32 dfs_cac_ms;
 	bool has_wmm;
+	s8 psd;
 };
 
 struct ieee80211_regdomain {
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9a0ac0363f1f..844d2000b4e1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4167,6 +4167,8 @@ enum nl80211_wmm_rule {
  *	as the primary or any of the secondary channels isn't possible
  * @NL80211_FREQUENCY_ATTR_NO_EHT: EHT operation is not allowed on this channel
  *	in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_PSD: power spectral density (in dBm)
+ *	is allowed on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4205,6 +4207,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_16MHZ,
 	NL80211_FREQUENCY_ATTR_NO_320MHZ,
 	NL80211_FREQUENCY_ATTR_NO_EHT,
+	NL80211_FREQUENCY_ATTR_PSD,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4305,6 +4308,8 @@ enum nl80211_reg_type {
  * 	a given frequency range. The value is in mBm (100 * dBm).
  * @NL80211_ATTR_DFS_CAC_TIME: DFS CAC time in milliseconds.
  *	If not present or 0 default CAC time will be used.
+ * @NL80211_ATTR_POWER_RULE_PSD: power spectral density (in dBm).
+ *	This could be negative.
  * @NL80211_REG_RULE_ATTR_MAX: highest regulatory rule attribute number
  *	currently defined
  * @__NL80211_REG_RULE_ATTR_AFTER_LAST: internal use
@@ -4322,6 +4327,8 @@ enum nl80211_reg_rule_attr {
 
 	NL80211_ATTR_DFS_CAC_TIME,
 
+	NL80211_ATTR_POWER_RULE_PSD,
+
 	/* keep last */
 	__NL80211_REG_RULE_ATTR_AFTER_LAST,
 	NL80211_REG_RULE_ATTR_MAX = __NL80211_REG_RULE_ATTR_AFTER_LAST - 1
@@ -4404,6 +4411,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
  * @NL80211_RRF_NO_HE: HE operation not allowed
  * @NL80211_RRF_NO_320MHZ: 320MHz operation not allowed
+ * @NL80211_RRF_PSD: channels has power spectral density value
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4423,6 +4431,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_160MHZ		= 1<<16,
 	NL80211_RRF_NO_HE		= 1<<17,
 	NL80211_RRF_NO_320MHZ		= 1<<18,
+	NL80211_RRF_PSD                 = 1<<19,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0a31b1d2845d..1e8fe560078f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1106,6 +1106,10 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_OFFSET, chan->freq_offset))
 		goto nla_put_failure;
 
+	if ((chan->flags & IEEE80211_CHAN_PSD) &&
+	    nla_put_s8(msg, NL80211_FREQUENCY_ATTR_PSD, chan->psd))
+		goto nla_put_failure;
+
 	if ((chan->flags & IEEE80211_CHAN_DISABLED) &&
 	    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_DISABLED))
 		goto nla_put_failure;
@@ -8456,6 +8460,11 @@ static int nl80211_put_regdom(const struct ieee80211_regdomain *regdom,
 				reg_rule->dfs_cac_ms))
 			goto nla_put_failure;
 
+		if ((reg_rule->flags & NL80211_RRF_PSD) &&
+		    nla_put_s8(msg, NL80211_ATTR_POWER_RULE_PSD,
+			       reg_rule->psd))
+			goto nla_put_failure;
+
 		nla_nest_end(msg, nl_reg_rule);
 	}
 
@@ -8629,6 +8638,7 @@ static const struct nla_policy reg_rule_policy[NL80211_REG_RULE_ATTR_MAX + 1] =
 	[NL80211_ATTR_POWER_RULE_MAX_ANT_GAIN]	= { .type = NLA_U32 },
 	[NL80211_ATTR_POWER_RULE_MAX_EIRP]	= { .type = NLA_U32 },
 	[NL80211_ATTR_DFS_CAC_TIME]		= { .type = NLA_U32 },
+	[NL80211_ATTR_POWER_RULE_PSD]		= { .type = NLA_S8 },
 };
 
 static int parse_reg_rule(struct nlattr *tb[],
@@ -8650,6 +8660,14 @@ static int parse_reg_rule(struct nlattr *tb[],
 
 	reg_rule->flags = nla_get_u32(tb[NL80211_ATTR_REG_RULE_FLAGS]);
 
+	if (reg_rule->flags & NL80211_RRF_PSD) {
+		if (!tb[NL80211_ATTR_POWER_RULE_PSD])
+			return -EINVAL;
+
+		reg_rule->psd =
+			nla_get_s8(tb[NL80211_ATTR_POWER_RULE_PSD]);
+	}
+
 	freq_range->start_freq_khz =
 		nla_get_u32(tb[NL80211_ATTR_FREQ_RANGE_START]);
 	freq_range->end_freq_khz =
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0d40d6af7e10..452e0085ed2c 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1587,6 +1587,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_HE;
 	if (rd_flags & NL80211_RRF_NO_320MHZ)
 		channel_flags |= IEEE80211_CHAN_NO_320MHZ;
+	if (rd_flags & NL80211_RRF_PSD)
+		channel_flags |= IEEE80211_CHAN_PSD;
 	return channel_flags;
 }
 
@@ -1793,6 +1795,9 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 				chan->dfs_cac_ms = reg_rule->dfs_cac_ms;
 		}
 
+		if (chan->flags & IEEE80211_CHAN_PSD)
+			chan->psd = reg_rule->psd;
+
 		return;
 	}
 
@@ -1813,6 +1818,9 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 	}
 
+	if (chan->flags & IEEE80211_CHAN_PSD)
+		chan->psd = reg_rule->psd;
+
 	if (chan->orig_mpwr) {
 		/*
 		 * Devices that use REGULATORY_COUNTRY_IE_FOLLOW_POWER
@@ -1882,6 +1890,12 @@ static void handle_channel_adjacent_rules(struct wiphy *wiphy,
 							 rrule2->dfs_cac_ms);
 		}
 
+		if ((rrule1->flags & NL80211_RRF_PSD) &&
+		    (rrule2->flags & NL80211_RRF_PSD))
+			chan->psd = min_t(s8, rrule1->psd, rrule2->psd);
+		else
+			chan->flags &= ~NL80211_RRF_PSD;
+
 		return;
 	}
 
@@ -2572,6 +2586,9 @@ static void handle_channel_custom(struct wiphy *wiphy,
 			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 	}
 
+	if (chan->flags & IEEE80211_CHAN_PSD)
+		chan->psd = reg_rule->psd;
+
 	chan->max_power = chan->max_reg_power;
 }
 
-- 
2.17.1

