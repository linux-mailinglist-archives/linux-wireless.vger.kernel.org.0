Return-Path: <linux-wireless+bounces-36541-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDVDHrp1CWolbAQAu9opvQ
	(envelope-from <linux-wireless+bounces-36541-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B1355FD58
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 10:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20D66301452D
	for <lists+linux-wireless@lfdr.de>; Sun, 17 May 2026 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAAF28686;
	Sun, 17 May 2026 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0pkoqEg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95026B67E
	for <linux-wireless@vger.kernel.org>; Sun, 17 May 2026 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004833; cv=none; b=ftZ1Qz4rjQJJk+S811OY/Lvxq4fDKsXJKhQuUgtjbVPDnf9HIHnlJMK1nPK1MnnfpWUuwDfmMlCyXT9ErJVUK9PtWapI9WJqOaqrqKGfgiV5Axz7ksTRIhFWAyD4NjTTjXpi1ifb1KpGSZfDOV/WeDk7/kia4zNpg8vCZVWvxn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004833; c=relaxed/simple;
	bh=x6Sb1HBekxwXr3IFX/j+lsBpOGTqwtIOryk1vBJD3i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNQUXctcqmoAlNCZRJdCQ3DkhbCk2JRoFqN7CNuFiZISAspawZQJJ35Xb1OiwjifKqza6SgwD5XsZwzLhkij6hq5n8Y0HO+2vU98NuTRA48qXKQTHNcZXoRNcjn4Q04Uxp9TwbvcwhssVVVD6Ea7xnUtj9iLx7SVo5Wfavj80w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0pkoqEg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004831; x=1810540831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6Sb1HBekxwXr3IFX/j+lsBpOGTqwtIOryk1vBJD3i8=;
  b=U0pkoqEgUc5mAUkHR1GS5id8AxinRfxhqimamuJ7dlNRtfbGZuMRESN8
   WHUJTHKZL4b4XQ53km6ydIpU2Ri+k98TOJI1CpXC53B4F4x+KxzBhO0yb
   uQRdv0PkeKDnvOr/LC7Qdz5K1Xb1VFn+3YItztVQO7xpcIogfxt5fVzoq
   D2Dn84seDJCTck06WuEnF9xs6Wv1/zvT39mfSanZ3eNhUMkFps/wimonf
   kS7x0KJ7fWJJ2PEWdeNk1RlcRWtNnTJFv27ExRpGR7cpXX+Lcn5VbYN6a
   QdBdLLaiscs/Lam+Pd3kz1UITosGYPh9Rm0rYjp8PLs0iKAij2+wvhgMT
   w==;
X-CSE-ConnectionGUID: fh82BgEVTuemyIqkm4p2OA==
X-CSE-MsgGUID: xSZhrKd7R9KMrDdMTE9exA==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79606957"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="79606957"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:31 -0700
X-CSE-ConnectionGUID: 8mz1heFTTqyicsDLbFRQDw==
X-CSE-MsgGUID: mXgZ76aGSdiVcZo34aI/6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="236490419"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:00:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH v2 iwlwifi-next 05/15] wifi: iwlwifi: mld: keep healthy link on EMLSR missed beacon exit
Date: Sun, 17 May 2026 10:59:49 +0300
Message-Id: <20260517100550.b2d700f7775e.I8e9189ce6cf4388878beab14e56341becd5f427c@changeid>
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
X-Rspamd-Queue-Id: F0B1355FD58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36541-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Avinash Bhatt <avinash.bhatt@intel.com>

When EMLSR exits due to beacon loss on the current link, the driver
should keep the link that is still receiving beacons. The previous
code always called get_primary_link(), keeping the primary link
regardless of which link is actually losing beacons. If the primary
link is the one losing beacons, the driver exits EMLSR onto the
degraded link and the connection is lost eventually.

When both links lose beacons, keep the primary link. When only the
current link loses beacons -- whether due to signal loss or a BSS
parameter change -- keep the other link.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 549f1c1ea22f..1bdfba6279e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -663,15 +663,20 @@ void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
 	 * OR more than IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED
 	 * on current link and the link's bss_param_ch_count has changed on
 	 * the other link's beacon.
+	 *
+	 * When both links lose beacons, keep the primary (symmetric failure).
+	 * When only the current link is sick, keep the other link.
 	 */
-	if ((missed_bcon >= IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS &&
-	     scnd_lnk_bcn_lost >= IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS) ||
-	    missed_bcon >= IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH ||
-	    (bss_param_ch_cnt_link_id != link_id &&
-	     missed_bcon >=
-	     IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED)) {
+	if (missed_bcon >= IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS &&
+	    scnd_lnk_bcn_lost >= IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS) {
 		iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_MISSED_BEACON,
 				   iwl_mld_get_primary_link(vif));
+	} else if (missed_bcon >= IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH ||
+		   (bss_param_ch_cnt_link_id != link_id &&
+		    missed_bcon >=
+		    IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED)) {
+		iwl_mld_exit_emlsr(mld, vif, IWL_MLD_EMLSR_EXIT_MISSED_BEACON,
+				   iwl_mld_get_other_link(vif, link_id));
 	}
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_handle_missed_beacon_notif);
-- 
2.34.1


