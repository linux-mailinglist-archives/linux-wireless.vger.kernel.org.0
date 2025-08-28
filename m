Return-Path: <linux-wireless+bounces-26745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C96B396E7
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76683A8B99
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64092EB864;
	Thu, 28 Aug 2025 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAzczE5k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF172DECA1
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369625; cv=none; b=JGa2+YE0w9rZJfWmPf/rOhV08Eo7zNWrmy0+R2vzGM00eE49qXBH/0CRvA432xds30RMzZxcnaTtJuxLCVjI/ozAAuG1DuNXNLaFzgdLA/vnAbG1+r0jplrx3PpkdWH0Wr+Vv2WP8ka/Rq/WEKpOupKP42xvsHKKn8fzyCa6i94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369625; c=relaxed/simple;
	bh=w3uwv3PkqayD81u8Ic7/kabWAKghrfY2AbDjgfBePQM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gyO9KdBtn6NeWWlMxZNu7MymNmM/CA6ws+5u1/wdTxi8eHscShVTa2l+4hXOdUT5g69s7mIUgEz9meTJ/tFK6ZPvp8hjA/SP8y3zb5nMdKRCkRueeO1eLdFsY9quq8r9e0+4HN+Ci5M5thjORJs43weYjNxg3qVH30hule3piRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAzczE5k; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369623; x=1787905623;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=w3uwv3PkqayD81u8Ic7/kabWAKghrfY2AbDjgfBePQM=;
  b=CAzczE5kOxGpJCDaDyKbnRz4xAHgNyFlScRVzlqRNrSSVMSbgayzEBd2
   06HKhyfPwu/cDQn3oTG8CMwlV4q0LPjBqWP3O9xsJHfBweuRGHgi3PElF
   u3IMguTbDo9+ObHm8TRl3RW3jEyUGekj1kDdAiKAIswTDKhQxe3mwz2dj
   rXMj8VilRmHnTKLDGIgdWno2YhGrbGEmdY7pExyx3M42avJHTI5F2FO/S
   iziMGtJQ+GmzFPQYmJ7KSZUT+wWOxXa0Iz41ehMt1i3hPJeVEjPM97pXb
   e24r2DxI8ghsoRJV2PJ1vSevsuRmnGYI7EmGmdnZBlU43Ba+j1dvswd9x
   g==;
X-CSE-ConnectionGUID: oQafS9eVTuioGuKFkMtuIg==
X-CSE-MsgGUID: bgljTFDhQemJFktawHd1+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003380"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003380"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:51 -0700
X-CSE-ConnectionGUID: 4JHda5n9THKAHXbfoav9GQ==
X-CSE-MsgGUID: CRqoqKxXQbaVc5bu5TEl/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224533"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: don't support WH a step
Date: Thu, 28 Aug 2025 11:26:01 +0300
Message-Id: <20250828111032.8d484f21a237.I16a30af0b4b964339bd60c3bed854d1028c1fff8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
References: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is no longer supported. Fail the probe if such an HW is
detected.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 6045a7915b91..607fcea6f4ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -337,6 +337,12 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 		return -EINVAL;
 	}
 
+	if (CSR_HW_RFID_TYPE(drv->trans->info.hw_rf_id) == IWL_CFG_RF_TYPE_WH &&
+	    CSR_HW_RFID_STEP(drv->trans->info.hw_rf_id) == SILICON_A_STEP) {
+		IWL_ERR(drv, "WH A step is not supported\n");
+		return -EINVAL;
+	}
+
 	fw_name_pre = iwl_drv_get_fwname_pre(drv->trans, _fw_name_pre);
 
 	if (first)
-- 
2.34.1


