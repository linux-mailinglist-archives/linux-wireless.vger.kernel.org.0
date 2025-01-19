Return-Path: <linux-wireless+bounces-17718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E24FA163AF
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 20:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A953E3A58C8
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF311422AB;
	Sun, 19 Jan 2025 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ua9a1avD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409EB1DF742
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737313417; cv=none; b=sU+QuvCg0Yod2DhmLwfChY+avHR99Wi4ISp1BO2BuJWZIS1CMBKFpwYaWr7zy2iSIPNF+BvFfX8CxmARf/VW3BNayTVhYjx7uFX/6kaS+CQxLYG/v+1LtkrgLNnOIHWHSBoVfR6NiCtV77nfvdfwmyX5ZkeuSrXtkXAX/ZTuwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737313417; c=relaxed/simple;
	bh=EZ2IJhCGwMV3pU0+m5eUCb7ttDoWuP0lmCP9CkyyS+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MTtqkggiifF1FHRRjXB5TJ4RKcGXJcJnMQzBO8BJgZmfxLFIUKPgA3/WhR/nGkPSpUynAuXjDf/3L6tPs5OjFBYDmLrMTuHx5Nu512mqQguG1KxQBZ7IWGKzKbx7o9BtYI4d3m4DpGfbK6Zidtzs6gkb66eMo4MQgYcgjZzR8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ua9a1avD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737313416; x=1768849416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EZ2IJhCGwMV3pU0+m5eUCb7ttDoWuP0lmCP9CkyyS+E=;
  b=Ua9a1avDQ72OGd3o472pOgWEQ13hI5U46lqpsJkVc18ZBSD2UdQnpYF3
   Gz/zH5gCW6DkI0nOHilOfNKhy6qIJEIHVWt0GpzAA86aLr9EO1ARGeyes
   oTPi5FhP5pjBpGY3QbcNlKGjQDBQziCzmU5yw5/efQbYBb09ouLIjE7Ii
   9Qbn+W8Ne9b+dkkVxHD0jOB9J2ylaCqHY2lgVNQuS/yfp43C10XGqMsH9
   DjeLH8CjYTF0j/9OyxgB4eEIOFb+LO72TcpMXnxDh/YS4lKJW2qh/h0FR
   +YBP6i/Knz6hQcgzoA+VNocf9TawKSZdJxYIjzKBe0vPTE3r23P6EyqYk
   Q==;
X-CSE-ConnectionGUID: JA75nAUrREyPNdV/CDbbpA==
X-CSE-MsgGUID: 2DBlxNU1RxqjNJaD4RzSAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="37556139"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="37556139"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 11:03:34 -0800
X-CSE-ConnectionGUID: 3CcZWHS8SgW+u5DdeCCmfw==
X-CSE-MsgGUID: TMLke+ucQ2ekeAfF8ODAbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106127771"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 11:03:32 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2] wifi: iwlwifi: remove the mvm prefix from iwl_mvm_aux_sta_cmd
Date: Sun, 19 Jan 2025 21:03:15 +0200
Message-Id: <20250119210104.276658439163.I70641851f9e5210ec3a7033db38a45d24814083b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250119210104.04f3afcf9c77.Ic2b6f265d0b4aea25ccc7114d6f48afa621871be@changeid>
References: <20250119210104.04f3afcf9c77.Ic2b6f265d0b4aea25ccc7114d6f48afa621871be@changeid>
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
v2: rephrased the commit message

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


