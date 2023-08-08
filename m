Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AF0773FBE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 18:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjHHQw0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 12:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjHHQvT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 12:51:19 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F3E5B91
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 08:57:58 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d4789fd9317so3658764276.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Aug 2023 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1691510258; x=1692115058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgPnVahWszdVaOXn/B81CA9j/CkCDunLsjO2nGKJNVA=;
        b=gyl+PfI03l8TPfhnseBeFU52SIbag9BhHjlGn1etKmd4DzQhCvKtD8fFvoQL5VbrFU
         uad9Jj5v6ckpLpN9eaJDhezXYad0+arTyEEFpSTYAG9yKySvbkJBT8eDVvCAisiGILgd
         EH2De1MdBvi0wbmhdDPmc2pqHurL1sF1/kAmmnVVL//cWxBoKvglZKrfatxUOGJnBEe2
         ViviA4FjQ+oyMphrbEHQTrhhuBMJFgdvRuV3vzfH2C6XIpjytoeknC6QW0P7QXmEM/CH
         YebO6O/XduQ1sv8s3HO0fJXHGUazntlYrTVEa4E2dm5vvFkHpVJfwpRzzFAjU8bHosHe
         RIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510258; x=1692115058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgPnVahWszdVaOXn/B81CA9j/CkCDunLsjO2nGKJNVA=;
        b=Mr0o/fZenNx1cjFz5rGoxEAU4KPquuNPQBkHim/4M9jdl9cuX9Sf/H5OH97OwwdWA0
         2NQBjy9KZtEPm3FW7mEl2sRHEqozbfGp7bAMWIU2OMYrRFoXcq7mkjeV9wOYkNlaDZtG
         zOWthPVevIY+25RQmQa9wsV2NZM8wHEIOUaG+XFw2cnGjeComaJh+mBEXUhgiNYrB5WE
         rElwVuyt2IH7UvvmE4+wftJpnFnBqa13qCt2j6L7EJXkF+jcZqVzyhRCJMqliXtzlk+3
         a6SIxA3WxlFKm0qBv0fTL4PsqEx4H3lSplhBHvjE4RZwTqj0HewPkJhxR5L2gBkHgtxc
         QF3Q==
X-Gm-Message-State: AOJu0YxjRX5eYVB4liTt4s7UmhJNTtil0z3/jOj5mLhtJF78SPQqine0
        ywih6LEoVqBJzZV/iUGwgrGFwh153q9DqDLq0c4=
X-Google-Smtp-Source: AGHT+IGWQRAoqqmjwK9KDMaPa/Y7Uv42EyFH0pSl/NGIN5pBNckGmxcwm8x6vUf+fdJd/0aIXl0SUA==
X-Received: by 2002:a17:902:e5c2:b0:1bc:81f2:ddf0 with SMTP id u2-20020a170902e5c200b001bc81f2ddf0mr1277022plf.67.1691490467607;
        Tue, 08 Aug 2023 03:27:47 -0700 (PDT)
Received: from bassem.sydney.mm.lcl (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.googlemail.com with ESMTPSA id q17-20020a170902dad100b001bb9aadfb04sm8642087plx.220.2023.08.08.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 03:27:47 -0700 (PDT)
From:   Bassem Dawood <bassem@morsemicro.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        kernel test robot <lkp@intel.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v6 1/2] wifi: cfg80211: Add short_beacon_tail/head/period
Date:   Tue,  8 Aug 2023 20:27:31 +1000
Message-Id: <20230808102732.37270-1-bassem@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417012151.2512303-1-gilad.itzkovitch@virscient.com>
References: <20230417012151.2512303-1-gilad.itzkovitch@virscient.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kieran Frewen <kieran.frewen@morsemicro.com>

Support variables to handle short beacon period and adding a
separate tail/head for them. Also, add short beacon period,
head and tail attributes for user configuration.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304131044.Y2mHsqp7-lkp@intel.com/
Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
v6:
 - update to latest wireless-next
v5:
 - initialise s1g beacon variables to false
v4:
 - squash cfg80211 commits together
 - add protection for short head/tail with S1G band check
 - better validation rule for short_beacon_period
   and align its types
---
 include/net/cfg80211.h       |  10 +++-
 include/uapi/linux/nl80211.h |  10 ++++
 net/wireless/nl80211.c       | 103 ++++++++++++++++++++++++++---------
 3 files changed, 97 insertions(+), 26 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7c7d03aa9d06..482f455305aa 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1211,8 +1211,13 @@ struct cfg80211_rnr_elems {
  *	or %NULL if not changed
  * @tail: tail portion of beacon (after TIM IE)
  *	or %NULL if not changed
+ * @short_head: head portion of short beacon or %NULL if not changed
+ * @short_tail: short tail portion of beacon (after TIM IE)
+ *	or %NULL if not changed
  * @head_len: length of @head
  * @tail_len: length of @tail
+ * @short_head_len: length of @short_head
+ * @short_tail_len: length of @short_tail
  * @beacon_ies: extra information element(s) to add into Beacon frames or %NULL
  * @beacon_ies_len: length of beacon_ies in octets
  * @proberesp_ies: extra information element(s) to add into Probe Response
@@ -1241,6 +1246,7 @@ struct cfg80211_beacon_data {
 	unsigned int link_id;
 
 	const u8 *head, *tail;
+	const u8 *short_head, *short_tail;
 	const u8 *beacon_ies;
 	const u8 *proberesp_ies;
 	const u8 *assocresp_ies;
@@ -1252,6 +1258,7 @@ struct cfg80211_beacon_data {
 	s8 ftm_responder;
 
 	size_t head_len, tail_len;
+	size_t short_head_len, short_tail_len;
 	size_t beacon_ies_len;
 	size_t proberesp_ies_len;
 	size_t assocresp_ies_len;
@@ -1324,6 +1331,7 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @beacon: beacon data
  * @beacon_interval: beacon interval
  * @dtim_period: DTIM period
+ * @short_beacon_period: S1G short beacon period
  * @ssid: SSID to be used in the BSS (note: may be %NULL if not provided from
  *	user space)
  * @ssid_len: length of @ssid
@@ -1365,7 +1373,7 @@ struct cfg80211_ap_settings {
 
 	struct cfg80211_beacon_data beacon;
 
-	int beacon_interval, dtim_period;
+	int beacon_interval, dtim_period, short_beacon_period;
 	const u8 *ssid;
 	size_t ssid_len;
 	enum nl80211_hidden_ssid hidden_ssid;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 88eb85c63029..03df70b0238e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2794,6 +2794,12 @@ enum nl80211_commands {
  *	indicates that the sub-channel is punctured. Higher 16 bits are
  *	reserved.
  *
+ * @NL80211_ATTR_SHORT_BEACON_PERIOD: (u16) period for S1G long beacon
+ * @NL80211_ATTR_SHORT_BEACON_HEAD: portion of the S1G short beacon before
+ *  the TIM element
+ * @NL80211_ATTR_SHORT_BEACON_TAIL: portion of the S1G short beacon after
+ *  the TIM element
+ *
  * @NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS: Maximum number of peers that HW
  *	timestamping can be enabled for concurrently (u16), a wiphy attribute.
  *	A value of 0xffff indicates setting for all peers (i.e. not specifying
@@ -3346,6 +3352,10 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_PUNCT_BITMAP,
 
+	NL80211_ATTR_SHORT_BEACON_PERIOD,
+	NL80211_ATTR_SHORT_BEACON_HEAD,
+	NL80211_ATTR_SHORT_BEACON_TAIL,
+
 	NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS,
 	NL80211_ATTR_HW_TIMESTAMP_ENABLED,
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0da2e6a2a7ea..eedc6f47d74d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -230,13 +230,19 @@ static int validate_beacon_head(const struct nlattr *attr,
 	const struct element *elem;
 	const struct ieee80211_mgmt *mgmt = (void *)data;
 	unsigned int fixedlen, hdrlen;
-	bool s1g_bcn;
+	bool s1g_bcn = false;
+	bool s1g_short_bcn = false;
 
 	if (len < offsetofend(typeof(*mgmt), frame_control))
 		goto err;
 
 	s1g_bcn = ieee80211_is_s1g_beacon(mgmt->frame_control);
-	if (s1g_bcn) {
+	s1g_short_bcn = ieee80211_is_s1g_short_beacon(mgmt->frame_control);
+	if (s1g_short_bcn) {
+		fixedlen = offsetof(struct ieee80211_ext,
+				    u.s1g_short_beacon.variable);
+		hdrlen = offsetof(struct ieee80211_ext, u.s1g_short_beacon);
+	} else if (s1g_bcn) {
 		fixedlen = offsetof(struct ieee80211_ext,
 				    u.s1g_beacon.variable);
 		hdrlen = offsetof(struct ieee80211_ext, u.s1g_beacon);
@@ -263,7 +269,12 @@ static int validate_beacon_head(const struct nlattr *attr,
 		return 0;
 
 err:
-	NL_SET_ERR_MSG_ATTR(extack, attr, "malformed beacon head");
+	if (s1g_short_bcn)
+		NL_SET_ERR_MSG_ATTR(extack, attr, "malformed S1G short beacon head");
+	else if (s1g_bcn)
+		NL_SET_ERR_MSG_ATTR(extack, attr, "malformed S1G beacon head");
+	else
+		NL_SET_ERR_MSG_ATTR(extack, attr, "malformed beacon head");
 	return -EINVAL;
 }
 
@@ -817,6 +828,12 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_MLO_LINK_DISABLED] = { .type = NLA_FLAG },
+
+	[NL80211_ATTR_SHORT_BEACON_PERIOD] = NLA_POLICY_MIN(NLA_U16, 1),
+	[NL80211_ATTR_SHORT_BEACON_HEAD] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_beacon_head, IEEE80211_MAX_DATA_LEN),
+	[NL80211_ATTR_SHORT_BEACON_TAIL] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr, IEEE80211_MAX_DATA_LEN),
 };
 
 /* policy for the key attributes */
@@ -5505,7 +5522,8 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 				struct nlattr *attrs[],
 				struct cfg80211_beacon_data *bcn,
-				struct netlink_ext_ack *extack)
+				struct netlink_ext_ack *extack,
+				bool is_s1g_band)
 {
 	bool haveinfo = false;
 	int err;
@@ -5515,10 +5533,18 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 	bcn->link_id = nl80211_link_id(attrs);
 
 	if (attrs[NL80211_ATTR_BEACON_HEAD]) {
+		struct ieee80211_mgmt *mgmt;
+
 		bcn->head = nla_data(attrs[NL80211_ATTR_BEACON_HEAD]);
 		bcn->head_len = nla_len(attrs[NL80211_ATTR_BEACON_HEAD]);
 		if (!bcn->head_len)
 			return -EINVAL;
+
+		mgmt = (void *)bcn->head;
+		if (ieee80211_is_s1g_beacon(mgmt->frame_control) && !is_s1g_band)
+			return -EINVAL;
+		else if (ieee80211_is_beacon(mgmt->frame_control) && is_s1g_band)
+			return -EINVAL;
 		haveinfo = true;
 	}
 
@@ -5528,6 +5554,22 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		haveinfo = true;
 	}
 
+	if (attrs[NL80211_ATTR_SHORT_BEACON_HEAD]) {
+		if (!is_s1g_band)
+			return -EINVAL;
+		bcn->short_head = nla_data(attrs[NL80211_ATTR_SHORT_BEACON_HEAD]);
+		bcn->short_head_len = nla_len(attrs[NL80211_ATTR_SHORT_BEACON_HEAD]);
+		haveinfo = true;
+	}
+
+	if (attrs[NL80211_ATTR_SHORT_BEACON_TAIL]) {
+		if (!is_s1g_band)
+			return -EINVAL;
+		bcn->short_tail = nla_data(attrs[NL80211_ATTR_SHORT_BEACON_TAIL]);
+		bcn->short_tail_len = nla_len(attrs[NL80211_ATTR_SHORT_BEACON_TAIL]);
+		haveinfo = true;
+	}
+
 	if (!haveinfo)
 		return -EINVAL;
 
@@ -5935,8 +5977,24 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (!params)
 		return -ENOMEM;
 
+	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
+		err = nl80211_parse_chandef(rdev, info, &params->chandef);
+		if (err)
+			goto out;
+	} else if (wdev->valid_links) {
+		/* with MLD need to specify the channel configuration */
+		err = -EINVAL;
+		goto out;
+	} else if (wdev->u.ap.preset_chandef.chan) {
+		params->chandef = wdev->u.ap.preset_chandef;
+	} else if (!nl80211_get_ap_channel(rdev, params)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = nl80211_parse_beacon(rdev, info->attrs, &params->beacon,
-				   info->extack);
+				   info->extack,
+				   params->chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		goto out;
 
@@ -5944,6 +6002,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
 	params->dtim_period =
 		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
+	params->short_beacon_period = 1;
+	if (info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD])
+		params->short_beacon_period =
+			nla_get_u16(info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD]);
 
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params->beacon_interval);
@@ -6040,21 +6102,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &params->chandef);
-		if (err)
-			goto out;
-	} else if (wdev->valid_links) {
-		/* with MLD need to specify the channel configuration */
-		err = -EINVAL;
-		goto out;
-	} else if (wdev->u.ap.preset_chandef.chan) {
-		params->chandef = wdev->u.ap.preset_chandef;
-	} else if (!nl80211_get_ap_channel(rdev, params)) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	if (info->attrs[NL80211_ATTR_PUNCT_BITMAP]) {
 		err = nl80211_parse_punct_bitmap(rdev, info,
 						 &params->chandef,
@@ -6237,7 +6284,8 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (!wdev->links[link_id].ap.beacon_interval)
 		return -EINVAL;
 
-	err = nl80211_parse_beacon(rdev, info->attrs, &params, info->extack);
+	err = nl80211_parse_beacon(rdev, info->attrs, &params, info->extack,
+		wdev->links[link_id].ap.chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		goto out;
 
@@ -10131,7 +10179,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		goto skip_beacons;
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_after,
-				   info->extack);
+		info->extack,
+		wdev->links[link_id].ap.chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		goto free;
 
@@ -10149,7 +10198,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		goto free;
 
 	err = nl80211_parse_beacon(rdev, csa_attrs, &params.beacon_csa,
-				   info->extack);
+		info->extack,
+		wdev->links[link_id].ap.chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		goto free;
 
@@ -15976,6 +16026,7 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_color_change_settings params = {};
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct nlattr **tb;
 	u16 offset;
 	int err;
@@ -15999,7 +16050,8 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 	params.color = nla_get_u8(info->attrs[NL80211_ATTR_COLOR_CHANGE_COLOR]);
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_next,
-				   info->extack);
+		info->extack,
+		wdev->links[link_id].ap.chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		return err;
 
@@ -16014,7 +16066,8 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 
 	err = nl80211_parse_beacon(rdev, tb, &params.beacon_color_change,
-				   info->extack);
+		info->extack,
+		wdev->links[link_id].ap.chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		goto out;
 
-- 
2.25.1

