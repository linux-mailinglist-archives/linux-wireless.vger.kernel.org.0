Return-Path: <linux-wireless+bounces-26652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D3B36F41
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564EB1BC1830
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2C369329;
	Tue, 26 Aug 2025 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNNtg4xa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4F34F48B
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223755; cv=none; b=qjFaC+9k4q1TRoY7zg8rgWTKde7pZjp3HxGXPBjcE2YMlo5gD00V3nB2GGXFxJGGRRemx2skydAtbVvM1mM2MTIQPDBm/ABLoyV8nfDVOLl1TuZq1q554nu1MuTE5qSAM9Pb+iVlOnNn1PQMHPtbUl9CWtT8zBVKGt5Ku4GW6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223755; c=relaxed/simple;
	bh=XeyKL21a6UDLoCNSkBQF1hXE3FEaxQxszMY+sQ9YEFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUh2pjy1SCA6e7yOisXTJPj0TxFdmGddUKL02Xs+t7KvshlllFVu2gnmOYiC3MR5IScoa1TgbuouG9g/U1uWJqgj+5MSxeGMHSFawcfXkgbSlUS7wmnb7yTDOljJQiT3GpNjVXb96TGpMslPz/wZcvRG8EXsYjkwn9kOe7FGcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNNtg4xa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223754; x=1787759754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XeyKL21a6UDLoCNSkBQF1hXE3FEaxQxszMY+sQ9YEFQ=;
  b=JNNtg4xaQNjOjl+fqFgOp4NRa5NYIDJty9JtnZquQCyF1CoOFkummuTG
   EjcVXbK7UUHN//wxSNCA5XU5k54Bcrv3rEbQsc2gRFsdyTBsx5Gb97RLB
   2UAgaaXP6dDwwIi1WTBSDyZ7So+srgAQ/2yqxwEd4sJQvZ/UzQ6aK83cC
   NBcBsJiTBMrLZOLagXiVJB8zZUEI4nKubtorQcyAewiO+Fflw77yxtvFq
   SI3pazoyw9TxgC6VGabuo/fEumwudx4AVNdFUR5PIGt1pG965BEO4q2X2
   Y/AGLY+4RdAnzSTwQfVWTbywze0ywrYzxXOYqrQSn/0hKds5MbssuUsvI
   w==;
X-CSE-ConnectionGUID: /gDhdpWjQV+2LTG0JFDpUg==
X-CSE-MsgGUID: +oMPGAdhRXWlzjNpPpZXOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108441"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108441"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:49 -0700
X-CSE-ConnectionGUID: reSsXqdiRgqioSUeAEtxSQ==
X-CSE-MsgGUID: Ifo2wQXRSriDXCHp0ZJmqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218382"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: refactor iwl_pnvm_get_from_fs
Date: Tue, 26 Aug 2025 18:55:04 +0300
Message-Id: <20250826184046.c752988eb0d1.I7b3a9a4f6a8d23663838a1e232f8bfad57c596ce@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Instead of having an error code or 0 as a return value and passing a
pointer to a pointer to be set by this function, change it to return a
pointer, and use NULL as an error indication.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 4d91ae065c8d..0421a84a44a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -237,11 +237,12 @@ static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
 	return -ENOENT;
 }
 
-static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
+static u8 *iwl_pnvm_get_from_fs(struct iwl_trans *trans, size_t *len)
 {
 	const struct firmware *pnvm;
 	char pnvm_name[MAX_PNVM_NAME];
 	size_t new_len;
+	u8 *data;
 	int ret;
 
 	iwl_pnvm_get_fs_name(trans, pnvm_name, sizeof(pnvm_name));
@@ -250,31 +251,32 @@ static int iwl_pnvm_get_from_fs(struct iwl_trans *trans, u8 **data, size_t *len)
 	if (ret) {
 		IWL_DEBUG_FW(trans, "PNVM file %s not found %d\n",
 			     pnvm_name, ret);
-		return ret;
+		return NULL;
 	}
 
 	new_len = pnvm->size;
-	*data = kvmemdup(pnvm->data, pnvm->size, GFP_KERNEL);
+	data = kvmemdup(pnvm->data, pnvm->size, GFP_KERNEL);
 	release_firmware(pnvm);
 
-	if (!*data)
-		return -ENOMEM;
+	if (!data)
+		return NULL;
 
 	*len = new_len;
 
-	return 0;
+	return data;
 }
 
 static const u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len,
 				    __le32 sku_id[3], const struct iwl_fw *fw)
 {
 	struct pnvm_sku_package *package;
-	u8 *image = NULL;
 
 	/* Get PNVM from BIOS for non-Intel SKU */
 	if (sku_id[2]) {
 		package = iwl_uefi_get_pnvm(trans_p, len);
 		if (!IS_ERR_OR_NULL(package)) {
+			u8 *image = NULL;
+
 			if (*len >= sizeof(*package)) {
 				/* we need only the data */
 				*len -= sizeof(*package);
@@ -298,9 +300,7 @@ static const u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len,
 	}
 
 	/* If it's not available, or for Intel SKU, try from the filesystem */
-	if (iwl_pnvm_get_from_fs(trans_p, &image, len))
-		return NULL;
-	return image;
+	return iwl_pnvm_get_from_fs(trans_p, len);
 }
 
 static void
-- 
2.34.1


