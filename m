Return-Path: <linux-wireless+bounces-2947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8628459E3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAF71F23D9F
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E855D465;
	Thu,  1 Feb 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBuAtsQv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA75D47F
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797084; cv=none; b=bSM95bvpt9tCSIpgNq4q8PYFjNfOucU/rcJXDr30HpIaDfA30VAsIXl5moCgN6/LMIPcaK9auYFjT7LHdUwPeazKYRa3EpzHsz0ck9A6MvdAT3u960tVsDN3/a6O8WubikZzv4Xj9Hi/8lqQsS8MY0P2lvP23y8PhL2YfOqxykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797084; c=relaxed/simple;
	bh=qyhl9VTo8Ix1OWihXvgm2nyKbki1uEVs8AFRG+Uv3HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9p/hnRNCV46T49usBM8LKJGnWe/NLJwEslBD/iG8M/Yde0PBlUf+2jsJcnNCXG75odr5UJ9pgEU7yXQ4qniAbtguUiptPbZlpG1UeUQchrpT1/wYEE/+rohjV1//DpAVmVrz4lBctm8dveTiNWNckFEpKmmTZHEcgmiAkOmcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBuAtsQv; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797081; x=1738333081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qyhl9VTo8Ix1OWihXvgm2nyKbki1uEVs8AFRG+Uv3HY=;
  b=kBuAtsQvXO+yUctOM5llaLHEsv/cgqjV7MxAhbX27BYLqKJ99CFe1MjZ
   uRLitpzcLdHUqlErhff1nFkBFo+gT70z5cfVmqrOtdrfCrceZDZSk5uS7
   0C69bk++AaxYYS5D4QtkGAJyrR3M8k5vL0Z5R16AY46o/D7s6T4knkJx5
   Lx5Px0tzqaYl0sZhQwyzUobUHYgeFjCc0QySbFagM3R7+u4yFiOtqpdy1
   ClDskLsrcl1YXkAH8ShVAQufc+Yq2Mgg9U/e6kt/HUjVlb8ct3iJYsSFz
   ZGcGrLyrmWfUbWUHQqlO6AKVql1VQjRGeGkwIk7hnZENfzBNo4Wyvn37K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062072"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062072"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:18:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="93552"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:18:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/17] wifi: iwlwifi: prepare for reading SPLC from UEFI
Date: Thu,  1 Feb 2024 16:17:25 +0200
Message-Id: <20240201155157.4cce81198afe.Ice8b1b97a68da9ec7b5a4799ddb668642198e1af@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
References: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

As the iwl_bios_get_x() functions are now generated using a macro,
and this macro requires the all iwl_acpi_get_x() to have the same
prototype, change iwl_acpi_get_pwr_limit() to return a int
and the actuall power limit will be filled in a pointer function
parameter.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 23 +++++++++-----------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  6 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c |  2 +-
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 170c840c321a..d6e7de2543b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -362,31 +362,28 @@ int iwl_acpi_get_mcc(struct device *dev, char *mcc)
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_mcc);
 
-u64 iwl_acpi_get_pwr_limit(struct device *dev)
+int iwl_acpi_get_pwr_limit(struct iwl_fw_runtime *fwrt, u64 *dflt_pwr_limit)
 {
 	union acpi_object *data, *wifi_pkg;
-	u64 dflt_pwr_limit;
-	int tbl_rev;
+	int tbl_rev, ret = -EINVAL;
 
-	data = iwl_acpi_get_object(dev, ACPI_SPLC_METHOD);
-	if (IS_ERR(data)) {
-		dflt_pwr_limit = 0;
+	*dflt_pwr_limit = 0;
+	data = iwl_acpi_get_object(fwrt->dev, ACPI_SPLC_METHOD);
+	if (IS_ERR(data))
 		goto out;
-	}
 
-	wifi_pkg = iwl_acpi_get_wifi_pkg(dev, data,
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 					 ACPI_SPLC_WIFI_DATA_SIZE, &tbl_rev);
 	if (IS_ERR(wifi_pkg) || tbl_rev != 0 ||
-	    wifi_pkg->package.elements[1].integer.value != ACPI_TYPE_INTEGER) {
-		dflt_pwr_limit = 0;
+	    wifi_pkg->package.elements[1].integer.value != ACPI_TYPE_INTEGER)
 		goto out_free;
-	}
 
-	dflt_pwr_limit = wifi_pkg->package.elements[1].integer.value;
+	*dflt_pwr_limit = wifi_pkg->package.elements[1].integer.value;
+	ret = 0;
 out_free:
 	kfree(data);
 out:
-	return dflt_pwr_limit;
+	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_pwr_limit);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 61bfdaa467d4..f0ed7174a951 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -156,7 +156,7 @@ int iwl_acpi_get_dsm_u32(struct device *dev, int rev, int func,
  */
 int iwl_acpi_get_mcc(struct device *dev, char *mcc);
 
-u64 iwl_acpi_get_pwr_limit(struct device *dev);
+int iwl_acpi_get_pwr_limit(struct iwl_fw_runtime *fwrt, u64 *dflt_pwr_limit);
 
 /*
  * iwl_acpi_get_eckv - read external clock validation from ACPI, if available
@@ -212,8 +212,10 @@ static inline int iwl_acpi_get_mcc(struct device *dev, char *mcc)
 	return -ENOENT;
 }
 
-static inline u64 iwl_acpi_get_pwr_limit(struct device *dev)
+static inline int iwl_acpi_get_pwr_limit(struct iwl_fw_runtime *fwrt,
+					 u64 *dflt_pwr_limit)
 {
+	*dflt_pwr_limit = 0;
 	return 0;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 1b41318e1e55..0e7b66a20b7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -689,7 +689,7 @@ static u32 iwl_mvm_min_backoff(struct iwl_mvm *mvm)
 	if (!backoff)
 		return 0;
 
-	dflt_pwr_limit = iwl_acpi_get_pwr_limit(mvm->dev);
+	iwl_acpi_get_pwr_limit(&mvm->fwrt, &dflt_pwr_limit);
 
 	while (backoff->pwr) {
 		if (dflt_pwr_limit >= backoff->pwr)
-- 
2.34.1


