Return-Path: <linux-wireless+bounces-14590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61089B2F5D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 12:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AC0282279
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 11:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285571D61A4;
	Mon, 28 Oct 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3EG1R8B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9C1D86DC
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116522; cv=none; b=usGIGHBfWv6BK21vRiDeT9WFazUDFx6y1YG4PeDkQh8repXNqsKugClwhicLWGl9q1K8cLOm2b5hUJ+2iTNy09I7NLhl7+/Tv7JTIMH3usg80RHndFKid7Fa8/tBzfd43qECf8ScKwpqzJU6Wv5o6Np+3KLRoUIdrUYeFRRsaEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116522; c=relaxed/simple;
	bh=0Boe/NZNdkuGDl/ROM4CzySbDcET+BNsrim4wTaIOiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/y9cF0PeJMkREb/tOm9WCk5gs/r6e7s5n4GCo2neR2OJtYNW0jKheCLTJCbVvqP6VEQCUUtqqhbWf/8MuGnXo+HdO3EJ/19h1x1m3YsLkCAI2oNy8E54oJQxal9Bb1CBFaq4TmcV8nOulQB3FwMvRQUsCsZP6b8TcyyWkw3RrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3EG1R8B; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730116520; x=1761652520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Boe/NZNdkuGDl/ROM4CzySbDcET+BNsrim4wTaIOiw=;
  b=V3EG1R8B7TFqRYUWcqf+bQd99gpWYWWl6iWrHjhdvM7NBVWhNObeYkEf
   WX/9HBypp4x8pKekBIkgZuNZVJkaSwk9obQgch89+uk8894nbX8rOazIz
   9REVUubZsT94cW297/Ut2zfj9pshj+hXY6wB2c6yosDky6ScJ4FuEe0/O
   hBFFjhsf6HF4LsYsLibiYVr4CfrdGmlHGbTg8iBOwbdnAlYcJKXDOf9Tx
   IwXwGSmVYa+m0UHt6naWvwqw2pvu8CQeOIwlln2bW6kRp7toUZk+CllFc
   G4YgcJm/Mci6PLCVTDE+o5AZjFW3GaMifUPZp2Vo8/59ACfJMmE+PH0dl
   A==;
X-CSE-ConnectionGUID: vt9OfUl8TUmfRWslZBZbfA==
X-CSE-MsgGUID: DRv1cDtbRFOeceN7wyQZQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29813869"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29813869"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:18 -0700
X-CSE-ConnectionGUID: 6XhuOPg6Rt2LePfNrPIXxQ==
X-CSE-MsgGUID: BdGWiOS7SkGQc++rWqQ7kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112432561"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:55:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: mvm: clarify fw_id_to_link_sta protection
Date: Mon, 28 Oct 2024 13:54:46 +0200
Message-Id: <20241028135215.a6c6aa4147cf.If7f1b30a7b92ce5e9226e8972201a20aa9905108@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
References: <20241028115500.351123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is written only with wiphy and mvm mutexes held, but in
order to actually rely on that document it and add lockdep
assertions to ensure it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c       |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 11 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  1 +
 4 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 08546e673cf5..1b62bb92ee93 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1403,6 +1403,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	int ret, i;
 	struct ieee80211_supported_band *sband = NULL;
 
+	lockdep_assert_wiphy(mvm->hw->wiphy);
 	lockdep_assert_held(&mvm->mutex);
 
 	ret = iwl_trans_start_hw(mvm->trans);
@@ -1622,6 +1623,7 @@ int iwl_mvm_load_d3_fw(struct iwl_mvm *mvm)
 {
 	int ret, i;
 
+	lockdep_assert_wiphy(mvm->hw->wiphy);
 	lockdep_assert_held(&mvm->mutex);
 
 	ret = iwl_trans_start_hw(mvm->trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4db7c3ee6bf5..7c6051990569 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3516,6 +3516,8 @@ void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	unsigned int link_id;
 
+	lockdep_assert_wiphy(mvm->hw->wiphy);
+
 	/*
 	 * This is called before mac80211 does RCU synchronisation,
 	 * so here we already invalidate our internal RCU-protected
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 99eb1e1db1bb..1a096f1b1870 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -521,6 +521,9 @@ void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
 			       unsigned int link_id,
 			       bool is_in_fw)
 {
+	lockdep_assert_wiphy(mvm->hw->wiphy);
+	lockdep_assert_held(&mvm->mutex);
+
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id],
 			 is_in_fw ? ERR_PTR(-EINVAL) : NULL);
 	RCU_INIT_POINTER(mvm->fw_id_to_link_sta[mvm_sta_link->sta_id], NULL);
@@ -559,6 +562,9 @@ static int iwl_mvm_mld_alloc_sta_link(struct iwl_mvm *mvm,
 	u32 sta_id = iwl_mvm_find_free_sta_id(mvm,
 					  ieee80211_vif_type_p2p(vif));
 
+	lockdep_assert_wiphy(mvm->hw->wiphy);
+	lockdep_assert_held(&mvm->mutex);
+
 	if (sta_id == IWL_MVM_INVALID_STA)
 		return -ENOSPC;
 
@@ -631,6 +637,9 @@ static int iwl_mvm_alloc_sta_after_restart(struct iwl_mvm *mvm,
 	int ret = -EINVAL;
 	int sta_id;
 
+	lockdep_assert_wiphy(mvm->hw->wiphy);
+	lockdep_assert_held(&mvm->mutex);
+
 	/* First add an empty station since allocating a queue requires
 	 * a valid station. Since we need a link_id to allocate a station,
 	 * pick up the first valid one.
@@ -858,6 +867,7 @@ int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, u8 sta_id)
 {
 	int ret;
 
+	lockdep_assert_wiphy(mvm->hw->wiphy);
 	lockdep_assert_held(&mvm->mutex);
 
 	if (WARN_ON(sta_id == IWL_MVM_INVALID_STA))
@@ -1064,6 +1074,7 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 	unsigned int link_id;
 	int ret;
 
+	lockdep_assert_wiphy(mvm->hw->wiphy);
 	lockdep_assert_held(&mvm->mutex);
 
 	for_each_set_bit(link_id, &old_links_long,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 5aa48c77b054..5d85661e01f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1082,6 +1082,7 @@ struct iwl_mvm {
 	/* data related to data path */
 	struct iwl_rx_phy_info last_phy_info;
 	struct ieee80211_sta __rcu *fw_id_to_mac_id[IWL_STATION_COUNT_MAX];
+	/* note: fw_id_to_link_sta must be protected by wiphy and mvm mutexes */
 	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_STATION_COUNT_MAX];
 	u8 rx_ba_sessions;
 
-- 
2.34.1


