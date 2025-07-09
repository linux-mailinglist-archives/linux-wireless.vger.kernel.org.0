Return-Path: <linux-wireless+bounces-25118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B75EAFF2AB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306091C825F2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795D125A357;
	Wed,  9 Jul 2025 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LE2t8Xgy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F92641EA
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091576; cv=none; b=FZhimtbucLNofov57Z6hhNlR6kzarACjp7jew5h+C/IlaU4V8IqHXfT4t5tz4iQKfonn65639BmT+H16n83sqkzvu0pA6Txe4pK5Da7ueK8utMx6g562QHpftcj6p50BH9kJz1aX8ixuz2zvI/t1ozobcmErtd2j1Sd0M2j2NJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091576; c=relaxed/simple;
	bh=LVu5fVxddWa0M4cAXPfPOTlrOprHlTBTLykSaMDrV+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DV5gl8m/iieLoGIx9JElpzYOsJDhKM6hpisPO6k35h+h03kohTW50bf52UshNkIASMwyXRxi0qjv6Ky8IPpxC5cHmcDf7wrRxf9FSqO39O2jNYnCnHistmk39ABVYP2Pco34/EFzcUrkrlKFZx6D9Z4wOBkRnnz/6EqwpbU1beQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LE2t8Xgy; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091575; x=1783627575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LVu5fVxddWa0M4cAXPfPOTlrOprHlTBTLykSaMDrV+U=;
  b=LE2t8XgyJMVCO7lWr9uSqWtMlbAJ9WD2WYt4WRvCSFUYtArWYCqrIlBW
   fpcY2mwwM6ZhKllyEYIctrtKKFmP71CnNbS6Udf9T3UGtuCKOTkQAyaQa
   m+UPdNnD7DnM6raxMykP3oxfGxWsgpNnLPkjpkQrJpjllzcbJjXub/giz
   rmgozzUtPj+nv7tO0tUmsEsBR+Z1dcaicx536QoX5BmqljjO6wGUpMaHc
   6V6jQuw3PBOhMAG0lPMQjFa48Qbx+jU/fgQBQByNmcVBTRVYpuv4z+8kp
   7QyfSGTHsa+exTH3YFIr7trNARMzRug94muZaYYujGW9BGjvCxmDH+C56
   w==;
X-CSE-ConnectionGUID: nq8SEUhAQ3GDA9ZHDM5MPw==
X-CSE-MsgGUID: eVF3mvFTT62fRE3MU4wV7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240311"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240311"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:14 -0700
X-CSE-ConnectionGUID: jB2AlCA6TxiMiJTL7ZpX+g==
X-CSE-MsgGUID: wJ/uwSs4SNuEqwEpUPp7cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126060"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: pcie: inform me when op mode leaving
Date: Wed,  9 Jul 2025 23:05:37 +0300
Message-Id: <20250709230308.abd840f5e998.I3a3fe174ea55a30daa04a0a3e9a6264913677045@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
References: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Itamar Shalev <itamar.shalev@intel.com>

Transport gen2 didn't inform ME when the op mode is leaving.

Signed-off-by: Itamar Shalev <itamar.shalev@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  5 ++++-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  1 +
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c    | 20 +++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 9604781dd0b7..b6e71c172e7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -419,7 +419,10 @@ void iwl_trans_op_mode_leave(struct iwl_trans *trans)
 {
 	might_sleep();
 
-	iwl_trans_pcie_op_mode_leave(trans);
+	if (trans->mac_cfg->gen2)
+		iwl_trans_pcie_gen2_op_mode_leave(trans);
+	else
+		iwl_trans_pcie_op_mode_leave(trans);
 
 	cancel_delayed_work_sync(&trans->restart.wk);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 7dd11891ccfe..f48aeebb151c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1091,6 +1091,7 @@ int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 void iwl_trans_pcie_stop_device(struct iwl_trans *trans);
 
 /* common functions that are used by gen2 transport */
+void iwl_trans_pcie_gen2_op_mode_leave(struct iwl_trans *trans);
 int iwl_pcie_gen2_apm_init(struct iwl_trans *trans);
 void iwl_pcie_apm_config(struct iwl_trans *trans);
 int iwl_pcie_prepare_card_hw(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index 0df8522ca410..035048e0e8f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -630,3 +630,23 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 	mutex_unlock(&trans_pcie->mutex);
 	return ret;
 }
+
+void iwl_trans_pcie_gen2_op_mode_leave(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	mutex_lock(&trans_pcie->mutex);
+
+	/* disable interrupts - don't enable HW RF kill interrupt */
+	iwl_disable_interrupts(trans);
+
+	iwl_pcie_gen2_apm_stop(trans, true);
+
+	iwl_disable_interrupts(trans);
+
+	iwl_pcie_disable_ict(trans);
+
+	mutex_unlock(&trans_pcie->mutex);
+
+	iwl_pcie_synchronize_irqs(trans);
+}
-- 
2.34.1


