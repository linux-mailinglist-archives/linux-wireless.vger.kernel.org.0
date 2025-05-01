Return-Path: <linux-wireless+bounces-22298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B976BAA5CDB
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BD53BC2BA
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7C25F98C;
	Thu,  1 May 2025 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUFnJVbW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E5A22CBD2
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093603; cv=none; b=Zb+qXso2FRuxjvvcusK1JDPiH9Q7lyE52rYqeZHgLHF6WV0Lz9+WwIAwPuS+jvYSTrKyUaeuVMJL/EtNfUDYRyEbkMO7Vz7byC0HYq6uMh+sXuEijgoa6C8UUXzODKin1xTzRvPa+NbLCeLoBw+t1Edg3ClU8oZ2RvpcBJHCCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093603; c=relaxed/simple;
	bh=Fkf8lMteFqE+eMCD80QmSSdOwAQ7SlCebspg1+5vBhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrSu9xqw/Nqhrb2oqYz2OkkkXP+K6AkCEov3dZP29r3bXj2DEfd5nrybVbkh/ZU2zpvKfHPGeodzMmcyHQeo6Lou0r9c+HOMmGWhEcUWJdjxiCvtY0R3dI21NFw3nhEwPNQFJeAksFWANH0wp6Uc7fZ3x67vqAZc/oH/ryNnLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUFnJVbW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093601; x=1777629601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fkf8lMteFqE+eMCD80QmSSdOwAQ7SlCebspg1+5vBhE=;
  b=TUFnJVbWCTZoWysvFOnPDllBv9+G64ghgl4GNvnXOdNakYVp00LsZA8O
   /EMXRmoxkTsKAjTga9MZMdOqT97AZ1yYRB3GVMMFtghrTBCRJ/1qE+PE4
   unDwi7YJKuUpOh0qUMgUX47e33h18Z9aRzgimVGUWM6XKRsUxUEEphUcL
   sIe6zG6iWf/JUx69A8m7EypVNQlQaUJEl2x7j142557mlij4Ht7LrqwC9
   o/iHvSI9uFd+E0srQHUbIYjR+5u+KZlJ9+qx9phM3a9UZmEGaMfARSgi8
   MbXmSG5YbkFDHZhqZpDjCwAglFuU4DFnIOA4TWIM6irAks6nNhDr+PYai
   A==;
X-CSE-ConnectionGUID: Setg8HdGTWuMmhs65RVpzw==
X-CSE-MsgGUID: U4qTMEXuT7O3H/auqOoGFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962824"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962824"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 03:00:01 -0700
X-CSE-ConnectionGUID: mC4eTReiT5WKknnIpCc9vQ==
X-CSE-MsgGUID: K4HxvfgsR4y5+Fb421NzjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135317959"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:59:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: pcie: add entry for Killer AX1650i on AdL-P
Date: Thu,  1 May 2025 12:59:28 +0300
Message-Id: <20250501125731.3c968258c0c7.Iad4d2041bfe544875fe9f5c051e23a765f862786@changeid>
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

On AdL-P, we're missing an entry for the Killer(R) Wi-Fi 6
AX1650i 160 MHz adapter. Add an entry to fix that.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219114
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index cfa6b8650122..903f62032a28 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1046,6 +1046,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(HR1), BW_LIMIT(80), NO_CDB),
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_name, MAC_TYPE(SO),
 		     RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
+	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_killer_1650i_name,
+		     DEVICE(0x51f0), SUBDEV(0x1652),
+		     MAC_TYPE(SO), RF_TYPE(HR2)),
 
 /* So-F with Hr */
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax203_name, MAC_TYPE(SOF),
-- 
2.34.1


