Return-Path: <linux-wireless+bounces-16846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A179FDC2E
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03CF3A14C8
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CA51991B2;
	Sat, 28 Dec 2024 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Faqn7d9l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC891990C7
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418081; cv=none; b=MBbF1XgG/TEK/rqKec9ChAjB+lENg6HPupC8R7BSKfK0B5E7XvhqfCuDMfUTsAZzU2K2xq/r45+xap7fFCSTv/S7MsrFLZMIDfCxF65wsoqxS+Qooxb++HsHiObXeheH+JLSOg2u6tPO27pdBYko3WioIDpe8fIExIxTs7/PYn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418081; c=relaxed/simple;
	bh=rO/o6y2WdZQ0UIS8eFPk4AByvCX4rDsoydR1rVVwdlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9fVmxn5lqWQ2Arrj2Q6txkelHC3sPP2DXOSnutjkDnUbcJB31FvdHI4+abYROFIvzGgYyx6aXVg8T+o/5J0OB66Fgg1aPUE47oR3L9dMTM7Pca7tNxG6apNWIm76KTLswRLacTN/NVy0lWwEc1U1v89YlXl+pKVClNkY6nyU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Faqn7d9l; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418080; x=1766954080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rO/o6y2WdZQ0UIS8eFPk4AByvCX4rDsoydR1rVVwdlM=;
  b=Faqn7d9lBAHIzWPqMkqSOqgij1vw3TnSJJbDTeWDQWHRqamD9hsmN2z7
   UW+6uHFgyQeneOvHbtIgBTWNPiMX8NqCsDrm00uHs/GBOwRxH3UMCiq3l
   x9us8yeFY7kCaERFJvA+Yqk0hLwJHVyw3tdWqFoTgpIC31yOHe8SIJLMR
   NVoM+dN7fDp9Lbg63fdV6CObSddIUhTyPVjBFvuCGjbnIP34zgtRk9yiZ
   K856m3cM9jd2AxEWuAuSYDUIt0ebJHdZvx30UWsc4ELuHN9vPkfRSPIpl
   R67nwrC5/orLjNULOtedKsYifvC+Qskj8Z8EhbBOpTt/SjZ4fvWpQYwtu
   g==;
X-CSE-ConnectionGUID: 8w/EJ3OnQCCyv5Iu3o33cQ==
X-CSE-MsgGUID: ZYjdRIVNQga6WGV4zkMnbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479756"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479756"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:39 -0800
X-CSE-ConnectionGUID: v1xDuV6GTB6lhrfpOrMQdA==
X-CSE-MsgGUID: kZVz68kES5SHypj+CgXpRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488375"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: Remove MVM prefix from TX API macros
Date: Sat, 28 Dec 2024 22:34:08 +0200
Message-Id: <20241228223206.1b235ec5354e.If99a38b1f0d7e42ea4ee3907e6c395846c4aa9b0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

These are not mvm specific.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 04b177b8ef30..1f23bde5720c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -482,8 +482,8 @@ struct agg_tx_status {
 #define TX_RES_RATE_TABLE_COL_GET(_f) (((_f) & TX_RES_RATE_TABLE_COLOR_MSK) >>\
 				       TX_RES_RATE_TABLE_COLOR_POS)
 
-#define IWL_MVM_TX_RES_GET_TID(_ra_tid) ((_ra_tid) & 0x0f)
-#define IWL_MVM_TX_RES_GET_RA(_ra_tid) ((_ra_tid) >> 4)
+#define IWL_TX_RES_GET_TID(_ra_tid) ((_ra_tid) & 0x0f)
+#define IWL_TX_RES_GET_RA(_ra_tid) ((_ra_tid) >> 4)
 
 /**
  * struct iwl_tx_resp_v3 - notifies that fw is TXing a packet
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index b5f6bb9cab4a..bd09bd0ca930 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1626,8 +1626,8 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	int txq_id = SEQ_TO_QUEUE(sequence);
 	/* struct iwl_tx_resp_v3 is almost the same */
 	struct iwl_tx_resp *tx_resp = (void *)pkt->data;
-	int sta_id = IWL_MVM_TX_RES_GET_RA(tx_resp->ra_tid);
-	int tid = IWL_MVM_TX_RES_GET_TID(tx_resp->ra_tid);
+	int sta_id = IWL_TX_RES_GET_RA(tx_resp->ra_tid);
+	int tid = IWL_TX_RES_GET_TID(tx_resp->ra_tid);
 	struct agg_tx_status *agg_status =
 		iwl_mvm_get_agg_status(mvm, tx_resp);
 	u32 status = le16_to_cpu(agg_status->status);
@@ -1917,8 +1917,8 @@ static void iwl_mvm_rx_tx_cmd_agg(struct iwl_mvm *mvm,
 				  struct iwl_rx_packet *pkt)
 {
 	struct iwl_tx_resp *tx_resp = (void *)pkt->data;
-	int sta_id = IWL_MVM_TX_RES_GET_RA(tx_resp->ra_tid);
-	int tid = IWL_MVM_TX_RES_GET_TID(tx_resp->ra_tid);
+	int sta_id = IWL_TX_RES_GET_RA(tx_resp->ra_tid);
+	int tid = IWL_TX_RES_GET_TID(tx_resp->ra_tid);
 	u16 sequence = le16_to_cpu(pkt->hdr.sequence);
 	struct iwl_mvm_sta *mvmsta;
 	int queue = SEQ_TO_QUEUE(sequence);
-- 
2.34.1


