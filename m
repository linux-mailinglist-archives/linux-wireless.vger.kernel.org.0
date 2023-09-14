Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56DE79FE29
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 10:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbjINIVO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 04:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjINIVN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 04:21:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAADB1FC2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 01:21:08 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E6Qkkb020578;
        Thu, 14 Sep 2023 08:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=vPmd2x9Ads2imXPGSQeGl0Mg3P4X/mqnSeDSYdTrZHo=;
 b=b8MXIdz416YtKyh9Tojf8VWCYUdSm0r1Iz3jE5NyiHecq9IKK15fO8R/uM90Ats85QGj
 axYNyPSPQamblvFszV/SzWj/jzY6ADubXemPBAn8WBr6K+gqMOKYmiUvQa3q+dYA3b0v
 ipMtYzPJtU931fZrRuHU5roQ6CYJHNKiKxlPOMI1mR50QQMsmzCuZ+fGbMNJ5pqBJ99z
 hsNvXOsAcE+klY6Dj5EFPESrdKKYz8/aaunwXIxShTQ1EmJSxTMkumoDn1xg560fbeYM
 +ZybVNDV1/5Ugttrm7QZ5c0pVQvcZVfl3oAS1uPQ2JAuILa49pIWKQPhaBqVNGa8rIWJ sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3re30vhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 08:20:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38E8Kw4h032691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 08:20:58 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 01:20:56 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_jjohnson@quicinc.com>,
        <quic_wgong@quicinc.com>
Subject: [PATCH v6] wifi: cfg80211: save power spectral density(psd) of regulatory rule
Date:   Thu, 14 Sep 2023 04:20:26 -0400
Message-ID: <20230914082026.3709-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A2pDJd7u4AEPr-_kmYFXYO5nYNj-vpN7
X-Proofpoint-ORIG-GUID: A2pDJd7u4AEPr-_kmYFXYO5nYNj-vpN7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_06,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140072
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6 GHz regulatory domains introduces Power Spectral Density (PSD).
The PSD value of the regulatory rule should be taken into effect
for the ieee80211_channels falling into that particular regulatory
rule. Save the values in the channel which has PSD value and add
nl80211 attributes accordingly to handle it.

Co-developed-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
V6: change per johannes.
   1. rebased to ath-202308030925
   2. remove change in parse_reg_rule() which is for CRDA

v5: change by comments of johannes.
    1. add handler for nl80211 attributes
    2. add indentation for NL80211_RRF_PSD
    3. squashed with "cfg80211: add definition for 6 GHz power spectral density(psd)"
    4. remove all other patches

v4:
    1. rebased to top commit id 9e263e193af7 kernel/git/jberg/mac80211-next.git
    2. add NULL check for "mac80211: use ieee802_11_parse_elems() to find ies instead of ieee80211_bss_get_ie()"
    3. remove the 3 patches which already upstream:
       "mac80211: parse transmit power envelope element"
       "ieee80211: add definition for transmit power envelope element"
       "ieee80211: add definition of regulatory info in 6 GHz operation information"

v3: change per comments of Johannes.
    1. add patch "mac80211: use ieee802_11_parse_elems() to find ies instead of ieee80211_bss_get_ie()"
    2. move nl80211_ap_reg_power to ieee80211
    3. change some comments, length check, stack big size variable...

v2: change per comments of johannes.
    including code style, code logic, patch merge, commit log...

 include/net/cfg80211.h       |  4 ++++
 include/net/regulatory.h     |  1 +
 include/uapi/linux/nl80211.h |  9 +++++++++
 net/wireless/nl80211.c       |  9 +++++++++
 net/wireless/reg.c           | 17 +++++++++++++++++
 5 files changed, 40 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7c7d03aa9d06..a02f78197af4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -115,6 +115,7 @@ struct wiphy;
  *	This may be due to the driver or due to regulatory bandwidth
  *	restrictions.
  * @IEEE80211_CHAN_NO_EHT: EHT operation is not permitted on this channel.
+ * @IEEE80211_CHAN_PSD: Power spectral density (in dBm) on this channel.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED		= 1<<0,
@@ -138,6 +139,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_16MHZ		= 1<<18,
 	IEEE80211_CHAN_NO_320MHZ	= 1<<19,
 	IEEE80211_CHAN_NO_EHT		= 1<<20,
+	IEEE80211_CHAN_PSD		= 1<<21,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
@@ -171,6 +173,7 @@ enum ieee80211_channel_flags {
  *	on this channel.
  * @dfs_state_entered: timestamp (jiffies) when the dfs state was entered.
  * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS channels.
+ * @psd: power spectral density (in dBm)
  */
 struct ieee80211_channel {
 	enum nl80211_band band;
@@ -187,6 +190,7 @@ struct ieee80211_channel {
 	enum nl80211_dfs_state dfs_state;
 	unsigned long dfs_state_entered;
 	unsigned int dfs_cac_ms;
+	s8 psd;
 };
 
 /**
diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index b2cb4a9eb04d..ebf9e028d1ef 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -213,6 +213,7 @@ struct ieee80211_reg_rule {
 	u32 flags;
 	u32 dfs_cac_ms;
 	bool has_wmm;
+	s8 psd;
 };
 
 struct ieee80211_regdomain {
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 88eb85c63029..a5d2759b31e5 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4213,6 +4213,8 @@ enum nl80211_wmm_rule {
  *	as the primary or any of the secondary channels isn't possible
  * @NL80211_FREQUENCY_ATTR_NO_EHT: EHT operation is not allowed on this channel
  *	in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_PSD: Power spectral density (in dBm)
+ *	is allowed on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4251,6 +4253,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_16MHZ,
 	NL80211_FREQUENCY_ATTR_NO_320MHZ,
 	NL80211_FREQUENCY_ATTR_NO_EHT,
+	NL80211_FREQUENCY_ATTR_PSD,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4351,6 +4354,8 @@ enum nl80211_reg_type {
  * 	a given frequency range. The value is in mBm (100 * dBm).
  * @NL80211_ATTR_DFS_CAC_TIME: DFS CAC time in milliseconds.
  *	If not present or 0 default CAC time will be used.
+ * @NL80211_ATTR_POWER_RULE_PSD: power spectral density (in dBm).
+ *	This could be negative.
  * @NL80211_REG_RULE_ATTR_MAX: highest regulatory rule attribute number
  *	currently defined
  * @__NL80211_REG_RULE_ATTR_AFTER_LAST: internal use
@@ -4368,6 +4373,8 @@ enum nl80211_reg_rule_attr {
 
 	NL80211_ATTR_DFS_CAC_TIME,
 
+	NL80211_ATTR_POWER_RULE_PSD,
+
 	/* keep last */
 	__NL80211_REG_RULE_ATTR_AFTER_LAST,
 	NL80211_REG_RULE_ATTR_MAX = __NL80211_REG_RULE_ATTR_AFTER_LAST - 1
@@ -4451,6 +4458,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_HE: HE operation not allowed
  * @NL80211_RRF_NO_320MHZ: 320MHz operation not allowed
  * @NL80211_RRF_NO_EHT: EHT operation not allowed
+ * @NL80211_RRF_PSD: Channels has power spectral density value
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4471,6 +4479,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_HE		= 1<<17,
 	NL80211_RRF_NO_320MHZ		= 1<<18,
 	NL80211_RRF_NO_EHT		= 1<<19,
+	NL80211_RRF_PSD			= 1<<20,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0da2e6a2a7ea..279c3fa888e4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1114,6 +1114,10 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_OFFSET, chan->freq_offset))
 		goto nla_put_failure;
 
+	if ((chan->flags & IEEE80211_CHAN_PSD) &&
+	    nla_put_s8(msg, NL80211_FREQUENCY_ATTR_PSD, chan->psd))
+		goto nla_put_failure;
+
 	if ((chan->flags & IEEE80211_CHAN_DISABLED) &&
 	    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_DISABLED))
 		goto nla_put_failure;
@@ -8556,6 +8560,11 @@ static int nl80211_put_regdom(const struct ieee80211_regdomain *regdom,
 				reg_rule->dfs_cac_ms))
 			goto nla_put_failure;
 
+		if ((reg_rule->flags & NL80211_RRF_PSD) &&
+		    nla_put_s8(msg, NL80211_ATTR_POWER_RULE_PSD,
+			       reg_rule->psd))
+			goto nla_put_failure;
+
 		nla_nest_end(msg, nl_reg_rule);
 	}
 
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0317cf9da307..e60861610659 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1589,6 +1589,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_320MHZ;
 	if (rd_flags & NL80211_RRF_NO_EHT)
 		channel_flags |= IEEE80211_CHAN_NO_EHT;
+	if (rd_flags & NL80211_RRF_PSD)
+		channel_flags |= IEEE80211_CHAN_PSD;
 	return channel_flags;
 }
 
@@ -1795,6 +1797,9 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 				chan->dfs_cac_ms = reg_rule->dfs_cac_ms;
 		}
 
+		if (chan->flags & IEEE80211_CHAN_PSD)
+			chan->psd = reg_rule->psd;
+
 		return;
 	}
 
@@ -1815,6 +1820,9 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 	}
 
+	if (chan->flags & IEEE80211_CHAN_PSD)
+		chan->psd = reg_rule->psd;
+
 	if (chan->orig_mpwr) {
 		/*
 		 * Devices that use REGULATORY_COUNTRY_IE_FOLLOW_POWER
@@ -1884,6 +1892,12 @@ static void handle_channel_adjacent_rules(struct wiphy *wiphy,
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
 
@@ -2577,6 +2591,9 @@ static void handle_channel_custom(struct wiphy *wiphy,
 			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 	}
 
+	if (chan->flags & IEEE80211_CHAN_PSD)
+		chan->psd = reg_rule->psd;
+
 	chan->max_power = chan->max_reg_power;
 }
 

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1

