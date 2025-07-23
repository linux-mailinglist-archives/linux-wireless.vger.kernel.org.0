Return-Path: <linux-wireless+bounces-25904-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AECDB0EAEB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A662960D50
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4262737E6;
	Wed, 23 Jul 2025 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ie6XRnjv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569EC272E63
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253156; cv=none; b=jw/gsecL5X1S/e1ZpErjb8EKlTWPY//IV5+vWdysOv9fniai1Kktgv0UfMcfaRz4+5vI76EPHT4Q8mGQiVgB8b5Cb5I1hYw/ga0VF2IuVPMcTKWYW3Pj0YxrpNM8Frz1CO1r2FTL+MkNPOKe5mwshqGMv0uKVOmzbd7D+FGxGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253156; c=relaxed/simple;
	bh=Fh/q9dgnT8yxNyF3GLPtFH1T00IzK+6fKV8CMUs2G98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bMwbO2XkWgDVPTLHTU6GKGih5gk2xmYyemPIXsyeiOq7k8xQKdHnsU5ARumDpE/AcDdxfoBrc84Tk0knp6EIvaD6JMMqdYVBpdUkKnA/F/H/k550XrjwXoM7Zt1DNDcp1QPD/q6uKdQgg0f0Wnm7jOaG3YhY513dx2Ds41JgFGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ie6XRnjv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253155; x=1784789155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fh/q9dgnT8yxNyF3GLPtFH1T00IzK+6fKV8CMUs2G98=;
  b=Ie6XRnjvzHmiz+M5DiV3yvz8QWlJCxGhz96p2C2oVvQuzt1rZgXYgCu/
   9+hqeN2At3HXDUmwxpoeBhXFcTjouLRybq6WTXkhvkVGSYH4GafuOcNol
   zHrsWylmk9vZaR5//xeKe1L7lnXy5RdYID6uqPFJIjdPDWNd7Y3uzDxQV
   2EtcQs02CSC1jwutzQN3pBFCx3LLEHSADcsr0nh312ZGVYxUVeDq+33hC
   PmYohyiZP1adYXrBMtgzkXrMvpKG+EyN5CDgPot/CFXo6wlCljtFCZkvc
   czkycVTkeApLZKVoolq9o3gut3JGvD1ZrEoU9e2MaizzVRYSQ9Y8occIt
   w==;
X-CSE-ConnectionGUID: Ghnsl2YwSreGXtz0Lx0GXA==
X-CSE-MsgGUID: Ub8QlJ4uQdiCeIXDujRfyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340776"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340776"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:52 -0700
X-CSE-ConnectionGUID: E8Z7yBorRn2IvREXdAsASw==
X-CSE-MsgGUID: EObIjbEpTEatNx/JfP4aLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918107"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 11/14] wifi: iwlwifi: mld: use spec link id and not FW link id
Date: Wed, 23 Jul 2025 09:45:12 +0300
Message-Id: <20250723094230.2104f8cac836.I25ed77c2b87bde82a9153e2aa26e09b8a42f6ee3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
References: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

In missed beacon handling, we compare the FW link id to the
bss_param_ch_cnt_link_id, which is a spec link id. Fix it.

Reviewed-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index ca5e73cfe36e..782fc41aa1c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -524,21 +524,23 @@ void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
 {
 	const struct iwl_missed_beacons_notif *notif = (const void *)pkt->data;
 	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
-	u32 link_id = le32_to_cpu(notif->link_id);
+	u32 fw_link_id = le32_to_cpu(notif->link_id);
 	u32 missed_bcon = le32_to_cpu(notif->consec_missed_beacons);
 	u32 missed_bcon_since_rx =
 		le32_to_cpu(notif->consec_missed_beacons_since_last_rx);
 	u32 scnd_lnk_bcn_lost =
 		le32_to_cpu(notif->consec_missed_beacons_other_link);
 	struct ieee80211_bss_conf *link_conf =
-		iwl_mld_fw_id_to_link_conf(mld, link_id);
+		iwl_mld_fw_id_to_link_conf(mld, fw_link_id);
 	u32 bss_param_ch_cnt_link_id;
 	struct ieee80211_vif *vif;
+	u8 link_id;
 
 	if (WARN_ON(!link_conf))
 		return;
 
 	vif = link_conf->vif;
+	link_id = link_conf->link_id;
 	bss_param_ch_cnt_link_id = link_conf->bss_param_ch_cnt_link_id;
 
 	IWL_DEBUG_INFO(mld,
@@ -550,7 +552,7 @@ void iwl_mld_handle_missed_beacon_notif(struct iwl_mld *mld,
 
 	mld->trans->dbg.dump_file_name_ext_valid = true;
 	snprintf(mld->trans->dbg.dump_file_name_ext, IWL_FW_INI_MAX_NAME,
-		 "LinkId_%d_MacType_%d", link_id,
+		 "LinkId_%d_MacType_%d", fw_link_id,
 		 iwl_mld_mac80211_iftype_to_fw(vif));
 
 	iwl_dbg_tlv_time_point(&mld->fwrt,
-- 
2.34.1


