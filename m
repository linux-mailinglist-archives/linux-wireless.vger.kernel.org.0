Return-Path: <linux-wireless+bounces-26419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D92BB294D6
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 21:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191D220141F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA6E14EC73;
	Sun, 17 Aug 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WT9GK3WL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799021E082
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755457500; cv=none; b=rL6W5gbuXV1kXzK1W2V3LJB7LDIu+Iq2hPYKhso4ass0xiMeXhyQDrK0eOc3d2+uZVynys9n7zAeEFP1kJ11+53v4E/DBGxrX3Q+8emwZt8kbH9QmsI6sTvTrR+CEY1m00tMkoAxt329JinJvc2PYVls85qzOYoyMflAy4S/77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755457500; c=relaxed/simple;
	bh=vEFVbB2SmisgIXJoaMjaiuVu+dXZ4m1ouQNidypipqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6TSFuIbZU6fpDNTFpMQcgwzT0NRk/8ZJZfNsY1Y2Wwt3ZUYFhWQDFHrjzD47eo1UvEWlnOiZhCB7AXDgWA4sGiIOFFdoPI7S0UT20/wsyTutJ0yVVRqBGjWJdtLQxLREHmT6SVuSSsElAUEIxzVCp3Uyv965IQHKTLKUGCuAsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WT9GK3WL; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109912545so38128831cf.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755457496; x=1756062296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K9F9stUcHItMGPx2gd9JWX+dHSLyDbc7/NXa2s6Tvk=;
        b=WT9GK3WLFVvlzxawxLw8J8malGjwKRboQH0mvXBgZq8uve+pYtv/1sSBIZyw2n40Mq
         5tHDn47Lr3YVmxHVoXknS6gVsswi4hjlCCVrMgCvaaPc0D3Ar5iVBdoOUnazcjneDUHZ
         DmAEZtiUPGiK5AObWAgJA0O1oKkajsn+8Du2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755457496; x=1756062296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0K9F9stUcHItMGPx2gd9JWX+dHSLyDbc7/NXa2s6Tvk=;
        b=pN6eH/HmWmqgbVUsjkas/9TxOcua+TiEwDIIb8tOOais9A32jcjxxtTaXdp2jJTHyI
         CWxte09CrPxQAlWhoEjKwqknwefC+CAqs4g/RQyXUvrFWSlmEMAu5fKIdAFnQLL8Cpik
         FXOppOMUhNuqV7jXoKlk0oEAHipMTvedJNxv62KqENbAGdzJZ9LmBAYKnjzVMpyNtiMZ
         2dBGN5pAN1xMhB7gVPuKlsTDXm4N+Fam7RrX0xoQXV4YwomnOprDmZcn94m1z/KsUmv6
         4k8FMDw8zTCs036GmMBX/ZNKQ6X/htdYOOPBdDwOolL7Rq1BdRWjXWkJK2XN4DfkhTXt
         BLWQ==
X-Gm-Message-State: AOJu0Yy8tYks8mYogv76AOKWMW3kpMVBWduaNZ8fbTdm2tbo32PHPj9p
	LP698K5RMDkK8vWzJvAWToVMyuS6N1T+gyLp0GdcKryePVqEPXpMdwnSnT8Tl4YRlg==
X-Gm-Gg: ASbGncvrp3gpBXjovK/VWWIXgWY2TcCNGsTcQLhSPCzicZnMZKk+yNqWOSZL1NBN+cF
	MeCoJ5phYJJ5kkat2FBeiLo0++ztx8dwhIuNaIr4+NF/cddh3iJPHZevZvXhsd12Q9BUuIhHB9a
	znz7Ygi7PmhlI6jyofmheZ1nHGk4RhyyEwpgPBCN57RMFnBICCGqRTi/CTJPGdD8RGCWJj5ZvSY
	oGDhwNkf1BlXcAOXzDeb3XRI7cpl7qT+p2TsJ/sVyUGgI8woJTqWN1p+3v/uhZ0TcEPyzLcOG1k
	nI86GTTrYado/OyVMEqwRGHYZvMJjPXx96L0mnG3OxqXBQnxTZNLz8fD58dTzWnBrFblw4UvKQY
	HhKDr5ai/qCjUnt3RlM1LOXm2tqR3c2lR4JgzDGv5j3HRkZjizh2vFjefTBrItQXrxvDnsWcVaF
	RXuV+LSg==
X-Google-Smtp-Source: AGHT+IGi9Zj7stGLJybSRddb3OnvwILzVShuwQyRhJS2TSWURorhoA2bJxWJb8jYjrjKAMzlED6Quw==
X-Received: by 2002:a05:622a:4a1a:b0:4ab:9586:bdd6 with SMTP id d75a77b69052e-4b12a3afe95mr100367011cf.53.1755457496500;
        Sun, 17 Aug 2025 12:04:56 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de50b31sm40382461cf.51.2025.08.17.12.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 12:04:56 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next v2 3/4] wifi: nl80211: strict checking attributes for NL80211_CMD_SET_BSS
Date: Sun, 17 Aug 2025 21:04:34 +0200
Message-ID: <20250817190435.1495094-4-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250817190435.1495094-1-arend.vanspriel@broadcom.com>
References: <20250817190435.1495094-1-arend.vanspriel@broadcom.com>
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
 net/wireless/nl80211.c       | 52 +++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b27614269d98..9e0427ecaf3c 100644
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
index 379c6d40b650..66b58a1d43db 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -871,6 +871,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_S1G_LONG_BEACON_PERIOD] = NLA_POLICY_MIN(NLA_U8, 2),
 	[NL80211_ATTR_S1G_SHORT_BEACON] =
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
+	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -8864,6 +8865,8 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct bss_parameters params;
 	u32 bss_param_support = rdev->wiphy.bss_param_support;
+	u32 changed = 0;
+	bool strict;
 
 	memset(&params, 0, sizeof(params));
 	params.link_id = nl80211_link_id_or_invalid(info->attrs);
@@ -8876,26 +8879,54 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
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
@@ -8905,6 +8936,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 		if (params.p2p_ctwindow != 0 &&
 		    !(bss_param_support & WIPHY_BSS_PARAM_P2P_CTWINDOW))
 			return -EINVAL;
+		changed |= WIPHY_BSS_PARAM_P2P_CTWINDOW;
 	}
 
 	if (info->attrs[NL80211_ATTR_P2P_OPPPS]) {
@@ -8913,9 +8945,11 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 			return -EINVAL;
 		tmp = nla_get_u8(info->attrs[NL80211_ATTR_P2P_OPPPS]);
+		if (tmp && !(bss_param_support & WIPHY_BSS_PARAM_P2P_OPPPS))
+			return -EINVAL;
 		params.p2p_opp_ps = tmp;
 		if (params.p2p_opp_ps &&
-		    !(bss_param_support & WIPHY_BSS_PARAM_P2P_OPPPS))
+		    !(rdev->wiphy.bss_param_support & WIPHY_BSS_PARAM_P2P_OPPPS))
 			return -EINVAL;
 	}
 
@@ -8926,6 +8960,10 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
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


