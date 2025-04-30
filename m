Return-Path: <linux-wireless+bounces-22269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDBAAA4C6D
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5841C22000
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F4F25B1C9;
	Wed, 30 Apr 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsV9eLpr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9E2609DE
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017876; cv=none; b=E2nBbZYzJP7UNc5S5POZGMma7LVQi6SomDvYRJnAYH99FOJCieAvGqHPOQQ7EVEtKJB9NqU47aA6/wQAxmuHWCXspMR+LHQbWwrAol+VQQduAG/3H/X6lJHicxWA3c9vwHKSLa6nuNl3Q4GTh6nA9nRbRd07qeRWB1MlgYA0bys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017876; c=relaxed/simple;
	bh=Q5BENWI18D3j6yWTFewTdFLZgzKVlm0kM8iapeIMLNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0swXEIGpemDI7K8Yhdgnp8AbbbRzahSvZgOvwA3cnThEALgtYoFPlzPF2N+LomJTgqgCSEtt1Hj3nXypwB+Gwyrv3/ITl/jFuxJj29XsnUcutW78r2zv/p2P83XDmh75h9416Cc5ZNADiRxttBXt3DEcKMbM3xxuQ6CTzBNFYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsV9eLpr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017875; x=1777553875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q5BENWI18D3j6yWTFewTdFLZgzKVlm0kM8iapeIMLNg=;
  b=YsV9eLprDs8bi8mb9Q12TIczF0eYdu45RwkHy88HPxup+7SLb1CdGlnI
   F/4qzNBff5VJvexnnhRcQsR3S4HSHGaRMYagJcVLYxLqCYXLGs255jzUI
   j9UoeOPEgiQR+rPcMMSvQ8fGebrHQERko2XF0RvktlszAlCj9ntr9YDtO
   qyVbZbKI4Sz6/aTwbQjFSMggjfoVr7QRZZO03jjP9Zo5FFDdecztugSMk
   uLP0oayy2VWdCBy6XYvac4MzlYEwxk55nUxAHxewVnhlLOUQ7k+U15LlR
   3UxgKJQ1ePGymamBsydXTqHLGHrElbiQ7kw9lwzuoaXlFdWNxUkHUraD8
   Q==;
X-CSE-ConnectionGUID: LxVFDaJdSUmWGvswWJ/b/A==
X-CSE-MsgGUID: xrIq1fv+QLm/l3M2VBhzCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332342"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332342"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:54 -0700
X-CSE-ConnectionGUID: HN4aDE/5SVG5AFIgy9yujw==
X-CSE-MsgGUID: KQRk34cwStSUaOKWOO4/uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632110"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: support for COMPRESSED_BA_RES_API_S_VER_7
Date: Wed, 30 Apr 2025 15:57:22 +0300
Message-Id: <20250430155443.c4be90e242ff.Ie8a0f0d6320613bd8c5cb6c82a063069fffa3b67@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The rate format changed but since we don't use the rate, just claim
support for this new API.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 8 +++++---
 drivers/net/wireless/intel/iwlwifi/mld/notif.c | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 0a39e4b6eb62..50d1c590044f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_tx_h__
@@ -701,7 +701,8 @@ enum iwl_mvm_ba_resp_flags {
  * @rts_retry_cnt: RTS retry count
  * @reserved: reserved (for alignment)
  * @wireless_time: Wireless-media time
- * @tx_rate: the rate the aggregation was sent at
+ * @tx_rate: the rate the aggregation was sent at. Format depends on command
+ *	version.
  * @tfd_cnt: number of TFD-Q elements
  * @ra_tid_cnt: number of RATID-Q elements
  * @tfd: array of TFD queue status updates. See &iwl_compressed_ba_tfd
@@ -730,7 +731,8 @@ struct iwl_compressed_ba_notif {
 		DECLARE_FLEX_ARRAY(struct iwl_compressed_ba_tfd, tfd);
 	};
 } __packed; /* COMPRESSED_BA_RES_API_S_VER_4,
-	       COMPRESSED_BA_RES_API_S_VER_5 */
+	       COMPRESSED_BA_RES_API_S_VER_6,
+	       COMPRESSED_BA_RES_API_S_VER_7 */
 
 /**
  * struct iwl_mac_beacon_cmd_v6 - beacon template command
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 10f1bee89205..76b1a21135a8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -307,7 +307,8 @@ CMD_VERSIONS(tx_resp_notif,
 	     CMD_VER_ENTRY(8, iwl_tx_resp))
 CMD_VERSIONS(compressed_ba_notif,
 	     CMD_VER_ENTRY(5, iwl_compressed_ba_notif)
-	     CMD_VER_ENTRY(6, iwl_compressed_ba_notif))
+	     CMD_VER_ENTRY(6, iwl_compressed_ba_notif)
+	     CMD_VER_ENTRY(7, iwl_compressed_ba_notif))
 CMD_VERSIONS(tlc_notif,
 	     CMD_VER_ENTRY(3, iwl_tlc_update_notif))
 CMD_VERSIONS(mu_mimo_grp_notif,
-- 
2.34.1


