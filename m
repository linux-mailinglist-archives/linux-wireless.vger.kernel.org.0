Return-Path: <linux-wireless+bounces-18666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66479A2DDCE
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 13:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4471D3A458C
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15EF1DDC22;
	Sun,  9 Feb 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FshmCKDy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140F1CCB40
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104519; cv=none; b=fGP+25Cvk20WbfXCg6tnpW//37wQmun6T1mPSZcIGLhNuoynwkDFmJxM3PyirVjHkGnMeZuqj0+SeFjlnJnjSCxX/vG7E6f875wg/49XazJ2tfNjSaP/K200rvlHgZDSyGf8ti22OkwP94jqFt1uV3bAXQkDJRcze1m+57lEYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104519; c=relaxed/simple;
	bh=KlPm5iWWgWagsIpk4sTL7/2jAggTVN+kQQrBdjYkG5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdk0H3Y+QuTSAOB0o8gQC4xMccd7cQRDAQj8TI/5/TFLTmZV0TdWbhWafnObYO2sMkHCHO4e+KrOKbhw/xmGs+cpSlDVZEdyUjC5873MvVqozWAFLAC+Rrtplymntg/XuvkYrqPtcExPnZABiWJkORNtRcqsaEc5IC+qMk9xNn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FshmCKDy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739104518; x=1770640518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KlPm5iWWgWagsIpk4sTL7/2jAggTVN+kQQrBdjYkG5g=;
  b=FshmCKDyOa8RzacEngV/HvhW7T32dKyjUmS9NXRoQti48eMjJyX0OcAH
   P0y6E++eLnai9btNgZ75QFK2XjF/NTncWkUER6zbC9afeZIRLHqKvtD+s
   L7zcAoVvIHogHwWz04mZVqE0/Hj59KKIrJn+gAei+dSvq6wcjqRi61bxn
   MlLzSinttUUpKtc/YvSpYe2yrrIGWCIM6/we2LjPof08J0EMtvx+U7nCo
   ErtC7Ea+Q4LvU+9z4sMvmCZDpOaSUMVUqInXjvPCgga2XF6SgiW0T639S
   Y/vMl7bjl6AmO6hbD6On5TqxxSrLZbOsSMPwGpFjufVY7j9y1VeFEcgM6
   g==;
X-CSE-ConnectionGUID: o+gTmbsCReWQVif+Pqnybg==
X-CSE-MsgGUID: CHJHqQZ1TDiE8NtKxtucrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51125980"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51125980"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:18 -0800
X-CSE-ConnectionGUID: lMaqsOo/TY6boPNuP/NvtQ==
X-CSE-MsgGUID: PY8ED3FpT0e6pfyQetOVIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111782446"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:16 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 5/9] wifi: iwlwifi: mvm: don't try to talk to a dead firmware
Date: Sun,  9 Feb 2025 14:34:49 +0200
Message-Id: <20250209143303.8e1597b62c70.I12ea71dd9b805b095c9fc12a10c9f34a4e801b61@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
References: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This fixes:

 bad state = 0
 WARNING: CPU: 10 PID: 702 at drivers/net/wireless/inel/iwlwifi/iwl-trans.c:178 iwl_trans_send_cmd+0xba/0xe0 [iwlwifi]
 Call Trace:
  <TASK>
  ? __warn+0xca/0x1c0
  ? iwl_trans_send_cmd+0xba/0xe0 [iwlwifi 64fa9ad799a0e0d2ba53d4af93a53ad9a531f8d4]
  iwl_fw_dbg_clear_monitor_buf+0xd7/0x110 [iwlwifi 64fa9ad799a0e0d2ba53d4af93a53ad9a531f8d4]
  _iwl_dbgfs_fw_dbg_clear_write+0xe2/0x120 [iwlmvm 0e8adb18cea92d2c341766bcc10b18699290068a]

Ask whether the firmware is alive before sending a command.

Fixes: 268712dc3b34 ("wifi: iwlwifi: mvm: add a debugfs hook to clear the monitor data")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 83e3c1160362..55d035b896e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1479,6 +1479,13 @@ static ssize_t iwl_dbgfs_fw_dbg_clear_write(struct iwl_mvm *mvm,
 	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		return -EOPNOTSUPP;
 
+	/*
+	 * If the firmware is not running, silently succeed since there is
+	 * no data to clear.
+	 */
+	if (!iwl_mvm_firmware_running(mvm))
+		return count;
+
 	mutex_lock(&mvm->mutex);
 	iwl_fw_dbg_clear_monitor_buf(&mvm->fwrt);
 	mutex_unlock(&mvm->mutex);
-- 
2.34.1


