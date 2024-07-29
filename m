Return-Path: <linux-wireless+bounces-10625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C51393FC4D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF43283656
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AB815CD7F;
	Mon, 29 Jul 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4QuZxrj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CF715F32E
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273639; cv=none; b=OWyshXReNp21uvGcnst6vRdOgipvl/c9o3f3u15lpGLZDNz/dXQ0HDYuCeW9T2DGzKN1Alemcqfnmp7kWU6No/T/EJK4AR8ZapJoFufmrjm+xxf09qc0sksLUm4aDOtI2Mb9xDtbzhpwYzBNaqlNnK7Zu/ZHSzuQqzt7eFpaHbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273639; c=relaxed/simple;
	bh=jXVuO5tOZ+eISviJbsvhc3FgmaD1mf0sUdUvnLEfdiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LG6h08roN0EbM/zPKH+44pv4WLAOc07grCjGsL+9G7PFlfMpN2XdgIyS3o/UNLXqmgYRG2Cse/t2nNqMpwMpyn6kEx6GuQFOX+BUmHz00US0rrTR54iXVe4eW2gNEe/rTrY1ZhQzcn3d4UN3jP5/1urG+Am+dyUHLxueiQ/1z2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4QuZxrj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273639; x=1753809639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXVuO5tOZ+eISviJbsvhc3FgmaD1mf0sUdUvnLEfdiY=;
  b=e4QuZxrjhAn5vZtMjms0yg7epWwZ97hpQsONmkD5pyS1/WULosm9yP+V
   hIgz7NVcqfxSIl+ATI5wPsF1d1ZPfWbFOfTD1qzkXLRA8XinbxwxTRi6u
   3DG+A8AC0bWCHte/MydD3PRN7/MhQpPSTGCDqmC+Wag2fpZJ3vhKLtNjU
   BCvoTWUkF0DLOF5s2c3TVmqq3TFabtT7vn49Q2eQpgubq8xYWBGeVpTnu
   1N3rWcFAvIn7z1heylKwfkJhXafjMUDyUwz9LaFXxEpjElfZgiOpu/K5o
   wl6wWOoX6dX2I0mPe0kMxSyajuKB96VmaAttxd3rYwXRTzrpBVpFUB5BQ
   Q==;
X-CSE-ConnectionGUID: zns5kiRuT2CNpbPEcW6C7A==
X-CSE-MsgGUID: 29n/kI9US0GF9ektSTYafg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445574"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445574"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:38 -0700
X-CSE-ConnectionGUID: 52qZ7uUOTyOCrxvU8BnAYw==
X-CSE-MsgGUID: Sh1eBVG5Rh6fYD4IJsz9cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288276"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/17] wifi: iwlwifi: pcie: print function scratch before writing
Date: Mon, 29 Jul 2024 20:20:06 +0300
Message-Id: <20240729201718.737e5f8bb8df.Ia3f3637ac4a0fb4b35ffd652f92eb75de652ee12@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We may want to know the value of this register for certain
debug scenarios before we overwrite it, it indicates which
parts of the chip have recently been reset.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 18dda89b7985..8903a5692dfb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -526,6 +526,8 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 	keep_ram_busy = !iwl_pcie_set_ltr(trans);
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		IWL_DEBUG_POWER(trans, "function scratch register value is 0x%08x\n",
+				iwl_read32(trans, CSR_FUNC_SCRATCH));
 		iwl_write32(trans, CSR_FUNC_SCRATCH, CSR_FUNC_SCRATCH_INIT_VALUE);
 		iwl_set_bit(trans, CSR_GP_CNTRL,
 			    CSR_GP_CNTRL_REG_FLAG_ROM_START);
-- 
2.34.1


