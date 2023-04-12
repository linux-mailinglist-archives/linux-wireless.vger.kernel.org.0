Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35036E0255
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 01:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDLXMw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLXMv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 19:12:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9410CE
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 16:12:49 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v9so18603682pjk.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1681341168; x=1683933168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPEr8IU7++5c4mIGd01Mc5AT4MvTsN5EscavM83cha0=;
        b=32QGSvypTlJdwmLhmjMgqIQgjRBlxUFCSAeU2JSwWWznLSHDfj129bynmRgRFtGOjP
         PgwlTg3zjIwUMq49Xr4fzBbFJk46uJvX618s5M5nJSPw9asz2toFHbv1PYvB3UtVvI0s
         SOotsr/nD3giphrn17/q7Cs0Zkbbz5lV4y2cZm9AJmOh11GI++tL/0/oKJGS2g/9uiYT
         DNIMTNf63HI1EiYwav5bxpYaNSj+bhtJHR1Gx1F2HHj5qG1cbiZtkgYsoKR2KN77+LoZ
         WgfxF7s1IbYu4hR0ngv3PdKxD1qAQKMY1DYibDVs8FCX6/H2Y4XNYV6fQ6m8jTDSpn/j
         eUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681341168; x=1683933168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPEr8IU7++5c4mIGd01Mc5AT4MvTsN5EscavM83cha0=;
        b=fV/6TiEVxLKuZ1jAlxbiIeRSuVpf5ZhtsRwQYL+tBLbh5dNlQxOiAtB2vvdPcrsuEO
         l6d5IrqseQHrFam0Pu+4SUExm0owOOnJpgr+sSuVcYQ2e+kxY5mRCBOlzQsruIrjJDst
         FVYUjjIlQrR+hmwGzGnRLyORHp4Se5gXcjpWBOquguQ6QsKasgNHsWtS+Dvzy26C3T6z
         ESKeIL+iap50XxRe6x3X/oXwQC/z+HO5l9ymBx+PkGM3l01PWMQj3zTSfQyuGjOxkmNe
         a1hdvoGPuMyJQ1UwYv4J1WExSanc9bmSF2A8cRq2NTdBfo2zN13AclmcgMswD/HmUdGo
         XXOQ==
X-Gm-Message-State: AAQBX9fm55BKTxtXc2bQVteWuv1CgBEIageNBMX6VyHyurdG052+XaqX
        DZJUk3KWg4xQCd7HGzWhzR+6XTanFc+erA8Oyo8=
X-Google-Smtp-Source: AKy350ZmdA40LyekKQbd8zNC96tMRGxiQkOM1uQ9DyBDtOaq7jJkAUfjLTmQjPjqJsF3fbFgvOTXkQ==
X-Received: by 2002:a17:90b:1801:b0:23d:5196:eca8 with SMTP id lw1-20020a17090b180100b0023d5196eca8mr10531011pjb.20.1681341168522;
        Wed, 12 Apr 2023 16:12:48 -0700 (PDT)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902a51400b001a1c2ee06e0sm128198plq.15.2023.04.12.16.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 16:12:48 -0700 (PDT)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
X-Google-Original-From: Gilad Itzkovitch <gilad.itzkovitch@virscient.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v4 1/2] wifi: cfg80211: Add short_beacon_tail/head/period
Date:   Thu, 13 Apr 2023 11:12:40 +1200
Message-Id: <20230412231241.1587517-1-gilad.itzkovitch@virscient.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---

Notes:
    V4:
     - squash cfg80211 commits together
     - add protection for short head/tail with S1G band check
     - better validation rule for short_beacon_period
       and align its types

 include/net/cfg80211.h       |  10 +++-
 include/uapi/linux/nl80211.h |  10 ++++
 net/wireless/nl80211.c       | 101 ++++++++++++++++++++++++++---------
 3 files changed, 96 insertions(+), 25 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..6d0a31d85888 100644
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
index c59fec406da5..09ff24ed30ff 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2787,6 +2787,12 @@ enum nl80211_commands {
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
@@ -3336,6 +3342,10 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_PUNCT_BITMAP,
 
+	NL80211_ATTR_SHORT_BEACON_PERIOD,
+	NL80211_ATTR_SHORT_BEACON_HEAD,
+	NL80211_ATTR_SHORT_BEACON_TAIL,
+
 	NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS,
 	NL80211_ATTR_HW_TIMESTAMP_ENABLED,
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2c9edb015652..32b648315cc6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -231,12 +231,18 @@ static int validate_beacon_head(const struct nlattr *attr,
 	const struct ieee80211_mgmt *mgmt = (void *)data;
 	unsigned int fixedlen, hdrlen;
 	bool s1g_bcn;
+	bool s1g_short_bcn;
 
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
 
@@ -810,6 +821,12 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
+
+	[NL80211_ATTR_SHORT_BEACON_PERIOD] = NLA_POLICY_MIN(NLA_U16, 1),
+	[NL80211_ATTR_SHORT_BEACON_HEAD] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_beacon_head, IEEE80211_MAX_DATA_LEN),
+	[NL80211_ATTR_SHORT_BEACON_TAIL] =
+		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_ie_attr, IEEE80211_MAX_DATA_LEN),
 };
 
 /* policy for the key attributes */
@@ -5495,7 +5512,8 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 				struct nlattr *attrs[],
 				struct cfg80211_beacon_data *bcn,
-				struct netlink_ext_ack *extack)
+				struct netlink_ext_ack *extack,
+				bool is_s1g_band)
 {
 	bool haveinfo = false;
 	int err;
@@ -5505,10 +5523,18 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
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
 
@@ -5518,6 +5544,22 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
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
 
@@ -5925,8 +5967,24 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
 
@@ -5934,6 +5992,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
 	params->dtim_period =
 		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
+	params->short_beacon_period = 1;
+	if (info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD])
+		params->short_beacon_period =
+			nla_get_u16(info->attrs[NL80211_ATTR_SHORT_BEACON_PERIOD]);
 
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params->beacon_interval);
@@ -6030,21 +6092,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
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
@@ -6227,7 +6274,8 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (!wdev->links[link_id].ap.beacon_interval)
 		return -EINVAL;
 
-	err = nl80211_parse_beacon(rdev, info->attrs, &params, info->extack);
+	err = nl80211_parse_beacon(rdev, info->attrs, &params, info->extack,
+		wdev->links[link_id].ap.chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		goto out;
 
@@ -10098,7 +10146,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		goto skip_beacons;
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_after,
-				   info->extack);
+		info->extack,
+		wdev->links[link_id].ap.chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		goto free;
 
@@ -10116,7 +10165,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		goto free;
 
 	err = nl80211_parse_beacon(rdev, csa_attrs, &params.beacon_csa,
-				   info->extack);
+		info->extack,
+		wdev->links[link_id].ap.chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		goto free;
 
@@ -15931,6 +15981,7 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_color_change_settings params = {};
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct nlattr **tb;
 	u16 offset;
 	int err;
@@ -15954,7 +16005,8 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 	params.color = nla_get_u8(info->attrs[NL80211_ATTR_COLOR_CHANGE_COLOR]);
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_next,
-				   info->extack);
+		info->extack,
+		wdev->links[link_id].ap.chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		return err;
 
@@ -15969,7 +16021,8 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 
 	err = nl80211_parse_beacon(rdev, tb, &params.beacon_color_change,
-				   info->extack);
+		info->extack,
+		wdev->links[link_id].ap.chandef.chan->band == NL80211_BAND_S1GHZ);
 	if (err)
 		goto out;
 

base-commit: aa2aa818cd1198cfa2498116d57cd9f13fea80e4
-- 
2.34.1

