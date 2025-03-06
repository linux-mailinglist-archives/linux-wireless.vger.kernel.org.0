Return-Path: <linux-wireless+bounces-19957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92467A5595B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2DD3B2D4F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA54627933D;
	Thu,  6 Mar 2025 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WICiSGHj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5D27CB1C
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298729; cv=none; b=gP6C5X/UAiqf2h6OlHm9RYpi4m81/YokJf0JbzuxYvbsJ6XTtMKPFIZYib+jxDwFsPbazTsIbRV4qkGR/ns/1Kd0VZw1Kqy9E50/zl6JU5llfVkx7hPul4gZYmey4tcUOPkm9jaCJKXX+ez88AN3cOAKVV1GstS0ZF6tV/vxkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298729; c=relaxed/simple;
	bh=+syhqyEU7ZeN3xxAqNsIFIuAmJpnrWfr6M2cgkxY0gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdHfqvmvGV/gKMiUG+W1ze7sbkoF1YGyQB8PZnw3X7f3uAzrS9qZJgeO+3pLmNyWrL++OW5scRhtajGSNwt6cRLqBt4XOlpxeIGfZM+WI8OMfi52a2euo0ncUzYDZiRwSszmNqcj/ICDBL5DE/rcBakVkGvypTb+BMs2eMm0Ztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WICiSGHj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298726; x=1772834726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+syhqyEU7ZeN3xxAqNsIFIuAmJpnrWfr6M2cgkxY0gQ=;
  b=WICiSGHjJWKBCZrvRPN8WenSof7dB5lDRYQQsKqXDJg8oYScH+Asuw2t
   00ZrZJFqJiKAmIOthOjUwI8v5FrOUzdV8jMSN4sEIUhlSCXnPX/B/VpLr
   NvuUspTLmT0IZQHXyRg4MLoqDQHhiE8J1By7YXSK1b0p55bX4lvbZwxBx
   08wnVd60SYqMW9O95QrUdnN5tnVhbWRnzyZa3mUCfkoSJHA62E1Bga5L+
   /w0fhaT9xQW1/gqZQF4iZv/VOyLAWWkHAPCreq4KE9Yb4t9hXqS600s74
   Qiqvhfni5n7KocTl8qx3YO9D9+cNw/uO7cSARBMTYgq9sX30Vx8gvGH3n
   A==;
X-CSE-ConnectionGUID: 5Q5ueCdRR9mGCFbNAPZapA==
X-CSE-MsgGUID: iGed50tfS9GFvQWOEMXxmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474285"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474285"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:26 -0800
X-CSE-ConnectionGUID: qlGQx5hqQ/yR9eZV+5y8/g==
X-CSE-MsgGUID: HXbwOQY3RTaWRxtv8+6LQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061914"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 13/15] wifi: iwlwifi: don't warn when if there is a FW error
Date: Fri,  7 Mar 2025 00:04:52 +0200
Message-Id: <20250307000213.44d20a682276.I9332506af1997faefcf0bdb51d98d5e874051722@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_trans_reclaim is warning if it is called when the FW is not alive.
But if it is called when there is a pending restart, i.e. after a FW
error, there is no need to warn, instead - return silently.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 1632ab20a23f..ea67df09fc01 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021, 2023-2024 Intel Corporation
+ * Copyright (C) 2019-2021, 2023-2025 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/bsearch.h>
@@ -639,6 +639,9 @@ IWL_EXPORT_SYMBOL(iwl_trans_tx);
 void iwl_trans_reclaim(struct iwl_trans *trans, int queue, int ssn,
 		       struct sk_buff_head *skbs, bool is_flush)
 {
+	if (unlikely(test_bit(STATUS_FW_ERROR, &trans->status)))
+		return;
+
 	if (WARN_ONCE(trans->state != IWL_TRANS_FW_ALIVE,
 		      "bad state = %d\n", trans->state))
 		return;
-- 
2.34.1


