Return-Path: <linux-wireless+bounces-3232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F8284BA82
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6361A1F204E1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84F3134CDB;
	Tue,  6 Feb 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuzAOR0k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2820134CCA
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235349; cv=none; b=qr05tbM/37ctoVbPN1R/8neNlJAw7hke/m4Z0eluNKseMqPtd2QUn1dIjJ1cQUFFkqsV2MhO0HjuF74PxxlxhgmfUpY0FwJ54/rXYoxcyitnB+u2HK74nP4+MoXTl48DlebRl2tpIoq6r12x0TKMj+YZg0b4/kuTnwmQi8OFErw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235349; c=relaxed/simple;
	bh=51SYq2MvJm4vF/IP5v45nLVuSp8Xr3h/jNpxkUvZ12Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wxaf5HywpESRN5WW3tuP4sPAENR27IB0taFmJ4ouDSDzV073hAi61N9NqaEcX+BH2drWR4hydy+rEnzZaWaKUEucIcUKVo2B6Ubn5txvH2EDfqWLsukHd+bulURsfGpK/CuaVMkyamsy11w/p4DNb6jItf1IkmC4vN/QoIaR7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuzAOR0k; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235348; x=1738771348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=51SYq2MvJm4vF/IP5v45nLVuSp8Xr3h/jNpxkUvZ12Q=;
  b=GuzAOR0kUFE++VOcj4u9Dp5x0mtDWhH1nUkxQoCpnCZUmMSjim6gW2tA
   Knaqb9y63xEHXiW5H6k/08ByQW3y3rU7bQEXW4PYRLnCiZAQL7O1tE0S/
   Jd233RzB5idFBiBhDcs7tXPkyeWIzxLtiIpiKmVqGSgUAKrEIDmcce/0a
   VZlsh03tiFc/eC5Tg2Pu2aRgKcrhYUhpYXsKdhyBCUL4LyqSY493AFkiX
   8KbvNE165UnMMZkUh6rAurB5Zkz39A2cHh3tjNriJVIEoPVU8G933d8/n
   bHDdO83pNtwytuLc2jaBcVwFZ4g3i27OAD/KFcgosAi7nWMIM58Lo5ObV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252302"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252302"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349804"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 01/11] wifi: iwlwifi: mvm: fix a crash when we run out of stations
Date: Tue,  6 Feb 2024 18:02:04 +0200
Message-Id: <20240206175739.1f76c44b2486.I6a00955e2842f15f0a089db2f834adb9d10fbe35@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
References: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

A DoS tool that injects loads of authentication frames made our AP
crash. The iwl_mvm_is_dup() function couldn't find the per-queue
dup_data which was not allocated.

The root cause for that is that we ran out of stations in the firmware
and we didn't really add the station to the firmware, yet we didn't
return an error to mac80211.
Mac80211 was thinking that we have the station and because of that,
sta_info::uploaded was set to 1. This allowed
ieee80211_find_sta_by_ifaddr() to return a valid station object, but
that ieee80211_sta didn't have any iwl_mvm_sta object initialized and
that caused the crash mentioned earlier when we got Rx on that station.

Fixes: 57974a55d995 ("wifi: iwlwifi: mvm: refactor iwl_mvm_mac_sta_state_common()")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9c8eea883212..4fe50036bfde 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3697,6 +3697,9 @@ iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
 					   NL80211_TDLS_SETUP);
 	}
 
+	if (ret)
+		return ret;
+
 	for_each_sta_active_link(vif, sta, link_sta, i)
 		link_sta->agg.max_rc_amsdu_len = 1;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index b7639e429889..1484eaedf452 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -512,6 +512,10 @@ static bool iwl_mvm_is_dup(struct ieee80211_sta *sta, int queue,
 		return false;
 
 	mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+
+	if (WARN_ON_ONCE(!mvm_sta->dup_data))
+		return false;
+
 	dup_data = &mvm_sta->dup_data[queue];
 
 	/*
-- 
2.34.1


