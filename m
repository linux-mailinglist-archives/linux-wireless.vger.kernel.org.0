Return-Path: <linux-wireless+bounces-21756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B1DA946DD
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 09:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88EB1752FB
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Apr 2025 07:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A41C7006;
	Sun, 20 Apr 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZFoFX6o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3A1C6FE1
	for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745132422; cv=none; b=rW3FlQLfMZDSEdc1RI71wc5HjVxnKme6cTr6UTQUVuR4Ck1d3JPfuEXjaayECQ69DPf+KR9rGJj7+0+shNTF8uGJ9uFgSNJYTqJ3wZKbJCC2DWyNAMbRzmZpXQ/5Gt3fluLKFjx+h2pcS3ChYp62ZeMV/qhpA3ZxXUhgJm/l20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745132422; c=relaxed/simple;
	bh=IGpJ/AwL8haasIessbohiPXKLfvo/QBSwwHjK8R2Y6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=up4nnSVoL+shzO8qlIWtWpjF1Av5GJfFXGbRw4bOuHfv0/E9n9dgFWLbXaDLwNqaxvrQDZnJOxVWvUEJdWF18yACJmBbonv/FPHUav1FqzZEcc8XZOUaVH+OjG4AauUC9cPnWifyncNxS1OVmtCXG5K6yKn/nqZYLGIigxqJCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZFoFX6o; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745132421; x=1776668421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IGpJ/AwL8haasIessbohiPXKLfvo/QBSwwHjK8R2Y6A=;
  b=SZFoFX6oyTVwG/ooeWBJHsfkObPvJz+6IljzxLZuRVOZ9Sjyu4FH432b
   OKHC4f8u8GwufYr9j6r22+ZJWp7UOUvoxY4MYw6HkRR5SHDE4eyCma7LT
   UPXT3Dr+uOVB6QCB69IE01whBWZfzkbz/to1y3Gfrr50LQ/nL9qyOi3Bz
   zM5s7Sg3Wpk7fzY+tPDIpnRzCwFNk9cfm3LwDdwfmlDt7tVxhyPYpiFa0
   8HK/IcGqKR7JI4Pa923Viyqt2vwJDyeCJk8gFkycxABaynPCGmQhwb729
   Ju8H9kUV+2qRwwOqSFAeLFJitbufvUSMpIrXnmeUhxsZAj0avVEHOw14o
   Q==;
X-CSE-ConnectionGUID: BvwWlRm0RFu74S7vRrbr4g==
X-CSE-MsgGUID: nKuZd6PGQ1yEpnIp2oxjfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46827889"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46827889"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:19 -0700
X-CSE-ConnectionGUID: grrgxCgOR0O5aOhuqqieFQ==
X-CSE-MsgGUID: htxQbEp9Ri+CvBl2Rsi73Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="154615721"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 00:00:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless 3/7] wifi: iwlwifi: mld: only create debugfs symlink if it does not exist
Date: Sun, 20 Apr 2025 09:59:57 +0300
Message-Id: <20250420095642.2490696f032a.I74319c7cf18f7e16a3d331cb96e38504b9fbab66@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
References: <20250420070001.3406977-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When mac80211 switches between non-MLO and MLO it will recreate the
debugfs directories. This results in the add_if_debugfs handler being
called multiple times. As the convenience symlink is created in the mld
debugfs directory and not the vif, it will not be removed by mac80211
when this happens and still exists.

Add a check and only create the convenience symlink if we have not yet
done so.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c  | 5 +++--
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 89d95e9b4f30..93f9f78e4276 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -949,8 +949,9 @@ void iwl_mld_add_vif_debugfs(struct ieee80211_hw *hw,
 	snprintf(name, sizeof(name), "%pd", vif->debugfs_dir);
 	snprintf(target, sizeof(target), "../../../%pd3/iwlmld",
 		 vif->debugfs_dir);
-	mld_vif->dbgfs_slink =
-		debugfs_create_symlink(name, mld->debugfs_dir, target);
+	if (!mld_vif->dbgfs_slink)
+		mld_vif->dbgfs_slink =
+			debugfs_create_symlink(name, mld->debugfs_dir, target);
 
 	if (iwlmld_mod_params.power_scheme != IWL_POWER_SCHEME_CAM &&
 	    vif->type == NL80211_IFTYPE_STATION) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 99e13cfd1e5f..68d97d3b8f02 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -651,6 +651,7 @@ void iwl_mld_mac80211_remove_interface(struct ieee80211_hw *hw,
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove(iwl_mld_vif_from_mac80211(vif)->dbgfs_slink);
+	iwl_mld_vif_from_mac80211(vif)->dbgfs_slink = NULL;
 #endif
 
 	iwl_mld_rm_vif(mld, vif);
-- 
2.34.1


