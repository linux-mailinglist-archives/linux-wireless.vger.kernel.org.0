Return-Path: <linux-wireless+bounces-25712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF1BB0BC6A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 08:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2C6168D58
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 06:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBCF26E6EF;
	Mon, 21 Jul 2025 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etucoa/c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69AE1E835B
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078828; cv=none; b=soYOvMulr/Ep8VUjBfbouxNo4aQ/z7haos0Jzs0CkAsdEJ0PNI+iprFfhKiCnoxSJRusOpXTjy7IFFJc/7qOOtxvMh6bO2w6/YwFxHejBBoE/sC0bbpx7e/dsRCoNMS4nY6hEi8VXd7l426d3sWGulr+gO3SejKo4YNQ6LLES8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078828; c=relaxed/simple;
	bh=yLoqXUoZj1Br42q6WT7pPMlEnxOD9BGVe1iCRJWbtJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5UGzr73HuPoFNf4qvdp5dox0o7nz41bWMR0EROQIlBOPP75ss3uKbKmzXGCAvhUolETdPA/n/8JBOXgXJEfoLg6Fq/iTjLwluGrihrgwi1k9XqF9mNYnGDDDa0YvH7INuMa2TfYPo5eWURBuSl+MlyFRtHGj6J9+kyyZG8wSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etucoa/c; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753078827; x=1784614827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yLoqXUoZj1Br42q6WT7pPMlEnxOD9BGVe1iCRJWbtJo=;
  b=etucoa/c8IZohpjrjtFC08ClKYjlTlbhgjxuAQ0es0OluQQkSADU/DHn
   DgAr1F41ejxwynwCznOnCOQuHx0G3FIxzM54PXgsA5BWXnQBfVIhuaDda
   g9nd+OT+PDdafE6Sagvviq/pPbKSt+vQeOVxwIlczc5UEhs5MOLSOAXuo
   FxuxWhIvas31v/KO64CpDpIfORiAWGyHHFZYgMJSlnzLir1oN17OteZM3
   nKyrsHNsVvxmKMrFpCLIM1W/FfmFz/ZcnejZ3OAO2eWxyjtrUg+3gL1as
   cj8+HmYFKhkj6HyGYzGZuhZMnrJC3CoUVVqXIyYi/wRtNMlXS8h4zczJf
   Q==;
X-CSE-ConnectionGUID: Bt1R+ZvVT0uqef1p9LSm2Q==
X-CSE-MsgGUID: BV1iNWY0SJ6dD3o+DHHqdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="54996149"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="54996149"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 23:20:26 -0700
X-CSE-ConnectionGUID: hlxW5/DGSMWHV8ZtNWAONA==
X-CSE-MsgGUID: L0VgE5WVTcOea27uv1pgtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="189697833"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2025 23:20:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: remove ieee80211_remove_key
Date: Mon, 21 Jul 2025 09:20:03 +0300
Message-Id: <20250721091956.e964ceacd85c.Idecab8ef161fa58e000b3969bc936399284b79f0@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

It is no longer used, remove it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h | 16 +---------------
 net/mac80211/key.c     | 27 +--------------------------
 2 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a2dbaad2f6d3..a0cf976a9117 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6032,18 +6032,6 @@ void ieee80211_get_key_rx_seq(struct ieee80211_key_conf *keyconf,
 void ieee80211_set_key_rx_seq(struct ieee80211_key_conf *keyconf,
 			      int tid, struct ieee80211_key_seq *seq);
 
-/**
- * ieee80211_remove_key - remove the given key
- * @keyconf: the parameter passed with the set key
- *
- * Context: Must be called with the wiphy mutex held.
- *
- * Remove the given key. If the key was uploaded to the hardware at the
- * time this function is called, it is not deleted in the hardware but
- * instead assumed to have been removed already.
- */
-void ieee80211_remove_key(struct ieee80211_key_conf *keyconf);
-
 /**
  * ieee80211_gtk_rekey_add - add a GTK key from rekeying during WoWLAN
  * @vif: the virtual interface to add the key on
@@ -6070,9 +6058,7 @@ void ieee80211_remove_key(struct ieee80211_key_conf *keyconf);
  * for the new key for each TID to set up sequence counters properly.
  *
  * IMPORTANT: If this replaces a key that is present in the hardware,
- * then it will attempt to remove it during this call. In many cases
- * this isn't what you want, so call ieee80211_remove_key() first for
- * the key that's being replaced.
+ * then it will attempt to remove it during this call.
  */
 struct ieee80211_key_conf *
 ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 997892da8886..9d65013ddac7 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2008	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright 2018-2020, 2022-2024  Intel Corporation
+ * Copyright 2018-2020, 2022-2025  Intel Corporation
  */
 
 #include <crypto/utils.h>
@@ -1354,31 +1354,6 @@ void ieee80211_set_key_rx_seq(struct ieee80211_key_conf *keyconf,
 }
 EXPORT_SYMBOL_GPL(ieee80211_set_key_rx_seq);
 
-void ieee80211_remove_key(struct ieee80211_key_conf *keyconf)
-{
-	struct ieee80211_key *key;
-
-	key = container_of(keyconf, struct ieee80211_key, conf);
-
-	lockdep_assert_wiphy(key->local->hw.wiphy);
-
-	/*
-	 * if key was uploaded, we assume the driver will/has remove(d)
-	 * it, so adjust bookkeeping accordingly
-	 */
-	if (key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) {
-		key->flags &= ~KEY_FLAG_UPLOADED_TO_HARDWARE;
-
-		if (!(key->conf.flags & (IEEE80211_KEY_FLAG_GENERATE_MMIC |
-					 IEEE80211_KEY_FLAG_PUT_MIC_SPACE |
-					 IEEE80211_KEY_FLAG_RESERVE_TAILROOM)))
-			increment_tailroom_need_count(key->sdata);
-	}
-
-	ieee80211_key_free(key, false);
-}
-EXPORT_SYMBOL_GPL(ieee80211_remove_key);
-
 struct ieee80211_key_conf *
 ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
 			struct ieee80211_key_conf *keyconf,
-- 
2.34.1


