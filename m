Return-Path: <linux-wireless+bounces-20061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B3A57F2C
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6EB3ABC67
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EF914D2BB;
	Sat,  8 Mar 2025 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJbyreTl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98018DB33
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471301; cv=none; b=soKVA4TU6mmh+IwGLW6yCLXPMF0RJ4OwjvEYibP1/FgOFvWQCqb7CXjwC6HgtqERLjSKcIWW20S4sUdVVdNFbqLogOFQ+5oiXSiHAIOpuj5s96cNVMmKC2mysMXA+4Zwj3qXRuL7/lhNuPA+WAMPq4HbQDdTWAuBXYt47qf40i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471301; c=relaxed/simple;
	bh=E5Z4OPGNz8H9581BuBj0UoVBdzsVdMpx+AwxQ29Ihwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=juvaGg3zhyPGgEJQFsU6Q+AcgVJ7O1p0Ds9G4EF3DH0vjh5LAluzdYA7yZZuzuNgATvYxNZa0B2LBUgaXz9VMW6xlFVngXthPRqUwLWkJ16E4Wvhv2EugNpEx1tUvPwVwTI+YXDaMMPK1CX5EqtqIf9K0oYj6HMBeBrs0Cb6keU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJbyreTl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471300; x=1773007300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E5Z4OPGNz8H9581BuBj0UoVBdzsVdMpx+AwxQ29Ihwk=;
  b=CJbyreTlpXV9/H0THkqaQ2w4m0UufjR16gUn0Xq/tocteLL90skVf7IQ
   qO8Nsy13tIQSJOcjwCfIY5BVj0EHGqH0JvxIT1ImJcbCrZpMH+rcLx119
   gmVpRFx/ZDdvMSXzCGs0qrHhA4/Nr3XV0/FMLnqkIF4fSZpVYmK0WL0L5
   u1pzLC0BGN0zUlt6G8m0HiH49gaj2gQ5+E/aEMM041zr4NPlIgMZk6ED6
   o6dvL3PdiEhiUBs9NIp4BuDWeuIKfrUt7eQdMrN+Nt+N0kJYMSMvo5ZhI
   hEDc2PZyM9bhkdCWDdgDGVnwK9BWllXnbFOtgbvSSna3BOgHidqa77Xyy
   A==;
X-CSE-ConnectionGUID: NETaJXCERMqFNQkGFXZRcg==
X-CSE-MsgGUID: CxcnufoPSEWxwx8Vkmb6Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540613"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540613"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:39 -0800
X-CSE-ConnectionGUID: LxBRsgRhQg2AuE5K9Z+5/g==
X-CSE-MsgGUID: f5zKv7WPTzqlGy3/8EJjkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352062"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 01/15] wifi: iwlwifi: mld: fix build with CONFIG_PM_SLEEP undefined
Date: Sun,  9 Mar 2025 00:01:11 +0200
Message-Id: <20250308235203.6f7e44a27b87.I78b9311019b59477a1961cddc4640b255ceda651@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

fw_status.in_d3 is only defined under CONFIG_PM_SLEEP.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h | 4 +++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h b/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
index 773bc1b09392..64a8d4248324 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #ifndef __iwl_mld_hcmd_h__
 #define __iwl_mld_hcmd_h__
@@ -10,8 +10,10 @@ static inline int iwl_mld_send_cmd(struct iwl_mld *mld, struct iwl_host_cmd *cmd
 	/* No commands, including the d3 related commands, should be sent
 	 * after entering d3
 	 */
+#ifdef CONFIG_PM_SLEEP
 	if (WARN_ON(mld->fw_status.in_d3))
 		return -EIO;
+#endif
 
 	if (!(cmd->flags & CMD_ASYNC))
 		lockdep_assert_wiphy(mld->wiphy);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 6eda6081c8b4..1ab98ba42c76 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -296,7 +296,9 @@ iwl_cleanup_mld(struct iwl_mld *mld)
 	CLEANUP_STRUCT(mld);
 	CLEANUP_STRUCT(&mld->scan);
 
+#ifdef CONFIG_PM_SLEEP
 	mld->fw_status.in_d3 = false;
+#endif
 
 	iwl_mld_low_latency_restart_cleanup(mld);
 
-- 
2.34.1


