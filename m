Return-Path: <linux-wireless+bounces-3104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FADD8490F8
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BAC1F22964
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85BE33997;
	Sun,  4 Feb 2024 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVXanE8M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6943398B
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084398; cv=none; b=WVTe1fU8ND+nrCfGNavKMCx2cXyLqAKWHQdKP34N41Bh4HUV9sVLLR3FQeSw1zsQpIKowSorO0jt3C6JGAi+G+0V0ZMvwqttY0Ed/3Xum0dXEtdgzBzmXufDGs6iyWdBcVjuk7DeUghfyHPFN7PCTw4GLfRy956+c3HvyT9oMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084398; c=relaxed/simple;
	bh=QwL1JSZdJ5qnTRFrjcUMMMiPe6NM8j6+UAO5D5cRGtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E0PGC5k1YfpQBjWREvwqfqCtNqvdM1grZnRtwPYna0lkiwlNFcdVPPeXV6cCma2Juz0qeWbzPOchsUaCHsZNyZaaQKhysiC3KIX7rwdnMJbJMXU9T6gFxQNRtO812WO1AkiQCbWBR0AdfmRQ26Nb/gUgJRvD5gpWct7IHto9N3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVXanE8M; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084397; x=1738620397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QwL1JSZdJ5qnTRFrjcUMMMiPe6NM8j6+UAO5D5cRGtg=;
  b=KVXanE8MYN3N0l/7lKdT3wl7zciCGxR7NXZuBm8fTGxk5VRbEpDVguhr
   4YllbdcnB5CGnTCB2QdFfLQPLURzdD+wFUpGHlejjeGCtQ0cZfNK0bHzs
   /ddRzcEopEc9JUTzU1fODp6DegKk+MviIyKoNRcRvZE5oL1MlvpdeSJeP
   7VNf5YNOcyCbYWE+da3m6Tddz6zSDhUSLWavEqeY0209CV0ZGHvSvQ0Q0
   ucJGuuKdUs7dIuesCuvQ5EGfpHZZV+EQaA+N6PkoNBqxykBCHBZ0q7HwD
   7RoC/XESiPhdnq0ZeGqEZWKIp2tKLvvYqjvog43aqQ4kNrnzWR4PKuK9F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869368"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869368"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815854"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: pcie: don't allow hw-rfkill to stop device on gen2
Date: Mon,  5 Feb 2024 00:06:05 +0200
Message-Id: <20240204235836.794c5387e67e.I064365428815ec3135afa345fbbde78449b60203@changeid>
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

On new devices the HW rfkill shutdown doesn't need to be handled
"as fast as possible", so disallow the immediate shutdown mode
here via documentation and a warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h | 4 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c  | 9 +++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index 3dc618a7c70f..1ca82f3e4ebf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -68,9 +68,11 @@ struct iwl_cfg;
  *	Must be atomic and called with BH disabled.
  * @queue_not_full: notifies that a HW queue is not full any more.
  *	Must be atomic and called with BH disabled.
- * @hw_rf_kill:notifies of a change in the HW rf kill switch. True means that
+ * @hw_rf_kill: notifies of a change in the HW rf kill switch. True means that
  *	the radio is killed. Return %true if the device should be stopped by
  *	the transport immediately after the call. May sleep.
+ *	Note that this must not return %true for newer devices using gen2 PCIe
+ *	transport.
  * @free_skb: allows the transport layer to free skbs that haven't been
  *	reclaimed by the op_mode. This can happen when the driver is freed and
  *	there are Tx packets pending in the transport layer.
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index b5756e168f49..6c76b2dd6878 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1484,12 +1484,9 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq)
 
 	IWL_WARN(trans, "reporting RF_KILL (radio %s)\n",
 		 state ? "disabled" : "enabled");
-	if (iwl_op_mode_hw_rf_kill(trans->op_mode, state)) {
-		if (trans->trans_cfg->gen2)
-			_iwl_trans_pcie_gen2_stop_device(trans);
-		else
-			_iwl_trans_pcie_stop_device(trans, from_irq);
-	}
+	if (iwl_op_mode_hw_rf_kill(trans->op_mode, state) &&
+	    !WARN_ON(trans->trans_cfg->gen2))
+		_iwl_trans_pcie_stop_device(trans, from_irq);
 }
 
 void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
-- 
2.34.1


