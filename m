Return-Path: <linux-wireless+bounces-18521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D32A28AF9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3C93A5FD9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2C5FC1D;
	Wed,  5 Feb 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chxUMEVc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602FEA32
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760174; cv=none; b=uZdRlBq0iI5NyDCUkvqFvuA8e+f7Bku4Ram7Al4t1arKNmxyl252hAwlFZYFx/4Lyh7ah9VzTW+OOQYUSZnZ2jHRZrU8xaXeKgmJrULS26w9jWuzoJxz0juLejqT7O6L9C9lWKTzkIEHXnsw8v+m575fSCrymP+9JsDYZVWkKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760174; c=relaxed/simple;
	bh=mdrWi0suj1P1aPUOmzcJIyZic3Hhi/uu3Sb+qYjIIeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=meE7as2TKYtqo6FM4C7Wjda+49FN3vec1cqtpTk01P54EmKMlZEbqC0h6B0Gkkj+c9Ci5+sN7/FkM/O52/gpXbExKGMy6A5XrUlP2zSm2cLosBdMrvKGRbGuGLZ/Z5qaTFJkLyjq9wV40kqUCXg3BTzVLl1iFnrDXYVdpvUBIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chxUMEVc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760169; x=1770296169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdrWi0suj1P1aPUOmzcJIyZic3Hhi/uu3Sb+qYjIIeI=;
  b=chxUMEVck/uVXFNg+y/8ZAQS6wCBZfzItGh1Dv+ZJbULFLCGQCsJ2JFB
   LQqxMyt2AeCwUB0i8diPwN2UnvjKeE1rw/ZOLvo9YnYX2AMYes7PevzAF
   Et69kFnfj11QA2nfkcSrKy9FJyvPOiM4jbdxl40ijZn6yFz+ClRBpx+hZ
   K+uJQcg0shdfo5AGjzVUl9YNif5Yov4uIP6xfgCeZJK65omJwOV6rSQPp
   wVlTM5WZJjpEYFUq8ma/J5uvVoUFm0gxtzN9002JbrcdJMEqNmUV3Ie8q
   W0CoKdXp49QZPRsiqjwppKCkzl5h6gFoJInxA4Gti6vBDpYOdAUwaiFyv
   Q==;
X-CSE-ConnectionGUID: igFvZqi+TQ+WNNHuqXXXTA==
X-CSE-MsgGUID: 3N+9iVIPSsS6ZDwambHgCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159167"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159167"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:09 -0800
X-CSE-ConnectionGUID: tbZL6wOvQEKUTM9iMT8rzw==
X-CSE-MsgGUID: ha5Lv2YqSEa2C1+9HUsoxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745449"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 03/19] wifi: iwlwifi: remove the mvm prefix from iwl_mvm_aux_sta_cmd
Date: Wed,  5 Feb 2025 14:55:32 +0200
Message-Id: <20250205145347.1d0978118509.I70641851f9e5210ec3a7033db38a45d24814083b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is a firmware command and is not specific to the iwlmvm op_mode

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 37bb7002c1c9..232e20482e2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -46,7 +46,7 @@ enum iwl_mac_conf_subcmd_ids {
 	 */
 	STA_CONFIG_CMD = 0xA,
 	/**
-	 * @AUX_STA_CMD: &struct iwl_mvm_aux_sta_cmd
+	 * @AUX_STA_CMD: &struct iwl_aux_sta_cmd
 	 */
 	AUX_STA_CMD = 0xB,
 	/**
@@ -641,7 +641,7 @@ struct iwl_sta_cfg_cmd {
 } __packed; /* STA_CMD_API_S_VER_1 */
 
 /**
- * struct iwl_mvm_aux_sta_cmd - command for AUX STA configuration
+ * struct iwl_aux_sta_cmd - command for AUX STA configuration
  * ( AUX_STA_CMD = 0xB )
  *
  * @sta_id: index of aux sta to configure
@@ -649,7 +649,7 @@ struct iwl_sta_cfg_cmd {
  * @mac_addr: mac addr of the auxilary sta
  * @reserved_for_mac_addr: reserved
  */
-struct iwl_mvm_aux_sta_cmd {
+struct iwl_aux_sta_cmd {
 	__le32 sta_id;
 	__le32 lmac_id;
 	u8 mac_addr[ETH_ALEN];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 2f159024eeb8..9dd670041137 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -121,7 +121,7 @@ static int iwl_mvm_add_aux_sta_to_fw(struct iwl_mvm *mvm,
 {
 	int ret;
 
-	struct iwl_mvm_aux_sta_cmd cmd = {
+	struct iwl_aux_sta_cmd cmd = {
 		.sta_id = cpu_to_le32(sta->sta_id),
 		.lmac_id = cpu_to_le32(lmac_id),
 	};
-- 
2.34.1


