Return-Path: <linux-wireless+bounces-21989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73275A9ADB1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE63466A13
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3A143C69;
	Thu, 24 Apr 2025 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFBaWjOJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EAE27B50F
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498345; cv=none; b=kReH8hJL4U97QxW1OoXchQxijP6WEJu7oM49aRyCjFUQtmODxhCbE+VyCSGjVim8snIxuRm6mbiAsutvivWCrJcE88XjKzsHikPJOVshR53d0IuR/AxdevO67WmFDF7lkJll1tqB/LACL1v6lG1oZ2ef1VOI15CXfIGEStK5+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498345; c=relaxed/simple;
	bh=P8ZyrSFC5VaHD7aMrfocJ2J6MpWYpIimGitEkE6E/N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqBPtF1naNu+QZHJKlLnJncGe+AZOka6NvEvoSCEb9x5xTKLi611HTIwhvkiYzxLUQKc2+bhe17en+Vh6nrnPsf4gXUj3XxMpHbe/0JBJ+ce/udmTwQBhFLWZI15RCR1Qr1HScE3qQPI0rcZ/JdAr6FEoMF5lCQFMl9aCsItuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFBaWjOJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498344; x=1777034344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P8ZyrSFC5VaHD7aMrfocJ2J6MpWYpIimGitEkE6E/N4=;
  b=mFBaWjOJ8jtxJP1pBQkq3gfdXhveCRmcxDX2GYbggjfw0zinXWAv63NQ
   ocs5+a5NME/ZBrIxdhESpn/b8X+N2vFHgdzu5EpFAqp8DoWMFOoYK5SnR
   QEbfEYfpdZ09Bov76O/Ssyw/GjKUNl8K0lB+KlJwVTSzeWXTlSKVeLEef
   XHR0/5hXG5CV4EH/DptzDCquQYsPZnLighBfFFuQBBUPW7Tk77HqlvOUF
   JpU66L1zJj62psKVfvaSEIhD+pdzyKi2QcWWygkKNaQl0lKMi87M7IjOO
   BjptfiPMvrOegaHpja0UMIkAIQx1whq/s7JOHDi5v6wV56aGuODcqqj6M
   g==;
X-CSE-ConnectionGUID: eGpW1x1KRpGN7Q2VoJrL/A==
X-CSE-MsgGUID: OVHe7FLEQ9qnPci07X+M5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302435"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302435"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:39:03 -0700
X-CSE-ConnectionGUID: PVkUoo28TwGZis197IUcuQ==
X-CSE-MsgGUID: YwkKF6ByQTiUPeHI350Kjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137449"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:39:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 10/14] wifi: iwlwifi: mld: simplify iwl_mld_rx_fill_status()
Date: Thu, 24 Apr 2025 15:38:27 +0300
Message-Id: <20250424153620.77010d6a6694.I2fd06b073460717d324245482110cb0381218526@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Move some code that's only done when having received data out
of iwl_mld_rx_fill_status() and remove the two arguments that
are related to that. This simplifies the function for the no-
data case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c | 69 ++++++++++-----------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index ef366b7a20d1..3e69f2a4fa81 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1160,8 +1160,6 @@ static void iwl_mld_add_rtap_sniffer_config(struct iwl_mld *mld,
 
 static void iwl_mld_rx_fill_status(struct iwl_mld *mld, struct sk_buff *skb,
 				   struct iwl_mld_rx_phy_data *phy_data,
-				   struct iwl_rx_mpdu_desc *mpdu_desc,
-				   struct ieee80211_hdr *hdr,
 				   int queue)
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
@@ -1170,44 +1168,12 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, struct sk_buff *skb,
 	u8 stbc = u32_get_bits(rate_n_flags, RATE_MCS_STBC_MSK);
 	bool is_sgi = rate_n_flags & RATE_MCS_SGI_MSK;
 
-	if (WARN_ON_ONCE(phy_data->with_data && (!mpdu_desc || !hdr)))
-		return;
-
-	/* Keep packets with CRC errors (and with overrun) for monitor mode
-	 * (otherwise the firmware discards them) but mark them as bad.
-	 */
-	if (phy_data->with_data &&
-	    (!(mpdu_desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_CRC_OK)) ||
-	     !(mpdu_desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_OVERRUN_OK)))) {
-		IWL_DEBUG_RX(mld, "Bad CRC or FIFO: 0x%08X.\n",
-			     le32_to_cpu(mpdu_desc->status));
-		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-	}
-
 	phy_data->info_type = IWL_RX_PHY_INFO_TYPE_NONE;
 
-	if (phy_data->with_data &&
-	    likely(!(phy_data->phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD))) {
-		rx_status->mactime =
-			le64_to_cpu(mpdu_desc->v3.tsf_on_air_rise);
-
-		/* TSF as indicated by the firmware is at INA time */
-		rx_status->flag |= RX_FLAG_MACTIME_PLCP_START;
-	} else {
+	if (phy_data->phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
 		phy_data->info_type =
 			le32_get_bits(phy_data->data1,
 				      IWL_RX_PHY_DATA1_INFO_TYPE_MASK);
-	}
-
-	/* management stuff on default queue */
-	if (!queue && phy_data->with_data &&
-	    unlikely(ieee80211_is_beacon(hdr->frame_control) ||
-		     ieee80211_is_probe_resp(hdr->frame_control))) {
-		rx_status->boottime_ns = ktime_get_boottime_ns();
-
-		if (mld->scan.pass_all_sched_res == SCHED_SCAN_PASS_ALL_STATE_ENABLED)
-			mld->scan.pass_all_sched_res = SCHED_SCAN_PASS_ALL_STATE_FOUND;
-	}
 
 	/* set the preamble flag if appropriate */
 	if (format == RATE_MCS_CCK_MSK &&
@@ -1812,7 +1778,36 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 	if (!queue && (phy_data.phy_info & IWL_RX_MPDU_PHY_AMPDU))
 		iwl_mld_rx_update_ampdu_ref(mld, &phy_data, rx_status);
 
-	iwl_mld_rx_fill_status(mld, skb, &phy_data, mpdu_desc, hdr, queue);
+	/* Keep packets with CRC errors (and with overrun) for monitor mode
+	 * (otherwise the firmware discards them) but mark them as bad.
+	 */
+	if (!(mpdu_desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_CRC_OK)) ||
+	    !(mpdu_desc->status & cpu_to_le32(IWL_RX_MPDU_STATUS_OVERRUN_OK))) {
+		IWL_DEBUG_RX(mld, "Bad CRC or FIFO: 0x%08X.\n",
+			     le32_to_cpu(mpdu_desc->status));
+		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
+	}
+
+	if (likely(!(phy_data.phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD))) {
+		rx_status->mactime =
+			le64_to_cpu(mpdu_desc->v3.tsf_on_air_rise);
+
+		/* TSF as indicated by the firmware is at INA time */
+		rx_status->flag |= RX_FLAG_MACTIME_PLCP_START;
+	}
+
+	/* management stuff on default queue */
+	if (!queue && unlikely(ieee80211_is_beacon(hdr->frame_control) ||
+			       ieee80211_is_probe_resp(hdr->frame_control))) {
+		rx_status->boottime_ns = ktime_get_boottime_ns();
+
+		if (mld->scan.pass_all_sched_res ==
+				SCHED_SCAN_PASS_ALL_STATE_ENABLED)
+			mld->scan.pass_all_sched_res =
+				SCHED_SCAN_PASS_ALL_STATE_FOUND;
+	}
+
+	iwl_mld_rx_fill_status(mld, skb, &phy_data, queue);
 
 	if (iwl_mld_rx_crypto(mld, sta, hdr, rx_status, mpdu_desc, queue,
 			      le32_to_cpu(pkt->len_n_flags), &crypto_len))
@@ -2024,7 +2019,7 @@ void iwl_mld_rx_monitor_no_data(struct iwl_mld *mld, struct napi_struct *napi,
 	rx_status->freq = ieee80211_channel_to_frequency(channel,
 							 rx_status->band);
 
-	iwl_mld_rx_fill_status(mld, skb, &phy_data, NULL, NULL, queue);
+	iwl_mld_rx_fill_status(mld, skb, &phy_data, queue);
 
 	/* No more radiotap info should be added after this point.
 	 * Mark it as mac header for upper layers to know where
-- 
2.34.1


