Return-Path: <linux-wireless+bounces-26417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B10B294D5
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 21:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2DB201426
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 19:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B8217F53;
	Sun, 17 Aug 2025 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZwFck4R2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0B1D9663
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755457496; cv=none; b=l+7nxPZXpdO20YdRrKhCfHOkK9fHeJSFccw/S1LLky57uuuZZfm1y6LzAMQHeagVYYijEiRH11+a7GrFwnWEmqi9rUAfU6Yt/KpOUYAnbOmGK7MO786CXNYzrGRlcbumKsXt+PdUkPbQQFVy25/cGUaDUzvhtpEVda3pi7gY8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755457496; c=relaxed/simple;
	bh=4R5zxnbRP6NO6ozmpVglkTXQLoV7K3Z9LSf5nZsYvMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9GWEynRHq6ZfYc9j805O+Mn+OZBZaWmhQdFAgCxot6YzPEmrj8HXCZao2FRGLdUmyClzy7RDoDVb0/gj9wqGfLe3H5/dF2UZpmou+uCA6EbB/DgY2pEGkvn1ucAmxtQ0nCyZJS0RzLCrAsWJU6u/6UPWEI86zQKCrhEa7hTACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZwFck4R2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e87035a7c3so501678185a.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755457494; x=1756062294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVf7gWlirr5fHz2MV0uYDOBNvzFwAaRo1fKhyW/K11k=;
        b=ZwFck4R2hkp5xLKcPKEXBWgRaDDEjVCMEseRf/o3/Bb9GI/BnCDB75xSg3kn7IeOBq
         C0/dS1cmMkNKqE8MhK5fmhL7nPB/KiF3JHWgS9cubKkXqowpiZIU66mY3inuCi4Q1jSu
         WVBu/54jY7P/I4K0eE9vETw/nwOlOXmcsYNDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755457494; x=1756062294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVf7gWlirr5fHz2MV0uYDOBNvzFwAaRo1fKhyW/K11k=;
        b=jYvNn4zW1ZneQ2BN8jfmNuD+lrBeS75xG5nemerzXKrxTHkt4/xxH9Uk15s6LpDsp6
         DV9C8vasag23x8kqcBRONQOtMrwvMfuNk0+s2Z9pVcJJ2qxY0fN4gNEEg5mncYlF/d7Z
         ZNY4ybiKtNajrRkH/qoWj0d/NXhnRgOmg3PHU/aCZlYyJMSOWgCBNRQavbVZABsDu7Rj
         OJ5Ap0sAgCJjkEXe+Ap1dE3iz6/USygVMTuLBaoIjR0f4PEQxcNEF2NV0/e2KN9jxgvw
         o9fKXmvpKH4mC/JnTbK95TcOo5xcVmDrhFkS27oqInEyObkPZQYTTsHCThfRJjEe9/5E
         bBhQ==
X-Gm-Message-State: AOJu0YwhLF0R8gbIUAmd1VevIwHa8hjbP6MeGnR+XgSNcKUt3J73bxmG
	iMG6sakcE3UB2kTonD4IRUaZtQQqvBEozPA6wLyUYAIHXMIfd21rEc1Nr6n49d8qDgStBbxhum0
	1dXNaQpYu
X-Gm-Gg: ASbGncv7k/nosq56AiiCexMRkIJEbz5SmhXps6U8GP9pFZiftQzre9V9xaQw73qGZI+
	7OLyVHxVjKqUAAOyppff6k9GmjGKwSj9+guUXOFj4iCwR3Tsro54X6vkDWLUstJjRMnKYoK5eqF
	OMR8JBvVKdLbgMGL/7s09g09XKdc1ztuOMO7AjOj0jqgY0MUxVf8iLSERqFY4S0zAIVuG/hy+ZF
	GlgaxudxcLL5wOjC2/kz40A8PdhX1pqH2RS+MlMw/xK2ECsF/6IRoSqbKreCP3LrYpCGkZNgeey
	BzazYGcelzk+b1eUkrfovtyWD9fcKskqdkjg3crBlXs0dNdFQLshPUK2CbqpLV6ajCcK3oWZnnG
	8W6+aycIpP2Fu928esL0JO0soLwNT9CptKT+Oy0o/8oNXgfc0m0NZC/j4R2aEnQCkf7cSVIUCfU
	29Y6wNhg==
X-Google-Smtp-Source: AGHT+IEDMX9LvX3DD0foLz7bQvrwWPRNi+7ewI5gWFJo8u8OpiHVT5yYJqHR/0Yoo6TrpNpMizT3ug==
X-Received: by 2002:a05:620a:4495:b0:7e8:3fbd:4190 with SMTP id af79cd13be357-7e886712281mr741241385a.2.1755457493581;
        Sun, 17 Aug 2025 12:04:53 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de50b31sm40382461cf.51.2025.08.17.12.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 12:04:53 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wireless-next v2 1/4] wifi: nl80211: allow drivers to support subset of NL80211_CMD_SET_BSS
Date: Sun, 17 Aug 2025 21:04:32 +0200
Message-ID: <20250817190435.1495094-2-arend.vanspriel@broadcom.com>
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

The so-called fullmac devices rely on firmware functionality and/or API to
change BSS parameters. Today there are limited drivers supporting the
nl80211 primitive, but they only handle a subset of the bss parameters
passed if any. The mac80211 driver does handle all parameters and stores
their configured values. Some of the BSS parameters were already conditional
by wiphy->features. For these the wiphy->bss_param_support and wiphy->features
fields are silently aligned in wiphy_register(). Maybe better to issue a warning
instead when they are misaligned.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 include/net/cfg80211.h       | 29 +++++++++++++++++++++++++++
 include/uapi/linux/nl80211.h |  4 ++++
 net/wireless/core.c          |  9 +++++++++
 net/wireless/nl80211.c       | 39 ++++++++++++++++++++++++++++++++++--
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 406626ff6cc8..c5bcdd298247 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2456,6 +2456,29 @@ struct mpath_info {
 	int generation;
 };
 
+/**
+ * enum wiphy_bss_param_flags - bit positions for supported bss parameters.
+ *
+ * @WIPHY_BSS_PARAM_CTS_PROT: support changing CTS protection.
+ * @WIPHY_BSS_PARAM_SHORT_PREAMBLE: support changing short preamble usage.
+ * @WIPHY_BSS_PARAM_SHORT_SLOT_TIME: support changing short slot time usage.
+ * @WIPHY_BSS_PARAM_BASIC_RATES: support reconfiguring basic rates.
+ * @WIPHY_BSS_PARAM_AP_ISOLATE: support changing AP isolation.
+ * @WIPHY_BSS_PARAM_HT_OPMODE: support changing HT operating mode.
+ * @WIPHY_BSS_PARAM_P2P_CTWINDOW: support reconfiguring ctwindow.
+ * @WIPHY_BSS_PARAM_P2P_OPPPS: support changing P2P opportunistic power-save.
+ */
+enum wiphy_bss_param_flags {
+	WIPHY_BSS_PARAM_CTS_PROT = BIT(0),
+	WIPHY_BSS_PARAM_SHORT_PREAMBLE = BIT(1),
+	WIPHY_BSS_PARAM_SHORT_SLOT_TIME = BIT(2),
+	WIPHY_BSS_PARAM_BASIC_RATES = BIT(3),
+	WIPHY_BSS_PARAM_AP_ISOLATE = BIT(4),
+	WIPHY_BSS_PARAM_HT_OPMODE = BIT(5),
+	WIPHY_BSS_PARAM_P2P_CTWINDOW = BIT(6),
+	WIPHY_BSS_PARAM_P2P_OPPPS = BIT(7),
+};
+
 /**
  * struct bss_parameters - BSS parameters
  *
@@ -5782,6 +5805,11 @@ struct wiphy_radio {
  *	and probe responses.  This value should be set if the driver
  *	wishes to limit the number of csa counters. Default (0) means
  *	infinite.
+ * @bss_param_support: bitmask indicating which bss_parameters as defined in
+ *	&struct bss_parameters the driver can actually handle in the
+ *	.change_bss() callback. The bit positions are defined in &enum
+ *	wiphy_bss_param_flags.
+ *
  * @bss_select_support: bitmask indicating the BSS selection criteria supported
  *	by the driver in the .connect() callback. The bit position maps to the
  *	attribute indices defined in &enum nl80211_bss_select_attr.
@@ -5967,6 +5995,7 @@ struct wiphy {
 
 	u8 max_num_csa_counters;
 
+	u32 bss_param_support;
 	u32 bss_select_support;
 
 	u8 nan_supported_bands;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d1a14f2892d9..b27614269d98 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2928,6 +2928,9 @@ enum nl80211_commands {
  *	required alongside this attribute. Refer to
  *	@enum nl80211_s1g_short_beacon_attrs for the attribute definitions.
  *
+ * @NL80211_ATTR_BSS_PARAM: nested attribute used with %NL80211_CMD_GET_WIPHY
+ *	which indicates which BSS parameters can be modified.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3489,6 +3492,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_S1G_LONG_BEACON_PERIOD,
 	NL80211_ATTR_S1G_SHORT_BEACON,
+	NL80211_ATTR_BSS_PARAM,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index a7e2931ffb2e..797f9f2004a6 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1018,6 +1018,15 @@ int wiphy_register(struct wiphy *wiphy)
 
 	rdev->wiphy.features |= NL80211_FEATURE_SCAN_FLUSH;
 
+	if (rdev->wiphy.bss_param_support & WIPHY_BSS_PARAM_P2P_CTWINDOW)
+		rdev->wiphy.features |= NL80211_FEATURE_P2P_GO_CTWIN;
+	else if (rdev->wiphy.features & NL80211_FEATURE_P2P_GO_CTWIN)
+		rdev->wiphy.bss_param_support |= WIPHY_BSS_PARAM_P2P_CTWINDOW;
+	if (rdev->wiphy.bss_param_support & WIPHY_BSS_PARAM_P2P_OPPPS)
+		rdev->wiphy.features |= NL80211_FEATURE_P2P_GO_OPPPS;
+	else if (rdev->wiphy.features & NL80211_FEATURE_P2P_GO_OPPPS)
+		rdev->wiphy.bss_param_support |= WIPHY_BSS_PARAM_P2P_OPPPS;
+
 	rtnl_lock();
 	wiphy_lock(&rdev->wiphy);
 	res = device_add(&rdev->wiphy.dev);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 89519aa52893..379c6d40b650 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3019,6 +3019,40 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			    rdev->wiphy.ext_features))
 			goto nla_put_failure;
 
+		if (rdev->wiphy.bss_param_support) {
+			struct nlattr *nested;
+			u32 parsup = rdev->wiphy.bss_param_support;
+
+			nested = nla_nest_start(msg, NL80211_ATTR_BSS_PARAM);
+			if (!nested)
+				goto nla_put_failure;
+
+			if ((parsup & WIPHY_BSS_PARAM_CTS_PROT) &&
+			    nla_put_flag(msg, NL80211_ATTR_BSS_CTS_PROT))
+				goto nla_put_failure;
+			if ((parsup & WIPHY_BSS_PARAM_SHORT_PREAMBLE) &&
+			    nla_put_flag(msg, NL80211_ATTR_BSS_SHORT_PREAMBLE))
+				goto nla_put_failure;
+			if ((parsup & WIPHY_BSS_PARAM_SHORT_SLOT_TIME) &&
+			    nla_put_flag(msg, NL80211_ATTR_BSS_SHORT_SLOT_TIME))
+				goto nla_put_failure;
+			if ((parsup & WIPHY_BSS_PARAM_BASIC_RATES) &&
+			    nla_put_flag(msg, NL80211_ATTR_BSS_BASIC_RATES))
+				goto nla_put_failure;
+			if ((parsup & WIPHY_BSS_PARAM_AP_ISOLATE) &&
+			    nla_put_flag(msg, NL80211_ATTR_AP_ISOLATE))
+				goto nla_put_failure;
+			if ((parsup & WIPHY_BSS_PARAM_HT_OPMODE) &&
+			    nla_put_flag(msg, NL80211_ATTR_BSS_HT_OPMODE))
+				goto nla_put_failure;
+			if ((parsup & WIPHY_BSS_PARAM_P2P_CTWINDOW) &&
+			    nla_put_flag(msg, NL80211_ATTR_P2P_CTWINDOW))
+				goto nla_put_failure;
+			if ((parsup & WIPHY_BSS_PARAM_P2P_OPPPS) &&
+			    nla_put_flag(msg, NL80211_ATTR_P2P_OPPPS))
+				goto nla_put_failure;
+			nla_nest_end(msg, nested);
+		}
 		if (rdev->wiphy.bss_select_support) {
 			struct nlattr *nested;
 			u32 bss_select_support = rdev->wiphy.bss_select_support;
@@ -8829,6 +8863,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct bss_parameters params;
+	u32 bss_param_support = rdev->wiphy.bss_param_support;
 
 	memset(&params, 0, sizeof(params));
 	params.link_id = nl80211_link_id_or_invalid(info->attrs);
@@ -8868,7 +8903,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 		params.p2p_ctwindow =
 			nla_get_u8(info->attrs[NL80211_ATTR_P2P_CTWINDOW]);
 		if (params.p2p_ctwindow != 0 &&
-		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_CTWIN))
+		    !(bss_param_support & WIPHY_BSS_PARAM_P2P_CTWINDOW))
 			return -EINVAL;
 	}
 
@@ -8880,7 +8915,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 		tmp = nla_get_u8(info->attrs[NL80211_ATTR_P2P_OPPPS]);
 		params.p2p_opp_ps = tmp;
 		if (params.p2p_opp_ps &&
-		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_OPPPS))
+		    !(bss_param_support & WIPHY_BSS_PARAM_P2P_OPPPS))
 			return -EINVAL;
 	}
 
-- 
2.43.5


