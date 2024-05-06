Return-Path: <linux-wireless+bounces-7201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92048BC801
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A951C21235
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2AB524AE;
	Mon,  6 May 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxchMeI3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A85338C
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979077; cv=none; b=EJ6SkNb7AX93O5OS3XWEouFCBrF8oeHzaPRhNPj8vq1Bi1BhNtgM1D7QDHggEwCfg1xtuOFkZxGytZsLqfWjA4jOhA/D1cQOcAPkjdtes2XmD3q84c5D+pj12Z+QJEQmzQIn8mNoBV9rfYpJg7tMTkspfZ5PF20pfEApA9GCrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979077; c=relaxed/simple;
	bh=9+w4tbf2P1oZuyqL6uqj6BLPx+t2wTdP2J0hca9hB40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS18n8bCM4NIm4BRfXV4puexrRY1yy6Y7RiNZF1U6RKvEBPt8AU/cI6xVfRjimysxqID5nTktH3hpqtEruvoB1YkuiCV+FxX5L3G4nFTBXSoa8VQz6TEQKMtMFSBLOsuMHn3hUROXBuTLDhSBdhTfkx0wTayxKozJ89MuXDT6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxchMeI3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979077; x=1746515077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9+w4tbf2P1oZuyqL6uqj6BLPx+t2wTdP2J0hca9hB40=;
  b=jxchMeI3k+ADrThQ1O24LF8D3Cma0WHDUjBK/ileb6eP86MXWo7rM6oI
   0akD32coSCzaonq2Gvn4PXzBPkOkGA5BiU1r2+I35+u2gh5T1DJ4lXYNH
   PNBQ9+zL2BI72bXClUfm17HkH3du22QrH4OQQNVflV9HugfVe6VDAzSfF
   tu6D2e0yIRkRw/vxmnslymaMx2f1RUAyrfeKrbFmycybp7ldeKXw8hAbG
   SsrTWDcHBxQSZendYys9DiJ/aj7aty2cxqgqJZ0zlbbLxTIoEDwckjnKK
   bAXt8+fATs5XXAp3PpSRH9tayWG1HYOkTnE8SlVThw/I39IEow4mqHxXv
   g==;
X-CSE-ConnectionGUID: /g7hRdcMQHWxv2tmCmedpw==
X-CSE-MsgGUID: eX0ufEkPRCSRemDid+Cl3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638173"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638173"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:36 -0700
X-CSE-ConnectionGUID: Hj0XpNv2T2awzG3Xgt9UGA==
X-CSE-MsgGUID: dPAilluVS7KOZutT2/yGiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264900"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: mvm: Add active EMLSR blocking reasons prints
Date: Mon,  6 May 2024 10:04:08 +0300
Message-Id: <20240506095953.1e34fe2c3e51.Ia7db0392d81818ceb70a7b199d3f5fa8a4ad198d@changeid>
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

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

Upon adding/removing an EMLSR blocking reason add to the print
the EMLSR disabling mask

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 8252b24b5aca..5c17120dcc2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -33,6 +33,19 @@ static const char *iwl_get_esr_state_string(enum iwl_mvm_esr_state state)
 	return iwl_mvm_esr_states_names[offs];
 }
 
+static void iwl_mvm_print_esr_state(struct iwl_mvm *mvm, u32 mask)
+{
+#define NAME_FMT(x) "%s"
+#define NAME_PR(x) (mask & IWL_MVM_ESR_##x) ? "[" #x "]" : "",
+	IWL_DEBUG_INFO(mvm,
+		       "EMLSR state = " HANDLE_ESR_REASONS(NAME_FMT)
+		       " (0x%x)\n",
+		       HANDLE_ESR_REASONS(NAME_PR)
+		       mask);
+#undef NAME_FMT
+#undef NAME_PR
+}
+
 static u32 iwl_mvm_get_free_fw_link_id(struct iwl_mvm *mvm,
 				       struct iwl_mvm_vif *mvm_vif)
 {
@@ -708,16 +721,12 @@ iwl_mvm_esr_disallowed_with_link(struct ieee80211_vif *vif,
 	if (conf->csa_active)
 		ret |= IWL_MVM_ESR_EXIT_CSA;
 
-#define NAME_FMT(x) "%s"
-#define NAME_PR(x) (ret & IWL_MVM_ESR_##x) ? "[" #x "]" : "",
-
-	if (ret)
+	if (ret) {
 		IWL_DEBUG_INFO(mvm,
-			       "Link %d is not allowed for esr. reason = "
-			       HANDLE_ESR_REASONS(NAME_FMT) " (0x%x)\n",
-			       link->link_id,
-			       HANDLE_ESR_REASONS(NAME_PR)
-			       ret);
+			       "Link %d is not allowed for esr\n",
+			       link->link_id);
+		iwl_mvm_print_esr_state(mvm, ret);
+	}
 	return ret;
 }
 
@@ -1016,10 +1025,12 @@ void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (WARN_ON(!(reason & IWL_MVM_BLOCK_ESR_REASONS)))
 		return;
 
-	if (!(mvmvif->esr_disable_reason & reason))
+	if (!(mvmvif->esr_disable_reason & reason)) {
 		IWL_DEBUG_INFO(mvm,
 			       "Blocking EMLSR mode. reason = %s (0x%x)\n",
 			       iwl_get_esr_state_string(reason), reason);
+		iwl_mvm_print_esr_state(mvm, mvmvif->esr_disable_reason);
+	}
 
 	mvmvif->esr_disable_reason |= reason;
 
@@ -1107,11 +1118,12 @@ void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (!(mvmvif->esr_disable_reason & reason))
 		return;
 
+	mvmvif->esr_disable_reason &= ~reason;
+
 	IWL_DEBUG_INFO(mvm,
 		       "Unblocking EMLSR mode. reason = %s (0x%x)\n",
 		       iwl_get_esr_state_string(reason), reason);
-
-	mvmvif->esr_disable_reason &= ~reason;
+	iwl_mvm_print_esr_state(mvm, mvmvif->esr_disable_reason);
 
 	if (!mvmvif->esr_disable_reason)
 		iwl_mvm_esr_unblocked(mvm, vif);
-- 
2.34.1


