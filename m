Return-Path: <linux-wireless+bounces-16852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF0D9FDC34
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 21:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCA3188142A
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2024 20:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7891991A8;
	Sat, 28 Dec 2024 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNoHOPiF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1241990BB
	for <linux-wireless@vger.kernel.org>; Sat, 28 Dec 2024 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735418093; cv=none; b=s06q5g25Vr5KULeJ2QKRxygCHvbEYzilY5e1bU5YK302vsPSUpJTtM3FLBl81fgUMvawn27AIMT9rG2Kw0G1qFpz917ZwJw23Y/hpvsxSZ0Frqzri+x4yfT6844/XnAUPULth+GgvJqdzHQVrxaydZoG+0bKodO7txcnDDWYftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735418093; c=relaxed/simple;
	bh=WTMZl7hBU7ezzQKNSTeXiwL7dUgcKOYDSKgBfAzgUAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/923k3BP2gDiqa3fgtGAoyiiiifq+WwIIL7y/Ous6DJbYTB20yRau6LROe4h4EVksInJTrqqhHuUOfMD2FWHfFFUUZZSKGE9JALz+ojI8qCDvaSlcJE6/gVKFWCscO9YI16ayMHEhfRqUnpuGLbkQAidAZDeTp/9VT7NZBlceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNoHOPiF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735418092; x=1766954092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WTMZl7hBU7ezzQKNSTeXiwL7dUgcKOYDSKgBfAzgUAw=;
  b=DNoHOPiFbAOvtebdkGgUrvPAAIFhPdd36FF9yqghm3jH5u7gif1rNSdE
   meBGdte5nNmBL2krQFNdZw9VJkOjsjyYOXvgTqyBjFq2JmlNJvcPDXjOa
   C2BnZ4o58tikPRBOdOoJ55w9OiM3HfpasLpbOc5rrLIztqmN8d554shDz
   P3fvgg7sbR/OW3oq5MBHElVyntkjt4MBeTknuWEUkNM4t76AJUfyI43et
   CEW3C/iCbpOG8h8mHgravEIt+dyCT7N4Ko7Qsis+k9yiK5UKXDYI7o9Ag
   bgqUzq1ylD4bpUsObHVSXV92FXegxWcqjvLhxbQ7C86E74+eKSy7ubFwJ
   g==;
X-CSE-ConnectionGUID: 87kzVfApQea89rIrjyeW2g==
X-CSE-MsgGUID: 3rWkPFLITSuXOg2EJ2Aq/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35479772"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35479772"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:49 -0800
X-CSE-ConnectionGUID: KJRJ4XNrQlSFml12aL/t7g==
X-CSE-MsgGUID: AyQfRN4GSfeCpyJl31vOzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104488414"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 12:34:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mark that we support TX_CMD_API_S_VER_10
Date: Sat, 28 Dec 2024 22:34:14 +0200
Message-Id: <20241228223206.83d681dc9cf7.I355270fb20b23978d9402cb70caf52a0108b8cd4@changeid>
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

Usually each struct that represent an API needs to have a comment
specifying all the versions of the API that this struct corresponds to.
iwl_tx_cmd_gen3 was long supporting also version 10. Say that.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 1f23bde5720c..b9807dd4f255 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -298,8 +298,7 @@ struct iwl_tx_cmd_gen3 {
 	__le32 rate_n_flags;
 	u8 reserved[8];
 	struct ieee80211_hdr hdr[];
-} __packed; /* TX_CMD_API_S_VER_8,
-	       TX_CMD_API_S_VER_10 */
+} __packed; /* TX_CMD_API_S_VER_8, TX_CMD_API_S_VER_10 */
 
 /*
  * TX response related data
@@ -601,7 +600,8 @@ struct iwl_tx_resp {
 	__le16 reserved2;
 	struct agg_tx_status status;
 } __packed; /* TX_RSP_API_S_VER_6,
-	       TX_RSP_API_S_VER_7 */
+	       TX_RSP_API_S_VER_7,
+	       TX_RSP_API_S_VER_8 */
 
 /**
  * struct iwl_mvm_ba_notif - notifies about reception of BA
-- 
2.34.1


