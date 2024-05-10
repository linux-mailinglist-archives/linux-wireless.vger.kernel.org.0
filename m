Return-Path: <linux-wireless+bounces-7473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9C88C2667
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F72286167
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CA172BBC;
	Fri, 10 May 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5OmxBUC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23050172799
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350036; cv=none; b=g2F68ln0wr/EeNi0sjXJRe1bm/8/prAUoufflakhPOUdnyMsUj8En336iwrMA53/+AHbaY9Ww7l/cAz7WkraZUpM9zpOe4USfyq5MhY4u8iTkg+Mx7Mmfe3fSlp1vMJ4AxmkbBSxliDG+KmKKnAuTRd+EGyqu3BTi6lXCznNBd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350036; c=relaxed/simple;
	bh=OMXDzdUn332TT8eWLgMaC7FaoUKdgjTVDtwFY7O9mXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URjUWKkZtmxS35u5Gciplo4mkoi6f3Kmjnp+11oCNZH6GCQr72A7sco1FyOuN8WwZafMKvi9FMf5f3+fqlly9qDZUv8y3MKZY9G8Xwmi3XIEqQuJo3ol9FJaoedK+2ERQGMy2Hqnu+IypJAEKBb8yfltXqEW0ktyXvCGNfhmNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5OmxBUC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350035; x=1746886035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OMXDzdUn332TT8eWLgMaC7FaoUKdgjTVDtwFY7O9mXM=;
  b=d5OmxBUCbo60aBdsiyWPYw0erPBxoGsmscjn4CHJEXg1licJXKy6qo1U
   p4CtCE2E6xMZbOHDU5tfOcID7KNlWbp+4XJVfYe2GlT7OCDyUcdvDv0yB
   mfYBDs/nZ3n/0sa18oVDiZ20km/PNVH4Ockqx0ph23WB2M77YC35eiKAL
   o4qxor9MEDirMYdO7VstEKT+EsWA7BEKxQJorNn5vGsm1NvO+wiTBkvXc
   WsM2s/4zx5DboonBGyS98Uof+jtUGhW3Nv6UfZ/PHpgumNLujNEp4Z/kh
   hezVLeDaXZICylUsYTL7X+z+Fh1WYyG1ihv3e/fwe+EmgjC6ittmhK3BD
   Q==;
X-CSE-ConnectionGUID: fG2H9WTGQcCREBj34ghWpw==
X-CSE-MsgGUID: eeKFZiaeSumrCkkHAdRvDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125649"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125649"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:15 -0700
X-CSE-ConnectionGUID: cNVXgoa2Q5iFTpCjV18yJQ==
X-CSE-MsgGUID: 6pSkuJA7Rgipb5PfeW0WMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101914"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shahar S Matityahu <shahar.s.matityahu@intel.com>,
	Coelho@web.codeaurora.org, Luciano <luciano.coelho@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: remove fw_running op
Date: Fri, 10 May 2024 17:06:40 +0300
Message-Id: <20240510170500.ca07138cedeb.I090e31d3eaeb4ba19f5f84aba997ccd36927e9ac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

fw_running assumes that memory can be retrieved only after alive.
This assumption is no longer true as we support dump before alive.
To avoid invalid access to the NIC, check that STATUS_DEVICE_ENABLED
bit in trans status is set before dumping instead of the prior check.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Reviewed-by: Coelho, Luciano <luciano.coelho@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c | 3 +--
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c    | 6 ------
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 751a125a1566..893b21fcaf87 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -230,8 +230,7 @@ static ssize_t iwl_dbgfs_send_hcmd_write(struct iwl_fw_runtime *fwrt, char *buf,
 		.data = { NULL, },
 	};
 
-	if (fwrt->ops && fwrt->ops->fw_running &&
-	    !fwrt->ops->fw_running(fwrt->ops_ctx))
+	if (!iwl_trans_fw_running(fwrt->trans))
 		return -EIO;
 
 	if (count < header_size + 1 || count > 1024 * 4)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 9122f9a1260a..d201440066ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -19,7 +19,6 @@
 struct iwl_fw_runtime_ops {
 	void (*dump_start)(void *ctx);
 	void (*dump_end)(void *ctx);
-	bool (*fw_running)(void *ctx);
 	int (*send_hcmd)(void *ctx, struct iwl_host_cmd *host_cmd);
 	bool (*d3_debug_enable)(void *ctx);
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 53283d052e18..f19577474f4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -770,11 +770,6 @@ static void iwl_mvm_fwrt_dump_end(void *ctx)
 	mutex_unlock(&mvm->mutex);
 }
 
-static bool iwl_mvm_fwrt_fw_running(void *ctx)
-{
-	return iwl_mvm_firmware_running(ctx);
-}
-
 static int iwl_mvm_fwrt_send_hcmd(void *ctx, struct iwl_host_cmd *host_cmd)
 {
 	struct iwl_mvm *mvm = (struct iwl_mvm *)ctx;
@@ -795,7 +790,6 @@ static bool iwl_mvm_d3_debug_enable(void *ctx)
 static const struct iwl_fw_runtime_ops iwl_mvm_fwrt_ops = {
 	.dump_start = iwl_mvm_fwrt_dump_start,
 	.dump_end = iwl_mvm_fwrt_dump_end,
-	.fw_running = iwl_mvm_fwrt_fw_running,
 	.send_hcmd = iwl_mvm_fwrt_send_hcmd,
 	.d3_debug_enable = iwl_mvm_d3_debug_enable,
 };
-- 
2.34.1


