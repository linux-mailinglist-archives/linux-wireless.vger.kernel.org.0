Return-Path: <linux-wireless+bounces-37030-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO1PKbROF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37030-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D05E9E65
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92D573032166
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B93B6345;
	Wed, 27 May 2026 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkQFpLap"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AADB3B52FB
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912336; cv=none; b=YPHjbKtMChJ9cvWPVgIJBZax3g9Aua5T1TIvk/agcGidIkvkbPzO/L+ghwd8ab09NxDKNFrjqsYBwzNkC/ntDRCNLFi8MZT0NdRbFjdTCtI1iSsPmyuZZEzx9MDGLoj+GrEdIBFSNdtSdK1OyvWse1ZhbTPAxTX938vy5wJpfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912336; c=relaxed/simple;
	bh=aMpfbsqVU4nN3k8bYc6HRKFi54AOCsqat2gippXQ5Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CyYMELKLdGLQzGoIgiYTQ4/G9VmGTvrxpUZVfsJBorM1HgMK/69j6zekgv8LXdr7ba/GfTVyoJCqsNyGfLhNch2tiqH4qe0FCB92+Pffuha7JkYlIObzTXok75KUiYFFMN4PtEcRDQliEofoLmOrqtUtpOwRKzLVpm7lso6J5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkQFpLap; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912335; x=1811448335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aMpfbsqVU4nN3k8bYc6HRKFi54AOCsqat2gippXQ5Hs=;
  b=mkQFpLapmb0YHa0Nggpa7D+idEXoQ/zMLiBwjyLH9yLaDqfu/SKqxxRl
   y2bH/urSUOXCmaYYQcZCGCjcdmG271NcjOjf/TCdEo4rIkY1iJ/7vvirD
   e05+ppRWOiSPVhqgziKeNKnwrwFI3gYiWLRI8cL1jTqAf1vhTignCb9/E
   F10VUTn+rTcNkpT/usDOglm8eKnPO0MBpss2TvEIss2qb4dlZ6I9kit0e
   vY79JHkB9wZFIK8ujYEL8IfQ0paoOPHRGH6SBM+lTaegW/3n0GHOCmtLr
   CMJFLeFbdx7CJ0kpZ5J2bmEAkl7e/l7Ub/89hwRvSlt73lP7E+Lb8M2GY
   Q==;
X-CSE-ConnectionGUID: /7BUTnsoTGa7U2h7M3oE3Q==
X-CSE-MsgGUID: NryRpucqS5Ck3LZ2M/U6Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940863"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940863"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:35 -0700
X-CSE-ConnectionGUID: EIS1VGoDTzqcNbeDmpbt5w==
X-CSE-MsgGUID: xK4lQ10iToategBb9m4kXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286957"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Moriya Itzchaki <moriya.itzchaki@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: fix STEP_URM register address for SC devices
Date: Wed, 27 May 2026 23:05:02 +0300
Message-Id: <20260527230313.f0c115c4f74e.I3c66b2e39a97f754e853ac7e7dba8e433523619e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37030-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: A08D05E9E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Moriya Itzchaki <moriya.itzchaki@intel.com>

The CNVI_PMU_STEP_FLOW register address differs between device families.
For SC and newer devices, the register is at 0xA2D688,
while for BZ devices it's at 0xA2D588.

Signed-off-by: Moriya Itzchaki <moriya.itzchaki@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h        |  3 ++-
 .../wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c  | 12 ++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 6ca1f51b69a1..50acfe0d4f79 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -385,7 +385,8 @@ enum {
 #define   CNVI_SCU_REG_FOR_ECO_1_WIAMT_KNOWN		BIT(4)
 #define   CNVI_SCU_REG_FOR_ECO_1_WIAMT_PRESENT		BIT(5)
 
-#define CNVI_PMU_STEP_FLOW				0xA2D588
+#define CNVI_PMU_STEP_FLOW_BZ				0xA2D588
+#define CNVI_PMU_STEP_FLOW_SC				0xA2D688
 #define CNVI_PMU_STEP_FLOW_FORCE_URM			BIT(2)
 
 #define PREG_AUX_BUS_WPROT_0		0xA04CC0
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index 0e324aeb9055..f41cbe62e7aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -376,6 +376,7 @@ static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
 void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u32 step_reg;
 
 	iwl_pcie_reset_ict(trans);
 
@@ -404,10 +405,13 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans)
 	iwl_pcie_get_rf_name(trans);
 	mutex_unlock(&trans_pcie->mutex);
 
-	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
-		trans->step_urm = !!(iwl_read_prph(trans,
-						   CNVI_PMU_STEP_FLOW) &
-				     CNVI_PMU_STEP_FLOW_FORCE_URM);
+	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+		return;
+
+	step_reg = trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_SC ?
+		   CNVI_PMU_STEP_FLOW_SC : CNVI_PMU_STEP_FLOW_BZ;
+	trans->step_urm = !!(iwl_read_prph(trans, step_reg) &
+			     CNVI_PMU_STEP_FLOW_FORCE_URM);
 }
 
 static bool iwl_pcie_set_ltr(struct iwl_trans *trans)
-- 
2.34.1


