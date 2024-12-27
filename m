Return-Path: <linux-wireless+bounces-16824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE269FD1B3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4618C7A122E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC172BAF7;
	Fri, 27 Dec 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVeeTAs1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACDE5D8F0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286491; cv=none; b=I0g3NfFmASdTekUwvUWDkyqB/RQFDhWCSM3NCoTM0znQPNcfSy9xQOORE1Q/rKbJwUB7Wef2azx8evNMBtyKp555U0zdko+EiBDX8gAj3oEQCAcrKaQdwnNEne03ii+htO/tema8r1gUf+cGoclCLrOVtM8gJYkcGn6voVYBEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286491; c=relaxed/simple;
	bh=XOm55/LIVqi5UJE6fq00fM3Qj22Ye0PVPJwJrxMIx1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BLDzLm07lUQLn4k3yU9rYkMyavqDxbwGS8e8Q3qCEUrdVhDOdRso3jf0RC731k4vhN73Z9M0nMH7oaaXqaMTJV16QHmeBef6XL3tmR7YpZ4YpFtetUyBdvphppJNCJckkEcLvQ5fkUrc1JDLIiUoxujqs5rlURmd8DJSKbHFhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVeeTAs1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286489; x=1766822489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XOm55/LIVqi5UJE6fq00fM3Qj22Ye0PVPJwJrxMIx1A=;
  b=aVeeTAs1vdBabfmggeaW6LvYCmp5tWEwkg7kWOXA8xjxyj/nKiPyX5Hh
   /+A7BTUa0k6q6DaZ/PiSkht2mlhsimumFwZTc5+Tt6SBoeTKqZ1SUfa4A
   2acQPy8p3q7ZD09oHbcewKwSBFtO2PnsHYGV+mwHvwAcuopsOJQwIGsxQ
   OylrMrHfHu856mcglPbHrjQ8q7kgwK5nccQWH9MDm43sVOzDYBOkYAL5C
   gvnPZvNwWDCmjfz2kCl3y7NH/+goQwnQZ/ZNb3Gq2JKZdydC2o27ce3qX
   WpP+gTbtqlFdfNlTUjw+VsNzPbVphCWRPIswCPeML/DodNeYvwulIFZmr
   Q==;
X-CSE-ConnectionGUID: TzUdnaMbQvGDG/v0CsZTag==
X-CSE-MsgGUID: Cqj3K7YkSSiwPiZt61kpyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690913"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690913"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:28 -0800
X-CSE-ConnectionGUID: JzIxjwYkQdeFcLc9gm55ew==
X-CSE-MsgGUID: iM4YjirxRr2zXof4ESSwwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858208"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/17] wifi: iwlwifi: mvm: remove warning on unallocated BAID
Date: Fri, 27 Dec 2024 10:00:57 +0200
Message-Id: <20241227095718.4360f2b9e185.I447f9a5fc6dfdc78ec238200338e2da040ee7e61@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Due to the firmware allocating the BAID, we can only install
the data structure after the BAID is valid from the firmware's
point of view. As a result, the firmware can start sending
frame release notifications to the driver immediately. This
isn't supposed to happen by protocol, since the peer STA is
not expected to use the blockack session until the AddBA has
a response. However, firmware doesn't know that, our RX path
can't know when it was, so simply don't WARN in this case but
only have a debug message.

Since the BAID comes from firmware, also use IWL_FW_CHECK()
instead of a warning for the validity check.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c03cb7cc2f1c..09fd8752046e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -636,15 +636,21 @@ static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 	IWL_DEBUG_HT(mvm, "Frame release notification for BAID %u, NSSN %d\n",
 		     baid, nssn);
 
-	if (WARN_ON_ONCE(baid == IWL_RX_REORDER_DATA_INVALID_BAID ||
-			 baid >= ARRAY_SIZE(mvm->baid_map)))
+	if (IWL_FW_CHECK(mvm,
+			 baid == IWL_RX_REORDER_DATA_INVALID_BAID ||
+			 baid >= ARRAY_SIZE(mvm->baid_map),
+			 "invalid BAID from FW: %d\n", baid))
 		return;
 
 	rcu_read_lock();
 
 	ba_data = rcu_dereference(mvm->baid_map[baid]);
-	if (WARN(!ba_data, "BAID %d not found in map\n", baid))
+	if (!ba_data) {
+		IWL_DEBUG_RX(mvm,
+			     "Got valid BAID %d but not allocated, invalid frame release!\n",
+			     baid);
 		goto out;
+	}
 
 	/* pick any STA ID to find the pointer */
 	sta_id = ffs(ba_data->sta_mask) - 1;
-- 
2.34.1


