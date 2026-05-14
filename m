Return-Path: <linux-wireless+bounces-36429-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO+CJVAmBmqmfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36429-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2224B54677D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6483E304AA88
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB73B3BE3;
	Thu, 14 May 2026 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbUyGF5C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC018390987
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787904; cv=none; b=PhgBfbHNgFTF9oghBualzfWXYanDCG2I1xHBPD6/1eoA1x0BtigmNHcvE87gYSRGprNqeFjGODn/6JgNCE09U6/g4jMk+UyvvQbiWYHjtTlfuB+dDtXEaSVAyTxeC1ulg6yqEZBLTT/v80KY+XErdMDz8xTMHMIA5QdE5efKzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787904; c=relaxed/simple;
	bh=H/BR6vVAxgALlYGNh4PSMQHWm5CefTxpF6lG80lT6yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7ZFKEBJH+dBubdR9w+Ifhxb6NT5aTXks50EzFiHNvgKO7picQ+lTrvsgMEwzWnOCgguzW/C093/WDmfoH25AuIK8BZmGp36BqFb5mWnNU6moNd6rSWkOYrc+RQdkEkn8MiI2SgTRcnEQG4aiEH7he0Gh1pLeH+UrqMRY0957Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbUyGF5C; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778787903; x=1810323903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H/BR6vVAxgALlYGNh4PSMQHWm5CefTxpF6lG80lT6yA=;
  b=UbUyGF5CfMKShSdaV4cU6AzYxUARFayO7WilPr/y6mKYJr30KaTZf645
   FJZ+0ON/heIYff3yVx53wuwaxplJhWNqE/r7d2Yp5PwSV9BciGLHY6+9f
   EV0ow7k5HuJAJ69gUzaNT2OpYN5qVChT5y08r4DkF4/ejJk/9QSfPiw/b
   9w4D22I25Zz4ORLY7Vc1rhf2vNVd1Oblf5fRbn1UWuwPYzlGPFSCwFmbi
   Bb/ZCyWKbqdhRiK1URfc74muWKv+i4dgF8XAzZzNmlthT4cWZCx79En0e
   NefowcBkUaLUseXLx5kgePQFBJwoI3IFsnAW73XvMkgytnogk/3NL15r7
   Q==;
X-CSE-ConnectionGUID: fSOm1wuIS0SKLUsyNfgQAA==
X-CSE-MsgGUID: yUFlxI/PS7WSmqLJERdwbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83352597"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83352597"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:02 -0700
X-CSE-ConnectionGUID: 9U2BZXYLRX+Yd2uIjLUJRw==
X-CSE-MsgGUID: F4e6Be1TQ3mi5Fbrtncx6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237616325"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: rename LINK_DEBUGFS_WRITE_FILE_OPS
Date: Thu, 14 May 2026 22:44:28 +0300
Message-Id: <20260514224230.5bff36ea7dd0.I62b01f83b622f281257fb842d9cc00b28dc2f5e1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
References: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2224B54677D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36429-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

These are with wiphy mutex held, so rename the macro to
LINK_DEBUGFS_WIPHY_WRITE_FILE_OPS indicating that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
tested: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index ba5a47519aa1..afe972834cb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -979,7 +979,8 @@ void iwl_mld_add_vif_debugfs(struct ieee80211_hw *hw,
 	VIF_DEBUGFS_ADD_FILE(twt_operation, mld_vif_dbgfs, 0200);
 	VIF_DEBUGFS_ADD_FILE(int_mlo_scan, mld_vif_dbgfs, 0200);
 }
-#define LINK_DEBUGFS_WRITE_FILE_OPS(name, bufsz)			\
+
+#define LINK_DEBUGFS_WIPHY_WRITE_FILE_OPS(name, bufsz)			\
 	WIPHY_DEBUGFS_WRITE_FILE_OPS(link_##name, bufsz, bss_conf)
 
 #define LINK_DEBUGFS_ADD_FILE_ALIAS(alias, name, parent, mode)		\
-- 
2.34.1


