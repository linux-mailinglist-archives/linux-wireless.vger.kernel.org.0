Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D31789D27
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjH0LGh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjH0LGQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:06:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1C0109
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134374; x=1724670374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kL8Ogp+A8HWMXAf4b4oBK6TLktgvUAS8VtguVS/qzj8=;
  b=G+KYVOv5ERsGLSQxtBCOrrWLWENQ0wmAnBpDK8N3qMkyaQhHQYPgrhBh
   yZadejiPPRMHedWCfKf+V+TFHDWMSGPimdhPc1pt0jXJf1cdiT+1qgwaZ
   aLWxk524F0SK0cA/JHsO3Ye9MeCNtTZkmPYSsk8+EFENKX+wyIE3qgoDV
   oIZrLOyysqLKJ2WWngutJxkbpdxPB7w4U/5o9XQUoPWdvJUmJsy70MUon
   V6wCO0jtzekyzQpnI0r7RKYJ+VoiPKFj+JaqIAgaiortVTWdrUSPSOuov
   aVXXUOVuxIVnq+ENEc79yDdtcEI/56l4SolcGzZIZ2axEX/fwSW/zuu08
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301581"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301581"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881633014"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: mac80211: take MBSSID/EHT data also from probe resp
Date:   Sun, 27 Aug 2023 14:05:30 +0300
Message-Id: <20230827135854.3c7e52d49482.Iba6b672f6dc74b45bba26bc497e953e27da43ef9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230827110532.348304-1-gregory.greenman@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The code that sets up the assoc link will currently take the BSS
element data from the beacon only. This is correct for some of
the data, notably the timing and the "have_beacon", but all the
data about MBSSID and EHT really doesn't need to be taken from
there, and if the EHT puncturing is misconfigured on the AP but
we didn't receive a beacon yet, this causes us to connect but
immediately disconnect upon receiving the first beacon, rather
than connecting without EHT in the first place.

Change the code to take MBSSID and EHT data also from the probe
response, for a better picture of what the BSS capabilities are
and to avoid that EHT puncturing problem.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a93fbed69a70..8abd4301f278 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7262,7 +7262,7 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 			   unsigned int link_id)
 {
 	struct ieee80211_local *local = sdata->local;
-	const struct cfg80211_bss_ies *beacon_ies;
+	const struct cfg80211_bss_ies *bss_ies;
 	struct ieee80211_supported_band *sband;
 	const struct element *ht_elem, *vht_elem;
 	struct ieee80211_link_data *link;
@@ -7337,32 +7337,37 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 	link->conf->eht_puncturing = 0;
 
 	rcu_read_lock();
-	beacon_ies = rcu_dereference(cbss->beacon_ies);
-	if (beacon_ies) {
-		const struct ieee80211_eht_operation *eht_oper;
-		const struct element *elem;
+	bss_ies = rcu_dereference(cbss->beacon_ies);
+	if (bss_ies) {
 		u8 dtim_count = 0;
 
-		ieee80211_get_dtim(beacon_ies, &dtim_count,
+		ieee80211_get_dtim(bss_ies, &dtim_count,
 				   &link->u.mgd.dtim_period);
 
 		sdata->deflink.u.mgd.have_beacon = true;
 
 		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
-			link->conf->sync_tsf = beacon_ies->tsf;
+			link->conf->sync_tsf = bss_ies->tsf;
 			link->conf->sync_device_ts = bss->device_ts_beacon;
 			link->conf->sync_dtim_count = dtim_count;
 		}
+	} else {
+		bss_ies = rcu_dereference(cbss->ies);
+	}
+
+	if (bss_ies) {
+		const struct ieee80211_eht_operation *eht_oper;
+		const struct element *elem;
 
 		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION,
-					      beacon_ies->data, beacon_ies->len);
+					      bss_ies->data, bss_ies->len);
 		if (elem && elem->datalen >= 3)
 			link->conf->profile_periodicity = elem->data[2];
 		else
 			link->conf->profile_periodicity = 0;
 
 		elem = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY,
-					  beacon_ies->data, beacon_ies->len);
+					  bss_ies->data, bss_ies->len);
 		if (elem && elem->datalen >= 11 &&
 		    (elem->data[10] & WLAN_EXT_CAPA11_EMA_SUPPORT))
 			link->conf->ema_ap = true;
@@ -7370,7 +7375,7 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 			link->conf->ema_ap = false;
 
 		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION,
-					      beacon_ies->data, beacon_ies->len);
+					      bss_ies->data, bss_ies->len);
 		eht_oper = (const void *)(elem->data + 1);
 
 		if (elem &&
-- 
2.38.1

