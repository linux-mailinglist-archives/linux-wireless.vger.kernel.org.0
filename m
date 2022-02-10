Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F434B1623
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbiBJTU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:20:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbiBJTUY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:20:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2663CB60
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AH7NBnaIUGrExV46cki+wkuBj5lm5NJnHvUaSbEcQr4=;
        t=1644520824; x=1645730424; b=ix/PY62Lwss1I9s00RhBrKMAvgALf3fEphUOBMe5645TXkm
        v3wAM5CdpfLlicEH8kJhWeWLJYTv01vdEwCrVBu2JJmdZ9FP/jRdbu/7YrRTS+zfizHUcqcD57OA4
        5fZDCbRxgWiqKuMmRlvX7XHBwO4x8WeeR7994Hp0ifXrWYYXQTfFdaZZ4lVpXueH7kPLWJULmr72r
        7u12p9kLy/ThqL3rvQ7OFwntXNEata2rG+OS6a+winXj5sj6S/8duCRKkl7dWGvKHGDwPv6FoTINY
        FC0kJl3HHrATtdZymRhcBRqlidg1z/Pe3u7oBwa7Sv2efRthHWNFIPUiLbXH9RBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEzO-00HC2X-7P;
        Thu, 10 Feb 2022 20:20:22 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     quic_vikram@quicinc.com, quic_alokad@quicinc.com,
        quic_jiad@quicinc.com, quic_periyasa@quicinc.com,
        quic_msinada@quicinc.com, quic_srirrama@quicinc.com,
        ilan.peer@intel.com
Subject: [PATCH v2 11/19] cfg80211: Support configuration of station EHT capabilities
Date:   Thu, 10 Feb 2022 20:20:00 +0100
Message-Id: <20220210201853.e899619c8855.Icb4a5f2ec7b41d9008ac4cfc16c59baeb84793d3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210192008.188166-1-johannes@sipsolutions.net>
References: <20220210192008.188166-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
 net/wireless/nl80211.c       | 33 +++++++++++++++++++++++++++++----
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5cfc483dece1..68713388b617 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1487,6 +1487,8 @@ struct sta_txpwr {
  * @airtime_weight: airtime scheduler weight for this station
  * @txpwr: transmit power for an associated station
  * @he_6ghz_capa: HE 6 GHz Band capabilities of station
+ * @eht_capa: EHT capabilities of station
+ * @eht_capa_len: the length of the EHT capabilities
  */
 struct station_parameters {
 	const u8 *supported_rates;
@@ -1520,6 +1522,8 @@ struct station_parameters {
 	u16 airtime_weight;
 	struct sta_txpwr txpwr;
 	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
+	const struct ieee80211_eht_cap_elem *eht_capa;
+	u8 eht_capa_len;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index baf6433c0119..98ed52663d6b 100644
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
index 1214dbccbb10..228f0088aea5 100644
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
@@ -6365,6 +6369,12 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 				       params->he_capa_len))
 		return -EINVAL;
 
+	if (params->eht_capa &&
+	    !ieee80211_eht_capa_size_ok((const void *)params->he_capa,
+					(const void *)params->eht_capa,
+					params->eht_capa_len))
+		return -EINVAL;
+
 	/* When you run into this, adjust the code below for the new flag */
 	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 7);
 
@@ -6422,7 +6432,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		if (params->supported_rates)
 			return -EINVAL;
 		if (params->ext_capab || params->ht_capa || params->vht_capa ||
-		    params->he_capa)
+		    params->he_capa || params->eht_capa)
 			return -EINVAL;
 	}
 
@@ -6625,6 +6635,13 @@ static int nl80211_set_station_tdls(struct genl_info *info,
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
@@ -6882,6 +6899,13 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
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
@@ -6931,8 +6955,9 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
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

