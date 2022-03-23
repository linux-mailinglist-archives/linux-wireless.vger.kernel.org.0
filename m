Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95EA4E5907
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 20:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbiCWTSm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 15:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344099AbiCWTSl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 15:18:41 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD378567C
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648063031; x=1679599031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=48FcNTQs6SA6f6OD0KjPMS7vv97HCeD7SfKAnrRGSZE=;
  b=GLsiMHgKoc9Ck8aPaGtri+ninpRIEDMFtpv4CngarKFmbOAYbuSuC5Wk
   iqkSWT+Mi8TWkJGvvBtjx8gqPxf8FCsjjRCw8BaDn+E8/OOb6zKeztBJa
   MRPOFkKiXDwm/Ah5LMdnTWJppczbK9TpBweR3IKb8sNHLDOpZgndebfCr
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 12:17:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 12:17:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 12:16:51 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 12:16:50 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 1/4] nl80211: advertise RU puncturing support to userspace
Date:   Wed, 23 Mar 2022 12:16:37 -0700
Message-ID: <20220323191640.31230-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

RU preamble puncturing is allowed for bandwidths more that 80 MHz
except 80+80. Drivers may not support puncturing at all or have
restrictions for a minimum bandwidth.
Add new attribute NL80211_ATTR_RU_PUNCT_SUPP_BW to advertise the
driver support to the userspace. Default value (0) will indicate that
RU puncturing is not supported.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v2: Moved boundary check for ru_punct_supp_bw to wiphy_register().

 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 22 ++++++++++++++++++++++
 net/wireless/core.c          |  4 ++++
 net/wireless/nl80211.c       | 19 +++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 68713388b617..46630a125e8e 100644
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
index 0568a79097b8..bdd2cb22b5a0 100644
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
diff --git a/net/wireless/core.c b/net/wireless/core.c
index f08d4b3bb148..795f2400373d 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -892,6 +892,10 @@ int wiphy_register(struct wiphy *wiphy)
 		return -EINVAL;
 	}
 
+	if (WARN_ON(rdev->wiphy.ru_punct_supp_bw >
+		    NL80211_RU_PUNCT_SUPP_BW_320))
+		return -EINVAL;
+
 	for (i = 0; i < rdev->wiphy.n_vendor_commands; i++) {
 		/*
 		 * Validate we have a policy (can be explicitly set to
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ee1c2b6b6971..1fbfda2b3b14 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -790,6 +790,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_RANGE(NLA_BINARY,
 				 NL80211_EHT_MIN_CAPABILITY_LEN,
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
+	[NL80211_ATTR_RU_PUNCT_SUPP_BW] =
+		NLA_POLICY_MAX(NLA_U8, NL80211_RU_PUNCT_SUPP_BW_320),
 };
 
 /* policy for the key attributes */
@@ -2301,6 +2303,20 @@ static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
 	return -ENOBUFS;
 }
 
+static int
+nl80211_put_ru_punct_supp_bw(struct cfg80211_registered_device *rdev,
+			     struct sk_buff *msg)
+{
+	if (!rdev->wiphy.ru_punct_supp_bw)
+		return 0;
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
@@ -2889,6 +2905,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_put_mbssid_support(&rdev->wiphy, msg))
 			goto nla_put_failure;
 
+		if (nl80211_put_ru_punct_supp_bw(rdev, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;

base-commit: f5ba9781dde28f87d1e6db580ab63b308b5b5e1b
-- 
2.31.1

