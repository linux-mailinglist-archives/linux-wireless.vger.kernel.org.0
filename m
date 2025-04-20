Return-Path: <linux-wireless+bounces-21759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FBCA946E0
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6AD3B7797
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70471C3F02;
	Sun, 20 Apr 2025 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3hKXurY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38601C84D9
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132425; cv=none; b=iOoaHgwxJcRy79N8aARd9BdRLWpQBe9av3FgsNNwgiHTdQ9+bVDBrNhsbqGZwiTJRjDwGNcLW79xgJ8JL606RW+MMe4dF6MfdjTzmz4Cyw1EupPG1/EfadAgRMOE02drwoU7KaVFCb3t/ibMmwlCmzpIDOxbdfGQ6jQ5VZxvwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132425; c=relaxed/simple;
	bh=FvTK8o780GE4QA6xhQKejbgQ7nBmBo3RPQdS85ldfiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N60bkWx8WBgRO0fc87gSmDi9zd7iypewW+VakZaA2gLPBmVtj7C3ao62hUW3DWame5VmBUuciA6mXnY6xpNa/9JA9bIAIm+4PC1sN01J4OEE8ljeK2/1CrsdWmu6NWz6jH0ICvIHX8KF36wOfaNL+Sn959mrrgVztN9C1dKZJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3hKXurY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745132424; x=1776668424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FvTK8o780GE4QA6xhQKejbgQ7nBmBo3RPQdS85ldfiE=;
  b=I3hKXurYvTiwjRAvyyIvbs1Gk8KGrFbhL/UDam/riuxKP8UBp3l+LXVK
   qVcnW8nM13Ubpat52aQyutUhj1ALzrYOmvh9FmCU5Yk6MP0S3Ngg2UO01
   3PzjUcrm4s0FEq0cNN8CQDFoRuhoVa9Rv1KvHKgzACJTCd677QEQ2GTEI
   o9xvfPb84CJmcN9iu7WxFdQ+CUfGa/W4xvM5gfCCHeXjtwh+MQEVgvi4F
   v0HcVn9AFTaeHuU5IVhmHZatHaGGXddpcdbPQ9kKwqUhxnmpJJt8gaDit
   FpKeVkQwlW2qVyDKcaKRO1v15Q6diSWQQJpOVZ8HjSRKSFMF58RsMm1XH
   w==;
X-CSE-ConnectionGUID: SNMbeykYQNKaJo3QjGVPVQ==
X-CSE-MsgGUID: AAnFBgKySrmPgoO49p4uFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46827933"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46827933"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:23 -0700
X-CSE-ConnectionGUID: 0Be3sG2HTsiB/5wc1K5MkQ==
X-CSE-MsgGUID: Ky70jKxcRjagw6YbRyoRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="154615759"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless 6/7] wifi: iwlwifi: don't warn if the NIC is gone in resume
Date: Sun, 20 Apr 2025 10:00:00 +0300
Message-Id: <20250420095642.d8d58146c829.I569ca15eaaa774d633038a749cc6ec7448419714@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
References: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Some BIOSes decide to power gate the WLAN device during S3. Since
iwlwifi doesn't expect this, it gets very noisy reporting that the
device is no longer available. Wifi is still available because iwlwifi
recovers, but it spews scary prints in the log.

Fix that by failing gracefully.

Fixes: e8bb19c1d590 ("wifi: iwlwifi: support fast resume")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219597
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 20 ++++++++++++++++---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  9 +++++----
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 13 +++++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  2 +-
 5 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 6125fe70ce72..e7b2e08645ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -555,7 +555,6 @@ void __releases(nic_access)
 iwl_trans_release_nic_access(struct iwl_trans *trans)
 {
 	iwl_trans_pcie_release_nic_access(trans);
-	__release(nic_access);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_release_nic_access);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 93446c374008..bb7917a3aac0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1760,10 +1760,24 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	 * need to reset it completely.
 	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
 	 * so assume that any bits there mean that the device is usable.
+	 * For older devices, just try silently to grab the NIC.
 	 */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ &&
-	    !iwl_read32(trans, CSR_FUNC_SCRATCH))
-		device_was_powered_off = true;
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		if (!iwl_read32(trans, CSR_FUNC_SCRATCH))
+			device_was_powered_off = true;
+	} else {
+		/*
+		 * bh are re-enabled by iwl_trans_pcie_release_nic_access,
+		 * so re-enable them if _iwl_trans_pcie_grab_nic_access fails.
+		 */
+		local_bh_disable();
+		if (_iwl_trans_pcie_grab_nic_access(trans, true)) {
+			iwl_trans_pcie_release_nic_access(trans);
+		} else {
+			device_was_powered_off = true;
+			local_bh_enable();
+		}
+	}
 
 	if (restore || device_was_powered_off) {
 		trans->state = IWL_TRANS_NO_FW;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 45460f93d24a..114a9195ad7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -558,10 +558,10 @@ void iwl_trans_pcie_free(struct iwl_trans *trans);
 void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
 					   struct device *dev);
 
-bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
-#define _iwl_trans_pcie_grab_nic_access(trans)			\
+bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent);
+#define _iwl_trans_pcie_grab_nic_access(trans, silent)		\
 	__cond_lock(nic_access_nobh,				\
-		    likely(__iwl_trans_pcie_grab_nic_access(trans)))
+		    likely(__iwl_trans_pcie_grab_nic_access(trans, silent)))
 
 void iwl_trans_pcie_check_product_reset_status(struct pci_dev *pdev);
 void iwl_trans_pcie_check_product_reset_mode(struct pci_dev *pdev);
@@ -1105,7 +1105,8 @@ void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
 int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
 				 u32 *val);
 bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
-void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
+void __releases(nic_access_nobh)
+iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
 
 /* transport gen 1 exported functions */
 void iwl_trans_pcie_fw_alive(struct iwl_trans *trans, u32 scd_addr);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index b1ccace7377f..102a6123bba0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2406,7 +2406,7 @@ EXPORT_SYMBOL(iwl_trans_pcie_reset);
  * This version doesn't disable BHs but rather assumes they're
  * already disabled.
  */
-bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
+bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
 {
 	int ret;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -2458,6 +2458,11 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	if (unlikely(ret < 0)) {
 		u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);
 
+		if (silent) {
+			spin_unlock(&trans_pcie->reg_lock);
+			return false;
+		}
+
 		WARN_ONCE(1,
 			  "Timeout waiting for hardware access (CSR_GP_CNTRL 0x%08x)\n",
 			  cntrl);
@@ -2489,7 +2494,7 @@ bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	bool ret;
 
 	local_bh_disable();
-	ret = __iwl_trans_pcie_grab_nic_access(trans);
+	ret = __iwl_trans_pcie_grab_nic_access(trans, false);
 	if (ret) {
 		/* keep BHs disabled until iwl_trans_pcie_release_nic_access */
 		return ret;
@@ -2498,7 +2503,8 @@ bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	return false;
 }
 
-void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
+void __releases(nic_access_nobh)
+iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -2525,6 +2531,7 @@ void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 	 * scheduled on different CPUs (after we drop reg_lock).
 	 */
 out:
+	__release(nic_access_nobh);
 	spin_unlock_bh(&trans_pcie->reg_lock);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 7c1dd5cc084a..83c6fcafcf1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1021,7 +1021,7 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	 * returned. This needs to be done only on NICs that have
 	 * apmg_wake_up_wa set (see above.)
 	 */
-	if (!_iwl_trans_pcie_grab_nic_access(trans))
+	if (!_iwl_trans_pcie_grab_nic_access(trans, false))
 		return -EIO;
 
 	/*
-- 
2.34.1


