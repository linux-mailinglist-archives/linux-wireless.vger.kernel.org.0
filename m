Return-Path: <linux-wireless+bounces-25193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B93B00957
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE3D5C5360
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843A92F0027;
	Thu, 10 Jul 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nhziv0JM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11D52F002C
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166521; cv=none; b=XQspDUprWDfDVYDs0o5vQNmoRI/BBQ8/WlIt3gnfkK0uxGXK5/55ncninYV3Uvwt4ux6943uvUFZpluJwzuTlZcxpSVcaZW9gThYaGPfOSAJ2ZRdzVXcZdaCbw1i5w4C1+xAhH8VpOE2kiCaADIzdAUaobJId7sq/oZYX8Fj38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166521; c=relaxed/simple;
	bh=52rCPOFcE8td4+TBTHZH1GPn4pheNONi0Fo/PqChPVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5OEGoY5IOyaXoMf60clKQr1zQG+s1bzrIaoOSLbvOXOtkC2/K6s4bU/zHk4/aMfuchgwi3KFZoqnvGP0sX4WAmlNjqn7z9zL5YfCjC3wypUDtwi25ndy4xNMJeMZ0iPAGpKsY5ew5IEDVOmsg83No/dU87WCO1ID5qfbHpjcnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nhziv0JM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166520; x=1783702520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52rCPOFcE8td4+TBTHZH1GPn4pheNONi0Fo/PqChPVM=;
  b=Nhziv0JMQ4AUOWm5biigwf1ORwSr5AfGHSEQfH95tf11EQJEgnawFcw1
   3ob6PQjFuizAqoM6Mk/Q9GqzMRs2IhUGKyX7rp6JomUtifgmObaP/vMUE
   D+civtnkbtmEUWJ0PiSpOr+zsuYvsz1AwfXYYu11HNKnOA8zD8hSW7UyK
   H5Odz4APce31Qp+fBL31KrEf6RzPb0bzHDMKBvIfnlBW4eww4Dvi9K8Yr
   +/ZF4m+9tTU7jCkcyIoR+ceuCQXzE9D0breFczD7IhmtCHAIzDGYmA3xZ
   4s/gSnsd26Q9X7sTvQtN+IJcNi1WWAZLK0B+BUp7ufM63LYzlW3ZgGE4z
   Q==;
X-CSE-ConnectionGUID: 8TqUdhx9QvK6ZpDwTAJ5Fg==
X-CSE-MsgGUID: P4dxg0klQ6Ci9fVOtYucYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54610001"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54610001"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:17 -0700
X-CSE-ConnectionGUID: 0S3QErALRTO96s1CeMqKWQ==
X-CSE-MsgGUID: tbubiaXAQ1W8AZumVjcwNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277033"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Rotem Kerem <rotem.kerem@intel.com>
Subject: [PATCH wireless-next 06/15] wifi: iwlwifi: add suppress_cmd_error_once() API
Date: Thu, 10 Jul 2025 19:54:39 +0300
Message-Id: <20250710195219.e061ae241fd3.Ie2043c4e237196ebcfe195006d3d76371de48a55@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
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


