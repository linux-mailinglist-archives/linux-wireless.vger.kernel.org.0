Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4037347CE
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjFRSvQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFRSvP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:51:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D7E72
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114264; x=1718650264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0c2/wKWdYa0n3zzQ8JO5F+2h68IrTvIYwoOFtF9XiBU=;
  b=n9+jZXuv8mxfvBWBMdMO7q0YKxZ9t9+1m35N4Tq1TM8GcVepI1j95AcY
   XxnkKaRTA0Rsp5zmBVNn7MMmfnYlXUJ0ZeFTjxdOkoZqNUocn16frdPGo
   c+EvNg9FxsYQyeemKQ1HOIm60FOyu4cAvEeQGhwtBV59GSN2BHphSBbaa
   lOueE6/Vk1AU8IJAbQyPTppKJvZQ65P7faar+ZybHKO1dGsCkGLEVVv0t
   Zah3yXh1dMC9o8XIOPI1pWshwdB+QPUjL3NIOE45rM+YTyGSBFlesMxBc
   L4HMJfa3kcllpWvKMn7b04Ia23V/1xQ07slAoR9kONnuDTNaaE0olauJi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116677"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116677"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:51:03 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747234133"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747234133"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:51:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 19/20] wifi: cfg80211: search all RNR elements for colocated APs
Date:   Sun, 18 Jun 2023 21:50:01 +0300
Message-Id: <20230618214436.ffe2c014f478.I372a4f96c88f7ea28ac39e94e0abfc465b5330d4@changeid>
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

An AP reporting colocated APs may send more than one reduced neighbor
report element. As such, iterate all elements instead of only parsing
the first one when looking for colocated APs.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 127 ++++++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 64 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index b2cf7abd5ad0..465334b3960e 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -643,90 +643,89 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 	int n_coloc = 0, ret;
 	LIST_HEAD(ap_list);
 
-	elem = cfg80211_find_elem(WLAN_EID_REDUCED_NEIGHBOR_REPORT, ies->data,
-				  ies->len);
-	if (!elem)
-		return 0;
-
-	pos = elem->data;
-	end = pos + elem->datalen;
-
 	ret = cfg80211_calc_short_ssid(ies, &ssid_elem, &s_ssid_tmp);
 	if (ret)
 		return ret;
 
-	/* RNR IE may contain more than one NEIGHBOR_AP_INFO */
-	while (pos + sizeof(*ap_info) <= end) {
-		enum nl80211_band band;
-		int freq;
-		u8 length, i, count;
+	for_each_element_id(elem, WLAN_EID_REDUCED_NEIGHBOR_REPORT,
+			    ies->data, ies->len) {
+		pos = elem->data;
+		end = elem->data + elem->datalen;
 
-		ap_info = (void *)pos;
-		count = u8_get_bits(ap_info->tbtt_info_hdr,
-				    IEEE80211_AP_INFO_TBTT_HDR_COUNT) + 1;
-		length = ap_info->tbtt_info_len;
+		/* RNR IE may contain more than one NEIGHBOR_AP_INFO */
+		while (pos + sizeof(*ap_info) <= end) {
+			enum nl80211_band band;
+			int freq;
+			u8 length, i, count;
 
-		pos += sizeof(*ap_info);
+			ap_info = (void *)pos;
+			count = u8_get_bits(ap_info->tbtt_info_hdr,
+					    IEEE80211_AP_INFO_TBTT_HDR_COUNT) + 1;
+			length = ap_info->tbtt_info_len;
 
-		if (!ieee80211_operating_class_to_band(ap_info->op_class,
-						       &band))
-			break;
+			pos += sizeof(*ap_info);
 
-		freq = ieee80211_channel_to_frequency(ap_info->channel, band);
+			if (!ieee80211_operating_class_to_band(ap_info->op_class,
+							       &band))
+				break;
 
-		if (end - pos < count * length)
-			break;
+			freq = ieee80211_channel_to_frequency(ap_info->channel,
+							      band);
 
-		if (u8_get_bits(ap_info->tbtt_info_hdr,
-				IEEE80211_AP_INFO_TBTT_HDR_TYPE) !=
-		    IEEE80211_TBTT_INFO_TYPE_TBTT) {
-			pos += count * length;
-			continue;
-		}
+			if (end - pos < count * length)
+				break;
 
-		/*
-		 * TBTT info must include bss param + BSSID +
-		 * (short SSID or same_ssid bit to be set).
-		 * ignore other options, and move to the
-		 * next AP info
-		 */
-		if (band != NL80211_BAND_6GHZ ||
-		    !(length == offsetofend(struct ieee80211_tbtt_info_7_8_9,
-					    bss_params) ||
-		      length == sizeof(struct ieee80211_tbtt_info_7_8_9) ||
-		      length >= offsetofend(struct ieee80211_tbtt_info_ge_11,
-					    bss_params))) {
-			pos += count * length;
-			continue;
-		}
+			if (u8_get_bits(ap_info->tbtt_info_hdr,
+					IEEE80211_AP_INFO_TBTT_HDR_TYPE) !=
+			    IEEE80211_TBTT_INFO_TYPE_TBTT) {
+				pos += count * length;
+				continue;
+			}
 
-		for (i = 0; i < count; i++) {
-			struct cfg80211_colocated_ap *entry;
+			/* TBTT info must include bss param + BSSID +
+			 * (short SSID or same_ssid bit to be set).
+			 * ignore other options, and move to the
+			 * next AP info
+			 */
+			if (band != NL80211_BAND_6GHZ ||
+			    !(length == offsetofend(struct ieee80211_tbtt_info_7_8_9,
+						    bss_params) ||
+			      length == sizeof(struct ieee80211_tbtt_info_7_8_9) ||
+			      length >= offsetofend(struct ieee80211_tbtt_info_ge_11,
+						    bss_params))) {
+				pos += count * length;
+				continue;
+			}
 
-			entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN,
-					GFP_ATOMIC);
+			for (i = 0; i < count; i++) {
+				struct cfg80211_colocated_ap *entry;
 
-			if (!entry)
-				goto error;
+				entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN,
+						GFP_ATOMIC);
 
-			entry->center_freq = freq;
+				if (!entry)
+					goto error;
 
-			if (!cfg80211_parse_ap_info(entry, pos, length,
-						    ssid_elem, s_ssid_tmp)) {
-				n_coloc++;
-				list_add_tail(&entry->list, &ap_list);
-			} else {
-				kfree(entry);
-			}
+				entry->center_freq = freq;
+
+				if (!cfg80211_parse_ap_info(entry, pos, length,
+							    ssid_elem,
+							    s_ssid_tmp)) {
+					n_coloc++;
+					list_add_tail(&entry->list, &ap_list);
+				} else {
+					kfree(entry);
+				}
 
-			pos += length;
+				pos += length;
+			}
 		}
-	}
 
 error:
-	if (pos != end) {
-		cfg80211_free_coloc_ap_list(&ap_list);
-		return 0;
+		if (pos != end) {
+			cfg80211_free_coloc_ap_list(&ap_list);
+			return 0;
+		}
 	}
 
 	list_splice_tail(&ap_list, list);
-- 
2.38.1

