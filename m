Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F3B735886
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjFSN13 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 09:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjFSN12 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 09:27:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D675AE62
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181243; x=1718717243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6rNblBFPCjMCNSaTl+wAvEW0duQ4B03BqCPI1K3GSIM=;
  b=ORqXiAP4Jr5xbnqc7VFbTxp0I/l7D8SDTghsUaUS6fUzkVtXvTMG4WV7
   UiM4mzElqpgPLg8BpYGD4Bz72srSl8xGM6reTIbGVGOACXlVdeR9zmnDp
   MFl0wKjAbcgiDcrDjBmShtti01ppITn8oO6dpVkoFTsIfYVldTRUJm00f
   t8fBeA2CVc81/r1Tgn4kR243/9fy1Lw2gjxT7Zx3CbS5BW0/lD5uechho
   b6nBQKEwg+XwQ1ilU1M85ANCfYCRCy2AJc4rtxXUUUpQUTErM7GkDPAeH
   dVZXXH0EKG7fsRDekSgvd53i7jNfhdNS4OF57T0ESSVYl5YydNbWj8EAY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339240704"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339240704"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="716871761"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716871761"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 8/9] wifi: cfg80211: Retrieve PSD information from RNR AP information
Date:   Mon, 19 Jun 2023 16:26:52 +0300
Message-Id: <20230619161906.067ded2b8fc3.I9f407ab5800cbb07045a0537a513012960ced740@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619132653.902084-1-gregory.greenman@intel.com>
References: <20230619132653.902084-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Retrieve the Power Spectral Density (PSD) value from RNR AP
information entry and store it so it could be used by the drivers.

PSD value is explained in Section 9.4.2.170 of Draft
P802.11Revme_D2.0.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h |  7 +++++--
 include/net/cfg80211.h    |  2 ++
 net/wireless/scan.c       | 13 +++++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 15c4e12b6fc7..6f1747a9c106 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4504,6 +4504,9 @@ static inline bool for_each_element_completed(const struct element *element,
 #define IEEE80211_RNR_TBTT_PARAMS_PROBE_ACTIVE			0x20
 #define IEEE80211_RNR_TBTT_PARAMS_COLOC_AP			0x40
 
+#define IEEE80211_RNR_TBTT_PARAMS_PSD_NO_LIMIT			127
+#define IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED			-128
+
 struct ieee80211_neighbor_ap_info {
 	u8 tbtt_info_hdr;
 	u8 tbtt_info_len;
@@ -4539,7 +4542,7 @@ struct ieee80211_tbtt_info_7_8_9 {
 
 	/* The following element is optional, structure may not grow */
 	u8 bss_params;
-	u8 psd_20;
+	s8 psd_20;
 } __packed;
 
 /* Format of the TBTT information element if it has >= 11 bytes */
@@ -4550,7 +4553,7 @@ struct ieee80211_tbtt_info_ge_11 {
 
 	/* The following elements are optional, structure may grow */
 	u8 bss_params;
-	u8 psd_20;
+	s8 psd_20;
 	struct ieee80211_rnr_mld_params mld_params;
 } __packed;
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9eba57d35e98..41c5248eb7f4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2466,6 +2466,7 @@ struct cfg80211_scan_info {
  * @short_ssid_valid: @short_ssid is valid and can be used
  * @psc_no_listen: when set, and the channel is a PSC channel, no need to wait
  *       20 TUs before starting to send probe requests.
+ * @psd_20: The AP's 20 MHz PSD value.
  */
 struct cfg80211_scan_6ghz_params {
 	u32 short_ssid;
@@ -2474,6 +2475,7 @@ struct cfg80211_scan_6ghz_params {
 	bool unsolicited_probe;
 	bool short_ssid_valid;
 	bool psc_no_listen;
+	s8 psd_20;
 };
 
 /**
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 465334b3960e..e38c51512f97 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -96,6 +96,7 @@ MODULE_PARM_DESC(bss_entries_limit,
  *	colocated and can be discovered via legacy bands.
  * @short_ssid_valid: short_ssid is valid and can be used
  * @short_ssid: the short SSID for this SSID
+ * @psd_20: The 20MHz PSD EIRP of the primary 20MHz channel for the reported AP
  */
 struct cfg80211_colocated_ap {
 	struct list_head list;
@@ -111,6 +112,7 @@ struct cfg80211_colocated_ap {
 	   transmitted_bssid:1,
 	   colocated_ess:1,
 	   short_ssid_valid:1;
+	s8 psd_20;
 };
 
 static void bss_free(struct cfg80211_internal_bss *bss)
@@ -578,6 +580,8 @@ static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 {
 	u8 bss_params;
 
+	entry->psd_20 = IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED;
+
 	/* The length is already verified by the caller to contain bss_params */
 	if (length > sizeof(struct ieee80211_tbtt_info_7_8_9)) {
 		struct ieee80211_tbtt_info_ge_11 *tbtt_info = (void *)pos;
@@ -594,12 +598,20 @@ static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 					  IEEE80211_RNR_MLD_PARAMS_DISABLED_LINK))
 				return -EINVAL;
 		}
+
+		if (length >= offsetofend(struct ieee80211_tbtt_info_ge_11,
+					  psd_20))
+			entry->psd_20 = tbtt_info->psd_20;
 	} else {
 		struct ieee80211_tbtt_info_7_8_9 *tbtt_info = (void *)pos;
 
 		memcpy(entry->bssid, tbtt_info->bssid, ETH_ALEN);
 
 		bss_params = tbtt_info->bss_params;
+
+		if (length == offsetofend(struct ieee80211_tbtt_info_7_8_9,
+					  psd_20))
+			entry->psd_20 = tbtt_info->psd_20;
 	}
 
 	/* ignore entries with invalid BSSID */
@@ -904,6 +916,7 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		scan_6ghz_params->short_ssid = ap->short_ssid;
 		scan_6ghz_params->short_ssid_valid = ap->short_ssid_valid;
 		scan_6ghz_params->unsolicited_probe = ap->unsolicited_probe;
+		scan_6ghz_params->psd_20 = ap->psd_20;
 
 		/*
 		 * If a PSC channel is added to the scan and 'need_scan_psc' is
-- 
2.38.1

