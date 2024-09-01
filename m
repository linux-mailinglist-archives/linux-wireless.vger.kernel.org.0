Return-Path: <linux-wireless+bounces-12295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447B29674F2
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 06:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB064B218A3
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 04:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9623E2943F;
	Sun,  1 Sep 2024 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbVUIuLg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12563CF63
	for <linux-wireless@vger.kernel.org>; Sun,  1 Sep 2024 04:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164296; cv=none; b=JnstCjgWWTyVYvDBQhj8Bm2DUC9rGxPyP0aWvGRG0PleAMnxE84jmtsHm8XhKw0LTJ0KgH73HVBYVNliTAH5xiAHVhcIsn879gG5tUggg4YAUa9WjbmwNoEvlmGCOkA+9h5Mmui7D2mBRD9h9b7mG8j1v62HYEfMNy0kzn5OTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164296; c=relaxed/simple;
	bh=Kd3DtaP+km1WVMUZdSpxvn/BZMFJSib9INfiF0jqbgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGLl0lr3/0EALjNlMe5ZZgqr8uaO81uCPyfE0LVBLjaR5B03VLUBm7IGOfKUIMh+HOEJCBuQGl0GCNm4NhPEmB/Dx22aagjVhxLBfhyRzjtSp8xp/mRKbk5Zacws4R82TLhXLwWpvc4NuaLy+DRnEzq5gpzgEVXHYtPKs4V7fLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbVUIuLg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725164295; x=1756700295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kd3DtaP+km1WVMUZdSpxvn/BZMFJSib9INfiF0jqbgI=;
  b=DbVUIuLgV8yBbl5/NKP24XTj36Nmttp/eJV+wpABQXqZn2gBPbylJskJ
   XxLRNdlcAvM+io4nCgRmwQzdqADuMTIS/rEzNOQXNsyEX1RsJiratcfXe
   2WagVtSMXX5Bi3h9BlcDl1S6UKqVfEdqwH3GrRJR4BYDfChMQVt21vfX3
   k1B7B9/mqSkKpQgtEh/kTMeNgNg9VTWDUbypzrBA8SINYsrTU2vcn+ky6
   DVnVnU71CgzrszZsychncsQZxLDu49+ppk/RDnZcyHuepsoEmVZdpLWds
   lo0oCWCLybz72aAMVcJQ1j5XB07WsvAG0R913BAam2L/DWdtg2qc42P19
   g==;
X-CSE-ConnectionGUID: e4JwwWmQSE2UOP9tLZLLcQ==
X-CSE-MsgGUID: 1j7gViRRT32HLXUnSe07vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="27559524"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="27559524"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:14 -0700
X-CSE-ConnectionGUID: c1M4iJEpQuiOOX8Z6UnHrw==
X-CSE-MsgGUID: 0hwYq3wcT3yF8aY9rUU2yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64276316"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 5/8] wifi: iwlwifi: s/iwl_mvm_remove_sta_cmd/iwl_remove_sta_cmd
Date: Sun,  1 Sep 2024 07:17:54 +0300
Message-Id: <20240901071542.57efe93c2702.I4619885f691cc295cc440a62f23405392da338f4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
References: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is not mvm specific.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h | 6 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 6dd9401596e9..c46e24fc6a1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -50,7 +50,7 @@ enum iwl_mac_conf_subcmd_ids {
 	 */
 	AUX_STA_CMD = 0xB,
 	/**
-	 * @STA_REMOVE_CMD: &struct iwl_mvm_remove_sta_cmd
+	 * @STA_REMOVE_CMD: &struct iwl_remove_sta_cmd
 	 */
 	STA_REMOVE_CMD = 0xC,
 	/**
@@ -636,13 +636,13 @@ struct iwl_mvm_aux_sta_cmd {
 } __packed; /* AUX_STA_CMD_API_S_VER_1 */
 
 /**
- * struct iwl_mvm_remove_sta_cmd - a cmd structure to remove a sta added by
+ * struct iwl_remove_sta_cmd - a cmd structure to remove a sta added by
  *	STA_CONFIG_CMD or AUX_STA_CONFIG_CMD
  * ( STA_REMOVE_CMD = 0xC )
  *
  * @sta_id: index of station to remove
  */
-struct iwl_mvm_remove_sta_cmd {
+struct iwl_remove_sta_cmd {
 	__le32 sta_id;
 } __packed; /* REMOVE_STA_API_S_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 759b77d555b7..28a9d90ad1cd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -94,7 +94,7 @@ static int iwl_mvm_mld_add_int_sta_to_fw(struct iwl_mvm *mvm,
  */
 static int iwl_mvm_mld_rm_sta_from_fw(struct iwl_mvm *mvm, u32 sta_id)
 {
-	struct iwl_mvm_remove_sta_cmd rm_sta_cmd = {
+	struct iwl_remove_sta_cmd rm_sta_cmd = {
 		.sta_id = cpu_to_le32(sta_id),
 	};
 	int ret;
-- 
2.34.1


