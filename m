Return-Path: <linux-wireless+bounces-4852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B712687EE12
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8511F23EB1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D4F55C06;
	Mon, 18 Mar 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCRjXvVh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C7355C0E
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780845; cv=none; b=Z9JzrqYOkIz3NsRXm505tijopEA6zVPXaMNn6jK/rWjNcItdziZjb+v8OsGYxuydISNH4KsrIHLms78/RK/DLAtmrsrGUY8E7BsvqO8xsozhhu52iR3OEPjglWPTqMZd1N6K2AL2vAt3gBn4go1fg9QDafnm46ybOe4XPZuzYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780845; c=relaxed/simple;
	bh=8bxRgKWQCw7G1LGrnS70T9/FjAGC/eSYiARXWPDFYQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTmJv62zS7eGzDNK5AXFmnfRZjIv8+jfhyfzcCxG6cpQy6jPr4P0UZ+ycFaehxfMhD681izCXc4lD8AhuprtHe/CB0rZdcbn8wROAJyI2WeDN+ZHyeUSkDE8z6gLsikVwTpP7mZFMo+yZSmFVSp1nnmUTgmQN8UcEVtRxbQUM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCRjXvVh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780844; x=1742316844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bxRgKWQCw7G1LGrnS70T9/FjAGC/eSYiARXWPDFYQ0=;
  b=lCRjXvVhnBxj2JSA8WC6iFpKmUyh8HKSRPfOMrTV0idSWvNx16AGOgO1
   TENGWi6UF3zOqmrlA67Y7D32KCiTmJHo0TZxa/VedC4CmbYDURUl+GTti
   0Bk9WGYe76GSTP/nUnd3scRt7dPdbTVbJuwQG3U0ZJtKUy+uV35XyoKF1
   hhOz0woGJviAzNtLB8VckM5Dr1lna2zvdGm3EJrgVt3/yB8df9f49rapX
   RYaTvf5wSQ7bMNEqkrFi+B7paQ6R7laeEppNeznPN1aWrjmghR4SynISA
   CyOz9c9NcJgvPzm+GsoAyfz0iwod1SLi+Yy1EPYQzJZq/mXhGNMD0QIyf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819428"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819428"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909877"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/15] wifi: mac80211: add flag to disallow puncturing in 5 GHz
Date: Mon, 18 Mar 2024 18:53:25 +0200
Message-Id: <20240318184907.49759510da7d.I12c5a61f0be512e0c4e574c2f794ef4b37ecaf6b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
References: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Some devices may not be capable of handling puncturing in 5 GHz
only (vs. the current flag that just removes puncturing support
completely). Add a flag to support such devices: check and then
downgrade the channel width if needed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h | 3 +++
 net/mac80211/debugfs.c | 1 +
 net/mac80211/mlme.c    | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 757ec33882c2..88bb781f33f6 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2779,6 +2779,8 @@ struct ieee80211_txq {
  *
  * @IEEE80211_HW_DISALLOW_PUNCTURING: HW requires disabling puncturing in EHT
  *	and connecting with a lower bandwidth instead
+ * @IEEE80211_HW_DISALLOW_PUNCTURING_5GHZ: HW requires disabling puncturing in
+ *	EHT in 5 GHz and connecting with a lower bandwidth instead
  *
  * @IEEE80211_HW_HANDLES_QUIET_CSA: HW/driver handles quieting for CSA, so
  *	no need to stop queues. This really should be set by a driver that
@@ -2843,6 +2845,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_DETECTS_COLOR_COLLISION,
 	IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX,
 	IEEE80211_HW_DISALLOW_PUNCTURING,
+	IEEE80211_HW_DISALLOW_PUNCTURING_5GHZ,
 	IEEE80211_HW_HANDLES_QUIET_CSA,
 
 	/* keep last, obviously */
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 2f68e92a7404..98310188f330 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -498,6 +498,7 @@ static const char *hw_flag_names[] = {
 	FLAG(DETECTS_COLOR_COLLISION),
 	FLAG(MLO_MCAST_MULTI_LINK_TX),
 	FLAG(DISALLOW_PUNCTURING),
+	FLAG(DISALLOW_PUNCTURING_5GHZ),
 	FLAG(HANDLES_QUIET_CSA),
 #undef FLAG
 };
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a0f9fdc8b0d3..958ff328a6c1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -599,6 +599,10 @@ static bool ieee80211_chandef_usable(struct ieee80211_sub_if_data *sdata,
 	    ieee80211_hw_check(&sdata->local->hw, DISALLOW_PUNCTURING))
 		return false;
 
+	if (chandef->punctured && chandef->chan->band == NL80211_BAND_5GHZ &&
+	    ieee80211_hw_check(&sdata->local->hw, DISALLOW_PUNCTURING_5GHZ))
+		return false;
+
 	return true;
 }
 
-- 
2.34.1


