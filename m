Return-Path: <linux-wireless+bounces-22681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4252CAACE38
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E0F1C40C00
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166A42147FC;
	Tue,  6 May 2025 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjI6mkxI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C411FF7C8
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560487; cv=none; b=iYkoCUUMmdyOFfoIQgvFmXx+jGpJq3P0gc2tdD3Z+ERgB/0LGUlk79HjfygcqdWM9h69aLVPMA7AZFH85FMyvmbpPDJ2KKH2huG25qui48iAqtUXKm6enSeE15FlzdOcVG/rtfq/0kH89a4Op5WGnPttpTCfRHnlK6vN+W9qook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560487; c=relaxed/simple;
	bh=gj3gwp6UBYWiH2VJbPqwkCFiVU0dd4viHF7CF7T/Oac=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pPVRroJoCg/mj2cZwcN4OS2By9MjfGFbhjTdSNnytyM4sstN5bMyllgwlbvChTjECqRqjdR71x3Fez1tgflbuUigr5zd8uf59Pgq9kjJNn4Jazh9hYI7vhf9kNMYZ6PWJYq+h5z43oxCsWunXNKEbVvMcmah3k44FQgKTNOeIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjI6mkxI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560486; x=1778096486;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gj3gwp6UBYWiH2VJbPqwkCFiVU0dd4viHF7CF7T/Oac=;
  b=cjI6mkxItWKMGUNltIXTupifWePkCtJfaT2bceHOQ3xomwzJck+7PLtH
   N15YwMUAJHPHyEPDyYhCG7yza2NkdPDjOEdtei/10dDtPwGprP5aBOuZO
   yVHrRukx+BNgdkz+Rz5PM5fj7pU2QM9bSVmQ06XeUJ8PT6tgRPZbbflcY
   KjXdzbGU3VoSE/1FQDMbw/G9pPkj77WIJZMixOx16Wam2xxVQABQWAifj
   yOVT/gi1FEccGPyvwVKrkczp/I+EMqukRFOPEN5I/I/6jgPfvC8axTzK/
   AxBIRurO7IomxV3gH72mcxfe2YtAv88oDLeA9q31vxT/ZCn9bzfBYRPjl
   w==;
X-CSE-ConnectionGUID: ZDue6KmqQvm37GXQIXN4Fw==
X-CSE-MsgGUID: LddP64luTHCG83Rd9C6EjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961637"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961637"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:26 -0700
X-CSE-ConnectionGUID: ZVkwSMqATRm3v0+uXo7DxA==
X-CSE-MsgGUID: cgin9NfxS+aWDLWF5hlxDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465440"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: pcie: remove iwl_trans_pcie_gen2_send_hcmd
Date: Tue,  6 May 2025 22:40:53 +0300
Message-Id: <20250506194102.3407967-7-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This function is not implemented nor called. Remove its declaration.

Message-Id: <20250506223834.ade3d3cb455b.I5245da00d65745fd6b6028903ff3c08f8417c1a4@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index d580e2ad7520..8adeddeb0e4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1135,8 +1135,6 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 				 const struct fw_img *img,
 				 bool run_in_rfkill);
 void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans);
-int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
-				  struct iwl_host_cmd *cmd);
 void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
 int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 			       struct iwl_host_cmd *cmd);
-- 
2.34.1


