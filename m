Return-Path: <linux-wireless+bounces-22293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 955C1AA5CD5
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355561BC1E58
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838C22D4C8;
	Thu,  1 May 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuEkz1QW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1022CBF6
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093597; cv=none; b=tM47f2nIkQH0u2O+oTt1dg9xi+pY2xfMgzIJphMDqTZ3jbjgfvB7W8iwBdfoPVzcR6rqAfvxMxl8Kv5CZHdS8AIrs1l5rJLwZRjZTkkFpQXfzjimJf6/qhYBY52brAmUePyyplgioCkCDvvBSPGJ5errYbsTNZ2+TrRR0Ut0dRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093597; c=relaxed/simple;
	bh=LGy4yo5s9ZRbu9O4DPXGCUWq5myzz/5UFKGVuOOEa4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZxB3Ul42S8ZlmccdWCgeSsLMq6Gv7A5o8gHudmM1uDkG9L8VOgtPjxvp18i0QNkUJUxZ4xw0tNADrnaYDSZii+RVziFpNDQVcxGNgWXAcgNUQIeTLpkBhEkn5qJHoM8KGtYFRBJrK0u54vtOsCyvc3fTxa9u5yQNDhLIyktn/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuEkz1QW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093595; x=1777629595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LGy4yo5s9ZRbu9O4DPXGCUWq5myzz/5UFKGVuOOEa4o=;
  b=FuEkz1QW+xlfVgv7BnPW6Ru9sQCOqBzf0UNBZQygh2W3zRDVrWB1MaSF
   RNubQPBG5STofOvHJkiWe74jwJh4qwQ35WUr+qXmed6TJ4c4yGWsvY4Lc
   eNu381Vy4+PPkHDtmWjQmM6N+VdBbcbQUUgBvlwquedkffKWF59l0WZOB
   yQxsSduXRMuKmhZKxHvtso3DPS9KcgiT6ezvK7kYNJJGy988mJYVrz4oT
   zMHTYZgfvNfqMEFrXByQ07LdsQIx8ikPXG8dIISCiTVcCoMeStyCuCoGa
   R+FfsTCfpkZNePp6ya1zHMMhXA7TAUhNQV8egOIA5CPH2p+FKWIy1iuzu
   A==;
X-CSE-ConnectionGUID: SV04EdkGTyyc5vqu48fV7w==
X-CSE-MsgGUID: zJFhnXSdQuiSLbCVj0UjcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962820"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962820"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:59:55 -0700
X-CSE-ConnectionGUID: bI1I596dQMGdUBGA9GxN4g==
X-CSE-MsgGUID: gX5BoljoQ3adyJ8PPfnSoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135317934"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:59:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: remove TH/TH1 RF types
Date: Thu,  1 May 2025 12:59:24 +0300
Message-Id: <20250501125731.d0e40b4a4114.Idd76734c310cf5f27de43d24e71b27467ab5905a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
References: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are the same values as JF2/JF1 respectively, and
that really matches the code names. Remove TH/TH1.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 12 ++++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index b9bd89bfdd74..f9fdb7c97636 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -432,8 +432,6 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_BR		0x4C
 #define IWL_CFG_MAC_TYPE_DR		0x4D
 
-#define IWL_CFG_RF_TYPE_TH		0x105
-#define IWL_CFG_RF_TYPE_TH1		0x108
 #define IWL_CFG_RF_TYPE_JF2		0x105
 #define IWL_CFG_RF_TYPE_JF1		0x108
 #define IWL_CFG_RF_TYPE_HR2		0x10A
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e9660d05d55d..2480fba9b140 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -903,24 +903,24 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     BW_LIMIT(80), CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9270_160_name, DEVICE(0x2526),
-		     MAC_TYPE(TH), RF_TYPE(TH),
+		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_NO_LIMIT, CORES(BT_GNSS), NO_CDB),
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9270_name, DEVICE(0x2526),
-		     MAC_TYPE(TH), RF_TYPE(TH),
+		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_LIMIT(80), CORES(BT_GNSS), NO_CDB),
 
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9162_160_name, DEVICE(0x271B),
-		     MAC_TYPE(TH), RF_TYPE(TH1),
+		     MAC_TYPE(TH), RF_TYPE(JF1),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9162_name, DEVICE(0x271B),
-		     MAC_TYPE(TH), RF_TYPE(TH1),
+		     MAC_TYPE(TH), RF_TYPE(JF1),
 		     BW_LIMIT(80), CORES(BT), NO_CDB),
 
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_160_name, DEVICE(0x2526),
-		     MAC_TYPE(TH), RF_TYPE(TH),
+		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_NO_LIMIT, CORES(BT), NO_CDB),
 	IWL_DEV_INFO(iwl9260_2ac_cfg, iwl9260_name, DEVICE(0x2526),
-		     MAC_TYPE(TH), RF_TYPE(TH),
+		     MAC_TYPE(TH), RF_TYPE(JF2),
 		     BW_LIMIT(80), CORES(BT), NO_CDB),
 
 /* Qu with Jf */
-- 
2.34.1


