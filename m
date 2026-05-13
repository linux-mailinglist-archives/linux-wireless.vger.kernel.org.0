Return-Path: <linux-wireless+bounces-36364-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFz8IgIQBGouDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36364-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:45:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCFD52DB28
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7F99305B280
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830222030A;
	Wed, 13 May 2026 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nL69AMYP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FAF3A718C
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651069; cv=none; b=OZ2FYKL71LQKb/m38JriatiuMGSw3YOkmg5TfyJ8IbD+OXdKHTmvOUwyWHT+gkgaJCgvVb1zf9FtDsNe3nraC37G7Eu1bKqKIf2z1x8++GPKyV2kWBrqwLEDo0Xueqdx7luDigqzSPKahpE8bfVHgK2z+nBeTWXU0CGlITOiRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651069; c=relaxed/simple;
	bh=qb+K7m8bPOdJxGp1vIKJWBOjWXIzfjN+D9j9uv9ZuDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLjEgW2kcODIHFQkZ5gkKachkDVb/6dt88bPrDmJHHQsd1Sjj3nXVCEe92F7R/nni/1OCrSY/ywx1jZEBALQ41o1vUY/I+Nb+rkZ1hknYS2wofAkcN5A7EXNqptrbpdjrtiXvhP9jPz/E8qH5JaiN8PwY8OztGdrnIjgyjH4NXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nL69AMYP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651066; x=1810187066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qb+K7m8bPOdJxGp1vIKJWBOjWXIzfjN+D9j9uv9ZuDA=;
  b=nL69AMYPUa4NIY2K0WA3t0TZ34vCbeozv2lStoRY5Jze2UOkp0pLe3Be
   RcCWFY5biOY9CwIEVjVDS7bs5h5m0pXZ+MSlmlqS5M5ZVTfdVPR7p+DuG
   FwBlRPe+pnFsuHOoZ+PvxAhW3X5NYsukGl75HzsSlHJuEd3uvIrPj+22A
   ZJXoFFfZbhGziFwR7N5aYZ0qfTj6/IxeEdqsolgNKU8nMP9KEf6gZ6VQ+
   zDUQOGqyVLYuFShjjOmcKpGnJ3i7JZTtTBr7haWBWrCk5IIzjeIzmximP
   zfwxewVY6hI/YT68cXDSfj8MwqFMaNFZKTOwjYaskbqyZHjaOaxwe7Gap
   Q==;
X-CSE-ConnectionGUID: IGNtgG97RAWf5DZzbAwPeA==
X-CSE-MsgGUID: PCTWKHs1SpCfME7HgREgPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552834"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552834"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:25 -0700
X-CSE-ConnectionGUID: NJUmHUarTEmbeFMBA23fNA==
X-CSE-MsgGUID: MH4mphd9St+Zt6ImTVuNMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077927"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:24 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: implement UHR DPS
Date: Wed, 13 May 2026 08:43:54 +0300
Message-Id: <20260513084215.69c5657f2b0c.I0e0dfcd2e2641a5656a14f01ce696443ae10bc4a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECCFD52DB28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36364-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,intel.com:server fail];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

For UHR, implement dynamic power save (DPS). Since the firmware
handles most of it, simply advertise DPS capability and set the
corresponding link flag when the AP has advertised that it is a
DPS assisting AP.

DPS assisting is currently not supported.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h |  2 ++
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c  |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mld/link.c       | 10 +++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index fa2fc6a92e60..604281eb29c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -550,6 +550,7 @@ enum iwl_link_ctx_protection_flags {
  * @LINK_FLG_NDP_FEEDBACK_ENABLED: mark support for NDP feedback and change
  *	of threshold
  * @LINK_FLG_NPCA: NPCA enabled
+ * @LINK_FLG_DPS: AP is a DPS assisting AP
  */
 enum iwl_link_ctx_flags {
 	LINK_FLG_BSS_COLOR_DIS		= BIT(0),
@@ -557,6 +558,7 @@ enum iwl_link_ctx_flags {
 	LINK_FLG_RU_2MHZ_BLOCK		= BIT(2),
 	LINK_FLG_NDP_FEEDBACK_ENABLED	= BIT(3),
 	LINK_FLG_NPCA			= BIT(4),
+	LINK_FLG_DPS			= BIT(6),
 }; /* LINK_CONTEXT_FLAG_E_VER_1 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 4e8222ffe732..f29de029c709 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -696,7 +696,8 @@ static const struct ieee80211_sband_iftype_data iwl_iftype_cap[] = {
 			.phy.cap = IEEE80211_UHR_PHY_CAP_ELR_RX |
 				   IEEE80211_UHR_PHY_CAP_ELR_TX,
 			.mac.mac_cap = {
-				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP,
+				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
+				      IEEE80211_UHR_MAC_CAP0_DPS_SUPP,
 			},
 		},
 	},
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 9ef39b03e67f..785459937fbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -335,10 +335,18 @@ iwl_mld_change_link_in_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 			link_sta_dereference_check(mld_vif->ap_sta,
 						   link->link_id);
 
-		if (!WARN_ON(!link_sta) && link_sta->he_cap.has_he &&
+		if (WARN_ON(!link_sta))
+			return -EINVAL;
+
+		if (link_sta->he_cap.has_he &&
 		    link_sta->he_cap.he_cap_elem.mac_cap_info[5] &
 		    IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX)
 			cmd.ul_mu_data_disable = 1;
+
+		if (link_sta->uhr_cap.has_uhr &&
+		    link_sta->uhr_cap.mac.mac_cap[0] &
+				IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP)
+			flags |= LINK_FLG_DPS;
 	}
 
 	cmd.htc_trig_based_pkt_ext = link->htc_trig_based_pkt_ext;
-- 
2.34.1


