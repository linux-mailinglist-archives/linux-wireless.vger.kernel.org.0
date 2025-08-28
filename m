Return-Path: <linux-wireless+bounces-26744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 636F3B396E5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975821C23EE6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1FE2EB84B;
	Thu, 28 Aug 2025 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6aKbLix"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB02EA498
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369624; cv=none; b=fTO+twhZqPwdJy8YP9pXmggmR//H9J5/HcdrmYx14PfVMEo5VDMirUjAyho0UpBJeMGJAA0uLvZ9Q1oevVvVF8gctoXJGnGGmLxSw4C0GmNNDZXK72MYH0qzDNbSYiZAlBIhS4Ocwso/e9HF+a+iOOedm51vESEq5DpdXyJ4qL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369624; c=relaxed/simple;
	bh=sYQ1HjZ+IRZhBnCsrh1za1c5qqUEb/F38UUpRKbinzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1bNDpJMsAVja38pewUgQXdokYJmDGhXLUb+K0wJJbYMWNdH1O1vyLIGVlVAHM+PvhsOcZDVTCS/Vku3IS9KqN7QJ82nApIv2v7q9WUSE7ujhm7hRrq3Rok7tO2mv01+RCt5jmeFn1EotPv5Sd9XWhAGnFCz9NEQG6Uc82zWQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6aKbLix; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369623; x=1787905623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYQ1HjZ+IRZhBnCsrh1za1c5qqUEb/F38UUpRKbinzQ=;
  b=J6aKbLixeYbmS9ioSSi5PpkFW2qmCWKztvPHo/8m9/bZ71HQ5qztUyv/
   R+DNjvrk+J/I8bDrFWbaLuiToIqe+t3EWZ6YMMOT7YXbE59OtkTGbQIU6
   EeG+kVfRA7n1zG/kNloLp6g09RcWKMHryDCj/aDDcCX5OTplWraGqJUHl
   UfEvC1xafbt6H6qeQ5lgPsQOC6ILJu9PbYnxTXGY5GwDgJgu+zI8rkB2n
   Mh7s0AAny0xd1Pe6H95SAEWiOWcEPujZT4tfV5Jzy760hSLiVhDujBA5c
   15VgHhXFKe2ml4UJjbR3u7SNuF3nhiedSAfKa3G4XmflKePJlXe5x3Ou4
   A==;
X-CSE-ConnectionGUID: uz60Bbe/Q3iKDMcS3MtgNw==
X-CSE-MsgGUID: OUIOUHWMQb+v8+3Waz2OSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003353"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003353"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:42 -0700
X-CSE-ConnectionGUID: PoYGOJvhSIiitMf9gp0msg==
X-CSE-MsgGUID: MJvlbe6jRLa8+hX2v+yTrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224508"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: gen1_2: rename iwl_trans_pcie_op_mode_enter
Date: Thu, 28 Aug 2025 11:25:54 +0300
Message-Id: <20250828111032.64b3f290c397.I3ae2ca53330a8543bcbac32880824683f919ac74@changeid>
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

As a new version of this will be added for gen3, rename to
iwl_pcie_gen1_2_op_mode_enter to distinguish between the different
versions.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c            | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 485e00d6158c..26aafaf19eda 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -397,7 +397,7 @@ void iwl_trans_op_mode_enter(struct iwl_trans *trans,
 
 	WARN_ON_ONCE(!trans->conf.rx_mpdu_cmd);
 
-	iwl_trans_pcie_op_mode_enter(trans);
+	iwl_pcie_gen1_2_op_mode_enter(trans);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_op_mode_enter);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index b5ff7a6da325..4f49473decb9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1070,7 +1070,7 @@ static inline void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans) { }
 void iwl_pcie_rx_allocator_work(struct work_struct *data);
 
 /* common trans ops for all generations transports */
-void iwl_trans_pcie_op_mode_enter(struct iwl_trans *trans);
+void iwl_pcie_gen1_2_op_mode_enter(struct iwl_trans *trans);
 int _iwl_trans_pcie_start_hw(struct iwl_trans *trans);
 int iwl_trans_pcie_start_hw(struct iwl_trans *trans);
 void iwl_trans_pcie_op_mode_leave(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 5643aac4032b..bd503cb8f504 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -1905,7 +1905,7 @@ void iwl_trans_pcie_write_prph(struct iwl_trans *trans, u32 addr, u32 val)
 	iwl_trans_pcie_write32(trans, HBUS_TARG_PRPH_WDAT, val);
 }
 
-void iwl_trans_pcie_op_mode_enter(struct iwl_trans *trans)
+void iwl_pcie_gen1_2_op_mode_enter(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
-- 
2.34.1


