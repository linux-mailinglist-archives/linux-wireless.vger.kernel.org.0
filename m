Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ABA7368BD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjFTKFD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjFTKEh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEFE1717
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255476; x=1718791476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HQiXLMDZo58yFwu6FvNYxXsLFQtezWfDWtVVc7n+RBU=;
  b=WHNaPVyLKpzoMI8DaTShxpB0sfctpagAeJBy9voURccZZLaC/iNRLvry
   vkQfQ2uqgIqlyoLKj9VOlPLD/tOar2ZN7WLO/rMgv0GZ4+V6YsB0QfDOE
   u2l9cDAbHHHePj1dck4+Yj6xX3+A9REVB4ixTLWqE5qak0A484wUSmQu0
   DrP6KlAJrEWJ6mVKv57SJzaIIRGj9QK6P/TYrYqWyEHEeMQ7bqHI7BLIu
   XwLrIk6TLhJkcXqLf6jTufUcRTODl0q/Uig0V0CTJUyI6hywKL8qzBULU
   /csjTxVnB4sQ7zVDbVH9xzlwS4Kk/03H2QGalWrnRmPncOMzzfRWdrkCo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819592"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819592"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143290"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143290"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/19] wifi: iwlwifi: mvm: use EHT maximum MPDU length on 2.4 GHz
Date:   Tue, 20 Jun 2023 13:03:53 +0300
Message-Id: <20230620125813.fd5322bb48a4.Ic471045f83229ceaacce25edcf992d3ce2c75de5@changeid>
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

On 2.4 GHz there's no VHT, so EHT defines its own bits for
the maximum MPDU length. Use them when telling firmware
about the maximum.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 2382725f25bd..6cba8a353b53 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -523,6 +523,7 @@ u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta,
 {
 	const struct ieee80211_sta_vht_cap *vht_cap = &link_sta->vht_cap;
 	const struct ieee80211_sta_ht_cap *ht_cap = &link_sta->ht_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap = &link_sta->eht_cap;
 
 	if (WARN_ON_ONCE(!link_conf->chandef.chan))
 		return IEEE80211_MAX_MPDU_LEN_VHT_3895;
@@ -537,8 +538,18 @@ u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta,
 		default:
 			return IEEE80211_MAX_MPDU_LEN_VHT_3895;
 		}
-	} else
-	if (vht_cap->vht_supported) {
+	} else if (link_conf->chandef.chan->band == NL80211_BAND_2GHZ &&
+		   eht_cap->has_eht) {
+		switch (u8_get_bits(eht_cap->eht_cap_elem.mac_cap_info[0],
+				    IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK)) {
+		case IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454:
+			return IEEE80211_MAX_MPDU_LEN_VHT_11454;
+		case IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_7991:
+			return IEEE80211_MAX_MPDU_LEN_VHT_7991;
+		default:
+			return IEEE80211_MAX_MPDU_LEN_VHT_3895;
+		}
+	} else if (vht_cap->vht_supported) {
 		switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
 		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
 			return IEEE80211_MAX_MPDU_LEN_VHT_11454;
-- 
2.38.1

