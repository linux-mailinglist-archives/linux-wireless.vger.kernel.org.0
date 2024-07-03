Return-Path: <linux-wireless+bounces-9912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06CA92579B
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BC01F27007
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA89167DBD;
	Wed,  3 Jul 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3A7SxIw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819516132A
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000773; cv=none; b=UrZkcF2nEfPi1ETpsqX+sE6/ro8rB6GHoAj5LvI3qx7wCl82fltANbHTjKT4Goatc3m6sRBRu9QHg1RwRQJN9y3UuWXGIDRuVYoVDhut7zEftJ4zpTME0ZfiK0GqLyZEfoEGcsq/OTx8Z/+z/zBGENHdf46IOpkYQ6VBbAvmQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000773; c=relaxed/simple;
	bh=HeKCM9A+Nme3mWt1cPIO2loKa8nftVFqMrugtJPI76c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLaNpcBL9w2DoRFcmY7oJnzNDhZWa8NK6wiqFL6BxyEvmPiuhrgJarsmdCRt4417fTl+kn7zfP0/WHphXtjQOZVkR4myGYru5o3CtgoSCpRoO3IYAgnAQ0Esl7ib1T5qpCxdJeqq/PplEu81AF/zHDnK6LDrZCLc521lnD0bHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3A7SxIw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000772; x=1751536772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HeKCM9A+Nme3mWt1cPIO2loKa8nftVFqMrugtJPI76c=;
  b=n3A7SxIwtKOMInCDITGMNB8qGqOXxZZWXCBTDQmES8zxtjXEpEwDUWqd
   DXR0DxM28t75o9/O3EcoMFHMu96J//pfLhoJmtGGgg/WaivdwR1EASNsW
   F+wUtnq/26ULXc7/6GN7iiIC7mc23mNU/AkwZIFnrBsBsqLpJtChadCDn
   LTenj3v5dnr1uQikr+NRoRm2LzHs6h9htZjeKVB3Y6XgHIifBOp2V028d
   dSlcV62Q8OrxnBNNqxXlycYVYvXDSg14Zoox6Gbmhb63XWFHKBXkn68vG
   2OGVU8ZjVnnZJvYw8kZWiuxXSjg9oWXg6PJvnVIG+bqnl/DSop+4+V2TX
   A==;
X-CSE-ConnectionGUID: D8vbGGNQR+2Ly6+y5lBJnw==
X-CSE-MsgGUID: S67HJBsDS3eA/FEgwJhclA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837551"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837551"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:32 -0700
X-CSE-ConnectionGUID: uWHffGCoQDytVIJ3UHONHA==
X-CSE-MsgGUID: XLekF4MITUuEpPR9hCOvBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987812"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/18] wifi: iwlwifi: fw: api: fix memory region kernel-doc
Date: Wed,  3 Jul 2024 12:58:59 +0300
Message-Id: <20240703125541.9344b2b94d45.Id770b4f1893308ba43fc039a8851c526312ad2b5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add the missing special_mem union member and use constant
formatting (%) for the type constants.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 34 ++++++++++---------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index e71b3bc20253..855cd13a181e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -147,32 +147,34 @@ struct iwl_fw_ini_region_internal_buffer {
  * Configures parameters for region data collection
  *
  * @hdr: debug header
- * @id: region id. Max id is &IWL_FW_INI_MAX_REGION_ID
+ * @id: region id. Max id is %IWL_FW_INI_MAX_REGION_ID
  * @type: region type. One of &enum iwl_fw_ini_region_type
  * @sub_type: region sub type
  * @sub_type_ver: region sub type version
  * @reserved: not in use
  * @name: region name
  * @dev_addr: device address configuration. Used by
- *	&IWL_FW_INI_REGION_DEVICE_MEMORY, &IWL_FW_INI_REGION_PERIPHERY_MAC,
- *	&IWL_FW_INI_REGION_PERIPHERY_PHY, &IWL_FW_INI_REGION_PERIPHERY_AUX,
- *	&IWL_FW_INI_REGION_PAGING, &IWL_FW_INI_REGION_CSR,
- *	&IWL_FW_INI_REGION_DRAM_IMR and &IWL_FW_INI_REGION_PCI_IOSF_CONFIG
- *	&IWL_FW_INI_REGION_DBGI_SRAM, &FW_TLV_DEBUG_REGION_TYPE_DBGI_SRAM,
- *	&IWL_FW_INI_REGION_PERIPHERY_SNPS_DPHYIP,
+ *	%IWL_FW_INI_REGION_DEVICE_MEMORY, %IWL_FW_INI_REGION_PERIPHERY_MAC,
+ *	%IWL_FW_INI_REGION_PERIPHERY_PHY, %IWL_FW_INI_REGION_PERIPHERY_AUX,
+ *	%IWL_FW_INI_REGION_PAGING, %IWL_FW_INI_REGION_CSR,
+ *	%IWL_FW_INI_REGION_DRAM_IMR and %IWL_FW_INI_REGION_PCI_IOSF_CONFIG
+ *	%IWL_FW_INI_REGION_DBGI_SRAM, %FW_TLV_DEBUG_REGION_TYPE_DBGI_SRAM,
+ *	%IWL_FW_INI_REGION_PERIPHERY_SNPS_DPHYIP,
  * @dev_addr_range: device address range configuration. Used by
- *	&IWL_FW_INI_REGION_PERIPHERY_MAC_RANGE and
- *	&IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE
- * @fifos: fifos configuration. Used by &IWL_FW_INI_REGION_TXF and
- *	&IWL_FW_INI_REGION_RXF
+ *	%IWL_FW_INI_REGION_PERIPHERY_MAC_RANGE and
+ *	%IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE
+ * @fifos: fifos configuration. Used by %IWL_FW_INI_REGION_TXF and
+ *	%IWL_FW_INI_REGION_RXF
  * @err_table: error table configuration. Used by
- *	IWL_FW_INI_REGION_LMAC_ERROR_TABLE and
- *	IWL_FW_INI_REGION_UMAC_ERROR_TABLE
+ *	%IWL_FW_INI_REGION_LMAC_ERROR_TABLE and
+ *	%IWL_FW_INI_REGION_UMAC_ERROR_TABLE
  * @internal_buffer: internal monitor buffer configuration. Used by
- *	&IWL_FW_INI_REGION_INTERNAL_BUFFER
+ *	%IWL_FW_INI_REGION_INTERNAL_BUFFER
+ * @special_mem: special device memory region, used by
+ *	%IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY
  * @dram_alloc_id: dram allocation id. One of &enum iwl_fw_ini_allocation_id.
- *	Used by &IWL_FW_INI_REGION_DRAM_BUFFER
- * @tlv_mask: tlv collection mask. Used by &IWL_FW_INI_REGION_TLV
+ *	Used by %IWL_FW_INI_REGION_DRAM_BUFFER
+ * @tlv_mask: tlv collection mask. Used by %IWL_FW_INI_REGION_TLV
  * @addrs: array of addresses attached to the end of the region tlv
  */
 struct iwl_fw_ini_region_tlv {
-- 
2.34.1


