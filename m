Return-Path: <linux-wireless+bounces-36523-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBZVNpXPCGp+6QMAu9opvQ
	(envelope-from <linux-wireless+bounces-36523-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D9155D9F8
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 22:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F9FE301370A
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2026 20:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C154654;
	Sat, 16 May 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWxmqX0p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D829A32D
	for <linux-wireless@vger.kernel.org>; Sat, 16 May 2026 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778962320; cv=none; b=MtYL88RsXLIGRbp0Ao/TK6HUazIFdhn9TZ4TwCfRcYh/CGFe2MIyR4U4cVSw8cXM0IsDj0EJbdLaJdmbR6MqNuE9RAILrj1HTQ+9ui/+I3975eJaiqJIA7uGQfkOZq6g0c9sv9K46l5NNFKnGtTGxZAOWkjKeDQyJ/UKJvqORQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778962320; c=relaxed/simple;
	bh=x6Sb1HBekxwXr3IFX/j+lsBpOGTqwtIOryk1vBJD3i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4goczHSTRqYvslcDKnWfX1ulr+6hPxc2/95cVX4dV0Ckbz5RMY1kt9NDe907wFbTSxHvVjF2Faev+fVNI4DJsj5+Dj1gAz5mmHnlHFp9DBlKdjGhRYHtpkwSxf2Lu9py0Ex8hhy8QguULf2KoFVqaZf4289iJ9FhgIjav48b/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWxmqX0p; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778962319; x=1810498319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6Sb1HBekxwXr3IFX/j+lsBpOGTqwtIOryk1vBJD3i8=;
  b=TWxmqX0pom1b3OZ37O1NdOf0whRxPuKNtDKXziOzlmyDW7K9tCevpAcD
   0Wu6nzwa2mu+/4ohZAK7+8ox7uczzqKQDnvihXHu8SIsiSAUrijpLTHKw
   NogJUB1mTo4rxZJx5oBwycMPGFaXee0hpSAnwfeQyDtVZqYAenhDPuxXn
   Xwza4oD5ZLJNFOdPvSDXjc5FFpj0U1ZDWKFAwBVIXKvXwCXsX3oYL8Rnf
   /BtfsTZHeA+Vh1fXi4f/1jPuSWlNI7ecyBU4jLb/11IVyJUzboj3TbNyQ
   7opCYBPk1O9y9mG8Mw4MUmO9HZSzlCvod3LytI488oINI5BV5ZiEd2r8I
   A==;
X-CSE-ConnectionGUID: cQITIX64TiaSawzaC+ntng==
X-CSE-MsgGUID: 2hrcSBX9RdKiUkznrpHGhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="79845726"
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="79845726"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:59 -0700
X-CSE-ConnectionGUID: spjlGILERYCPOxjBRubRKw==
X-CSE-MsgGUID: 5uh6ut0BQgWKTA8hszkMZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,238,1770624000"; 
   d="scan'208";a="239130882"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2026 13:11:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH iwlwifi-fixes 05/15] wifi: iwlwifi: mld: keep healthy link on EMLSR missed beacon exit
Date: Sat, 16 May 2026 23:11:27 +0300
Message-Id: <20260516230843.b2d700f7775e.I8e9189ce6cf4388878beab14e56341becd5f427c@changeid>
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
X-Rspamd-Queue-Id: 93D9155D9F8
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
	TAGGED_FROM(0.00)[bounces-36523-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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


