Return-Path: <linux-wireless+bounces-16866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3A9FDF43
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3FD3A18AA
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7A1917E4;
	Sun, 29 Dec 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEJ4V1M/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8579191F74
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483515; cv=none; b=TQickiaOYpqyac7PtdZ/cxjcHWktYtg/OHzG4Uje6FiWD4uv6zCgcVf8v5KDRo9PDgH7ioBwCxpLo2ndALWB3fqaSU98gE25PI5L+el/az5AVku2RpPvhS1/tP6MR6LM2l6xoxgF8jiB093xCEGKxcg7JhiK9ErenPVYBrwTyBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483515; c=relaxed/simple;
	bh=4WPtpO5RmuL/owV5jmdMaAC6YaWYsMI6Fzi3DU/OuNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPhr7R7pK/IT3kQzcGZpRoBZDYJK74pf3QxTzmgwlqhukcl3pA7ZWIhLMIXR1Q3H11JvCpy4xzLpzH8uGj4XNWEbPeGhdiGmYJg4YvNmj01InYk3lAsy0qRFYITkEhsAErBJc2RL2XvBU99GHeWx10jnHG+kV+bTxpMtA1stevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEJ4V1M/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483514; x=1767019514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4WPtpO5RmuL/owV5jmdMaAC6YaWYsMI6Fzi3DU/OuNM=;
  b=eEJ4V1M/NaEnNdCgUIk2289B+4V3/8KjqESCoCv07Wp+q8FISyv9slT5
   2Rsd4RlhOyF/NrCKjUyRQ38VoccHYFRRnPevTjIfdpmt7aopwNyH6EC00
   PRNbhZsw7ExqFu/YoEYsri0FPsqjUx+isu0fTshbT7zshjt52YcPVMdvj
   vv0D14DdGn4ygwBuwK11LSUKNBWCcmqvSE9nVlZj/kzhEbzQaBDIMu44I
   3ttfRJZCraMZCnAhfttFyConXLsJcZ7xGq7PccRwyMPQd8oR8hbL1gHiU
   ubl9+s1upr8hGeHqMrJET0blgeLAt7dGVxm556AwWTPDWDGdzXVN1G3QJ
   A==;
X-CSE-ConnectionGUID: y86fnzxwSfOUpAQA+Wa9WQ==
X-CSE-MsgGUID: V05HzJCqQlumnxS32l1MVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572434"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572434"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:14 -0800
X-CSE-ConnectionGUID: y2sZ/GEPT2+LvhTc4RkIFw==
X-CSE-MsgGUID: TAzf2S5DQQmvlujlkfXtcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656904"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 05/17] wifi: iwlwifi: mvm: s/iwl_mvm_aux_sta_cmd/iwl_aux_sta_cmd
Date: Sun, 29 Dec 2024 16:44:40 +0200
Message-Id: <20241229164246.ca3b97e29365.I70641851f9e5210ec3a7033db38a45d24814083b@changeid>
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
index 019839604011..b9c0334daa43 100644
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


