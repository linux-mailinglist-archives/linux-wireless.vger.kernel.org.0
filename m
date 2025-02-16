Return-Path: <linux-wireless+bounces-18988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5857A37384
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C380188BB5A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987718DB19;
	Sun, 16 Feb 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvwR6hIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EE7190696
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699041; cv=none; b=syw/j1cRkZDDgGjRwvVJwz6hqoGr9sspDqX3imIrL9xCuzQP19efEgbxRBNKFNFdhMsyTBXs3w8t82XFQVC6h2kAuD8fvR1VZ8AVtnTev6Ge+JGfjqgjpjUMCuIgblHdg0unHutYVn2oaPA8umQ0fYLd4LZ2MOLmrd+JOgcRaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699041; c=relaxed/simple;
	bh=H/5+l5/rAoiBt64HXABZKpD0sDj6zlNdhvfyfNpCq1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ByRhcLr1twCjRShNutyfX93Q9u2yheKgPPJRaG34BQ5XRiTnbPDiGR6aNXkC2Q6xOzNDMo4Z872IcxFnbqe3x/clwWIEDygO1dCq1xNc6teg1QxsfQCj2j6b5cDQdPM8d9+2UPevddJXzfTsZdIdJDsmoIWrDuGz0xK+2Qcutds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvwR6hIF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699039; x=1771235039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H/5+l5/rAoiBt64HXABZKpD0sDj6zlNdhvfyfNpCq1s=;
  b=hvwR6hIFy3Xcz1KTDMHYZvIYziVsAJC43ifln10UuT60EtpEBBu5S6Km
   5keoKc56a1t2z1sAboL6txeVOSSgXGG4YWglz+xWmaolMiHlAY7KuBpxY
   ZwT3MRQCksBky0KGL6VHFCAjxX87DwiWkMtga9gumm3Su1FaqHEKW4MO1
   cJC4BcB3vnVDC4llKAo0dzoSS/LX1s25VDqLQOP4eOPZ/PerncZlccwdU
   wss1R1RPk/ngUCcnRw8niebmbhJXLzYRy2Tmay+SImQSu+WJA/UGAEeZO
   S5dFMDwrSTbNGbjNuGaGDTerApDdGIApFaC0igvIzjNywl6Uqynfke1Uj
   g==;
X-CSE-ConnectionGUID: Ae7og01ASsO6ifmbrmFfUQ==
X-CSE-MsgGUID: Ny5Jtk1nTXWv8mYn+VcKAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323392"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323392"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:59 -0800
X-CSE-ConnectionGUID: GnI4ukEyRoGK6i06wWiicg==
X-CSE-MsgGUID: a/xzMENLTIWTlM4h65jn3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785246"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 18/42] wifi: iwlwifi: mld: add file mlo.h/c
Date: Sun, 16 Feb 2025 11:42:57 +0200
Message-Id: <20250216111648.11d4a0a17f73.I5d078b0ca0e6375d0a280c09c95d1fc9fc410134@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

this file is handling a link object

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 993 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h | 157 +++
 2 files changed, 1150 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mlo.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mlo.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
new file mode 100644
index 000000000000..fbc8c8584925
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -0,0 +1,993 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#include "mlo.h"
+
+/* Block reasons helper */
+#define HANDLE_EMLSR_BLOCKED_REASONS(HOW)	\
+	HOW(PREVENTION)			\
+	HOW(WOWLAN)			\
+	HOW(FW)				\
+	HOW(ROC)			\
+	HOW(NON_BSS)			\
+	HOW(TMP_NON_BSS)		\
+	HOW(TPT)
+
+static const char *
+iwl_mld_get_emlsr_blocked_string(enum iwl_mld_emlsr_blocked blocked)
+{
+	/* Using switch without "default" will warn about missing entries  */
+	switch (blocked) {
+#define REASON_CASE(x) case IWL_MLD_EMLSR_BLOCKED_##x: return #x;
+	HANDLE_EMLSR_BLOCKED_REASONS(REASON_CASE)
+#undef REASON_CASE
+	}
+
+	return "ERROR";
+}
+
+static void iwl_mld_print_emlsr_blocked(struct iwl_mld *mld, u32 mask)
+{
+#define NAME_FMT(x) "%s"
+#define NAME_PR(x) (mask & IWL_MLD_EMLSR_BLOCKED_##x) ? "[" #x "]" : "",
+	IWL_DEBUG_INFO(mld,
+		       "EMLSR blocked = " HANDLE_EMLSR_BLOCKED_REASONS(NAME_FMT)
+		       " (0x%x)\n",
+		       HANDLE_EMLSR_BLOCKED_REASONS(NAME_PR)
+		       mask);
+#undef NAME_FMT
+#undef NAME_PR
+}
+
+/* Exit reasons helper */
+#define HANDLE_EMLSR_EXIT_REASONS(HOW)	\
+	HOW(BLOCK)			\
+	HOW(MISSED_BEACON)		\
+	HOW(FAIL_ENTRY)			\
+	HOW(CSA)			\
+	HOW(EQUAL_BAND)			\
+	HOW(BANDWIDTH)			\
+	HOW(LOW_RSSI)			\
+	HOW(LINK_USAGE)			\
+	HOW(BT_COEX)			\
+	HOW(CHAN_LOAD)			\
+	HOW(RFI)
+
+static const char *
+iwl_mld_get_emlsr_exit_string(enum iwl_mld_emlsr_exit exit)
+{
+	/* Using switch without "default" will warn about missing entries  */
+	switch (exit) {
+#define REASON_CASE(x) case IWL_MLD_EMLSR_EXIT_##x: return #x;
+	HANDLE_EMLSR_EXIT_REASONS(REASON_CASE)
+#undef REASON_CASE
+	}
+
+	return "ERROR";
+}
+
+static void iwl_mld_print_emlsr_exit(struct iwl_mld *mld, u32 mask)
+{
+#define NAME_FMT(x) "%s"
+#define NAME_PR(x) (mask & IWL_MLD_EMLSR_EXIT_##x) ? "[" #x "]" : "",
+	IWL_DEBUG_INFO(mld,
+		       "EMLSR exit = " HANDLE_EMLSR_EXIT_REASONS(NAME_FMT)
+		       " (0x%x)\n",
+		       HANDLE_EMLSR_EXIT_REASONS(NAME_PR)
+		       mask);
+#undef NAME_FMT
+#undef NAME_PR
+}
+
+void iwl_mld_emlsr_prevent_done_wk(struct wiphy *wiphy, struct wiphy_work *wk)
+{
+	struct iwl_mld_vif *mld_vif = container_of(wk, struct iwl_mld_vif,
+						   emlsr.prevent_done_wk.work);
+	struct ieee80211_vif *vif =
+		container_of((void *)mld_vif, struct ieee80211_vif, drv_priv);
+
+	if (WARN_ON(!(mld_vif->emlsr.blocked_reasons &
+		      IWL_MLD_EMLSR_BLOCKED_PREVENTION)))
+		return;
+
+	iwl_mld_unblock_emlsr(mld_vif->mld, vif,
+			      IWL_MLD_EMLSR_BLOCKED_PREVENTION);
+}
+
+void iwl_mld_emlsr_tmp_non_bss_done_wk(struct wiphy *wiphy,
+				       struct wiphy_work *wk)
+{
+	struct iwl_mld_vif *mld_vif = container_of(wk, struct iwl_mld_vif,
+						   emlsr.prevent_done_wk.work);
+	struct ieee80211_vif *vif =
+		container_of((void *)mld_vif, struct ieee80211_vif, drv_priv);
+
+	if (WARN_ON(!(mld_vif->emlsr.blocked_reasons &
+		      IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS)))
+		return;
+
+	iwl_mld_unblock_emlsr(mld_vif->mld, vif,
+			      IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS);
+}
+
+#define IWL_MLD_TRIGGER_LINK_SEL_TIME	(HZ * IWL_MLD_TRIGGER_LINK_SEL_TIME_SEC)
+#define IWL_MLD_SCAN_EXPIRE_TIME	(HZ * IWL_MLD_SCAN_EXPIRE_TIME_SEC)
+
+/* Exit reasons that can cause longer EMLSR prevention */
+#define IWL_MLD_PREVENT_EMLSR_REASONS	(IWL_MLD_EMLSR_EXIT_MISSED_BEACON | \
+					 IWL_MLD_EMLSR_EXIT_LINK_USAGE)
+#define IWL_MLD_PREVENT_EMLSR_TIMEOUT	(HZ * 400)
+
+#define IWL_MLD_EMLSR_PREVENT_SHORT	(HZ * 300)
+#define IWL_MLD_EMLSR_PREVENT_LONG	(HZ * 600)
+
+static void iwl_mld_check_emlsr_prevention(struct iwl_mld *mld,
+					   struct iwl_mld_vif *mld_vif,
+					   enum iwl_mld_emlsr_exit reason)
+{
+	unsigned long delay;
+
+	/*
+	 * Reset the counter if more than 400 seconds have passed between one
+	 * exit and the other, or if we exited due to a different reason.
+	 * Will also reset the counter after the long prevention is done.
+	 */
+	if (time_after(jiffies, mld_vif->emlsr.last_exit_ts +
+				IWL_MLD_PREVENT_EMLSR_TIMEOUT) ||
+	    mld_vif->emlsr.last_exit_reason != reason)
+		mld_vif->emlsr.exit_repeat_count = 0;
+
+	mld_vif->emlsr.last_exit_reason = reason;
+	mld_vif->emlsr.last_exit_ts = jiffies;
+	mld_vif->emlsr.exit_repeat_count++;
+
+	/*
+	 * Do not add a prevention when the reason was a block. For a block,
+	 * EMLSR will be enabled again on unblock.
+	 */
+	if (reason == IWL_MLD_EMLSR_EXIT_BLOCK)
+		return;
+
+	/* Set prevention for a minimum of 30 seconds */
+	mld_vif->emlsr.blocked_reasons |= IWL_MLD_EMLSR_BLOCKED_PREVENTION;
+	delay = IWL_MLD_TRIGGER_LINK_SEL_TIME;
+
+	/* Handle repeats for reasons that can cause long prevention */
+	if (mld_vif->emlsr.exit_repeat_count > 1 &&
+	    reason & IWL_MLD_PREVENT_EMLSR_REASONS) {
+		if (mld_vif->emlsr.exit_repeat_count == 2)
+			delay = IWL_MLD_EMLSR_PREVENT_SHORT;
+		else
+			delay = IWL_MLD_EMLSR_PREVENT_LONG;
+
+		/*
+		 * The timeouts are chosen so that this will not happen, i.e.
+		 * IWL_MLD_EMLSR_PREVENT_LONG > IWL_MLD_PREVENT_EMLSR_TIMEOUT
+		 */
+		WARN_ON(mld_vif->emlsr.exit_repeat_count > 3);
+	}
+
+	IWL_DEBUG_INFO(mld,
+		       "Preventing EMLSR for %ld seconds due to %u exits with the reason = %s (0x%x)\n",
+		       delay / HZ, mld_vif->emlsr.exit_repeat_count,
+		       iwl_mld_get_emlsr_exit_string(reason), reason);
+
+	wiphy_delayed_work_queue(mld->wiphy,
+				 &mld_vif->emlsr.prevent_done_wk, delay);
+}
+
+static int _iwl_mld_exit_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			       enum iwl_mld_emlsr_exit exit, u8 link_to_keep,
+			       bool sync)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	u16 new_active_links;
+	int ret = 0;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	/* On entry failure need to exit anyway, even if entered from debugfs */
+	if (exit != IWL_MLD_EMLSR_EXIT_FAIL_ENTRY && !IWL_MLD_AUTO_EML_ENABLE)
+		return 0;
+
+	/* Ignore exit request if EMLSR is not active */
+	if (!iwl_mld_emlsr_active(vif))
+		return 0;
+
+	if (WARN_ON(!ieee80211_vif_is_mld(vif) || !mld_vif->authorized))
+		return 0;
+
+	if (WARN_ON(!(vif->active_links & BIT(link_to_keep))))
+		link_to_keep = __ffs(vif->active_links);
+
+	new_active_links = BIT(link_to_keep);
+	IWL_DEBUG_INFO(mld,
+		       "Exiting EMLSR. reason = %s (0x%x). Current active links=0x%x, new active links = 0x%x\n",
+		       iwl_mld_get_emlsr_exit_string(exit), exit,
+		       vif->active_links, new_active_links);
+
+	if (sync)
+		ret = ieee80211_set_active_links(vif, new_active_links);
+	else
+		ieee80211_set_active_links_async(vif, new_active_links);
+
+	/* Update latest exit reason and check EMLSR prevention */
+	iwl_mld_check_emlsr_prevention(mld, mld_vif, exit);
+
+	return ret;
+}
+
+void iwl_mld_exit_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			enum iwl_mld_emlsr_exit exit, u8 link_to_keep)
+{
+	_iwl_mld_exit_emlsr(mld, vif, exit, link_to_keep, false);
+}
+
+static int _iwl_mld_emlsr_block(struct iwl_mld *mld, struct ieee80211_vif *vif,
+				enum iwl_mld_emlsr_blocked reason,
+				u8 link_to_keep, bool sync)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (!IWL_MLD_AUTO_EML_ENABLE || !iwl_mld_vif_has_emlsr_cap(vif))
+		return 0;
+
+	if (mld_vif->emlsr.blocked_reasons & reason)
+		return 0;
+
+	mld_vif->emlsr.blocked_reasons |= reason;
+
+	IWL_DEBUG_INFO(mld,
+		       "Blocking EMLSR mode. reason = %s (0x%x)\n",
+		       iwl_mld_get_emlsr_blocked_string(reason), reason);
+	iwl_mld_print_emlsr_blocked(mld, mld_vif->emlsr.blocked_reasons);
+
+	if (reason == IWL_MLD_EMLSR_BLOCKED_TPT)
+		wiphy_delayed_work_cancel(mld_vif->mld->wiphy,
+					  &mld_vif->emlsr.check_tpt_wk);
+
+	return _iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_BLOCK,
+				   link_to_keep, sync);
+}
+
+void iwl_mld_block_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
+		       enum iwl_mld_emlsr_blocked reason, u8 link_to_keep)
+{
+	_iwl_mld_emlsr_block(mld, vif, reason, link_to_keep, false);
+}
+
+int iwl_mld_block_emlsr_sync(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			   enum iwl_mld_emlsr_blocked reason, u8 link_to_keep)
+{
+	return _iwl_mld_emlsr_block(mld, vif, reason, link_to_keep, true);
+}
+
+static void _iwl_mld_select_links(struct iwl_mld *mld,
+				  struct ieee80211_vif *vif);
+
+void iwl_mld_trigger_link_selection(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif)
+{
+	bool last_scan_was_recent =
+		time_before(jiffies, mld->scan.last_mlo_scan_jiffies +
+				     IWL_MLD_SCAN_EXPIRE_TIME);
+
+	if (last_scan_was_recent) {
+		IWL_DEBUG_EHT(mld, "MLO scan was recent, skip.\n");
+		_iwl_mld_select_links(mld, vif);
+	} else {
+		IWL_DEBUG_EHT(mld, "Doing link selection after MLO scan\n");
+		iwl_mld_int_mlo_scan(mld, vif);
+	}
+}
+
+void iwl_mld_unblock_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			 enum iwl_mld_emlsr_blocked reason)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (!IWL_MLD_AUTO_EML_ENABLE || !iwl_mld_vif_has_emlsr_cap(vif))
+		return;
+
+	if (!(mld_vif->emlsr.blocked_reasons & reason))
+		return;
+
+	mld_vif->emlsr.blocked_reasons &= ~reason;
+
+	IWL_DEBUG_INFO(mld,
+		       "Unblocking EMLSR mode. reason = %s (0x%x)\n",
+		       iwl_mld_get_emlsr_blocked_string(reason), reason);
+	iwl_mld_print_emlsr_blocked(mld, mld_vif->emlsr.blocked_reasons);
+
+	if (reason == IWL_MLD_EMLSR_BLOCKED_TPT)
+		wiphy_delayed_work_queue(mld_vif->mld->wiphy,
+					 &mld_vif->emlsr.check_tpt_wk,
+					 round_jiffies_relative(IWL_MLD_TPT_COUNT_WINDOW));
+
+	if (mld_vif->emlsr.blocked_reasons)
+		return;
+
+	IWL_DEBUG_INFO(mld, "EMLSR is unblocked\n");
+	iwl_mld_trigger_link_selection(mld, vif);
+}
+
+static void
+iwl_mld_vif_iter_emlsr_mode_notif(void *data, u8 *mac,
+				  struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_esr_mode_notif *notif = (void *)data;
+
+	if (!iwl_mld_vif_has_emlsr_cap(vif))
+		return;
+
+	switch (le32_to_cpu(notif->action)) {
+	case ESR_RECOMMEND_ENTER:
+		iwl_mld_unblock_emlsr(mld_vif->mld, vif,
+				      IWL_MLD_EMLSR_BLOCKED_FW);
+		break;
+	case ESR_RECOMMEND_LEAVE:
+		iwl_mld_block_emlsr(mld_vif->mld, vif,
+				    IWL_MLD_EMLSR_BLOCKED_FW,
+				    iwl_mld_get_primary_link(vif));
+		break;
+	case ESR_FORCE_LEAVE:
+	default:
+		/* ESR_FORCE_LEAVE should not happen at this point */
+		IWL_WARN(mld_vif->mld, "Unexpected EMLSR notification: %d\n",
+			 le32_to_cpu(notif->action));
+	}
+}
+
+void iwl_mld_handle_emlsr_mode_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt)
+{
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_vif_iter_emlsr_mode_notif,
+						pkt->data);
+}
+
+static void
+iwl_mld_vif_iter_disconnect_emlsr(void *data, u8 *mac,
+				  struct ieee80211_vif *vif)
+{
+	if (!iwl_mld_vif_has_emlsr_cap(vif))
+		return;
+
+	ieee80211_connection_loss(vif);
+}
+
+void iwl_mld_handle_emlsr_trans_fail_notif(struct iwl_mld *mld,
+					   struct iwl_rx_packet *pkt)
+{
+	const struct iwl_esr_trans_fail_notif *notif = (const void *)pkt->data;
+	u32 fw_link_id = le32_to_cpu(notif->link_id);
+	struct ieee80211_bss_conf *bss_conf =
+		iwl_mld_fw_id_to_link_conf(mld, fw_link_id);
+
+	IWL_DEBUG_INFO(mld, "Failed to %s EMLSR on link %d (FW: %d), reason %d\n",
+		       le32_to_cpu(notif->activation) ? "enter" : "exit",
+		       bss_conf ? bss_conf->link_id : -1,
+		       le32_to_cpu(notif->link_id),
+		       le32_to_cpu(notif->err_code));
+
+	if (IWL_FW_CHECK(mld, !bss_conf,
+			 "FW reported failure to %sactivate EMLSR on a non-existing link: %d\n",
+			 le32_to_cpu(notif->activation) ? "" : "de",
+			 fw_link_id)) {
+		ieee80211_iterate_active_interfaces_mtx(
+			mld->hw, IEEE80211_IFACE_ITER_NORMAL,
+			iwl_mld_vif_iter_disconnect_emlsr, NULL);
+		return;
+	}
+
+	/* Disconnect if we failed to deactivate a link */
+	if (!le32_to_cpu(notif->activation)) {
+		ieee80211_connection_loss(bss_conf->vif);
+		return;
+	}
+
+	/*
+	 * We failed to activate the second link, go back to the link specified
+	 * by the firmware as that is the one that is still valid now.
+	 */
+	iwl_mld_exit_emlsr(mld, bss_conf->vif, IWL_MLD_EMLSR_EXIT_FAIL_ENTRY,
+			   bss_conf->link_id);
+}
+
+/* Active non-station link tracking */
+static void iwl_mld_count_non_bss_links(void *_data, u8 *mac,
+					struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int *count = _data;
+
+	if (ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_STATION)
+		return;
+
+	*count += iwl_mld_count_active_links(mld_vif->mld, vif);
+}
+
+struct iwl_mld_update_emlsr_block_data {
+	bool block;
+	int result;
+};
+
+static void iwl_mld_vif_iter_update_emlsr_non_bss_block(void *_data, u8 *mac,
+						       struct ieee80211_vif *vif)
+{
+	struct iwl_mld_update_emlsr_block_data *data = _data;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int ret;
+
+	if (data->block) {
+		ret = iwl_mld_block_emlsr_sync(mld_vif->mld, vif,
+					       IWL_MLD_EMLSR_BLOCKED_NON_BSS,
+					       iwl_mld_get_primary_link(vif));
+		if (ret)
+			data->result = ret;
+	} else {
+		iwl_mld_unblock_emlsr(mld_vif->mld, vif,
+				      IWL_MLD_EMLSR_BLOCKED_NON_BSS);
+	}
+}
+
+int iwl_mld_emlsr_check_non_bss_block(struct iwl_mld *mld,
+				      int pending_link_changes)
+{
+	/* An active link of a non-station vif blocks EMLSR. Upon activation
+	 * block EMLSR on the bss vif. Upon deactivation, check if this link
+	 * was the last non-station link active, and if so unblock the bss vif
+	 */
+	struct iwl_mld_update_emlsr_block_data block_data = {};
+	int count = pending_link_changes;
+
+	/* No need to count if we are activating a non-BSS link */
+	if (count <= 0)
+		ieee80211_iterate_active_interfaces_mtx(mld->hw,
+							IEEE80211_IFACE_ITER_NORMAL,
+							iwl_mld_count_non_bss_links,
+							&count);
+
+	/*
+	 * We could skip updating it if the block change did not change (and
+	 * pending_link_changes is non-zero).
+	 */
+	block_data.block = !!count;
+
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_vif_iter_update_emlsr_non_bss_block,
+						&block_data);
+
+	return block_data.result;
+}
+
+#define EMLSR_SEC_LINK_MIN_PERC 10
+#define EMLSR_MIN_TX 3000
+#define EMLSR_MIN_RX 400
+
+void iwl_mld_emlsr_check_tpt(struct wiphy *wiphy, struct wiphy_work *wk)
+{
+	struct iwl_mld_vif *mld_vif = container_of(wk, struct iwl_mld_vif,
+						   emlsr.check_tpt_wk.work);
+	struct ieee80211_vif *vif =
+		container_of((void *)mld_vif, struct ieee80211_vif, drv_priv);
+	struct iwl_mld *mld = mld_vif->mld;
+	struct iwl_mld_sta *mld_sta;
+	struct iwl_mld_link *sec_link;
+	unsigned long total_tx = 0, total_rx = 0;
+	unsigned long sec_link_tx = 0, sec_link_rx = 0;
+	u8 sec_link_tx_perc, sec_link_rx_perc;
+	s8 sec_link_id;
+
+	if (!iwl_mld_vif_has_emlsr_cap(vif) || !mld_vif->ap_sta)
+		return;
+
+	mld_sta = iwl_mld_sta_from_mac80211(mld_vif->ap_sta);
+
+	/* We only count for the AP sta in a MLO connection */
+	if (!mld_sta->mpdu_counters)
+		return;
+
+	/* This wk should only run when the TPT blocker isn't set.
+	 * When the blocker is set, the decision to remove it, as well as
+	 * clearing the counters is done in DP (to avoid having a wk every
+	 * 5 seconds when idle. When the blocker is unset, we are not idle anyway)
+	 */
+	if (WARN_ON(mld_vif->emlsr.blocked_reasons & IWL_MLD_EMLSR_BLOCKED_TPT))
+		return;
+	/*
+	 * TPT is unblocked, need to check if the TPT criteria is still met.
+	 *
+	 * If EMLSR is active, then we also need to check the secondar link
+	 * requirements.
+	 */
+	if (iwl_mld_emlsr_active(vif)) {
+		sec_link_id = iwl_mld_get_other_link(vif, iwl_mld_get_primary_link(vif));
+		sec_link = iwl_mld_link_dereference_check(mld_vif, sec_link_id);
+		if (WARN_ON_ONCE(!sec_link))
+			return;
+		/* We need the FW ID here */
+		sec_link_id = sec_link->fw_id;
+	} else {
+		sec_link_id = -1;
+	}
+
+	/* Sum up RX and TX MPDUs from the different queues/links */
+	for (int q = 0; q < mld->trans->num_rx_queues; q++) {
+		struct iwl_mld_per_q_mpdu_counter *queue_counter =
+			&mld_sta->mpdu_counters[q];
+
+		spin_lock_bh(&queue_counter->lock);
+
+		/* The link IDs that doesn't exist will contain 0 */
+		for (int link = 0;
+		     link < ARRAY_SIZE(queue_counter->per_link);
+		     link++) {
+			total_tx += queue_counter->per_link[link].tx;
+			total_rx += queue_counter->per_link[link].rx;
+		}
+
+		if (sec_link_id != -1) {
+			sec_link_tx += queue_counter->per_link[sec_link_id].tx;
+			sec_link_rx += queue_counter->per_link[sec_link_id].rx;
+		}
+
+		memset(queue_counter->per_link, 0,
+		       sizeof(queue_counter->per_link));
+
+		spin_unlock_bh(&queue_counter->lock);
+	}
+
+	IWL_DEBUG_INFO(mld, "total Tx MPDUs: %ld. total Rx MPDUs: %ld\n",
+		       total_tx, total_rx);
+
+	/* If we don't have enough MPDUs - exit EMLSR */
+	if (total_tx < IWL_MLD_ENTER_EMLSR_TPT_THRESH &&
+	    total_rx < IWL_MLD_ENTER_EMLSR_TPT_THRESH) {
+		iwl_mld_block_emlsr(mld, vif, IWL_MLD_EMLSR_BLOCKED_TPT,
+				    iwl_mld_get_primary_link(vif));
+		return;
+	}
+
+	/* EMLSR is not active */
+	if (sec_link_id == -1)
+		return;
+
+	IWL_DEBUG_INFO(mld, "Secondary Link %d: Tx MPDUs: %ld. Rx MPDUs: %ld\n",
+		       sec_link_id, sec_link_tx, sec_link_rx);
+
+	/* Calculate the percentage of the secondary link TX/RX */
+	sec_link_tx_perc = total_tx ? sec_link_tx * 100 / total_tx : 0;
+	sec_link_rx_perc = total_rx ? sec_link_rx * 100 / total_rx : 0;
+
+	/*
+	 * The TX/RX percentage is checked only if it exceeds the required
+	 * minimum. In addition, RX is checked only if the TX check failed.
+	 */
+	if ((total_tx > EMLSR_MIN_TX &&
+	     sec_link_tx_perc < EMLSR_SEC_LINK_MIN_PERC) ||
+	    (total_rx > EMLSR_MIN_RX &&
+	     sec_link_rx_perc < EMLSR_SEC_LINK_MIN_PERC)) {
+		iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_LINK_USAGE,
+				   iwl_mld_get_primary_link(vif));
+		return;
+	}
+
+	/* Check again when the next window ends  */
+	wiphy_delayed_work_queue(mld_vif->mld->wiphy,
+				 &mld_vif->emlsr.check_tpt_wk,
+				 round_jiffies_relative(IWL_MLD_TPT_COUNT_WINDOW));
+}
+
+void iwl_mld_emlsr_unblock_tpt_wk(struct wiphy *wiphy, struct wiphy_work *wk)
+{
+	struct iwl_mld_vif *mld_vif = container_of(wk, struct iwl_mld_vif,
+						   emlsr.unblock_tpt_wk);
+	struct ieee80211_vif *vif =
+		container_of((void *)mld_vif, struct ieee80211_vif, drv_priv);
+
+	iwl_mld_unblock_emlsr(mld_vif->mld, vif, IWL_MLD_EMLSR_BLOCKED_TPT);
+}
+
+/*
+ * Link selection
+ */
+struct iwl_mld_link_sel_data {
+	u8 link_id;
+	const struct cfg80211_chan_def *chandef;
+	s32 signal;
+	u16 grade;
+};
+
+s8 iwl_mld_get_emlsr_rssi_thresh(struct iwl_mld *mld,
+				 const struct cfg80211_chan_def *chandef,
+				 bool low)
+{
+	if (WARN_ON(chandef->chan->band != NL80211_BAND_2GHZ &&
+		    chandef->chan->band != NL80211_BAND_5GHZ &&
+		    chandef->chan->band != NL80211_BAND_6GHZ))
+		return S8_MAX;
+
+#define RSSI_THRESHOLD(_low, _bw)			\
+	(_low) ? IWL_MLD_LOW_RSSI_THRESH_##_bw##MHZ	\
+	       : IWL_MLD_HIGH_RSSI_THRESH_##_bw##MHZ
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_20_NOHT:
+	case NL80211_CHAN_WIDTH_20:
+	/* 320 MHz has the same thresholds as 20 MHz */
+	case NL80211_CHAN_WIDTH_320:
+		return RSSI_THRESHOLD(low, 20);
+	case NL80211_CHAN_WIDTH_40:
+		return RSSI_THRESHOLD(low, 40);
+	case NL80211_CHAN_WIDTH_80:
+		return RSSI_THRESHOLD(low, 80);
+	case NL80211_CHAN_WIDTH_160:
+		return RSSI_THRESHOLD(low, 160);
+	default:
+		WARN_ON(1);
+		return S8_MAX;
+	}
+#undef RSSI_THRESHOLD
+}
+
+static u32
+iwl_mld_emlsr_disallowed_with_link(struct iwl_mld *mld,
+				   struct ieee80211_vif *vif,
+				   struct iwl_mld_link_sel_data *link,
+				   bool primary)
+{
+	struct wiphy *wiphy = mld->wiphy;
+	struct ieee80211_bss_conf *conf;
+	enum iwl_mld_emlsr_exit ret = 0;
+
+	conf = wiphy_dereference(wiphy, vif->link_conf[link->link_id]);
+	if (WARN_ON_ONCE(!conf))
+		return false;
+
+	if (link->chandef->chan->band == NL80211_BAND_2GHZ && mld->bt_is_active)
+		ret |= IWL_MLD_EMLSR_EXIT_BT_COEX;
+
+	if (link->signal <
+	    iwl_mld_get_emlsr_rssi_thresh(mld, link->chandef, false))
+		ret |= IWL_MLD_EMLSR_EXIT_LOW_RSSI;
+
+	if (conf->csa_active)
+		ret |= IWL_MLD_EMLSR_EXIT_CSA;
+
+	if (ret) {
+		IWL_DEBUG_INFO(mld,
+			       "Link %d is not allowed for EMLSR as %s\n",
+			       link->link_id,
+			       primary ? "primary" : "secondary");
+		iwl_mld_print_emlsr_exit(mld, ret);
+	}
+
+	return ret;
+}
+
+static u8
+iwl_mld_set_link_sel_data(struct iwl_mld *mld,
+			  struct ieee80211_vif *vif,
+			  struct iwl_mld_link_sel_data *data,
+			  unsigned long usable_links,
+			  u8 *best_link_idx)
+{
+	u8 n_data = 0;
+	u16 max_grade = 0;
+	unsigned long link_id;
+
+	/*
+	 * TODO: don't select links that weren't discovered in the last scan
+	 * This requires mac80211 (or cfg80211) changes to forward/track when
+	 * a BSS was last updated. cfg80211 already tracks this information but
+	 * it is not exposed within the kernel.
+	 */
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf =
+			link_conf_dereference_protected(vif, link_id);
+
+		if (WARN_ON_ONCE(!link_conf))
+			continue;
+
+		/* Ignore any BSS that was not seen in the last 5 seconds */
+		if (ktime_before(link_conf->bss->ts_boottime,
+				 ktime_sub_ns(ktime_get_boottime_ns(),
+					      (u64)5 * NSEC_PER_SEC)))
+			continue;
+
+		data[n_data].link_id = link_id;
+		data[n_data].chandef = &link_conf->chanreq.oper;
+		data[n_data].signal = MBM_TO_DBM(link_conf->bss->signal);
+		data[n_data].grade = iwl_mld_get_link_grade(mld, link_conf);
+
+		if (n_data == 0 || data[n_data].grade > max_grade) {
+			max_grade = data[n_data].grade;
+			*best_link_idx = n_data;
+		}
+		n_data++;
+	}
+
+	return n_data;
+}
+
+static bool
+iwl_mld_valid_emlsr_pair(struct ieee80211_vif *vif,
+			 struct iwl_mld_link_sel_data *a,
+			 struct iwl_mld_link_sel_data *b)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld *mld = mld_vif->mld;
+	enum iwl_mld_emlsr_exit ret = 0;
+
+	/* Per-link considerations */
+	if (iwl_mld_emlsr_disallowed_with_link(mld, vif, a, true) ||
+	    iwl_mld_emlsr_disallowed_with_link(mld, vif, b, false))
+		return false;
+
+	if (a->chandef->chan->band == b->chandef->chan->band) {
+		ret |= IWL_MLD_EMLSR_EXIT_EQUAL_BAND;
+	} else if (a->chandef->width != b->chandef->width) {
+		/* TODO: task=EMLSR task=statistics
+		 * replace BANDWIDTH exit reason with channel load criteria
+		 */
+		ret |= IWL_MLD_EMLSR_EXIT_BANDWIDTH;
+	}
+
+	if (ret) {
+		IWL_DEBUG_INFO(mld,
+			       "Links %d and %d are not a valid pair for EMLSR\n",
+			       a->link_id, b->link_id);
+		IWL_DEBUG_INFO(mld,
+			       "Links bandwidth are: %d and %d\n",
+			       nl80211_chan_width_to_mhz(a->chandef->width),
+			       nl80211_chan_width_to_mhz(b->chandef->width));
+		iwl_mld_print_emlsr_exit(mld, ret);
+		return false;
+	}
+
+	return true;
+}
+
+/* Calculation is done with fixed-point with a scaling factor of 1/256 */
+#define SCALE_FACTOR 256
+
+/*
+ * Returns the combined grade of two given links.
+ * Returns 0 if EMLSR is not allowed with these 2 links.
+ */
+static
+unsigned int iwl_mld_get_emlsr_grade(struct iwl_mld *mld,
+				     struct ieee80211_vif *vif,
+				     struct iwl_mld_link_sel_data *a,
+				     struct iwl_mld_link_sel_data *b,
+				     u8 *primary_id)
+{
+	struct ieee80211_bss_conf *primary_conf;
+	struct wiphy *wiphy = ieee80211_vif_to_wdev(vif)->wiphy;
+	unsigned int primary_load;
+
+	lockdep_assert_wiphy(wiphy);
+
+	/* a is always primary, b is always secondary */
+	if (b->grade > a->grade)
+		swap(a, b);
+
+	*primary_id = a->link_id;
+
+	if (!iwl_mld_valid_emlsr_pair(vif, a, b))
+		return 0;
+
+	primary_conf = wiphy_dereference(wiphy, vif->link_conf[*primary_id]);
+
+	if (WARN_ON_ONCE(!primary_conf))
+		return 0;
+
+	primary_load = iwl_mld_get_chan_load(mld, primary_conf);
+
+	/* The more the primary link is loaded, the more worthwhile EMLSR becomes */
+	return a->grade + ((b->grade * primary_load) / SCALE_FACTOR);
+}
+
+static void _iwl_mld_select_links(struct iwl_mld *mld,
+				  struct ieee80211_vif *vif)
+{
+	struct iwl_mld_link_sel_data data[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct iwl_mld_link_sel_data *best_link;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int max_active_links = iwl_mld_max_active_links(mld, vif);
+	u16 new_active, usable_links = ieee80211_vif_usable_links(vif);
+	u8 best_idx, new_primary, n_data;
+	u16 max_grade;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (!mld_vif->authorized || hweight16(usable_links) <= 1)
+		return;
+
+	if (WARN(time_before(mld->scan.last_mlo_scan_jiffies,
+			     jiffies - IWL_MLD_SCAN_EXPIRE_TIME),
+		"Last MLO scan was too long ago, can't select links\n"))
+		return;
+
+	/* The logic below is simple and not suited for more than 2 links */
+	WARN_ON_ONCE(max_active_links > 2);
+
+	n_data = iwl_mld_set_link_sel_data(mld, vif, data, usable_links,
+					   &best_idx);
+
+	if (WARN(!n_data, "Couldn't find a valid grade for any link!\n"))
+		return;
+
+	/* Default to selecting the single best link */
+	best_link = &data[best_idx];
+	new_primary = best_link->link_id;
+	new_active = BIT(best_link->link_id);
+	max_grade = best_link->grade;
+
+	/* If EMLSR is not possible, activate the best link */
+	if (max_active_links == 1 || n_data == 1 ||
+	    !iwl_mld_vif_has_emlsr_cap(vif) || !IWL_MLD_AUTO_EML_ENABLE ||
+	    mld_vif->emlsr.blocked_reasons)
+		goto set_active;
+
+	/* Try to find the best link combination */
+	for (u8 a = 0; a < n_data; a++) {
+		for (u8 b = a + 1; b < n_data; b++) {
+			u8 best_in_pair;
+			u16 emlsr_grade =
+				iwl_mld_get_emlsr_grade(mld, vif,
+							&data[a], &data[b],
+							&best_in_pair);
+
+			/*
+			 * Prefer (new) EMLSR combination to prefer EMLSR over
+			 * a single link.
+			 */
+			if (emlsr_grade < max_grade)
+				continue;
+
+			max_grade = emlsr_grade;
+			new_primary = best_in_pair;
+			new_active = BIT(data[a].link_id) |
+				     BIT(data[b].link_id);
+		}
+	}
+
+set_active:
+	IWL_DEBUG_INFO(mld, "Link selection result: 0x%x. Primary = %d\n",
+		       new_active, new_primary);
+
+	mld_vif->emlsr.selected_primary = new_primary;
+	mld_vif->emlsr.selected_links = new_active;
+
+	ieee80211_set_active_links_async(vif, new_active);
+}
+
+static void iwl_mld_vif_iter_select_links(void *_data, u8 *mac,
+					   struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld *mld = mld_vif->mld;
+
+	_iwl_mld_select_links(mld, vif);
+}
+
+void iwl_mld_select_links(struct iwl_mld *mld)
+{
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_vif_iter_select_links,
+						NULL);
+}
+
+void iwl_mld_emlsr_check_equal_bw(struct iwl_mld *mld,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_bss_conf *link)
+{
+	u8 other_link_id = iwl_mld_get_other_link(vif, link->link_id);
+	struct ieee80211_bss_conf *other_link =
+		link_conf_dereference_check(vif, other_link_id);
+
+	if (!ieee80211_vif_link_active(vif, link->link_id) ||
+	    !iwl_mld_emlsr_active(vif) ||
+	    WARN_ON(link->link_id == other_link_id || !other_link))
+		return;
+
+	if (link->chanreq.oper.width != other_link->chanreq.oper.width)
+		iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_BANDWIDTH,
+				   iwl_mld_get_primary_link(vif));
+}
+
+static void iwl_mld_emlsr_check_bt_iter(void *_data, u8 *mac,
+					struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld *mld = mld_vif->mld;
+	struct ieee80211_bss_conf *link;
+	unsigned int link_id;
+
+	if (!mld->bt_is_active) {
+		iwl_mld_retry_emlsr(mld, vif);
+		return;
+	}
+
+	/* BT is turned ON but we are not in EMLSR, nothing to do */
+	if (!iwl_mld_emlsr_active(vif))
+		return;
+
+	/* In EMLSR and BT is turned ON */
+
+	for_each_vif_active_link(vif, link, link_id) {
+		if (WARN_ON(!link->chanreq.oper.chan))
+			continue;
+
+		if (link->chanreq.oper.chan->band == NL80211_BAND_2GHZ) {
+			iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_BT_COEX,
+					   iwl_mld_get_primary_link(vif));
+			return;
+		}
+	}
+}
+
+void iwl_mld_emlsr_check_bt(struct iwl_mld *mld)
+{
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_emlsr_check_bt_iter,
+						NULL);
+}
+
+static void iwl_mld_emlsr_check_chan_load_iter(void *_data, u8 *mac,
+					       struct ieee80211_vif *vif)
+{
+	struct iwl_mld *mld = (struct iwl_mld *)_data;
+	struct ieee80211_bss_conf *prim_link;
+	unsigned int prim_link_id;
+	int chan_load;
+
+	if (!iwl_mld_emlsr_active(vif))
+		return;
+
+	prim_link_id = iwl_mld_get_primary_link(vif);
+	prim_link = link_conf_dereference_protected(vif, prim_link_id);
+	if (WARN_ON(!prim_link))
+		return;
+
+	chan_load = iwl_mld_get_chan_load_by_others(mld, prim_link, true);
+
+	if (chan_load < 0)
+		return;
+
+	/* chan_load is in range [0,255] */
+	if (chan_load < NORMALIZE_PERCENT_TO_255(IWL_MLD_CHAN_LOAD_THRESH))
+		iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_CHAN_LOAD,
+				   prim_link_id);
+}
+
+void iwl_mld_emlsr_check_chan_load(struct iwl_mld *mld)
+{
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+					       IEEE80211_IFACE_ITER_NORMAL,
+					       iwl_mld_emlsr_check_chan_load_iter,
+					       (void *)(uintptr_t)mld);
+}
+
+void iwl_mld_retry_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	if (!iwl_mld_vif_has_emlsr_cap(vif) || iwl_mld_emlsr_active(vif) ||
+	    mld_vif->emlsr.blocked_reasons)
+		return;
+
+	iwl_mld_trigger_link_selection(mld, vif);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
new file mode 100644
index 000000000000..56f9f0e4a75e
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#ifndef __iwl_mld_mlo_h__
+#define __iwl_mld_mlo_h__
+
+#include <linux/ieee80211.h>
+#include <linux/types.h>
+#include <net/mac80211.h>
+#include "iwl-config.h"
+#include "iwl-trans.h"
+#include "iface.h"
+
+struct iwl_mld;
+
+void iwl_mld_emlsr_prevent_done_wk(struct wiphy *wiphy, struct wiphy_work *wk);
+void iwl_mld_emlsr_tmp_non_bss_done_wk(struct wiphy *wiphy,
+				       struct wiphy_work *wk);
+
+static inline bool iwl_mld_emlsr_active(struct ieee80211_vif *vif)
+{
+	/* Set on phy context activation, so should be a good proxy */
+	return !!(vif->driver_flags & IEEE80211_VIF_EML_ACTIVE);
+}
+
+static inline bool iwl_mld_vif_has_emlsr_cap(struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	/* We only track/permit EMLSR state once authorized */
+	if (!mld_vif->authorized)
+		return false;
+
+	/* No EMLSR on dual radio devices */
+	return ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_STATION &&
+	       ieee80211_vif_is_mld(vif) &&
+	       vif->cfg.eml_cap & IEEE80211_EML_CAP_EMLSR_SUPP &&
+	       !CSR_HW_RFID_IS_CDB(mld_vif->mld->trans->hw_rf_id);
+}
+
+static inline int
+iwl_mld_max_active_links(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	if (vif->type == NL80211_IFTYPE_AP)
+		return mld->fw->ucode_capa.num_beacons;
+
+	if (ieee80211_vif_type_p2p(vif) == NL80211_IFTYPE_STATION)
+		return IWL_FW_MAX_ACTIVE_LINKS_NUM;
+
+	/* For now, do not accept more links on other interface types */
+	return 1;
+}
+
+static inline int
+iwl_mld_count_active_links(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_link *mld_link;
+	int n_active = 0;
+
+	for_each_mld_vif_valid_link(mld_vif, mld_link) {
+		if (rcu_access_pointer(mld_link->chan_ctx))
+			n_active++;
+	}
+
+	return n_active;
+}
+
+static inline u8 iwl_mld_get_primary_link(struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	lockdep_assert_wiphy(mld_vif->mld->wiphy);
+
+	if (!ieee80211_vif_is_mld(vif) || WARN_ON(!vif->active_links))
+		return 0;
+
+	/* In AP mode, there is no primary link */
+	if (vif->type == NL80211_IFTYPE_AP)
+		return __ffs(vif->active_links);
+
+	if (iwl_mld_emlsr_active(vif) &&
+	    !WARN_ON(!(BIT(mld_vif->emlsr.primary) & vif->active_links)))
+		return mld_vif->emlsr.primary;
+
+	return __ffs(vif->active_links);
+}
+
+/*
+ * For non-MLO/single link, this will return the deflink/single active link,
+ * respectively
+ */
+static inline u8 iwl_mld_get_other_link(struct ieee80211_vif *vif, u8 link_id)
+{
+	switch (hweight16(vif->active_links)) {
+	case 0:
+		return 0;
+	default:
+		WARN_ON(1);
+		fallthrough;
+	case 1:
+		return __ffs(vif->active_links);
+	case 2:
+		return __ffs(vif->active_links & ~BIT(link_id));
+	}
+}
+
+s8 iwl_mld_get_emlsr_rssi_thresh(struct iwl_mld *mld,
+				 const struct cfg80211_chan_def *chandef,
+				 bool low);
+
+/* EMLSR block/unblock and exit */
+void iwl_mld_block_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			 enum iwl_mld_emlsr_blocked reason, u8 link_to_keep);
+int iwl_mld_block_emlsr_sync(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			     enum iwl_mld_emlsr_blocked reason, u8 link_to_keep);
+void iwl_mld_unblock_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			   enum iwl_mld_emlsr_blocked reason);
+void iwl_mld_exit_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			enum iwl_mld_emlsr_exit exit, u8 link_to_keep);
+
+int iwl_mld_emlsr_check_non_bss_block(struct iwl_mld *mld,
+				      int pending_link_changes);
+
+void iwl_mld_handle_emlsr_mode_notif(struct iwl_mld *mld,
+				     struct iwl_rx_packet *pkt);
+void iwl_mld_handle_emlsr_trans_fail_notif(struct iwl_mld *mld,
+					   struct iwl_rx_packet *pkt);
+
+void iwl_mld_emlsr_check_tpt(struct wiphy *wiphy, struct wiphy_work *wk);
+void iwl_mld_emlsr_unblock_tpt_wk(struct wiphy *wiphy, struct wiphy_work *wk);
+
+void iwl_mld_select_links(struct iwl_mld *mld);
+
+void iwl_mld_emlsr_check_equal_bw(struct iwl_mld *mld,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_bss_conf *link);
+
+void iwl_mld_emlsr_check_bt(struct iwl_mld *mld);
+
+void iwl_mld_emlsr_check_chan_load(struct iwl_mld *mld);
+
+void iwl_mld_trigger_link_selection(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif);
+
+/**
+ * iwl_mld_retry_emlsr - Retry entering EMLSR
+ * @mld: MLD context
+ * @vif: VIF to retry EMLSR on
+ *
+ * Retry entering EMLSR on the given VIF.
+ * Use this if one of the parameters that can prevent EMLSR has changed.
+ */
+void iwl_mld_retry_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif);
+
+#endif /* __iwl_mld_mlo_h__ */
-- 
2.34.1


