Return-Path: <linux-wireless+bounces-25134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E484AFF328
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F43617CBC1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E3F24729D;
	Wed,  9 Jul 2025 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jw1/AlAe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9624677E
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093512; cv=none; b=PWwH2cm72TR2H1N12gTW2yr8gQgtkgLs47WpNBcwVT1oKv5zqGMvS+y+urs+feBFW90/CJz0T3epl3cYo8TrPlSC4Kw8awTFQd8birkro3Sapm031PI4BaefgaZAyVl7kgVLEIXcwjf8jI8UWNDABqtwsPibQbvGC250k4ZlF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093512; c=relaxed/simple;
	bh=E4+O1y7C8pVnYTEFCrRmWIHPI9mD89rapbmh/nUuYQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t8fL6jmQhvu8H+/Sj9VYTnjT7Kj6VyvdMtlosh2xEtizoxEZyGwAn6psNAK7Zhcf2cDsuwTDfeAmbOOv7ld14nHX5M/Ex8lskfp/QGz28p7McPTmuFEv2Ta1aXxa0jOZz/lq9CxyOWG99uG29cp5qdb/PoET+AUBtsIHTFP54Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jw1/AlAe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093510; x=1783629510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E4+O1y7C8pVnYTEFCrRmWIHPI9mD89rapbmh/nUuYQ8=;
  b=jw1/AlAeGPjUT8Tot+vQRt+QEypwsuVAX+n3UT2x5Dc7jcwN0NtRSniU
   0Urf80CNX8boV3bohQQE3tGntN+ADwHB8BXsSsZyHjzKwOMBkezya+jYo
   zLX4KZTOZegroR8hp6WYMp9R2ikALQWxUJVEyPJeyM9fk5jxh4m4MD0H/
   xuziljXtElmLmJzfdKpnn26lY1uR9FqfrPLqoKtye3zwlk7ruyYDCScq/
   mel/7T1sCqxI+sm8VRZwTWNtc5pgbjbllPRR+Ok6Lviz4VbyM4b3ITbbQ
   TMvbi1xxIWQBpqf/0BkOB2+HrKc8iEGBB/wtbc0XubCTIocGreVFdRwT2
   Q==;
X-CSE-ConnectionGUID: p6f3Fgz3Qy+jLsuqGentvw==
X-CSE-MsgGUID: sgiQe+2WTr2hmrFczxzSXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974447"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974447"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:30 -0700
X-CSE-ConnectionGUID: +Ae8ugFIQOuiXFxO5wA6/A==
X-CSE-MsgGUID: 64YilCzrSS+lhD3ndWM89w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161532936"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 05/11] wifi: mac80211: clean up cipher suite handling
Date: Wed,  9 Jul 2025 23:37:57 +0300
Message-Id: <20250709233537.cff427e8f8a5.I744d1ea6a37e3ea55ae8bc3e770acee734eff268@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
References: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Under the previous commit's assumption that FIPS isn't
supported by hardware, we don't need to modify the
cipher suite list, but just need to use the software
one instead of the driver's in this case, so clean up
the code.

Also fix it to exclude TKIP in this case, since that's
also dependent on RC4.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/main.c        | 69 ++++++++++----------------------------
 2 files changed, 17 insertions(+), 54 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 142b547ca606..2a482089f9e1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1403,8 +1403,6 @@ struct ieee80211_local {
 	bool rx_mcast_action_reg;
 	unsigned int filter_flags; /* FIF_* */
 
-	bool wiphy_ciphers_allocated;
-
 	struct cfg80211_chan_def dflt_chandef;
 	bool emulate_chanctx;
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index c1c758e76d2e..ec60b82af007 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2017     Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -1025,12 +1025,9 @@ EXPORT_SYMBOL(ieee80211_alloc_hw_nm);
 
 static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 {
-	bool have_wep = !fips_enabled; /* FIPS does not permit the use of RC4 */
 	bool have_mfp = ieee80211_hw_check(&local->hw, MFP_CAPABLE);
-	int r = 0, w = 0;
-	u32 *suites;
 	static const u32 cipher_suites[] = {
-		/* keep WEP first, it may be removed below */
+		/* keep WEP and TKIP first, they may be removed below */
 		WLAN_CIPHER_SUITE_WEP40,
 		WLAN_CIPHER_SUITE_WEP104,
 		WLAN_CIPHER_SUITE_TKIP,
@@ -1046,34 +1043,17 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 		WLAN_CIPHER_SUITE_BIP_GMAC_256,
 	};
 
-	if (ieee80211_hw_check(&local->hw, SW_CRYPTO_CONTROL) ||
-	    local->hw.wiphy->cipher_suites) {
-		/* If the driver advertises, or doesn't support SW crypto,
-		 * we only need to remove WEP if necessary.
-		 */
-		if (have_wep)
-			return 0;
-
-		/* well if it has _no_ ciphers ... fine */
-		if (!local->hw.wiphy->n_cipher_suites)
-			return 0;
-
-		/* Driver provides cipher suites, but we need to exclude WEP */
-		suites = kmemdup_array(local->hw.wiphy->cipher_suites,
-				       local->hw.wiphy->n_cipher_suites,
-				       sizeof(u32), GFP_KERNEL);
-		if (!suites)
-			return -ENOMEM;
-
-		for (r = 0; r < local->hw.wiphy->n_cipher_suites; r++) {
-			u32 suite = local->hw.wiphy->cipher_suites[r];
-
-			if (suite == WLAN_CIPHER_SUITE_WEP40 ||
-			    suite == WLAN_CIPHER_SUITE_WEP104)
-				continue;
-			suites[w++] = suite;
-		}
-	} else {
+	if (ieee80211_hw_check(&local->hw, SW_CRYPTO_CONTROL) && fips_enabled) {
+		dev_err(local->hw.wiphy->dev.parent,
+			"Drivers with SW_CRYPTO_CONTROL cannot work with FIPS\n");
+		return -EINVAL;
+	}
+
+	if (WARN_ON(ieee80211_hw_check(&local->hw, SW_CRYPTO_CONTROL) &&
+		    !local->hw.wiphy->cipher_suites))
+		return -EINVAL;
+
+	if (fips_enabled || !local->hw.wiphy->cipher_suites) {
 		/* assign the (software supported and perhaps offloaded)
 		 * cipher suites
 		 */
@@ -1083,19 +1063,13 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 		if (!have_mfp)
 			local->hw.wiphy->n_cipher_suites -= 4;
 
-		if (!have_wep) {
-			local->hw.wiphy->cipher_suites += 2;
-			local->hw.wiphy->n_cipher_suites -= 2;
+		/* FIPS does not permit the use of RC4 */
+		if (fips_enabled) {
+			local->hw.wiphy->cipher_suites += 3;
+			local->hw.wiphy->n_cipher_suites -= 3;
 		}
-
-		/* not dynamically allocated, so just return */
-		return 0;
 	}
 
-	local->hw.wiphy->cipher_suites = suites;
-	local->hw.wiphy->n_cipher_suites = w;
-	local->wiphy_ciphers_allocated = true;
-
 	return 0;
 }
 
@@ -1651,10 +1625,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	ieee80211_led_exit(local);
 	destroy_workqueue(local->workqueue);
  fail_workqueue:
-	if (local->wiphy_ciphers_allocated) {
-		kfree(local->hw.wiphy->cipher_suites);
-		local->wiphy_ciphers_allocated = false;
-	}
 	kfree(local->int_scan_req);
 	return result;
 }
@@ -1725,11 +1695,6 @@ void ieee80211_free_hw(struct ieee80211_hw *hw)
 
 	mutex_destroy(&local->iflist_mtx);
 
-	if (local->wiphy_ciphers_allocated) {
-		kfree(local->hw.wiphy->cipher_suites);
-		local->wiphy_ciphers_allocated = false;
-	}
-
 	idr_for_each(&local->ack_status_frames,
 		     ieee80211_free_ack_frame, NULL);
 	idr_destroy(&local->ack_status_frames);
-- 
2.34.1


