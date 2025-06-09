Return-Path: <linux-wireless+bounces-23870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B95AD2578
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16783AFB33
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199821CA14;
	Mon,  9 Jun 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJACasR3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063421CC79
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493323; cv=none; b=cgqv6OdbacxI5oMdrRtP+JycxSRoXmp30ckXc+rntBJ9YkBeYsPknPGgmDSU/SYeuf5vLXhymHmYa0XVwf9VTnmq4U1WAfDzf4rJS8iD4NzpHC9UcCeoiV7F2oeUfy+rOWwyTcz6OmfQ9eysUPhMzNYELdVHqKFrBbt+juyObOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493323; c=relaxed/simple;
	bh=je8VqrYTM7GyCcWF0UZvDnqaWlZ8VvtSAGumM+PSc4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqm/K7LvYFkeDIsFNW1SnfZf2hirgarywkm1Zv+IY/wKdZh2DIjibbgrFru37OPQ4aKRYS5toLZFTv0sarv9KA3dQson3vxc0jMAkz/AlqAXEStmeW30lY2kpU24vTJZogwbR475P4xJPVhbgtsiIutr6/BTQcWS4jUBoa9OArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJACasR3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493322; x=1781029322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=je8VqrYTM7GyCcWF0UZvDnqaWlZ8VvtSAGumM+PSc4E=;
  b=AJACasR3iP2AHA6L4MdzspuFKk+FS20HIAd0IktJsCI5H1XBGBCQOnVR
   T/IxzmQ0ycDr1Tyl6Yro2XL5yhXbJW+VPf2RlqTmRqMiy0CCKvqWI0Fjp
   k1OjJ9XqTD3NPeoLjpNl5wwxPOomIrortIRUBl3GnSr/mJfa0DIMA2eSh
   pS3LFndkcrzN4q5J5iBuMxmTz1UIypmZA/iZy/4VZv5Mo/fDQ1G1SmixQ
   FGc0amkhoqLrc0GSDQ9f/858siuqv04Ex/sk6Ic4JGAMXg3hc/Pw7GQDP
   NkAl12/RJQnfWIABjyNx9U7WStQ8P+qfErGZ8IIZWt/iJdNwzBIFV0PeH
   g==;
X-CSE-ConnectionGUID: Y2LV1HbjTx+1P/qhFstAdw==
X-CSE-MsgGUID: b7FM7IG5TGKg5DIDnff6Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237691"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237691"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:01 -0700
X-CSE-ConnectionGUID: pYKENHgGS8yiLUoBbdxSIg==
X-CSE-MsgGUID: dkzceQtqQsyFDRcB8CGQAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510359"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: pcie: initiate TOP reset if requested
Date: Mon,  9 Jun 2025 21:21:17 +0300
Message-Id: <20250609211928.0875d5f7e066.I62f14008d89416bc4a3a1056e06762561a7fac57@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

At load time, the firmware may request a TOP reset via
bit 6 in the IPC status register. Handle that and set
TOP reset in that case. Since the init will be retried,
there's no need to do anything else.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h        | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 0fd452cb94ae..f3fa37fee2e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -113,6 +113,7 @@
 #define CSR_IPC_STATE_RESET_SW_READY		1
 #define CSR_IPC_STATE_RESET_TOP_READY		2
 #define CSR_IPC_STATE_RESET_TOP_FOLLOWER	3
+#define CSR_IPC_STATE_TOP_RESET_REQ		BIT(6)
 
 #define CSR_IPC_SLEEP_CONTROL	(CSR_BASE + 0x114)
 #define CSR_IPC_SLEEP_CONTROL_SUSPEND	0x3
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
index 7b56eb78663c..0c73b1fe3645 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/rx.c
@@ -1700,6 +1700,15 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 		timer_delete(&trans_pcie->txqs.txq[i]->stuck_timer);
 	}
 
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_SC) {
+		u32 val = iwl_read32(trans, CSR_IPC_STATE);
+
+		if (val & CSR_IPC_STATE_TOP_RESET_REQ) {
+			IWL_ERR(trans, "FW requested TOP reset for FSEQ\n");
+			trans->do_top_reset = 1;
+		}
+	}
+
 	/* The STATUS_FW_ERROR bit is set in this function. This must happen
 	 * before we wake up the command caller, to ensure a proper cleanup. */
 	iwl_trans_fw_error(trans, IWL_ERR_TYPE_IRQ);
-- 
2.34.1


