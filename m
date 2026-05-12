Return-Path: <linux-wireless+bounces-36300-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPQFH826AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36300-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:29:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD5251A0F4
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3DCE305C8D7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14BE37267B;
	Tue, 12 May 2026 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvokSoQM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23637F73E
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563413; cv=none; b=kngLvozxORf7iU19eW7OatSAsrhAUZVO+upRa0CUmUtrfMbNnZtPKW5nEtyhKlpHHIdhDPIo8bHIlI3kZXrPJqmkAGBvTv59q8MxPgbBJFHwFfpW7mAoQ8oqWbDhARxwyXsQS8HlcS6Fd5ciwHXKVAvyPEcTWurLmWo9GzyuyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563413; c=relaxed/simple;
	bh=GNUQIqDpLu66+5weZr/m26SFG88hRLvpFgnDmRhPQZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ktuLZQskoasN4lds6gV0/6arH1QL6z0z0lZSPLSprF37K7BWklGDxB8FKouw48Sk8ixefP+9pNwjvZgJXzqyqEX5MezTzHt9Pg1RbhG8OtAVzgfcOWT6D1XYKB38IhoxPVhDjFIENt8XVxb2BatBCx2q11naW/DhGYGRVaetrhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvokSoQM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563412; x=1810099412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNUQIqDpLu66+5weZr/m26SFG88hRLvpFgnDmRhPQZ4=;
  b=HvokSoQMdE7yPFuDySKRjwTYE6n5zmpI255SdIXHNBjBURA4vt4BFOBS
   rFSxVnN72DsVbnG1WkaBrQfsBVgCrLdgthznoIwZdPtLD53Kr70D9ZvK0
   WIWmMLRVyeNLxtyZ5F+hVY6UkREDmSH+2DKDywiw8hz/EQDHiFbp1IUl8
   b19Imz6uN5BA8lgxKHS/wd0RA8itnQfjAa0Y7hVuFJ5nulHFtyoBUep4Q
   8/svxnHdU6JFddTZYk/Sis8LLnOxJX7cs9zYlJhXinVGHtQJLkIV25ZUC
   kRjQci+JRP09DxoSQUHOTE2QBeHwpvebVGOlapYbdaHEK5dH7BQE1Xd0Y
   Q==;
X-CSE-ConnectionGUID: 04mkXckaT6ulKHGTdXTMQA==
X-CSE-MsgGUID: ubI1ugBFQhyeURkfOd/46Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495097"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495097"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:31 -0700
X-CSE-ConnectionGUID: dTs3tZgyTI6pXNms2rdUWQ==
X-CSE-MsgGUID: eqfFKDq7TqC/oAsdfsWg+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187569"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: support a TLV indicating num of mgmt mcast keys
Date: Tue, 12 May 2026 08:23:01 +0300
Message-Id: <20260512082114.f171962abd2e.Ic678616c7d574de257e5923d56258043a5261674@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
References: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EBD5251A0F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36300-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

FW has a limitation of how many multicast management keys it supports.
Until today we just assumed this limitation. But now as it is changing,
due to NAN, we need a clear indication from the FW so we know how many
we can install.

Read and store this indication from the FW's TLV.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h | 3 +--
 drivers/net/wireless/intel/iwlwifi/fw/file.h    | 3 ++-
 drivers/net/wireless/intel/iwlwifi/fw/img.h     | 3 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c    | 7 +++++++
 drivers/net/wireless/intel/iwlwifi/mld/key.c    | 2 +-
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
index e6f9abdfa546..3e62a458b131 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2021, 2023, 2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021, 2023, 2025-2026 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -191,7 +191,6 @@ enum iwl_sta_sleep_flag {
 #define STA_KEY_IDX_INVALID (0xff)
 #define STA_KEY_MAX_DATA_KEY_NUM (4)
 #define IWL_MAX_GLOBAL_KEYS (4)
-#define IWL_MAX_NUM_IGTKS 2
 #define STA_KEY_LEN_WEP40 (5)
 #define STA_KEY_LEN_WEP104 (13)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index f7a6f21267e9..68ddd99a9f7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2008-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2008-2014, 2018-2024, 2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -111,6 +111,7 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_FW_NUM_STATIONS		= IWL_UCODE_TLV_CONST_BASE + 0,
 	IWL_UCODE_TLV_FW_NUM_LINKS		= IWL_UCODE_TLV_CONST_BASE + 1,
 	IWL_UCODE_TLV_FW_NUM_BEACONS		= IWL_UCODE_TLV_CONST_BASE + 2,
+	IWL_UCODE_TLV_FW_NUM_MCAST_KEY_ENTRIES	= IWL_UCODE_TLV_CONST_BASE + 3,
 
 	IWL_UCODE_TLV_TYPE_DEBUG_INFO		= IWL_UCODE_TLV_DEBUG_BASE + 0,
 	IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION	= IWL_UCODE_TLV_DEBUG_BASE + 1,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 94113d1db8e1..75b1344f6cbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2024, 2026 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -53,6 +53,7 @@ struct iwl_ucode_capabilities {
 	u32 num_stations;
 	u32 num_links;
 	u32 num_beacons;
+	u32 num_mcast_key_entries;
 	DECLARE_BITMAP(_api, NUM_IWL_UCODE_TLV_API);
 	DECLARE_BITMAP(_capa, NUM_IWL_UCODE_TLV_CAPA);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 83a63be90e46..488524529538 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1331,6 +1331,12 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			capa->num_beacons =
 				le32_to_cpup((const __le32 *)tlv_data);
 			break;
+		case IWL_UCODE_TLV_FW_NUM_MCAST_KEY_ENTRIES:
+			if (tlv_len != sizeof(u32))
+				goto invalid_tlv_len;
+			capa->num_mcast_key_entries =
+				le32_to_cpup((const __le32 *)tlv_data);
+			break;
 		case IWL_UCODE_TLV_UMAC_DEBUG_ADDRS: {
 			const struct iwl_umac_debug_addrs *dbg_ptrs =
 				(const void *)tlv_data;
@@ -1641,6 +1647,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	fw->ucode_capa.n_scan_channels = IWL_DEFAULT_SCAN_CHANNELS;
 	fw->ucode_capa.num_stations = IWL_STATION_COUNT_MAX;
 	fw->ucode_capa.num_beacons = 1;
+	fw->ucode_capa.num_mcast_key_entries = 2;
 	/* dump all fw memory areas by default */
 	fw->dbg.dump_mask = 0xffffffff;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.c b/drivers/net/wireless/intel/iwlwifi/mld/key.c
index 944d5487c110..151e35b851f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.c
@@ -259,7 +259,7 @@ int iwl_mld_add_key(struct iwl_mld *mld,
 
 	igtk_ptr = iwl_mld_get_igtk_ptr(vif, sta, key);
 	if (igtk_ptr) {
-		if (mld->num_igtks == IWL_MAX_NUM_IGTKS)
+		if (mld->num_igtks == mld->fw->ucode_capa.num_mcast_key_entries)
 			return -EOPNOTSUPP;
 
 		if (*igtk_ptr) {
-- 
2.34.1


