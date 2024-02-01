Return-Path: <linux-wireless+bounces-2952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C48138459F4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA55E1C24370
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A598665E;
	Thu,  1 Feb 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIEBVtiO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E95D465
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797191; cv=none; b=EjnJTOGgG+WrOy4cYrC9FUYRmwhE7my/JOPI75hhRXgwoqFAV5qbmJ7ZqkjBS24PLMR4AI1S3VIBI0igMgn5p6aEmaQiedMFJF0yXvM0JfjAadSkfeUbMh5+O21YvdHzBWjW5l0EmWvvXKmDeyPWdJorTvheyjcE95wJxI7rihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797191; c=relaxed/simple;
	bh=XEIu6d98e+aEiKqx5wQn5QQDTXO03TBrKpzV86pf214=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7ky/oZlYWbIASYcoLHRyJctQTu5u9TeDfT14YtI5v8s03Q64m+112Hx6jgWtgms4EQPKKs7dE8mLB9e0XL8vlL0SB7/QksOgCU8wW49EfI4a72aKsy44BWluLM6voAgQolxVSBx8zceXGN5XfWGX1W5nttzNd+9i5pz0uSjPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIEBVtiO; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797190; x=1738333190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XEIu6d98e+aEiKqx5wQn5QQDTXO03TBrKpzV86pf214=;
  b=MIEBVtiOzCpIbCJEuyn4rbJ4gz+tPdoLDxF3CxZ4XeGnQ5z53m1nosrK
   6GfYPENdiFbHUZ0b/xE0gnrW3Ln2aReBWM5i2whanKKLSjRzN2uE1Vgah
   751hnRR1b7ojvP4qfVGZoRnE1tb+XjJirjhuIK7Eg0LL6Kx+R5hL897j5
   FvhVsUlW8LAv9vpj1/cvuANuBqyObUT/PRWmSx5HATLg1XlhBceIO8VMf
   sPorUIpNP0PF8WbLudGD+QvLF8kAV48PfWMHvVsRzMKWiy14fyzvI4J2T
   KMuhqbXzrFYNcIxw/93gwpZoHmtv7qVa/sOtJrtXhqyHlcXouTWk+jTsQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062868"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062868"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94114"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 05/17] wifi: iwlwifi: support link command version 2
Date: Thu,  1 Feb 2024 16:17:29 +0200
Message-Id: <20240201155157.df1890aba2fd.Icad9ba10f8bab770adc6a559b2c7bff5cccbffe9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
References: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

In version 2, listen_lmac becomes reserved.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h    | 18 ++++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/link.c  | 10 ++++++++--
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index f15e6d64c298..53a5fae15f01 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -447,6 +447,7 @@ enum iwl_link_ctx_flags {
  * @listen_lmac: indicates whether the link should be allocated on the Listen
  *	Lmac or on the Main Lmac. Cannot be changed on an active Link.
  *	Relevant only for eSR.
+ * @reserved1: in version 2, listen_lmac became reserved
  * @cck_rates: basic rates available for CCK
  * @ofdm_rates: basic rates available for OFDM
  * @cck_short_preamble: 1 for enabling short preamble, 0 otherwise
@@ -472,10 +473,10 @@ enum iwl_link_ctx_flags {
  * @bssid_index: index of the associated VAP
  * @bss_color: 11ax AP ID that is used in the HE SIG-A to mark inter BSS frame
  * @spec_link_id: link_id as the AP knows it
- * @reserved: alignment
+ * @reserved2: alignment
  * @ibss_bssid_addr: bssid for ibss
  * @reserved_for_ibss_bssid_addr: reserved
- * @reserved1: reserved for future use
+ * @reserved3: reserved for future use
  */
 struct iwl_link_config_cmd {
 	__le32 action;
@@ -486,7 +487,10 @@ struct iwl_link_config_cmd {
 	__le16 reserved_for_local_link_addr;
 	__le32 modify_mask;
 	__le32 active;
-	__le32 listen_lmac;
+	union {
+		__le32 listen_lmac;
+		__le32 reserved1;
+	};
 	__le32 cck_rates;
 	__le32 ofdm_rates;
 	__le32 cck_short_preamble;
@@ -512,11 +516,13 @@ struct iwl_link_config_cmd {
 	u8 bssid_index;
 	u8 bss_color;
 	u8 spec_link_id;
-	u8 reserved;
+	u8 reserved2;
 	u8 ibss_bssid_addr[6];
 	__le16 reserved_for_ibss_bssid_addr;
-	__le32 reserved1[8];
-} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1 */
+	__le32 reserved3[8];
+} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1 and
+	     * LINK_CONTEXT_CONFIG_CMD_API_S_VER_2
+	     */
 
 /* Currently FW supports link ids in the range 0-3 and can have
  * at most two active links for each vif.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index be48b0fc9cb6..f3fcef9034ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -53,6 +53,8 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	unsigned int link_id = link_conf->link_id;
 	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
 	struct iwl_link_config_cmd cmd = {};
+	unsigned int cmd_id = WIDE_ID(MAC_CONF_GROUP, LINK_CONFIG_CMD);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 1);
 
 	if (WARN_ON_ONCE(!link_info))
 		return -EINVAL;
@@ -84,7 +86,8 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (vif->type == NL80211_IFTYPE_ADHOC && link_conf->bssid)
 		memcpy(cmd.ibss_bssid_addr, link_conf->bssid, ETH_ALEN);
 
-	cmd.listen_lmac = cpu_to_le32(link_info->listen_lmac);
+	if (cmd_ver < 2)
+		cmd.listen_lmac = cpu_to_le32(link_info->listen_lmac);
 
 	return iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_ADD);
 }
@@ -100,6 +103,8 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	struct iwl_link_config_cmd cmd = {};
 	u32 ht_flag, flags = 0, flags_mask = 0;
 	int ret;
+	unsigned int cmd_id = WIDE_ID(MAC_CONF_GROUP, LINK_CONFIG_CMD);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 1);
 
 	if (WARN_ON_ONCE(!link_info ||
 			 link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
@@ -224,7 +229,8 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd.flags = cpu_to_le32(flags);
 	cmd.flags_mask = cpu_to_le32(flags_mask);
 	cmd.spec_link_id = link_conf->link_id;
-	cmd.listen_lmac = cpu_to_le32(link_info->listen_lmac);
+	if (cmd_ver < 2)
+		cmd.listen_lmac = cpu_to_le32(link_info->listen_lmac);
 
 	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_MODIFY);
 	if (!ret && (changes & LINK_CONTEXT_MODIFY_ACTIVE))
-- 
2.34.1


