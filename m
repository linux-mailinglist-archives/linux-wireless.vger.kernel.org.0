Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EED7368BF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjFTKFF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjFTKEo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B821730
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255481; x=1718791481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cpNX9bfm2ywftKdaNnGcY9N8S7wv/i3SDE6D9tI9M58=;
  b=oCxFCu92/n75R0OLvlAxcvxGJROfFnMA5TbUGaJU15yh933bMH5gTNB/
   IQAQOd/fzdIrRtRmwVN+CwBMb5rm8xVVJE5c48O9gOwAF4crsE2GEitrB
   rrlJhB/CC/EGJdmp0yqRNXCUPNuuqlYH+dFNlkK31eepCwZipRAWYmblT
   c1Ndze2NJh+VuYpHH6V6Nhw5OUgLwKahuHbAw5IBKc7ndvKwQMhWXuhxt
   SKJglj6t2x7kqeCVcAhsbJFY7pIobEbTKv1U1N5il5RKSoBMc9gTwatR9
   ZjAuHAPA5WjQRZxYkeq1STBpP2On04RrzRbrjeFtQNuWhQQEsiXII3vbU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819604"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819604"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143451"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143451"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/19] wifi: iwlwifi: mvm: add EHT A-MPDU size exponent support
Date:   Tue, 20 Jun 2023 13:03:55 +0300
Message-Id: <20230620125813.c5e00045d90f.I7520787fca8f8430a564adedf975d069ad8c5417@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add support for reading the EHT MAC capabilities A-MPDU
size exponent field, as indicated by the draft spec.

Also clarify the existing code a bit and add comments
so it's clearer to understand what's going on here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 27 +++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 3c24b25fe661..37a52ffa8897 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -60,22 +60,27 @@ u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_link_sta *link_sta,
 	if (WARN_ON(!link_sta))
 		return 0;
 
-	if (link_sta->ht_cap.ht_supported)
+	/* Note that we always use only legacy & highest supported PPDUs, so
+	 * of Draft P802.11be D.30 Table 10-12a--Fields used for calculating
+	 * the maximum A-MPDU size of various PPDU types in different bands,
+	 * we only need to worry about the highest supported PPDU type here.
+	 */
+
+	if (link_sta->ht_cap.ht_supported) {
+		agg_size = link_sta->ht_cap.ampdu_factor;
 		mpdu_dens = link_sta->ht_cap.ampdu_density;
+	}
 
-	if (link_conf->chandef.chan->band ==
-	    NL80211_BAND_6GHZ) {
+	if (link_conf->chandef.chan->band == NL80211_BAND_6GHZ) {
+		/* overwrite HT values on 6 GHz */
 		mpdu_dens = le16_get_bits(link_sta->he_6ghz_capa.capa,
 					  IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
 		agg_size = le16_get_bits(link_sta->he_6ghz_capa.capa,
 					 IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
 	} else if (link_sta->vht_cap.vht_supported) {
-		agg_size = link_sta->vht_cap.cap &
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
-		agg_size >>=
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
-	} else if (link_sta->ht_cap.ht_supported) {
-		agg_size = link_sta->ht_cap.ampdu_factor;
+		/* if VHT supported overwrite HT value */
+		agg_size = u32_get_bits(link_sta->vht_cap.cap,
+					IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK);
 	}
 
 	/* D6.0 10.12.2 A-MPDU length limit rules
@@ -91,6 +96,10 @@ u32 iwl_mvm_get_sta_ampdu_dens(struct ieee80211_link_sta *link_sta,
 			u8_get_bits(link_sta->he_cap.he_cap_elem.mac_cap_info[3],
 				    IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
 
+	if (link_sta->eht_cap.has_eht)
+		agg_size += u8_get_bits(link_sta->eht_cap.eht_cap_elem.mac_cap_info[1],
+					IEEE80211_EHT_MAC_CAP1_MAX_AMPDU_LEN_MASK);
+
 	/* Limit to max A-MPDU supported by FW */
 	agg_size = min_t(u32, agg_size,
 			 STA_FLG_MAX_AGG_SIZE_4M >> STA_FLG_MAX_AGG_SIZE_SHIFT);
-- 
2.38.1

