Return-Path: <linux-wireless+bounces-3110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F58490FE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A1F28346E
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74393D98E;
	Sun,  4 Feb 2024 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUy1HhXR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593A13D392
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084411; cv=none; b=SIni9ey0fbIhYtAZFvMhiYvQJXSnF2yyWk568dDMvitddMKBrRmSclpF1XIWHXiSkP0KMV01QyGpt38zhtp7JHluymOtaRQ/Vc2XymmCYUk0MeVB47t25W681d6tZALiETME/ouC1JD9l5bSC9yJgU36xEiPqqxOS1hc14LVT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084411; c=relaxed/simple;
	bh=Ys9NnU4n+cuG0mcI08ClPT6e/xvVsf7e+O6TRpFvesc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tf6AHZ/Zp7RKpPglLeMmoLjnDLmJAF6C74MaN/1hXlH+Wewyq19mW4LF8YXtRUs/+pz7foACAn0pTPCgECVJ9r1PimW8bo9SVSgjMWzKrZm1loMx3IEEeJ+TEX5/olOKrfNGCMLPsa3k6nM+TxOrULPDSCTjFA3wH78EZ/BXHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUy1HhXR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084410; x=1738620410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ys9NnU4n+cuG0mcI08ClPT6e/xvVsf7e+O6TRpFvesc=;
  b=jUy1HhXRPxTTCLErh1BVu5A8WxUzU9+v0Abt8bt1BenLGtAUsLFNXDWu
   wcGPd86BBZ5YVCbXpIjr0bmE5aunop5uCx7sHM8DI6Ms1z3cHKnCeW2LR
   KuQ+ddH6Y7o7xKksL4qd8ZdhkCMpV2nRmoKeT7VpwcCI5mMRfmVRxAix/
   U4bedF2/Z3ckembpCx5NcVt9VZnK9/MXAdgTsEgJPCzZPgA26Jil92VIG
   pkgoBwti+pw9+Mn77JQp/3C471BvIoMrXVf+xZ/JCLXeA3L2g1+UPY+wa
   s20dIZ7zNe8bERbQQtfMi1gCDWDx/kbtYNQw5sVKPvcjIyokG1BLzhldn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869384"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869384"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815888"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: use system_unbound_wq for debug dump
Date: Mon,  5 Feb 2024 00:06:11 +0200
Message-Id: <20240204235836.75c8d2286f81.I478e9faf422f22ae66c0a113003fea83565c5692@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This can take some time, so it's better to use the unbound
workqueue.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index b877a2cd4005..154ce92d126a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2879,7 +2879,8 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	IWL_WARN(fwrt, "Collecting data: trigger %d fired.\n",
 		 le32_to_cpu(desc->trig_desc.type));
 
-	schedule_delayed_work(&wk_data->wk, usecs_to_jiffies(delay));
+	queue_delayed_work(system_unbound_wq, &wk_data->wk,
+			   usecs_to_jiffies(delay));
 
 	return 0;
 }
@@ -3181,7 +3182,9 @@ int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 	if (sync)
 		iwl_fw_dbg_collect_sync(fwrt, idx);
 	else
-		schedule_delayed_work(&fwrt->dump.wks[idx].wk, usecs_to_jiffies(delay));
+		queue_delayed_work(system_unbound_wq,
+				   &fwrt->dump.wks[idx].wk,
+				   usecs_to_jiffies(delay));
 
 	return 0;
 }
-- 
2.34.1


