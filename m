Return-Path: <linux-wireless+bounces-3106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F78490FA
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 431FCB22283
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9517336AF9;
	Sun,  4 Feb 2024 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6wCCZXJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842F33CD4
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084403; cv=none; b=BMylR/570JqmGIZdlflbVj9Yj4uUH1YczphdZ9QkP/nltLkb2TfJbQ0PECr2eq5dQSUAxC3yckGN4MnLZOit/tH+aIk/w3k8hLoBppjK5fI8i/E2w0qMg7ZdWdM/G8U1ZmLTk4RS9D1CKFaE8Z3vBzL/0DFVXHZxcfhiCJXstIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084403; c=relaxed/simple;
	bh=AxpxeiORYvqCxwiOQbWfTUZgLlebTjiAr3czY5IUvj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRba9CI/aVbiQllNHw2rtOgxokJbr+hONF/fyGTpxi7VgU0xU59sDmG2iNsJC6+8CEj2FFqur6+z/2cEbVLGAOkAOcnB1SP916ZKRUQGy4xyXp9M1JU6aUq8Gj4N7ykxHyskw0AmSGMOfBM/Oq2fLfLQrpJLe/owRoi9gVZY26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6wCCZXJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084402; x=1738620402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AxpxeiORYvqCxwiOQbWfTUZgLlebTjiAr3czY5IUvj8=;
  b=c6wCCZXJzjTGl3WXjwHKiZvc82LscAwrQRoU1xoYJ3/2YZuntosRMRgP
   DCtoYJV5rEMgHYiafUlBt/Cm17BtnaWdvDutFtaWtfvGjp3Weq94MXB26
   VMOczgZ9BYSZWCKvTquxBQQjdQfSvceqgqCra6mbOJlf+V5rgWxx2CE95
   kAso+ZqBXmekvTg4aiTB3vmuT/1Vr61AnW4qsxmAOzEubTmp2GnCkQhyJ
   cRPutZjWpW3yBvzFyqdYousUfwLt7ZS7y6D6f3Hg46QWiXoGoqn9THvEN
   wEhqDpamoe+BUNkK1k2sXSHeFgDn+kkMuc8KuZC5yvujIv9z5ZbuO6gAm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869372"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869372"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815869"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: const-ify chandef pointers
Date: Mon,  5 Feb 2024 00:06:07 +0200
Message-Id: <20240204235836.e7fbd3e26d85.I72d72e61dc5f5fc76c53e32cb60b66237eaedec3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In much of the PHY context handling code the chandef
coming from mac80211 is read-only, mark them const
to make that clearer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index eb30c299a71e..37195cb5f70b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1810,18 +1810,18 @@ void iwl_mvm_rx_shared_mem_cfg_notif(struct iwl_mvm *mvm,
 /* MVM PHY */
 struct iwl_mvm_phy_ctxt *iwl_mvm_get_free_phy_ctxt(struct iwl_mvm *mvm);
 int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
-			 struct cfg80211_chan_def *chandef,
+			 const struct cfg80211_chan_def *chandef,
 			 u8 chains_static, u8 chains_dynamic);
 int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
-			     struct cfg80211_chan_def *chandef,
+			     const struct cfg80211_chan_def *chandef,
 			     u8 chains_static, u8 chains_dynamic);
 void iwl_mvm_phy_ctxt_ref(struct iwl_mvm *mvm,
 			  struct iwl_mvm_phy_ctxt *ctxt);
 void iwl_mvm_phy_ctxt_unref(struct iwl_mvm *mvm,
 			    struct iwl_mvm_phy_ctxt *ctxt);
 int iwl_mvm_phy_ctx_count(struct iwl_mvm *mvm);
-u8 iwl_mvm_get_channel_width(struct cfg80211_chan_def *chandef);
-u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef);
+u8 iwl_mvm_get_channel_width(const struct cfg80211_chan_def *chandef);
+u8 iwl_mvm_get_ctrl_pos(const struct cfg80211_chan_def *chandef);
 int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 			 u8 chains_static, u8 chains_dynamic);
 
@@ -2530,7 +2530,7 @@ static inline void iwl_mvm_set_chan_info(struct iwl_mvm *mvm,
 static inline void
 iwl_mvm_set_chan_info_chandef(struct iwl_mvm *mvm,
 			      struct iwl_fw_channel_info *ci,
-			      struct cfg80211_chan_def *chandef)
+			      const struct cfg80211_chan_def *chandef)
 {
 	enum nl80211_band band = chandef->chan->band;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 8bf778503b74..bac655834f32 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -9,7 +9,7 @@
 #include "mvm.h"
 
 /* Maps the driver specific channel width definition to the fw values */
-u8 iwl_mvm_get_channel_width(struct cfg80211_chan_def *chandef)
+u8 iwl_mvm_get_channel_width(const struct cfg80211_chan_def *chandef)
 {
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
@@ -33,7 +33,7 @@ u8 iwl_mvm_get_channel_width(struct cfg80211_chan_def *chandef)
  * Maps the driver specific control channel position (relative to the center
  * freq) definitions to the the fw values
  */
-u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef)
+u8 iwl_mvm_get_ctrl_pos(const struct cfg80211_chan_def *chandef)
 {
 	int offs = chandef->chan->center_freq - chandef->center_freq1;
 	int abs_offs = abs(offs);
@@ -116,7 +116,7 @@ static void iwl_mvm_phy_ctxt_set_rxchain(struct iwl_mvm *mvm,
 static void iwl_mvm_phy_ctxt_cmd_data_v1(struct iwl_mvm *mvm,
 					 struct iwl_mvm_phy_ctxt *ctxt,
 					 struct iwl_phy_context_cmd_v1 *cmd,
-					 struct cfg80211_chan_def *chandef,
+					 const struct cfg80211_chan_def *chandef,
 					 u8 chains_static, u8 chains_dynamic)
 {
 	struct iwl_phy_context_cmd_tail *tail =
@@ -137,7 +137,7 @@ static void iwl_mvm_phy_ctxt_cmd_data_v1(struct iwl_mvm *mvm,
 static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
 				      struct iwl_mvm_phy_ctxt *ctxt,
 				      struct iwl_phy_context_cmd *cmd,
-				      struct cfg80211_chan_def *chandef,
+				      const struct cfg80211_chan_def *chandef,
 				      u8 chains_static, u8 chains_dynamic)
 {
 	cmd->lmac_id = cpu_to_le32(iwl_mvm_get_lmac_id(mvm,
@@ -197,7 +197,7 @@ int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
  */
 static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 				  struct iwl_mvm_phy_ctxt *ctxt,
-				  struct cfg80211_chan_def *chandef,
+				  const struct cfg80211_chan_def *chandef,
 				  u8 chains_static, u8 chains_dynamic,
 				  u32 action)
 {
@@ -254,7 +254,7 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
  * Send a command to add a PHY context based on the current HW configuration.
  */
 int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
-			 struct cfg80211_chan_def *chandef,
+			 const struct cfg80211_chan_def *chandef,
 			 u8 chains_static, u8 chains_dynamic)
 {
 	int ret;
@@ -300,7 +300,7 @@ void iwl_mvm_phy_ctxt_ref(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt)
  * changed.
  */
 int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
-			     struct cfg80211_chan_def *chandef,
+			     const struct cfg80211_chan_def *chandef,
 			     u8 chains_static, u8 chains_dynamic)
 {
 	enum iwl_ctxt_action action = FW_CTXT_ACTION_MODIFY;
-- 
2.34.1


