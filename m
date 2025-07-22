Return-Path: <linux-wireless+bounces-25792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2CCB0D07A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683396C2185
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F4128A1E6;
	Tue, 22 Jul 2025 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nAcfABqJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD9A28C03A
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155728; cv=none; b=kTOwx7mPHa5KX4TFaTTuMJQXCc0vK88tpf+CbvD2wY7B0jg55ZWzPQWKsnFXoIH5Ccxc4PAzhDBThoLCjF32QyFZEFf87syzw9SNoyUX89Fxc9vovhUXrsFRt/3TRlJesfY2uhqcn4pMkS9JHhtgX4ZLPJyrStlPyLUnvaQiICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155728; c=relaxed/simple;
	bh=Fh/q9dgnT8yxNyF3GLPtFH1T00IzK+6fKV8CMUs2G98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tAlaF4+u5N/Ys/6DjWHV6lHtUfnfnvSfKipmWOPT/SB1YNsdq9sxJecohSc9Ct39TRw6tBQlEwA3Tee/ZbYQeCFXb3F7jHP42AjkJxPht3AHpbWLCHrobs7eeLYNuqhzc0ORy8RSdWsK4X+VpWtNV9ZtLPnMCQcDsaqLVIxyi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nAcfABqJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155726; x=1784691726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fh/q9dgnT8yxNyF3GLPtFH1T00IzK+6fKV8CMUs2G98=;
  b=nAcfABqJ3jhM4Ec2yrzFmEkaO8CGRgci/J5TQU7tcBnUYR8WUj11WNz0
   HdAFb/0G82nstyI3P9iLEKzqRdbshwDYRVaKIu5DEsXU04Y+QGxUzzum3
   cuGRxN0yZjMIbRjiPLJPzNQv+iPy8Z3ldFZxDIkKGjelPsCwbdwu4t9Hi
   4eELPKXpudM2dLNV8h9UgWXImKovxVSPH4liXkxIZvuECGBZ6DgMIvNf6
   39kgMGZnYg1yq0RsPaGOGW4PGf50R86RORV8ClGIi2IAQ5I5QthkJRjdq
   uq9KIXXJY9x0MFnJUpk90v7tCkfGt7IhQg9vh3fFDqlYrsXdzHThA047B
   w==;
X-CSE-ConnectionGUID: UecuX8PzRfOoTCbQIfAaQw==
X-CSE-MsgGUID: alJHWqXmSTWzI37vpmZm3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006169"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006169"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:42:06 -0700
X-CSE-ConnectionGUID: YzletXeITLyxrYp44TSiuw==
X-CSE-MsgGUID: TS+0fQkzSKK+4rZ+khBDrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338157"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:42:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: use spec link id and not FW link id
Date: Tue, 22 Jul 2025 06:41:23 +0300
Message-Id: <20250722063923.3f12df0b4e83.I25ed77c2b87bde82a9153e2aa26e09b8a42f6ee3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
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


