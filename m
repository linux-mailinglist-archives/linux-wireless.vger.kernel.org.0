Return-Path: <linux-wireless+bounces-26411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952DB2927F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 11:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE4A2025A1
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB17227EAA;
	Sun, 17 Aug 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z0r4YtDw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B30225416
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423681; cv=none; b=UuFtZT5/kGFuYx51xGO3FHO+FQn/zpdhow5WO2iUU3gn0SVOuft89ZEwlB/Z82DjiSrNKVhUQYNZ21+hW2wRwSV7+5a1HXbzYpvnVS4D36HqL+O4773L3yNWFqoNNnKgZPEWuNDqW5ccn7I0PnsDGYXj2yCMzD05moQucTN4w/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423681; c=relaxed/simple;
	bh=oAQ40edfTgBJeeuakrtN5Z1m56iPTG54ZnPNCBdY11Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSg/Q/FrYAr8RyjQFGRE4LqVoyEReJqBkvNk5LE5GkHCQt1i3OnKo9gRLNXW1rCEDMGkVJkC2ZTlf5Dn/Gj+VVy4+MEkC4rOnDIEDx7ZHmDd5pw8P73ShaI05q/38mcc8jIz25AvSOHCz2XnW8xvYB7OW6vqHF/7EZfv7Ie7bqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z0r4YtDw; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70a927f38deso16865636d6.1
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 02:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755423679; x=1756028479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq+YK52CicgXNkfJdFbc05VwjYey8dD19zCnHS4rUGw=;
        b=Z0r4YtDwf24dINMNmj+mxKP5RMc+R1eJ/ZhR5OoR9y1USr/ViDiCp8po9qPnh9EMOK
         VSKXROI8FwCVmOMu8dftT+lfHnkO9ZVNRzYWoHri2FpkTQWR6nmqlPU5jtJR4t90Dowz
         hl4tSQ27983Js9jdM62sF1YLBJHxhkFJhlmTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755423679; x=1756028479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq+YK52CicgXNkfJdFbc05VwjYey8dD19zCnHS4rUGw=;
        b=L/r5YO/0RIwvVDDHzWenwbjsltsK4wlwxQpZs0Gf7cXUP4ED/oc7p/2PUQTm5D2NCn
         pTwa2niJhJUMUo01OBbWC4d2dXe6ro71XAl53e2NW9JhYgAviLWQZyhHtBSs5Rw/09QI
         I6Q1sYMg7SYeHduSFKzMEH0/SHsCpGtEX4a2p3SEujcyiUUswjpg96azaNNEa3Flc/ku
         BzD9a+t1wqGNmm9YDmRf2/2cUDh733ERInyP2n2tKgs/hkkLRNM7QR0F8Wa4fi4FaC2s
         s+fKsRixUBpRKmt+aQcF4Pk5ij/OAeGvFko0VOin9W/oM+oUUxBq8+gSUHHv6X3x6vVM
         7u0Q==
X-Gm-Message-State: AOJu0YzAB7oH6mGY/J9THKxct4sYxFNW32ZQLOmTnkfH83DU2Pap70t8
	gPx4Dkbd5BLKei89l1nWP9/U90hkun3h7ImMtdO5VamtR5h2nW7nh2CKse3jv7YARg==
X-Gm-Gg: ASbGncsYjWrw0cafXJjr2966JinxmnivadB2jkHKmClJ6GFctmdikYHAAb7GFv+3E5D
	f+5DnbDZrOQ2p3N7oF6UlrlQSOii3G62H95Shb5N9q3nQ9IQKHhyJ2OY/MD1lR2ranL2GZzZgoY
	J19nRGN6p35zEevVzOsdQI4ief+3kLsLFokLZ23nlO7m4+6iABSnIzoFoSAs/jJ8Staznq7xJur
	C4y/rhVkVOtvP+5ZvfP8AjkKT7xgKrmzXLny7ffZtGYEb+ehgLFoIWLA5V63T3vOP8QoUCBx19Y
	NLVxq4U9On0UpeVZjOXbYJ1GshzPsS1vqjovHxkQW0jHxKwFfRG0YuRJigYkmqr6/nJw1O4Smex
	XZvjnzTtDGkQNi/OEceYKfbCyyRitAidB42nKtM92j130y7I6FQEDhG5fB7CULYrEXVXl/kVXdW
	J3c6a7Dt9JSw0LV/u8
X-Google-Smtp-Source: AGHT+IGlQqdR1ksVAMfX0Tl/6GyTYB50EFDNZIpKrSulTNRL8ANkpYTpVNguQZdKWQYvIrIcKas7HQ==
X-Received: by 2002:ad4:5ae3:0:b0:707:77cb:5b0b with SMTP id 6a1803df08f44-70ba7c05054mr87416766d6.26.1755423679154;
        Sun, 17 Aug 2025 02:41:19 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f819sm35706346d6.9.2025.08.17.02.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 02:41:18 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wl-next 3/4] wifi: nl80211: strict checking attributes for NL80211_CMD_SET_BSS
Date: Sun, 17 Aug 2025 11:41:02 +0200
Message-ID: <20250817094103.941090-4-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250817094103.941090-1-arend.vanspriel@broadcom.com>
References: <20250817094103.941090-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assure user-space only modifies attributes for NL80211_CMD_SET_BSS
that are supported by the driver. This stricter checking is only done
when user-space commits to it by including NL80211_ATTR_BSS_PARAM.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 include/uapi/linux/nl80211.h |  5 +++-
 net/wireless/nl80211.c       | 57 +++++++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 50750aa3c2ea..32fbc3d0a7c6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2929,7 +2929,10 @@ enum nl80211_commands {
  *	@enum nl80211_s1g_short_beacon_attrs for the attribute definitions.
  *
  * @NL80211_ATTR_BSS_PARAM: nested attribute used with %NL80211_CMD_GET_WIPHY
- *	which indicates which BSS parameters can be modified.
+ *	which indicates which BSS parameters can be modified. The attribute can
+ *	also be used as flag attribute by user-space in %NL80211_CMD_SET_BSS to
+ *	indicate that it wants strict checking on the BSS parameters to be
+ *	modified.
  *	
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8003667f0db5..7a8871a5a359 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -871,6 +871,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_S1G_LONG_BEACON_PERIOD] = NLA_POLICY_MIN(NLA_U8, 2),
 	[NL80211_ATTR_S1G_SHORT_BEACON] =
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
+	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -8863,6 +8864,9 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct bss_parameters params;
+	u32 bss_param_support = rdev->wiphy.bss_param_support;
+	u32 changed = 0;
+	bool strict;
 
 	memset(&params, 0, sizeof(params));
 	params.link_id = nl80211_link_id_or_invalid(info->attrs);
@@ -8875,26 +8879,54 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 	params.p2p_ctwindow = -1;
 	params.p2p_opp_ps = -1;
 
-	if (info->attrs[NL80211_ATTR_BSS_CTS_PROT])
+	strict = nla_get_flag(info->attrs[NL80211_ATTR_BSS_PARAM]);
+	if (info->attrs[NL80211_ATTR_BSS_CTS_PROT]) {
+		if (strict && !(bss_param_support & WIPHY_BSS_PARAM_CTS_PROT))
+			return -EINVAL;
 		params.use_cts_prot =
 		    nla_get_u8(info->attrs[NL80211_ATTR_BSS_CTS_PROT]);
-	if (info->attrs[NL80211_ATTR_BSS_SHORT_PREAMBLE])
+		changed |= WIPHY_BSS_PARAM_CTS_PROT;
+	}
+	if (info->attrs[NL80211_ATTR_BSS_SHORT_PREAMBLE]) {
+		if (strict &&
+		    !(bss_param_support & WIPHY_BSS_PARAM_SHORT_PREAMBLE))
+			return -EINVAL;
 		params.use_short_preamble =
 		    nla_get_u8(info->attrs[NL80211_ATTR_BSS_SHORT_PREAMBLE]);
-	if (info->attrs[NL80211_ATTR_BSS_SHORT_SLOT_TIME])
+		changed |= WIPHY_BSS_PARAM_SHORT_PREAMBLE;
+	}
+	if (info->attrs[NL80211_ATTR_BSS_SHORT_SLOT_TIME]) {
+		if (strict &&
+		    !(bss_param_support & WIPHY_BSS_PARAM_SHORT_SLOT_TIME))
+			return -EINVAL;
 		params.use_short_slot_time =
 		    nla_get_u8(info->attrs[NL80211_ATTR_BSS_SHORT_SLOT_TIME]);
+		changed |= WIPHY_BSS_PARAM_SHORT_SLOT_TIME;
+	}
 	if (info->attrs[NL80211_ATTR_BSS_BASIC_RATES]) {
+		if (strict &&
+		    !(bss_param_support & WIPHY_BSS_PARAM_BASIC_RATES))
+			return -EINVAL;
 		params.basic_rates =
 			nla_data(info->attrs[NL80211_ATTR_BSS_BASIC_RATES]);
 		params.basic_rates_len =
 			nla_len(info->attrs[NL80211_ATTR_BSS_BASIC_RATES]);
+		changed |= WIPHY_BSS_PARAM_BASIC_RATES;
 	}
-	if (info->attrs[NL80211_ATTR_AP_ISOLATE])
-		params.ap_isolate = !!nla_get_u8(info->attrs[NL80211_ATTR_AP_ISOLATE]);
-	if (info->attrs[NL80211_ATTR_BSS_HT_OPMODE])
+	if (info->attrs[NL80211_ATTR_AP_ISOLATE]) {
+		if (strict && !(bss_param_support & WIPHY_BSS_PARAM_AP_ISOLATE))
+			return -EINVAL;
+		params.ap_isolate =
+			!!nla_get_u8(info->attrs[NL80211_ATTR_AP_ISOLATE]);
+		changed |= WIPHY_BSS_PARAM_AP_ISOLATE;
+	}
+	if (info->attrs[NL80211_ATTR_BSS_HT_OPMODE]) {
+		if (strict && !(bss_param_support & WIPHY_BSS_PARAM_HT_OPMODE))
+			return -EINVAL;
 		params.ht_opmode =
 			nla_get_u16(info->attrs[NL80211_ATTR_BSS_HT_OPMODE]);
+		changed |= WIPHY_BSS_PARAM_HT_OPMODE;
+	}
 
 	if (info->attrs[NL80211_ATTR_P2P_CTWINDOW]) {
 		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
@@ -8902,8 +8934,9 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 		params.p2p_ctwindow =
 			nla_get_u8(info->attrs[NL80211_ATTR_P2P_CTWINDOW]);
 		if (params.p2p_ctwindow != 0 &&
-		    !(rdev->wiphy.bss_param_support & WIPHY_BSS_PARAM_P2P_CTWINDOW))
+		    !(bss_param_support & WIPHY_BSS_PARAM_P2P_CTWINDOW))
 			return -EINVAL;
+		changed |= WIPHY_BSS_PARAM_P2P_CTWINDOW;
 	}
 
 	if (info->attrs[NL80211_ATTR_P2P_OPPPS]) {
@@ -8912,10 +8945,10 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 			return -EINVAL;
 		tmp = nla_get_u8(info->attrs[NL80211_ATTR_P2P_OPPPS]);
-		params.p2p_opp_ps = tmp;
-		if (params.p2p_opp_ps &&
-		    !(rdev->wiphy.bss_param_support & WIPHY_BSS_PARAM_P2P_OPPPS))
+		if (tmp && !(bss_param_support & WIPHY_BSS_PARAM_P2P_OPPPS))
 			return -EINVAL;
+		params.p2p_opp_ps = tmp;
+		changed |= WIPHY_BSS_PARAM_P2P_OPPPS;
 	}
 
 	if (!rdev->ops->change_bss)
@@ -8925,6 +8958,10 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 		return -EOPNOTSUPP;
 
+	changed &= rdev->wiphy.bss_param_support;
+	if (!changed)
+		return 0;
+
 	return rdev_change_bss(rdev, dev, &params);
 }
 
-- 
2.43.5


