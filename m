Return-Path: <linux-wireless+bounces-25208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC23B00B5E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA6D3A9C04
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129592F4A0C;
	Thu, 10 Jul 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LngH5kUr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0CB2FCE13
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172141; cv=none; b=A/OLrYb/uz8tStKry4xY5Mjt2RM8BjNL+IDmrREKHyPk68dOYuPbD+U2huU5hfhis9AYTfRS32YZBH3srPtis15fNCyInL2eoiYYg1xfhxyBEiHIeFkWxbod27XGT1nRvnWQ92e15Frfw/EoVnxCrqPS48xp0wEn2V5d18SJkTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172141; c=relaxed/simple;
	bh=BUtryMZ0Y09LRFSC5n0c2KI1cmX1ZGxae2aQCr22JRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+orty0r2+UkhGkQj0xMszhN7Xb/Ai0YytwLm6YHFWCct3ZlDKfaT0xPcExBjWKB8y1hDvszEri+0Mv9hrwrxtJOxvnEpZQq6LgqdhysBEu9V1EpRvTkq3DWdkliujsOAcx6VKVhHhlnWwKUIftHSgCFcsmLUZupZM8yWSbgSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LngH5kUr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172140; x=1783708140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BUtryMZ0Y09LRFSC5n0c2KI1cmX1ZGxae2aQCr22JRk=;
  b=LngH5kUrJ94YhJgH2tZ+dKVOZU41PAmpULEikWJu4m5o4nhfCfXNOpkq
   dyXXsJo43y5KI+q1NuDWELwzwpoW93VI6Ai7H4TO70yZX3COGAHPNSYF8
   mnF8dBjHUKYVzWLGzTqRWzkQgbJFYbePaelYiCeMUp6i7E6Lmi8uC1PzS
   zMt5yvA/aIrJ7XKIa1VThf4W6970rXj5uD4lAGYXnKEL4XpbwfM3UB2bc
   gCyG1TpQoE2SgiZ9zlz1FLKp9zT1u06ELxiH75DwYmhli19efpx0+tqtc
   BoQ9ngyi+DOfwuLi8bYVvo8vEcc/CZ9XCiGZJD++TA6rg3OGkxI9sPM8Q
   Q==;
X-CSE-ConnectionGUID: J/Dj4KKGQNSMY5z/3f+WEw==
X-CSE-MsgGUID: LDmrAbUDRGucPe38Nz802Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077792"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077792"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:59 -0700
X-CSE-ConnectionGUID: y0jXqtl9Rs600pnNhCZxNw==
X-CSE-MsgGUID: sSTdJqSrRcuV09EiJxyaUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718680"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mvm: remove regulatory puncturing setup
Date: Thu, 10 Jul 2025 21:28:21 +0300
Message-Id: <20250710212632.b2a28a99725b.I72ba276cb705c02cea8f68e27ef3935d5120cfee@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We don't have puncturing before EHT, and EHT devices aren't
supported in iwlmvm, so remove the regulatory puncturing
setup code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 ------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b28c21c20371..c16946950a8a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -165,12 +165,6 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 	mvm->lar_regdom_set = true;
 	mvm->mcc_src = src_id;
 
-	if (!iwl_puncturing_is_allowed_in_bios(mvm->bios_enable_puncturing,
-					       le16_to_cpu(resp->mcc)))
-		ieee80211_hw_set(mvm->hw, DISALLOW_PUNCTURING);
-	else
-		__clear_bit(IEEE80211_HW_DISALLOW_PUNCTURING, mvm->hw->flags);
-
 	iwl_mei_set_country_code(__le16_to_cpu(resp->mcc));
 
 out:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f0d459766365..cf6177b43262 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1372,7 +1372,6 @@ struct iwl_mvm {
 	struct iwl_mvm_acs_survey *acs_survey;
 
 	bool statistics_clear;
-	u32 bios_enable_puncturing;
 };
 
 /* Extract MVM priv from op_mode and _hw */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 1c05a3d8e424..7dfae8b1a43e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1397,8 +1397,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 		}
 	}
 
-	mvm->bios_enable_puncturing = iwl_uefi_get_puncturing(&mvm->fwrt);
-
 	if (iwl_mvm_has_new_tx_api(mvm)) {
 		/*
 		 * If we have the new TX/queue allocation API initialize them
-- 
2.34.1


