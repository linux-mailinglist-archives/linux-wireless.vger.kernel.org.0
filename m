Return-Path: <linux-wireless+bounces-36522-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAfPGKnPCGp+6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36522-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F194E55DA1F
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A0943005D1C
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF0454654;
	Sat, 16 May 2026 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ce2eTLOc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3EF2BDC23
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962319; cv=none; b=mFLZnuw7PafwE5VDStqrPOsWv13crMEvzZ5tGc3B2B1osJX0pnHnYKx+N9brnNUu8DI29+AApVnsp22q2UR2p4e1Tec30p9aJZXQ+nK8ZuHynuFbnvOCsKGz4c0efsxzY0zFvaAeVOJpXbfLhhYuXC/xZugcc8kRtvc8G6jiTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962319; c=relaxed/simple;
	bh=Xn5m5kV9zhwhVJn3nSQBZ6wMWj4lJiCADTL64W0HuvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJ7mR7HzJckvYmxZIdPjNUlbQvkZK41Hx5U0nYZP6Ud1AykytXJl0RUwOB2vdpjccJ8ipvSGlI4MHER55TBkNhlSe08uQklVwdDvgjDCuCPm+AcBGPMuS4nuuupB4alA/ZiTScnbZCZc0gRLlJWOdg1yGxhBfUdYDyGuOea2irI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ce2eTLOc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962318; x=1810498318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xn5m5kV9zhwhVJn3nSQBZ6wMWj4lJiCADTL64W0HuvU=;
  b=Ce2eTLOczU7xsAnB8+vXf8/SGIrqMszpgSHUlWy6BuMbBQkwSP6sAn6D
   ohNMZGhVpn2PYzclcSxLRWmRGMB0e6VMXeherExRZ4IHRnsbV2BGvT9jw
   C8SG1Nzu1pvzSBVXsusFChoAEw/zUtyJTBuhVN7sjDhT1mbkuQ96AhO+a
   yVxAWC/XeBIVC5AdRNz96dqepHERHHpariCdGgiUpJ+ZkYm4Zdyaz7+Cf
   XISaZ0/CJPRKgsDxJ0GacYTfwx1RGKTSiakYvuZ9oUfcjr/4o6iMEkDKF
   19TwpSAvD8CjDpEhdWbk3aD6uRFr92vfedCsOr+TQuD2bT2s0093w946l
   g==;
X-CSE-ConnectionGUID: PxCztsbyQC+QLtpTSgNSJA==
X-CSE-MsgGUID: GuUoy0dhSCSA8CwjE13VYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845725"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845725"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:58 -0700
X-CSE-ConnectionGUID: VZQoxvKSSV6RuADgm9ccgQ==
X-CSE-MsgGUID: gJdwseo3RtyPxTDjqOPyHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130875"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH iwlwifi-fixes 04/15] wifi: iwlwifi: mld: skip MLO scan trigger when AP has no QBSS Load IE
Date: Sat, 16 May 2026 23:11:26 +0300
Message-Id: <20260516230843.621538e20244.I7fdccb759508f32991cc06774cc7621725a58bd3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
References: <20260516201137.2395464-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F194E55DA1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36522-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim]
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


