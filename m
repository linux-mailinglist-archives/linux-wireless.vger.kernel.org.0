Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67D54B5DA5
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 23:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiBNWbO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 17:31:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiBNWbN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 17:31:13 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7F411B32C
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 14:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644877864; x=1676413864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LdQlytw+qO0lg4bdIohWOSgj1PROmxBDj09GEvuAm1c=;
  b=jccF+eJnDLh5LnbfUzL06e2duJU4TZoqAQckf9zE8Wn/UumfRVZtfAyl
   9DY76py7zW4+qfr54bFr1XMiuqWJelGoDn/uB/ciqzyzKtVdnFZF8h3jt
   DM38e1w9EMVytTtswg6VmA1pYFaMWC1klMoA4NzqBuuU9Sb7IF5fZiVqo
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Feb 2022 14:31:04 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 14:31:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 14:31:03 -0800
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 14:31:03 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 1/3] nl80211: advertise RU puncturing support to userspace
Date:   Mon, 14 Feb 2022 14:30:49 -0800
Message-ID: <20220214223051.3610-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220214223051.3610-1-quic_alokad@quicinc.com>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

RU preamble puncturing is allowed for bandwidths more that 80 MHz
except 80+80. Drivers may not support puncturing at all or have
restrictions for a minimum bandwidth.
Add new attribute NL80211_ATTR_RU_PUNCT_SUPP_BW to advertise the
driver support to the userspace. Default value (0) will indicate that
RU puncturing is not supported.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 22 ++++++++++++++++++++++
 net/wireless/nl80211.c       | 22 ++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 136c0c537334..5605cf6d247b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5129,6 +5129,10 @@ struct wiphy_iftype_akm_suites {
  * @ema_max_profile_periodicity: maximum profile periodicity supported by
  *	the driver. Setting this field to a non-zero value indicates that the
  *	driver supports enhanced multi-BSSID advertisements (EMA AP).
+ *
+ * @ru_punct_supp_bw: Whether the driver supports RU puncturing, and if so,
+ *	for which bandwidths. See &enum nl80211_ru_punct_supp_bw for the
+ *	possible values for this field.
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5276,6 +5280,8 @@ struct wiphy {
 	u8 mbssid_max_interfaces;
 	u8 ema_max_profile_periodicity;
 
+	enum nl80211_ru_punct_supp_bw ru_punct_supp_bw;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 98ed52663d6b..b4849afede98 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2663,6 +2663,10 @@ enum nl80211_commands {
  *	association request when used with NL80211_CMD_NEW_STATION). Can be set
  *	only if %NL80211_STA_FLAG_WME is set.
  *
+ * @NL80211_ATTR_RU_PUNCT_SUPP_BW: (u8) Minimum bandwidth for which
+ *	the driver supports preamble puncturing, value should be of type
+ *	&enum nl80211_ru_punct_supp_bw
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3175,6 +3179,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EHT_CAPABILITY,
 
+	NL80211_ATTR_RU_PUNCT_SUPP_BW,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7600,4 +7606,20 @@ enum nl80211_ap_settings_flags {
 	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
 };
 
+/**
+ * enum nl80211_ru_punct_supp_bw - Bandwidths supporting preamble puncturing
+ *
+ * @NL80211_RU_PUNCT_NOT_SUPP: preamble puncturing is not supported
+ * @NL80211_RU_PUNCT_SUPP_BW_80: puncturing supported within channels of at
+ *	least 80 MHz bandwidth
+ * @NL80211_RU_PUNCT_SUPP_BW_160: puncturing supported within channels of at
+ *	least 160 MHz bandwidth
+ * @NL80211_RU_PUNCT_SUPP_BW_320: puncturing supported within 320 MHz.
+ */
+enum nl80211_ru_punct_supp_bw {
+	NL80211_RU_PUNCT_NOT_SUPP,
+	NL80211_RU_PUNCT_SUPP_BW_80,
+	NL80211_RU_PUNCT_SUPP_BW_160,
+	NL80211_RU_PUNCT_SUPP_BW_320,
+};
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1595e14fd678..3b244b96d15f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -782,6 +782,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_RANGE(NLA_BINARY,
 				 NL80211_EHT_MIN_CAPABILITY_LEN,
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
+	[NL80211_ATTR_RU_PUNCT_SUPP_BW] =
+		NLA_POLICY_MAX(NLA_U8, NL80211_RU_PUNCT_SUPP_BW_320),
 };
 
 /* policy for the key attributes */
@@ -2293,6 +2295,23 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 	return -ENOBUFS;
 }
 
+static int
+nl80211_put_ru_punct_supp_bw(struct cfg80211_registered_device *rdev,
+			     struct sk_buff *msg)
+{
+	if (!rdev->wiphy.ru_punct_supp_bw)
+		return 0;
+
+	if (rdev->wiphy.ru_punct_supp_bw > NL80211_RU_PUNCT_SUPP_BW_320)
+		return -EINVAL;
+
+	if (nla_put_u8(msg, NL80211_ATTR_RU_PUNCT_SUPP_BW,
+		       rdev->wiphy.ru_punct_supp_bw))
+		return -ENOBUFS;
+
+	return 0;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2881,6 +2900,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_put_mbssid_support(&rdev->wiphy, msg))
 			goto nla_put_failure;
 
+		if (nl80211_put_ru_punct_supp_bw(rdev, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
-- 
2.31.1

