Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB34565236
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 12:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiGDKZz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 06:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiGDKZd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 06:25:33 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DED1114C
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 03:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656930250; x=1688466250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fjJINO81/YrRYiiogSNa+48rhNRYhIS+of2WeOkh6AQ=;
  b=BsDR/UWo+vBkWFq7ut7FFMjm97pAQ9yFNlk2UmgFXqvI7vTcCvUdTbaj
   p/wNtWZzsPF6TdbI7fUeT+pXjAEqXqE4b/TN+e23v6ioOylZA/7qVOdNT
   t+Gu8hr9FB7PQsl6TuD3/6APaTfwyTW4Bl63KVpi2Q0rEKsffF8ldMptx
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Jul 2022 03:24:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 03:24:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:10 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 03:24:08 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <johannes@sipsolutions.net>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 4/7] cfg80211: add NL command to set 6 GHz power mode
Date:   Mon, 4 Jul 2022 15:53:38 +0530
Message-ID: <20220704102341.5692-5-quic_adisi@quicinc.com>
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

6 GHz introduces various power modes for access points and for clients.
When user configures these power modes, currently cfg80211 does not
have support to store the configured power mode.

Add support to store the 6 GHz configured power mode in the structure
wireless_dev via a new NL command - NL80211_CMD_SET_6GHZ_POWER_MODE.

The  above command uses two new NL attributes to set power mode for AP
and clients - NL80211_ATTR_6GHZ_REG_AP_POWER_MODE and
NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE respectively.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h       |  9 ++++++
 include/uapi/linux/nl80211.h | 15 +++++++++
 net/wireless/ap.c            |  4 +++
 net/wireless/nl80211.c       | 62 ++++++++++++++++++++++++++++++++++++
 net/wireless/sme.c           |  3 ++
 5 files changed, 93 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ed482b23fb9c..1e8852c6149f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5644,6 +5644,9 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
  * @links: array of %IEEE80211_MLD_MAX_NUM_LINKS elements containing @addr
  *	@ap and @client for each link
  * @valid_links: bitmap describing what elements of @links are valid
+ * @ap_6ghz_power: 6 GHz regulatory power mode for Access Points
+ * @client_6ghz_power: 6 GHz regulatory power mode for Clients
+ * @reg_6ghz_pwr_configured: true if 6 GHz power mode is configured
  */
 struct wireless_dev {
 	struct wiphy *wiphy;
@@ -5758,6 +5761,12 @@ struct wireless_dev {
 		};
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 	u16 valid_links;
+
+	union {
+		enum ieee80211_ap_reg_power ap_6ghz_power;
+		enum ieee80211_client_reg_power client_6ghz_power;
+	};
+	bool reg_6ghz_pwr_configured;
 };
 
 static inline const u8 *wdev_address(struct wireless_dev *wdev)
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 789f73878f50..e62838887802 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1254,6 +1254,11 @@
  *	without %NL80211_ATTR_MLO_LINK_ID as an easy way to remove all links
  *	in preparation for e.g. roaming to a regular (non-MLO) AP.
  *
+ * @NL80211_CMD_SET_6GHZ_POWER_MODE: Set 6 GHz power mode for the interface
+ *	using -
+ *	&NL80211_ATTR_6GHZ_REG_AP_POWER_MODE - for access points
+ *	&NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE - for clients
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1501,6 +1506,8 @@ enum nl80211_commands {
 	NL80211_CMD_ADD_LINK,
 	NL80211_CMD_REMOVE_LINK,
 
+	NL80211_CMD_SET_6GHZ_POWER_MODE,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2701,6 +2708,12 @@ enum nl80211_commands {
  *	suites allowed as %NL80211_MAX_NR_AKM_SUITES which is the legacy maximum
  *	number prior to the introduction of this attribute.
  *
+ * @NL80211_ATTR_6GHZ_REG_AP_POWER_MODE: Configure 6 GHz regulatory power mode
+ *	for access points. Referenced from &enum ieee80211_ap_reg_power.
+ *
+ * @NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE: Configure 6 GHz regulatory power
+ *	mode for clients. Referenced from &enum ieee80211_client_reg_power.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3223,6 +3236,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_MAX_NUM_AKM_SUITES,
 
+	NL80211_ATTR_6GHZ_REG_AP_POWER_MODE,
+	NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/ap.c b/net/wireless/ap.c
index e68923200018..be4e6177d72a 100644
--- a/net/wireless/ap.c
+++ b/net/wireless/ap.c
@@ -82,6 +82,10 @@ int cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 
 	wdev_lock(wdev);
 	err = __cfg80211_stop_ap(rdev, dev, link_id, notify);
+
+	if (wdev->reg_6ghz_pwr_configured)
+		wdev->reg_6ghz_pwr_configured = false;
+
 	wdev_unlock(wdev);
 
 	return err;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index afa8cd686e0e..4d5c45f303ec 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -799,6 +799,12 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_6GHZ_REG_AP_POWER_MODE] =
+		NLA_POLICY_RANGE(NLA_U8, IEEE80211_REG_LPI_AP,
+				 IEEE80211_REG_AP_POWER_MAX),
+	[NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE] =
+		NLA_POLICY_RANGE(NLA_U8, IEEE80211_REG_DEFAULT_CLIENT,
+				 IEEE80211_REG_CLIENT_POWER_MAX),
 };
 
 /* policy for the key attributes */
@@ -15699,6 +15705,55 @@ static int nl80211_remove_link(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int nl80211_set_6ghz_power_mode(struct sk_buff *skb,
+				       struct genl_info *info)
+{
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = NULL;
+	enum nl80211_iftype iftype = NL80211_IFTYPE_UNSPECIFIED;
+	int ret = -EINVAL;
+
+	if (dev)
+		wdev = dev->ieee80211_ptr;
+
+	if (wdev)
+		iftype = wdev->iftype;
+
+	if (iftype != NL80211_IFTYPE_AP &&
+	    iftype != NL80211_IFTYPE_STATION)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_6GHZ_REG_AP_POWER_MODE] &&
+	    !info->attrs[NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE])
+		return -EINVAL;
+
+	wdev_lock(wdev);
+	if (wdev->reg_6ghz_pwr_configured) {
+		wdev_unlock(wdev);
+		return -EALREADY;
+	}
+
+	if (iftype == NL80211_IFTYPE_AP &&
+	    info->attrs[NL80211_ATTR_6GHZ_REG_AP_POWER_MODE]) {
+		wdev->ap_6ghz_power =
+		  nla_get_u8(info->attrs[NL80211_ATTR_6GHZ_REG_AP_POWER_MODE]);
+		ret = 0;
+	}
+
+	if (iftype == NL80211_IFTYPE_STATION &&
+	    info->attrs[NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE]) {
+		wdev->client_6ghz_power =
+		  nla_get_u8(info->attrs[NL80211_ATTR_6GHZ_REG_CLIENT_POWER_MODE]);
+		ret = 0;
+	}
+
+	if (!ret)
+		wdev->reg_6ghz_pwr_configured = true;
+
+	wdev_unlock(wdev);
+	return ret;
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -16849,6 +16904,13 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
 					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
+	{
+		.cmd = NL80211_CMD_SET_6GHZ_POWER_MODE,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_set_6ghz_power_mode,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
+	}
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 00be498aab2e..8858d396e4f8 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1500,6 +1500,9 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
 	if (!wdev->connected)
 		wdev->u.client.ssid_len = 0;
 
+	if (wdev->reg_6ghz_pwr_configured)
+		wdev->reg_6ghz_pwr_configured = false;
+
 	return err;
 }
 
-- 
2.17.1

