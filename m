Return-Path: <linux-wireless+bounces-33501-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCrtJl9FvGkJwQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33501-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:50:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3F2D1507
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 19:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48711301BD58
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 18:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F1F34EEE4;
	Thu, 19 Mar 2026 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0fd1y5/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B897B315D33
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946159; cv=none; b=Cn9Or2F2M9+0MZ4Aid+F9DETr7tf2jpq0bX7/NF2tEQRmNWk5m7gZnMV8ok3Fc7qS0bnFhCRLW8Zi1LAc6e6TaXxSEwFpJtrFAkzfJ4vhn6Jf282aDY8hJTIGxoqo1f33ZWm0fMvwZLy2uuGHYz1wosm4h9abrwHSIFLqcseKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946159; c=relaxed/simple;
	bh=z80i2/4XoEOc4ncQeDYz0t1dOjpNbwOzaZfKCrvhyfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P70awz8nynFFZ3hr1tXcH9UkpE63qjYotjtTaKcvFPBp3QQVKttB5LbqTYBm1wgGLuaVtMX8VIwTfs5lwI9D/TfuXAiFXPt5FE3MvFzrxH+V2kdZ+gT1CpNYcwTTJKbmqff9+cg2rGkGgvTgjEjrTxd9bTD3/5luIngWebNAKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0fd1y5/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773946158; x=1805482158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z80i2/4XoEOc4ncQeDYz0t1dOjpNbwOzaZfKCrvhyfg=;
  b=K0fd1y5/DTozQ2dnZx79G/dkrrB6mKXo/+D1DzKXbgcewYikyqqH4vVe
   QcDp8R+a6Gec9ZvvV9NQfHeFjhup5ZLmdBRgGtb2zyGqmDUkSoy19l02B
   C855YSC0HWbDhWdVD3ZArsq8rZ+VuorPMpSfvZ1oS+/dcgTIQ/zKoP0yX
   2ZpiSGJCuBoQ3BW8zmYVfGGV8eg+CFwp/sduMMT9CniJ6u9gi9yRdZBY4
   eCxfHSqzlgtgZNjoK+hy5NzV4Nd3HOVzXPzdC1rVggOpKDcII+ZCw+0h9
   o4wbws08BodZaKHMSDDF7FIdWCx0TS1ehoW/KZBW8l8uC/hK3UFkPu/RJ
   g==;
X-CSE-ConnectionGUID: skc9XwVpRxWVrZpC9QvXUA==
X-CSE-MsgGUID: gAUmfV8YTlGzevfQB2M6Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85656483"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85656483"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:18 -0700
X-CSE-ConnectionGUID: OTLmEYrBQqqcw+ZqiP3RIw==
X-CSE-MsgGUID: FAUlWH0KSpSyZgxQnkNdzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227998525"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 11:49:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: support version 11 of REDUCE_TX_POWER_CMD
Date: Thu, 19 Mar 2026 20:48:47 +0200
Message-Id: <20260319204647.9cea60b78a1b.Ia91c59829af0dc4d6c351c5b09ce33800c1f9e44@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
References: <20260319184855.1981384-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33501-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EE3F2D1507
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This introduces support for UNII-9.
After we increased the size of the arrays of the subbands in SAR
structure, we now support the new firmware command.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 15 ++++++++-
 .../net/wireless/intel/iwlwifi/mld/power.c    |  5 ++-
 .../wireless/intel/iwlwifi/mld/regulatory.c   | 32 +++++++++++++++----
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 118c08f95649..ec923162a44b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -426,19 +426,32 @@ struct iwl_dev_tx_power_cmd_v10 {
 	__le32 flags;
 } __packed; /* TX_REDUCED_POWER_API_S_VER_10 */
 
+struct iwl_dev_tx_power_cmd_v11 {
+	__le16 per_chain[IWL_NUM_CHAIN_TABLES_V2][IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V3];
+	u8 per_chain_restriction_changed;
+	u8 reserved;
+	__le32 timer_period;
+	__le32 flags;
+} __packed; /* TX_REDUCED_POWER_API_S_VER_11 */
+
 /*
  * struct iwl_dev_tx_power_cmd - TX power reduction command (multiversion)
  * @common: common part of the command
  * @v9: version 9 part of the command
  * @v10: version 10 part of the command
+ * @v11: version 11 part of the command
  */
 struct iwl_dev_tx_power_cmd {
 	struct iwl_dev_tx_power_common common;
 	union {
 		struct iwl_dev_tx_power_cmd_v9 v9;
 		struct iwl_dev_tx_power_cmd_v10 v10;
+		struct iwl_dev_tx_power_cmd_v11 v11;
 	};
-} __packed; /* TX_REDUCED_POWER_API_S_VER_9_VER10 */
+} __packed; /* TX_REDUCED_POWER_API_S_VER_9
+	     * TX_REDUCED_POWER_API_S_VER_10
+	     * TX_REDUCED_POWER_API_S_VER_11
+	     */
 
 #define IWL_NUM_GEO_PROFILES		3
 #define IWL_NUM_GEO_PROFILES_V3		8
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/power.c b/drivers/net/wireless/intel/iwlwifi/mld/power.c
index c3318e84f4a2..49b0d9f8f865 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/power.c
@@ -405,7 +405,10 @@ int iwl_mld_set_tx_power(struct iwl_mld *mld,
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_LINK),
 		.common.pwr_restriction = cpu_to_le16(u_tx_power),
 	};
-	int len = sizeof(cmd.common) + sizeof(cmd.v10);
+	int len = sizeof(cmd.common) + sizeof(cmd.v11);
+
+	if (iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 10) == 10)
+		len = sizeof(cmd.common) + sizeof(cmd.v10);
 
 	if (WARN_ON(!mld_link))
 		return -ENODEV;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index 27059ec93847..78db140aa1f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -95,23 +95,43 @@ static int iwl_mld_geo_sar_init(struct iwl_mld *mld)
 
 int iwl_mld_config_sar_profile(struct iwl_mld *mld, int prof_a, int prof_b)
 {
-	u32 cmd_id = REDUCE_TX_POWER_CMD;
 	struct iwl_dev_tx_power_cmd cmd = {
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
-		.v10.flags = cpu_to_le32(mld->fwrt.reduced_power_flags),
 	};
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, REDUCE_TX_POWER_CMD, 10);
+	int num_subbands;
+	int cmd_size;
 	int ret;
 
+	switch (cmd_ver) {
+	case 10:
+		cmd.v10.flags = cpu_to_le32(mld->fwrt.reduced_power_flags);
+		cmd_size = sizeof(cmd.common) + sizeof(cmd.v10);
+		num_subbands = IWL_NUM_SUB_BANDS_V2;
+		break;
+	case 11:
+		cmd.v11.flags = cpu_to_le32(mld->fwrt.reduced_power_flags);
+		cmd_size= sizeof(cmd.common) + sizeof(cmd.v11);
+		num_subbands = IWL_NUM_SUB_BANDS_V3;
+		break;
+	default:
+		WARN_ONCE(1, "Bad version for REDUCE_TX_POWER_CMD: %d\n",
+			  cmd_ver);
+		return -EOPNOTSUPP;
+	}
+
 	/* TODO: CDB - support IWL_NUM_CHAIN_TABLES_V2 */
-	ret = iwl_sar_fill_profile(&mld->fwrt, &cmd.v10.per_chain[0][0][0],
-				   IWL_NUM_CHAIN_TABLES, IWL_NUM_SUB_BANDS_V2,
+	/* v10 and v11 have the same position for per_chain */
+	BUILD_BUG_ON(offsetof(typeof(cmd), v11.per_chain) !=
+		     offsetof(typeof(cmd), v10.per_chain));
+	ret = iwl_sar_fill_profile(&mld->fwrt, &cmd.v11.per_chain[0][0][0],
+				   IWL_NUM_CHAIN_TABLES, num_subbands,
 				   prof_a, prof_b);
 	/* return on error or if the profile is disabled (positive number) */
 	if (ret)
 		return ret;
 
-	return iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd,
-				    sizeof(cmd.common) + sizeof(cmd.v10));
+	return iwl_mld_send_cmd_pdu(mld, REDUCE_TX_POWER_CMD, &cmd, cmd_size);
 }
 
 int iwl_mld_init_sar(struct iwl_mld *mld)
-- 
2.34.1


