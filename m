Return-Path: <linux-wireless+bounces-33951-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KLdBFkHxWnn5gQAu9opvQ
	(envelope-from <linux-wireless+bounces-33951-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:15:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D40893331DB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B485F305B67E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CF43BF671;
	Thu, 26 Mar 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4HHkoxA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A63BF676
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520112; cv=none; b=uN0Z/okbjwBmoIaTqb7qK8oxiAjnDsbAYQpIccIey+ElI82CxyuZNSA4JADTz30aCg9sX9wouSw6SbBbBQsgk/Dll/ox7cfObfPl047VNM3/0HjTtFN+IOI3hhXfzc/7yH+MZ+/y3bcfbyvSxgTud4vzXM+o1yhmSvwXrtEe/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520112; c=relaxed/simple;
	bh=HUbGiBOwG+0dMz5sLqcDV9Rr1OgA7v6ZnqnwrVWqoiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oElY/lkWMOhkNKLJ4Pd1MbHjMlkCiQtJFXoFOKw1DO7C/6xOKJj8JusWDfn3t690jZN7OC1tUhHnNicWTRW8ydxR5TJqmg5RaYLnmXcqR3jIOFr2p90ZhmYlsxtDMuuZvkhOECJ3P4CiwI4FZYd8ZBENT+YIm1ufLWnT+ZhOwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4HHkoxA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520111; x=1806056111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HUbGiBOwG+0dMz5sLqcDV9Rr1OgA7v6ZnqnwrVWqoiI=;
  b=Q4HHkoxAumV4UzWCCO6gnAvVim6XJGPKYdIwQMOimDkvFJFNbaXg9OXe
   UerkyrYo84d0JxtjCcRy4Fjxl24ooIYOe1avot77dV+1T03ouEhwlzedT
   wwfeu87AydIqCPMX79Qa+puqqOJHq46Lm8bC8mjS7F9dua3EiaVraiNlW
   smm1morQS2xiGSIdfTBHnVlrft3nn50CL8bfXzmhM2ZYgPieizeAQkshE
   gt+qfimPqrbGeWUSU2F9QZhR+SPhyZHGmJRmeVR5agOB8jceoGUiDWsAr
   yglwV5DZ6j3PUj9nAaikE8q4EtHX8amt7r7WkZh2+8utn9AmLMqRRCw9v
   A==;
X-CSE-ConnectionGUID: +jSJkQwyQgWckYDhzTrS2w==
X-CSE-MsgGUID: czRv02FxRfyf9dTnb9KEvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048560"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048560"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:09 -0700
X-CSE-ConnectionGUID: 7zpbl6S+SjO3Cp8bwYXfOQ==
X-CSE-MsgGUID: aWIVH/3mTO2bMUT8ue9oxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653176"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 wireless-next 03/15] wifi: mac80211: export ieee80211_calculate_rx_timestamp
Date: Thu, 26 Mar 2026 12:14:33 +0200
Message-Id: <20260326121156.a1abc9c52f37.Ieabfe66768b1bf64c3076d62e73c50794faeacdc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
References: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33951-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D40893331DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Benjamin Berg <benjamin.berg@intel.com>

The function is quite useful when handling beacon timestamps. Export it
so that it can be used by mac80211_hwsim and others.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h     | 18 ++++++++++++++++++
 net/mac80211/ibss.c        |  2 +-
 net/mac80211/ieee80211_i.h |  4 ----
 net/mac80211/mesh_sync.c   |  2 +-
 net/mac80211/rx.c          |  2 +-
 net/mac80211/scan.c        |  2 +-
 net/mac80211/util.c        | 18 +++---------------
 7 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 2959736efdf3..ff862d54eb77 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7393,6 +7393,24 @@ void ieee80211_disable_rssi_reports(struct ieee80211_vif *vif);
  */
 int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id);
 
+/**
+ * ieee80211_calculate_rx_timestamp - calculate timestamp in frame
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @status: RX status
+ * @mpdu_len: total MPDU length (including FCS)
+ * @mpdu_offset: offset into MPDU to calculate timestamp at
+ *
+ * This function calculates the RX timestamp at the given MPDU offset, taking
+ * into account what the RX timestamp was. An offset of 0 will just normalize
+ * the timestamp to TSF at beginning of MPDU reception.
+ *
+ * Returns: the calculated timestamp
+ */
+u64 ieee80211_calculate_rx_timestamp(struct ieee80211_hw *hw,
+				     struct ieee80211_rx_status *status,
+				     unsigned int mpdu_len,
+				     unsigned int mpdu_offset);
+
 /**
  * ieee80211_report_wowlan_wakeup - report WoWLAN wakeup
  * @vif: virtual interface
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 1e1ab25d9d8d..97292ff51475 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1127,7 +1127,7 @@ static void ieee80211_rx_bss_info(struct ieee80211_sub_if_data *sdata,
 	if (ieee80211_have_rx_timestamp(rx_status)) {
 		/* time when timestamp field was received */
 		rx_timestamp =
-			ieee80211_calculate_rx_timestamp(local, rx_status,
+			ieee80211_calculate_rx_timestamp(&local->hw, rx_status,
 							 len + FCS_LEN, 24);
 	} else {
 		/*
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index bacb49ad2817..53d783769642 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1922,10 +1922,6 @@ ieee80211_vif_get_num_mcast_if(struct ieee80211_sub_if_data *sdata)
 	return -1;
 }
 
-u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
-				     struct ieee80211_rx_status *status,
-				     unsigned int mpdu_len,
-				     unsigned int mpdu_offset);
 int ieee80211_hw_config(struct ieee80211_local *local, int radio_idx,
 			u32 changed);
 int ieee80211_hw_conf_chan(struct ieee80211_local *local);
diff --git a/net/mac80211/mesh_sync.c b/net/mac80211/mesh_sync.c
index 3a66b4cefca7..24a68eef7db8 100644
--- a/net/mac80211/mesh_sync.c
+++ b/net/mac80211/mesh_sync.c
@@ -103,7 +103,7 @@ mesh_sync_offset_rx_bcn_presp(struct ieee80211_sub_if_data *sdata, u16 stype,
 	 * section.
 	 */
 	if (ieee80211_have_rx_timestamp(rx_status))
-		t_r = ieee80211_calculate_rx_timestamp(local, rx_status,
+		t_r = ieee80211_calculate_rx_timestamp(&local->hw, rx_status,
 						       len + FCS_LEN, 24);
 	else
 		t_r = drv_get_tsf(local, sdata);
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index d9a654ef082d..dbdd67c181d8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -404,7 +404,7 @@ ieee80211_add_rx_radiotap_header(struct ieee80211_local *local,
 		while ((pos - (u8 *)rthdr) & 7)
 			*pos++ = 0;
 		put_unaligned_le64(
-			ieee80211_calculate_rx_timestamp(local, status,
+			ieee80211_calculate_rx_timestamp(&local->hw, status,
 							 mpdulen, 0),
 			pos);
 		rthdr->it_present |= cpu_to_le32(BIT(IEEE80211_RADIOTAP_TSFT));
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 4823c8d45639..eeff230bd909 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -216,7 +216,7 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 
 		if (link_conf) {
 			bss_meta.parent_tsf =
-				ieee80211_calculate_rx_timestamp(local,
+				ieee80211_calculate_rx_timestamp(&local->hw,
 								 rx_status,
 								 len + FCS_LEN,
 								 24);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 72e73f4f79c5..38b0c42c4c13 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3423,20 +3423,7 @@ u8 ieee80211_mcs_to_chains(const struct ieee80211_mcs_info *mcs)
 	return 1;
 }
 
-/**
- * ieee80211_calculate_rx_timestamp - calculate timestamp in frame
- * @local: mac80211 hw info struct
- * @status: RX status
- * @mpdu_len: total MPDU length (including FCS)
- * @mpdu_offset: offset into MPDU to calculate timestamp at
- *
- * This function calculates the RX timestamp at the given MPDU offset, taking
- * into account what the RX timestamp was. An offset of 0 will just normalize
- * the timestamp to TSF at beginning of MPDU reception.
- *
- * Returns: the calculated timestamp
- */
-u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
+u64 ieee80211_calculate_rx_timestamp(struct ieee80211_hw *hw,
 				     struct ieee80211_rx_status *status,
 				     unsigned int mpdu_len,
 				     unsigned int mpdu_offset)
@@ -3555,7 +3542,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 	case RX_ENC_LEGACY: {
 		struct ieee80211_supported_band *sband;
 
-		sband = local->hw.wiphy->bands[status->band];
+		sband = hw->wiphy->bands[status->band];
 		ri.legacy = sband->bitrates[status->rate_idx].bitrate;
 
 		if (mactime_plcp_start) {
@@ -3587,6 +3574,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 
 	return ts;
 }
+EXPORT_SYMBOL_GPL(ieee80211_calculate_rx_timestamp);
 
 /* Cancel CAC for the interfaces under the specified @local. If @ctx is
  * also provided, only the interfaces using that ctx will be canceled.
-- 
2.34.1


