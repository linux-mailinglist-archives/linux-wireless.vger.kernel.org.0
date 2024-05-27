Return-Path: <linux-wireless+bounces-8132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54B28D0802
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EBC1C21621
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2816B728;
	Mon, 27 May 2024 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1jf6sUe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9416B723
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826011; cv=none; b=M7M9bYGMgaBi1k1fG9Zf1uFtiZEFNupzMhCtR5UzT3NM4jwVAqkWqVZ4/avIOrLE/L6gQQaeRD2c89KnGNYGFhZfOXNAzYQ3XsPk8yBmuLr2M+RD1vwTa6I2Tko+RyX54yO8NC8jvIS9nEqo4o3Or5C8OjlLD8ensWY0YtBS6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826011; c=relaxed/simple;
	bh=GlDXrMmvyHp+ZQHsgykCIZT2Gm3bqfQZI9tYpK9ENqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdKEKK2YGUrzrlTeWrlC6daKyrZ1Al3rUVGaswZ9TO2lwggiyiMAhb44jgINA1mNhMa5IS8Js/D7gyzKP9TrOs2W8dqwpTEI86KgEid7nn5022SQvDZSec475LopHzBpKVzMH9WpAWUeF+8pFkGT+pWqnb7pqs/hXxK5iASJ8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1jf6sUe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716826011; x=1748362011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GlDXrMmvyHp+ZQHsgykCIZT2Gm3bqfQZI9tYpK9ENqk=;
  b=g1jf6sUejeDm43SQbL7LuBBbVF+cAN0erMo4T5TTFS61QkG+pHGWWEV7
   Wix4NGIFXfQVf13QqfJBUW3XUaSYfQyPIJ0Y4zhAhwASpmEm3VdSWSy5E
   NsdIAUd8js53MSumYk+nH+JKVstpxq0h5BNicvtXFo/8W+0H/TXKviUfo
   mUdBVCFvkb5wzo0FSuFJ/DdsP8Sre49Db7n/AcVyP8Wx68qaGhgEQL5st
   Xs0UzZRrj/YmMX1akoJauSMlQIGagAE+5+2HVngvnLbxrLbD/FlzQYISk
   Bi5pRAfn8L4AsRf6oesH2MZkE7ccvd4kNmKFSiarh+wG2WrdOmgP5t2I4
   Q==;
X-CSE-ConnectionGUID: UAOJ+tlBSh2Bu4zUwH7zMA==
X-CSE-MsgGUID: uX4DZWnvQvi8T/4YTIF1YA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002121"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002121"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:50 -0700
X-CSE-ConnectionGUID: ToJqOvPxQh6H5mXKDLQGIw==
X-CSE-MsgGUID: LJ+WAk3eTQeglDivHMj2FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407143"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 18/20] wifi: iwlwifi: remove redundant prints
Date: Mon, 27 May 2024 19:06:13 +0300
Message-Id: <20240527190228.5c589c7abed0.I3590c4ee0ee99d1b207852c32d25d326afb327dd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Upon start, the different opmodes are currently printing:
1. HW rev, which is already print by iwlwifi
2. The HW name (e.g. "Intel(R) Wi-Fi 7 BE201 320MHz")

cleanup things such as the hw rev won't be printed again, the HW name will
be printed by iwlwifi instead of each opmode.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 3 ---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 516decc647dd..ed9487062093 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1450,9 +1450,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		goto out_free;
 	}
 
-	IWL_INFO(mvm, "Detected %s, REV=0x%X\n",
-		 mvm->trans->name, mvm->trans->hw_rev);
-
 	if (iwlwifi_mod_params.nvm_file)
 		mvm->nvm_file_name = iwlwifi_mod_params.nvm_file;
 	else
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index fed2754be680..92e48cff49de 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1476,6 +1476,8 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!iwl_trans->name)
 		iwl_trans->name = iwl_trans->cfg->name;
 
+	IWL_INFO(iwl_trans, "Detected %s\n", iwl_trans->name);
+
 	if (iwl_trans->trans_cfg->mq_rx_supported) {
 		if (WARN_ON(!iwl_trans->cfg->num_rbds)) {
 			ret = -EINVAL;
-- 
2.34.1


