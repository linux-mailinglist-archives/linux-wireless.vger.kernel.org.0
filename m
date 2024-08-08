Return-Path: <linux-wireless+bounces-11144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F76A94C5A5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30597288A20
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1079715B986;
	Thu,  8 Aug 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwyGSqXW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6F3158D7F
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148596; cv=none; b=ktm8x9Sdt11FI/WBHobTKQ5o0oIXgGnKKf5l6gcH2zrMKn9Mi1TzMQJVtRjloC7YEW3Tni6J3ZERo4RXJsl9q9LaYCZI+d+88U+rBfc25KG2fAOVXULGI+4QqWcgBQ7FkM8yf2oKxxJakMxSpnV5MeUgGQqTaRKx/rjsi0d/kfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148596; c=relaxed/simple;
	bh=/49CYzd6N7ZY004PiipnuHZImv81GXobqQf9XWe48/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rm6/a/4gXZBJnba1d8gigyg0nAZE3LmnQWL1eeq8YUHWNw+THG5tcdRFiFCkMw9gK+s01/AKhasBynevgXpt/AcL/mYpZkeZSp3PttLjNFnA65nlMUSB26idKqdsUHRujJtfUcUhcn+CqcpILWE3uJwt9nI73yoox8ZiCKpbHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwyGSqXW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148595; x=1754684595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/49CYzd6N7ZY004PiipnuHZImv81GXobqQf9XWe48/o=;
  b=gwyGSqXWQcaN8jsGZTxn/DwwX+q8G47omHnUs7a79g8b3AxqMU60mON7
   owL3jVgBED1xbwHdKVUMJwh8b5egZW+vlenJTsSlqxLiqA2n9Z61bwcbF
   OWCF8QRXLVo5aV87+8mO/oZL4ArtNsLYeQ1cEv6RiohkKP3LWNkoUcXLR
   NEVhYK/Ji7Lqeq1YdAlp6MDyZ/NQHYkG/5CoK/UJCts1AH9mHlsUPx2N1
   3h2IJOccin1Ohs0w3CA2IDJEjXfMBea/Gdc7RLxoCezPCgLueH+leWhQo
   V60ADWOx4Rt7r0Q5TVos6ibaqAaqrCRLpvFUsADne3T9aSlQpaFyWJvgX
   g==;
X-CSE-ConnectionGUID: H3/9zEKhRGuAhf2Fh9JPqg==
X-CSE-MsgGUID: WFrHzwt4TmWIPUfBR/cOvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808854"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808854"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:14 -0700
X-CSE-ConnectionGUID: 66cFEM2zRZqQi5UqO+EEYA==
X-CSE-MsgGUID: i2HcdAsAS4qK+NogWRzNdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305317"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 09/13] wifi: iwlwifi: use default command queue watchdog timeout
Date: Thu,  8 Aug 2024 23:22:45 +0300
Message-Id: <20240808232017.87af3f063025.I2222981ead13f6a917f2d4b116c5b94200dc9e51@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We used to have the opmode configuring it to the trans according to the
debug tlv value (FW_DBG_TRIGGER_TXQ_TIMERS).
But this debug is not used, so trans can just have the default value
hardcoded.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c   | 2 --
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h  | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c    | 4 ----
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 4 +++-
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 65b7c68e5ca7..e0b14be25b02 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1325,8 +1325,6 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 		       iwlwifi_mod_params.amsdu_size);
 	}
 
-	trans_cfg.cmd_q_wdg_timeout = IWL_WATCHDOG_DISABLED;
-
 	trans_cfg.command_groups = iwl_dvm_groups;
 	trans_cfg.command_groups_size = ARRAY_SIZE(iwl_dvm_groups);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 6148acbac6af..c6f51e3bc3c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -386,7 +386,6 @@ struct iwl_dump_sanitize_ops {
  * @cmd_queue: the index of the command queue.
  *	Must be set before start_fw.
  * @cmd_fifo: the fifo for host commands
- * @cmd_q_wdg_timeout: the timeout of the watchdog timer for the command queue.
  * @no_reclaim_cmds: Some devices erroneously don't set the
  *	SEQ_RX_FRAME bit on some notifications, this is the
  *	list of such notifications to filter. Max length is
@@ -412,7 +411,6 @@ struct iwl_trans_config {
 
 	u8 cmd_queue;
 	u8 cmd_fifo;
-	unsigned int cmd_q_wdg_timeout;
 	const u8 *no_reclaim_cmds;
 	unsigned int n_no_reclaim_cmds;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d69556c406a8..c703f74ac64d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1437,10 +1437,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans_cfg.cb_data_offs = offsetof(struct ieee80211_tx_info,
 					  driver_data[2]);
 
-	/* Set a short watchdog for the command queue */
-	trans_cfg.cmd_q_wdg_timeout =
-		iwl_mvm_get_wd_timeout(mvm, NULL, false, true);
-
 	snprintf(mvm->hw->wiphy->fw_version,
 		 sizeof(mvm->hw->wiphy->fw_version),
 		 "%.31s", fw->fw_version);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 719ddc4b72c5..3b9943eb6934 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1967,7 +1967,6 @@ void iwl_trans_pcie_configure(struct iwl_trans *trans,
 
 	trans_pcie->txqs.cmd.q_id = trans_cfg->cmd_queue;
 	trans_pcie->txqs.cmd.fifo = trans_cfg->cmd_fifo;
-	trans_pcie->txqs.cmd.wdg_timeout = trans_cfg->cmd_q_wdg_timeout;
 	trans_pcie->txqs.page_offs = trans_cfg->cb_data_offs;
 	trans_pcie->txqs.dev_cmd_offs = trans_cfg->cb_data_offs + sizeof(void *);
 	trans_pcie->txqs.queue_alloc_cmd_ver = trans_cfg->queue_alloc_cmd_ver;
@@ -3567,6 +3566,9 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	}
 	trans->max_skb_frags = IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie);
 
+	/* Set a short watchdog for the command queue */
+	trans_pcie->txqs.cmd.wdg_timeout = IWL_DEF_WD_TIMEOUT;
+
 	trans_pcie->txqs.tso_hdr_page = alloc_percpu(struct iwl_tso_hdr_page);
 	if (!trans_pcie->txqs.tso_hdr_page) {
 		ret = -ENOMEM;
-- 
2.34.1


