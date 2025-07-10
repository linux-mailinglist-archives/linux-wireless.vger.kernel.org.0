Return-Path: <linux-wireless+bounces-25191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12262B00954
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92823B62FC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760C2EFDB6;
	Thu, 10 Jul 2025 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuM/52Dj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F202F0C6C
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166516; cv=none; b=A88mBk2yWArMy4VXnNvsNWAvhlHghg7jGKSgGxzC2c2TE23RZKMmnDnCh4loRVeuRpQTM2pVRlJtyFvJNkP2HU+Ncz6zqKrKcqhG2i3Fxw7g2fBF3/5Ufbj0B8Cr4rzlfLSRyb9CMRK5s67Sf+mfJXhaitgICvN4ZjWZkEFxh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166516; c=relaxed/simple;
	bh=BUtryMZ0Y09LRFSC5n0c2KI1cmX1ZGxae2aQCr22JRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iXunZml++m1yRhG5XTOr1F0bbNaotopDSFW3XP9CqM9BIf7KXvOhxOZGPjW8XTpiFxiFDz8nELSTUcGhbLvrtfQMrCjFDcpSnHq9Q5jVFvFcK1RVYVBTKnwUmYoOgtmlkxHzeYWX44LVoDY7ASsaOeOqX33NKJO8pq0o+aaYWP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuM/52Dj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166514; x=1783702514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BUtryMZ0Y09LRFSC5n0c2KI1cmX1ZGxae2aQCr22JRk=;
  b=iuM/52DjBEumh3U8tg8PhkhGLmeYE/wf3Kk0riqQtgIPHIcfhbgj8VF6
   4ASBeStN1c4ZuiGojI00Hoiq+hQacTreckLS0tTZ7cJZqR2Ozb/4AYrU9
   hv0PPkolSnrNiQ61MrtNEi0vo6lrUWGJeR2ya8rt0IEDlfyJ6SIWB7GDe
   HO7AteaZVpAsPZThlwIAILVJxLdfT8p4gqvYgFDEsZGJR01OtXRYsZ+ML
   +peWMF/OtVJRrmQLP7zOUCsCkWNixyz2MniyBR5HKRSWjoVcIifWGEW7Q
   N6IsAfKzyYmRGHU22MC2Y4TxcXPWMtMFEMMGzWRUnpy+JpG8npX6qLloT
   g==;
X-CSE-ConnectionGUID: fQ9sGKQ5QU6fWJL7C54bbw==
X-CSE-MsgGUID: OY6qQaAnQ52nuUjjM3o/yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54609993"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54609993"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:14 -0700
X-CSE-ConnectionGUID: s7cWoAKzQZKJIXJeGNOnHA==
X-CSE-MsgGUID: l4n20D5MTLq6OlQnycNPvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277009"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 04/15] wifi: iwlwifi: mvm: remove regulatory puncturing setup
Date: Thu, 10 Jul 2025 19:54:37 +0300
Message-Id: <20250710195219.b2a28a99725b.I72ba276cb705c02cea8f68e27ef3935d5120cfee@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
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


