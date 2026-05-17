Return-Path: <linux-wireless+bounces-36540-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCWtA7V1CWolbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36540-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FA55FD51
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B531E300F519
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDC428686;
	Sun, 17 May 2026 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWrY8r2v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843232E228D
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004832; cv=none; b=nXm/BnxGl4CEmSRYxxABi8PWQbfy+dvQG76x1yC2Re9ti7oWUGoyqYWyWKP9FJAWu8Pta1vLDHBhYc/8aIsQNduTVMNpJkJKunQEiEWz4NKWMkw/V6rbEdYhTRfV0o3xxD6bFexNEMaPsPdrywqp8e/PfeTSzxx0RR1pOqapvU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004832; c=relaxed/simple;
	bh=Xn5m5kV9zhwhVJn3nSQBZ6wMWj4lJiCADTL64W0HuvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g83yFNdUQq/iYQIGQN4e20Ict1OM2Jlqb7UWH2IbSZEtiVBSh30IZF5DkhEPHh8CPfB56DeXTtoDTKoLXxZwRIh43CQoRA9rpZLEaAaNG+KSz3O8bvsWglPiU/RQJR2WcQ7SvsDz0icBeVIwqlmPHfP4MIg0Rvsoae+tawyylyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWrY8r2v; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004830; x=1810540830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xn5m5kV9zhwhVJn3nSQBZ6wMWj4lJiCADTL64W0HuvU=;
  b=MWrY8r2vH1QbSCqrvC6zSLn+I3R7d1uNSZYUWSG6SZYYxtaiL4qh7G31
   noWSwy/m9Yt56aKE8b0Yu+5/VrvULjVYQndm+7R+C2TEZGRsW8jz5Ydz9
   iSEEPZNU5D/1KHx96Iw515WZAJRYBhrruenXdEKMxx7Nj7yzZfH2v817I
   q43QGSPkGPpwrwmEuT28uc2ur3OMkTbh56hNChQhswO6F6QJuZdM65Cip
   AIZ/VS7qqxXumy4dYz5koPZz8+pOB6wzqgOWc8gfyBBq1YqSV+JAeCpem
   2Bliqt+O7O6DsCOKW5i5Vjqplcy+GhTj+KbUaWB8XohG/YxMvw3G6a8sG
   g==;
X-CSE-ConnectionGUID: 5dG6PYEOTDqQYYyjJEJDxg==
X-CSE-MsgGUID: ht0cf4sMSke3SShfRIF4tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606955"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606955"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:30 -0700
X-CSE-ConnectionGUID: 9+Nech1RRe+tdwPN3vLeVQ==
X-CSE-MsgGUID: QO1PcSF+SI27OZIYZKCz+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490410"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH v2 iwlwifi-next 04/15] wifi: iwlwifi: mld: skip MLO scan trigger when AP has no QBSS Load IE
Date: Sun, 17 May 2026 10:59:48 +0300
Message-Id: <20260517100550.621538e20244.I7fdccb759508f32991cc06774cc7621725a58bd3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
References: <20260517075959.2815365-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F3FA55FD51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36540-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Avinash Bhatt <avinash.bhatt@intel.com>

When FW PHY statistics report high channel load (MCLM), the driver
triggers an internal MLO scan to find a better link. However, link grade
computation uses the QBSS Load IE from AP beacons, not MCLM data. If
the AP does not broadcast a QBSS Load IE, the scan produces no benefit
as the grade falls back to static band defaults regardless, and the same
bad link will be selected anyway as the active link.

Skip the MLO scan trigger when the AP does not advertise a QBSS Load IE.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 5 ++---
 drivers/net/wireless/intel/iwlwifi/mld/link.h | 3 +++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 7 +++++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index e5e9b7089c14..549f1c1ea22f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -859,9 +859,8 @@ iwl_mld_apply_puncturing_penalty(const struct ieee80211_bss_conf *link_conf,
 	*grade = *grade * (n_subchannels - n_punctured) / n_subchannels;
 }
 
-static int
-iwl_mld_get_chan_load_from_element(struct iwl_mld *mld,
-				   struct ieee80211_bss_conf *link_conf)
+int iwl_mld_get_chan_load_from_element(struct iwl_mld *mld,
+				       struct ieee80211_bss_conf *link_conf)
 {
 	const struct cfg80211_bss_ies *ies;
 	const struct element *bss_load_elem = NULL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 0b3974d86531..f1997e280058 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -145,6 +145,9 @@ unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 unsigned int iwl_mld_get_chan_load(struct iwl_mld *mld,
 				   struct ieee80211_bss_conf *link_conf);
 
+int iwl_mld_get_chan_load_from_element(struct iwl_mld *mld,
+				       struct ieee80211_bss_conf *link_conf);
+
 int iwl_mld_get_chan_load_by_others(struct iwl_mld *mld,
 				    struct ieee80211_bss_conf *link_conf,
 				    bool expect_active_link);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 2a3b2c883fc4..a2f8a6957535 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -1100,6 +1100,13 @@ static void iwl_mld_chan_load_update_iter(void *_data, u8 *mac,
 		if (rcu_access_pointer(link_conf->chanctx_conf) != chanctx)
 			continue;
 
+		/* No QBSS IE - links will be selected based on default channel
+		 * load values, so the same link will be selected again.
+		 * No point in scan.
+		 */
+		if (iwl_mld_get_chan_load_from_element(mld, link_conf) < 0)
+			continue;
+
 		if (iwl_mld_chan_load_requires_scan(mld,
 						    link_conf,
 						    new_chan_load)) {
-- 
2.34.1


