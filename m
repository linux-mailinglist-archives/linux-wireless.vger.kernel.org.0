Return-Path: <linux-wireless+bounces-1028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A73981911A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B251F250B6
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEBD39AC4;
	Tue, 19 Dec 2023 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RalUefHX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CB39AC1
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015964; x=1734551964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cmNcMPwLJ9Tv2Ejg2JgR3rVq92AD56HyI4B1TvrJ0NA=;
  b=RalUefHXOvQaC/frdvr2pMagJkHwHckCLMSdPXn0pwCRdd7BDO0XGZjG
   1d03vMW1spcRua5N0BLPvhAKaQeJ39AvHh+POOcfNZ+nJNbxvjYlLDrsy
   vGogvdGEOsFC8unWeuokPcc78Wlv9UT+p9QEcRIp7KIEa/FykA9hrjrIn
   soH386uVVp68EsWnydca9othhYIV0k+9VYa/FiQE+Mi6BZvJB4a9hmyB4
   9GSGDbM0Zhyvb9X72WG9F4uP6X6wm0xwl/wIWw23mEUzTb1XETRmi6UpQ
   N7OSODlxou7YFnPTPcEDeJT8G0HHnZir2Xm+DQVkYA2NIC+DQOaQNlwFc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694933"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694933"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589085"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589085"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/14] wifi: iwlwifi: mvm: Allow DFS concurrent operation
Date: Tue, 19 Dec 2023 21:58:50 +0200
Message-Id: <20231219215605.dc39b33bf507.I04dfda24d73091fb75701279d10ac400314de488@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
References: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

AX210 devices allow concurrent P2P operation on DFS channels.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 10 ++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 480f8edbfd35..1bccbbe9a5ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1609,10 +1609,12 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 	/* Set the GO concurrent flag only in case that NO_IR is set.
 	 * Otherwise it is meaningless
 	 */
-	if ((nvm_flags & NVM_CHANNEL_GO_CONCURRENT) &&
-	    (flags & NL80211_RRF_NO_IR))
-		flags |= NL80211_RRF_GO_CONCURRENT;
-
+	if ((nvm_flags & NVM_CHANNEL_GO_CONCURRENT)) {
+		if (flags & NL80211_RRF_NO_IR)
+			flags |= NL80211_RRF_GO_CONCURRENT;
+		if (flags & NL80211_RRF_DFS)
+			flags |= NL80211_RRF_DFS_CONCURRENT;
+	}
 	/*
 	 * reg_capa is per regulatory domain so apply it for every channel
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a64600f0ed9f..06de4dc2a915 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -517,6 +517,10 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->regulatory_flags |= REGULATORY_CUSTOM_REG |
 					       REGULATORY_DISABLE_BEACON_HINTS;
 
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_DFS_CONCURRENT);
+
 	hw->wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
 	hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	hw->wiphy->flags |= WIPHY_FLAG_SPLIT_SCAN_6GHZ;
-- 
2.34.1


