Return-Path: <linux-wireless+bounces-7541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E018C3679
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787081C211DD
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADBC2D047;
	Sun, 12 May 2024 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMLxlhY+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548F2943F
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516726; cv=none; b=b+PCTAPpL2SDIk1/SgqELpOuTWOT1sjdAH09XDXwDL76wh8jiE9MNXuc0mCMvn4MSE4KJBElUsQOqJTmcR3ck50ZG3J5djM+4Q+5zqc7yCaRB51NgOYqwOcxGKAaCDg/rLlY3k490hdRNeBf214WFHGHdZmY3XKRrHF7bxBj2p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516726; c=relaxed/simple;
	bh=citO1RM7ul6yQQt499Myc6LnyLGKzGg2FrM8Gqv0RdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DM7c1q8tkrGJhqKi9TExbGQ7ryBqzuz1ePBYOSfPNVm6POUs/DRiSYPH+luFLGRXkcth4wPgP8RhTccwhw1AbFgiedJxGGpsgUZk3wr6vGBtKi1wNGs44O+BmMi1hs5nhJBIBBaPxbxU7Gf3MZqO/kgCJbz9ekdebdHimxMAkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMLxlhY+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516725; x=1747052725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=citO1RM7ul6yQQt499Myc6LnyLGKzGg2FrM8Gqv0RdA=;
  b=nMLxlhY+WHlolLo/Mh4HcVohHIkXJxPybi6Djo3rBpbx34kaYkvCWFS9
   fflVuCdEmo7VtXowK3uqBD9O8vQPSZksJGaxUIk2loC+QBWvIbir3BhMs
   EzI4ScAB5FfNokT1FHyHSwFzo+ujlq8Hi9PL0OOudFu83kLVnf2FXEkB4
   sGSIkVWUsyq9R4gQcSgNsiHLwXkwMW55UTyJCE5OGS2uP7uJyxfh/MHB7
   SMz3OJ9UDap/RWr+gKCJCTxajb+k6oL8z1hNIawGamEK/R0DfBi9hiAYt
   q+HLLlwFUMPPUHOCnWQ/W3l1L246R1ZqqAYIZE5hud8clR0IxxPF+53V/
   g==;
X-CSE-ConnectionGUID: 7wZvFeD2QNiKiEWHrxWKsw==
X-CSE-MsgGUID: 61R5UhaTQhC1R6OxxlC6SQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397200"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397200"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:24 -0700
X-CSE-ConnectionGUID: 3wLTS4rQRvCOj68RUzNrqw==
X-CSE-MsgGUID: 26IccaLFSWCmAoiT6h6hSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761320"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/14] wifi: iwlwifi: mvm: don't skip link selection
Date: Sun, 12 May 2024 15:24:59 +0300
Message-Id: <20240512152312.caab27a8dd8f.I63f67e213d5e05416f71513a8d914917d59aa44f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If we exit EMLSR due to a IWL_MVM_ESR_EXIT*, a MLO scan followed by a
link selection is scheduled with a delay of 30 seconds.
If during that 30 seconds EMLSR was blocked and unblocked
(IWL_MVM_ESR_BLOCKED*), we would still want to get the needed data from
the MLO scan and select link accordingly, and not return immediately to
EMLSR.

Fixes: 2f33561ea8f9 ("wifi: iwlwifi: mvm: trigger link selection after exiting EMLSR")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index fd8a21891d26..0745229c8c37 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -1076,6 +1076,13 @@ static void iwl_mvm_esr_unblocked(struct iwl_mvm *mvm,
 
 	IWL_DEBUG_INFO(mvm, "EMLSR is unblocked\n");
 
+	/* We exited due to an EXIT reason, so MLO scan was scheduled already */
+	if (mvmvif->last_esr_exit.reason &&
+	    !(mvmvif->last_esr_exit.reason & IWL_MVM_BLOCK_ESR_REASONS)) {
+		IWL_DEBUG_INFO(mvm, "Wait for MLO scan\n");
+		return;
+	}
+
 	/*
 	 * If EMLSR was blocked for more than 30 seconds, or the last link
 	 * selection decided to not enter EMLSR, trigger a new scan.
-- 
2.34.1


