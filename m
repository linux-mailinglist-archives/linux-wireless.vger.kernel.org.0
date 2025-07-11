Return-Path: <linux-wireless+bounces-25280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9164B02086
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084494A8071
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0732ED859;
	Fri, 11 Jul 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2SeGMdK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E962ED17D
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248099; cv=none; b=PDRk7Lu22DM6X6HdNBGebOhIMohxXGUzBnn539hbLxkQi6zpOAGC65CUIY4jFDOQ1N3XhjACr0zL7hB64MkTeGB4wUxBcIcWNtkHLPmzv+ZETPEaqv1+SW5hUZo0kdTlLQGbzdAjvnvLM1SNFM6fPiT/uwPSjIrdAwmBX0RGlJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248099; c=relaxed/simple;
	bh=3bo3mVBY6B2Cu0h5pAInV0zPUJAsG3+RGstT0Hy9kZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zd5vA91eu3yice9cMG6XgNxJfFpVLir3xXvmfMb4RXiiL1fUEn28aT+JnQcKWYMLykpf8JGMXIbP19JDsM1gh4X4SBDELX28Q/OLVgZI2x/0euUq8brXKIc7rZADvWcwlYB9ZK42IHQ9BUbXsfJY3QXQHbcugSyl1P2uil2P2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2SeGMdK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248098; x=1783784098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bo3mVBY6B2Cu0h5pAInV0zPUJAsG3+RGstT0Hy9kZc=;
  b=h2SeGMdKYWJin8osYECD6WM0nwUW0UYgUkqlLDT3NwwAvA46lep3wWZZ
   /iFSXeudTYNFwg44M0ERdNN5wVzdV+M4vNp2oJo4HagG360tw973k/oSL
   qOCXw5/IrLZhhqftS7GZArMc9kt/MTbJSzXR50f2r1q3Cr0WZX1E59O+q
   Rc+oPldwV+9C5rgTAK4DQhv6IaJzQakAiLD9M158Kgbua3CccjcUl8CV5
   0GGC4e/81tdhh5+wdNCb1JAUW7KdFMOxmHs2Ihl1JPqIqcYQ6MZBPQcHi
   clyPhgFcTUSg8bDtgph76nX0S5i/boc6PiTwQwVErmgd4S79/CuOQntZr
   g==;
X-CSE-ConnectionGUID: NZ1WfjXBToiTUcqyUXny7Q==
X-CSE-MsgGUID: CjDQQMCcRPSbejLGxJAaUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264157"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264157"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:57 -0700
X-CSE-ConnectionGUID: 3tNOEGI5TUOqyA1W5SEmuw==
X-CSE-MsgGUID: GZs7T4u4T8qvEgXf7/QrYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485104"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: mvm: remove support for REDUCE_TX_POWER_CMD ver 6 and 7
Date: Fri, 11 Jul 2025 18:34:19 +0300
Message-Id: <20250711183056.05fabbda0a2f.Id55eeb4f337eb52163621ca202d97a3539bf3f53@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

These versions are no longer used in any of our devices. Remove them.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 48 -------------------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 14 ++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 --
 3 files changed, 4 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 23140205ccb9..df70b32cfced 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -341,50 +341,6 @@ struct iwl_dev_tx_power_cmd_v5 {
 	__le32 timer_period;
 } __packed; /* TX_REDUCED_POWER_API_S_VER_5 */
 
-/**
- * struct iwl_dev_tx_power_cmd_v6 - TX power reduction command version 6
- * @per_chain: per chain restrictions
- * @enable_ack_reduction: enable or disable close range ack TX power
- *	reduction.
- * @per_chain_restriction_changed: is per_chain_restriction has changed
- *	from last command. used if set_mode is
- *	IWL_TX_POWER_MODE_SET_SAR_TIMER.
- *	note: if not changed, the command is used for keep alive only.
- * @reserved: reserved (padding)
- * @timer_period: timer in milliseconds. if expires FW will change to default
- *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
- */
-struct iwl_dev_tx_power_cmd_v6 {
-	__le16 per_chain[IWL_NUM_CHAIN_TABLES_V2][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
-	u8 enable_ack_reduction;
-	u8 per_chain_restriction_changed;
-	u8 reserved[2];
-	__le32 timer_period;
-} __packed; /* TX_REDUCED_POWER_API_S_VER_6 */
-
-/**
- * struct iwl_dev_tx_power_cmd_v7 - TX power reduction command version 7
- * @per_chain: per chain restrictions
- * @enable_ack_reduction: enable or disable close range ack TX power
- *	reduction.
- * @per_chain_restriction_changed: is per_chain_restriction has changed
- *	from last command. used if set_mode is
- *	IWL_TX_POWER_MODE_SET_SAR_TIMER.
- *	note: if not changed, the command is used for keep alive only.
- * @reserved: reserved (padding)
- * @timer_period: timer in milliseconds. if expires FW will change to default
- *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
- * @flags: reduce power flags.
- */
-struct iwl_dev_tx_power_cmd_v7 {
-	__le16 per_chain[IWL_NUM_CHAIN_TABLES_V2][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
-	u8 enable_ack_reduction;
-	u8 per_chain_restriction_changed;
-	u8 reserved[2];
-	__le32 timer_period;
-	__le32 flags;
-} __packed; /* TX_REDUCED_POWER_API_S_VER_7 */
-
 /**
  * struct iwl_dev_tx_power_cmd_v8 - TX power reduction command version 8
  * @per_chain: per chain restrictions
@@ -429,8 +385,6 @@ struct iwl_dev_tx_power_cmd_per_band {
  * @v3: version 3 part of the command
  * @v4: version 4 part of the command
  * @v5: version 5 part of the command
- * @v6: version 6 part of the command
- * @v7: version 7 part of the command
  * @v8: version 8 part of the command
  */
 struct iwl_dev_tx_power_cmd_v3_v8 {
@@ -440,8 +394,6 @@ struct iwl_dev_tx_power_cmd_v3_v8 {
 		struct iwl_dev_tx_power_cmd_v3 v3;
 		struct iwl_dev_tx_power_cmd_v4 v4;
 		struct iwl_dev_tx_power_cmd_v5 v5;
-		struct iwl_dev_tx_power_cmd_v6 v6;
-		struct iwl_dev_tx_power_cmd_v7 v7;
 		struct iwl_dev_tx_power_cmd_v8 v8;
 	};
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 4c2d0a4098cc..749fb8441190 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -888,17 +888,11 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 		len = sizeof(cmd_v9_v10.v9);
 		n_subbands = IWL_NUM_SUB_BANDS_V1;
 		per_chain = &cmd_v9_v10.v9.per_chain[0][0];
-	} else if (cmd_ver >= 7) {
-		len = sizeof(cmd.v7);
+	} else if (cmd_ver == 8) {
+		len = sizeof(cmd.v8);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;
-		per_chain = cmd.v7.per_chain[0][0];
-		cmd.v7.flags = cpu_to_le32(mvm->fwrt.reduced_power_flags);
-		if (cmd_ver == 8)
-			len = sizeof(cmd.v8);
-	} else if (cmd_ver == 6) {
-		len = sizeof(cmd.v6);
-		n_subbands = IWL_NUM_SUB_BANDS_V2;
-		per_chain = cmd.v6.per_chain[0][0];
+		per_chain = cmd.v8.per_chain[0][0];
+		cmd.v8.flags = cpu_to_le32(mvm->fwrt.reduced_power_flags);
 	} else if (fw_has_api(&mvm->fw->ucode_capa,
 			      IWL_UCODE_TLV_API_REDUCE_TX_POWER)) {
 		len = sizeof(cmd.v5);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9e9e76b67ef0..fa9d5e0b6609 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1515,10 +1515,6 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm,
 		len = sizeof(cmd_v9_v10.v9);
 	else if (cmd_ver == 8)
 		len = sizeof(cmd.v8);
-	else if (cmd_ver == 7)
-		len = sizeof(cmd.v7);
-	else if (cmd_ver == 6)
-		len = sizeof(cmd.v6);
 	else if (fw_has_api(&mvm->fw->ucode_capa,
 			    IWL_UCODE_TLV_API_REDUCE_TX_POWER))
 		len = sizeof(cmd.v5);
-- 
2.34.1


