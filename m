Return-Path: <linux-wireless+bounces-25201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF6B0095E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379323B9CFA
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902792F1994;
	Thu, 10 Jul 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8tcW8rd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ABD2F1996
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166528; cv=none; b=auywOgBf+1ePS6B1X3ZZM6DctwIBYH5IQmNdtKxVtzMw6l19QklZhYl+iKdyqOP5loLgDvBKv+nFQVjaRzF0tPXtaaxzWRgDhYGhyNeNxt4WJmyb63gEq+6PLpOO/QXY+6waWuRrEaOWq6reh/BVH7RWzJTZnVCQPoG7IQOmBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166528; c=relaxed/simple;
	bh=EE/qcSJt22azntezn22vn8QTsBG4nENvupm+j/3+xbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfpF1DLqrGf8+MI2jY7HjmLtV/6XaAug5SFSrZ3BDH8N8MTh7K8rJskRJU6e6PlCR0B90oID0Uk9PRqJpjmptRPbNnZr0O7yAzXee+BYoVdhxBOi7LFal6tGWUMSjvjydU962uEDcgvXW9sUGDw/1lRWVn5YdtkFYqbwPRGPzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8tcW8rd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752166527; x=1783702527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EE/qcSJt22azntezn22vn8QTsBG4nENvupm+j/3+xbc=;
  b=g8tcW8rdcgWZJlxDpyNn2exLn1821TCLlxtVldVIbIdcyvBx/loitY7k
   U+urmnWZz99bNwa+cJXpzxiCHVT8es1mLlILCjMOCCpmZf2RG5N609yD8
   zVEhxqildh1zN6XxPlLxl79LgNYryuKaur7/5IkPeuwh6KjJaOkdOdWnQ
   8QP+bV7D06wwWqz1/LNGPfWp+4kngtX/2B/29BE4dMYMldHGJoGgVPfLx
   nVEiGwyTYxYUuATeODrG1pkhFJT2vGR1VJzB299eXVfiAJtIvAuW78RGA
   28o0iU+mK5kKgD5h4lfzZPTGltTyVJ037FAE5Jm7lqs/9mnp5qipKl4Bo
   Q==;
X-CSE-ConnectionGUID: JAV3rZptQiiGze2vfo91/Q==
X-CSE-MsgGUID: X+HuuyTSR5OYyzaz0LyvtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54610028"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54610028"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:26 -0700
X-CSE-ConnectionGUID: Ybuug+e/ROCsKKWSLuhTTA==
X-CSE-MsgGUID: qz8btgzdRp6ZkpLHODrKQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156277116"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:55:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 14/15] wifi: iwlwifi: pcie: don't WARN on bad firmware input
Date: Thu, 10 Jul 2025 19:54:47 +0300
Message-Id: <20250710195219.4aedc0979beb.I3bd4d4296c7245261651603708456b7c67f55539@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
References: <20250710165448.2553296-1-miriam.rachel.korenblit@intel.com>
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


