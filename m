Return-Path: <linux-wireless+bounces-7462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB28C265A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7991B286585
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A316D136E0C;
	Fri, 10 May 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edv/anMS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A21708BA
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350017; cv=none; b=LIxA4S4epeCXC764wCYxpbbsVimwL58DYAgqziGVX69O+O9mLUa2hBbmdu1hvmCixDc/yZpYJkoNPeKMiG+JLfzc2Pu+MUpKPxtFlPeFZTMsFkOeAQ91SeXW+s0wAMmCkUHU14vyTxbSdaZWYXARLHDCMxgqeuJ4Ikonk5mtQPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350017; c=relaxed/simple;
	bh=AaiA1BIAfwmsBD3ptPBu0ojVSxZ4Sr2x13KkpnA/JnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5gcBxWholzE093usEDzgj/5GgjOJqTVKI09roKCwVy7ZGbswS+wqFsVarOLFlDEFZCmWlHdzNRSGgQyZ4c16JCYFlRRR33W65wWfNurdA1c0EdWEnkp7SymPSWlJzMl0fuv5ZH5RVl1ZeZUQwuK8fuv0rdZTNIge+z4JoA9NIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edv/anMS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350016; x=1746886016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AaiA1BIAfwmsBD3ptPBu0ojVSxZ4Sr2x13KkpnA/JnY=;
  b=edv/anMSadA0j7nqmqHANYyUOuuajkKK+flsBNXSfnR9+N9kCAkqGPXf
   BVAexF/4aDsHq3lSQQIx7UO2kXEki+qV1E1mo2lq/09Ww5St55lb03pUG
   +HmoShs/0X+wJKhquC19rkvMl6pjPIaoAI7Ek8YVM6XwjJFyLJvO6XXhY
   N6N6oBkfzS8vs/oiop7dgd2PfLdPMMlCZO5VytHoKwzeUqOFNxLOVIvvb
   oOMEUBp4z6BGQcxaLsllbotgmzI/z7NtaLcphktFMAgPW25oxoUJ/Pzx2
   bRKApsMN1Gg9kByzWj7NgUW/EZkxbBdQjRIEyGt3d1kvcRWIuR32rKr1q
   w==;
X-CSE-ConnectionGUID: u+MfZaf/SmiXEf7qY27w8A==
X-CSE-MsgGUID: Y305SAgTSDiMIfJ2OYE9hA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125524"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:06:55 -0700
X-CSE-ConnectionGUID: iYcMw1AdSMGslZ+p16Gpjg==
X-CSE-MsgGUID: 9szlc1qLRPyQ+ufJ2j0BgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101817"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:06:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 02/14] iwlwifi: mvm: Change default value of lookup_notif_ver
Date: Fri, 10 May 2024 17:06:29 +0300
Message-Id: <20240510170500.8cabfd580614.If3a0db9851f56041f8f5360959354abd5379224a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

After moving from commands to notificaitons in the d3 resume flow,
removing the WOWLAN_GET_STATUSES and REPLY_OFFLOADS_QUERY_CMD causes
the return of the default value when looking up their version.
Returning zero here results in the driver sending the not supported
NON_QOS_TX_COUNTER_CMD.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 71e6b06481a9..0f954e506d62 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2341,7 +2341,7 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
 out:
 	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
-				    WOWLAN_GET_STATUSES, 0) < 10) {
+				    WOWLAN_GET_STATUSES, IWL_FW_CMD_VER_UNKNOWN) < 10) {
 		mvmvif->seqno_valid = true;
 		/* +0x10 because the set API expects next-to-use, not last-used */
 		mvmvif->seqno = status->non_qos_seq_ctr + 0x10;
-- 
2.34.1


