Return-Path: <linux-wireless+bounces-33572-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEWnH7oBvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33572-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:13:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4952D7011
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AC633049E7D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76968371891;
	Fri, 20 Mar 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBYjzkSk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394BE36F401
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994188; cv=none; b=EwKGqoRdv+Ba6z7e5OKm3yCcMqpIPyYg5Fih307OjGD/RJOy8VfcQ711aUB6V+/xI+vyZRmlEct6buOGcBDaZGh09f5EvdaYZ6hfMeFIgdkW/jfx3GXbwB3tShDn9l3OUEyeWyBP9cYfUAtt4LEFeGkR0zY21F1M45poAMTf9/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994188; c=relaxed/simple;
	bh=6fMqFl4C67R3a12f+oW5g2628/BN7q64SU5pUefGg/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZjvPa+geyIRfo2MrGE+Wlbt4C/o8++Cq/xQmsW9bK91gj1MVJvW+SpJF8Pd+dR+JArNcN+Fu2ElaIR1TkRqTSPHRRNwhFD5Uy2ZUDneeC9TSBEANcT+/t3TV60OskNq4BVq+rZN4foAbaQIImrnOYBIiG/EhOyxd0lAEXRq40ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBYjzkSk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994187; x=1805530187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6fMqFl4C67R3a12f+oW5g2628/BN7q64SU5pUefGg/k=;
  b=SBYjzkSkfbrPJI7PWJ4ASQssipvRJQ1PGr3zWSDHUb/XIUIM8H642nvf
   ngVAbbDRmcZ6FdEaAlX1QnVS+kwkF5/TSnGT/Fk1Mim1iPC+vDBxJdEVV
   yHdLM1XZaPyEYtD/+7B8oZG9pmgmHk0nwtSlESTSJO5pR04gt/YluGp5u
   kqfqu8cOpfDZsgIS2NduJa33zayStoaGi9xEXu6zpj4EOBljTb674NZKn
   NymEjJriGukYiO5OYha+90qPQn/ejuavVXXmwOEftmHF7vPRI0UGhBu7O
   jFftISfDeh/YAnQJJGXSIdINyz5sdOUjHNnCH1juYNznrER5M3oSUDoHi
   w==;
X-CSE-ConnectionGUID: fFOubwUsTP+xjZ/ta2o0Tg==
X-CSE-MsgGUID: nsz2WvlKS8m/IF3J7+2/3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154148"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154148"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:47 -0700
X-CSE-ConnectionGUID: wK0C/dH3RpiiX1Pam8V6eQ==
X-CSE-MsgGUID: DKkU/LazR4aNkrew/S3qGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692614"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mld: add BIOS revision compatibility check for PPAG command
Date: Fri, 20 Mar 2026 10:09:14 +0200
Message-Id: <20260320100746.79bf2bf398d0.I8161dbe1a04af3738e00ab0fc13fe3dbfa9094ec@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33572-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3A4952D7011
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Prevent potential issues when newer BIOS revisions
are used with firmware that doesn't support them for
PER_PLATFORM_ANT_GAIN_CMD.

Without this check, the driver may attempt to use
BIOS configurations that are incompatible with the
current firmware version, leading to dropping of
command in firmware without any failure notification
to driver.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/regulatory.c   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
index f91f61ca9b2e..1633c8aa2e5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
@@ -214,6 +214,7 @@ static int iwl_mld_ppag_send_cmd(struct iwl_mld *mld)
 	u32 cmd_id = WIDE_ID(PHY_OPS_GROUP, PER_PLATFORM_ANT_GAIN_CMD);
 	int cmd_ver = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 1);
 	int cmd_len = sizeof(cmd.v8);
+	u8 cmd_bios_rev;
 	int ret;
 
 	BUILD_BUG_ON(offsetof(typeof(cmd), v8.ppag_config_info.hdr) !=
@@ -249,6 +250,10 @@ static int iwl_mld_ppag_send_cmd(struct iwl_mld *mld)
 			}
 		}
 		cmd_len = sizeof(cmd.v7);
+		cmd_bios_rev =
+			iwl_fw_lookup_cmd_bios_supported_revision(fwrt->fw,
+								  fwrt->ppag_bios_source,
+								  cmd_id, 4);
 	} else if (cmd_ver == 8) {
 		for (int chain = 0; chain < ARRAY_SIZE(cmd.v8.gain); chain++) {
 			for (int subband = 0;
@@ -262,12 +267,22 @@ static int iwl_mld_ppag_send_cmd(struct iwl_mld *mld)
 						cmd.v8.gain[chain][subband]);
 			}
 		}
+		cmd_bios_rev =
+			iwl_fw_lookup_cmd_bios_supported_revision(fwrt->fw,
+								  fwrt->ppag_bios_source,
+								  cmd_id, 5);
 	} else {
 		WARN(1, "Bad version for PER_PLATFORM_ANT_GAIN_CMD %d\n",
 		     cmd_ver);
 		return -EINVAL;
 	}
 
+	if (cmd_bios_rev < fwrt->ppag_bios_rev) {
+		IWL_ERR(mld, "BIOS revision compatibility check failed - Supported: %d, Current: %d\n",
+			cmd_bios_rev, fwrt->ppag_bios_rev);
+		return 0;
+	}
+
 	IWL_DEBUG_RADIO(mld, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
 	ret = iwl_mld_send_cmd_pdu(mld, cmd_id, &cmd, cmd_len);
 	if (ret < 0)
-- 
2.34.1


