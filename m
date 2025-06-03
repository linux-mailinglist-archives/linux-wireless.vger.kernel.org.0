Return-Path: <linux-wireless+bounces-23548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE12DACC466
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 12:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC957189306B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843A1229B2E;
	Tue,  3 Jun 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="kwYBRmdx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEA6214811
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946900; cv=none; b=VEDt2DRal7NSoExuG8XGENTwS2YfbRyM66DeoEfPmjDLrcS7+vzSN7ERl2/kTsDtoIPYERrkVfUQDESIuJO6+5jZiwCqOR8RAexf4hRUxRILNJWWsF42lsOX1iKXbBT9PsVYoh47HPOmAV9LdK4LlCF2AKqcguwkaqw3dcm0/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946900; c=relaxed/simple;
	bh=hfQG8bONJBeIT9xUVOfIypYgzSzybSYfr20KUidkYMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dramTQnQmqKTIXVEFu5LPP7JgX/WOev3zfcEL69OiUaTx9RzqhhnCDLeLBDzpPHrvj23xoQThb6ETsq7JVD3J6sZuTn5hcfXlfu96z8jcY0g1ZeFz6hiG+IV4h0HO7nokAPlOOGz6iFGTj00E81fMsJPmRA1AsJ9YUl9NFBhqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=kwYBRmdx; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748946898; x=1780482898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hfQG8bONJBeIT9xUVOfIypYgzSzybSYfr20KUidkYMU=;
  b=kwYBRmdxfUvIZD4SorU+sMBM1Fa53YCsayFIZ2su7aL9F/+T9udG4RSZ
   XaK2AYLMaQm+D7fh0aNxHxSoBw361TP5NWz2GqMUd0cnWtUxKgZ+xUlIr
   KT7NTIca6t9BSxny/EagbbHiJ4Y8+eBPE+fTN2KAQSjFrY22yxBHKdmSZ
   8=;
X-CSE-ConnectionGUID: wiaYOMExRfq2HtCR4NpSLw==
X-CSE-MsgGUID: WqCEaBbgQiylMYOtFHcWZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="112926831"
X-IronPort-AV: E=Sophos;i="6.16,205,1744063200"; 
   d="scan'208";a="112926831"
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:33:48 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 12:33:47 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 12:33:45 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 1/5] wifi: cfg80211: Add support to indicate changed AP BSS parameters to driver
Date: Tue, 3 Jun 2025 16:02:48 +0530
Message-ID: <20250603103252.18039-2-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
References: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE815.infineon.com (172.23.29.41) To
 MUCSE827.infineon.com (172.23.29.20)

With the userspace applications like hostapd, incase if the user explicitly
enabled an AP BSS param related config file option, like "ap_isolate", or
if the hostapd implicitly sets an AP BSS param like "cts_protection", then
those params are sent to the cfg80211 as part of SET_BSS operation request.

cfg80211 would then set the bits corresponding to the AP BSS parameters in
the newly introduced "changed" bitmap. Drivers which have registered for
the .change_bss() cfg80211_ops, on receiving this SET_BSS request, can now
understand which specific subset of params are changed by the userspace
using this bitmask. If the driver allows explicit configuration of changed
AP BSS params and if the values of those params are different from default
value in driver/firmware, then the driver can update it accordingly.

This helps ensuring that the driver does not partially handle the AP BSS
params and avoid misleading the userspace that the SET_BSS operation is
fully successful.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 include/net/cfg80211.h | 30 ++++++++++++++++++++++++++++++
 net/wireless/nl80211.c | 28 +++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..1f069ccb411e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2326,12 +2326,41 @@ struct mpath_info {
 	int generation;
 };
 
+/**
+ * enum cfg80211_bss_params_changed - BSS parameters that are being changed
+ *
+ * This enum provides information of all BSS parameters that
+ * have to be updated as part of change_bss() call.
+ *
+ * @CFG80211_BSS_PARAM_CHANGED_CTS_PROT: Indicates that CTS Protection changed.
+ * @CFG80211_BSS_PARAM_CHANGED_SHORT_PREAMBLE: Indicates that preamble changed.
+ * @CFG80211_BSS_PARAM_CHANGED_SHORT_SLOT_TIME: Indicates that slot timing changed.
+ * @CFG80211_BSS_PARAM_CHANGED_BASIC_RATES: Indicatesthat Basic Rateset changed.
+ * @CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE: Indicates that AP Isolation setting changed.
+ * @CFG80211_BSS_PARAM_CHANGED_HT_OPMODE: Indicates that HT mode to be changed.
+ * @CFG80211_BSS_PARAM_CHANGED_P2P_CTWINDOW: Indicates that P2P CTWindow changed.
+ * @CFG80211_BSS_PARAM_CHANGED_P2P_OPPPS: Indicates that P2P Opportunistic
+ *	Power Save Mode changed.
+ */
+enum cfg80211_bss_params_changed {
+	CFG80211_BSS_PARAM_CHANGED_CTS_PROT		= BIT(0),
+	CFG80211_BSS_PARAM_CHANGED_SHORT_PREAMBLE	= BIT(1),
+	CFG80211_BSS_PARAM_CHANGED_SHORT_SLOT_TIME	= BIT(2),
+	CFG80211_BSS_PARAM_CHANGED_BASIC_RATES		= BIT(3),
+	CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE		= BIT(4),
+	CFG80211_BSS_PARAM_CHANGED_HT_OPMODE		= BIT(5),
+	CFG80211_BSS_PARAM_CHANGED_P2P_CTWINDOW		= BIT(6),
+	CFG80211_BSS_PARAM_CHANGED_P2P_OPPPS		= BIT(7),
+};
+
 /**
  * struct bss_parameters - BSS parameters
  *
  * Used to change BSS parameters (mainly for AP mode).
  *
  * @link_id: link_id or -1 for non-MLD
+ * @changed: bitmask of BSS parameters being changed by the user,
+ *	see &enum cfg80211_bss_params_changed.
  * @use_cts_prot: Whether to use CTS protection
  *	(0 = no, 1 = yes, -1 = do not change)
  * @use_short_preamble: Whether the use of short preambles is allowed
@@ -2350,6 +2379,7 @@ struct mpath_info {
  */
 struct bss_parameters {
 	int link_id;
+	u32 changed;
 	int use_cts_prot;
 	int use_short_preamble;
 	int use_short_slot_time;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fd5f79266471..719517f58110 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8243,26 +8243,42 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 	params.p2p_ctwindow = -1;
 	params.p2p_opp_ps = -1;
 
-	if (info->attrs[NL80211_ATTR_BSS_CTS_PROT])
+	if (info->attrs[NL80211_ATTR_BSS_CTS_PROT]) {
 		params.use_cts_prot =
 		    nla_get_u8(info->attrs[NL80211_ATTR_BSS_CTS_PROT]);
-	if (info->attrs[NL80211_ATTR_BSS_SHORT_PREAMBLE])
+		params.changed |= CFG80211_BSS_PARAM_CHANGED_CTS_PROT;
+	}
+
+	if (info->attrs[NL80211_ATTR_BSS_SHORT_PREAMBLE]) {
 		params.use_short_preamble =
 		    nla_get_u8(info->attrs[NL80211_ATTR_BSS_SHORT_PREAMBLE]);
-	if (info->attrs[NL80211_ATTR_BSS_SHORT_SLOT_TIME])
+		params.changed |= CFG80211_BSS_PARAM_CHANGED_SHORT_PREAMBLE;
+	}
+
+	if (info->attrs[NL80211_ATTR_BSS_SHORT_SLOT_TIME]) {
 		params.use_short_slot_time =
 		    nla_get_u8(info->attrs[NL80211_ATTR_BSS_SHORT_SLOT_TIME]);
+		params.changed |= CFG80211_BSS_PARAM_CHANGED_SHORT_SLOT_TIME;
+	}
+
 	if (info->attrs[NL80211_ATTR_BSS_BASIC_RATES]) {
 		params.basic_rates =
 			nla_data(info->attrs[NL80211_ATTR_BSS_BASIC_RATES]);
 		params.basic_rates_len =
 			nla_len(info->attrs[NL80211_ATTR_BSS_BASIC_RATES]);
+		params.changed |= CFG80211_BSS_PARAM_CHANGED_BASIC_RATES;
 	}
-	if (info->attrs[NL80211_ATTR_AP_ISOLATE])
+
+	if (info->attrs[NL80211_ATTR_AP_ISOLATE]) {
 		params.ap_isolate = !!nla_get_u8(info->attrs[NL80211_ATTR_AP_ISOLATE]);
-	if (info->attrs[NL80211_ATTR_BSS_HT_OPMODE])
+		params.changed |= CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE;
+	}
+
+	if (info->attrs[NL80211_ATTR_BSS_HT_OPMODE]) {
 		params.ht_opmode =
 			nla_get_u16(info->attrs[NL80211_ATTR_BSS_HT_OPMODE]);
+		params.changed |= CFG80211_BSS_PARAM_CHANGED_HT_OPMODE;
+	}
 
 	if (info->attrs[NL80211_ATTR_P2P_CTWINDOW]) {
 		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
@@ -8272,6 +8288,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 		if (params.p2p_ctwindow != 0 &&
 		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_CTWIN))
 			return -EINVAL;
+		params.changed |= CFG80211_BSS_PARAM_CHANGED_P2P_CTWINDOW;
 	}
 
 	if (info->attrs[NL80211_ATTR_P2P_OPPPS]) {
@@ -8284,6 +8301,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 		if (params.p2p_opp_ps &&
 		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_OPPPS))
 			return -EINVAL;
+		params.changed |= CFG80211_BSS_PARAM_CHANGED_P2P_OPPPS;
 	}
 
 	if (!rdev->ops->change_bss)
-- 
2.47.0


