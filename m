Return-Path: <linux-wireless+bounces-3748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7207859855
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 18:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A101F21894
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186E46F070;
	Sun, 18 Feb 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTJK02f8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7E6F09B
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708278740; cv=none; b=D8ERiJ1j8L1RzjTHYDcwUGcNVshxbeIhfvkQ1LvG61BBwziYK4+2JtwtRbxzHblstSHJeYSR9F9FLBUnQbVvEWQrwFBXZ/YpBqeuOnaSt4fzmoRTNSxU4O/bzwmGRvHBdfnEQocusGww/JUwSmg6W/aiaP8Krc2j3KnmZt7tzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708278740; c=relaxed/simple;
	bh=E/O9XedZypVz0nwdzwOTDsAnudt4pGVmD/yLRuUdTPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMB82kIiKSpYmj+vRYp+rua7sas67l4jSLVnhYmyfDhlpCUSI0L+fxjD8DGeQNRydHJhBf4aGHUOisXJaSONcCLlEvH8GPXheVzH/ZuWR4nwvQzlygiFyDUfycpWyuWsSE2dhuKVMgPxJNMgklR5xFTaRHOJ+lQmKawPGZxJHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTJK02f8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708278737; x=1739814737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E/O9XedZypVz0nwdzwOTDsAnudt4pGVmD/yLRuUdTPE=;
  b=DTJK02f8IIAHioa1xVzR4crYwp78Ywy7x/jbay6k2w/PYSwcZqlfXvcy
   8CjGxqDE9BZ3bDMb2YVTIFHMM5qZ9zouBp1vfey/1u1uy+NLpfXRcCiJj
   Ytwp5ZTUQPJ04Oi6vi1Nb/C2KBOD1CGSGn+qenOXgPrt1MGVwTM8amfBb
   Rthf58aDKSXztp3dWpJS3V6wLnIOFw7pN5pQ2MZ4F7dz7zKim+zzLgWV6
   sEiv698YYpIa36cSKVfFY9F6JTNc9ZE7/UgUOIF1bOZ1QV6WWPdb5CxlA
   +f8i+d1vE1N99JMsyCOYw7bEabnOYr94r1RK+iWR9CcbgeGFTxDB308r2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2464981"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2464981"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="27459442"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 09:52:15 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 06/11] wifi: iwlwifi: mvm: ensure offloading TID queue exists
Date: Sun, 18 Feb 2024 19:51:47 +0200
Message-Id: <20240218194912.6632e6dc7b35.Ie6e6a7488c9c7d4529f13d48f752b5439d8ac3c4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
References: <20240218175152.3133364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The resume code path assumes that the TX queue for the offloading TID
has been configured. At resume time it then tries to sync the write
pointer as it may have been updated by the firmware.

In the unusual event that no packets have been send on TID 0, the queue
will not have been allocated and this causes a crash. Fix this by
ensuring the queue exist at suspend time.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c  |  9 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 28 ++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h |  3 ++-
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6d5ed79b9fff..70e03a9a937e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1309,7 +1309,9 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 		mvm->net_detect = true;
 	} else {
-		struct iwl_wowlan_config_cmd wowlan_config_cmd = {};
+		struct iwl_wowlan_config_cmd wowlan_config_cmd = {
+			.offloading_tid = 0,
+		};
 
 		wowlan_config_cmd.sta_id = mvm_link->ap_sta_id;
 
@@ -1321,6 +1323,11 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 			goto out_noreset;
 		}
 
+		ret = iwl_mvm_sta_ensure_queue(
+			mvm, ap_sta->txq[wowlan_config_cmd.offloading_tid]);
+		if (ret)
+			goto out_noreset;
+
 		ret = iwl_mvm_get_wowlan_config(mvm, wowlan, &wowlan_config_cmd,
 						vif, mvmvif, ap_sta);
 		if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index f3efbec38253..491c449fd431 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1502,6 +1502,34 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 	return ret;
 }
 
+int iwl_mvm_sta_ensure_queue(struct iwl_mvm *mvm,
+			     struct ieee80211_txq *txq)
+{
+	struct iwl_mvm_txq *mvmtxq = iwl_mvm_txq_from_mac80211(txq);
+	int ret = -EINVAL;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (likely(test_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state)) ||
+	    !txq->sta) {
+		return 0;
+	}
+
+	if (!iwl_mvm_sta_alloc_queue(mvm, txq->sta, txq->ac, txq->tid)) {
+		set_bit(IWL_MVM_TXQ_STATE_READY, &mvmtxq->state);
+		ret = 0;
+	}
+
+	local_bh_disable();
+	spin_lock(&mvm->add_stream_lock);
+	if (!list_empty(&mvmtxq->list))
+		list_del_init(&mvmtxq->list);
+	spin_unlock(&mvm->add_stream_lock);
+	local_bh_enable();
+
+	return ret;
+}
+
 void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk)
 {
 	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 4668f413abd3..b3450569864e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -571,6 +571,7 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 				       bool disable);
 
 void iwl_mvm_csa_client_absent(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_sta_ensure_queue(struct iwl_mvm *mvm, struct ieee80211_txq *txq);
 void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
 int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
-- 
2.34.1


