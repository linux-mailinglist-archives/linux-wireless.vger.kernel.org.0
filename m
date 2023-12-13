Return-Path: <linux-wireless+bounces-711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864980F4D7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 18:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB611F21699
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 17:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACCF61FCB;
	Tue, 12 Dec 2023 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgPJgtRC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DE6CE
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 09:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702403121; x=1733939121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gQqpnCLTfhm+oRnG7qRwdE8IIR5WlktBCZV51moCWug=;
  b=XgPJgtRC5bnrz6ZBf40uzd3VWmH6kgmZH5yfSp+OyS1k9ZXcNX8EmC3q
   JSkKBnFWvHbzw5TrnWqCoCIlXSLF9tOQh08ymQIbARxNq0/EZYsfYQT3J
   DSxYpywfOLvoyDOuj4KlxFWr30qBsMp8IVq+0F9N21D9/nG/HVKmz0t8J
   MDLu3YcIuIzPeBGGPXfA04TBqWD8coc8rXAJYwvsd4V7+d0ALrg9UXrqJ
   LIw+13KFwd5N2YWCe7V8z8X/NTWJK3pxnwOHSeSnpr98je9g7IMPYgXCh
   UKly2ZLldyhyoRirVdF/kmHSQ2rC5nHqfuFU5zl7LsaGYiRH/8ZwCbDFU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="16395967"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="16395967"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 09:45:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="749796943"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="749796943"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 09:45:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 13/13 v2] wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock
Date: Wed, 13 Dec 2023 13:46:03 +0200
Message-Id: <20231213134350.5929ce913431.I8f19713c4383707f8be7fc20ff5cc1ecf12429bb@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***

From: Johannes Berg <johannes.berg@intel.com>

Evidently I had only looked at all the ones in rx.c, and missed this.
Add bh-disable to this use of the rxq->lock as well.

Fixes: 25edc8f259c7 ("iwlwifi: pcie: properly implement NAPI")
Reported-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: add 'wifi' prefix
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index f39c436f0b6d..fc64e1e7f5ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3092,7 +3092,7 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 	struct iwl_rxq *rxq = &trans_pcie->rxq[0];
 	u32 i, r, j, rb_len = 0;
 
-	spin_lock(&rxq->lock);
+	spin_lock_bh(&rxq->lock);
 
 	r = iwl_get_closed_rb_stts(trans, rxq);
 
@@ -3116,7 +3116,7 @@ static u32 iwl_trans_pcie_dump_rbs(struct iwl_trans *trans,
 		*data = iwl_fw_error_next_data(*data);
 	}
 
-	spin_unlock(&rxq->lock);
+	spin_unlock_bh(&rxq->lock);
 
 	return rb_len;
 }
-- 
2.34.1


