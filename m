Return-Path: <linux-wireless+bounces-22783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E7AB110A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EF91C25BE8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A3128FFF1;
	Fri,  9 May 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIF5aVSd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F85C28F53F
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787528; cv=none; b=jrBwrQxANYoFhko0JqU3w7fdwzJRbaCJSvFd/4wtysTzLouxSTZNg4QyPvWdJitZRqIFIGlMowCg3l3JHqSGuWNzIDjXqsdOYG7e8vuXDuv4OiYHwVoR+SsUJhICn00QYhyRFacg/+DVKMwWb+d6Df2tKBb9en20ncXiQVaOm20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787528; c=relaxed/simple;
	bh=Ai6pzHqEjJBCOCCuvkPX66rya5f6r7/RihprIw+FPrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JGJHEjslSTJFnqWzLV/rErQgTpPnKxc+JpRgWRozYi9rhJxznKMoYj9ip+j4ELzpxSvzm/556VdgKSUU42B3nW2mkWcaTBdXbQ5vH7YKDPmCuUS0sV8i7G9EU2Hyq5dMpBD3s0YfDDniTnBEtPMtIzGDYzYgG73vQtV/gzNTpZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIF5aVSd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787527; x=1778323527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ai6pzHqEjJBCOCCuvkPX66rya5f6r7/RihprIw+FPrc=;
  b=aIF5aVSdWb7zIhjrCHHBbMDMUTWJgKnfYfDSSuGFheiBr6UhknM44mfw
   8WAXJ7fYkZRXbeC/Hcyi7reEDj+sWBe30lP7J/sTskSSBAx9ITOvH4Bsj
   TU4p4ELakI+Dp+TYDBkTWgAKwC27M4RG5mwrb/w/tXG8YVUrrje8pYqjf
   bpe9z37FGw1iVXlWrcn/Gul4X+K2Q+VRNM/2r9AGivATydm2FMCIlsNHZ
   ERxqdfPG0x5Tcnv0fY1+ojo6psIB3I6NyvK8OYLPfQB9ZhGsqzxqVkygm
   jU6QfN3UQsJNXmq+5iu1tjZ3oggvuPdxgu28WyLQZdwe9A4tEUprKryY2
   A==;
X-CSE-ConnectionGUID: IxBvN3aKTDiapT+HNMJa/Q==
X-CSE-MsgGUID: regiKrEwT/Wz3Hqxdhd+wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239908"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239908"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:27 -0700
X-CSE-ConnectionGUID: LllQUXXYQEqI6EaX+pHFfA==
X-CSE-MsgGUID: 4M0NkLO6QvqSaHfBYPaipg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537058"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mvm/mld: allow puncturing use in 5 GHz
Date: Fri,  9 May 2025 13:44:53 +0300
Message-Id: <20250509104454.2582160-15-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
References: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It was decided this was supported after all, so remove
the restriction.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250509134302.a19d92ef7351.I4f1f1383a894f3035623274b310b12c916da3f09@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 8677dbd2b4b6..92ea8f896478 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -243,7 +243,6 @@ static void iwl_mac_hw_set_flags(struct iwl_mld *mld)
 	ieee80211_hw_set(hw, TX_AMPDU_SETUP_IN_HW);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
-	ieee80211_hw_set(hw, DISALLOW_PUNCTURING_5GHZ);
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, TDLS_WIDER_BW);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 37a24f561770..0f056a6641bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -731,8 +731,6 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 	mvm->rts_threshold = IEEE80211_MAX_RTS_THRESHOLD;
 
-	ieee80211_hw_set(hw, DISALLOW_PUNCTURING_5GHZ);
-
 #ifdef CONFIG_PM_SLEEP
 	if ((unified || mvm->fw->img[IWL_UCODE_WOWLAN].num_sec) &&
 	    device_can_wakeup(mvm->trans->dev)) {
-- 
2.34.1


