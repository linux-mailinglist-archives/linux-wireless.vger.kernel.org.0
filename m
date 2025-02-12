Return-Path: <linux-wireless+bounces-18812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779EFA31E1E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB691623D7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90811FBC94;
	Wed, 12 Feb 2025 05:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="El99vpOs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC51F9423
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339039; cv=none; b=sykxLsDB65IP60TgT14z0r5bjR4SvByk2/UlxpXIWhuKvhJ9pxeYUvT9LKmd1l4AdgQUrWfEyV87MMqCJ7heiedGbodjF+QUwJYmYotBtbzzRBVwzRcTuPldu2yr2trxDFPZa30z9ZBiZhLFflzSltZXL8m7Egf3FcLhJH65dqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339039; c=relaxed/simple;
	bh=EBzdhNBBbQBN8UIwLWPe3XOTZMW202GEcXqb4f1yzSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbmKuu0uGBDFgqtqwvhP1eHryuWaWnjEYzj9U0OUChsPCHAUFdxPZxEQ3jAkZaAYR6JI3uRqyrmnk7MZdJ5hoWU9yd3YwAUlwp/nImJE7PwbaBUtUBPU9OwTzIQOadratZrFB2ne9oF1cwUFU4ZsnOAWyyf1/ucanWCKgAwcU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=El99vpOs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339038; x=1770875038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EBzdhNBBbQBN8UIwLWPe3XOTZMW202GEcXqb4f1yzSw=;
  b=El99vpOsg1SQsrXX4PR+iOMFk7hczPSaB+Tc8Bd2iNfFcattQJimYH7v
   Rhw9MUoVVVpDDCF2v79aC5BjeBh22qUKywvhXzl92gWCbOuM2MQ8RbhJF
   HjNyVxWVojSKy+dO1slbIxBefJlyEbEmFpwmlzuESfXo2JHsF/opwAeFL
   7sLzxmnh1Dj51pLfq2ddUIrGRa/NgfOnRjYhlSN5sipYwjaWHQ7mV/Vca
   QuvmvBnxnW1Lyjkzfg5wlZfT3hmyWqJY1ydwFZcdQt9QT0Gkan8I7BW6d
   /DubfY13C9W6QOtOit/G2OeFc1MRyBCO1seCriR+RNOv5ge5aLB0zVUgn
   w==;
X-CSE-ConnectionGUID: 7yry0Q18Rb+X5rv9iM0oTg==
X-CSE-MsgGUID: NR5Hn82iS82f7KOPe91i6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172219"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172219"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:58 -0800
X-CSE-ConnectionGUID: 0dSzpPv5Q7qs4Irbat3lag==
X-CSE-MsgGUID: YG2IBNklTli+MMx2nMOo/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893877"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 07/12] wifi: iwlwifi: export iwl_get_lari_config_bitmap
Date: Wed, 12 Feb 2025 07:43:28 +0200
Message-Id: <20250212073923.9bb7fbc592a6.I8850691eac7c8471257f3031e8c05905afc72f70@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
References: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This will now be called from another opmode we are writing.
iwl_fill_lari_config will only be used for the older ones.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 7 ++++++-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 11f54339acc6..6adcfa6e214a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -474,7 +474,7 @@ bool iwl_add_mcc_to_tas_block_list(u16 *list, u8 *size, u16 mcc)
 }
 IWL_EXPORT_SYMBOL(iwl_add_mcc_to_tas_block_list);
 
-static __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
+__le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 {
 	int ret;
 	u32 val;
@@ -521,6 +521,7 @@ static __le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 
 	return config_bitmap;
 }
+IWL_EXPORT_SYMBOL(iwl_get_lari_config_bitmap);
 
 static size_t iwl_get_lari_config_cmd_size(u8 cmd_ver)
 {
@@ -571,6 +572,10 @@ int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						   LARI_CONFIG_CHANGE), 1);
 
+	if (WARN_ONCE(cmd_ver > 12,
+		      "Don't add newer versions to this function\n"))
+		return -EINVAL;
+
 	memset(cmd, 0, sizeof(*cmd));
 	*cmd_size = iwl_get_lari_config_cmd_size(cmd_ver);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index d978a4fadfae..53693314d505 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -215,6 +215,7 @@ int iwl_bios_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc);
 int iwl_bios_get_eckv(struct iwl_fw_runtime *fwrt, u32 *ext_clk);
 int iwl_bios_get_wbem(struct iwl_fw_runtime *fwrt, u32 *value);
 
+__le32 iwl_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 int iwl_fill_lari_config(struct iwl_fw_runtime *fwrt,
 			 struct iwl_lari_config_change_cmd *cmd,
 			 size_t *cmd_size);
-- 
2.34.1


