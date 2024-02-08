Return-Path: <linux-wireless+bounces-3350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD4C84E5BF
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33D81F280D5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD348121A;
	Thu,  8 Feb 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FV9z29jh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72F823A0
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411548; cv=none; b=h2nKkGC5SZnMcJJIA8rE3BHI3Bwv46AU4pM3Bd7C4DFeckbwXwj+JPB2fDIEB3euBMCCECLUmJbTQ1XrEkAQUwp3tC1kXqYJkbGbtCCR8as+l9S7srUxtHIKUGUv2SOy3Q/Undzs2OVzTOtv6HRpswGDxtLBsEdiJe4k1AwK+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411548; c=relaxed/simple;
	bh=aSr69mK4rUy7lO5YSeJi8nKqmo8zyD0F5HQHGrxu5rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epoMIvphQCAicn5csIH8b3A5FKHKG8dhslIUCU/icXLk6gAjwl6jxAlVcxEEeVAQ5vdbyQq1EEIrRxTl0wD4djcxlofA+MtVFX4A4BBff/Vg0FRKuNtnJB0xko812GUZ6sSjZ3bbM5hKHNfrt3DQRve5LRT5P1aJcRDP2QNmy8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FV9z29jh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411547; x=1738947547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aSr69mK4rUy7lO5YSeJi8nKqmo8zyD0F5HQHGrxu5rI=;
  b=FV9z29jhe4Qv5csq2wD+MLCvTZTX+pIvNs+Xm+4fyIjOOjiG1SbtixtC
   tZKq6xJT+5534jYi2nlciRHB+RZ+p31KFczOBeGua7ZZDCrqaMK+B2pLM
   r9mKoVkBzcG5JbFfvE9uiqfv5apEJ99JymkgADKN2b9E6JmK/xZgXtNBO
   TjwiIdHhtdiCkWFChx2jgjW8Jm2yH3R8sfwyXaGgDvmmwKcgS+sk5oEjp
   SQj5enblB9jiRz8W0Fo7n+jBcGxpVh2G0NK8K+vvaPS1y8FxKjGVGH9HZ
   IsAQfS1jYTY7dM5/bmDt/5tcLkjxevfgJi//sJfAfeIGxA3GI60ETeH3j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1403976"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1403976"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318840"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 04/13] wifi: iwlwifi: mvm: Fix the listener MAC filter flags
Date: Thu,  8 Feb 2024 18:58:38 +0200
Message-Id: <20240208185302.a338c30ec4e9.Ic2813cdeba4443c692d462fc4859392f069d7e33@changeid>
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

One of the flags was from the wrong API.

Fixes: 9be162a7b670 ("wifi: iwlwifi: mvm: add support for the new MAC CTXT command")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index 4dc692c2c449..bb7851042177 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -167,7 +167,7 @@ static int iwl_mvm_mld_mac_ctxt_cmd_listener(struct iwl_mvm *mvm,
 	iwl_mvm_mld_mac_ctxt_cmd_common(mvm, vif, &cmd, action);
 
 	cmd.filter_flags = cpu_to_le32(MAC_CFG_FILTER_PROMISC |
-				       MAC_FILTER_IN_CONTROL_AND_MGMT |
+				       MAC_CFG_FILTER_ACCEPT_CONTROL_AND_MGMT |
 				       MAC_CFG_FILTER_ACCEPT_BEACON |
 				       MAC_CFG_FILTER_ACCEPT_PROBE_REQ |
 				       MAC_CFG_FILTER_ACCEPT_GRP);
-- 
2.34.1


