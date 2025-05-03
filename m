Return-Path: <linux-wireless+bounces-22378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12CBAA8262
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB069189CF80
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD2D148827;
	Sat,  3 May 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0WugMO5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091D1A239E
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301513; cv=none; b=LNP6GetC3pj8xcroBnmS8Nz0OhtMyhMkPSHZdt5G9+K+yzmm9b2g3GeOdU+SRyeCkVKvCGKKhYWhkBWEg9pGF4pfZN+sxlmX9vFGrpqPv1oxDQMBf/+FS7R9ALhCFzl/gLbbkt6U2FYTn5AMck77nzx3wK9uC3b/a3HFQV5M3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301513; c=relaxed/simple;
	bh=TNE8f/foyCZay2hPBZLNTV1jpbsBWL+/lvhICBh1jOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJFQdoBx8PMkWoYcNPlgMKcL/Fpi8scTkDLdivBhDGuRD6OdAgftV96Vy5R/VO6IoU+v/p4bF55c0bJuqaUGG6MID0hKg+gBsMqMBSJF3lhPiMn0jBP/FgBSMpeh8cdahxahKz5aihhu5JkNNvnvhMMLi6nWoVIUfVEfStu9NWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0WugMO5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301511; x=1777837511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TNE8f/foyCZay2hPBZLNTV1jpbsBWL+/lvhICBh1jOo=;
  b=M0WugMO5BQBHthqNNb4ywXPsqtugYSpJmhWrvaZf2S3UAzPt4n9IQJjD
   x+lYK+kp7ihra3xlKCQDLqo95K00WbGo0LQ9vRM6skye46ZoeR1ZbeK9Y
   T2j1vwG80xEWK+eura/fu0L7GCaDaa0p6OzoUK3Q2KP3SVgSXO+vBRIRF
   RI7a6utf71Gljv/P5NrbT0bDVwAuvWrcLctMxBZO2Uapf9BlKQ+TCVyFn
   IuA7RRucipMHeiHYCDR0vXWylT+nfIGRdhtwFIIdhkNlYb8wMOY37aXkj
   SSqat/KYJdAYXT4LqgC249dMbyGIM0mF2k6IeHjIEOWFtQAc7b/d7NO3+
   w==;
X-CSE-ConnectionGUID: OvWYfl+nQCWDXUmBSFDIqQ==
X-CSE-MsgGUID: kZmSEz0VQt+4zsUc04et2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613269"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613269"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:11 -0700
X-CSE-ConnectionGUID: deCAoDwqQ7G9v8wGiB65eQ==
X-CSE-MsgGUID: pr5NKnxKRumka12d/UX4jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644353"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:45:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: pcie: remove constant wdg_timeout
Date: Sat,  3 May 2025 22:44:30 +0300
Message-Id: <20250503224232.48333e80a74d.I6c1aaa23fac5ff7400aa59a3093b53774261cb0e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
References: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This value is only ever initialized and read, so just
replace the usage with the constant and remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 2 --
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 3 ---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 2 +-
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 360367bf6988..f08978d4402e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -304,7 +304,6 @@ enum iwl_pcie_imr_status {
  * @cmd: command queue data
  * @cmd.fifo: FIFO number
  * @cmd.q_id: queue ID
- * @cmd.wdg_timeout: watchdog timeout
  * @tfd: TFD data
  * @tfd.max_tbs: max number of buffers per TFD
  * @tfd.size: TFD size
@@ -324,7 +323,6 @@ struct iwl_pcie_txqs {
 	struct {
 		u8 fifo;
 		u8 q_id;
-		unsigned int wdg_timeout;
 	} cmd;
 
 	struct {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index cb41dbf3e0d3..db9431f09738 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3845,9 +3845,6 @@ iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	}
 	trans->max_skb_frags = IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie);
 
-	/* Set a short watchdog for the command queue */
-	trans_pcie->txqs.cmd.wdg_timeout = IWL_DEF_WD_TIMEOUT;
-
 	trans_pcie->txqs.tso_hdr_page = alloc_percpu(struct iwl_tso_hdr_page);
 	if (!trans_pcie->txqs.tso_hdr_page) {
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 7d7a217b1575..6c2477eec97d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -514,7 +514,7 @@ void iwl_pcie_tx_start(struct iwl_trans *trans, u32 scd_base_addr)
 
 	iwl_trans_ac_txq_enable(trans, trans_pcie->txqs.cmd.q_id,
 				trans_pcie->txqs.cmd.fifo,
-				trans_pcie->txqs.cmd.wdg_timeout);
+				IWL_DEF_WD_TIMEOUT);
 
 	/* Activate all Tx DMA/FIFO channels */
 	iwl_scd_activate_fifos(trans);
-- 
2.34.1


