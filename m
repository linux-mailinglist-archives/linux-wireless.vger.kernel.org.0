Return-Path: <linux-wireless+bounces-9909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C746925798
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC7F1F26D73
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC9B15B0F4;
	Wed,  3 Jul 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAk4Omi+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D813DDA3
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000769; cv=none; b=dFk9ToUAU2IQauwxn0wPbfna/rdtBiGaOtFsAYb2bxkspOpRlX2ZQa5BGJwbvvzyn3PG8mMmGgpYOKsNGZd+49dlwPZ4gvGLrj4VJmNf/VdgYYYSQpbkT4eyg92BLrYOZDGkgwS9gvBCIJlgzBFx4zmZS5OBEDPKJJM25rw1xMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000769; c=relaxed/simple;
	bh=Sp/ixgVkwiuFLDDZb3odbRpyy+lPQPZe14m765I22T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i94pywVfbvjX/MRIbrvR6+Zq0/L1EStj8UVYYOa9FdqKVVqlgrS54s/Hey1W7HgIzPP9LpCU3Cj+15P6qOOODnztPciUzNGKOlzbRqtoUXYKa0FvwQmhYONqUgh62J3v6CBrnAxKMPMtBRmU/M2+gG6rmUfmAa8b6xKakbb6ET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAk4Omi+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720000767; x=1751536767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sp/ixgVkwiuFLDDZb3odbRpyy+lPQPZe14m765I22T4=;
  b=fAk4Omi+MzvwLbboPuSpqXqpBOWs+oTUKYRhsoI8JaN7b+G5TyPG8Gv+
   4agyDIt7485BpDp+lXGqJL1XBJ1OAQU+sUJvm1x4XR9R886mgVul9FXx0
   lJClD/9qChBhNMX9MZNV/WnFlTEEuu1eTcJLb9JyS/56eZUDq/Fn61D4N
   7AjUrPHAArffbzL3na8tWoRfZmePyxoBJ70Vsq8PdqC0SNwHGvBBK4+H+
   yKxS4FPqmn7qo5+V/hGEmyzXSXOTEI24fihDYZgEwbzI9M475pwp+L/NB
   uQtcQxb6fMPH+FsEZTzmhtCzdXE+DD6GKu+y39HzA4YokfMsqtztz/c2Y
   A==;
X-CSE-ConnectionGUID: jK8zog90THSJBpStDgMXHg==
X-CSE-MsgGUID: 259rabS9R9+m8Vh3OHB+Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27837542"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27837542"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:27 -0700
X-CSE-ConnectionGUID: OAjHg99CSPqc5oxq6lNEow==
X-CSE-MsgGUID: W3W/FXKeQwyv6zbbSIlnpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="45987780"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 02:59:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 08/18] wifi: iwlwifi: keep BHs disabled when TXing from reclaim
Date: Wed,  3 Jul 2024 12:58:56 +0300
Message-Id: <20240703125541.5d12e0e54e9f.Ic53a7ff75f1163eb38bdcf5d66b503e91e6ce5ca@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
References: <20240703095906.833028-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

During reclaim, we may release the txq->lock spinlock in order to call
iwl_trans_tx to queue new frames. The iwl_trans_tx function expects to
be called with BHs disabled and iwl_pcie_reclaim is most of the times
called with BHs disabled already. However, reclaim can also happen after
flushing a STA and in that case BHs will not be disabled.

Solve this corner case by only releasing the spinlock but keeping BHs
disabled.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 8afb5fc1972e..1f6db6b90f6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2412,7 +2412,7 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		 * have tx as well. Bottom line, we can unlock and re-lock
 		 * later.
 		 */
-		spin_unlock_bh(&txq->lock);
+		spin_unlock(&txq->lock);
 
 		while ((skb = __skb_dequeue(&overflow_skbs))) {
 			struct iwl_device_tx_cmd *dev_cmd_ptr;
@@ -2431,7 +2431,7 @@ void iwl_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		if (iwl_txq_space(trans, txq) > txq->low_mark)
 			iwl_trans_pcie_wake_queue(trans, txq);
 
-		spin_lock_bh(&txq->lock);
+		spin_lock(&txq->lock);
 		txq->overflow_tx = false;
 	}
 
-- 
2.34.1


