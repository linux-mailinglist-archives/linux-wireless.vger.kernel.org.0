Return-Path: <linux-wireless+bounces-5049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16C88190E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25B4B22E1A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8C58595F;
	Wed, 20 Mar 2024 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvbDclK+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25385947
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970026; cv=none; b=PkmsekmMd8ej9sg4uQyzGuJMb0ZZ08dhRytz82+xAALppeC7nZ+lZrlzlXmLjc7E9QbP10EbZsWHS/kNSKMqOd1Tdy7f4ptqLwvo5cm1EpiImjnB+QMtY/2Koe1zG6lSRGEDTJeuLwKtKZ01A2o2XQgjJjWV5NurD5wdYxiX0Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970026; c=relaxed/simple;
	bh=eROf8H4GaFXLCwJyzJ1YUW04hZ0Q3vc7cKMdwBg73vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RU51wlo5ExHMm/AgxPl9n/nW/cgAEaUtqfrGkgkh7i0p9BtQozlaZ4K0A6OUy3cxsCopD4jmBImu2sh7NPTCUCIjF46oK9je/4o0IazmdFekbKUM8Hokj+FuPzJFqSdDraMvZms8I8ICPwOnOKYzoT325MfKkVLERm1ffMvmeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvbDclK+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970024; x=1742506024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eROf8H4GaFXLCwJyzJ1YUW04hZ0Q3vc7cKMdwBg73vw=;
  b=LvbDclK+fYBN0E7sLQQ2OvC3zCwLdioJl4qLAl+G5kfapBYMbTQSItq6
   3gp74Ld3ZtH6x/lFZGskspakXJoyNairO8/74jfGvPhgM/vMZeKU3JHJY
   YfBLlkfmP8JRel0IuP01o6DaSvlrG0GklUvTVfz5dGk72eprLALitzsuv
   ZFcqoOySeprtnoMIdVfAl+kplCRShVoUXBvj72zzh82Y+zrrpqx8ef015
   sgzOcK70H3ylx09nYPz0TJDtGHDaxhJPEDLzapl9NaVcTLfQt+mdNWkR+
   CyeZAc40Y906d3g6IaSiEK6FLhFya0uQg+L6yNEmVhSzJKR2Bvr+gmsEZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698078"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698078"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184152"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 07/17] wifi: iwlwifi: remove wrong CRF_IDs
Date: Wed, 20 Mar 2024 23:26:28 +0200
Message-Id: <20240320232419.b7bea022622b.Ia6ffa981397dc11bd1acb7e190c275155857823d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Those CRF_IDs never existed and were a mistake. Those values are
CNVI_IDs.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 2 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 8df6ec12b74e..05b4001c8224 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -454,8 +454,6 @@ enum {
 #define REG_CRF_ID_TYPE_HR_NONE_CDB_CCP	0x532
 #define REG_CRF_ID_TYPE_GF			0x410
 #define REG_CRF_ID_TYPE_FM			0x910
-#define REG_CRF_ID_TYPE_FMI			0x930
-#define REG_CRF_ID_TYPE_FMR			0x900
 #define REG_CRF_ID_TYPE_WHP			0xA10
 
 #define HPM_DEBUG			0xA03440
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 75e5177cf140..7cba9f72dd11 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1202,8 +1202,6 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_GF << 12);
 		break;
 	case REG_CRF_ID_TYPE_FM:
-	case REG_CRF_ID_TYPE_FMI:
-	case REG_CRF_ID_TYPE_FMR:
 		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
 		break;
 	case REG_CRF_ID_TYPE_WHP:
-- 
2.34.1


