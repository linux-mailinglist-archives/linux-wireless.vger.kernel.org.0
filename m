Return-Path: <linux-wireless+bounces-23542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD31ACC2C4
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 11:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754187A5336
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D32227EA7;
	Tue,  3 Jun 2025 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ar0O8GIG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8482C327A
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942286; cv=none; b=bB9oSDlcJdtk3AnrMalre5ZT0PY0Ga+uqYiQ1q7gaZ5oIFpBuBmdMEgTXPezbi8XLrD48TQWCjP87lBZItaLiObl87taYc1s/V7sH8S2qxRcqda2BA59HfTDtkRAZ7tWY4i5dDbHSQwwPP3dEOR9Y5EqJ6syHypwOF9h0g3D55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942286; c=relaxed/simple;
	bh=skddas44H9fta7+SogWVARBpPT4r49mLRIbZDUQQyLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNkPbUObevnMLl4lTrbAwMYkZX+E2mgh0TtiTJphcogDwZI1K8rwnMiDsL7DHghjVcPF5pE6V0oLHV2o7ci6ay3oGyTjolzntxcYLtSblBSuT9iZcX3//LID9CL6k4vJQ+HZEX4ilmIcEd1EaUksL1F2vdGlgTgfVq1uXnsZeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ar0O8GIG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748942285; x=1780478285;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=skddas44H9fta7+SogWVARBpPT4r49mLRIbZDUQQyLI=;
  b=Ar0O8GIGSACgCUA/6n1nJ1uAFWKEfn14UEApwVbVtorpMNYDsfbDzkSs
   dk3x+g0uwOA4UxBSwfn83tb9NDCTKChInpp5xZaeYFCpZdZxBEeStp2os
   +4VR7zalitxYvx/oJIuuBG9gU9tmTVhpsfIhIxdPkbyOeJDzAtPfyu55N
   ctB8RrmOkAJ9mR4x207c6GBDi8YRzKSFw6732G1bhJui5bBxHMH3/WCMD
   GuBklD42rKt53BVU6JKR0z1zJT5yR1MjtqHfq18zpCJcjC9ZlOQZwTo3E
   se6OOzH4+amWpifVypEIcixBPQM/p3ja4DxPU6OaAycN5QjqzhPnt6uxC
   A==;
X-CSE-ConnectionGUID: YnBcpzUFTGiTMdsFvAGwSw==
X-CSE-MsgGUID: yhK1arC9Qse3qBzfs5+Tkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68526079"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="68526079"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:18:04 -0700
X-CSE-ConnectionGUID: N/Dz892DTjy8UkJLjZAZAw==
X-CSE-MsgGUID: +9WNY3IJSF2ENGk7NuW4BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="144691150"
Received: from egrumbac-mobl6.jer.intel.com ([10.13.65.82])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:18:03 -0700
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless] wifi: iwlwifi: fix merge damage related to iwl_pci_resume
Date: Tue,  3 Jun 2025 12:17:54 +0300
Message-ID: <20250603091754.70182-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The changes I made in
wifi: iwlwifi: don't warn if the NIC is gone in resume
conflicted with a major rework done in this area.
The merge de-facto removed my changes.
Re-add them.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 656f8b06c27b..0a9e0dbb58fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1501,11 +1501,27 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	 * Scratch value was altered, this means the device was powered off, we
 	 * need to reset it completely.
 	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
-	 * so assume that any bits there mean that the device is usable.
+	 * but not bits [15:8]. So if we have bits set in lower word, assume
+	 * the device is alive.
+	 * For older devices, just try silently to grab the NIC.
 	 */
-	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ &&
-	    !iwl_read32(trans, CSR_FUNC_SCRATCH))
-		device_was_powered_off = true;
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		if (!(iwl_read32(trans, CSR_FUNC_SCRATCH) &
+		      CSR_FUNC_SCRATCH_POWER_OFF_MASK))
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
-- 
2.49.0


