Return-Path: <linux-wireless+bounces-5054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45950881913
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9BA8B231FD
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179885C62;
	Wed, 20 Mar 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUCu0E0K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C558624B;
	Wed, 20 Mar 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970034; cv=none; b=tulQqSPYwGTYgaxjMgDiRrXIKEOJuMXBczAZszrAe1CSI9IWvd7dIwG77+v107w7IF4bsrJDi+NKUXqW3SZicFVeODD9qZmOYXGposjsyOVo7uWHnGKWyJRfuV8d0eGrprc61mjVMc++3hV/c09gYa4hf26PaD+CtAqxiOP5jgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970034; c=relaxed/simple;
	bh=CjhnpktcNcIRXLzJgkY11a71CMccKoOJwTXiIvUtcXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bjJewWCbTsxv6p4Err/cJgNBnVNoTVbkpQWDKAubSqliGR5yx66r5RlDcOzunIJdVVGqgDzhSjMtqYAa7UljU3HuACH3XW01ro068lSAXG40qHjPduODWdvsFkHYPEDntq8S5Xucne99ZTGzvOS2GOepkCuS4Wg0mwDm/XNfQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUCu0E0K; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970033; x=1742506033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CjhnpktcNcIRXLzJgkY11a71CMccKoOJwTXiIvUtcXw=;
  b=IUCu0E0KcuYmVK/7nChaFttJoUpUvf5lOL4XrXe6YjUbjn/Hv67YYmDs
   skBzlCEOaag/exkYSbvTPTm2osXii5eBsMSChw7GMD9ZeN6ejRTmr7gov
   mmpUWQn3ZaFF2E4WIK21QW3El3WQFB/Nm9w1swHQ8bg9JIa94STB/FJDS
   M+mABwpgVniSSYkl+jctJpGwINUn4g1uvtbk/GGP3DCcBtsSBq4jFsRW+
   v2KFHsnn0hQqoYbgkIfNfEhvpZxdD33j6zpoS/vLy6X+vk8lzh+n63KW3
   0QX/oJNAEgCE3+oyiZHZTNyHU0RtHKZDeT9H9kwnfRV1EPVV7hgWr2nfo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698111"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698111"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184179"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 11/17] wifi: iwlwifi: mvm: handle debugfs names more carefully
Date: Wed, 20 Mar 2024 23:26:32 +0200
Message-Id: <20240320232419.4dc1eb3dd015.I32f308b0356ef5bcf8d188dd98ce9b210e3ab9fd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With debugfs=off, we can get here with the dbgfs_dir being
an ERR_PTR(). Instead of checking for all this, which is
often flagged as a mistake, simply handle the names here
more carefully by printing them, then we don't need extra
checks.

Also, while checking, I noticed theoretically 'buf' is too
small, so fix that size as well.

Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218422
Fixes: c36235acb34f ("wifi: iwlwifi: mvm: rework debugfs handling")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 5485e8bf613e..af56a55063a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -806,7 +806,9 @@ void iwl_mvm_vif_dbgfs_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct dentry *dbgfs_dir = vif->debugfs_dir;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	char buf[100];
+	char buf[3 * 3 + 11 + (NL80211_WIPHY_NAME_MAXLEN + 1) +
+		 (7 + IFNAMSIZ + 1) + 6 + 1];
+	char name[7 + IFNAMSIZ + 1];
 
 	/* this will happen in monitor mode */
 	if (!dbgfs_dir)
@@ -819,10 +821,11 @@ void iwl_mvm_vif_dbgfs_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * find
 	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
 	 */
-	snprintf(buf, 100, "../../../%pd3/iwlmvm", dbgfs_dir);
+	snprintf(name, sizeof(name), "%pd", dbgfs_dir);
+	snprintf(buf, sizeof(buf), "../../../%pd3/iwlmvm", dbgfs_dir);
 
-	mvmvif->dbgfs_slink = debugfs_create_symlink(dbgfs_dir->d_name.name,
-						     mvm->debugfs_dir, buf);
+	mvmvif->dbgfs_slink =
+		debugfs_create_symlink(name, mvm->debugfs_dir, buf);
 }
 
 void iwl_mvm_vif_dbgfs_rm_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
-- 
2.34.1


