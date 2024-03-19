Return-Path: <linux-wireless+bounces-4886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6694C87F915
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1FE282D59
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5824B7C0BA;
	Tue, 19 Mar 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clSf/dee"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0F7C6DB
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835856; cv=none; b=VBaIHXcOhz4ggkMuLZBZBYDrdZQAMGFIcOgjH/LZ4cuiu3AsqA6s8F9q8w0xipo4SNPN5h/jp8ZZZn7jYlrdi3xhQpNR61dMBAIVZQqfDdAu/ykc4BxZfc1iSpxqkPRn2C3M3wEhRu3jGJCG86xXVZiyXvcDj4be2XWqKF1Jxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835856; c=relaxed/simple;
	bh=HuMdXcutYJ+Y8LDAwEHJJWovwrd/yxl8N05Y+bUV7h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Asjk73em7pTIVPdtyxGbkVdxxpr9SdLMJ79LwecfgU0Uo0aJvMS/XET3xbpsQZ4J+X/jgF836y+e7Llz39qhjxshMyuZHzZZnuQZ6JD/oi6Dw6jOAJw+R/QzW7xkgAeWMa8GLbIuQU5TtwkJr5c/G8Lt4IK+a9yu0kkxYeKll1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clSf/dee; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835855; x=1742371855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HuMdXcutYJ+Y8LDAwEHJJWovwrd/yxl8N05Y+bUV7h4=;
  b=clSf/deeCqWMGTPHOqrq0Gi4oYTGZnJ7XrhZOOvEfakHPAHj6t7n4tZu
   8q8eT59KAZ/LTwpltET5cv0xRww9nfciFSsxr7RBlE4Hl0EfjuOeg+N3V
   vkFQGysD7amrdjWVLVBPnsbXuCddqc27tlykGx3F1P4LgAYZMqFWtbkgD
   Ixqyx02Xk6CBMt3u9A/q9va2u3M80bUVeCbAlEXOTd2kNEmSGl+eplUVt
   6+Emt7qgPKcCEab+EVqioSDoQYpn6jyASw22Wrsj2ExhNzaFErrnGIUaj
   jHA7EIxKWEaWhBoa06F6cSMYTO6ihJhvQqZ0huChyUYM3p9D+oi295ASD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810548"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810548"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447601"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:10:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: support iwl_dev_tx_power_cmd_v8
Date: Tue, 19 Mar 2024 10:10:18 +0200
Message-Id: <20240319100755.29ff7a88ddac.I39cf2ff1d1ddf0fa62722538698dc7f21aaaf39e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This just adds a __le32 that we (currently) don't use.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 30 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  4 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++-
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 0bf38243f88a..ce18ef9d3128 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -385,6 +385,33 @@ struct iwl_dev_tx_power_cmd_v7 {
 	__le32 timer_period;
 	__le32 flags;
 } __packed; /* TX_REDUCED_POWER_API_S_VER_7 */
+
+/**
+ * struct iwl_dev_tx_power_cmd_v8 - TX power reduction command version 8
+ * @per_chain: per chain restrictions
+ * @enable_ack_reduction: enable or disable close range ack TX power
+ *	reduction.
+ * @per_chain_restriction_changed: is per_chain_restriction has changed
+ *	from last command. used if set_mode is
+ *	IWL_TX_POWER_MODE_SET_SAR_TIMER.
+ *	note: if not changed, the command is used for keep alive only.
+ * @reserved: reserved (padding)
+ * @timer_period: timer in milliseconds. if expires FW will change to default
+ *	BIOS values. relevant if setMode is IWL_TX_POWER_MODE_SET_SAR_TIMER
+ * @flags: reduce power flags.
+ * @tpc_vlp_backoff_level: user backoff of UNII5,7 VLP channels in USA.
+ *	Not in use.
+ */
+struct iwl_dev_tx_power_cmd_v8 {
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES_V2][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
+	u8 enable_ack_reduction;
+	u8 per_chain_restriction_changed;
+	u8 reserved[2];
+	__le32 timer_period;
+	__le32 flags;
+	__le32 tpc_vlp_backoff_level;
+} __packed; /* TX_REDUCED_POWER_API_S_VER_8 */
+
 /**
  * struct iwl_dev_tx_power_cmd - TX power reduction command (multiversion)
  * @common: common part of the command
@@ -392,6 +419,8 @@ struct iwl_dev_tx_power_cmd_v7 {
  * @v4: version 4 part of the command
  * @v5: version 5 part of the command
  * @v6: version 6 part of the command
+ * @v7: version 7 part of the command
+ * @v8: version 8 part of the command
  */
 struct iwl_dev_tx_power_cmd {
 	struct iwl_dev_tx_power_common common;
@@ -401,6 +430,7 @@ struct iwl_dev_tx_power_cmd {
 		struct iwl_dev_tx_power_cmd_v5 v5;
 		struct iwl_dev_tx_power_cmd_v6 v6;
 		struct iwl_dev_tx_power_cmd_v7 v7;
+		struct iwl_dev_tx_power_cmd_v8 v8;
 	};
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index e1c2b7fc92ab..df3b29b998cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -896,11 +896,13 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	u32 n_subbands;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
 					   IWL_FW_CMD_VER_UNKNOWN);
-	if (cmd_ver == 7) {
+	if (cmd_ver >= 7) {
 		len = sizeof(cmd.v7);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;
 		per_chain = cmd.v7.per_chain[0][0];
 		cmd.v7.flags = cpu_to_le32(mvm->fwrt.reduced_power_flags);
+		if (cmd_ver == 8)
+			len = sizeof(cmd.v8);
 	} else if (cmd_ver == 6) {
 		len = sizeof(cmd.v6);
 		n_subbands = IWL_NUM_SUB_BANDS_V2;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1c0383d3c6a6..01843a1c9c24 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1412,7 +1412,9 @@ int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (tx_power == IWL_DEFAULT_MAX_TX_POWER)
 		cmd.common.pwr_restriction = cpu_to_le16(IWL_DEV_MAX_TX_POWER);
 
-	if (cmd_ver == 7)
+	if (cmd_ver == 8)
+		len = sizeof(cmd.v8);
+	else if (cmd_ver == 7)
 		len = sizeof(cmd.v7);
 	else if (cmd_ver == 6)
 		len = sizeof(cmd.v6);
-- 
2.34.1


