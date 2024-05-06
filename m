Return-Path: <linux-wireless+bounces-7209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1E48BC80B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F909B217E8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE36784DFA;
	Mon,  6 May 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdbDsCHA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD847D06E
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979105; cv=none; b=BCt1JNS+UGS4mJfUD+iJZ6tpM9SgqE8bW6GsX94SR8NqBfERUZY2at+t50YmA2dXf0LmHAeS5ZNkQgonJvkg4ndYyfPWzRxjDbPoXvmmv9A4tniME5RzyzBPecZ4q+YbKshjncRxC8CyNtqR5a3ZEMMrVSzs9ZI8vDbrneQfQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979105; c=relaxed/simple;
	bh=ugG6CR6kXKPeohpjZd46oi+5QmHPp68lpjv2CKY87Os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=av51ih9PbOXY6sm1go6r+d6GyHJ9xUTXv1OKvbwm2KzvE8l4VsrGmWE+SRNmOqxFGgDlPUe+Z/48uvP5ORwbw4Wj7xLtMOAF0s6Y9al/LM0QIyQnq80Sj933+faIL/NJgv1y0CO3IbGn83oO+ifHDfynLk4aERFy/69rU/q4jlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdbDsCHA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979105; x=1746515105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ugG6CR6kXKPeohpjZd46oi+5QmHPp68lpjv2CKY87Os=;
  b=ZdbDsCHAusP42+EJ6FuHSGkcjKM+GklZ8GrQ1++c/1hwkkthK0SmdBZ3
   NHZRda9ufCdtvBsnlPbQqJ6K4YtMvnsnJGaTBu/Y2hqQN9+Rfk20AmeRY
   gtlZIlT/4AodsNln89z0swB3jrHA1IkqMqXXdSK5TEzW8Ff9Iuyewtksc
   jloFy2enLUmDfdFApJfmoyXTzD9YRGuH1BQBypaFp/3BjW/wxxz/PnS1j
   T5h5jVyz3p0//vhQPTUpXdSP0cXroZxym1uCqSmSU57r2QhxzKy+NVCQo
   I/ph99DlCO4bVCWoY3gInNajZZQls9fUnbyHU8e+5fZ7vhc6zFUofNOzv
   Q==;
X-CSE-ConnectionGUID: VWMGHNeJQOSaenQWkH6ZwQ==
X-CSE-MsgGUID: jtI65bg4Q2uevUMcgfLN6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638255"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638255"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:51 -0700
X-CSE-ConnectionGUID: ztRjRzwiQC2+Rdg8XPM2fA==
X-CSE-MsgGUID: my3XMPq3SU2UTYhY1y9RHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264998"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: exit EMLSR if secondary link is not used
Date: Mon,  6 May 2024 10:04:17 +0300
Message-Id: <20240506095953.99ad1d71e9b9.Ide825433488ec809773efdc36937e3089d0012df@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Exit EMLSR mode if the secondary link is not used enough for Rx/Tx

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 37 ++++++++++++++++++-
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index b0568c74a15b..b4ba5f81f20c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -15,7 +15,8 @@
 	HOW(EXIT_LOW_RSSI)		\
 	HOW(EXIT_COEX)			\
 	HOW(EXIT_BANDWIDTH)		\
-	HOW(EXIT_CSA)
+	HOW(EXIT_CSA)			\
+	HOW(EXIT_LINK_USAGE)
 
 static const char *const iwl_mvm_esr_states_names[] = {
 #define NAME_ENTRY(x) [ilog2(IWL_MVM_ESR_##x)] = #x,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b96568f5640c..1f58c727fa63 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -369,6 +369,7 @@ struct iwl_mvm_vif_link_info {
  * @IWL_MVM_ESR_EXIT_BANDWIDTH: Bandwidths of primary and secondry links
  *	preventing the enablement of EMLSR
  * @IWL_MVM_ESR_EXIT_CSA: CSA happened, so exit EMLSR
+ * @IWL_MVM_ESR_EXIT_LINK_USAGE: Exit EMLSR due to low tpt on secondary link
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
@@ -381,6 +382,7 @@ enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_EXIT_COEX		= 0x40000,
 	IWL_MVM_ESR_EXIT_BANDWIDTH	= 0x80000,
 	IWL_MVM_ESR_EXIT_CSA		= 0x100000,
+	IWL_MVM_ESR_EXIT_LINK_USAGE	= 0x200000,
 };
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 36083905457b..4fa8066a89b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -951,12 +951,19 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 	}
 }
 
+#define SEC_LINK_MIN_PERC 10
+#define SEC_LINK_MIN_TX 3000
+#define SEC_LINK_MIN_RX 400
+
 static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 {
 	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
 	struct iwl_mvm_vif *mvmvif;
 	struct iwl_mvm_sta *mvmsta;
 	unsigned long total_tx = 0, total_rx = 0;
+	unsigned long sec_link_tx = 0, sec_link_rx = 0;
+	u8 sec_link_tx_perc, sec_link_rx_perc;
+	u8 sec_link;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -973,6 +980,13 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 	if (!mvmsta->mpdu_counters)
 		return;
 
+	/* Get the FW ID of the secondary link */
+	sec_link = iwl_mvm_get_other_link(bss_vif,
+					  iwl_mvm_get_primary_link(bss_vif));
+	if (WARN_ON(!mvmvif->link[sec_link]))
+		return;
+	sec_link = mvmvif->link[sec_link]->fw_link_id;
+
 	/* Sum up RX and TX MPDUs from the different queues/links */
 	for (int q = 0; q < mvm->trans->num_rx_queues; q++) {
 		spin_lock_bh(&mvmsta->mpdu_counters[q].lock);
@@ -982,6 +996,10 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 			total_tx += mvmsta->mpdu_counters[q].per_link[link].tx;
 			total_rx += mvmsta->mpdu_counters[q].per_link[link].rx;
 		}
+
+		sec_link_tx += mvmsta->mpdu_counters[q].per_link[sec_link].tx;
+		sec_link_rx += mvmsta->mpdu_counters[q].per_link[sec_link].rx;
+
 		/*
 		 * In EMLSR we have statistics every 5 seconds, so we can reset
 		 * the counters upon every statistics notification.
@@ -994,9 +1012,26 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 
 	/* If we don't have enough MPDUs - exit EMLSR */
 	if (total_tx < IWL_MVM_ENTER_ESR_TPT_THRESH &&
-	    total_rx < IWL_MVM_ENTER_ESR_TPT_THRESH)
+	    total_rx < IWL_MVM_ENTER_ESR_TPT_THRESH) {
 		iwl_mvm_block_esr(mvm, bss_vif, IWL_MVM_ESR_BLOCKED_TPT,
 				  iwl_mvm_get_primary_link(bss_vif));
+		return;
+	}
+
+	/* Calculate the percentage of the secondary link TX/RX */
+	sec_link_tx_perc = total_tx ? sec_link_tx * 100 / total_tx : 0;
+	sec_link_rx_perc = total_rx ? sec_link_rx * 100 / total_rx : 0;
+
+	/*
+	 * The TX/RX percentage is checked only if it exceeds the required
+	 * minimum. In addition, RX is checked only if the TX check failed.
+	 */
+	if ((total_tx > SEC_LINK_MIN_TX &&
+	     sec_link_tx_perc < SEC_LINK_MIN_PERC) ||
+	    (total_rx > SEC_LINK_MIN_RX &&
+	     sec_link_rx_perc < SEC_LINK_MIN_PERC))
+		iwl_mvm_exit_esr(mvm, bss_vif, IWL_MVM_ESR_EXIT_LINK_USAGE,
+				 iwl_mvm_get_primary_link(bss_vif));
 }
 
 void iwl_mvm_handle_rx_system_oper_stats(struct iwl_mvm *mvm,
-- 
2.34.1


