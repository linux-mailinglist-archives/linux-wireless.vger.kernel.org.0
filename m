Return-Path: <linux-wireless+bounces-16832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D9C9FD1BB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB3E3A06AA
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8162BAF7;
	Fri, 27 Dec 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFQ3IU9I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24AB7083A
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286505; cv=none; b=mz74MPBShrdman0BgOHXQaLlfpqg63H6pdceCw2G7vAI749zfT+wXgr01isvr95T1ELB79AmyKuTaEVcaw6tRzFlz8O6Ahs2hdhBJznan4qNDzwBHzFJ7IiSjlxJ0cGOSEBJauBS22CvX0bpUHcerPx6nL5gltY5ER7GhyWQ9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286505; c=relaxed/simple;
	bh=mPVW1jPPJt3asM8GdHbJYaT3oPg3xBAXP+tmsQFl45w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfHjOxdgyNBUySiyX24saRNG3wa5H9Lc6Um9GsMtawzJHaFq88HDNtV4tkHl5mz067cQq6M6yv6jtx5d4mz3f+y7UBSZvl3pexcIIcCS0h32qOPLG/27nPDwdRKXL2A1zBZEzc4TDi1g6+yFSrjpub+BZizCh0gBEjznOR7BQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFQ3IU9I; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286503; x=1766822503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mPVW1jPPJt3asM8GdHbJYaT3oPg3xBAXP+tmsQFl45w=;
  b=iFQ3IU9I3r3w6IY49NWyTmA/TeLpHS/5u8pcEFmmNEBrmEn9QhhkUG5n
   5tOgIqH7HWzGnzQWw3koM3z9exBXjVcsofi/S7/Y/E4NACiztP12DHsyj
   7krk1kW9IigpetRJSE2ii36Mf7CXHiEGR7VbJYo+SPiLPMybqXHfQW6xp
   QoaRrd+KtK452j2Z4172LFw4wsgaj2Sk0HUKd3oNYL+Ip+PUP75Fc1Q+O
   RzIilaKqCfZVqncdX39JSxnFcksks9MJIhlhruc2Z0VmrXxq85NHYQVxs
   op7h6g02t+C/FXJ4fnt+IN7MZ3LLeP4llFBqEon5plfXFN99czQ2SDmgJ
   Q==;
X-CSE-ConnectionGUID: kdE4QAmhT6iLuNr1oZmByg==
X-CSE-MsgGUID: fgKotgEBQKyAM4BflgUU2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690970"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690970"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:43 -0800
X-CSE-ConnectionGUID: eaNpZvHjQfeMzemc5WhjPQ==
X-CSE-MsgGUID: W3yjH4loTfSDE7SHz5MYgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858352"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/17] wifi: iwlwifi: restrict driver retry loops to timeouts
Date: Fri, 27 Dec 2024 10:01:05 +0200
Message-Id: <20241227095718.a21bf40b0fd3.I70166e460906d6d183359889d7543b9c587b7182@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We had reverted the retry loop removal because of an issue
with PNVM loading, but that issue manifests as timeouts.
Since the retry loops aren't needed in other cases, only
do them when there were timeouts while loading, not other
errors.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index d7bf996d3a82..61ac62591161 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1435,12 +1435,15 @@ _iwl_op_mode_start(struct iwl_drv *drv, struct iwlwifi_opmode_table *op)
 		if (test_bit(STATUS_TRANS_DEAD, &drv->trans->status))
 			break;
 
-		IWL_ERR(drv, "retry init count %d\n", retry);
-
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 		debugfs_remove_recursive(drv->dbgfs_op_mode);
 		drv->dbgfs_op_mode = NULL;
 #endif
+
+		if (PTR_ERR(op_mode) != -ETIMEDOUT)
+			break;
+
+		IWL_ERR(drv, "retry init count %d\n", retry);
 	}
 
 	return NULL;
-- 
2.34.1


