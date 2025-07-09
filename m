Return-Path: <linux-wireless+bounces-25029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BD5AFDE84
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47FD57B7925
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D713224240;
	Wed,  9 Jul 2025 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlJG5Cru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD722333D
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032651; cv=none; b=QGLvlLjqR76tNLXAlP+J9Ei5JZ/wfbbO4PkQiRg16Jq6IbkCatxlO93KLw9aBMaQwx6A2v4B3itoFXGLSdKTVmWodXlbh5pn35DBy9YvoPHAuoAJL2/GxoB24h7OFHp9/npZmwYre7986Gr2ExsSV9+jYECMvu7fAyNVqFp7LQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032651; c=relaxed/simple;
	bh=Jt1LemJ7lyuw0ysHRo6Ek2o3vEj0uvSZY3MobRPaOOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eiVMV3nAqM6lkx0WeYv+/gLolybcOcZRLAGtbET5sQ5rLNTyyrx+jvvxJS7i02FpSHEC/cG8tr/MsgM5pPxX1XL+E2piUuigroU44aEDuHabogpiNwVKVZiBp9ODGCMEmVhGyACL122Lp//a5D8DZz1p15LoSs0bfNcEydpQ6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlJG5Cru; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032649; x=1783568649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jt1LemJ7lyuw0ysHRo6Ek2o3vEj0uvSZY3MobRPaOOY=;
  b=IlJG5Cru4REu9WZ2ZsujQ+ojSlfBG/pZF+zgedxUudIiyNfJNEBvF/Lg
   l0+EtdvvqakelT94anMpwO4cpl2UsQ0i9qZsmstv7LgT2aK2CLIDBzol2
   wnCZC1kpY75WfEbqJSzfKrhgsZwZZmq7aZbyxOO+1nmnsVrbuJTrg3Rsq
   j5VYdMujdXipCHRh1FsePEcCpvaTdBgNEuOPJKO3soGT+NPrZ2Z0S2cJb
   F7JgwmTa/ZiMfJefyJdIiIpYDcBOh7CE2MopjR9/vCpb50gTYiP8ohvdm
   k4wrawbrv7WoluRQK4NXfJNs4mOM0sQzYE/VzijgtmR8Uf44L2TuF1xc9
   g==;
X-CSE-ConnectionGUID: Fbkj4GxXTpqtv2kaIQX3qQ==
X-CSE-MsgGUID: w/f3Qov/RwyNiZG9Jy6BIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720648"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720648"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:09 -0700
X-CSE-ConnectionGUID: 0o986mZLRsO3laTG+bSfyQ==
X-CSE-MsgGUID: 97KiQPxNTjapFKaCzOYK2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390563"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 09/15] wifi: iwlwifi: remove Intel driver load message
Date: Wed,  9 Jul 2025 06:43:33 +0300
Message-Id: <20250709063858.76c05f66a65c.I16a9cbcfce92a1d1b8b26a20ea9911e8a5a0b1cc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
References: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's really not much value in printing something just
because the driver loaded, remove that message.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 064ff2135411..f62f7c7ee7f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -2049,8 +2049,6 @@ static int __init iwl_drv_init(void)
 	for (i = 0; i < ARRAY_SIZE(iwlwifi_opmode_table); i++)
 		INIT_LIST_HEAD(&iwlwifi_opmode_table[i].drv);
 
-	pr_info(DRV_DESCRIPTION "\n");
-
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	/* Create the root of iwlwifi debugfs subsystem. */
 	iwl_dbgfs_root = debugfs_create_dir(DRV_NAME, NULL);
-- 
2.34.1


