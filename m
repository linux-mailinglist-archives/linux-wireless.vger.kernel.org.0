Return-Path: <linux-wireless+bounces-20065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71877A57F33
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E723ABAC6
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D280E1DF73C;
	Sat,  8 Mar 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYxwF+dW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B165212B0D
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471306; cv=none; b=jrrTLMolWmDuLLdOuAkYFc5Jga5WUA6zU3i6nxfbt6f0OD0GDF3Rj7yzwCSLWQWGYvEqWo3qKvJT3rF/nhw2RcxcsLkjT1P1in8YiVPzfKn4e/LJNQynltBsqTXQtnnXIPxAul8IJeKaCfhSfCtltMMZGjUw7zj3eS1O/RbkoEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471306; c=relaxed/simple;
	bh=REAIoendfzQyX6wyUdJhIUsemDKdtguPeCQcl/KPyos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+/5QPXTa1eoB68I7ZMDkTRmcJWBksvFsd8mHb0s8pcSCtUfpJWpqahHEcC/eThDKSnaC7x5Og2J9N57IzhOram3iYVnG9IftyZN7zCHQT0nW5EQwGB4v6m1+YPPb+pw/IxfUwNGHFzC1mA0cslaRcuRHHi/1liC9HiobFVC3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYxwF+dW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471305; x=1773007305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=REAIoendfzQyX6wyUdJhIUsemDKdtguPeCQcl/KPyos=;
  b=fYxwF+dWDVsTQEN0cgkyWvy1CCsX2YNpb6xiIXEPneDPIH54wIGOxfLO
   x4czOhN+vrMBlUC5XCGxF467XXLP/crIAPbZ/IMPOuRuzZlzP2li17GkQ
   LFjcMMZ84fay2CDEuZgtveJoliNMKgcNo07tF21FayLnLmp1d/55bqj+m
   dlUTmrPTZ/C/u3BnV1tXuwo5J3pyw0brTrp0nCXSClb4Bx2710FDqeZe6
   JehvG1SrPn2aqU9dTKWos7JFkNyJdX+hC5gjG44NvBTGC2OPOgLG+yHPS
   hr5KsSCFVmA1PrxId+mfxkZytNTF36NOpjfJuDUG1hSI1oyTbrtrgJttk
   Q==;
X-CSE-ConnectionGUID: ACrxKj7iR2+jtBvHszR7fQ==
X-CSE-MsgGUID: vzHv/kxPR42YBFnog7mjgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540623"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540623"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:45 -0800
X-CSE-ConnectionGUID: WaCC2hqPTvGoVtBCwncvkQ==
X-CSE-MsgGUID: yyXHjJ/zRXyNRA65wbgHRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352105"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:43 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 05/15] wifi: iwlwifi: mld: assume wiphy is locked when getting BSS ifaces
Date: Sun,  9 Mar 2025 00:01:15 +0200
Message-Id: <20250308235203.6ce298d6a44f.Ibc862dfdd6cb2da63781c791b9dc601bd5ce4bdc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The code was calling ieee80211_iterate_interfaces, however that
takes a lock of iflist_mtx, which must not be taken recursively. Fix
this by using the appropriate _mtx version that asserts that the wiphy
mutex is already held.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 691062b44461..e49e2260ac05 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -465,10 +465,10 @@ u8 iwl_mld_get_fw_bss_vifs_ids(struct iwl_mld *mld)
 {
 	u8 fw_id_bitmap = 0;
 
-	ieee80211_iterate_interfaces(mld->hw,
-				     IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER,
-				     iwl_mld_get_fw_id_bss_bitmap_iter,
-				     &fw_id_bitmap);
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER,
+						iwl_mld_get_fw_id_bss_bitmap_iter,
+						&fw_id_bitmap);
 
 	return fw_id_bitmap;
 }
-- 
2.34.1


