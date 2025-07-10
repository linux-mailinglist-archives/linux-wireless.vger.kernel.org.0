Return-Path: <linux-wireless+bounces-25218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA394B00B66
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF875C1568
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862BD2F4317;
	Thu, 10 Jul 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfr+6lx2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2DB2F49FE
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172153; cv=none; b=lGt0S5iXlb0ExiqZ+R8uR7gHIx2cECwRA9P1RzXXU7yJ5eQDW204Frl3Z6YySphqnf1c9Yhh4mKGzEUG6hvHar8Gimo86vLZEg1SdK1gbfUZBHHieRbMct4txwgGTwKbKdraETQAqyJ280dHsFrXaHD9jJS1UfEe3VmnJBQk4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172153; c=relaxed/simple;
	bh=EE/qcSJt22azntezn22vn8QTsBG4nENvupm+j/3+xbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imCb00eeUilgLpMRccp9M6rnIwV2Bym4gsd8pU3480ZzyDsHSCX8gjJzDkdZnXdXy9/YlDzk2bK+JPE6vDqlEzrnm14QWYHt4G+TUOBQCGnO3Vvr5vAVYG4P876ilrXfr/qaklHc2Gxh65yXyhS7oBTdrGRMuv2TfinCQ9Ya3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfr+6lx2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172152; x=1783708152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EE/qcSJt22azntezn22vn8QTsBG4nENvupm+j/3+xbc=;
  b=mfr+6lx24kQ27KUhyJ6bas3OA3+OW/8xSzjJfDnODH9pFN623PRNfSSw
   MZT3Koen4lr45lNCqnQi/6isnMAA2GjqXobep/qhLQBT5dbwQ7+tnjHR2
   hq9rA1QVwRG0vbJewelzHB8DQbE1DCSKHjgYXDexfmmHYTvUt12l/aCQW
   AS8ujWQgFUhoyaza38n5BaULJmExH26wthDBow7hs6BNIIq/BGGTeUJd6
   ccWVatEYl3irEhNahhT0Ct+PvfRmaq6zx+Rfy/GGTaZxLeh/Q7UbEgmR9
   wzPtGJgkmzQN9NmGjbuvzeVYjI9ikhdi8EccXRiWvwSAk5KkCoXTT6d4m
   Q==;
X-CSE-ConnectionGUID: 8NtncrGBQVao53EcWQU7Jw==
X-CSE-MsgGUID: HZAXM91NRSeAalu/XVR4fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077817"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077817"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:11 -0700
X-CSE-ConnectionGUID: V0ZftYZ1TJGYDdONsJHNHA==
X-CSE-MsgGUID: FHF2pmFTRRumBpLcuDNE9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718756"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:29:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: pcie: don't WARN on bad firmware input
Date: Thu, 10 Jul 2025 21:28:31 +0300
Message-Id: <20250710212632.4aedc0979beb.I3bd4d4296c7245261651603708456b7c67f55539@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
References: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Don't WARN, which results in a useless backtrace, but just use
IWL_FW_CHECK() instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
index 224f4a68c7a8..b38ec90f8342 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c
@@ -25,6 +25,7 @@
 #include "iwl-op-mode.h"
 #include "internal.h"
 #include "fw/api/tx.h"
+#include "fw/dbg.h"
 #include "pcie/utils.h"
 
 /*************** DMA-QUEUE-GENERAL-FUNCTIONS  *****
@@ -1638,13 +1639,11 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 	/* If a Tx command is being handled and it isn't in the actual
 	 * command queue then there a command routing bug has been introduced
 	 * in the queue management code. */
-	if (WARN(txq_id != trans->conf.cmd_queue,
-		 "wrong command queue %d (should be %d), sequence 0x%X readp=%d writep=%d\n",
-		 txq_id, trans->conf.cmd_queue, sequence, txq->read_ptr,
-		 txq->write_ptr)) {
-		iwl_print_hex_error(trans, pkt, 32);
+	if (IWL_FW_CHECK(trans, txq_id != trans->conf.cmd_queue,
+			 "wrong command queue %d (should be %d), sequence 0x%X readp=%d writep=%d pkt=%*phN\n",
+			 txq_id, trans->conf.cmd_queue, sequence, txq->read_ptr,
+			 txq->write_ptr, 32, pkt))
 		return;
-	}
 
 	spin_lock_bh(&txq->lock);
 
-- 
2.34.1


