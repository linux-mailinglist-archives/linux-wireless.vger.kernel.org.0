Return-Path: <linux-wireless+bounces-16946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF99FEF45
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 13:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDF4161C3F
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C7219D072;
	Tue, 31 Dec 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpszlacU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EC19D070
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646391; cv=none; b=Aw3Ces8EyDeTwMOHO5R4zfJS8gZmMs08H93iBPHPev9QScaUjOoP+Uip0hEoKhI1lDkmc0ey64KIYq9QgAkB1GmvaJ4BzuYkvBxyBZYiOuf6mkku1qoFh1LIWF2VHbOqRNkfZbSTpTwqtQ3UVvXKVNWQaoCWblBUFstW/mtlcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646391; c=relaxed/simple;
	bh=c+GF7J9mSXIIwOqKT4QhodIghrR3Qk+dqGWYxwRxcQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a11/faVue2LYv2BJzkam1try/Hyws/DJ/YE1zTEmYfCdD+cK4V7LD9Vl4Tpmj4I3Rq7eXS9I1EaG4XnAMNlOFehMC3fdOYQ7MAUM/D+RltA/lCGQjLLmqnZANi3MrIq096VmAxZAtiQvg1ee6xdLcATQ3puxQmm0WRbWRo8sNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpszlacU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646390; x=1767182390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+GF7J9mSXIIwOqKT4QhodIghrR3Qk+dqGWYxwRxcQE=;
  b=mpszlacUifgAzpwyfl58+Xv+r217D2z1dskpKJJyEbtDalZd/Lh5yS+9
   bI4cQNgzP+m171S9VAQrlV86PS43wWipYL0gZliH295tN9K/32uP+oHB2
   qeBF/BI6fUfsCLW0o2Nh0UpEPGn2us983PwgxF7OHEU+RNNRdTr04L+Fh
   TMxUD2ewiIdo2D16cGWxfYNeNMKRFFL+qCfqhXkSMgK9wuWYNuoeau2ql
   1SYv1EzUg1B/p97DeyH9ZFkZmSuDjFppg8BYJ+TacUgcZ+HqCydnNkjFI
   vlf4glHZbtdbOZLZ8vNC/Ke7tyMQ/VUICUbeARSCydmtVjhpHK4FV3D7R
   A==;
X-CSE-ConnectionGUID: +e4AbMmmRySsOj3TyoE4FQ==
X-CSE-MsgGUID: UE/YJg7kRkuGVEc1/lt/Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330201"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330201"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:50 -0800
X-CSE-ConnectionGUID: Clu6af69QuCxx0Vo2nk26A==
X-CSE-MsgGUID: FTWzMoWwRjKqAOyLvSA2bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380352"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:49 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: pcie: make iwl_pcie_d3_complete_suspend() static
Date: Tue, 31 Dec 2024 13:59:14 +0200
Message-Id: <20241231135726.c09d2251824c.Ibcfbb4bbe27a0767a1da4a5897b2b0f70193dc3d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The function is only used in the same file, so it can
trivially be static. Do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 2 --
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 58e5e403a110..856b7e9f717d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1137,8 +1137,6 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans);
 int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
 				  struct iwl_host_cmd *cmd);
 void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
-void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
-				  bool test, bool reset);
 int iwl_pcie_gen2_enqueue_hcmd(struct iwl_trans *trans,
 			       struct iwl_host_cmd *cmd);
 int iwl_pcie_enqueue_hcmd(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 044f46fa4ba7..c917ed4c19bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1489,8 +1489,8 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state, bool from_irq)
 		_iwl_trans_pcie_stop_device(trans, from_irq);
 }
 
-void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
-				  bool test, bool reset)
+static void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
+					 bool test, bool reset)
 {
 	iwl_disable_interrupts(trans);
 
-- 
2.34.1


