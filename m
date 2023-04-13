Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E11E6E080C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDMHpm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDMHpk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9653593D5
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371931; x=1712907931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCkkIZBDf8v5eafGLor7rOkXKVBimEWp+l7xHxgHK4Q=;
  b=O7Bdk1YF4wV4LK8/NqQ7lF6qWqifWlcGuY6hpDKuemiMaa0gBdX5jTtr
   etEaMH4XoArrwWd+erhw6OGU06pJaXmOCwpMcrxJZDFf52aobD3b6t0zR
   pHATTAIUKLHFNUG5to+IWRP0r/inmx7rZNyOnbXOZsrS5cOwHI1hhe2+7
   mDlaSGQP7h3mUbCSEJybcb8HhR9BinSGTU6CODtYYzVW9lyB9mXuf9Xg9
   /FFGTfjzWqXChXBtOxd+NZoDl2K9VDa+wMWtiJiLb9RiPMgi9f0FZdZ+8
   Jbu5Ecu4sqRBXUV/P8OyFxncZNKUrOxLqpnIw4/35n4KKkm75G7WxwXJk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323736068"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323736068"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034783"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034783"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Daniel Gabay <daniel.gabay@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: nvm: Update HE capabilities on 6GHz band for EHT device
Date:   Thu, 13 Apr 2023 10:44:10 +0300
Message-Id: <20230413102635.1eee32cfd199.I9c5ff3a6956d509137deca620814935149516fbc@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Daniel Gabay <daniel.gabay@intel.com>

Max A-MPDU length exponent shall be set to 2 for EHT capable
device on 6GHz band in order to support 4MB aggregation.

Update HE MAC capabilities accordingly for station and softap
interfaces.

This change requires to add another ieee80211_sband_iftype_data for
uhb since high/uhb are no longer the same.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h |  5 ++---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c    | 10 ++++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
index baa643386018..0e8ca761d24b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
@@ -47,13 +47,12 @@ struct iwl_nvm_data {
 	struct ieee80211_supported_band bands[NUM_NL80211_BANDS];
 
 	/*
-	 * iftype data for low (2.4 GHz) and high (5 and 6 GHz) bands,
-	 * we can use the same for 5 and 6 GHz bands because they have
-	 * the same data
+	 * iftype data for low (2.4 GHz) high (5 GHz) and uhb (6 GHz) bands
 	 */
 	struct {
 		struct ieee80211_sband_iftype_data low[2];
 		struct ieee80211_sband_iftype_data high[2];
+		struct ieee80211_sband_iftype_data uhb[2];
 	} iftd;
 
 	struct ieee80211_channel channels[];
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 449a1922a215..92a79df3e6d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -860,7 +860,10 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 	/* Advertise an A-MPDU exponent extension based on
 	 * operating band
 	 */
-	if (sband->band != NL80211_BAND_2GHZ)
+	if (sband->band == NL80211_BAND_6GHZ && iftype_data->eht_cap.has_eht)
+		iftype_data->he_cap.he_cap_elem.mac_cap_info[3] |=
+			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2;
+	else if (sband->band != NL80211_BAND_2GHZ)
 		iftype_data->he_cap.he_cap_elem.mac_cap_info[3] |=
 			IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_1;
 	else
@@ -996,15 +999,18 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 
 	BUILD_BUG_ON(sizeof(data->iftd.low) != sizeof(iwl_he_eht_capa));
 	BUILD_BUG_ON(sizeof(data->iftd.high) != sizeof(iwl_he_eht_capa));
+	BUILD_BUG_ON(sizeof(data->iftd.uhb) != sizeof(iwl_he_eht_capa));
 
 	switch (sband->band) {
 	case NL80211_BAND_2GHZ:
 		iftype_data = data->iftd.low;
 		break;
 	case NL80211_BAND_5GHZ:
-	case NL80211_BAND_6GHZ:
 		iftype_data = data->iftd.high;
 		break;
+	case NL80211_BAND_6GHZ:
+		iftype_data = data->iftd.uhb;
+		break;
 	default:
 		WARN_ON(1);
 		return;
-- 
2.38.1

