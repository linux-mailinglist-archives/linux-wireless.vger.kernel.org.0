Return-Path: <linux-wireless+bounces-22327-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93017AA7194
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE193A59A4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1826ACD;
	Fri,  2 May 2025 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Olgsd2CC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088525484D
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188449; cv=none; b=f6iwTxu9dwVdW/rgW8WVkGLZX4kjXBrcpOGMqoRjJfKJLbPKAgSxcNUU3hAL0rTgjCt3AzQIBkt6PIvtGgRA/iRL8L9oR+0gcvUx6+j5GtDTDAdMIKtE2YOXu4ULmuplXNksiQ0pTm6qA0q0L4WyT4X+oT6xjXtuM1PIyo229Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188449; c=relaxed/simple;
	bh=VyGgffmaF+AbLnxi3qum+3PrMSJKKuNEDt2kvrUzeFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzXK6cZtXllfT/TknsrIry2jy4h3/IfqNSjkc/YScqx8w/RKC+jWrwow7ukKKiDAXKjmgedZbxSvfu4pcPkNk8qWvOCcRKQCQjHa9lTpQ1VAuXtJL3GOuUEYBN6Vtvzmb0tlg+cOflueqqGEgfj+TS/oOrGAjBkAN1wlNQVfS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Olgsd2CC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188448; x=1777724448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyGgffmaF+AbLnxi3qum+3PrMSJKKuNEDt2kvrUzeFg=;
  b=Olgsd2CCB1FmO9HaFNA2J13/ppv3ahd/X6RvDrh5ehuplzR8ULNsyJbq
   ebNfOsU/mGZL0AiU7iaiNWkNf8Vn2Z8Ax7G3KDWwez2cmer2fxT1l1t3H
   l9ZyxrB6OiJGBMne3lznohmeNQxywT64EeSi18vEQ0cwpkys4mPEmsftA
   I6o/DGN/9092IfmVOdbfnD3n/9A8mQMDUGLW+LXMenTSBbkCRiSxqDWeY
   qy13R/mbeSPvkLKDxPhV0vOHitz0Cx3fJBWRm2BeEigbIAGy3VMs1un8t
   QoND5PG07ccFhr9oi0ryA6zZ0G1luezpftlO262cL99mdH7Su6S2MmRe9
   A==;
X-CSE-ConnectionGUID: Ql7ko1DJRJC2cv4B/da5hA==
X-CSE-MsgGUID: GOwkB/2kQwa8tT2Sz8Yu+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010348"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010348"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:48 -0700
X-CSE-ConnectionGUID: PZPC5aESTDaotLMUn2CP/A==
X-CSE-MsgGUID: DEYWqwHqQfOQkHD+qh9+Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586097"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 02/15] wifi: iwlwifi: remove TH/TH1 RF types
Date: Fri,  2 May 2025 15:20:17 +0300
Message-Id: <20250502151751.7677cffdfae2.Idd76734c310cf5f27de43d24e71b27467ab5905a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
References: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
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
index 0330e55e8480..7b09edc2430c 100644
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


