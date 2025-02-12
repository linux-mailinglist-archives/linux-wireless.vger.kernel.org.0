Return-Path: <linux-wireless+bounces-18813-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED91A31E1F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668CF163690
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7681F9423;
	Wed, 12 Feb 2025 05:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8Em2Te+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C01FBC92
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339041; cv=none; b=OZEUp4q8Gb8tdL/S6dgHOTkfDXSImH8EIS4URg+6PcEQCIeREIVDD7V4BEwGSy5a721T6Gw1pcS/LYzdAoavMRMezHQgluo4tQ+u1q6iGolOgpvWQXNnmGvslwYi+5IAM6TuYxRQ90qlvf7WuRT6iCFCV6fKx6CvfpPt7cXoBFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339041; c=relaxed/simple;
	bh=OjLY5YmdWPtzyH4jPKZCyj6lNWunAvCf9dcAXxyBgGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s229dsRY3srPsHHK0Ly2W7/iHcyDWlDaVQ/AAlX2RycDUpsFS9rK5DLdpNV0kg0qGVSWW7c5lAIUubdR5Tp9G2jS9WHUvG0mg17fWpy+Jmrc3g3WRMvRW1NIdFAvFSROlZiiPnxPbJGIHa8qFSodbG78DeydEhIzwPRb1uJTyRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8Em2Te+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339039; x=1770875039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjLY5YmdWPtzyH4jPKZCyj6lNWunAvCf9dcAXxyBgGM=;
  b=F8Em2Te+5csSNG6arEYkw6BRRgq6+ije0rvolSjDagjtakmZiRD7H1nO
   daMWMVT5bWdHuYY+W5n/JBVytkhkdVERqx1s5FpO5pd+IfeNoYn0WPXz7
   Xryu6t8WpU7JpKLPqN6VB0sP+ITfspE7pKjrLsOWa9xR/W/q/HeNK9ijF
   DZo7S+5FUOHtU1I8ZQVLDH3GuBXmW71UEjFBov/e/zjCVNJGFf6fwSzhb
   95a93c+lB1HwdYf4aCPkJaFgs2N36hQCGj6OmH/E3Y0QG0HXAuTIjsTfS
   Rrm+Wr90yaQYLi3PU3hCqPbXo5A4zbwcThdU+jN3GPzcHP5T8OxkhaFS4
   w==;
X-CSE-ConnectionGUID: P4J074o7TRCc1K1XRTRN5A==
X-CSE-MsgGUID: WSrHFFnZRaugzTGHha+kew==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172221"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172221"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:59 -0800
X-CSE-ConnectionGUID: Ufw7NEBrRqmxyFNhZULZJQ==
X-CSE-MsgGUID: jUHFfwcJSTyipzJWwJNeJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893883"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 08/12] wifi: iwlwifi: remember if the UATS table was read successfully
Date: Wed, 12 Feb 2025 07:43:29 +0200
Message-Id: <20250212073923.61801b78a2cb.I710a766888f370a75b47116fec29d41c106b13ed@changeid>
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

This will allow to read the table once, and not any time the command is
sent. The actual use of this will be in a later patch.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 048877fa7c71..a9e6bba2419e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -104,6 +104,7 @@ struct iwl_txf_iter_data {
  *	the driver by calling &iwl_fw_set_current_image()
  * @dump: debug dump data
  * @uats_table: AP type table
+ * @uats_valid: is AP type table valid
  * @uefi_tables_lock_status: The status of the WIFI GUID UEFI variables lock:
  *	0: Unlocked, 1 and 2: Locked.
  *	Only read the UEFI variables if locked.
@@ -181,6 +182,7 @@ struct iwl_fw_runtime {
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
 	struct iwl_mcc_allowed_ap_type_cmd uats_table;
+	bool uats_valid;
 	u8 uefi_tables_lock_status;
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 434eed4130b9..78bd0eb7aa92 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -402,6 +402,9 @@ static int iwl_uefi_uats_parse(struct uefi_cnv_wlan_uats_data *uats_data,
 
 	memcpy(fwrt->uats_table.offset_map, uats_data->offset_map,
 	       sizeof(fwrt->uats_table.offset_map));
+
+	fwrt->uats_valid = true;
+
 	return 0;
 }
 
-- 
2.34.1


