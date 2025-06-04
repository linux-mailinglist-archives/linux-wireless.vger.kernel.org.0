Return-Path: <linux-wireless+bounces-23681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB1AACDA5C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847E21895EB2
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91F28C2CB;
	Wed,  4 Jun 2025 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JPEaVgA5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A120E6E3
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 08:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027351; cv=none; b=L1+qXxqUKBn/MAEzIG1is+iGbqJiw7cw2pDjHDgXUC0t2mKWjqMhSxPIYRuaLQ0FclJOnMzKXZlcBbiKyhk2rta35ZQApoNYhh+K2+gb1iOJ/NimSzkYtLcYtzlS3Jqh0WjaSPCkDk74uiJ6hbT1jm91XR7CXxcvuPikuMtp0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027351; c=relaxed/simple;
	bh=kobPPUEAAfS7+2sRgxlo8foABZXoKkSiwucOq66MWJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6fT+YQwCE6yDB3QlRexcyDGYBvzSwKLkCZ12nbUeI7QYQwAuWCb7G/MnBVckRVJKZ75AdMoFk5mp/tgdxDzKWwZcCBDY6M5sQ8bHExnYZMrYW5OrEUpmxUByzkDxF4CMNBC7Bz30manMTMGi2bUqaWzjRmdtBeDdb8ikFsbB+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JPEaVgA5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450dd065828so34284655e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 01:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749027346; x=1749632146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txWsZdY/j2eCvGNwWqWYzdxsjKCyeCghlNrrPm8TRYk=;
        b=JPEaVgA5O3FTkLkknhoSpOZbT5rsOXIfh67HeH+gmuhPMxpXLzhdO7c/mEZel/G3zr
         F6C/yACo3MJc2jeAds+IiFgfpYHJ/u7Rmgi7BaTyG2xqvc6ClOJm2mR/Ah1MA1ggoVdM
         w9m25Kn7yky7wmggsJrunwbC6GtGAKqaUJ8hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749027346; x=1749632146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txWsZdY/j2eCvGNwWqWYzdxsjKCyeCghlNrrPm8TRYk=;
        b=iIu4axizLobHHFb6f06CHU0HOMceEtoO9mIuYhukvE0qhMV4O6NZtzatuCe1WW/nbH
         e7pRpMOpgaIqY8rIBuIULBXIQEWo+6eZvjsQDnpnnpA9lr+n1fxe1Dr5Ihu5M9lwvDeP
         zzTgVaLz6/B7ZaMuazsGPhFhlW+32UqwWqR9Hv9oNzMgs16XsGh0jFMPKUQ1mEon6YiE
         0arAf0wQgtjxpwKR5c+IekTpsf5/uxTCQ23kJFxoE0r3bl1vubStM6OajgC58ip/9sbJ
         YRJ9T1eByOwVtjuQ5O2aqSTJpAay5gkyhLkfDhivdn/8W80tXojouUOWNLa+dM4o2zkN
         rTaQ==
X-Gm-Message-State: AOJu0YwB/R1gJa8tr8lPA+/G+PQXPuBHnnfeva4qFwujzWuwdt2avf2z
	YE6clJwn/TI7sMcanyOo/nVymjkWIjbz69KUJqpJHNckmLoJqTdyEXbdnCgvyhMA4A==
X-Gm-Gg: ASbGncsL5SfgC8JptZ9fNdf4+0U7vCYvIGHSMYXwQr9LuXK0a7rB4lLEYSBaDTF/VY4
	58qXppcwAURPBCrhWepYEv1AMeQR5dDCWyC5dWYdiMBnc9OK0dubnG4hrT6s209G9kHnsqQ0Mvc
	3AXxpg699kLEEXotETiG0CrfQMzeR5WN9ZzJnT4w4DstxXuWu03khaQLy5MD80EVXuHSPiCAI5G
	KcT7PKTcyUhgjXd5KGd9Jzi/krrQCVyFuG3whyAI8nEcz6VxiB6jihMHJBfuazEZ/rfrLT5tgT3
	BEguZxuEnH++YQKtErsC5PE5GlU5Z9GQ57fpebD3p/IW0ALXIjkmm0nQBEKRW/1WEsjV3V03Cb2
	qiLfeO3clt8LbJRtCReJYUc8kj8gRf3s=
X-Google-Smtp-Source: AGHT+IHBc9A7qhONZIeU8GfRbrUtUNGSHBHen2pxv3ub+R4FjzMp/AhQCa7Advc1++iHB0hsTptHkg==
X-Received: by 2002:a05:6000:2409:b0:3a4:ed4c:422f with SMTP id ffacd0b85a97d-3a51d96e1d7mr1461784f8f.44.1749027346566;
        Wed, 04 Jun 2025 01:55:46 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb09a3sm189165695e9.24.2025.06.04.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:55:46 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC 1/4] wifi: nl80211: allow drivers to support subset of NL80211_CMD_SET_BSS
Date: Wed,  4 Jun 2025 10:55:35 +0200
Message-ID: <20250604085539.2803896-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
References: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
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
their configured values.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 include/net/cfg80211.h       | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/nl80211.h |  4 ++++
 net/wireless/nl80211.c       | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1848dc8ec99..8f9338c1e976 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2326,6 +2326,30 @@ struct mpath_info {
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
+	WIPHY_BSS_PARAM_MASK = (WIPHY_BSS_PARAM_P2P_OPPPS << 1) - 1
+};
+
 /**
  * struct bss_parameters - BSS parameters
  *
@@ -5638,6 +5662,11 @@ struct wiphy_radio {
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
@@ -5817,6 +5846,7 @@ struct wiphy {
 
 	u8 max_num_csa_counters;
 
+	u32 bss_param_support;
 	u32 bss_select_support;
 
 	u8 nan_supported_bands;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e9ccf43fe3c6..b81dffad2f8f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2899,6 +2899,9 @@ enum nl80211_commands {
  *	APs Support". Drivers may set additional flags that they support
  *	in the kernel or device.
  *
+ * @NL80211_ATTR_BSS_PARAM: nested attribute used with %NL80211_CMD_GET_WIPHY
+ *	which indicates which BSS parameters can be modified.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3455,6 +3458,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_EPCS,
 
 	NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS,
+	NL80211_ATTR_BSS_PARAM,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fd5f79266471..bf3cd044de13 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2996,6 +2996,40 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
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
-- 
2.43.5


