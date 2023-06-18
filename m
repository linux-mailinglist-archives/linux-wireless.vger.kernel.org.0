Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527247347C5
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFRSut (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFRSus (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF6C1A8
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114240; x=1718650240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sA63Ah4UkBQAjvYx+xSHIFl130dqcpFqGv8ViZR6ROM=;
  b=jDiBgkU1mUoGYMUhqNyOS/y8jA0CTIQ5Ik+nY8HdHrqXxeVK9ATqETeg
   Gr3I//Yv2vW1CvxzffDSTdBNBKK+LXJy/YhcTF2Ze8pyflUYhWGw2N31e
   coRI2P9BWVDTXJUNpfZK/xFROCF0S0toCYDIOLZq6JOJsClfC1I613taW
   mxmxo74OuxjfRLM2CCMjGlG9QCrle/8XF8/d0xQXGPFZ+2D1TjfcnX1vd
   iii4P+S7/KfLpf7UObfzqt/TVnu7FIXHfQsxuN8+D3cR/2mGKWKyYpt6E
   IUoix1iRu28CbXRzLw9OEz3XizNp7NFpGXu/obu9vPmQueNxHGfLXXP5E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116649"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116649"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:40 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233994"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233994"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/20] wifi: cfg80211: use structs for TBTT information access
Date:   Sun, 18 Jun 2023 21:49:52 +0300
Message-Id: <20230618214436.4c3f8901c1bc.Ic3e94fd6e1bccff7948a252ad3bb87e322690a17@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
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

From: Benjamin Berg <benjamin.berg@intel.com>

Make the data access a bit nicer overall by using structs. There is a
small change here to also accept a TBTT information length of eight
bytes as we do not require the 20 MHz PSD information.

This also fixes a bug reading the short SSID on big endian machines.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h |  3 --
 net/wireless/scan.c       | 61 +++++++++++++++++++++------------------
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 5a27c232afdb..e145af7448a3 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4483,9 +4483,6 @@ static inline bool for_each_element_completed(const struct element *element,
 #define IEEE80211_AP_INFO_TBTT_HDR_COUNT			0xF0
 #define IEEE80211_TBTT_INFO_TYPE_TBTT				0
 #define IEEE80211_TBTT_INFO_TYPE_MLD				1
-#define IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM		9
-#define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM	13
-#define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM_MLD_PARAM	16
 
 #define IEEE80211_RNR_TBTT_PARAMS_OCT_RECOMMENDED		0x01
 #define IEEE80211_RNR_TBTT_PARAMS_SAME_SSID			0x02
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 974a6a8240dd..f0b4d7671d17 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -574,39 +574,41 @@ static void cfg80211_free_coloc_ap_list(struct list_head *coloc_ap_list)
 static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 				  const u8 *pos, u8 length,
 				  const struct element *ssid_elem,
-				  int s_ssid_tmp)
+				  u32 s_ssid_tmp)
 {
-	/* skip the TBTT offset */
-	pos++;
+	u8 bss_params;
 
-	/* ignore entries with invalid BSSID */
-	if (!is_valid_ether_addr(pos))
-		return -EINVAL;
-
-	memcpy(entry->bssid, pos, ETH_ALEN);
-	pos += ETH_ALEN;
+	/* The length is already verified by the caller to contain bss_params */
+	if (length > sizeof(struct ieee80211_tbtt_info_7_8_9)) {
+		struct ieee80211_tbtt_info_ge_11 *tbtt_info = (void *)pos;
 
-	if (length >= IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM) {
-		memcpy(&entry->short_ssid, pos,
-		       sizeof(entry->short_ssid));
+		memcpy(entry->bssid, tbtt_info->bssid, ETH_ALEN);
+		entry->short_ssid = le32_to_cpu(tbtt_info->short_ssid);
 		entry->short_ssid_valid = true;
-		pos += 4;
+
+		bss_params = tbtt_info->bss_params;
+	} else {
+		struct ieee80211_tbtt_info_7_8_9 *tbtt_info = (void *)pos;
+
+		memcpy(entry->bssid, tbtt_info->bssid, ETH_ALEN);
+
+		bss_params = tbtt_info->bss_params;
 	}
 
+	/* ignore entries with invalid BSSID */
+	if (!is_valid_ether_addr(entry->bssid))
+		return -EINVAL;
+
 	/* skip non colocated APs */
-	if (!cfg80211_parse_bss_param(*pos, entry))
+	if (!cfg80211_parse_bss_param(bss_params, entry))
 		return -EINVAL;
-	pos++;
 
-	if (length == IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM) {
-		/*
-		 * no information about the short ssid. Consider the entry valid
-		 * for now. It would later be dropped in case there are explicit
-		 * SSIDs that need to be matched
-		 */
-		if (!entry->same_ssid)
-			return 0;
-	}
+	/* no information about the short ssid. Consider the entry valid
+	 * for now. It would later be dropped in case there are explicit
+	 * SSIDs that need to be matched
+	 */
+	if (!entry->same_ssid && !entry->short_ssid_valid)
+		return 0;
 
 	if (entry->same_ssid) {
 		entry->short_ssid = s_ssid_tmp;
@@ -617,10 +619,10 @@ static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 		 * cfg80211_parse_colocated_ap(), before calling this
 		 * function.
 		 */
-		memcpy(&entry->ssid, &ssid_elem->data,
-		       ssid_elem->datalen);
+		memcpy(&entry->ssid, &ssid_elem->data, ssid_elem->datalen);
 		entry->ssid_len = ssid_elem->datalen;
 	}
+
 	return 0;
 }
 
@@ -682,8 +684,11 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 		 * next AP info
 		 */
 		if (band != NL80211_BAND_6GHZ ||
-		    (length != IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM &&
-		     length < IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM)) {
+		    !(length == offsetofend(struct ieee80211_tbtt_info_7_8_9,
+					    bss_params) ||
+		      length == sizeof(struct ieee80211_tbtt_info_7_8_9) ||
+		      length >= offsetofend(struct ieee80211_tbtt_info_ge_11,
+					    bss_params))) {
 			pos += count * length;
 			continue;
 		}
-- 
2.38.1

