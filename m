Return-Path: <linux-wireless+bounces-28777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC30C46BF9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C68D4E6C70
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326B91A704B;
	Mon, 10 Nov 2025 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaWuaz1+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4D30EF7D
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779769; cv=none; b=i427CSIHB87PI8h0NcGAXcjZrds5q+RlyzwzvyplChdgoxVkMiN0rmRXjomUngKkGsmMlgT0f7B5CesfXN7WH4S8Kjol09UWux7ASMnPSJbaRJGuEz09H0twJ88/f4CGD5cbw78+ItF5IXa1/jR/by5Ltrg8LDUqMWYDMQVWhWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779769; c=relaxed/simple;
	bh=swk1MVHmnZ2oWqG5/DRGwaGJq3g/TRGQLfI7J3WhOfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GfGRMD0KJb+gIZGyLk/NIlLw4sZlMQLmqJTTsW7WB3YmHQx7BYSnEeIweEYKayoYbjRamG5XCC2hR5pUnEW3IDr/l+JeywfnjKKoK2wlqNr/AX+fXzTEKFEcxwZYlv0Am2ZRCSeYknx9znzElaeuajlgMTvaaZuhTPIiHE+xVxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaWuaz1+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779768; x=1794315768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=swk1MVHmnZ2oWqG5/DRGwaGJq3g/TRGQLfI7J3WhOfw=;
  b=UaWuaz1+G9eQCN1iJtCmG6KuheB5jr7NKcT7ATNp3pumIhNEyNpCBymf
   CkvayyVYTiru4HwdckRhHYlP3XBHZ5/4rnTnoskltFFWRTRfBgohGW2LZ
   Fvdke7c7IIfZd7FIp7SKJL3rnDolkfyrEJPLQzE2NxTLpQpfuFFP2f5tY
   reeAS6cjSp4KrwDtPFF8TZSZ/OIIWO1HSKxEWM0V9kacDhup9m2QIVVQM
   s2KcBfwZw+erwtvOoA8+zrUs9+Ca5Ab32j/hmxQHi8TTjxuvqh8j1Gscp
   bpMB0lNDbQGZY6fXlpG+EriJO1UTkZPHicpvAlHBBdtDPcP9Ae4i1lG+8
   A==;
X-CSE-ConnectionGUID: W14kL6SMSRusqeu/5ti18g==
X-CSE-MsgGUID: rieY7U/KQSmOJk2b6Z25tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454890"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454890"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:47 -0800
X-CSE-ConnectionGUID: PTpR31V/RUe9a+aloeWC6Q==
X-CSE-MsgGUID: f6oh8L2RRYi7K9xvx8hObw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928550"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:45 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: adjust LINK context NPCA API
Date: Mon, 10 Nov 2025 15:02:21 +0200
Message-Id: <20251110150012.93bd7a454eef.I3d2ce1a363b0d8c3809ec8e729b7acf94efca25b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The link context NPCA API was changed in the firmware, adjust
the driver accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 628f39917a6f..f260115abc5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -503,23 +503,37 @@ enum iwl_link_modify_bandwidth {
 	IWL_LINK_MODIFY_BW_320,
 };
 
+/**
+ * enum iwl_npca_flags - NPCA flags
+ * @IWL_NPCA_FLAG_MAC_HDR_BASED: MAC header based NPCA operation
+ *	permitted in the BSS (MOPLEN)
+ */
+enum iwl_npca_flags {
+	IWL_NPCA_FLAG_MAC_HDR_BASED = BIT(0),
+}; /* NPCA_FLAG_E */
+
 /**
  * struct iwl_npca_params - NPCA parameters (non-primary channel access)
  *
+ * @dis_subch_bmap: disabled subchannel bitmap for NPCA
  * @switch_delay: after switch, delay TX according to destination AP
  * @switch_back_delay: switch back to control channel before OBSS frame end
+ * @initial_qsrc: Indicates the value that is used to initialize the
+ *	EDCAF QSRC[AC] variables
  * @min_dur_threshold: minimum PPDU time to switch to the non-primary
- *	NPCA channel
- * @flags: NPCA flags - bit 0: puncturing allowed, bit 1: new TX allowed
+ *	NPCA channel (usec)
+ * @flags: NPCA flags, see &enum iwl_npca_flags
  * @reserved: reserved for alignment purposes
  */
 struct iwl_npca_params {
+	__le16 dis_subch_bmap;
 	u8 switch_delay;
 	u8 switch_back_delay;
-	__le16 min_dur_threshold;
-	__le16 flags;
-	__le16 reserved;
-} __packed; /* NPCA_PARAM_API_S_VER_1 */
+	u8 initial_qsrc;
+	u8 min_dur_threshold;
+	u8 flags;
+	u8 reserved;
+} __packed; /* NPCA_PARAM_API_S_VER_2 */
 
 /**
  * struct iwl_link_config_cmd - command structure to configure the LINK context
@@ -630,7 +644,8 @@ struct iwl_link_config_cmd {
 	struct iwl_npca_params npca_params; /* since _VER_7 */
 	struct iwl_ac_qos prio_edca_params; /* since _VER_7 */
 	__le32 reserved3[4];
-} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3, _VER_4, _VER_5, _VER_6, _VER_7 */
+} __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1, _VER_2, _VER_3, _VER_4,
+	     *				    _VER_5, _VER_6, _VER_7, _VER_8 */
 
 /* Currently FW supports link ids in the range 0-3 and can have
  * at most two active links for each vif.
-- 
2.34.1


