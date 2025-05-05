Return-Path: <linux-wireless+bounces-22468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794FBAA9C13
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7676117E260
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4736B26FA76;
	Mon,  5 May 2025 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djqi3Xfw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49826F45F
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471438; cv=none; b=XXgkulZA2i+z22LszpPmlvwk4HDlxB7IdHfuIIgrBeYkyGTpT5MKfKbBcS35XQePSF7I1yNkuYg3uM1mUUNPs8H25xp4Csd37y6facNKLLlz5VYfgpjzWwVERar7MnS4EbUeKLwb6Wa5zciCuVrK2LQ4QpMU66lA0yx32ZrkPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471438; c=relaxed/simple;
	bh=mANmuShWGuyjhREm6DkeW3Zh2WpmiD2ipGWxv6CG+VY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHGkidRGRRYsQtVbWCv3Qf4ukPcCVzT9qYfsE6EU6ohIj8CzQc1DblBxfVEdkKgCcxeqdr6iciqEOY4drlImBxIXsvahKXOHfobKERRWQnS99Ta8QZL8+egk6AomTI6LR4v9lQvdTH/RvN9b6Amh5mvSlD2YE/BFGytZS9WACo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djqi3Xfw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471436; x=1778007436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mANmuShWGuyjhREm6DkeW3Zh2WpmiD2ipGWxv6CG+VY=;
  b=djqi3XfwgmyMQy1A+kBEGXFakdsOQ0ePh8AJXvevdwHuNCAyK8fhgbEB
   1UaBLc0NyDbbqH0Q4/UZa/ddvCPJUvOOyxXqVTBppyrv7N2v8G9UfzOZR
   D+cCrpUi0+gzpx4uzn8CWiOcbq3Hh9kXjxDcKt/7VtMUJMeQMmXdU5k9N
   9HzX8IBR7xBgkucMsbh1HrhFw0OOE6pfWrl9/TDtqhoK496Qnx8p836uG
   UESUUQMHJyqqWuWvd3OqS3Nrz6tx19waoE2UVXvsmttsBZcuSHl13tvVA
   hf1QgleRgYNqrddKJNnXPiLAbprNgxJsVww27w6rMsjx0OM71eQ3/jQ9u
   w==;
X-CSE-ConnectionGUID: 3OFnvQiARkCzjHAstUzhyw==
X-CSE-MsgGUID: w3HhprNESxS6/e4nnLDZnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359442"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359442"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:16 -0700
X-CSE-ConnectionGUID: GEXirHPrTqS8avIzT0Q/Ng==
X-CSE-MsgGUID: TPI1YHGRRcChndrpS2B2YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135697956"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: mld: add debugfs for using ptp clock time for monitor interface
Date: Mon,  5 May 2025 21:56:44 +0300
Message-Id: <20250505215513.fffe6718fbca.I75f034005851a2d0c8ba5b015b9fdcad8a7c550d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Add a debugfs option to use the ptp clock time for Rx device
timestamps on a monitor interface. This can be useful for e.g.
synchronizing multiple NICs or reporting the timestamp in the
system clock instead of the GP2.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c |  3 +++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h     |  2 ++
 drivers/net/wireless/intel/iwlwifi/mld/rx.c      | 14 +++++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 89d95e9b4f30..0c896b4dba65 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -546,6 +546,9 @@ iwl_mld_add_debugfs_files(struct iwl_mld *mld, struct dentry *debugfs_dir)
 #endif
 	MLD_DEBUGFS_ADD_FILE(inject_packet, debugfs_dir, 0200);
 
+	debugfs_create_bool("rx_ts_ptp", 0600, debugfs_dir,
+			    &mld->monitor.ptp_time);
+
 	/* Create a symlink with mac80211. It will be removed when mac80211
 	 * exits (before the opmode exits which removes the target.)
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 0e4cc90fb6fc..cdbfe77e73f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -116,6 +116,7 @@
  * @monitor.ampdu_toggle: the state of the previous packet to track A-MPDU
  * @monitor.cur_aid: current association id tracked by the sniffer
  * @monitor.cur_bssid: current bssid tracked by the sniffer
+ * @monitor.ptp_time: set the Rx mactime using the device's PTP clock time
  * @monitor.p80: primary channel position relative to he whole bandwidth, in
  * steps of 80 MHz
  * @fw_id_to_link_sta: maps a fw id of a sta to the corresponding
@@ -201,6 +202,7 @@ struct iwl_mld {
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 			__le16 cur_aid;
 			u8 cur_bssid[ETH_ALEN];
+			bool ptp_time;
 #endif
 		} monitor;
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index d95603e6ac78..a27cdb77e446 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1213,8 +1213,20 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, struct sk_buff *skb,
 		iwl_mld_rx_eht(mld, skb, phy_data, queue);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	if (unlikely(mld->monitor.on))
+	if (unlikely(mld->monitor.on)) {
 		iwl_mld_add_rtap_sniffer_config(mld, skb);
+
+		if (mld->monitor.ptp_time) {
+			u64 adj_time =
+			    iwl_mld_ptp_get_adj_time(mld,
+						     phy_data->gp2_on_air_rise *
+						     NSEC_PER_USEC);
+
+			rx_status->mactime = div64_u64(adj_time, NSEC_PER_USEC);
+			rx_status->flag |= RX_FLAG_MACTIME_IS_RTAP_TS64;
+			rx_status->flag &= ~RX_FLAG_MACTIME;
+		}
+	}
 #endif
 
 	if (format != RATE_MCS_MOD_TYPE_CCK && is_sgi)
-- 
2.34.1


