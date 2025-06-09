Return-Path: <linux-wireless+bounces-23874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B849AD2579
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD5C16924A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE421D3CC;
	Mon,  9 Jun 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVttyJzS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87421FF3E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493329; cv=none; b=YbivC2lCbULHrGV4gqHlFI811ugsLMsqDGvEZTxAvyGH9wX5vyQtBAml5MkArscdpc/m4UG/vk5nMvK6ybaQF214D36UkB3T8htfuuZ+dWHwG5pJr1BLAZ5/uSucOwfPAB9qBaFDYLM/pypTDp3h6d9keHEkLB7uyr5r/nopdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493329; c=relaxed/simple;
	bh=4m7Dk3O25FeN9C9YGtdZPNVRD1R8dEtTm80n4CtCi+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSp0k9kL5fqoDblmbzUYN7yWgXjt2wxKek6TxMf3G/jPDntf7vImTWI3C9vugTJzhYgJ09HrAJjp0XVeAaJ/MOvDGSkAnM32/Vi6PRquv4VRJ07ezGB2ZuI6tM+zfodi9Jx69NLJ45LhYamf5jWJLJZ3xBMXfQ/WYb91GuauPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVttyJzS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749493328; x=1781029328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4m7Dk3O25FeN9C9YGtdZPNVRD1R8dEtTm80n4CtCi+k=;
  b=TVttyJzSUJPf+qGDFX6EyZ5LYTb/HJxzNGGAODk3MhWYaMQr/0A1SNBR
   G5G7hElDSbSm8Cu3nBNM3t7elmBHkoZAvxdCoFqEtVykKoeml6dm3kyup
   6Vf3BIWLCEpzPNMb0HRSIv13lFEUTQzcW2KnoU0p2FnGy0/A6+ZaWClWQ
   ja1uwsykAubQruxjzUKgQuu7p6v7Hju8PH21yhB6gmWvv6PZ4qp/a9GVL
   a+QZenZsHhdNZHMpcR42BUqB9bXMUyhEP3yi4bUFEmm1dEmq0aTjtb3cn
   Grxz6i991SxUy2KpLuNUVMopn+7jEXDH4k907pPiW9VejdapfRRE4jbsm
   w==;
X-CSE-ConnectionGUID: cob3fQyrQQG8XAyP7T+XBQ==
X-CSE-MsgGUID: M4IbLMW+ToK+v4LPM2BumA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="62237697"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="62237697"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:07 -0700
X-CSE-ConnectionGUID: yUKb6uXcTIePyccJERWxrA==
X-CSE-MsgGUID: K7qLDN44QuiifdZ2EEUKNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146510418"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:22:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: pcie: reinit device properly during TOP reset
Date: Mon,  9 Jun 2025 21:21:21 +0300
Message-Id: <20250609211928.903444f8e8e8.I7f70600339abb9d658f97924aef22faf1af00a3c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
References: <20250609182121.3886519-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

During TOP reset a full _iwl_trans_pcie_start_hw() is needed so
the device is properly initialized for operation. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h   | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c | 5 +++++
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c      | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index c90707cfd351..796410f2fa48 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1074,6 +1074,7 @@ void iwl_pcie_rx_allocator_work(struct work_struct *data);
 
 /* common trans ops for all generations transports */
 void iwl_trans_pcie_op_mode_enter(struct iwl_trans *trans);
+int _iwl_trans_pcie_start_hw(struct iwl_trans *trans);
 int iwl_trans_pcie_start_hw(struct iwl_trans *trans);
 void iwl_trans_pcie_op_mode_leave(struct iwl_trans *trans);
 void iwl_trans_pcie_write8(struct iwl_trans *trans, u32 ofs, u8 val);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index 6c5acb7bf643..b5e4b60f710c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -610,6 +610,11 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 		msleep(10);
 		IWL_INFO(trans, "TOP reset successful, reinit now\n");
 		/* now load the firmware again properly */
+		ret = _iwl_trans_pcie_start_hw(trans);
+		if (ret) {
+			IWL_ERR(trans, "failed to start HW after TOP reset\n");
+			goto out;
+		}
 		trans_pcie->prph_scratch->ctrl_cfg.control.control_flags &=
 			~cpu_to_le32(IWL_PRPH_SCRATCH_TOP_RESET);
 		top_reset_done = true;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 4d2806d071d9..bace11a949c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1845,7 +1845,7 @@ static int iwl_pcie_gen2_force_power_gating(struct iwl_trans *trans)
 	return iwl_trans_pcie_sw_reset(trans, true);
 }
 
-static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
+int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int err;
-- 
2.34.1


