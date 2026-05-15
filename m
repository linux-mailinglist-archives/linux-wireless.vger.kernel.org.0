Return-Path: <linux-wireless+bounces-36489-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF40LnUTB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36489-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:37:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2F054FAE4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B623E31A0C53
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408D47ECC4;
	Fri, 15 May 2026 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZ9Rit3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1725A47ECF4
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847322; cv=none; b=iBZIbvgmThUNuxtHuKgcoC6e0N2IpKImEAN5xAjRFu8rViEXy2m7WCK9zXLwnI5JWt+MJIinIBRSJNunqYEUXDa6Jw2XByG0GrEMssXy1Y67xsJuvDE5pvMTLtB679hkHAeCZW1XmHzvvkWpCXBjGzDU7SrMbF+M1ADsyfNRWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847322; c=relaxed/simple;
	bh=PuQt6DfS+4Kk9pNps9AmBBLOw2CILoaxHFj8GU1RytA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dkj+LHG5Yy4f9V1S/tGhTiEZ69bBAtPCMc2E4FZDojsC551tgw4NMRsES4ANEgzqVIhiSgLQhueJID4ub8kU1saM5ymGYbb42RdMF1e0aFSJ3BvhgHVJD96mB0nuJH4UVFplb1rl+55d1jpJuexNF10/uq95HSkeIgbKiCqx6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZ9Rit3D; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847319; x=1810383319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PuQt6DfS+4Kk9pNps9AmBBLOw2CILoaxHFj8GU1RytA=;
  b=AZ9Rit3D3eCYQbFmr76j6Hb0N4FB0QTCFqFd9fjYW/0sXTT8D7b3BJBT
   bAe8ibuCUxs4PJMbFMMeVagAA4qNJeQFILCJJ6nK66RsjemF7ElUuqNhh
   RbrEwlWj+MyKtUyipTTsZJl8JxbBnT5eujlJxWgiurxzymQdg1k6E3U+2
   qXwNW3t1D3mlsma5NUgZgrsMtd7T3Gp2iKkJiNQr5wQR4YxALRd080HyL
   T2BPWCBg2B66zWF2RmhLC2tuR9szcRFy2LaSs5HT+F4dvP5jZnXtOxrfC
   fxHBFnAsRZeovTpT6UXRio4x8jDzc6phWfTp+9x87GGlTnF/cbKZloIvo
   Q==;
X-CSE-ConnectionGUID: +zhrUOCkRrWORB6kG6Y/7g==
X-CSE-MsgGUID: SWWiLunoSiiCkiUHilTbHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79657845"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79657845"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:19 -0700
X-CSE-ConnectionGUID: MqelxGH6TVeiAixlfa+AUg==
X-CSE-MsgGUID: RxqpZxTOTKex64m34NWENA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262201055"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Moriya Itzchaki <moriya.itzchaki@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 3/5] wifi: iwlwifi: use correct function to read STEP_URM register
Date: Fri, 15 May 2026 15:14:58 +0300
Message-Id: <20260515151352.3a69fa2dbda7.I8d96635a9c06a835b05a10b6d66c8a9299676246@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
References: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C2F054FAE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36489-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Moriya Itzchaki <moriya.itzchaki@intel.com>

CNVI_PMU_STEP_FLOW is a PRPH register, not a UMAC PRPH register.
Use iwl_read_prph() instead of iwl_read_umac_prph() to read it
correctly.

Fixes: de0c2cdcb7eb ("wifi: iwlwifi: mvm: limit EHT 320 MHz MCS for STEP URM")
Signed-off-by: Moriya Itzchaki <moriya.itzchaki@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index a50e845cea42..64262bcca55d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -398,9 +398,9 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans)
 	mutex_unlock(&trans_pcie->mutex);
 
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
-		trans->step_urm = !!(iwl_read_umac_prph(trans,
-							CNVI_PMU_STEP_FLOW) &
-					CNVI_PMU_STEP_FLOW_FORCE_URM);
+		trans->step_urm = !!(iwl_read_prph(trans,
+						   CNVI_PMU_STEP_FLOW) &
+				     CNVI_PMU_STEP_FLOW_FORCE_URM);
 }
 
 static bool iwl_pcie_set_ltr(struct iwl_trans *trans)
-- 
2.34.1


