Return-Path: <linux-wireless+bounces-20035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D40A57E5B
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FF67A670F
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BC11A08B1;
	Sat,  8 Mar 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azE0hwlu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C81A4E9D
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741467998; cv=none; b=eYB/NqrQYE84BtildWL5O8J+h05BZ+xtQuNAjvHL3Fb2nXTPjRnRjG3f2hq2UPE20Mxu2mwd6ZfBX9hCeOv8RuES+fGDqKXykmvCKY//JA8pdnwUqz0HF6Ulw2XSqk5at8Ce5h/cc7bXEwtxLPrUVHzzb0Oi50/RB9U9DFzponA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741467998; c=relaxed/simple;
	bh=nNDNwW2ZN1Qp/TQmf5OAJQWk2mHc8zN7tz9Fxb4t+Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U04mIPpvMbNojAEunGkWKVIh8TzGEJ00FmdZU4cFvdUmlge95k9K3eUCOuR5OJYehYODaPSpKWT26A4snKSTGv2UYdJ3Fm68RSDXJFdRrq40dTlvGgM+X/Zb+cjKKCqGTncP6nyBC/Be0H5W/VYTwj78yRmwsdKtyhmFoE5CfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azE0hwlu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741467997; x=1773003997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nNDNwW2ZN1Qp/TQmf5OAJQWk2mHc8zN7tz9Fxb4t+Q4=;
  b=azE0hwlu9oZJ4H4eJa6Eh+FGxW4fup04xDgikas/CtEAs0Llf5ncy7yf
   xx16jA/2qzILmzo2WrfQUkIouoWT5Tzr3bctWInNXsf76hZ/QycZLbqfw
   Z6Gua5C8Z7UGQqr2PEmIUBuf9rwyuZzZumxL7siKNvYdXt6WNVuEgZUE7
   dZQvHFCW1PnG0dT1+Zx0JFbh1fTqUXVlqV6XCIGMYPUMMiVVi4Wk79+de
   GbkRzVt71AgD9+leutS6GfjSysxS/sWvfFXmXjTKJJEGyNKgJ5Gifd1z4
   c8H3GI4bUZoKgGkdWyBe5yo4WUdSNImpANpNL11Ciu+qmXk09IJRAWAYg
   Q==;
X-CSE-ConnectionGUID: SAH+7BpDTd+0UjnsyuSGVg==
X-CSE-MsgGUID: AuzQ46sFSguZyW3JnoAgAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413065"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413065"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:03 -0800
X-CSE-ConnectionGUID: lMAH/DYNSBGQABUCVIxNog==
X-CSE-MsgGUID: 1JqiwWZGRwaV0innl5nbmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644375"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH RESEND wireless-next 06/15] wifi: cfg80211: improve supported_selector documentation
Date: Sat,  8 Mar 2025 23:03:32 +0200
Message-Id: <20250308225541.ba402ff47314.I502b56111b62ea0be174ae76bd03684ae1d4aefb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Improve the documentation for supported BSS selectors to make it more
precise.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 4 ++--
 include/uapi/linux/nl80211.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0d423830a8ed..c61894c1265a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3148,10 +3148,10 @@ enum cfg80211_assoc_req_flags {
  *	included in the Current AP address field of the Reassociation Request
  *	frame.
  * @flags:  See &enum cfg80211_assoc_req_flags
- * @supported_selectors: supported selectors in IEEE 802.11 format
+ * @supported_selectors: supported BSS selectors in IEEE 802.11 format
  *	(or %NULL for no change).
  *	If %NULL, then support for SAE_H2E should be assumed.
- * @supported_selectors_len: Length of supported_selectors in octets.
+ * @supported_selectors_len: number of supported BSS selectors
  * @ht_capa:  HT Capabilities over-rides.  Values set in ht_capa_mask
  *	will be used in ht_capa.  Un-supported values will be ignored.
  * @ht_capa_mask:  The bits of ht_capa which are to be used.
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 95287289b3b4..a945ad223cfd 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2881,9 +2881,9 @@ enum nl80211_commands {
  * @NL80211_ATTR_VIF_RADIO_MASK: Bitmask of allowed radios (u32).
  *	A value of 0 means all radios.
  *
- * @NL80211_ATTR_SUPPORTED_SELECTORS: supported selectors, array of
- *	supported selectors as defined by IEEE 802.11 7.3.2.2 but without the
- *	length restriction (at most %NL80211_MAX_SUPP_SELECTORS).
+ * @NL80211_ATTR_SUPPORTED_SELECTORS: supported BSS Membership Selectors, array
+ *	of supported selectors as defined by IEEE Std 802.11-2020 9.4.2.3 but
+ *	without the length restriction (at most %NL80211_MAX_SUPP_SELECTORS).
  *	This can be used to provide a list of selectors that are implemented
  *	by the supplicant. If not given, support for SAE_H2E is assumed.
  *
-- 
2.34.1


