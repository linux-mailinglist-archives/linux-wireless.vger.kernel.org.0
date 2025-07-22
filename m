Return-Path: <linux-wireless+bounces-25828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76727B0D4A9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC33C167421
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B01E2DC33B;
	Tue, 22 Jul 2025 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJj8ydOq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F62DAFC3
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172990; cv=none; b=Dj/iOSDIoMQW92M4x1gR/bseGWlXS+/PDSg7WOuv44RGwcGTdJCDYsz0wiY7GmUSdbAvMrhEctGyG4aIGiamcspRhPvAa/Yst/Tc9IRQwZfW1OI51V3GA8vWIdninv51thb46dSmHte/BKnBmvpP61pliaie/lijchksotbKczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172990; c=relaxed/simple;
	bh=Fh/q9dgnT8yxNyF3GLPtFH1T00IzK+6fKV8CMUs2G98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVZVXKsTUMW7W6GflmSpFsp1STpIFONRP+GjFyzmwS8NquMFfVhOrvIfYHYl4offZtWZSTI6FYNPKgNJ7TAIMGEAvJnDPAXYVxNhARYfUpDRblI8TKf2QlA623RmD5HY7iiezDt9UqIcSU4vomQxgPM2WIr/6RLQiBEx1+kNhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJj8ydOq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172989; x=1784708989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fh/q9dgnT8yxNyF3GLPtFH1T00IzK+6fKV8CMUs2G98=;
  b=GJj8ydOqiv9h93YUE058U905vzc/TEtUa5FzrDJyrsUxbQO+VvTd7GjI
   LO6WE7GsEwQ0aaMlTTKJwwFmagA/DHod86UX9N5ahSM5yMrzf+JRqexK5
   4ocSELZgAZVko7DTYMAviTvij7xC5pqhLx+6sdelDsTbzz3rdB3lGDfUh
   SIouRe6EYkTKznApT809ASuPGVFm9xJ/aGs0EJkGJi5nUjb9EGNQBpAKO
   ENsmu/dg8fL46hnRo5t0/ty1sB8kQZTiyGnappDAnF/ltOdKwEci+7NVf
   QXpJvVqW8b3WhIdicMPAdrrIzLa7Sg4ICvFL1Hehq9jDJrebDjtIKkp0Z
   w==;
X-CSE-ConnectionGUID: MjiCXXBwSW6VTtZAGVxrMw==
X-CSE-MsgGUID: NCZN/i1jTNecwXeK7p91QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569958"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569958"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:49 -0700
X-CSE-ConnectionGUID: +O5bMFFVQDu4eEYaNG9Tjg==
X-CSE-MsgGUID: DH26/Eq3SjednDQ00h3PSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124310"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: use spec link id and not FW link id
Date: Tue, 22 Jul 2025 11:29:08 +0300
Message-Id: <20250722112718.3f12df0b4e83.I25ed77c2b87bde82a9153e2aa26e09b8a42f6ee3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
References: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
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


