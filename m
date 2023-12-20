Return-Path: <linux-wireless+bounces-1023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC128190B8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7901C24B4E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6739AC7;
	Tue, 19 Dec 2023 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elYqaMHJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24939ADE
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703014154; x=1734550154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IMZpO0Fm4jJ25sjYRDB2ovqMAPpcckyo28/Rr71FIBo=;
  b=elYqaMHJMiJbfYLhbFj4xx7/ju3ufmbPc/WwByMnu6aEWZLuEmvlSba6
   3WM+a7ODAyvREQ4ZDFW24UsKnVHrcYXjnBopgzdCyVMaINpG8kaBQ3FvK
   3wERK2+bYAFsFl8A38U6x46ftk3bgvlo4+B4RQDXzz8RIEGm/EWmoz0Ik
   az/ciMACfiW+VU0dKNBbOtgvS2AKfNCYbVWyTAmNm7Do/Xd2XwdJ5rl1t
   Ku4kyUtOrTVz9FIskN76o/07sjYAuw/AYg48SguNH7CaL7WTyuKFNJ7GV
   uj5COscLTumoqSErN+6yTwV7c034PNIu5b0H2xnlyoSEYDrmCLOZD5eDS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460054341"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="460054341"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:29:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="899478232"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="899478232"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:29:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/14] wifi: iwlwifi: mvm: send TX path flush in rfkill
Date: Wed, 20 Dec 2023 15:29:21 +0200
Message-Id: <20231220152651.c528a6fa6cec.Ibe5e9560359ccc0fba60c35e01de285c376748a2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220132931.3314293-1-miriam.rachel.korenblit@intel.com>
References: <20231220132931.3314293-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If we want to drop packets, that's surely a good thing to
do when we want to enter rfkill. Send this command despite
rfkill so we can successfully clean up everything, we need
to handle it separately since it has CMD_WANT_SKB, so it's
not going to automatically return success when in rfkill.

Fixes: d4e3a341b87b ("iwlwifi: mvm: add support for new flush queue response")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ae5cd13cd6dd..db986bfc4dc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -2256,7 +2256,7 @@ int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id, u16 tids)
 	WARN_ON(!iwl_mvm_has_new_tx_api(mvm));
 
 	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP, TXPATH_FLUSH, 0) > 0)
-		cmd.flags |= CMD_WANT_SKB;
+		cmd.flags |= CMD_WANT_SKB | CMD_SEND_IN_RFKILL;
 
 	IWL_DEBUG_TX_QUEUES(mvm, "flush for sta id %d tid mask 0x%x\n",
 			    sta_id, tids);
-- 
2.34.1


