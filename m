Return-Path: <linux-wireless+bounces-13669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E2D993DF5
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0F51F2490F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBBB13AD18;
	Tue,  8 Oct 2024 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViF4DJFo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59813AA2A
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361551; cv=none; b=nObd1UKPst2x8kmnjDOShKp8I4TsHJemt6fVSelbvSkGVEhkyID+qdxtfjaGNOJokR1OGIx1oJKIX4gFV45IXVTLPR61MeBC2NSUYOJo6v7GFUFzJ5uUJ+kS3MH9YBb+g6ZYGtoIP4B4GdbbNBEfLxqzFv8u35XE/hc19Tlj1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361551; c=relaxed/simple;
	bh=anFFpWbCjBeMTRyD3jarTGcTRgTJWwQq3KtWu4w1GX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4EYBFQ9ARKQupkXZK8F2GvV4HnJ3QyBOaRTVccZiA/2Ahq0Kwlc/tBkOn6WKi/8VFq+BaCZ8liR4nuoQ1tYdsPrsUDZiXyoSum8+A/eCpehHcioKqJJKoojHYtPeG9WHZlMNOxvRw2XbUanjefHu6T0QXqBf7O9UGPo3pRM+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViF4DJFo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361550; x=1759897550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=anFFpWbCjBeMTRyD3jarTGcTRgTJWwQq3KtWu4w1GX8=;
  b=ViF4DJFoETNP1OUg+GB1nvrgyT85FnRhC3Cx82nrR/HcEdfJB5fSdNl4
   S34MAKLhb7lqp+EfCzLFccgRU2/34yWnFzRDj/RugDK3mwPrxXHdpI/kp
   6ZcXoBr33e9nrnKlWR2SPmTDPr5gMnmgb/lceQrROrB/SIZ6xr1CQAIeM
   cvhPdKka/YMMvD1ZJ2KW2996e3bH+WBaOeCTiPUN2Gn112W+EJtNoRu2D
   fx22BfL9eajcX3tUTVdHY72cwOVnJNcGBNtFhmCBHy+0JWs2xULpj/dlT
   FBI/dnc+ny6mnpk+jI2Zrcvc1O3RyCQWm671N3n4Z5uIcT6FWHAZwDK90
   g==;
X-CSE-ConnectionGUID: sIYMlB8IQJKp0qAyydsEww==
X-CSE-MsgGUID: L6kjWwEySc6eL5E0G7CMHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024274"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024274"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:50 -0700
X-CSE-ConnectionGUID: NcrGnO0+QhWMUyjhbRmD0A==
X-CSE-MsgGUID: oMNVVOdlSse0raMHzNoEVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486328"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 06/14] wifi: iwlwifi: bump FW API to 94 for BZ/SC devices
Date: Tue,  8 Oct 2024 07:25:20 +0300
Message-Id: <20241008072037.7ddabbd42131.Ib8bd35521a317c14b3a2a2e5983cf5bca5e8718b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 94 for those devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index fa1be8c54d3c..ea40d402681d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	93
+#define IWL_BZ_UCODE_API_MAX	94
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	90
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index f1dd1c29f305..635fed641c19 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	93
+#define IWL_SC_UCODE_API_MAX	94
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	90
-- 
2.34.1


