Return-Path: <linux-wireless+bounces-36424-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIMHEUwmBmqmfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36424-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEF2546776
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5681D303DD20
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0BA389E1A;
	Thu, 14 May 2026 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyXaVPd7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A283AE198
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787896; cv=none; b=rFzL3trmi2yapl8IByR2/F+KoFB1SxleRmhrlLQtQDmf5RHY1DMqtZyedmmnDc+hMNIwg0X16sz+j2+Sx9ce+3EsOOu/Ks6qAhqUW6ue51LqTpsjhNu5k90VzBsRYZOASV4OjrTyd4Z40+WKxfu9TLKRBdJ1B6xFLLx9WpWQG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787896; c=relaxed/simple;
	bh=XF1EC7pHunNfxibcCW5vVuY7gWCOd+t6+acwg7MdJpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDFVRG9oygsJ3tK3H8FrT/mIwj8dbJEx/HV3ZqHW1rbmt7rj2Z246d0JXVpx6rKGntjVEMAczVqkHcuCCMyGzH/sjbzEGzPEWo8nSmqEHHGQ1tZI7llUBoqYQ+rKNmQdDZ3+iKvjqBXlD5wWjdcMden2jCv7MvtaM7XDOPGDSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyXaVPd7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778787896; x=1810323896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XF1EC7pHunNfxibcCW5vVuY7gWCOd+t6+acwg7MdJpQ=;
  b=hyXaVPd77nznph1ns9ufLA1gb+TVZz+oo41VeCjCyRd+whIvYIr4QcUW
   eR7dq7uFUs9ibg1NaFbeqP3aDUQMDVjTIXkbxUdDwKLNtJ6gcSFiAy0+S
   mEYPq+qEO5cYzbBCvvMis/1hqaWCJuJNX4OGmaT0nZbcEt+uFrk8sAmpG
   7CRN/GmasZaMrWxQpsUKN01IbSzzo36xhalNmzOy9cytcxeogWGbB0WMP
   +cOty6KbRpQfBx45lPtPnwAGQAZl3QgeqIUC/7wSTzPHH08sEPpyNAfI7
   XIvSycnDUo3ZARL6JbqHgCmcjbsXjTfk0lVD8y9Fy6FbX2w1awdDOjZAY
   Q==;
X-CSE-ConnectionGUID: PcQFRrtvQlauM+YJnp8rCA==
X-CSE-MsgGUID: gk1rWX4zQCW4YS6GS2e85g==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83352580"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83352580"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:44:55 -0700
X-CSE-ConnectionGUID: qYmKDOoCQ5eILEpXRSNM+A==
X-CSE-MsgGUID: Bit0CH9ITgaewnDhkaPH6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237616251"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:44:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mld: implement UHR multi-link PM
Date: Thu, 14 May 2026 22:44:23 +0300
Message-Id: <20260514224230.a28557532e2b.Id35c7f7c319c36daf8ef35fec28940d4db6fc253@changeid>
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
X-Rspamd-Queue-Id: 9DEF2546776
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36424-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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


