Return-Path: <linux-wireless+bounces-37093-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDCvMlwoGWo3rQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37093-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:47:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B15FD849
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 291DF300ACBE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96CF30EF77;
	Fri, 29 May 2026 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INHf8z6l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDC3A4512
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033613; cv=none; b=hbHfDLHYm2DJ91hu754XQJHeUD7Uaok0wsJNPwyRsFHt6RiWwp1N00rv+J6gMCnNTAisnGbZNX5pqRI9+0IQzLfd+EfMf96yDDfuOYwUMGhVIsVScw0v1AUBY3c/ITpZoMMPL6tfxrxKPAhkLhju6UGuDDo8Wr1FHn2S4w3FXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033613; c=relaxed/simple;
	bh=hJ3BqeiFJRoZrgu8rGXza/rCM5+mupDyqvrTOnR5gYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0qSslLlR8p7pyguWqryJ3F9FTucyjoAhuxAvN2HzGw3iY2iPk1dwiI5IIb6kikZ9MYT5Iw8dsVDZPIlgp4Qq4wNt3fAR5Te7ufd/vZKcxJl6+t5Mk6C9PeloJ4D6VM/Py1kkU5TAOWmWB+ThCLH5T7neAOPkrBNZfUGdB62O/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INHf8z6l; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780033612; x=1811569612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hJ3BqeiFJRoZrgu8rGXza/rCM5+mupDyqvrTOnR5gYk=;
  b=INHf8z6ldGnN8/6ZgrlubfyDzMqMROTkBnerqFMEfHQQqft44cAL7ptu
   m2layZe0A9EDtUcnoTb3QgWDLSgK63U7shVWmT+PRdSRYFpSnPsZDkLtw
   fXba1Jmfnc+FXnL3x+GAPek05/UGLI/hTbOoScfZ3elQxGnUUr/zxP4fb
   QaVfk3PPwMjQttxpGSSRqbZu5EVJQKZ4rA/zQepNQgeY+hMB+aoQz4REa
   NpOLESzzCRd/iIll8cvYYgnP2JMZS1ZxQCZqdZP3DfcGlASVd8uSVb0HI
   KuX492AMScPZptdPHjl199dYDyelLLGVI4KFFgjW25IcEBpKBXRb8wqo4
   g==;
X-CSE-ConnectionGUID: KpZNUWRrQMWcNX0UoKGUFQ==
X-CSE-MsgGUID: s9aydoSAQhi4aH+uxl7B3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="91453712"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="91453712"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:46:52 -0700
X-CSE-ConnectionGUID: dKDmw2DqRgKaFkowg609Zg==
X-CSE-MsgGUID: 6lYai7zBRE2WbtwHUeBCuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="247043596"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:46:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-fixes 3/3] wifi: iwlwifi: mvm: avoid oversized UATS command copy
Date: Fri, 29 May 2026 08:46:31 +0300
Message-Id: <20260529084540.6c79ecf6814d.I348df3980764c15efce0099a35fe8a88fb2a6ee2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054631.4039300-1-miriam.rachel.korenblit@intel.com>
References: <20260529054631.4039300-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37093-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 6C7B15FD849
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

MCC_ALLOWED_AP_TYPE_CMD exceeds the fixed copied host-command buffer
and triggers warnings in the gen2 enqueue path when command
0xc05 is sent.

Use IWL_HCMD_DFL_NOCOPY as it was done before the offending commit.

Fixes: 078df640ef05 ("wifi: iwlwifi: mld: add support for iwl_mcc_allowed_ap_type_cmd v2")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c |  26 +-
 res                                         | 250 ++++++++++++++++++++
 2 files changed, 271 insertions(+), 5 deletions(-)
 create mode 100644 res

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f05df3a3300e..6e507d6dcdd2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -459,9 +459,14 @@ static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
 
 static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 {
+	struct iwl_mcc_allowed_ap_type_cmd_v1 *cmd __free(kfree) = NULL;
 	int cmd_id = WIDE_ID(REGULATORY_AND_NVM_GROUP,
 			     MCC_ALLOWED_AP_TYPE_CMD);
-	struct iwl_mcc_allowed_ap_type_cmd_v1 cmd = {};
+	struct iwl_host_cmd hcmd = {
+		.id = cmd_id,
+		.len[0] = sizeof(*cmd),
+		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
+	};
 	u8 cmd_ver;
 	int ret;
 
@@ -485,14 +490,25 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 	if (!mvm->fwrt.ap_type_cmd_valid)
 		return;
 
+	/* Since we free the command immediately after iwl_mvm_send_cmd, we
+	 * must send this command in SYNC mode.
+	 */
+	lockdep_assert_held(&mvm->mutex);
+
+	cmd = kzalloc_obj(*cmd);
+	if (!cmd)
+		return;
+
 	BUILD_BUG_ON(sizeof(mvm->fwrt.ap_type_cmd.mcc_to_ap_type_map) !=
-		     sizeof(cmd.mcc_to_ap_type_map));
+		     sizeof(cmd->mcc_to_ap_type_map));
 
-	memcpy(cmd.mcc_to_ap_type_map,
+	memcpy(cmd->mcc_to_ap_type_map,
 	       mvm->fwrt.ap_type_cmd.mcc_to_ap_type_map,
 	       sizeof(mvm->fwrt.ap_type_cmd.mcc_to_ap_type_map));
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
+	hcmd.data[0] = cmd;
+
+	ret = iwl_mvm_send_cmd(mvm, &hcmd);
 	if (ret < 0)
 		IWL_ERR(mvm, "failed to send MCC_ALLOWED_AP_TYPE_CMD (%d)\n",
 			ret);
diff --git a/res b/res
new file mode 100644
index 000000000000..07bc81f14701
--- /dev/null
+++ b/res
@@ -0,0 +1,250 @@
+The following changes since commit 1d174fec87850e1005db9b106f84bbbb19cb59b9:
+
+  ARM: dts: omap2: add stlc4560 spi-wireless node (2026-05-20 12:05:04 +0200)
+
+are available in the Git repository at:
+
+  https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/ tags/iwlwifi-next-2026-05-26
+
+for you to fetch changes up to 455fac900cf93d03a020b82f2cf2849cd2c74fd8:
+
+  wifi: iwlwifi: mld: fix indentation in iwl_mld_fill_supp_rates() (2026-05-26 15:17:13 +0300)
+
+----------------------------------------------------------------
+iwlwifi - next: 2026-05-26
+
+This contains mainly:
+UHR support (DPS, DUO, multi-link PM), NAN enhancements
+(multicast, schedule config v2, multiple stations), EMLSR fixes, new
+Killer/LNL device IDs, firmware API cleanups, and a few bugfixes
+
+----------------------------------------------------------------
+Aaron Katzin (1):
+      wifi: iwlwifi: pcie: add debug print for resume flow if powered off
+
+Avinash Bhatt (9):
+      wifi: iwlwifi: fix buffer overflow when firmware reports no channels
+      wifi: iwlwifi: Transition to basic uAPSD with MAC_PM_POWER_TABLE API VER_3
+      wifi: iwlwifi: mld: add chan-load hysteresis for MLO scan triggers
+      wifi: iwlwifi: mld: add duplicated beacon RSSI adjustment
+      wifi: iwlwifi: mld: Add KUnit tests for channel-load thresholds
+      wifi: iwlwifi: mld: implement PSD/EIRP RSSI adjustment
+      wifi: iwlwifi: mld: update link grading tables per bandwidth
+      wifi: iwlwifi: mld: skip MLO scan trigger when AP has no QBSS Load IE
+      wifi: iwlwifi: mld: keep healthy link on EMLSR missed beacon exit
+
+Avraham Stern (5):
+      wifi: iwlwifi: mld: call iwl_mld_free_ap_early_key() for AP only
+      wifi: iwlwifi: mld: add support for nan schedule config command version 2
+      wifi: iwlwifi: mld: add handler for NAN ULW attribute notification
+      wifi: iwlwifi: mld: nan: add availability attribute to schedule config
+      wifi: iwlwifi: mld: add support for deferred nan schedule config
+
+Daniel Gabay (4):
+      wifi: iwlwifi: mld: fix NAN DW end notification handler
+      wifi: iwlwifi: mld: add NULL check for channel in DW end handler
+      wifi: iwlwifi: mld: validate aux sta before flush in stop_nan
+      wifi: iwlwifi: print UHR rate type
+
+Dongyang Jin (1):
+      wifi: iwlwifi: mld: fix indentation in iwl_mld_fill_supp_rates()
+
+Emmanuel Grumbach (15):
+      wifi: iwlwifi: fix the access to CNVR TOP registers
+      wifi: iwlwifi: mld: honor BSS_CHANGED_BEACON_ENABLED
+      wifi: iwlwifi: mld: move iwl_mld_link_info_changed_ap_ibss to ap.c
+      wifi: iwlwifi: rename iwl_system_statistics_notif_oper
+      wifi: iwlwifi: introduce iwl_system_statistics_notif_oper version 4
+      wifi: iwlwifi: mld: support the new statistics APIs
+      wifi: iwlwifi: remove nvm_ver for devices that don't need it
+      wifi: iwlwifi: implement the new RSC notification
+      wifi: iwlwifi: led_compensation is needed for iwldvm only
+      wifi: iwlwifi: shadow_ram_support is needed for iwldvm only.
+      wifi: iwlwifi: max_event_log_size is needed for iwldvm only
+      wifi: iwlwifi: smem_offset smem_len are not needed from 22000 and up
+      wifi: iwlwifi: reduce the log level of firmware debug buffer size mismatch
+      wifi: iwlwifi: move pcie content to pcie internal transport
+      wifi: iwlwifi: move iwl_trans_activate_nic to iwl-trans.c
+
+Ilan Peer (7):
+      wifi: iwlwifi: mld: Fix number of antennas in NAN capabilities
+      wifi: iwlwifi: mld: Do not declare support for NDPE
+      wifi: iwlwifi: mld: Do not declare NAN support for Extended Key ID
+      wifi: iwlwifi: mld: Add support for multiple NAN Management stations
+      wifi: iwlwifi: mld: Replace static declarations of IWL_MLD_ALLOC_FN
+      wifi: iwlwifi: mld: Add support for NAN multicast data
+      wifi: iwlwifi: mld: Disallow using a per-STA GTK for Tx
+
+Israel Kozitz (1):
+      wifi: iwlwifi: mld: fix NAN max channel switch time unit
+
+Jay Ng (1):
+      wifi: iwlwifi: remove unused header inclusions
+
+Johannes Berg (38):
+      wifi: iwlwifi: mld: tlc: separate from link STA
+      wifi: iwlwifi: mld: disable queue hang detection for NAN data
+      wifi: iwlwifi: mld: support NAN and NAN_DATA interfaces
+      wifi: iwlwifi: mld: add NAN link management
+      wifi: iwlwifi: add NAN schedule command support
+      wifi: iwlwifi: mld: implement NAN peer station management
+      wifi: iwlwifi: mld: add peer schedule support
+      wifi: iwlwifi: mld: clean up station handling in key APIs
+      wifi: iwlwifi: mld: add TLC support for NAN stations
+      wifi: iwlwifi: mld: track TX/RX IGTKs separately
+      wifi: iwlwifi: mld: don't report bad STA ID in EHT TB sniffer
+      wifi: iwlwifi: api: RX: define UHR RX PHY flags
+      wifi: iwlwifi: fw: api: fix UHR U-SIG whitespace
+      wifi: iwlwifi: fw: api: add/fix some UHR sniffer definitions
+      wifi: iwlwifi: pcie: fix ACPI DSM check
+      wifi: iwlwifi: advertise UHR capabilities for such devices
+      wifi: iwlwifi: print FSEQ sha1 in addition to version
+      wifi: iwlwifi: tighten flags in debugfs command sending
+      wifi: iwlwifi: define new FSEQ TLV with MAC ID
+      wifi: iwlwifi: set state to NO_FW on reset
+      wifi: iwlwifi: mld: support NPCA capability for UHR devices
+      wifi: iwlwifi: mld: implement UHR DPS
+      wifi: iwlwifi: mld: give link STA debugfs files a namespace
+      wifi: iwlwifi: mld: set correct key mask for NAN
+      wifi: iwlwifi: mld: add UHR DUO support
+      wifi: iwlwifi: mld: implement UHR multi-link PM
+      wifi: iwlwifi: mld: rename LINK_DEBUGFS_WRITE_FILE_OPS
+      wifi: iwlwifi: mld: add link and link station FW IDs to debugfs
+      wifi: iwlwifi: api: remove NAN_GROUP
+      wifi: iwlwifi: api: clean up/fix some kernel-doc references
+      wifi: iwlwifi: pcie: add two LNL PCI IDs
+      wifi: iwlwifi: clean up location format/BW encoding
+      wifi: iwlwifi: fw: move struct iwl_fw_ini_dump_entry to dbg.c
+      wifi: iwlwifi: fw: separate ini dump allocation
+      wifi: iwlwifi: fw: dbg: always use non-tracing PRPH access
+      wifi: iwlwifi: fw: separate out old-style dump code
+      wifi: iwlwifi: dbg: remove unused 'range_len' arg from dump
+      wifi: iwlwifi: transport: add memory read under NIC access
+
+Junjie Cao (2):
+      wifi: iwlwifi: mld: fix race condition in PTP removal
+      wifi: iwlwifi: mvm: fix race condition in PTP removal
+
+Junrui Luo (1):
+      wifi: iwlwifi: mld: validate sta_mask before ffs() in BA session handlers
+
+Miri Korenblit (19):
+      wifi: iwlwifi: mld: set NAN phy capabilities
+      wifi: iwlwifi: mld: use host rate for NAN management frames
+      wifi: iwlwifi: mld: extract NAN capabilities setting to a function
+      wifi: iwlwifi: mld: don't allow softAP with NAN
+      wifi: iwlwifi: bump core version for BZ/SC/DR to 103
+      wifi: iwlwifi: mld: allow NAN data
+      wifi: iwlwifi: support a TLV indicating num of mgmt mcast keys
+      wifi: iwlwifi: mark that we support iwl_rx_mpdu_desc version 7 and 8
+      wifi: iwlwifi: stop supporting cores 97 to 100
+      wifi: iwlwifi: mld: stop supporting iwl_compressed_ba_notif version 5 and 6
+      wifi: iwlwifi: mld: stop supporting MAC_PM_POWER_TABLE version 1
+      wifi: iwlwifi: mld: stop supporting TLC_MNG_UPDATE_NTFY_API_S_VER_3
+      wifi: iwlwifi: mld: stop supporting rate_n_flags version 2
+      wifi: iwlwifi: bump core version for BZ/SC/DR to 104
+      wifi: iwlwifi: define MODULE_FIRMWARE with the correct API
+      wifi: iwlwifi: mld: evacuate NAN channels on link switch
+      wifi: iwlwifi: mld: don't flush async_handlers_wk when canceling notifications
+      wifi: iwlwifi: mld: purge async notifications upon nic error
+      wifi: iwlwifi: bump maximum core version for BZ/SC/DR to 105
+
+Pagadala Yesu Anjaneyulu (3):
+      wifi: iwlwifi: add RF name handling for PE chip type for debugfs
+      wifi: iwlwifi: add XIAOMI to PPAG approved list
+      wifi: iwlwifi: mld: disallow puncturing in US/CA for WH
+
+Shahar Tzarfati (2):
+      wifi: iwlwifi: mld: expose beacon avg signal
+      wifi: iwlwifi: Add names for Killer BE1735x and BE1730x
+
+ drivers/net/wireless/intel/iwlwifi/Makefile        |    2 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |   23 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/7000.c      |    5 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/8000.c      |    5 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/9000.c      |    5 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |   38 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   19 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |   19 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |    8 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c     |   17 -
+ drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c     |   30 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c     |   22 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c     |    8 +-
+ drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   22 +-
+ .../net/wireless/intel/iwlwifi/fw/api/commands.h   |   13 +-
+ .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    9 +-
+ .../net/wireless/intel/iwlwifi/fw/api/location.h   |  107 +-
+ .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  184 ++-
+ drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   48 +-
+ drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   40 +-
+ drivers/net/wireless/intel/iwlwifi/fw/api/sta.h    |    3 +-
+ drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |   88 +-
+ drivers/net/wireless/intel/iwlwifi/fw/dbg-old.c    | 1022 ++++++++++++++++
+ drivers/net/wireless/intel/iwlwifi/fw/dbg.c        | 1292 +++-----------------
+ drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    7 +-
+ drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   15 +-
+ drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   14 +-
+ drivers/net/wireless/intel/iwlwifi/fw/file.h       |   10 +-
+ drivers/net/wireless/intel/iwlwifi/fw/img.h        |    3 +-
+ drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |    7 +-
+ drivers/net/wireless/intel/iwlwifi/fw/rs.c         |    5 +-
+ drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    9 +-
+ drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    3 +-
+ drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   14 +-
+ drivers/net/wireless/intel/iwlwifi/iwl-io.c        |   25 +-
+ drivers/net/wireless/intel/iwlwifi/iwl-io.h        |    6 +-
+ drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  150 ++-
+ drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |    2 +
+ drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.h |    9 +-
+ drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    7 +-
+ drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   17 +-
+ drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  123 +-
+ drivers/net/wireless/intel/iwlwifi/mld/agg.c       |    9 +
+ drivers/net/wireless/intel/iwlwifi/mld/ap.c        |   58 +-
+ drivers/net/wireless/intel/iwlwifi/mld/ap.h        |    8 +-
+ drivers/net/wireless/intel/iwlwifi/mld/d3.c        |  168 ++-
+ drivers/net/wireless/intel/iwlwifi/mld/d3.h        |    6 +-
+ drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |   74 +-
+ .../net/wireless/intel/iwlwifi/mld/ftm-initiator.c |   30 +-
+ drivers/net/wireless/intel/iwlwifi/mld/iface.c     |  187 ++-
+ drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   62 +-
+ drivers/net/wireless/intel/iwlwifi/mld/key.c       |  166 ++-
+ drivers/net/wireless/intel/iwlwifi/mld/link.c      |  569 ++++++++-
+ drivers/net/wireless/intel/iwlwifi/mld/link.h      |   37 +-
+ drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  358 ++++--
+ drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |   13 +-
+ drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   20 +-
+ drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   16 +-
+ drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |   36 +-
+ drivers/net/wireless/intel/iwlwifi/mld/nan.c       |  748 +++++++++++-
+ drivers/net/wireless/intel/iwlwifi/mld/nan.h       |   41 +-
+ drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   35 +-
+ drivers/net/wireless/intel/iwlwifi/mld/phy.c       |   24 +-
+ drivers/net/wireless/intel/iwlwifi/mld/power.c     |  210 +++-
+ drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |    2 +-
+ drivers/net/wireless/intel/iwlwifi/mld/rx.c        |   44 +-
+ drivers/net/wireless/intel/iwlwifi/mld/rx.h        |    7 +-
+ drivers/net/wireless/intel/iwlwifi/mld/sta.c       |  245 +++-
+ drivers/net/wireless/intel/iwlwifi/mld/sta.h       |   32 +-
+ drivers/net/wireless/intel/iwlwifi/mld/stats.c     |  108 +-
+ .../net/wireless/intel/iwlwifi/mld/tests/Makefile  |    1 +
+ .../intel/iwlwifi/mld/tests/chan_load_thresh.c     |  139 +++
+ .../intel/iwlwifi/mld/tests/link-selection.c       |    6 +-
+ .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |    8 +-
+ drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |  410 ++++---
+ drivers/net/wireless/intel/iwlwifi/mld/tx.c        |   51 +-
+ .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   30 +-
+ .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   32 +-
+ drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    4 +-
+ drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    4 +-
+ drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   14 +-
+ drivers/net/wireless/intel/iwlwifi/mvm/ptp.c       |    2 +-
+ drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |    9 +-
+ drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   14 +-
+ .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h  |  107 +-
+ .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |    9 +-
+ .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |   93 +-
+ 87 files changed, 5442 insertions(+), 2259 deletions(-)
+ create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dbg-old.c
+ create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/chan_load_thresh.c
-- 
2.34.1


