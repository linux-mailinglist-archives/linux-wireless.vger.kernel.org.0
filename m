Return-Path: <linux-wireless+bounces-25047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14257AFDEFB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A96484F77
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F6A13957E;
	Wed,  9 Jul 2025 05:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsBYOXDi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A201CAA85
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037355; cv=none; b=MFpgFJKO+oHxqxq3jGwVxxTfME2zg7ol2ljIBhKzMRPF61QNqhLcLImM5uD5ZmRlv4cafruDIvrp8hkq5qtph5cd+62FmiOvmMW5Da3BqwfVCr1tBPEEVXDXnkM2dRUygFzN+8ajlSCUdFw8pMrv3ZsP5N7LdiCdwqHFEeXeI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037355; c=relaxed/simple;
	bh=LVu5fVxddWa0M4cAXPfPOTlrOprHlTBTLykSaMDrV+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cg/dkm3DLW7W0/1YGjhstLtI/qu6uD3RCol5nd6gyvoWYJzQ4ws+m8FFOUXNitp5+imvC9usK7CFr0P69Bvarz8LoP3y7kTKXll1Sid5mOzff8K2AgoQ62236uW4dNMySn/UmNs4Ipe3GfJBfRjAS3fpYMUJaE4P2mr/tEvAaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsBYOXDi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037354; x=1783573354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LVu5fVxddWa0M4cAXPfPOTlrOprHlTBTLykSaMDrV+U=;
  b=HsBYOXDiOnLJuAg5P5UabQKMeO11sWiqF8rN5wLvj45eALx236YDzmEA
   r7XyUIZK7MP1otMqQWVRomySobNxha53x/bUfK/wy8HLOOFq12QUuJcCa
   B4UQn8kV/ecEQoOBA4lALIiqR29YdIKZ2UPOoY/3ygSWkFYrEw6CNXOfO
   d4H2tR2F7wVlCikOTHwxzgE4f92YsKNnowN/ODtLfCB3eGFBbT5vLJFlu
   1dsy2JqZKi2Sw5kdviMdnUj4HgAxMoObFD13t7kvfgJ81MfYZQQbXU5w2
   Esu4Hozk6AyEoLTmUzT9kTHvLLDqh4OyPfdl+/nl4Fncc9++RNwy86vwc
   A==;
X-CSE-ConnectionGUID: KluQmKRRQAOlvaRbXzBrag==
X-CSE-MsgGUID: 44sC1c6DRRW07ES9U2KxAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501470"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501470"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:33 -0700
X-CSE-ConnectionGUID: a8F++7dcQp2rcKdWARPtZA==
X-CSE-MsgGUID: 8mcskzyoSfmfjFkjgRfz+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859259"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Itamar Shalev <itamar.shalev@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: pcie: inform me when op mode leaving
Date: Wed,  9 Jul 2025 08:01:53 +0300
Message-Id: <20250709075928.2c5790b2448d.I3a3fe174ea55a30daa04a0a3e9a6264913677045@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
References: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Itamar Shalev <itamar.shalev@intel.com>

Transport gen2 didn't inform ME when the op mode is leaving.

Signed-off-by: Itamar Shalev <itamar.shalev@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  5 ++++-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  1 +
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c    | 20 +++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 9604781dd0b7..b6e71c172e7b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -419,7 +419,10 @@ void iwl_trans_op_mode_leave(struct iwl_trans *trans)
 {
 	might_sleep();
 
-	iwl_trans_pcie_op_mode_leave(trans);
+	if (trans->mac_cfg->gen2)
+		iwl_trans_pcie_gen2_op_mode_leave(trans);
+	else
+		iwl_trans_pcie_op_mode_leave(trans);
 
 	cancel_delayed_work_sync(&trans->restart.wk);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 7dd11891ccfe..f48aeebb151c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -1091,6 +1091,7 @@ int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 void iwl_trans_pcie_stop_device(struct iwl_trans *trans);
 
 /* common functions that are used by gen2 transport */
+void iwl_trans_pcie_gen2_op_mode_leave(struct iwl_trans *trans);
 int iwl_pcie_gen2_apm_init(struct iwl_trans *trans);
 void iwl_pcie_apm_config(struct iwl_trans *trans);
 int iwl_pcie_prepare_card_hw(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
index 0df8522ca410..035048e0e8f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c
@@ -630,3 +630,23 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 	mutex_unlock(&trans_pcie->mutex);
 	return ret;
 }
+
+void iwl_trans_pcie_gen2_op_mode_leave(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	mutex_lock(&trans_pcie->mutex);
+
+	/* disable interrupts - don't enable HW RF kill interrupt */
+	iwl_disable_interrupts(trans);
+
+	iwl_pcie_gen2_apm_stop(trans, true);
+
+	iwl_disable_interrupts(trans);
+
+	iwl_pcie_disable_ict(trans);
+
+	mutex_unlock(&trans_pcie->mutex);
+
+	iwl_pcie_synchronize_irqs(trans);
+}
-- 
2.34.1


