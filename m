Return-Path: <linux-wireless+bounces-16854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A789F9FDC36
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767C51881244
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228EF19938D;
	Sat, 28 Dec 2024 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rl5DoPTo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA01990CF
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418094; cv=none; b=Pv6w7LSHo7e6yxp25omJo46EJS1VF8/eXeSHAu8PVpB4UuuqCbJO3ks96o94GfSY799vPVdtu0N5IGj9mS/3E9CDxrtj1vUuZcaknjZ2bKpiJFAttqD0lNkUpYhdh8Ld18WtiZwrP+MVOmHPI8FO02z8iq+ssEf4xRzOOB9rQb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418094; c=relaxed/simple;
	bh=YhHHDSAOgED8HlcKQ5h79Kl0h8DGO2y2HHmuqlIfoqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HoHoy3Y69IcPcJmh7XYux6DUY4drfkWLZoENtaA+XXB3uDcM/esmqbRaqSvr6GSCEvuwk4VdOMsyR3eLBSAOSwVPC8K1jCSTjB8S/NoqVcIjF/NiP4MeQZeh4wh91pqXB8L7X7fcgcXx7tDPjRUhSXkAt7Jj6ijf3OyfTEIxNXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rl5DoPTo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418092; x=1766954092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YhHHDSAOgED8HlcKQ5h79Kl0h8DGO2y2HHmuqlIfoqQ=;
  b=Rl5DoPToRUr9pCsQMtxcudNc68ssj07wJS8v50Fjq4k2UHRlCpsQzRC2
   MlSVpP1pWBI5ThWPPCUsExrMY9vyCGBUJ5tLoHumo3meHC9bNijEg4mSl
   7Jx2qP65dD2KAf4idUXYkf0wYFVAGuCgJpO8Dj9YyLClfVXeKxki2VWf6
   F/zWYBTEhUYLa9EzkyXtKPqUQgzv4TsFaeotQCDmrIBprGibYRY736Nua
   ypHhG+CCYIqcJu7x1xOyf6Im8KVEvQYeJx5p8DOkxahLQLzRDEZFas1bM
   VbdIbMG5qe6CMveoDcOXAyOcD0uvOrYmOtgZ351wPhYIyghcz5JrusIA1
   w==;
X-CSE-ConnectionGUID: 9zdHyQABSlWDGZOhwcMEaA==
X-CSE-MsgGUID: +uBCLj82SxabXeEsq8kOTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479776"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479776"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:52 -0800
X-CSE-ConnectionGUID: lQfhElYwTBKkaXjUCpvsHw==
X-CSE-MsgGUID: krP821b3Tpycgx0bHVy5rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488421"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:51 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: api: remove version number from latest stored_beacon_notif
Date: Sat, 28 Dec 2024 22:34:16 +0200
Message-Id: <20241228223206.e2140aa3c65b.Ie851bdda6df02dcc352bf765a3ec6bdac45c65a2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
References: <20241228203419.2443350-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

By convention the newest version of a command/notification structure is
named with out the _ver_# suffix. Apply to stored_beacon_notif.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/offload.h | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c   | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index 6a7bbfd6b2b7..9b09b835560b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -31,7 +31,7 @@ enum iwl_prot_offload_subcmd_ids {
 
 	/**
 	 * @STORED_BEACON_NTF: &struct iwl_stored_beacon_notif_v2 or
-	 *	&struct iwl_stored_beacon_notif_v3
+	 *	&struct iwl_stored_beacon_notif
 	 */
 	STORED_BEACON_NTF = 0xFF,
 };
@@ -71,18 +71,18 @@ struct iwl_stored_beacon_notif_v2 {
 } __packed; /* WOWLAN_STROED_BEACON_INFO_S_VER_2 */
 
 /**
- * struct iwl_stored_beacon_notif_v3 - Stored beacon notification
+ * struct iwl_stored_beacon_notif - Stored beacon notification
  *
  * @common: fields common for all versions
  * @sta_id: station for which the beacon was received
  * @reserved: reserved for alignment
  * @data: beacon data, length in @byte_count
  */
-struct iwl_stored_beacon_notif_v3 {
+struct iwl_stored_beacon_notif {
 	struct iwl_stored_beacon_notif_common common;
 	u8 sta_id;
 	u8 reserved[3];
 	u8 data[MAX_STORED_BEACON_SIZE];
-} __packed; /* WOWLAN_STROED_BEACON_INFO_S_VER_3 */
+} __packed; /* WOWLAN_STROED_BEACON_INFO_S_VER_3, _VER_4 */
 
 #endif /* __iwl_fw_api_offload_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index bbf0f2753f9f..daa3bfaccaba 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1751,7 +1751,7 @@ void iwl_mvm_rx_stored_beacon_notif(struct iwl_mvm *mvm,
 
 		data = sb_v2->data;
 	} else {
-		struct iwl_stored_beacon_notif_v3 *sb_v3 = (void *)pkt->data;
+		struct iwl_stored_beacon_notif *sb_v3 = (void *)pkt->data;
 
 		if (pkt_len < struct_size(sb_v3, data, size))
 			return;
-- 
2.34.1


