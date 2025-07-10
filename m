Return-Path: <linux-wireless+bounces-25210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3266FB00B5F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F35C1052
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76AD2FCFD5;
	Thu, 10 Jul 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uq9mv0+S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610282FCFDE
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172142; cv=none; b=RxHAPLNii8+ujRnyI5yRRgUY8bUVkrdamwsZ7mWT/AsAup2NMd+tMXzjurRubldKU7U26s/HL6ftYa91CUdxB/nSJ2KMnd5vn2g2CFq8Ra6aNZTGwHb6dSPu2LDwwEUs30jLC3y25O/aLc8geBAjzCK2z+PBcOsbirCYiKYmpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172142; c=relaxed/simple;
	bh=52rCPOFcE8td4+TBTHZH1GPn4pheNONi0Fo/PqChPVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHxb7LnAtHtEo3xiYkhK1CaO+QPiV230uU9JSMw4W8GaNObyqyhhyihtoJCbSvN2ntodtcNIFXuQGJqrTbyxxiC+ghoj8HRZb7fs+2mZO+XtvmZjdD9w7+wk9/auiSMtajPDXvgXaPvQF/j1ZSSJyB7dYlQaD+F30hkqrS8n1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uq9mv0+S; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172142; x=1783708142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52rCPOFcE8td4+TBTHZH1GPn4pheNONi0Fo/PqChPVM=;
  b=Uq9mv0+SCLlQOMP62KYwKrHMsnd3jliCphD7RiVx9Sh3lLxToxpdDdV9
   Tqtlur1ka1qe34dGT5PAl+CZbeq4KlJELr8owBcMy6MWOYpdtXiNIUqG7
   v2XryqwcOn6D8mRqLU04PabYUc+FWjuj5oVm+OjeYmyOI8QtkNn/eaoZ2
   yzoA+XpEjOyG4DebO6Nbmww1d558wQcdH+EqnmKezfjwzB86bs05J/w7g
   41ftKxMDyAR+byeq2msvo8JFp2BI3e5XqXkVLBuWM8KmG/4BjF2K3E2kA
   CebaMd2Vs3iRqD3cqZt/3tsAJa9UNln5pWuJUCkC8v6HgabhTM2MgFfZt
   A==;
X-CSE-ConnectionGUID: w+OPzX1rSBi7xli+eRL67Q==
X-CSE-MsgGUID: r8pJIUIPTFaiiz3ZQHWTYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077794"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077794"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:01 -0700
X-CSE-ConnectionGUID: sqL5AzMxTuGX/e3FmaDT4A==
X-CSE-MsgGUID: aHFOLwJyR0iFSGd9xptEfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718718"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: add suppress_cmd_error_once() API
Date: Thu, 10 Jul 2025 21:28:23 +0300
Message-Id: <20250710212632.e061ae241fd3.Ie2043c4e237196ebcfe195006d3d76371de48a55@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Rotem Kerem <rotem.kerem@intel.com>

Add iwl_trans_suppress_cmd_error_once() function to be called by the op
modes instead of directly checking the trans status bits.
This hides the trans internal implementation details from callers.

Signed-off-by: Rotem Kerem <rotem.kerem@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h   | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index ac37d9613ade..aa0c8ca82805 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1230,6 +1230,11 @@ static inline u16 iwl_trans_get_num_rbds(struct iwl_trans *trans)
 	return result;
 }
 
+static inline void iwl_trans_suppress_cmd_error_once(struct iwl_trans *trans)
+{
+	set_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE, &trans->status);
+}
+
 /*****************************************************
  * PCIe handling
  *****************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 75cc1d8bb90c..cc052b0aa53f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -86,7 +86,7 @@ static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mld *mld, char *buf,
 
 	if (count == 6 && !strcmp(buf, "nolog\n")) {
 		mld->fw_status.do_not_dump_once = true;
-		set_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE, &mld->trans->status);
+		iwl_trans_suppress_cmd_error_once(mld->trans);
 	}
 
 	/* take the return value to make compiler happy - it will
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 86a87ea89916..f0e184c8a81a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1134,7 +1134,7 @@ static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mvm *mvm, char *buf,
 
 	if (count == 6 && !strcmp(buf, "nolog\n")) {
 		set_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE, &mvm->status);
-		set_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE, &mvm->trans->status);
+		iwl_trans_suppress_cmd_error_once(mvm->trans);
 	}
 
 	/* take the return value to make compiler happy - it will fail anyway */
-- 
2.34.1


