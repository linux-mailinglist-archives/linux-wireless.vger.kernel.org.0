Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ABC6E2083
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDNKPz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNKPy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:15:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA37C9
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467331; x=1713003331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FKUnfwk1+G1Hpqy+mU/IuuaYA1CZIXQZ/DqgGqT5vEg=;
  b=j9bQ0T2cws/PjXY18UZR9NXsGUgC5xTfif3KjAmHuMp6s6tN2AlSapNl
   7xtWFH1jxr2moi17ztfNoOh2Y9RMPapOEUIBgzi8P8hD4gieTqkvLKQ4K
   DWp0tdKirWnnDES1c2X6FmO2EYTfgjnywk+BMrS92Qihiw0JVFdSJOkBt
   rdd+xdLJojpxKNkVx6wDQL3RfGSsNZfZ5kNcOV9XzMuFdDPtOkHUfFFHX
   FmwJJpu4clrKGYc9OnwMLJNnGuriYtj4Qb0e1eUsh+wVP2VeKm9XtSSaT
   ydlzbuj/ZfHWPDgQtgqvHK1q3QgMXqeRErQiPQLvLzmUeKc8ke6scLTRY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263688"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263688"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351820"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351820"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:44 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: validate station properly in flush
Date:   Fri, 14 Apr 2023 13:12:04 +0300
Message-Id: <20230414130637.7d747df44d65.Ie5392859fab4cfb73c20b49bfee2caadef5fd8ec@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we have MLO, then the deflink.ap_sta_id cannot be used.
However, we can use the new mvmvif->ap_sta pointer for the
validation instead.

Also don't do it multiple times for different FW instances
of the same AP STA (TDLS STAs are only on a single link).

Note that this isn't really working right yet since the
underlying flush code hasn't been updated yet to know of
multiple link STAs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 540d6e3e30d4..718b5ba6ec92 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5605,6 +5605,7 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct iwl_mvm_vif *mvmvif;
 	struct iwl_mvm_sta *mvmsta;
 	struct ieee80211_sta *sta;
+	bool ap_sta_done = false;
 	int i;
 	u32 msk = 0;
 
@@ -5633,8 +5634,14 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		if (mvmsta->vif != vif)
 			continue;
 
+		if (sta == mvmvif->ap_sta) {
+			if (ap_sta_done)
+				continue;
+			ap_sta_done = true;
+		}
+
 		/* make sure only TDLS peers or the AP are flushed */
-		WARN_ON_ONCE(i != mvmvif->deflink.ap_sta_id && !sta->tdls);
+		WARN_ON_ONCE(sta != mvmvif->ap_sta && !sta->tdls);
 
 		if (drop) {
 			if (iwl_mvm_flush_sta(mvm, mvmsta, false))
-- 
2.38.1

