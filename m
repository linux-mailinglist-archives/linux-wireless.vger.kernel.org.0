Return-Path: <linux-wireless+bounces-25281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C6B02087
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B6BA602DE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FF72ED862;
	Fri, 11 Jul 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8ngujaS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F32ED845
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248099; cv=none; b=pkTwhU3/UP1BSVQWBbUKVwWC7qAvXUCGlkK4vWKhYPQuyLhYTlL1YQy9Qq/IWBSiBHF12Gda5XsFhenodBObBmh9n0LmqKlXjrGrktrvgKiGljC6RSYFwVZ9bqbf4LNx7g6vMFM8naeXu0yJtSwANQx091mFDG1GFRrlH23DRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248099; c=relaxed/simple;
	bh=Mp7sAFZKxXOJpzc8R3JgHdV4RhFPNkoURMiyEL2SaOc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hw4/RbLNE624or3Xk60O4bEvT8eZlrzUmO+cKWOf1g+nwp2tZU+zFBTLFFWGjOp31IhmDGA2fiuldTTH5CDZ0u/Lm7T/3BEl1xQeNVljZz2H6nSoh2Owdvmc6bkiSlG6jNF6RMWyxVFyG+rAnBRvAgxMtBNwa9DT0paoySeFR90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8ngujaS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248098; x=1783784098;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Mp7sAFZKxXOJpzc8R3JgHdV4RhFPNkoURMiyEL2SaOc=;
  b=D8ngujaSLxNQ8H5y35MkVL52qMjkGFcZaQaiMyOGxjfzgXHvBYHvieBu
   2IIEqzj23C5TryqA+OFWi52U8kOGf34VCLcOq1g3WaxkK08RiICYlbTcz
   Ln0uZh54g6WZtfhMLVyVg9CmbOq39K9KtP/HYU29pInI+oxsOAJBwC6mU
   YVrBI9RjhDYer+vMrtdFpGobVn6Zm9QAAi3bwIBQVUnJHaEw4bxodzmE3
   EwQOnHP7Aa3mHukDxmVNM+2mNjbDGjkCbQn4poWoTHzeaoTEdtcED6/r7
   5UxzJ6ytPlC9pL6RWi6vXfknCYetSmmzDqNVjlUPfLyGWnD+xWTOispUn
   g==;
X-CSE-ConnectionGUID: Di+KjRSmQ72sJDmorJDyGQ==
X-CSE-MsgGUID: OMdwgR4hSS2JMAgbojeiCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264160"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264160"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:58 -0700
X-CSE-ConnectionGUID: Mi6fop9TT/u2oXA9dV4Xrw==
X-CSE-MsgGUID: jYypPY1XRlOVhy39W+bKdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485106"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mld: remove support for REDUCE_TX_POWER_CMD ver 9
Date: Fri, 11 Jul 2025 18:34:20 +0300
Message-Id: <20250711183056.aeeb617abfae.I05101972506180644c42be5096c1b2afa36c625a@changeid>
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

iwlmld was planned to be used for HR, which has version 9,
but it was decided at the end to use iwlmvm for HR, so iwlmld only
needs to support version 10.
Remove version 9 support.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/power.c    | 10 +------
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 29 ++++---------------
 2 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/power.c b/drivers/net/wireless/intel/iwlwifi/mld/power.c
index 8cc276041360..f664b277adf7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/power.c
@@ -377,23 +377,15 @@ int iwl_mld_set_tx_power(struct iwl_mld *mld,
 	u16 u_tx_power = tx_power == IWL_DEFAULT_MAX_TX_POWER ?
 		IWL_DEV_MAX_TX_POWER : 8 * tx_power;
 	struct iwl_dev_tx_power_cmd cmd = {
-		/* Those fields sit on the same place for v9 and v10 */
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_LINK),
 		.common.pwr_restriction = cpu_to_le16(u_tx_power),
 	};
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id,
-					   IWL_FW_CMD_VER_UNKNOWN);
-	int len = sizeof(cmd.common);
+	int len = sizeof(cmd.common) + sizeof(cmd.v10);
 
 	if (WARN_ON(!mld_link))
 		return -ENODEV;
 
 	cmd.common.link_id = cpu_to_le32(mld_link->fw_id);
 
-	if (cmd_ver == 10)
-		len += sizeof(cmd.v10);
-	else if (cmd_ver == 9)
-		len += sizeof(cmd.v9);
-
 	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, len);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 887f1fb2f926..b82ddd629e24 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -120,37 +120,20 @@ int iwl_mld_config_sar_profile(struct iwl_mld *mld, int prof_a, int prof_b)
 	u32 cmd_id = REDUCE_TX_POWER_CMD;
 	struct iwl_dev_tx_power_cmd cmd = {
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
+		.v10.flags = cpu_to_le32(mld->fwrt.reduced_power_flags),
 	};
-	__le16 *per_chain;
 	int ret;
-	u16 len = sizeof(cmd.common);
-	u32 n_subbands;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id,
-					   IWL_FW_CMD_VER_UNKNOWN);
-
-	if (cmd_ver == 10) {
-		len += sizeof(cmd.v10);
-		n_subbands = IWL_NUM_SUB_BANDS_V2;
-		per_chain = &cmd.v10.per_chain[0][0][0];
-		cmd.v10.flags =
-			cpu_to_le32(mld->fwrt.reduced_power_flags);
-	} else if (cmd_ver == 9) {
-		len += sizeof(cmd.v9);
-		n_subbands = IWL_NUM_SUB_BANDS_V1;
-		per_chain = &cmd.v9.per_chain[0][0];
-	} else {
-		return -EOPNOTSUPP;
-	}
 
 	/* TODO: CDB - support IWL_NUM_CHAIN_TABLES_V2 */
-	ret = iwl_sar_fill_profile(&mld->fwrt, per_chain,
-				   IWL_NUM_CHAIN_TABLES,
-				   n_subbands, prof_a, prof_b);
+	ret = iwl_sar_fill_profile(&mld->fwrt, &cmd.v10.per_chain[0][0][0],
+				   IWL_NUM_CHAIN_TABLES, IWL_NUM_SUB_BANDS_V2,
+				   prof_a, prof_b);
 	/* return on error or if the profile is disabled (positive number) */
 	if (ret)
 		return ret;
 
-	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, len);
+	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd,
+				    sizeof(cmd.common) + sizeof(cmd.v10));
 }
 
 int iwl_mld_init_sar(struct iwl_mld *mld)
-- 
2.34.1


