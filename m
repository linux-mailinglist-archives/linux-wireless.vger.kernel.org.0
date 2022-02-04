Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3A4AA2B7
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 23:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbiBDWDJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 17:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245257AbiBDWDF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 17:03:05 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA40C061401
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 14:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=W0ZNB4eKjy0Ut+uyWEot4q1rhLgUOZzseGN7LocaPSc=;
        t=1644012185; x=1645221785; b=jkIU3lAIOlez3xoHcDLjVxKTcImK0pwJebPqlUPXUe9kHAj
        8taOJt8RdPoaBv8xc9oP+eqmkBkvLPAffRIsugGIFMlY2CsdbQkwVBnTUthBYyRPoKd8f5qlYHoQo
        9hriru9VI9lAjK6EN/s29tMO7uJEomf1DKwANu5mpAuilSgzZR5+1HNmSkGYUWIYmsF7r2JBk0J4d
        j3Df92elSJwnTnziNaERqfKDtDXnWewvoImx6NhF07KrBqKERnkILj1UcjmeExknW/9/tlQ5ulmvb
        7AUR08Xcynr0LUY0kXU1uts9Dop9xizY/+A2GeEen0sfS9uriwOecL301IW4yv5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6fX-00EeJL-Lv;
        Fri, 04 Feb 2022 23:03:03 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>,
        Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 11/19] cfg80211: Support configuration of station EHT capabilities
Date:   Fri,  4 Feb 2022 23:02:47 +0100
Message-Id: <20220204230119.71a813021cb9.Icb4a5f2ec7b41d9008ac4cfc16c59baeb84793d3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204220255.448224-1-johannes@sipsolutions.net>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Add attributes and some code bits to support userspace passing
in EHT capabilities of stations.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 10 +++++++++-
 net/wireless/nl80211.c       | 27 +++++++++++++++++++++++----
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c5aba50ecdbd..4124784477a2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1465,6 +1465,8 @@ struct sta_txpwr {
  * @airtime_weight: airtime scheduler weight for this station
  * @txpwr: transmit power for an associated station
  * @he_6ghz_capa: HE 6 GHz Band capabilities of station
+ * @eht_capa: EHT capabilities of station
+ * @eht_capa_len: the length of the EHT capabilities
  */
 struct station_parameters {
 	const u8 *supported_rates;
@@ -1498,6 +1500,8 @@ struct station_parameters {
 	u16 airtime_weight;
 	struct sta_txpwr txpwr;
 	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
+	const struct ieee80211_eht_cap_elem *eht_capa;
+	u8 eht_capa_len;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c09781a2a73c..6db607d63cbb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -11,7 +11,7 @@
  * Copyright 2008 Jouni Malinen <jouni.malinen@atheros.com>
  * Copyright 2008 Colin McCabe <colin@cozybit.com>
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -2659,6 +2659,10 @@ enum nl80211_commands {
  *	enumerated in &enum nl80211_ap_settings_flags. This attribute shall be
  *	used with %NL80211_CMD_START_AP request.
  *
+ * @NL80211_ATTR_EHT_CAPABILITY: EHT Capability information element (from
+ *	association request when used with NL80211_CMD_NEW_STATION). Can be set
+ *	only if %NL80211_STA_FLAG_WME is set.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3169,6 +3173,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_AP_SETTINGS_FLAGS,
 
+	NL80211_ATTR_EHT_CAPABILITY,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3224,6 +3230,8 @@ enum nl80211_attrs {
 #define NL80211_HE_MAX_CAPABILITY_LEN           54
 #define NL80211_MAX_NR_CIPHER_SUITES		5
 #define NL80211_MAX_NR_AKM_SUITES		2
+#define NL80211_EHT_MIN_CAPABILITY_LEN          13
+#define NL80211_EHT_MAX_CAPABILITY_LEN          51
 
 #define NL80211_MIN_REMAIN_ON_CHANNEL_TIME	10
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e5885cf5b9bc..54394ba71ad6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 
 #include <linux/if.h>
@@ -778,6 +778,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_RADAR_BACKGROUND] = { .type = NLA_FLAG },
 	[NL80211_ATTR_AP_SETTINGS_FLAGS] = { .type = NLA_U32 },
+	[NL80211_ATTR_EHT_CAPABILITY] =
+		NLA_POLICY_RANGE(NLA_BINARY,
+				 NL80211_EHT_MIN_CAPABILITY_LEN,
+				 NL80211_EHT_MAX_CAPABILITY_LEN),
 };
 
 /* policy for the key attributes */
@@ -6407,7 +6411,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		if (params->supported_rates)
 			return -EINVAL;
 		if (params->ext_capab || params->ht_capa || params->vht_capa ||
-		    params->he_capa)
+		    params->he_capa || params->eht_capa)
 			return -EINVAL;
 	}
 
@@ -6610,6 +6614,13 @@ static int nl80211_set_station_tdls(struct genl_info *info,
 			nla_data(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
 		params->he_capa_len =
 			nla_len(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
+
+		if (info->attrs[NL80211_ATTR_EHT_CAPABILITY]) {
+			params->eht_capa =
+				nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
+			params->eht_capa_len =
+				nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
+		}
 	}
 
 	err = nl80211_parse_sta_channel_info(info, params);
@@ -6867,6 +6878,13 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			nla_data(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
 		params.he_capa_len =
 			nla_len(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
+
+		if (info->attrs[NL80211_ATTR_EHT_CAPABILITY]) {
+			params.eht_capa =
+				nla_data(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
+			params.eht_capa_len =
+				nla_len(info->attrs[NL80211_ATTR_EHT_CAPABILITY]);
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
@@ -6916,8 +6934,9 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		params.ht_capa = NULL;
 		params.vht_capa = NULL;
 
-		/* HE requires WME */
-		if (params.he_capa_len || params.he_6ghz_capa)
+		/* HE and EHT require WME */
+		if (params.he_capa_len || params.he_6ghz_capa ||
+		    params.eht_capa_len)
 			return -EINVAL;
 	}
 
-- 
2.34.1

