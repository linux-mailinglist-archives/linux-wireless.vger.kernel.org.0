Return-Path: <linux-wireless+bounces-1021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05948190B6
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F44A1C24C23
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62D838FAA;
	Tue, 19 Dec 2023 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fjfnlnf3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B037D3B
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703014144; x=1734550144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cmNcMPwLJ9Tv2Ejg2JgR3rVq92AD56HyI4B1TvrJ0NA=;
  b=Fjfnlnf3XrWSd0K53CWX6+Sqxk1yCMbtmVN1q0tgVfnm2Kgo4mZOvwCc
   SbImxNjy7cjObUqay0BYo9m/B6F3xh7uwvdxalRddZdHhqOm4N49okTMg
   CfXCuzl+aPaXPdGtXZeSpJgGwk2NojFPzMKI37Tvh8VpWsLgmFkeOOL3T
   oC2RlQ2tyDM5PSPXXYYjIJqrAuG9z8JPntDjysy8BCThSrgsdGoVEhXwX
   Hld2JJZGh7gLR9SepebKSI5mJ3rP3IDaHbhdS8fc99Qy6hXc7/rvYg/hi
   5YUIV9aiB2uzF/ogELR6lTqJ0xTL70LLcvayzxW/oS1OQel8sOwvdiBmP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460054319"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="460054319"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:29:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="899478202"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="899478202"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:29:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/14] wifi: iwlwifi: mvm: Allow DFS concurrent operation
Date: Wed, 20 Dec 2023 15:29:19 +0200
Message-Id: <20231220152651.dc39b33bf507.I04dfda24d73091fb75701279d10ac400314de488@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220132931.3314293-1-miriam.rachel.korenblit@intel.com>
References: <20231220132931.3314293-1-miriam.rachel.korenblit@intel.com>
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


