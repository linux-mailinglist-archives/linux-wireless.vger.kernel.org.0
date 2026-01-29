Return-Path: <linux-wireless+bounces-31338-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKwnHC+1e2neHwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31338-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 20:29:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD176B3FA2
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 20:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49B47303FF2C
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839F325719;
	Thu, 29 Jan 2026 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UK2ICAUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC391F09A8
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769714843; cv=none; b=NPvJnv+/uqD+YZlYZvCDWsyRu/JRhcvnG2RUxRNHlfvOZOORtxe1+nPAAcmsgBaJKIX1hn+nla7q7ptDxvsQV7Uy9LaFaacPzfJ79o311l0Qq8A7xMh51N8STPV5DToYXWOJ5L6pLl1VPq+7EdRJ4XPU9fH6lvf9MOEoLOD+O74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769714843; c=relaxed/simple;
	bh=HmXxY3T4sXCCcKPJryoH4UJhhbDrskX72HmhNi8fXUY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHSwrBybbtLeTJF3fQkKogN4AFiNmctSE9Yt8EzuitbMi/Vf1loJsZAWPDyLS3sUupzbTFytt6OPZf2P+GiLVIGl5Cvy86uPnyZHh5mCvsabglDI6H7djr2h1LVSNaLzyQJHyDc8TDORCmKr9DKZebkqEXXGhhLgP4WYy+SA15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UK2ICAUy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769714841; x=1801250841;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HmXxY3T4sXCCcKPJryoH4UJhhbDrskX72HmhNi8fXUY=;
  b=UK2ICAUySDCFE26Ju1t7Kjgu39TpqDIDPIvLEnNJeaCD1FjnmH16CUOX
   EhlCJv20P+M7JRE+2kT1mBcTcIcfqweeZJpG15PqZ/xc/E6IPWs3y4c/p
   Or9UBeMV4ikCmRGnuXNyNUYJVEOpC7QCdH/62MQZsp6pkLQXjRjGSwEic
   0rKzVf44FLx0JatD1wJIvtfcyXX0pcTC2BsOeWqpxwZQLZuCWVJlhU7nz
   n9Af4dXgcVZ43O2RQAZRWmTYlqOkVIZuadoQISu/+Ul+7SnRwl04ZZIMZ
   /A0PPLGv2RezRoQxucpL9lsgqsRXQlWmy0qRXE/5zQFNrOmntqol7zWKK
   A==;
X-CSE-ConnectionGUID: ihI4YktpT82/10jVJZtEPg==
X-CSE-MsgGUID: 7X0yLvQhRH6CsQSGIZJ27Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="81700581"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="81700581"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 11:27:21 -0800
X-CSE-ConnectionGUID: 8BU3iufmRu+QyPnBR12S8A==
X-CSE-MsgGUID: ty8B/gokTXGU8Lhe81/zDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208576878"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 11:27:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 1/2] wifi: iwlwifi: mld: cancel mlo_scan_start_wk
Date: Thu, 29 Jan 2026 21:27:09 +0200
Message-Id: <20260129212650.a36482a60719.I5bf64a108ca39dacb5ca0dcd8b7258a3ce8db74c@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-31338-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD176B3FA2
X-Rspamd-Action: no action

mlo_scan_start_wk is not canceled on disconnection. In fact, it is not
canceled anywhere except in the restart cleanup, where we don't really
have to.

This can cause an init-after-queue issue: if, for example, the work was
queued and then drv_change_interface got executed.

This can also cause use-after-free: if the work is executed after the
vif is freed.

Fixes: 9748ad82a9d9 ("wifi: iwlwifi: defer MLO scan after link activation")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c    | 2 --
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index a5ececfc13e4..f15d1f5d1bf5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -55,8 +55,6 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 
 	ieee80211_iter_keys(mld->hw, vif, iwl_mld_cleanup_keys_iter, NULL);
 
-	wiphy_delayed_work_cancel(mld->wiphy, &mld_vif->mlo_scan_start_wk);
-
 	CLEANUP_STRUCT(mld_vif);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 55b484c16280..cd0dce8de856 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1759,6 +1759,8 @@ static int iwl_mld_move_sta_state_down(struct iwl_mld *mld,
 			wiphy_work_cancel(mld->wiphy, &mld_vif->emlsr.unblock_tpt_wk);
 			wiphy_delayed_work_cancel(mld->wiphy,
 						  &mld_vif->emlsr.check_tpt_wk);
+			wiphy_delayed_work_cancel(mld->wiphy,
+						  &mld_vif->mlo_scan_start_wk);
 
 			iwl_mld_reset_cca_40mhz_workaround(mld, vif);
 			iwl_mld_smps_workaround(mld, vif, true);
-- 
2.34.1


