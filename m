Return-Path: <linux-wireless+bounces-26409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD356B2927D
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 11:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF158201C13
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE8A225779;
	Sun, 17 Aug 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I/ktemHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F1224AE8
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423678; cv=none; b=jPEgU4gmxpUnQkF2Ie1eqD1efFDMBLAVe7k3gWrWRZIgtkRE7wDlw4nqXPrzihqmdt4laXuyMNZ59JXXSvBMQe+Mm8iXnP0vm/GydzanUf2J27CULuk54W1E38NiWGupIONNxrq2H0CIhqt3/N0XzcGMMxOtrHBhcGpRqtnu2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423678; c=relaxed/simple;
	bh=FvRaCqQ+qhP45p9mNX+L7RrxFwswzwl25iOV4Jo+kzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rf019La1l4QKg5u+SRltyoW34NoZ3vrFvoQg8E8Brd19GtEOpR+rB1CDFWw12+gCppTCDciTgKU4Ixui1EjKwSOKSqctUrPwO9DZ37lsn7q3cC2sQlMJrHKzwvhzktT+QmY1FoYzuqt+qJJPJ9+ysvxLm4L4sSfhfWTSjdpgXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I/ktemHd; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e8704cdc76so363229985a.1
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755423676; x=1756028476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwgCuwAAoNuuHvy3DU0J6Y44vtaiSH5y9GKOl9Jrvzk=;
        b=I/ktemHdPmzBjYDESDd158ELwp4g0oBpMBSwO8aHgrnl+bx9HSjQQs+I/JU+FsOvmx
         lgxxl48eL2F6lyb7ISoFqC/MNGFDjIAGm1rt/gIRbPoBFcHj2WFqSvjgLyyZukuAaew6
         gDzgS2jkgSjXlhztqfxwRh8Waooht6N4ADPqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755423676; x=1756028476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwgCuwAAoNuuHvy3DU0J6Y44vtaiSH5y9GKOl9Jrvzk=;
        b=hoe5WZeaXUycoWLti4almO+waoJSY3KkIZDg82lWpEwDsxnKLURVWcMX6RUTW3vwm5
         PTPWs9M2xoRgUQkWQ1ulyizWkEubyiw2/ziYQ0wqIYW8CEJVI72I7rlNZWstpiymR0YT
         kEABsp2BqVioWGx2XJ1+3RKb8p83N5P0sM+QlmLgqDkyg2JPy2HyjvsfDeI5f5kraPhY
         U9PzAGwPt3r1p10kuhq9Gktpk1Ouga8a/ukxZ9PLpD4Kkp/Yco9lQP3LwnrI9fd/1wYx
         IMKeLEUsRPGIY3QeXkQ4DzEv98Wwmlb6peKsnODMSi9YYzdWiFsaUflxOPrPOWMKmqFW
         LJ7Q==
X-Gm-Message-State: AOJu0Yz3YR7Dl6R6EtR92yJesMoy6BRkDgLgjvc/f1HS3sHl0MPBpwwC
	k/GGwzPFmvs950Y2RtFFdRKwErv1oyifQddG6vby2G/a6nWH1OS7qABF2pP10S6+xq3DhJwYs3H
	TVFyOrcLp
X-Gm-Gg: ASbGncsQaRwJN8HqUdx/iWeMe8RjB1aUOGXul/2UkaSTwOZMSaPYG5UqAkvhfDKFxG2
	SRqHlb7zJUNWpzaQMXVSWusCVRe/CIcdqAv8+zxuMfWucRZ+pXZdE5uEFn5SJHOrUYb03aM2HSm
	yeqSdW6E4TwWL0Wo1vbDUaO4eCZojIDIZ8rqM6EvaUYG3luDzxh0eX8O9tJDqSKmbgOGxiLC37m
	oOR0Sr2mbg2F0JQTxAzxIwx+abF9HEP2AHFUjF9HuGawStLz7vcroS0sIMlOmsooymKlIwUYaxj
	JQ0WJ8geU4KAMms/G3AAvU304fNTR0soJNkiTXucIC29WVNAApWK5oslXd+QVDL82s/3/dhCKAi
	pdBPWJOHAloDsbLxhgaFabRizZB9Izu+U+sG/Q7ZloHHjLXgzeVJekd2T6Te8HVDGRrCuFXr0/7
	KJ3PRqoA==
X-Google-Smtp-Source: AGHT+IFEB2ry02BUN+vzqtJPJmUVmj16i4BqH9tdLnoF50oq6NLVS3vi4TRRN64Fs9ifTNpBKU3nhg==
X-Received: by 2002:a05:620a:1a8b:b0:7e6:9686:affd with SMTP id af79cd13be357-7e8867caf15mr756390785a.42.1755423675818;
        Sun, 17 Aug 2025 02:41:15 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f819sm35706346d6.9.2025.08.17.02.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 02:41:15 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wl-next 1/4] wifi: nl80211: allow drivers to support subset of NL80211_CMD_SET_BSS
Date: Sun, 17 Aug 2025 11:41:00 +0200
Message-ID: <20250817094103.941090-2-arend.vanspriel@broadcom.com>
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
 net/wireless/nl80211.c       | 38 ++++++++++++++++++++++++++++++++++--
 4 files changed, 78 insertions(+), 2 deletions(-)

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
index d1a14f2892d9..50750aa3c2ea 100644
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
index 89519aa52893..8003667f0db5 100644
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
@@ -8868,7 +8902,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 		params.p2p_ctwindow =
 			nla_get_u8(info->attrs[NL80211_ATTR_P2P_CTWINDOW]);
 		if (params.p2p_ctwindow != 0 &&
-		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_CTWIN))
+		    !(rdev->wiphy.bss_param_support & WIPHY_BSS_PARAM_P2P_CTWINDOW))
 			return -EINVAL;
 	}
 
@@ -8880,7 +8914,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 		tmp = nla_get_u8(info->attrs[NL80211_ATTR_P2P_OPPPS]);
 		params.p2p_opp_ps = tmp;
 		if (params.p2p_opp_ps &&
-		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_OPPPS))
+		    !(rdev->wiphy.bss_param_support & WIPHY_BSS_PARAM_P2P_OPPPS))
 			return -EINVAL;
 	}
 
-- 
2.43.5


