Return-Path: <linux-wireless+bounces-21848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A99A97339
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 19:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEADD440A2C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A7C2900AC;
	Tue, 22 Apr 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwywE9M7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8F281369
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341274; cv=none; b=EDzbLW0wLHVL664XOZkfa6IZ2L+juGIhU2Sg9Au0QYLah7SkUbKW5MgsIXRCBgf5QO5uOxIoGwae1PbBHRwBBpnRjojRjw32hrY0T/S5WpkDywYhJcj5MHbEMq/OnpKNllQl4bQ0sM3GqLI2swB9BE8FZaS/veqjiSaDCllUvQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341274; c=relaxed/simple;
	bh=021RLHa79z8O3rv+ZcQ953h0RH4fReYhIPEqB/dtBKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WgKcja12gpiovb9ZuLMRMFf44JxCAeTg9V6cukP2dFr4eT262qfOYRV6ZQ44aj7lUAsLc4xo3xk73TG6pCA5dFGLvVpEKvaagBulVW43OJV8oQDnHG3Q3K/Z2FhP4NLVTUp7GP41bCCuZNi+8IIuf9NYgeiF+SneOZZhMKSAWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwywE9M7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745341272; x=1776877272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=021RLHa79z8O3rv+ZcQ953h0RH4fReYhIPEqB/dtBKU=;
  b=PwywE9M7T6TiMFmwswrejEv2crb4xToadZwl8I/8LRolDTuhtWd2cMtW
   /Sx+Xu35ngGKW0F4qpAqCt/fktdjVJ8fjvPUlcwP2tG0B3M44tvvoA1Yy
   7qytAHzsUPB/BXz5/UDRcBdt2xpyUtrNbC8TmX48SXTD/N/zBVBzPAarI
   HIYPn5PGKQGSMcJ627tDaSGsLBG2hygVdexSc1v1oXm6ezlXpXrRgpSsW
   Aztnw+oNB5P99637oHXkkgLO8Edbo8HzPyMfxEWTKZejA1gakBKAorOfx
   0i8mXkevfNVKOURkRH4xTCfpi79Pn4gR7v4mZeT3Hc5vtdLDogPKBq3Gb
   w==;
X-CSE-ConnectionGUID: xXFgBUASRl6EO9kqD1NiRQ==
X-CSE-MsgGUID: mPvo3I8yTouiaj13VFoq+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46794146"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="46794146"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 10:01:11 -0700
X-CSE-ConnectionGUID: e2WrTSCbR9q4bxCCGhyGLg==
X-CSE-MsgGUID: IiUrHkwRQsafVCig84oGCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="131963055"
Received: from iapp347.iil.intel.com (HELO 8ca39f2fbbbb.iil.intel.com) ([10.167.28.6])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 10:01:10 -0700
From: Itamar Shalev <itamar.shalev@intel.com>
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH wireless] wifi: iwlwifi: restore missing initialization of async_handlers_list
Date: Tue, 22 Apr 2025 20:01:05 +0300
Message-Id: <20250422170105.29358-1-itamar.shalev@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The initialization of async_handlers_list
was accidentally removed in a previous change.
This patch restores the missing initialization
to ensure proper handler registration.

Fixes: 6895d74c11d8 (wifi: iwlwifi: mld: initialize regulatory early)
Signed-off-by: Itamar Shalev <itamar.shalev@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index d4a99ae64074..4bff036aa3a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -75,6 +75,7 @@ void iwl_construct_mld(struct iwl_mld *mld, struct iwl_trans *trans,
 
 	/* Setup async RX handling */
 	spin_lock_init(&mld->async_handlers_lock);
+	INIT_LIST_HEAD(&mld->async_handlers_list);
 	wiphy_work_init(&mld->async_handlers_wk,
 			iwl_mld_async_handlers_wk);
 
-- 
2.34.1

---------------------------------------------------------------------
A member of the Intel Corporation group of companies

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


