Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E84160E3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbhIWOUP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbhIWOUP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 10:20:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A9C061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=2/zMNLU4X/8jw+GDvCXH7BkGzNY/tHBQid/wJvdVzG0=; t=1632406723; x=1633616323; 
        b=cnSAg4APC0hjOlyrkiM6YTv97bEQbR6k3iQs9G1N96A0IrB6qv9yhFhDtBUfabGSkg6zkbUq/WT
        bitgRFrRqhWS0BuTxDOuh38c2T8o/ixm+sjF3fh0U8qdGjJsJuAeFczNeQWzLnicIkgHFjHrxPlg/
        WsLpQtiCLoT4jFKpB07jnGBbkakgtHbDWLuhdk+jxIYy88RIvJ6PlT7/7hu8RMEGaGMJ6SDsVDMTW
        hXlgrFht2zFDK/K61ray36VFVEWbq62sbYCO7/dWI9uOfWmtZ1Mu9uUhGDy+0HKIby82LjjI8xl3A
        16WzKZtQQx/7iNG87Absf8Rs0mre2MeDOO2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mTPYf-00AlS3-1p;
        Thu, 23 Sep 2021 16:18:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: don't put struct cfg80211_ap_settings on stack
Date:   Thu, 23 Sep 2021 16:18:37 +0200
Message-Id: <20210923161836.5813d881eae3.I0fc0f83905b0bfa332c4f1505e00c13abfca3545@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This struct has grown quite a bit, so dynamically allocate
it instead of putting it on the stack.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 188 ++++++++++++++++++++++++-----------------
 1 file changed, 109 insertions(+), 79 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e4787c74e80b..384244a9aca9 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5323,7 +5323,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct cfg80211_ap_settings params;
+	struct cfg80211_ap_settings *params;
 	int err;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
@@ -5336,27 +5336,29 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (wdev->beacon_interval)
 		return -EALREADY;
 
-	memset(&params, 0, sizeof(params));
-
 	/* these are required for START_AP */
 	if (!info->attrs[NL80211_ATTR_BEACON_INTERVAL] ||
 	    !info->attrs[NL80211_ATTR_DTIM_PERIOD] ||
 	    !info->attrs[NL80211_ATTR_BEACON_HEAD])
-		return -EINVAL;
+	    	return -EINVAL;
 
-	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon);
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+
+	err = nl80211_parse_beacon(rdev, info->attrs, &params->beacon);
 	if (err)
-		return err;
+		goto out;
 
-	params.beacon_interval =
+	params->beacon_interval =
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
-	params.dtim_period =
+	params->dtim_period =
 		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
 
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
-					   params.beacon_interval);
+					   params->beacon_interval);
 	if (err)
-		return err;
+		goto out;
 
 	/*
 	 * In theory, some of these attributes should be required here
@@ -5366,129 +5368,156 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	 * additional information -- drivers must check!
 	 */
 	if (info->attrs[NL80211_ATTR_SSID]) {
-		params.ssid = nla_data(info->attrs[NL80211_ATTR_SSID]);
-		params.ssid_len =
+		params->ssid = nla_data(info->attrs[NL80211_ATTR_SSID]);
+		params->ssid_len =
 			nla_len(info->attrs[NL80211_ATTR_SSID]);
-		if (params.ssid_len == 0)
-			return -EINVAL;
+		if (params->ssid_len == 0) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_HIDDEN_SSID])
-		params.hidden_ssid = nla_get_u32(
+		params->hidden_ssid = nla_get_u32(
 			info->attrs[NL80211_ATTR_HIDDEN_SSID]);
 
-	params.privacy = !!info->attrs[NL80211_ATTR_PRIVACY];
+	params->privacy = !!info->attrs[NL80211_ATTR_PRIVACY];
 
 	if (info->attrs[NL80211_ATTR_AUTH_TYPE]) {
-		params.auth_type = nla_get_u32(
+		params->auth_type = nla_get_u32(
 			info->attrs[NL80211_ATTR_AUTH_TYPE]);
-		if (!nl80211_valid_auth_type(rdev, params.auth_type,
-					     NL80211_CMD_START_AP))
-			return -EINVAL;
+		if (!nl80211_valid_auth_type(rdev, params->auth_type,
+					     NL80211_CMD_START_AP)) {
+			err = -EINVAL;
+			goto out;
+		}
 	} else
-		params.auth_type = NL80211_AUTHTYPE_AUTOMATIC;
+		params->auth_type = NL80211_AUTHTYPE_AUTOMATIC;
 
-	err = nl80211_crypto_settings(rdev, info, &params.crypto,
+	err = nl80211_crypto_settings(rdev, info, &params->crypto,
 				      NL80211_MAX_NR_CIPHER_SUITES);
 	if (err)
-		return err;
+		goto out;
 
 	if (info->attrs[NL80211_ATTR_INACTIVITY_TIMEOUT]) {
-		if (!(rdev->wiphy.features & NL80211_FEATURE_INACTIVITY_TIMER))
-			return -EOPNOTSUPP;
-		params.inactivity_timeout = nla_get_u16(
+		if (!(rdev->wiphy.features & NL80211_FEATURE_INACTIVITY_TIMER)) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+		params->inactivity_timeout = nla_get_u16(
 			info->attrs[NL80211_ATTR_INACTIVITY_TIMEOUT]);
 	}
 
 	if (info->attrs[NL80211_ATTR_P2P_CTWINDOW]) {
-		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
-			return -EINVAL;
-		params.p2p_ctwindow =
+		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO) {
+			err = -EINVAL;
+			goto out;
+		}
+		params->p2p_ctwindow =
 			nla_get_u8(info->attrs[NL80211_ATTR_P2P_CTWINDOW]);
-		if (params.p2p_ctwindow != 0 &&
-		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_CTWIN))
-			return -EINVAL;
+		if (params->p2p_ctwindow != 0 &&
+		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_CTWIN)) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_P2P_OPPPS]) {
 		u8 tmp;
 
-		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
-			return -EINVAL;
+		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO) {
+			err = -EINVAL;
+			goto out;
+		}
 		tmp = nla_get_u8(info->attrs[NL80211_ATTR_P2P_OPPPS]);
-		params.p2p_opp_ps = tmp;
-		if (params.p2p_opp_ps != 0 &&
-		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_OPPPS))
-			return -EINVAL;
+		params->p2p_opp_ps = tmp;
+		if (params->p2p_opp_ps != 0 &&
+		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_OPPPS)) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		err = nl80211_parse_chandef(rdev, info, &params.chandef);
+		err = nl80211_parse_chandef(rdev, info, &params->chandef);
 		if (err)
-			return err;
+			goto out;
 	} else if (wdev->preset_chandef.chan) {
-		params.chandef = wdev->preset_chandef;
-	} else if (!nl80211_get_ap_channel(rdev, &params))
-		return -EINVAL;
+		params->chandef = wdev->preset_chandef;
+	} else if (!nl80211_get_ap_channel(rdev, params)) {
+		err = -EINVAL;
+		goto out;
+	}
 
-	if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &params.chandef,
-					   wdev->iftype))
-		return -EINVAL;
+	if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &params->chandef,
+					   wdev->iftype)) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 						    NL80211_ATTR_TX_RATES,
-						    &params.beacon_rate,
+						    &params->beacon_rate,
 						    dev, false);
 		if (err)
-			return err;
+			goto out;
 
-		err = validate_beacon_tx_rate(rdev, params.chandef.chan->band,
-					      &params.beacon_rate);
+		err = validate_beacon_tx_rate(rdev, params->chandef.chan->band,
+					      &params->beacon_rate);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_SMPS_MODE]) {
-		params.smps_mode =
+		params->smps_mode =
 			nla_get_u8(info->attrs[NL80211_ATTR_SMPS_MODE]);
-		switch (params.smps_mode) {
+		switch (params->smps_mode) {
 		case NL80211_SMPS_OFF:
 			break;
 		case NL80211_SMPS_STATIC:
 			if (!(rdev->wiphy.features &
-			      NL80211_FEATURE_STATIC_SMPS))
-				return -EINVAL;
+			      NL80211_FEATURE_STATIC_SMPS)) {
+				err = -EINVAL;
+				goto out;
+			}
 			break;
 		case NL80211_SMPS_DYNAMIC:
 			if (!(rdev->wiphy.features &
-			      NL80211_FEATURE_DYNAMIC_SMPS))
-				return -EINVAL;
+			      NL80211_FEATURE_DYNAMIC_SMPS)) {
+				err = -EINVAL;
+				goto out;
+			}
 			break;
 		default:
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 	} else {
-		params.smps_mode = NL80211_SMPS_OFF;
+		params->smps_mode = NL80211_SMPS_OFF;
 	}
 
-	params.pbss = nla_get_flag(info->attrs[NL80211_ATTR_PBSS]);
-	if (params.pbss && !rdev->wiphy.bands[NL80211_BAND_60GHZ])
-		return -EOPNOTSUPP;
+	params->pbss = nla_get_flag(info->attrs[NL80211_ATTR_PBSS]);
+	if (params->pbss && !rdev->wiphy.bands[NL80211_BAND_60GHZ]) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (info->attrs[NL80211_ATTR_ACL_POLICY]) {
-		params.acl = parse_acl_data(&rdev->wiphy, info);
-		if (IS_ERR(params.acl))
-			return PTR_ERR(params.acl);
+		params->acl = parse_acl_data(&rdev->wiphy, info);
+		if (IS_ERR(params->acl)) {
+			err = PTR_ERR(params->acl);
+			goto out;
+		}
 	}
 
-	params.twt_responder =
+	params->twt_responder =
 		    nla_get_flag(info->attrs[NL80211_ATTR_TWT_RESPONDER]);
 
 	if (info->attrs[NL80211_ATTR_HE_OBSS_PD]) {
 		err = nl80211_parse_he_obss_pd(
 					info->attrs[NL80211_ATTR_HE_OBSS_PD],
-					&params.he_obss_pd);
+					&params->he_obss_pd);
 		if (err)
 			goto out;
 	}
@@ -5496,7 +5525,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_HE_BSS_COLOR]) {
 		err = nl80211_parse_he_bss_color(
 					info->attrs[NL80211_ATTR_HE_BSS_COLOR],
-					&params.he_bss_color);
+					&params->he_bss_color);
 		if (err)
 			goto out;
 	}
@@ -5504,7 +5533,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_FILS_DISCOVERY]) {
 		err = nl80211_parse_fils_discovery(rdev,
 						   info->attrs[NL80211_ATTR_FILS_DISCOVERY],
-						   &params);
+						   params);
 		if (err)
 			goto out;
 	}
@@ -5512,24 +5541,24 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
 		err = nl80211_parse_unsol_bcast_probe_resp(
 			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
-			&params);
+			params);
 		if (err)
 			goto out;
 	}
 
-	nl80211_calculate_ap_params(&params);
+	nl80211_calculate_ap_params(params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-		params.flags |= AP_SETTINGS_EXTERNAL_AUTH_SUPPORT;
+		params->flags |= AP_SETTINGS_EXTERNAL_AUTH_SUPPORT;
 
 	wdev_lock(wdev);
-	err = rdev_start_ap(rdev, dev, &params);
+	err = rdev_start_ap(rdev, dev, params);
 	if (!err) {
-		wdev->preset_chandef = params.chandef;
-		wdev->beacon_interval = params.beacon_interval;
-		wdev->chandef = params.chandef;
-		wdev->ssid_len = params.ssid_len;
-		memcpy(wdev->ssid, params.ssid, wdev->ssid_len);
+		wdev->preset_chandef = params->chandef;
+		wdev->beacon_interval = params->beacon_interval;
+		wdev->chandef = params->chandef;
+		wdev->ssid_len = params->ssid_len;
+		memcpy(wdev->ssid, params->ssid, wdev->ssid_len);
 
 		if (info->attrs[NL80211_ATTR_SOCKET_OWNER])
 			wdev->conn_owner_nlportid = info->snd_portid;
@@ -5537,7 +5566,8 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 
 out:
-	kfree(params.acl);
+	kfree(params->acl);
+	kfree(params);
 
 	return err;
 }
-- 
2.31.1

