Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A47774B6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 11:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjHJJgQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 05:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjHJJgL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 05:36:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4002696
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 02:36:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2680eee423aso400145a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1691660168; x=1692264968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9sIvV60RLlSi1ylwTs6iJnbp6aDpJCJ6w2CIrcc7EY=;
        b=4g2k/kNWj77AiypT7p2L7K1kZXZ8AqJHTzuOo9FiPlpswxhBtBge2PrJ/5wLkQt4CJ
         jKBRbdk04aHKkX73boHKYVjOvWGGyC8M/6KmGW4Jr2372VWu/XdGWJhA9E1qOrJpoVgV
         0FXKggq8dkxto2HrnN8HhGHsSP7vmmhTfVqb3i9VCN+gi8kshe3BG1o8pwE+yPS8cVTd
         uWM7EE+ECwi+f+qy7Oyk65T2t3gO2xn1QMiIakQfn+MBnPCc7dxbFfzHg8JV+kdzHyAy
         KMUt3nAYGDCiNpdbasom2+ehc4gjVjVB/NU+fA1KKhNtJW/x6P6bzoQYFgPfATdPlhbR
         L5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660168; x=1692264968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9sIvV60RLlSi1ylwTs6iJnbp6aDpJCJ6w2CIrcc7EY=;
        b=O/Ibej4ju4W7sesSOiCIhRwdS0et3HIW9JelEhwhgnalq5rVb27LQ07D8JkOCxsYc8
         TN9M7EVIVY9Wj2sxUbZIw5uR+5UOyTOiFGrpUBAHFHPfEBT4vXzegUX5eVqJbE0amw/q
         6C7ItixQ6zT7TbUq7RRstGyA7ZF5fmBmaohJ3B+tYI2fdnXbg0YOY/fSATDyl6tY0lBV
         yqN3ZwQwkQ6S75L9HC5OpNjkl3UAhFt0BH7AIZSMsrtmNsrnCJ+uYASxt6XK1vMIwOyx
         UzeD50eR1BB9d5CDXLaTTFeEZ1MOe1MfxPC8sL8hxI+kH9691dhpX/r33wcLcrS1Ffo9
         GEJQ==
X-Gm-Message-State: AOJu0YykHPjsCNukR2aYOeZ0/lSiOqy5dHouR8+cC48QnCcUfhpYMvLR
        iOze2/fkwX2iNklOfYigqwQufCyQsfBBeGDcpH8=
X-Google-Smtp-Source: AGHT+IFTeosmvDZdX5AVZOsEWfFkSoOF8L+vmNjdBBmywinjnDUnRVtIvgJrLM7zYEEOBR0bg9nNQw==
X-Received: by 2002:a17:90b:1103:b0:268:b682:23da with SMTP id gi3-20020a17090b110300b00268b68223damr1309455pjb.34.1691660168043;
        Thu, 10 Aug 2023 02:36:08 -0700 (PDT)
Received: from bassem.hub ([2405:6e00:10e7:e100:b398:e136:4868:a1a5])
        by smtp.googlemail.com with ESMTPSA id fz12-20020a17090b024c00b00262e5449dbcsm1045906pjb.24.2023.08.10.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:36:07 -0700 (PDT)
From:   Bassem Dawood <bassem@morsemicro.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        kernel test robot <lkp@intel.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v7 1/2] wifi: cfg80211: Add short_beacon_tail/head/period
Date:   Thu, 10 Aug 2023 19:35:55 +1000
Message-Id: <20230810093556.33800-1-bassem@morsemicro.com>
X-Mailer: git-send-email 2.25.1
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
Closes: https://lore.kernel.org/oe-kbuild-all/202304131044.Y2mHsqp7-lkp@intel.com/
Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
v7:
 - move new nl80211 attributes to the end
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
index 88eb85c63029..d543d1b83072 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2815,6 +2815,12 @@ enum nl80211_commands {
  * @NL80211_ATTR_MLO_LINK_DISABLED: Flag attribute indicating that the link is
  *	disabled.
  *
+ * @NL80211_ATTR_SHORT_BEACON_PERIOD: (u16) period for S1G long beacon
+ * @NL80211_ATTR_SHORT_BEACON_HEAD: portion of the S1G short beacon before
+ *	the TIM element
+ * @NL80211_ATTR_SHORT_BEACON_TAIL: portion of the S1G short beacon after
+ *	the TIM element
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3353,6 +3359,10 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_MLO_LINK_DISABLED,
 
+	NL80211_ATTR_SHORT_BEACON_PERIOD,
+	NL80211_ATTR_SHORT_BEACON_HEAD,
+	NL80211_ATTR_SHORT_BEACON_TAIL,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
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

