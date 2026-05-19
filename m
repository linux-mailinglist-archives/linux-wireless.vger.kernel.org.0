Return-Path: <linux-wireless+bounces-36630-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D/GFaMIDGo5UQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36630-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:52:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B9578658
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59F41306FA78
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226211E25F9;
	Tue, 19 May 2026 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4rs2Dc0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB0397695
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172831; cv=none; b=sL6dgLl+GLKwbBgrqCd4GQkIAdjAS92b24UAualOIsdfoN3HLwlGFH7KHAu29+FfGCSZRwSnS5Kf41uY886VvwfrpgSQ9Zl79a40wtMSNAoBCTg0pf9l9+UTxjmEDiydc7V39z8PPgT/+LQbxAL8O0ky/6LTbmV2VyY0czHHBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172831; c=relaxed/simple;
	bh=7lrBtOFwr6NfjP5zKbxFHq+tnpay8jAj6UWkeuPotX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qm6ebV6Rc+MrNanHvhClS8N60pFwXiZQCldhhO96zryHW5Qklc4RysKfEEFTOoOqQ7ksm+uQBWZPXakgpd0AHDOBa0o4PBeYUV1stAUhSu9/GySH1YcTzmEUwodcYCvzpGtsN5OpRt5tvdl8buNpUVg06d0valO1T04PLRyYoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4rs2Dc0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172830; x=1810708830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7lrBtOFwr6NfjP5zKbxFHq+tnpay8jAj6UWkeuPotX0=;
  b=A4rs2Dc0yCe9QOiok1HE02spZHIBBUQTCn9E24MTmXG1mEFbWEOjFzBP
   c5jMX1m7BOOxw7u+hsVcNg7dEwEpvKjRBn1zocjYS2gDdzN0FDYQ7MyH6
   yiePRj5ULvg3R4A1wnd1nvtInxfMUPxzNff07qqqNPTnIb+6UDRBo7kqD
   HlLMbQibd7F4mwcKPCX2/ncEKqVl1RbIr4siPIdFCMqlr7RCXqIQEnJi/
   5PoQfqSHH9p2+4xTHBMw2BW+GInvWTBY1uyl/Xvv9HiE0kzGXSAtSQgH+
   L4MkLjVV2zWDs1p4RkRMBf5bcY3SaV7rOfEwLT6zcl5mDpN9fsOyaAuq1
   Q==;
X-CSE-ConnectionGUID: dNZpn2ATSO2xKUQk4zda5Q==
X-CSE-MsgGUID: pT/hw5AhRHKX73+v+6/A4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605640"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605640"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:30 -0700
X-CSE-ConnectionGUID: UljnOwD2SoupoBoH9jtdLQ==
X-CSE-MsgGUID: aKvn72raQqijXi09H1coIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227284"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH v3 iwlwifi-next 04/15] wifi: iwlwifi: mld: skip MLO scan trigger when AP has no QBSS Load IE
Date: Tue, 19 May 2026 09:39:59 +0300
Message-Id: <20260519064010.549003-5-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
References: <20260519064010.549003-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36630-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 600B9578658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avinash Bhatt <avinash.bhatt@intel.com>

When FW PHY statistics report high channel load (MCLM), the driver
triggers an internal MLO scan to find a better link. However, link grade
computation uses the QBSS Load IE from AP beacons, not MCLM data. If
the AP does not broadcast a QBSS Load IE, the scan produces no benefit
as the grade falls back to static band defaults regardless, and the same
bad link will be selected anyway as the active link.

Skip the MLO scan trigger when the AP does not advertise a QBSS Load IE.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Link: https://patch.msgid.link/20260517100550.621538e20244.I7fdccb759508f32991cc06774cc7621725a58bd3@changeid
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


