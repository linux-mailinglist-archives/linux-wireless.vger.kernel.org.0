Return-Path: <linux-wireless+bounces-20278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5196A5E74A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B552189D94A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAEF1EFF80;
	Wed, 12 Mar 2025 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElCmiQ+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F11F12F1
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818192; cv=none; b=YCB03sdDGpx5MoBUtcR1h3LF9t3vT7A6hV1VOPMmWOdbxdmUVwbWzpEZ4mfK/FHVC0SK1WbvsNvy0ZZSY841UpfcYRsXuitVDVisrg0RnXAYvm6w3MRe6t2sEraCve/TgC6bx9h9x6Z+kUjCI1QWHIwPPvcsRdqQS5l4Pb41Mxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818192; c=relaxed/simple;
	bh=sIRrE6KGGfHQ6rScaE1jSw4cK/j2ksVBjKLB8SOpaeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1rwxhWQfaX0pUKppAuANY3dYZPwQ+Vo1B2D6dDeagVuHw/cH0Ou4PVxSRqsoGlQ6DFWh731soVt/1tB9RID1POMbcAl9iE18jZZU7chle/omacg4y+ujjejnlJXur8S+zZf0QYK7dov1M4Rzq4XIONOIlkAVWD7ijcLMrv8fyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElCmiQ+9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818191; x=1773354191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sIRrE6KGGfHQ6rScaE1jSw4cK/j2ksVBjKLB8SOpaeM=;
  b=ElCmiQ+99TG43fibW6Sgo4SmuPhvv4KJ8dgZyol8B1tyRPEDba9SE11Q
   3NkGtQdDnkTzlqNaPjdnKDotzb7xR+wml9Tsdz7kt04HigdvAJm8Do8Bm
   luNTN7IWJeEFuZUrgronkS/7cDiVpnxbqa4UiCY+3BdjttCY4Oo8xsUdA
   5GVkT92+MUSz8wSym2uYGdpvalADxRHlYwkU3SeWUgumUp4UYahY962uf
   6HBv2aFvh+Vc7nw+pKTNmegp1YyvVGdBAg2Kt9ihQkkIbwrl0EWtcarpA
   Z5VNMYoZLSQ07lisg475ro2LSyGBGe8Tspjau5yXdIP6UqiFFSjsv7ayy
   w==;
X-CSE-ConnectionGUID: dZVoQePdS4OIgMAnQKgXuA==
X-CSE-MsgGUID: g5XVnfT2Q4CyZPyIPtH3NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826762"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826762"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:11 -0700
X-CSE-ConnectionGUID: +/UTvnzAQXa5qxEPU2wZDg==
X-CSE-MsgGUID: yNlxKUERQIKZ4DVPcmQYLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267408"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 13/15] wifi: iwlwifi: mld: iwl_mld_remove_link can't fail
Date: Thu, 13 Mar 2025 00:22:36 +0200
Message-Id: <20250313002008.16fe6ebae412.If5371ff7e096b7078ff9e98ff0e72010cd1f076d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_mld_remove_link removes the link from both the FW and from the
driver.
If removing it from the FW failed, we assume that the FW is
dead anyway and remove it from the driver as well.
On the other hand, we still return an error value, indicating the caller
(i.e. mac80211) that the link couldn't be removed - while it was
actually removed.
Later, mac80211 might tell the driver again to remove that link,
and then the driver will warn that it doesn't exist.

Fix this by making iwl_mld_remove_link a void function.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 19 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/mld/link.h |  4 ++--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  9 ++-------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 6db8b5305349..82a4979a3af3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -455,7 +455,7 @@ void iwl_mld_deactivate_link(struct iwl_mld *mld,
 					       mld_link->fw_id);
 }
 
-static int
+static void
 iwl_mld_rm_link_from_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link)
 {
 	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
@@ -464,13 +464,13 @@ iwl_mld_rm_link_from_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link)
 	lockdep_assert_wiphy(mld->wiphy);
 
 	if (WARN_ON(!mld_link))
-		return -EINVAL;
+		return;
 
 	cmd.link_id = cpu_to_le32(mld_link->fw_id);
 	cmd.spec_link_id = link->link_id;
 	cmd.phy_id = cpu_to_le32(FW_CTXT_ID_INVALID);
 
-	return iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_REMOVE);
+	iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_REMOVE);
 }
 
 static void iwl_mld_omi_bw_update(struct iwl_mld *mld,
@@ -832,18 +832,17 @@ int iwl_mld_add_link(struct iwl_mld *mld,
 }
 
 /* Remove link from fw, unmap the bss_conf, and destroy the link structure */
-int iwl_mld_remove_link(struct iwl_mld *mld,
-			struct ieee80211_bss_conf *bss_conf)
+void iwl_mld_remove_link(struct iwl_mld *mld,
+			 struct ieee80211_bss_conf *bss_conf)
 {
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
 	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
 	bool is_deflink = link == &mld_vif->deflink;
-	int ret;
 
 	if (WARN_ON(!link || link->active))
-		return -EINVAL;
+		return;
 
-	ret = iwl_mld_rm_link_from_fw(mld, bss_conf);
+	iwl_mld_rm_link_from_fw(mld, bss_conf);
 	/* Continue cleanup on failure */
 
 	if (!is_deflink)
@@ -854,11 +853,9 @@ int iwl_mld_remove_link(struct iwl_mld *mld,
 	wiphy_delayed_work_cancel(mld->wiphy, &link->rx_omi.finished_work);
 
 	if (WARN_ON(link->fw_id >= mld->fw->ucode_capa.num_links))
-		return -EINVAL;
+		return;
 
 	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[link->fw_id], NULL);
-
-	return ret;
 }
 
 void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 3a4f3ac990d7..42b7bdcbd741 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -114,8 +114,8 @@ iwl_mld_cleanup_link(struct iwl_mld *mld, struct iwl_mld_link *link)
 
 int iwl_mld_add_link(struct iwl_mld *mld,
 		     struct ieee80211_bss_conf *bss_conf);
-int iwl_mld_remove_link(struct iwl_mld *mld,
-			struct ieee80211_bss_conf *bss_conf);
+void iwl_mld_remove_link(struct iwl_mld *mld,
+			 struct ieee80211_bss_conf *bss_conf);
 int iwl_mld_activate_link(struct iwl_mld *mld,
 			  struct ieee80211_bss_conf *link);
 void iwl_mld_deactivate_link(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 938cf5900a29..6851064b82da 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2456,13 +2456,8 @@ iwl_mld_change_vif_links(struct ieee80211_hw *hw,
 		added |= BIT(0);
 
 	for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		if (removed & BIT(i)) {
-			link_conf = old[i];
-
-			err = iwl_mld_remove_link(mld, link_conf);
-			if (err)
-				return err;
-		}
+		if (removed & BIT(i))
+			iwl_mld_remove_link(mld, old[i]);
 	}
 
 	for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-- 
2.34.1


