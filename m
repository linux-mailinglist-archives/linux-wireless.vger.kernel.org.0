Return-Path: <linux-wireless+bounces-19897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2A4A549F0
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C267A5238
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E23420AF8D;
	Thu,  6 Mar 2025 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kD+luDmr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5686204590
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261756; cv=none; b=c4s1Qa+5zxgIe6CgPRaSISRLN4BarIlIDVcd75BC3mI7FpR7z/O3eKnnrRfs2HIl6ddbsArg60qVPsuke4tS07YdDEWtXY4lRXmF4L1xnKpsJfy5TTcAb4/6E2cYf6baj7uRMa4Fv7aw1RGAX+g3Og+nIHIc1CLHZN87xeE+vfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261756; c=relaxed/simple;
	bh=jOSPCYdHjY3mmUmNQsjMfcaCD0ekcqINe9k3tizI2lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nww6GYYlKrtXEusXA0+ShAPD+vD2k9/eRwb0uBu//DxcHDO5ipwtcFCg5KUNy6Ub85LU9yrJGcZBmEYClxb9vIqGPp7OtDrloZ3DmPU3yfEQ/b7ZkX1e/y91cDYQd+s+muoMcteyWfsHV9X9UpvPdjLkfja50PCKcYdbm0INUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kD+luDmr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261755; x=1772797755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jOSPCYdHjY3mmUmNQsjMfcaCD0ekcqINe9k3tizI2lk=;
  b=kD+luDmrDLqdrn+HsfabT4aL3ZT5C0nQyyf4QFMMcuPnwxLp4z4ofz4a
   Dd0JsaqRdmXqLBqQQwsNxi/NdnkQZAIHgxdAJx+C7e/ZBxuv5JCa2Ona4
   sGYJwJNp4y0F+dOp41lQcvlH446QeB7WYCYDU4OiUW3M6hE6VvN+nbIXK
   mmryr6f99H3XXAaezKzI2jk+Q7vLAnzeLqV/Be/4QjEXLhSglZW1avc3f
   qnOo5hRW+yKej+nptkWtpxTRnWI8o8Uqeq1ukPAQ+VcwYDFcaTNgpgjKI
   NK0e6+tEzu7PJV7Z0TwDlaTSeG7YpYz5zYAMvUrbiym0MFyVI6wjuLwpy
   Q==;
X-CSE-ConnectionGUID: ux40NAogSw6NFCQQqCvTtg==
X-CSE-MsgGUID: DgwRDWY/SbKrv8D16ZChfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474517"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474517"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:15 -0800
X-CSE-ConnectionGUID: hB6r4LO6RHaYjic/ZO8eYA==
X-CSE-MsgGUID: RZoTj7XQRGWpWZ4gP3v1rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915534"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 04/19] wifi: iwlwifi: fix print for ECKV
Date: Thu,  6 Mar 2025 13:48:40 +0200
Message-Id: <20250306134558.f713ab5f35b9.I318fed724709f9ee7a0c369e1cf5e1038ddd546a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The print was obviously wrong. We are handling ECKV and not WRDD in this
function.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index b4438b1f8dad..386aadbce2a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -690,7 +690,7 @@ int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
 
 	if (data->revision != IWL_UEFI_ECKV_REVISION) {
 		ret = -EINVAL;
-		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WRDD revision:%d\n",
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI ECKV revision:%d\n",
 				data->revision);
 		goto out;
 	}
-- 
2.34.1


