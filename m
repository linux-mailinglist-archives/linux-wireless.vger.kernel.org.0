Return-Path: <linux-wireless+bounces-20077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7109FA580A6
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1257A66BD
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14283145A18;
	Sun,  9 Mar 2025 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JA07+oKp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA7219FC
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498630; cv=none; b=O4L17mpRtUWFJUExTYRbbJvWsKKOIZ86Miy6KqUw60ygoSexbpIjV8P/ZxZj0LvYv/aWNu9O+ELuadqGq0nO7k2kg/oOFOoxLs+Bms/Rw8Tl1/mYUJvMeT4OqHIRLI+rrAuFvaHZwVt1bLnFO2oSqNu7RuXeBfjEmMAVJcwwCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498630; c=relaxed/simple;
	bh=E5Z4OPGNz8H9581BuBj0UoVBdzsVdMpx+AwxQ29Ihwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tIn0st4sf6fEwnzw7PEHx8eif8kp3w21weJjqH0HiXa246rkrtzBNZLdfhTCWPX4+wMbSuJ2NW2jVTE7wR73TG8bhrdL/4512p1Km17UYDvv8BTVis4H4dHMN+109eoOiIY6Kw5jx+tMKxtKrMKcp/D9iAVFfD9VbeS9ZNaIdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JA07+oKp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498628; x=1773034628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E5Z4OPGNz8H9581BuBj0UoVBdzsVdMpx+AwxQ29Ihwk=;
  b=JA07+oKpiyGENcmA4bUdBJw6ywPXZT8mi4ablz1Odf9+92F0mOA4DXg/
   teiV5q+X/7bDolUS7lohV4IKObpMSv9bjkHQ8Eo4GELzo0hJ2VCvkL75Q
   m8s/B/SoBGW4vXVClv/P/+4G5ANWeq97ncr8issEudhErw+NmXIQiWMnw
   ZYKPnf1dJPJpzWzBU6ofBCFzeGEbl0Q5gP9TSjALzNBfT2NsdMu+fvD2B
   au812pz6+L4NX5DgXZ5TSn5NIovksiHzLwwVRmCW/Tn+eplXtJa2eYUqV
   8al5CVBKQccjF76tYccW9W+uTsjAj3EQsd8cksyWw+htL3i/3c/r6NLCI
   Q==;
X-CSE-ConnectionGUID: 5FbyuLI2QVOuMh8DkSCREA==
X-CSE-MsgGUID: J8ei+qfJQ96ifzHOgfIvHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671681"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671681"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:07 -0800
X-CSE-ConnectionGUID: TRwE5pyHQSyLLH0f5a9kUw==
X-CSE-MsgGUID: ledH8+eYTmauxrkhaeDXnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470593"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 wireless-next 01/15] wifi: iwlwifi: mld: fix build with CONFIG_PM_SLEEP undefined
Date: Sun,  9 Mar 2025 07:36:39 +0200
Message-Id: <20250309073442.6f7e44a27b87.I78b9311019b59477a1961cddc4640b255ceda651@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
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


