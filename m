Return-Path: <linux-wireless+bounces-25282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A9B02088
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CBC1894383
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE942ED86D;
	Fri, 11 Jul 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPOAY7Vw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B9C2EA495
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248100; cv=none; b=EDvm74H8V0e5cbYpjhFaV3Y07OfvGe25ApiEdiNBgF632I5qv49AglOaXCzgNzbMde/DVqkT8VmfQZlAb8YEctKD8q9J1lEz5gEfLP6UBWERX8ZMHWCFkFKz3lLO1boJ2Ci6oHQSQn/bSvgjYE9rX9RyK4uYv1V1ovIQQrLCRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248100; c=relaxed/simple;
	bh=RbPzJTpQnFAD7cZDvAvsgZ1Swe+jBhOH3hE8tLiJZWw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mXl2vYC0iEtItkAlXv47+eM8cG7qtbtPR4dEgIB8+PlTcDDzQhHcpuLlmL0CjDLLJ5NBCs0zGbRleJBWvFN3v3QDM2I7Pb8NnEktH7O+DV+SgGKgYX2Kat+kWxSbEK+3JC2L0MswrDkAcXgD7cKJhNSaqRdsVWjcMbjD3nyAX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPOAY7Vw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752248099; x=1783784099;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RbPzJTpQnFAD7cZDvAvsgZ1Swe+jBhOH3hE8tLiJZWw=;
  b=jPOAY7VwuRVQXsJWhjFtKIkFG4My+1+eVt0DxHegUWQqfQLBV9/1KX1E
   71ecDFs6AzSSgJeRZ9AsXlQh+DfFUDW6HumDL2+UxsA8hclPH4C5pbXvo
   zf4z99M4Z9gPU31xLAMAL7vQPveB59kJ0DarW9D2rCeUA7VyMHiQ9cmYg
   eY4A6qElLxgh/zQUgkoWpnxkwdzbZQPnMdrlS70mcTPlx0Eb/Yu498PZ6
   i+HmSmhcinGGvD4aLgQB24hOt/HHO4nlE/ut4HXTSXXaOXl46QbpPP27+
   54hoFbbwk8/EtQZTZu/W2gn+liRG9BQhEvwWe1w8/U+6kIgnsbOCy0Bzj
   Q==;
X-CSE-ConnectionGUID: 7J8Cxnd/QI6dLmUXwyKZuA==
X-CSE-MsgGUID: I5kTmvlPQqKD15U5+4SZQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54264161"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54264161"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:59 -0700
X-CSE-ConnectionGUID: eVmOcFM3Q+eo+hudWQdOBg==
X-CSE-MsgGUID: iwhIw2ItShK0kvwaqFmx/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156485110"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:34:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: remove an unused struct
Date: Fri, 11 Jul 2025 18:34:21 +0300
Message-Id: <20250711183056.313285673570.I87c646f8b9b83d63c7c6c293cc5d454c32d852c2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
References: <20250711153429.3417098-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_reduce_tx_power_cmd is not used anywhere, remove it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index df70b32cfced..786b3bf4b448 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -255,19 +255,6 @@ struct iwl_uapsd_misbehaving_ap_notif {
 	u8 reserved[3];
 } __packed;
 
-/**
- * struct iwl_reduce_tx_power_cmd - TX power reduction command
- * REDUCE_TX_POWER_CMD = 0x9f
- * @flags: (reserved for future implementation)
- * @mac_context_id: id of the mac ctx for which we are reducing TX power.
- * @pwr_restriction: TX power restriction in dBms.
- */
-struct iwl_reduce_tx_power_cmd {
-	u8 flags;
-	u8 mac_context_id;
-	__le16 pwr_restriction;
-} __packed; /* TX_REDUCED_POWER_API_S_VER_1 */
-
 enum iwl_dev_tx_power_cmd_mode {
 	IWL_TX_POWER_MODE_SET_LINK = 0,
 	IWL_TX_POWER_MODE_SET_DEVICE = 1,
-- 
2.34.1


