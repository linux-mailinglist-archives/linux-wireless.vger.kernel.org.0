Return-Path: <linux-wireless+bounces-22814-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 658DFAB2504
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF2E189D502
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C822D14901B;
	Sat, 10 May 2025 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPx2+YeE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45ED22D4EB
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902925; cv=none; b=Drl3W5Xpw3zlhaCKJUHvD/dqKLdGI0gLA9hkACPfkdsbe81My4NoWB8uwHZnJ3cWL4T/BIJSwVEp6rIQEDCUXnPaiS6yaR+V6jvMkc7EgXEx2NrVzeuTTk3qiIr8xKpI4fDyPVHLvLHMRxQRNVEk0enk7fgTZK5YXRV4mahu194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902925; c=relaxed/simple;
	bh=Rx5/qFwO9kGnJPq4chImfQYZ2PrLW+1ZQR6qaXXxIxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i96BeUG086KPXLQqvbXQ6JkAOz2AsAiZAGuW2FFD1RiPAwpNfG/waIENBTwZ8NJLKhHR3XrTOHtCpXlVaizILBByaZ1LZO7qjXf6+v3oy9Pus0LhP1FPJYHy4M/EFoAh9QVhvkNxCfZwz+yMLgMqsljyzKluxUCodizfCiahirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPx2+YeE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902924; x=1778438924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rx5/qFwO9kGnJPq4chImfQYZ2PrLW+1ZQR6qaXXxIxc=;
  b=gPx2+YeE0i+HfUnp7upz0OWGiB3QHfUD6hCl/LBfdWirF56aW+4Lx6JG
   l7s4ELyHsEM3m5R4YTvDEaAzERxF44d+57/Ze02GpWiV3q42Apr7oJt2b
   gekYcMl3/mkkP6Rzsl9Emv16Bz9Yrz7OFyKMif/eQJz6KqygwoK7ElNfd
   3jVnuxmWtSSGeCMzteniU5aZI3iY+blpB15URC81CdcVH+pZGINSHXs13
   GcCFv/y78CluXYSGniJBqWh1QVHzOT7AN6WZm/9BzIqxlhdPmmn+7PSMT
   pewMu0jWI8powQSKwpAk2dcHSMyJQvP21TFhbFbE+vvaj2qgVwDHb6d32
   Q==;
X-CSE-ConnectionGUID: r6ZWiianSEK6QFwSN+xqKQ==
X-CSE-MsgGUID: H5sg8DhxSD+kfr4vjXR6fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880873"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880873"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:43 -0700
X-CSE-ConnectionGUID: 4OJoym5ITMeHe6GeSTORCg==
X-CSE-MsgGUID: cgKkUdKPSZy/05l5rQgFtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033410"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Eilon Rinat <eilon.rinat@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: dbg: fix dump trigger split check
Date: Sat, 10 May 2025 21:48:13 +0300
Message-Id: <20250510214621.c802d5cc1312.I0cf5d74f91349499ab35eef0ebdc604961e492ef@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
References: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Evidently, I confused the fields here, apply_policy should
be checked for IWL_FW_INI_APPLY_POLICY_SPLIT_DUMP_RESET.
Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Eilon Rinat <eilon.rinat@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 6ba0bcbcd56b..ea739ebe7cb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2724,7 +2724,7 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 	BUILD_BUG_ON((sizeof(trigger->regions_mask) * BITS_PER_BYTE) <
 		     ARRAY_SIZE(fwrt->trans->dbg.active_regions));
 
-	if (trigger->time_point &
+	if (trigger->apply_policy &
 			cpu_to_le32(IWL_FW_INI_APPLY_POLICY_SPLIT_DUMP_RESET)) {
 		size += iwl_dump_ini_dump_regions(fwrt, dump_data, list, tp_id,
 						  regions_mask, &imr_reg_data,
-- 
2.34.1


