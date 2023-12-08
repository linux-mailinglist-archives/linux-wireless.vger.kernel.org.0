Return-Path: <linux-wireless+bounces-560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB38E80955E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 23:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AFA1F2108B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 22:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74657302;
	Thu,  7 Dec 2023 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/Wgz/m3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C76A4
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 14:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701988275; x=1733524275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9c4OqDL9uM1O4qAKCxZ63Qu3L+Sv5X7NG+CW5iiGSqA=;
  b=E/Wgz/m31bjKNmAk9kxgXgmm54rSXc1+vWfmhHLOxqm19zcjlq9tzMue
   +cYMZANqkWF5C2E//NbdZGfiL6UlyPPt78emdXSpcQUlpq2EnLwpu1JCJ
   nMN01sIzlfF6F812s0VGvZ9kUyjxrpzve64NahRYqfW4cKHcul+gWYdRH
   9rUZ5u8pxZ+g5qrqvkqJR2psbeFlqZVFnhgcGpvziV8jJyhz5gPAeQLO5
   /GcRNnyVUZiVT9/PYWEw2vR/qZFSHZg+o/At952RUV4161hFc/GaaAOz9
   dvpqIZ/Se7rp3pbwkmHWNt8MFLQ20dqRpo7D2V8FfskvmsGWDnd0IdNBo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1396132"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1396132"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:31:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721636313"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="721636313"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:31:13 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 13/13 v2] wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock
Date: Fri,  8 Dec 2023 18:32:02 +0200
Message-Id: <20231208183100.e79ad3dae649.I8f19713c4383707f8be7fc20ff5cc1ecf12429bb@changeid>
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

Hi,
I Added the 'wifi' prefix

Thanks,
Miri

Evidently I had only looked at all the ones in rx.c, and missed this.
Add bh-disable to this use of the rxq->lock as well.

Fixes: 25edc8f259c7 ("iwlwifi: pcie: properly implement NAPI")
Reported-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
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


