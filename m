Return-Path: <linux-wireless+bounces-26721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3D6B39463
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0901C22CB5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 06:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E7A27B330;
	Thu, 28 Aug 2025 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9xErTsp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B519FA8D
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364160; cv=none; b=Odv+sdI2Stg5sxyPgJrH9EtJAxxgO/OlP8el80525VPMU1klJP5FGLyuTN+a0Nta3vWZFVHC+dIObM+0l8KtQDWtj7LUVTZ2abPEEH8EwGcq9pliuCgkXmp0evxYdug4nccNFJGuwbuV1F1dBcXlPD2BZutCmZ8PeY5FztaGGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364160; c=relaxed/simple;
	bh=ABXDD/xC7rn+cWqwJf3+yfbOhmEgvoXNGHMn6U23rXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uvQFApyJ+fSh5sySkUR7m1zDj+kir+JfqydNsL6f0JcMKuU4CSgDx4oerieTRKoo09ILgVVNQ8296QosmB/tiM4kwwSUoNOHa8NBT637KrWyq0DIlVtM3DroBaHzwqg7w4LLwDg/md2smL8O66ENSCw4T5IHGLA0A0c84+jN62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9xErTsp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756364159; x=1787900159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ABXDD/xC7rn+cWqwJf3+yfbOhmEgvoXNGHMn6U23rXY=;
  b=f9xErTsp6P+XmRcrqmA8XRf1sypCPYA9mM6j61S2b709nbzXm0rLD6XX
   NaAWyK+CTG0K3yfSAElaLESnghhqRjDgsvQPu45IiP2B0X+0hJZpAyruX
   2Vf58QoWLo1EqL/05Nu30iby2tHz9hD8HFvhtDAvFdwFn0gvhjfb6M8V2
   B818fljsG7jKt0SmmYYNMG8wjc74Wug/2FAltWxHGR2iGXEzc1/+DNupd
   02ZtUv1EsR0l+jhELJu1qDsJsf7U1jlUtzcLkpZ1uwl7ZXi+DIXVvUbCZ
   9RNm8BOfZy+Uz1RdpoADFdsfTk68w4rE2976oepuX7nPfU6CXgkgdXEXw
   w==;
X-CSE-ConnectionGUID: qkAFtyknTfm3DOp0gnwPuQ==
X-CSE-MsgGUID: 97/XlwoVSNqCJteDbit9qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58723681"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58723681"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:55:58 -0700
X-CSE-ConnectionGUID: pmiQEOQ9RXKMCruVdVc0+g==
X-CSE-MsgGUID: CwRbPGkBRK+/AvxoIRlhWQ==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:55:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 1/6] wifi: iwlwifi: if scratch is ~0U, consider it a failure
Date: Thu, 28 Aug 2025 09:55:26 +0300
Message-Id: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We want to see bits being set in the scratch register upon resume, but
if all the bits are set, it means that we were kicked out of the PCI bus
and that clearly doesn't mean we can assume the firmware is still alive
after the suspend / resume cycle.

Fixes: cb347bd29d0d ("wifi: iwlwifi: mvm: fix hibernation")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b7add05f7a85..46d8c1922292 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1222,11 +1222,15 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
 	 * but not bits [15:8]. So if we have bits set in lower word, assume
 	 * the device is alive.
+	 * Alternatively, if the scratch value is 0xFFFFFFFF, then we no longer
+	 * have access to the device and consider it powered off.
 	 * For older devices, just try silently to grab the NIC.
 	 */
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-		if (!(iwl_read32(trans, CSR_FUNC_SCRATCH) &
-		      CSR_FUNC_SCRATCH_POWER_OFF_MASK))
+		u32 scratch = iwl_read32(trans, CSR_FUNC_SCRATCH);
+
+		if (!(scratch & CSR_FUNC_SCRATCH_POWER_OFF_MASK) ||
+		    scratch == ~0U)
 			device_was_powered_off = true;
 	} else {
 		/*
-- 
2.34.1


