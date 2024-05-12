Return-Path: <linux-wireless+bounces-7520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C20F48C350B
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36561C20E0A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E5B1B299;
	Sun, 12 May 2024 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gx8VwZue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B622518040
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488299; cv=none; b=CGZlqNxCpRahkJroHLxFWVQH+YuT2OSNNx6uAwf9Ke16Pmdj8fK4+G5924qLrd6GWKasx6yExt2kMfRPrXCpC7wThky9xlAZAH0sQXKCD/x/3wz8Dh2CCz6CueY+xIsqtKaPoDAKcZEDxiCjD7ysfABAwVeXsdsMENURwizlpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488299; c=relaxed/simple;
	bh=02xpOPIxUWrmTGm+MwU8U5S4B5509jNsZb2bclQsBfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C745GhJ7cEL2fzU2oWQHtVCFfks4ivBMSurU9I5dBaAPN+HmcOmVPlJhxsyMNOM6IvsUQVc0wlVXTr0ZtDVbaC/XLBr7Pacq7lxstvKSACnsS+QrtflroIG9epA8k3f48ylS5DMT6Gmn8eazGx6cRbrgufNLJLNa175czjnqzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gx8VwZue; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488298; x=1747024298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=02xpOPIxUWrmTGm+MwU8U5S4B5509jNsZb2bclQsBfM=;
  b=gx8VwZueX1p/0JjVInc11hwwlBsjmY3P8v1sQupsZUoVs8MJQ4O4Vcua
   xN3Zo4Z4GyT2Pb9xwW3HQ91qsfTMYFxjwW+FMinSSNCIVplFbZyOa9rGJ
   qyIiWbZSADZp8GvwJQXj9zILSUNexLefE4Qg8RUxLntZAR/idJGZD0O9s
   hdoNYqCvOsnpzwltA+lHdiOuPPCnAt9lTyFBBxydYcrlPYstqgo5P3EvR
   Az3HYexV2l628TaYSbByaJa4rpAAS/SyGRnleiqyDQxnfjURs6AIalJfy
   7O5V4kFdkMgQ2DOYLx1wytxjr+cId2b/73Lu4xe7/VPH1YB9HcIuBl5Y9
   Q==;
X-CSE-ConnectionGUID: P7Gcv1KRRtC9DyiJp4y2NA==
X-CSE-MsgGUID: /DN4BH9hTmGSiwtHLZ25vw==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323854"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323854"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:37 -0700
X-CSE-ConnectionGUID: jXMqOGi1QoSKiLPYVDZ6mg==
X-CSE-MsgGUID: 2yQRSPriSy+TkeSJXNcvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532166"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/16] wifi: iwlwifi: fw: avoid bad FW config on RXQ DMA failure
Date: Sun, 12 May 2024 07:31:03 +0300
Message-Id: <20240512072733.faf3a1b87589.I77c950173cb914676fbd28483e5ef420bb9f1bc9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In practice, iwl_trans_get_rxq_dma_data() will not fail,
it only can do that if called with the wrong arguments.
But it does have an error value and doesn't initialize
the argument when it fails, so don't use the value then.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index 135bd48bfe9f..d8b083be5b6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021 Intel Corporation
+ * Copyright (C) 2019-2021, 2024 Intel Corporation
  */
 #include "iwl-drv.h"
 #include "runtime.h"
@@ -135,7 +135,9 @@ int iwl_configure_rxq(struct iwl_fw_runtime *fwrt)
 		struct iwl_trans_rxq_dma_data data;
 
 		cmd->data[i].q_num = i + 1;
-		iwl_trans_get_rxq_dma_data(fwrt->trans, i + 1, &data);
+		ret = iwl_trans_get_rxq_dma_data(fwrt->trans, i + 1, &data);
+		if (ret)
+			goto out;
 
 		cmd->data[i].fr_bd_cb = cpu_to_le64(data.fr_bd_cb);
 		cmd->data[i].urbd_stts_wrptr =
@@ -149,6 +151,7 @@ int iwl_configure_rxq(struct iwl_fw_runtime *fwrt)
 
 	ret = iwl_trans_send_cmd(fwrt->trans, &hcmd);
 
+out:
 	kfree(cmd);
 
 	if (ret)
-- 
2.34.1


