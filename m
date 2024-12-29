Return-Path: <linux-wireless+bounces-16863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE99FDF40
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4507618821A4
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF1A17B50A;
	Sun, 29 Dec 2024 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaF9mnzL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60018E34A
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483511; cv=none; b=sBcJpFrSTzxu3Q5K7+NhZFh3IiedyxraghoDql+2aLqLxw1vP1Nwxhsgr3i84DQEppuDx+bjG4oAtRCQOkmCo3gi5HZSGfadZ8bdMKPTKYLlfmsqmKZmT2aCok9vanE49qRSqIKJPlKp8z3ltHhii5wx0LMpSrtTNM+FR8OXY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483511; c=relaxed/simple;
	bh=xrTkA4CXCXZBqeSsOUcif0RrVXU2R0EvNOBlTA/cJ2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KbRTo/a3rNaId71FIqAGNUkex+lEwQQZ63jk0lCmbck7/7SjbzfEm0hvFDlNwmFUdFr4px0l2P8JYV5b+xRlpUAN/meP+HADz8l2ewE9JYwc1+RYk9Jh7kCgjctIQNx8e/4a5uEFrFtXiah3OmUWY20eRIqayuUB/Rv2ZJEUwDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaF9mnzL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483510; x=1767019510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xrTkA4CXCXZBqeSsOUcif0RrVXU2R0EvNOBlTA/cJ2A=;
  b=HaF9mnzLhF3PEtbwPDFIqvCoZWIn93jbq00+xOEUkAu2nvZteAICZEls
   xboxqukA2X9LL9WnJFIIr6iXXaZTDyrng/5Qi+6whVvZsd8xO6ovhvr4B
   S7b907ICEZOGAd6x1taoCXqbvB0kfFDKfvZAlSlhs7cwufYSWc2T2RTak
   hoV1tW+UGSo4itQuNWUayC438mZ1xexuFSJAsoarRnUdj0o5YHavtO+5r
   ameKz1ykZwqmy60qEC65ZJIg5Qoo/HoJPbVvCFA1wc0PHIbbCRJDmZN3Q
   OaMYfKTKrvQtHYOjZ2ecttZZBHGftqhLdMlTal/Jm5E++OgalnVOwTKGj
   w==;
X-CSE-ConnectionGUID: HgA2r1AcSt6b/yfd/krhUA==
X-CSE-MsgGUID: BRCxfXOnQiaTLkzWtSFmUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572428"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572428"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:10 -0800
X-CSE-ConnectionGUID: O6vQ4zCqSrq8boLRJt6JuA==
X-CSE-MsgGUID: aZU7YxYXRKSVRIOoGfkAxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656803"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 02/17] wifi: iwlwifi: fw: api: tdls: remove MVM_ from name
Date: Sun, 29 Dec 2024 16:44:37 +0200
Message-Id: <20241229164246.66e17791c392.I6998e263973c26c1e22b4f470b974a519011b29a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The API isn't really MVM specific, it's just the firmware
API. Remove the "MVM_" from the name here as well, as we've
already done in many other places.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h  | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
index 893438aadab0..cfa6532a3cdd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -10,7 +10,7 @@
 #include "fw/api/tx.h"
 #include "fw/api/phy-ctxt.h"
 
-#define IWL_MVM_TDLS_STA_COUNT	4
+#define IWL_TDLS_STA_COUNT	4
 
 /* Type of TDLS request */
 enum iwl_tdls_channel_switch_type {
@@ -128,7 +128,7 @@ struct iwl_tdls_config_cmd {
 	u8 tdls_peer_count;
 	u8 tx_to_ap_tid;
 	__le16 tx_to_ap_ssn;
-	struct iwl_tdls_sta_info sta_info[IWL_MVM_TDLS_STA_COUNT];
+	struct iwl_tdls_sta_info sta_info[IWL_TDLS_STA_COUNT];
 
 	__le32 pti_req_data_offset;
 	struct iwl_tx_cmd pti_req_tx_cmd;
@@ -155,7 +155,7 @@ struct iwl_tdls_config_sta_info_res {
  */
 struct iwl_tdls_config_res {
 	__le32 tx_to_ap_last_seq;
-	struct iwl_tdls_config_sta_info_res sta_info[IWL_MVM_TDLS_STA_COUNT];
+	struct iwl_tdls_config_sta_info_res sta_info[IWL_TDLS_STA_COUNT];
 } __packed; /* TDLS_CONFIG_RSP_API_S_VER_1 */
 
 #endif /* __iwl_fw_api_tdls_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d34ce4ffa980..6e0e12229672 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3919,7 +3919,7 @@ iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
 
 	if (sta->tdls &&
 	    (vif->p2p ||
-	     iwl_mvm_tdls_sta_count(mvm, NULL) == IWL_MVM_TDLS_STA_COUNT ||
+	     iwl_mvm_tdls_sta_count(mvm, NULL) == IWL_TDLS_STA_COUNT ||
 	     iwl_mvm_phy_ctx_count(mvm) > 1)) {
 		IWL_DEBUG_MAC80211(mvm, "refusing TDLS sta\n");
 		return -EBUSY;
-- 
2.34.1


