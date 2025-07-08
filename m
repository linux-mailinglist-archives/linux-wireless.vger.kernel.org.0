Return-Path: <linux-wireless+bounces-24986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAADBAFD79F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5566B3A8FE9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0E4239E70;
	Tue,  8 Jul 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cb63Hwtk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44023ABAB
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004287; cv=none; b=His5WUygawnSsHobnoftfHHQYZEECen4w7CLVlgkGwfxRZhPVlLpdeYPFMa52IFPl3uJA55YtheZmCWmJai1CKkrGdl1NNWdV5mUraYTOsIEGceHfY+E2LltcDrLS4m09UnX+yPIuFQR+kyjDaMmz4GaAP3AlokbzCItrvDowtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004287; c=relaxed/simple;
	bh=Jt1LemJ7lyuw0ysHRo6Ek2o3vEj0uvSZY3MobRPaOOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lye+3FWpPa6VkcNDO7MGbrswqnFleSwRrlvR+9EL8k3zr+SHVloGYlARLkDmijqDiey0svTr+F/og8lQOoLhyRbLMFJAhv7//+5YSfVRrb+cV6Vy+LAYFErHB8YgwZdpRnxZsdmwJgPduPpDs57pFLMmLDjI3piGq+awp3fpzXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cb63Hwtk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004286; x=1783540286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jt1LemJ7lyuw0ysHRo6Ek2o3vEj0uvSZY3MobRPaOOY=;
  b=cb63Hwtky65eEzkZeBzoBhHEbmGaqlTtWJccka5edHMP0VSgXntGaQsd
   2FA0/Ec/OcSF8CjBMbMkOGWQ1LzxmVw74A9KMYByA2qWtEmvo8F1MXUJ4
   OHzvCv0kd0saodY9B1DqN1jRabjrF0sHdUlVJTRh1XMGsOW4vdHzeaoog
   6JvjDZPmgrZU06on14U3gxBSpfHsT+J57oSmjWN4cFbXqXxLY+051aWO4
   B1Pnley9isIJe5AHq3TqOtYIko7Z7SWTDGguPQYBLJftPlMZpeIwETvog
   fPMHnxQVwgSiXc4a4zwtPlMj6rBCKJrGI01BzHmoB19Dp39W7G65y7dt7
   g==;
X-CSE-ConnectionGUID: 6g+hEGHOTEKZa7vJsLkt5Q==
X-CSE-MsgGUID: Ay+LmJcWRhSx+9XNKT646A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54229721"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54229721"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:26 -0700
X-CSE-ConnectionGUID: 3sVRORWORFqlBv49Ek1UvA==
X-CSE-MsgGUID: xLB9uA8oRuOO5BzZvJx3lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155668973"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: remove Intel driver load message
Date: Tue,  8 Jul 2025 22:50:47 +0300
Message-Id: <20250708224652.620820f8111e.I16a9cbcfce92a1d1b8b26a20ea9911e8a5a0b1cc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
References: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
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


