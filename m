Return-Path: <linux-wireless+bounces-26670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D800B37893
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 05:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0598B365CBB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 03:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0851991CB;
	Wed, 27 Aug 2025 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Md9+rwEX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2112114
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265670; cv=none; b=AWilBf5PCiatJqCHgJnMK8WZHjd6Ul/h0ipbunhyIL/8YTdCeg7pJOpTejpYZHLGgRMYI/J+cLOtaW/qwsFZjxmmzDoVpbxRkc72VgfGshapRCbPwmQV0EfT0YGTuX3O8hzNocJloHgGv8tQyBY89YCLANW/Jpg+TuusTgKpmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265670; c=relaxed/simple;
	bh=ABXDD/xC7rn+cWqwJf3+yfbOhmEgvoXNGHMn6U23rXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pxj3XfvuOnEAN3j0j6gs0lyMBHoVUt1H0tLmAZXv0kJZo8lneXfhIbNMms+YAacRi5Ky3AkSZT2XLJFI+4EshuasTnyQOA/3mKupkA01+rSsyxAra1B8cZRE9Pgk5BLRnIl7iDJ+OIZ/F8JH0tcmLxSY+3wzw1pkgeLsVBYNU3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Md9+rwEX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756265668; x=1787801668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ABXDD/xC7rn+cWqwJf3+yfbOhmEgvoXNGHMn6U23rXY=;
  b=Md9+rwEXG8TWT4NDyxOUf9dAA14JiFNvYCyJYh5wzyO9EH/AdcQvmMBd
   NRBGjsMeDZXE6OVLcyTRB2pZh0mq+u7eL7rzzidIzrOv0nSUNXlEdpk57
   WaPlUu2HwjK0tz7HgJSeszHG/stfwcRGr7fT4iKZYCyasGciEi/w65h66
   fokB0Rcc6/48H3YZKaoAe8/s6cNUaiK9Ae/wNV57pIp8iwRkTrvHDeLSk
   0mfKz5vKwzvWdYGBpCzoTNhbcWRg/rjdVakLWvdhOF+QBaTEJKDTm5jE0
   LmIn7NcYzCqucHzhijX1gXfUD9JUtF5fpPEW/1pynnBpKpeK9fX70ttBE
   w==;
X-CSE-ConnectionGUID: BHJ0DteLQcGuWQ3GJiuVcQ==
X-CSE-MsgGUID: bSKZ2EEGQTik4ldE2BNsEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69229546"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69229546"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:34:28 -0700
X-CSE-ConnectionGUID: mXkBWdNNS8+fZdG9h9PUWw==
X-CSE-MsgGUID: 2nnowdRWRCqQKlMCtkuV1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200631379"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:34:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 1/4] wifi: iwlwifi: if scratch is ~0U, consider it a failure
Date: Wed, 27 Aug 2025 06:33:58 +0300
Message-Id: <20250827063332.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We want to see bits being set in the scratch register upon resume, but
if all the bits are set, it means that we were kicked out of the PCI bus
and that clearly doesn't mean we can assume the firmware is still alive
after the suspend / resume cycle.

Fixes: cb347bd29d0d ("wifi: iwlwifi: mvm: fix hibernation")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b7add05f7a85..46d8c1922292 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1222,11 +1222,15 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
 	 * but not bits [15:8]. So if we have bits set in lower word, assume
 	 * the device is alive.
+	 * Alternatively, if the scratch value is 0xFFFFFFFF, then we no longer
+	 * have access to the device and consider it powered off.
 	 * For older devices, just try silently to grab the NIC.
 	 */
 	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
-		if (!(iwl_read32(trans, CSR_FUNC_SCRATCH) &
-		      CSR_FUNC_SCRATCH_POWER_OFF_MASK))
+		u32 scratch = iwl_read32(trans, CSR_FUNC_SCRATCH);
+
+		if (!(scratch & CSR_FUNC_SCRATCH_POWER_OFF_MASK) ||
+		    scratch == ~0U)
 			device_was_powered_off = true;
 	} else {
 		/*
-- 
2.34.1


