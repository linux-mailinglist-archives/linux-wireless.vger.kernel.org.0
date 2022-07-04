Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E369456523C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiGDK0D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 06:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiGDKZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 06:25:42 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7926211440
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656930258; x=1688466258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=MvdYv+YJGN2ILOx1k1ef7ciZKV3uX6IdJ7SV9yLTtkA=;
  b=v0YoVWrtPt36Vf/T61YlHK3YAxye67906+eBDIQDlVn2wJA3Xwvc7YXc
   f7XWKhgydVoygIzmKbpKYmggaOucqg+eXoaxvgYgCmSQqd0qHA4UbJ3yw
   Um44OdTwrtpojnF6ZzrkJgmE+lXqKIXZUoUHer7fHPcU22+jyCP/m8Gsn
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Jul 2022 03:24:18 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 03:24:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:17 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:16 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 7/7] cfg80211: save 6 GHz power mode of the regulatory rules
Date:   Mon, 4 Jul 2022 15:53:41 +0530
Message-ID: <20220704102341.5692-8-quic_adisi@quicinc.com>
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
index e62838887802..f2a32023a3f4 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4258,6 +4258,8 @@ enum nl80211_reg_type {
  *	If not present or 0 default CAC time will be used.
  * @NL80211_ATTR_POWER_RULE_PSD: power spectral density (in dBm).
  *	This could be negative.
+ * @NL80211_ATTR_REG_POWER_MODE: the regulatory power mode for 6 GHz rules.
+ *	Referenced from &enum nl80211_regulatory_power_modes
  * @NL80211_REG_RULE_ATTR_MAX: highest regulatory rule attribute number
  *	currently defined
  * @__NL80211_REG_RULE_ATTR_AFTER_LAST: internal use
@@ -4277,6 +4279,8 @@ enum nl80211_reg_rule_attr {
 
 	NL80211_ATTR_POWER_RULE_PSD,
 
+	NL80211_ATTR_REG_POWER_MODE,
+
 	/* keep last */
 	__NL80211_REG_RULE_ATTR_AFTER_LAST,
 	NL80211_REG_RULE_ATTR_MAX = __NL80211_REG_RULE_ATTR_AFTER_LAST - 1
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 915516bd4d93..5c0ac12c26b7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8200,6 +8200,13 @@ static int nl80211_put_regdom(const struct ieee80211_regdomain *regdom,
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
@@ -8379,6 +8386,10 @@ static const struct nla_policy reg_rule_policy[NL80211_REG_RULE_ATTR_MAX + 1] =
 	[NL80211_ATTR_POWER_RULE_MAX_EIRP]	= { .type = NLA_U32 },
 	[NL80211_ATTR_DFS_CAC_TIME]		= { .type = NLA_U32 },
 	[NL80211_ATTR_POWER_RULE_PSD]		= { .type = NLA_S8 },
+	[NL80211_ATTR_REG_POWER_MODE]		=
+			  NLA_POLICY_RANGE(NLA_U8,
+					   NL80211_REG_AP_LPI,
+					   NL80211_REG_MAX_POWER_MODES),
 };
 
 static int parse_reg_rule(struct nlattr *tb[],
@@ -8426,6 +8437,15 @@ static int parse_reg_rule(struct nlattr *tb[],
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

