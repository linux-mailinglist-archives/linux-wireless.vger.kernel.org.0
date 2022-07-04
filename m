Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6A565233
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 12:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiGDKZn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 06:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiGDKZW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 06:25:22 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E591B7
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656930243; x=1688466243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=l26yKAdHAT0aHgydRvuzdgRPmcJU/SbFfguiNZFjGoY=;
  b=VWbRp2aPVxKA+dND9v8Uiwd/4/xuoxAtGpleMmfFe7sK7Efw1FXf2kIi
   41uYwTQ/aanyFc491h8/ixneJomWHGshE7KTbN/0r6zvQO+s63QcWjiJY
   3W2tqcy2Rnrc9U/VTFsqi9XIKbcSv5B2OgzCb4YzKkbH1/OflCXpY/PjQ
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 04 Jul 2022 03:24:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 03:24:02 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:02 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:00 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>, Wen Gong <quic_wgong@quicinc.com>,
        "Aditya Kumar Singh" <quic_adisi@quicinc.com>
Subject: [PATCH 1/7] cfg80211: save Power Spectral Density (PSD) of the regulatory rule
Date:   Mon, 4 Jul 2022 15:53:35 +0530
Message-ID: <20220704102341.5692-2-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704102341.5692-1-quic_adisi@quicinc.com>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

6 GHz regulatory domain introduces Power Spectral Density (PSD).
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
index 140354f5f15b..600c080a280b 100644
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
index 47f06f6f5a67..ed20004fb6a9 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -221,6 +221,7 @@ struct ieee80211_reg_rule {
 	u32 flags;
 	u32 dfs_cac_ms;
 	bool has_wmm;
+	s8 psd;
 };
 
 struct ieee80211_regdomain {
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 279f9715919e..8c21136ac18c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4062,6 +4062,8 @@ enum nl80211_wmm_rule {
  *	as the primary or any of the secondary channels isn't possible
  * @NL80211_FREQUENCY_ATTR_NO_EHT: EHT operation is not allowed on this channel
  *	in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_PSD: power spectral density (in dBm)
+ *	is allowed on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4100,6 +4102,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_16MHZ,
 	NL80211_FREQUENCY_ATTR_NO_320MHZ,
 	NL80211_FREQUENCY_ATTR_NO_EHT,
+	NL80211_FREQUENCY_ATTR_PSD,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4200,6 +4203,8 @@ enum nl80211_reg_type {
  * 	a given frequency range. The value is in mBm (100 * dBm).
  * @NL80211_ATTR_DFS_CAC_TIME: DFS CAC time in milliseconds.
  *	If not present or 0 default CAC time will be used.
+ * @NL80211_ATTR_POWER_RULE_PSD: power spectral density (in dBm).
+ *	This could be negative.
  * @NL80211_REG_RULE_ATTR_MAX: highest regulatory rule attribute number
  *	currently defined
  * @__NL80211_REG_RULE_ATTR_AFTER_LAST: internal use
@@ -4217,6 +4222,8 @@ enum nl80211_reg_rule_attr {
 
 	NL80211_ATTR_DFS_CAC_TIME,
 
+	NL80211_ATTR_POWER_RULE_PSD,
+
 	/* keep last */
 	__NL80211_REG_RULE_ATTR_AFTER_LAST,
 	NL80211_REG_RULE_ATTR_MAX = __NL80211_REG_RULE_ATTR_AFTER_LAST - 1
@@ -4299,6 +4306,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
  * @NL80211_RRF_NO_HE: HE operation not allowed
  * @NL80211_RRF_NO_320MHZ: 320MHz operation not allowed
+ * @NL80211_RRF_PSD: channel has power spectral density value
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4318,6 +4326,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_160MHZ		= 1<<16,
 	NL80211_RRF_NO_HE		= 1<<17,
 	NL80211_RRF_NO_320MHZ		= 1<<18,
+	NL80211_RRF_PSD                 = 1<<19,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index eda2ad029c90..afa8cd686e0e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1096,6 +1096,10 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_OFFSET, chan->freq_offset))
 		goto nla_put_failure;
 
+	if ((chan->flags & IEEE80211_CHAN_PSD) &&
+	    nla_put_s8(msg, NL80211_FREQUENCY_ATTR_PSD, chan->psd))
+		goto nla_put_failure;
+
 	if ((chan->flags & IEEE80211_CHAN_DISABLED) &&
 	    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_DISABLED))
 		goto nla_put_failure;
@@ -8168,6 +8172,11 @@ static int nl80211_put_regdom(const struct ieee80211_regdomain *regdom,
 				reg_rule->dfs_cac_ms))
 			goto nla_put_failure;
 
+		if ((reg_rule->flags & NL80211_RRF_PSD) &&
+		    nla_put_s8(msg, NL80211_ATTR_POWER_RULE_PSD,
+			       reg_rule->psd))
+			goto nla_put_failure;
+
 		nla_nest_end(msg, nl_reg_rule);
 	}
 
@@ -8341,6 +8350,7 @@ static const struct nla_policy reg_rule_policy[NL80211_REG_RULE_ATTR_MAX + 1] =
 	[NL80211_ATTR_POWER_RULE_MAX_ANT_GAIN]	= { .type = NLA_U32 },
 	[NL80211_ATTR_POWER_RULE_MAX_EIRP]	= { .type = NLA_U32 },
 	[NL80211_ATTR_DFS_CAC_TIME]		= { .type = NLA_U32 },
+	[NL80211_ATTR_POWER_RULE_PSD]		= { .type = NLA_S8 },
 };
 
 static int parse_reg_rule(struct nlattr *tb[],
@@ -8362,6 +8372,14 @@ static int parse_reg_rule(struct nlattr *tb[],
 
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
index c7383ede794f..9a06aadba0d7 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1619,6 +1619,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_HE;
 	if (rd_flags & NL80211_RRF_NO_320MHZ)
 		channel_flags |= IEEE80211_CHAN_NO_320MHZ;
+	if (rd_flags & NL80211_RRF_PSD)
+		channel_flags |= IEEE80211_CHAN_PSD;
 	return channel_flags;
 }
 
@@ -1825,6 +1827,9 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 				chan->dfs_cac_ms = reg_rule->dfs_cac_ms;
 		}
 
+		if (chan->flags & IEEE80211_CHAN_PSD)
+			chan->psd = reg_rule->psd;
+
 		return;
 	}
 
@@ -1845,6 +1850,9 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 	}
 
+	if (chan->flags & IEEE80211_CHAN_PSD)
+		chan->psd = reg_rule->psd;
+
 	if (chan->orig_mpwr) {
 		/*
 		 * Devices that use REGULATORY_COUNTRY_IE_FOLLOW_POWER
@@ -1914,6 +1922,12 @@ static void handle_channel_adjacent_rules(struct wiphy *wiphy,
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
 
@@ -2600,6 +2614,9 @@ static void handle_channel_custom(struct wiphy *wiphy,
 			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 	}
 
+	if (chan->flags & IEEE80211_CHAN_PSD)
+		chan->psd = reg_rule->psd;
+
 	chan->max_power = chan->max_reg_power;
 }
 
-- 
2.17.1

