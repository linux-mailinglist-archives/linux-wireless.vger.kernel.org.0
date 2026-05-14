Return-Path: <linux-wireless+bounces-36430-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G73AVYmBmqmfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36430-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7394F546784
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8581F3056638
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5463B813C;
	Thu, 14 May 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YwA+5AxD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC08F3B8BD7
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787905; cv=none; b=V8JbqDsoc9caJdKXU5h5d9UJv2Tc4unL74hKioUGB5ss6vSVlw134QZ3U0zWRvhX1tNW0zy+XcpSZ9vuGW3vUQmlVOD76Ldd07hnNmzD7GgagoFcyKo86aSI2ozxqdcA63jbIhCypPGRmkOQ6rmXO80Vif6IMFukvT9jI3uqRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787905; c=relaxed/simple;
	bh=XrIj3rqUA9w+UPGXrnPXz/lm7d1eqHjJthAJui69Y/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htuP0K6Mx3dhNyZp6yuGnxi6mu5H1oZY1dRgzE59vHPunH3IAV81v1KfUefr8m/GTvdG9A21VCHYspjgBV8sx2XpZfG2ssMwZWhK4aUqep/VRYiW6jLG7CFzjf462AXG6NzcKC+g4BgrPTvB8pD/TzRI0FjkbVvnKpSR/33e1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YwA+5AxD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778787904; x=1810323904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XrIj3rqUA9w+UPGXrnPXz/lm7d1eqHjJthAJui69Y/4=;
  b=YwA+5AxD5s5pH5S2bcKNQeomtgIsH0USbDWC8HSKO0dXSSgJh140/iHf
   v2+yIg8kCtF9f273OQypmqFgL1hC7y2D/eKnKn+fpu7Wv/YCj2EEKwa0F
   Zfm1O8x+eYxfWTr8G69HwMgCx9G4NBFhflRT/tztO6A/n8BAK6xSqJlUw
   3VXGCSOcSjmdGPI1M9NSEC31CQsMg1kIsxcfASMrEPClhOefGM4wAKiMe
   QammWWUp4MufYcuGffXHdVH2JRrKbAyjsjz6wXtS35ZJs9dXCIhyelQKD
   yV3+Z8HkuPQpilrNcOfy8MG7rqypShO/awkWkmbDxDMx9ACfxIwMCng0o
   g==;
X-CSE-ConnectionGUID: bmZsPEuQSfmE3xEJTB6G5A==
X-CSE-MsgGUID: 5I+GUtThQ9GOKs+QZ7T/+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83352600"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83352600"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:04 -0700
X-CSE-ConnectionGUID: dxXW5dgCTW+Gr+G0HV6G6w==
X-CSE-MsgGUID: xiozUFABSy6IztWJcBi6pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237616337"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:45:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: add link and link station FW IDs to debugfs
Date: Thu, 14 May 2026 22:44:29 +0300
Message-Id: <20260514224230.7224fab5fe8d.Ic2fd82f5f20945aa070ac9e38882fcff2172a4d8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
References: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7394F546784
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36430-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Add the link and link station FW IDs to debugfs to aid debug
and testing, since assignments can't be known ahead of time,
especially with ID randomisation turned on.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index afe972834cb8..351a4f177e92 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -983,12 +983,35 @@ void iwl_mld_add_vif_debugfs(struct ieee80211_hw *hw,
 #define LINK_DEBUGFS_WIPHY_WRITE_FILE_OPS(name, bufsz)			\
 	WIPHY_DEBUGFS_WRITE_FILE_OPS(link_##name, bufsz, bss_conf)
 
+/*
+ * Note: no locking is provided, so the function must have its own,
+ * but it cannot acquire the wiphy mutex.
+ */
+#define LINK_DEBUGFS_READ_FILE_OPS(name, bufsz)			\
+	_MLD_DEBUGFS_READ_FILE_OPS(link_##name, bufsz, struct ieee80211_bss_conf)
+
 #define LINK_DEBUGFS_ADD_FILE_ALIAS(alias, name, parent, mode)		\
 	debugfs_create_file(alias, mode, parent, link_conf,		\
 			    &iwl_dbgfs_link_##name##_ops)
 #define LINK_DEBUGFS_ADD_FILE(name, parent, mode)			\
 	LINK_DEBUGFS_ADD_FILE_ALIAS(#name, name, parent, mode)
 
+static ssize_t iwl_dbgfs_link_fw_id_read(struct ieee80211_bss_conf *link_conf,
+					 size_t buflen, void *buf)
+{
+	struct iwl_mld_link *mld_link;
+
+	guard(rcu)();
+
+	mld_link = iwl_mld_link_from_mac80211(link_conf);
+	if (!mld_link)
+		return -EINVAL;
+
+	return scnprintf(buf, buflen, "%d\n", mld_link->fw_id);
+}
+
+LINK_DEBUGFS_READ_FILE_OPS(fw_id, 64);
+
 void iwl_mld_add_link_debugfs(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_bss_conf *link_conf,
@@ -1009,6 +1032,8 @@ void iwl_mld_add_link_debugfs(struct ieee80211_hw *hw,
 		/* Release the reference from debugfs_lookup */
 		dput(mld_link_dir);
 	}
+
+	LINK_DEBUGFS_ADD_FILE(fw_id, mld_link_dir, 0400);
 }
 
 static ssize_t _iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
@@ -1092,6 +1117,21 @@ static ssize_t iwl_dbgfs_link_sta_tlc_dhc_write(struct iwl_mld *mld, char *buf,
 	return ret ? : count;
 }
 
+static ssize_t
+iwl_dbgfs_link_sta_fw_id_read(struct ieee80211_link_sta *link_sta,
+			      size_t buflen, void *buf)
+{
+	struct iwl_mld_link_sta *mld_link_sta;
+
+	guard(rcu)();
+
+	mld_link_sta = iwl_mld_link_sta_from_mac80211(link_sta);
+	if (!mld_link_sta)
+		return -EINVAL;
+
+	return scnprintf(buf, buflen, "%u\n", mld_link_sta->fw_id);
+}
+
 #define LINK_STA_DEBUGFS_ADD_FILE_ALIAS(alias, name, parent, mode)	\
 	debugfs_create_file(alias, mode, parent, link_sta,		\
 			    &iwl_dbgfs_link_sta_##name##_ops)
@@ -1101,9 +1141,18 @@ static ssize_t iwl_dbgfs_link_sta_tlc_dhc_write(struct iwl_mld *mld, char *buf,
 #define LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(name, bufsz)			\
 	WIPHY_DEBUGFS_WRITE_FILE_OPS(link_sta_##name, bufsz, link_sta)
 
+/*
+ * Note: no locking is provided, so the function must have its own,
+ * but it cannot acquire the wiphy mutex.
+ */
+#define LINK_STA_DEBUGFS_READ_OPS(name, bufsz)				\
+	_MLD_DEBUGFS_READ_FILE_OPS(link_sta_##name, bufsz,		\
+				   struct ieee80211_link_sta)
+
 LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(tlc_dhc, 64);
 LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(fixed_rate, 64);
 LINK_STA_WIPHY_DEBUGFS_WRITE_OPS(fixed_rate_v3, 64);
+LINK_STA_DEBUGFS_READ_OPS(fw_id, 64);
 
 void iwl_mld_add_link_sta_debugfs(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
@@ -1113,4 +1162,5 @@ void iwl_mld_add_link_sta_debugfs(struct ieee80211_hw *hw,
 	LINK_STA_DEBUGFS_ADD_FILE(fixed_rate, dir, 0200);
 	LINK_STA_DEBUGFS_ADD_FILE(fixed_rate_v3, dir, 0200);
 	LINK_STA_DEBUGFS_ADD_FILE(tlc_dhc, dir, 0200);
+	LINK_STA_DEBUGFS_ADD_FILE(fw_id, dir, 0400);
 }
-- 
2.34.1


