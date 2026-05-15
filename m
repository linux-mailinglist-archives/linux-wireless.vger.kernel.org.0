Return-Path: <linux-wireless+bounces-36469-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGXRHNERB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36469-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:30:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E29BE54F91E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 177B830205D4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF4478E53;
	Fri, 15 May 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrpHhgi+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646E47A0D1
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847010; cv=none; b=g8CR2QHoerkZxlzrj6SM1Pkjp1hKuMW3UnvgOG1NY9C0TdtOt3rhDsV2dC+mhW/w4Ote5L4VzqCbemr5y+KpXQsJRmRGj/M3J+6PXPh/DmclPUTSogKLV6XsvniBqps0T9GI2bPa3oCzbp4A73pDUGdggaDASCw/wXuvO/gv+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847010; c=relaxed/simple;
	bh=XF1EC7pHunNfxibcCW5vVuY7gWCOd+t6+acwg7MdJpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4Nufu8+SKj4GL2twNPnzVC61/ivIxY/dOvx8S3kZTtsygbQ0ZjVcM76Aa7Df9yCEfps2TZ3zwU3xl/Oy+h4JBh6Fjf/eyEJrP/xe6iysthaqNXlIUawgNYxt6nG0ecLGx90heZIgFsRqLcLhaBLTp6IuYlLrZIr1W0bqPMWbC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrpHhgi+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847009; x=1810383009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XF1EC7pHunNfxibcCW5vVuY7gWCOd+t6+acwg7MdJpQ=;
  b=NrpHhgi+8Msk6foFR27fxAXgvgosAfSDyGjdE/ogvk2xy3pSBAUqEzMF
   Y1+ZMC7/JfLB+kcyVMU+/ay+YxKwPLRhL/r2b0U8J/1s/3ejTCYKvCbmH
   qDhgf3wwlISAGe9drZa5PEjT21T+3peCMmjLaATamSJJ+qoH+QNjC0f0/
   BPXiLpGrGTfCFuufPYh0iG6pyPcOzPH0iHgHSEjZ8qYIneMxYVc0WGSFK
   E+C8WdMBXPDeUR1Mu4v2uqBe0k37Xvoj/catpIqaZGL40jN0v0ZsfczAf
   Gy/Jr3jW1YYNOAQJn0j6fZig6RPVl3Jq5f6ZywNWv6iUf/2fbLjKdUI4B
   g==;
X-CSE-ConnectionGUID: u0hlSVqKTvqzR7gYl5vbEA==
X-CSE-MsgGUID: lylHTG7NSVWoPLM6GyJ1jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185673"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185673"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:09 -0700
X-CSE-ConnectionGUID: DXFMLe9bSjSBHrsj53c3bA==
X-CSE-MsgGUID: SBXUZAlbTEmeyXVW/jupKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243649981"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 04/15] wifi: iwlwifi: mld: implement UHR multi-link PM
Date: Fri, 15 May 2026 15:09:37 +0300
Message-Id: <20260515150751.a28557532e2b.Id35c7f7c319c36daf8ef35fec28940d4db6fc253@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
References: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E29BE54F91E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36469-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
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

For multi-link power management, the driver really only needs
to advertise the capability and tell the firmware that the AP
has it. Implement this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/mld/link.c       | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c   | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index dd69687a4e48..09b2cddc4ad2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -556,6 +556,7 @@ enum iwl_link_ctx_protection_flags {
  *	of threshold
  * @LINK_FLG_NPCA: NPCA enabled
  * @LINK_FLG_DPS: AP is a DPS assisting AP
+ * @LINK_FLG_MLPM: AP supports UHR multi-link PM
  * @LINK_FLG_DUO: AP supports UHR DUO
  */
 enum iwl_link_ctx_flags {
@@ -565,6 +566,7 @@ enum iwl_link_ctx_flags {
 	LINK_FLG_NDP_FEEDBACK_ENABLED	= BIT(3),
 	LINK_FLG_NPCA			= BIT(4),
 	LINK_FLG_DPS			= BIT(6),
+	LINK_FLG_MLPM			= BIT(7),
 	LINK_FLG_DUO			= BIT(8),
 }; /* LINK_CONTEXT_FLAG_E_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 4ac2740dd8a1..e5e9b7089c14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -352,6 +352,11 @@ iwl_mld_change_link_in_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 		    link_sta->uhr_cap.mac.mac_cap[1] &
 				IEEE80211_UHR_MAC_CAP1_DUO_SUPP)
 			flags |= LINK_FLG_DUO;
+
+		if (link_sta->uhr_cap.has_uhr &&
+		    mld_vif->ap_sta->ext_mld_capa_ops &
+				IEEE80211_UHR_ML_EXT_MLD_CAPA_ML_PM)
+			flags |= LINK_FLG_MLPM;
 	}
 
 	cmd.htc_trig_based_pkt_ext = link->htc_trig_based_pkt_ext;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 9736b43155d6..9dc540720ecd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -420,6 +420,8 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 
 	mld->ext_capab[0].eml_capabilities = IWL_MLD_EMLSR_CAPA;
 	mld->ext_capab[0].mld_capa_and_ops = IWL_MLD_CAPA_OPS;
+	mld->ext_capab[0].ext_mld_capa_and_ops =
+		IEEE80211_UHR_ML_EXT_MLD_CAPA_ML_PM;
 
 }
 
-- 
2.34.1


