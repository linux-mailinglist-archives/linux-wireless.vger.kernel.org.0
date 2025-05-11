Return-Path: <linux-wireless+bounces-22851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49759AB29CE
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F32AB7A6B09
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB7C25D541;
	Sun, 11 May 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Asvku5lK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5625D910
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982432; cv=none; b=WDT+ybCQt/g+jp4YR0z7UyUe4JBY7uVIyRj8/gNGwfAbkhgXpX2MF0Wzw0M1g2mZL0YPjcBlO0+S3AWg7sDexgQYgPW9IKsTav8VcGTNQ0Y+Pz+EiDZJUq61r5EnrMSd4+wueHlfkytwaco0vXygPDwke+nZFm8+KnYNu2d2Ef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982432; c=relaxed/simple;
	bh=GRI2vfyPKtkJ7UN9IpfvTznOCg+3cEf3L6jIatrkxts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aacyhFaqyAoU3ietCka+63sa008HJ65Pz0tRwXj2AXu2+ES+mJXOScdxdG13esxBOEu6hquc/CZJncoPgrMPFGB0ptEpyaZZcbtmW1mlA/lwed8XarJ4GxJ/eFyoj2gyHoXsMXqSVSN2GFY8xieDawqyYDlF507XabrNViSNjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Asvku5lK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982431; x=1778518431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GRI2vfyPKtkJ7UN9IpfvTznOCg+3cEf3L6jIatrkxts=;
  b=Asvku5lK/UQpgipClO/nhrqAVMtH3rNAUbxpZNyuAfG3dv6WejKzXGfv
   FFuY/AOLwjGeUQ5/Xqp6+ex4t7caRIH/09eiyGBKtefw9s8MD+yzpq4Z4
   qVfVmjdvPo/EM+CAzg6zYAQk3c25FcZkF7Bb6/fmlQ/aivbHf2gT2wJbT
   bgTS6i8ZqRgMdNjY/ZptdYZOjez0oLhLA1meWUi0N0LbWHfevp5IwZmK+
   y2gZwEqC8bC4/k4Cjyt0pxdVcHVQPEEfFqO0AfFWYvYRvyheE1Gm0rjHa
   3q0+l25aK6Khk2+PpW1fNHCbIW0PEwS1lyXyAaddzs5OFGKvQ2akXQvq0
   A==;
X-CSE-ConnectionGUID: XibwM66tRv6dl7+ile+Now==
X-CSE-MsgGUID: WjM4Yf3kS1e3MwWylfSb+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582701"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582701"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:51 -0700
X-CSE-ConnectionGUID: 9sufaBVpS3+n195Ps87EaA==
X-CSE-MsgGUID: m8RIEfKcSLC9LMc9d800rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137655091"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: fix a wrong comment
Date: Sun, 11 May 2025 19:53:18 +0300
Message-Id: <20250511195137.7eaf79a07226.I615cfd21001208b366c94a5fcb8e30a7d97f0ac2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
References: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_pcie_apply_destination is used in all generation.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 56b4042edbc2..a8aeb5c115fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1102,6 +1102,7 @@ int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
 				 u32 *val);
 bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
 void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
+void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power);
 
 /* transport gen 1 exported functions */
 void iwl_trans_pcie_fw_alive(struct iwl_trans *trans);
@@ -1126,9 +1127,6 @@ int iwl_pcie_alloc_dma_ptr(struct iwl_trans *trans,
 void iwl_pcie_free_dma_ptr(struct iwl_trans *trans, struct iwl_dma_ptr *ptr);
 void iwl_pcie_apply_destination(struct iwl_trans *trans);
 
-/* common functions that are used by gen3 transport */
-void iwl_pcie_alloc_fw_monitor(struct iwl_trans *trans, u8 max_power);
-
 /* transport gen 2 exported functions */
 int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 				 const struct iwl_fw *fw,
-- 
2.34.1


