Return-Path: <linux-wireless+bounces-7548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6DD8C3680
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DA11F21E90
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472BA46521;
	Sun, 12 May 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OACJmeTL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC02D4597A
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516736; cv=none; b=ZO3tKAdDb6NbXdbVymr5BRK5fvQ2jQ8YBTYDYTrGJI9WoaKwoKoggFf4uYNm31SVw+tCXpsghXNFPeajzJ6cfl9auNzDGDofaH15d0+4HV2Y95sNOqDaJ/dT+tzU8stl4PRHm+Ej6Aa0DEbP2It3hnCZkYWDAc+59MeGnoL+Lnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516736; c=relaxed/simple;
	bh=Q4UZw9Zb52Y/ZVLrGrtXnh9o6xje+qFBOhfeohxmnoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRQH/FgErkoT537/ehlhU/C6vzl6TDwoHJku7HhWDBYEVCjOKPI/JfyubEkNaCqC/C01E4Ba+aWy8eBE/MhL/ja4PbJwF1vgJBmBUwuvMp3qWCbRZqRIa/5KLKRrDQ0GsLqdh8x7NAqxgZ4Fze8g5j750JvLATOKVF/TfcS+wvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OACJmeTL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516734; x=1747052734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q4UZw9Zb52Y/ZVLrGrtXnh9o6xje+qFBOhfeohxmnoA=;
  b=OACJmeTLCQrCnAByZklD7YAvEah1ngbuoHZBb3i5zG0t3QwMtvcSe3Kc
   qOEOqL//P85QVpKNjU3++deDsG+Ur0FVh8N441Uf8YpwELjsBEsBbZEOU
   jwoiS2aAWkFTwpH9Z0rEIXTGqfOlW1qva3FvV+gDYvDmrEPwHmJD/70YH
   TqWht4IE5qXL9CW8zFzeaEVRN1oLrnEe2UKYCTtOpKJNevk4GXFT+wNC8
   9OvX5Uu+T+KomZ4J7j6h8pHK2p4KAzknBtgGQ/PHCw7XZ+v70HpbTM8c5
   TXK1GKJ+VIa206Fw/BB8jO3/Me/3NwAXAhPc3RMcqTp+5WSoHZaGxgJST
   w==;
X-CSE-ConnectionGUID: nki3l3AVQYS5YC/0vmeEtw==
X-CSE-MsgGUID: CQGDY78rTI6sXX8LoF0R3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397222"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397222"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:34 -0700
X-CSE-ConnectionGUID: Q3jbceNVSiCvbl0jUW8kfw==
X-CSE-MsgGUID: IeZt3YKLTAmpAiAHaDPFTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761353"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: mvm: Fix scan abort handling with HW rfkill
Date: Sun, 12 May 2024 15:25:06 +0300
Message-Id: <20240512152312.64bd170ce624.Iffe235c12a919dafec88eef399eb1f7bae2c5bdb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When HW rfkill is toggled to disable the RF, the flow to stop scan is
called. When trying to send the command to abort the scan, since
HW rfkill is toggled, the command is not sent due to rfkill being
asserted, and -ERFKILL is returned from iwl_trans_send_cmd(), but this
is silently ignored in iwl_mvm_send_cmd() and thus the scan abort flow
continues to wait for scan complete notification and fails. Since it
fails, the UID to type mapping is not cleared, and thus a warning is
later fired when trying to stop the interface.

To fix this, modify the UMAC scan abort flow to force sending the
scan abort command even when in rfkill, so stop the FW from accessing
the radio etc.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 9be812a40fd9..23a860055354 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3322,10 +3322,11 @@ static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
 
 	ret = iwl_mvm_send_cmd_pdu(mvm,
 				   WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
-				   0, sizeof(cmd), &cmd);
+				   CMD_SEND_IN_RFKILL, sizeof(cmd), &cmd);
 	if (!ret)
 		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
 
+	IWL_DEBUG_SCAN(mvm, "Scan abort: ret=%d\n", ret);
 	return ret;
 }
 
-- 
2.34.1


