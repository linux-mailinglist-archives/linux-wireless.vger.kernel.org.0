Return-Path: <linux-wireless+bounces-3242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D065B84BA8B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531711F230BA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD51134CE2;
	Tue,  6 Feb 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhS+m36U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F37134CE7
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235369; cv=none; b=smUvjpitRYwIY4rjgvqcXERKbcMkMViCbYtPjdCBpsjbVATi5FXrBGvM8PpLTQ+/WIuK88DCSpvkLWqTuq+ozBm717ZzNnVVSlNyb1o+IuXtblaD5fLJP3agMRvQl3yRYRkpbqEqF3YJ6CzI1LiImG1EiuMNiwcBo/JyV5CLum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235369; c=relaxed/simple;
	bh=RJxEqNoxjX/0smzrIc4TqVPuqGW4OpdCk7bLL/ag0OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYaJ7R090sMc+2/5BzYLqY5oh709Hum53NVjwAgBQQfe9Fdm5HU5Uib+Jj/27lrtiFcKyU15SvbZUC15GR00rkJVLBLKtygQMqCrTWThlMdIajMWjOFpFF8thBXy0BlbCX6Glinwe6QfJY9TzqOHKojstyI3/YI4dVTGSNofchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhS+m36U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235368; x=1738771368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJxEqNoxjX/0smzrIc4TqVPuqGW4OpdCk7bLL/ag0OE=;
  b=bhS+m36UhLUjEvOt8/2mk/1ReqAn+GwdnX7mG5JUz39Fk1PUTYgKnSrX
   Ycc7TdG1Kavxq6XBZHn5cro7jnTMxnkdHdBjyHGW3j/QNUsN7JeOKRzH/
   j9y4a8CfE6GIyj+qYS34yvEhzmc592kL/BLUUrwNUMu0P6e4AYkA23VJk
   MQgcDnTU6lXSPjRiArgdD5+8lV1gbZtnPd/rQe5UQPtjmK3CLl3LzsTAV
   f/a5hHd+d2VURGVpl59stjqSfPmba1lTuXkLFFiapXxS1ctkrVp8Tm/ug
   1SXryubIlxFOdC+xGkX/UaE7LH0yJ/sYhSF6HfRegMMx/Fx44wax+rIoJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252464"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252464"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349861"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/11] wifi: iwlwifi: queue: improve warning for no skb in reclaim
Date: Tue,  6 Feb 2024 18:02:14 +0200
Message-Id: <20240206175739.581427dc81fc.I9a109d02b4349807dce521c693ecd3516ec58cc0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
References: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We've seen this warning trigger, and while the reason is
probably obvious, I haven't been able to see it yet. Add
more information to the warning message to help identify
the cause. Also print out both index and SSN for all the
messages.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index ba0419bc1765..d3bde2d010b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2020-2023 Intel Corporation
+ * Copyright (C) 2020-2024 Intel Corporation
  */
 #include <net/tso.h>
 #include <linux/tcp.h>
@@ -1602,8 +1602,8 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	if (read_ptr == tfd_num)
 		goto out;
 
-	IWL_DEBUG_TX_REPLY(trans, "[Q %d] %d -> %d (%d)\n",
-			   txq_id, txq->read_ptr, tfd_num, ssn);
+	IWL_DEBUG_TX_REPLY(trans, "[Q %d] %d (%d) -> %d (%d)\n",
+			   txq_id, read_ptr, txq->read_ptr, tfd_num, ssn);
 
 	/*Since we free until index _not_ inclusive, the one before index is
 	 * the last we will free. This one must be used */
@@ -1631,7 +1631,8 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	     read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr)) {
 		struct sk_buff *skb = txq->entries[read_ptr].skb;
 
-		if (WARN_ON_ONCE(!skb))
+		if (WARN_ONCE(!skb, "no SKB at %d (%d) on queue %d\n",
+			      read_ptr, txq->read_ptr, txq_id))
 			continue;
 
 		iwl_txq_free_tso_page(trans, skb);
-- 
2.34.1


