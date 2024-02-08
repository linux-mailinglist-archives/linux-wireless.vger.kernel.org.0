Return-Path: <linux-wireless+bounces-3349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1483F84E5BE
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A422FB21247
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1406811EC;
	Thu,  8 Feb 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHis0tEv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF38121A
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411546; cv=none; b=kPzrBH7BkLlgVraYzeTuMehasnsWSFoUpZlkaZkbMu7Ve69btwZnVSRI+zBuXVP3lqFfPCdBVNAzBfsX0dZkxcOlZAkAFIGXJX+c//Y+3Wk76bNXYMWKlJ77pVn7nNfpuMCFrf9+98KSX3tI+gcMY7VByHSC2l2RqIfO044rF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411546; c=relaxed/simple;
	bh=kkJKYCreV4VszOdCbpMYu43N51+rioCE1FFBtHKpf6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukFyoYIqtyT7X+92PUaiJWDADCR3eDXxCfS4vXlrWU2/YXFcOSAeQfaBvcXPNpf7Yd0I+BEx+dKwRE3s+mB/yQJt0rUSL+1MxIulSKUrXkrDiDjLV0ei7H5MaIQ20G3AyiakXqRAI90BXdRhcvRAMKRXX1h/GfAeYnshe2NrSrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHis0tEv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411545; x=1738947545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkJKYCreV4VszOdCbpMYu43N51+rioCE1FFBtHKpf6c=;
  b=DHis0tEvYXLxgiZu5giVI0FG3yQjm/mHJo+Ad5Ux4y4gY4WZgkks84L9
   uy5mK/k9Rct1jfruSZuy3YkJHo1x7k9ypy2jT3taNnVjUnYj3WtSSmb3K
   gl+NPaDzxl0QpiFRoUBH9PEVBuwblUfrkEM/RxZjImpWK38byh3wkom06
   a+uKafUs6n994Od78LVJA/VwJXwMAjfVRWPY++ikj8yDp/7vC5ydif+dm
   eIy1aKnQ4SgX6V2mil3Ve7gCbYV6eaurTrdSBNPYFOn1mccgKpE7yq9tM
   3UrNLQNxyX+cEwySjNHDaggBVr7hHMS8Bo07S/P9WxxXoKP7jFb5SdfIt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1403969"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1403969"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318836"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 03/13] wifi: iwlwifi: mvm: Extend support for P2P service discovery
Date: Thu,  8 Feb 2024 18:58:37 +0200
Message-Id: <20240208185302.7ae41234de7b.Ie0b08d4b965409ef6df5505396927567fb899d52@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
References: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

New additions to the P2P specification use action frames to
extend the P2P device discovery and service discovery. Thus,
configure the P2P Device link to accept all management frames.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index f313a8d771e4..4dc692c2c449 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 - 2023 Intel Corporation
+ * Copyright (C) 2022 - 2024 Intel Corporation
  */
 #include "mvm.h"
 
@@ -205,8 +205,11 @@ static int iwl_mvm_mld_mac_ctxt_cmd_p2p_device(struct iwl_mvm *mvm,
 	cmd.p2p_dev.is_disc_extended =
 		iwl_mac_ctxt_p2p_dev_has_extended_disc(mvm, vif);
 
-	/* Override the filter flags to accept only probe requests */
-	cmd.filter_flags = cpu_to_le32(MAC_CFG_FILTER_ACCEPT_PROBE_REQ);
+	/* Override the filter flags to accept all management frames. This is
+	 * needed to support both P2P device discovery using probe requests and
+	 * P2P service discovery using action frames
+	 */
+	cmd.filter_flags = cpu_to_le32(MAC_CFG_FILTER_ACCEPT_CONTROL_AND_MGMT);
 
 	return iwl_mvm_mld_mac_ctxt_send_cmd(mvm, &cmd);
 }
-- 
2.34.1


