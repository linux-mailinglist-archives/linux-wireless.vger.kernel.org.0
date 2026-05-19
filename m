Return-Path: <linux-wireless+bounces-36631-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDulMIoHDGodUAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36631-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:47:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42644578522
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8D553087403
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 06:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD1390C86;
	Tue, 19 May 2026 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dynIsyO+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF73947AC
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 06:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172832; cv=none; b=tBra2lY1i5pg3IqsSJ37JtgF6AYgBNAuQhuNTbYSkW0pYbQgGWb7epZqqipNefyvMPBwzepCn1JbSX2JRiThCcHkvFRA3lckEDsOi8QLrTcIKG4jgvrSCCXMnoX3I9man8AmuY97Oiw1puwV48erZa2LQwv6P3hwuTElmKBrPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172832; c=relaxed/simple;
	bh=LO1imzBFGKGYa3EMb9YUgpSKR2dy0sl3nITZZn2tgRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vA/kkeJrykKuRrwO3N/I+tjG9ihwiGhzWFBf6YHferyQya19eBLb2DPYCpmeSYMFFm1UUOIJ+2Jie69yibv6/9hb1FaYM2r5vbfIP8QraE1YdkI3AFdRusysJvVy3tI2++14O6/vuxV7SQk0UIDpE+WXTbJBuvQUMu/k8ptn4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dynIsyO+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779172831; x=1810708831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LO1imzBFGKGYa3EMb9YUgpSKR2dy0sl3nITZZn2tgRM=;
  b=dynIsyO+KAJr4IQekpTxJM2LCl8VcpYROrp7QD/GqAbi+FIolyla9Bn+
   tiS+YTvNNpikSJUJBr7LXSkYrM2BkJ/YJfLKwe/8prFm3CKN+3XwpSPqa
   xsK3LD2En8H5RwbJ2YxNpB/Ww+1MtPhY/qDiY8HbBsCrrugp6rnk0rQZG
   g5ZR1aIUJDGfQ55neAcG5civIuAv0O7x9JEKyn/m8X0TU5oO6gyDBFIBb
   L0ff0vGx3tHAPbzlbAX+lU+gakRMnoyoklnIG8B8Wo0qC1sfxs6nExiut
   B4E5QZWV5k89Oj81eoGaeNm+Bq2rN6aH5Os1600v+lZLuRAe+szCdI5Js
   Q==;
X-CSE-ConnectionGUID: 7fEoCWWCQJqM9kY8xd14CQ==
X-CSE-MsgGUID: eEbYNEsBQLeaFxpzttKwPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="82605644"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82605644"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:31 -0700
X-CSE-ConnectionGUID: mgsrTC/8RTeV4nrfyKwhGQ==
X-CSE-MsgGUID: xTE5+8nbQf+ZRjfVsdtEwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235227291"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 23:40:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH v3 iwlwifi-next 05/15] wifi: iwlwifi: mld: keep healthy link on EMLSR missed beacon exit
Date: Tue, 19 May 2026 09:40:00 +0300
Message-Id: <20260519064010.549003-6-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36631-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 42644578522
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Link: https://patch.msgid.link/20260517100550.b2d700f7775e.I8e9189ce6cf4388878beab14e56341becd5f427c@changeid
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


