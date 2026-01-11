Return-Path: <linux-wireless+bounces-30653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB1D0F853
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C4263001612
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3438C349B17;
	Sun, 11 Jan 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0rCIBEX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980234CFD9
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153183; cv=none; b=pvkkzyWNLI+zqx1wP4Tqdbqx4JE5gUrP0rR3Jge3iN0mHKrPV/Q0E7UsLlWlfx4yH3DUxRrYF0ih+fxw3a58MMVyE4dr/7PtN6lpID1HX1+nxeH2pqlNiV9zRnubahrNms5Ma1Kj/k4REl7U/wf1PQ1NUbF4+x7ZjWwxD73X6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153183; c=relaxed/simple;
	bh=qDgoWhcDcLsC52Ay3UuAWxvQ4az6rn8FfKq9xW9/2aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJFSDwIIZX43nzljz3aFz3Ri4+4pPRzdG95Pl9krY6doqxyzuKP+/FC1IDeTeaCUlH9ZzYzBvIru6R7n7ZU+laYQ4ESBqfuuBI7Z10XpVrHr278O0ZPP2AJ6aY7AxpZRqQiQU1iLmqpPupvxIWu8+/PHCuy05m00EW4+5WYRGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0rCIBEX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153180; x=1799689180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qDgoWhcDcLsC52Ay3UuAWxvQ4az6rn8FfKq9xW9/2aE=;
  b=n0rCIBEXivxWOWoVSzTK2wNXUfq1Eqh1Gl9Hd1XhDNcIJ06ip/otjQmK
   9oL6BY/upoCdFeINjcNg2qLdxRadlvkTNeaGsmPNUCzjoq4lbB2hOigzg
   rU3NxvCE98D/1gkgzSPALeCx4vO1QKyRU3F35cyGJAvOo9td+ehQS45jv
   kp/i3m9DiT4WQD/O8QZaE101VePCpUEA5iaVczq0me7TL7ovBfTP24Tn9
   T2ki0Ic1L6UhYT7acCawahvw+FpswAmg5JrOSwD3MlHtVQLHjeoBqOZJ/
   H3yf6ta04/V1U/GwefIRIpttzytNV/vTDYn5MZ5GJzV/5trkbM0/EQByi
   g==;
X-CSE-ConnectionGUID: moDloc3jQfa0WhuOd9qoRA==
X-CSE-MsgGUID: DJCAY8FKTOq1vuQvRjfplw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521086"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521086"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:40 -0800
X-CSE-ConnectionGUID: 2BxaG6UrTFmJfvDjFML99A==
X-CSE-MsgGUID: Ejhwz8lxSAK7vwdob8GFRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393786"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:39 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mld: add an helper to update an EMLSR blocker
Date: Sun, 11 Jan 2026 19:39:15 +0200
Message-Id: <20260111193638.f87b347a5cf0.I6836ba40d21cca49401d1f88e03a37b00dd9f5c2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Add an helper function that iterates over all (relevant) interfaces and
sets/unsets a given EMLSR blocker.
For now use it only for IWL_MLD_EMLSR_BLOCKED_NON_BSS.

Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 39 +++++++++++++-------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 1efefc737248..87f67ddfced4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -451,29 +451,49 @@ static void iwl_mld_count_non_bss_links(void *_data, u8 *mac,
 
 struct iwl_mld_update_emlsr_block_data {
 	bool block;
+	enum iwl_mld_emlsr_blocked reason;
 	int result;
 };
 
 static void
-iwl_mld_vif_iter_update_emlsr_non_bss_block(void *_data, u8 *mac,
-					    struct ieee80211_vif *vif)
+iwl_mld_vif_iter_update_emlsr_block(void *_data, u8 *mac,
+				    struct ieee80211_vif *vif)
 {
 	struct iwl_mld_update_emlsr_block_data *data = _data;
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	int ret;
 
+	if (!iwl_mld_vif_has_emlsr_cap(vif))
+		return;
+
 	if (data->block) {
 		ret = iwl_mld_block_emlsr_sync(mld_vif->mld, vif,
-					       IWL_MLD_EMLSR_BLOCKED_NON_BSS,
+					       data->reason,
 					       iwl_mld_get_primary_link(vif));
 		if (ret)
 			data->result = ret;
 	} else {
 		iwl_mld_unblock_emlsr(mld_vif->mld, vif,
-				      IWL_MLD_EMLSR_BLOCKED_NON_BSS);
+				      data->reason);
 	}
 }
 
+static int iwl_mld_update_emlsr_block(struct iwl_mld *mld, bool block,
+				      enum iwl_mld_emlsr_blocked reason)
+{
+	struct iwl_mld_update_emlsr_block_data block_data = {
+		.block = block,
+		.reason = reason,
+	};
+
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_vif_iter_update_emlsr_block,
+						&block_data);
+
+	return block_data.result;
+}
+
 int iwl_mld_emlsr_check_non_bss_block(struct iwl_mld *mld,
 				      int pending_link_changes)
 {
@@ -481,7 +501,6 @@ int iwl_mld_emlsr_check_non_bss_block(struct iwl_mld *mld,
 	 * block EMLSR on the bss vif. Upon deactivation, check if this link
 	 * was the last non-station link active, and if so unblock the bss vif
 	 */
-	struct iwl_mld_update_emlsr_block_data block_data = {};
 	int count = pending_link_changes;
 
 	/* No need to count if we are activating a non-BSS link */
@@ -495,14 +514,8 @@ int iwl_mld_emlsr_check_non_bss_block(struct iwl_mld *mld,
 	 * We could skip updating it if the block change did not change (and
 	 * pending_link_changes is non-zero).
 	 */
-	block_data.block = !!count;
-
-	ieee80211_iterate_active_interfaces_mtx(mld->hw,
-						IEEE80211_IFACE_ITER_NORMAL,
-						iwl_mld_vif_iter_update_emlsr_non_bss_block,
-						&block_data);
-
-	return block_data.result;
+	return iwl_mld_update_emlsr_block(mld, !!count,
+					  IWL_MLD_EMLSR_BLOCKED_NON_BSS);
 }
 
 #define EMLSR_SEC_LINK_MIN_PERC 10
-- 
2.34.1


