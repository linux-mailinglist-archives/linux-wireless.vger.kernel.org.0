Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C706CB8EC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjC1IAV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjC1IAR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01A0422C
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990416; x=1711526416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wgjx4x6TEXrGokpgewf9IwWMotMLl0ts0hkISymvFRY=;
  b=F8NYt+J8hXXOEmzdn5wnckUqF8Tg/Py9HVQlv61Lut6/JiATdlrChy3f
   +mju0J4C/5x0+5IF9vV8sNUaeozl4SqRXuxkKOSLbHH+QkPR0i4/Dg7p4
   VNNu+nsFaOLs+g2Jf+OghDx7QtDjoLRBqlcR1IQ/g2FeYALU62LaNGXIP
   Cpmvr8eXjBDBCGm6CvnlL/s9+CCY90Zv6GxfnL2kI+hrNO/NUrbf+6aKt
   fWR6OiB2vJKz/AqnVJd54b2IaJ15hFY5izU+Kj84Xs/L/UOACBX2M7Mfb
   Hhhl7GB7/uSih9L2sIcGY63Pb/jHgRxolXQcSNYDPglWs0d1XiJTKwQQS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958164"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958164"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045164"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045164"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:56 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/31] wifi: iwlwifi: mvm: adjust smart fifo configuration to MLO
Date:   Tue, 28 Mar 2023 10:58:56 +0300
Message-Id: <20230328104949.870ff175b82c.Iada56a474a0770ae5469b31d635cc05405dbfb87@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Consider properties of all available links for smart FIFO
configuration.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c | 32 +++++++++++++++++----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
index 84b750d02848..7c5f41e40e7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sf.c
@@ -98,6 +98,10 @@ static void iwl_mvm_fill_sf_command(struct iwl_mvm *mvm,
 				    struct ieee80211_sta *sta)
 {
 	int i, j, watermark;
+	u8 max_rx_nss = 0;
+	bool is_legacy = true;
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
 
 	sf_cmd->watermark[SF_LONG_DELAY_ON] = cpu_to_le32(SF_W_MARK_SCAN);
 
@@ -106,10 +110,25 @@ static void iwl_mvm_fill_sf_command(struct iwl_mvm *mvm,
 	 * capabilities of the AP station, and choose the watermark accordingly.
 	 */
 	if (sta) {
-		if (sta->deflink.ht_cap.ht_supported ||
-		    sta->deflink.vht_cap.vht_supported ||
-		    sta->deflink.he_cap.has_he) {
-			switch (sta->deflink.rx_nss) {
+		/* find the maximal NSS number among all links (if relevant) */
+		rcu_read_lock();
+		for (link_id = 0; link_id < ARRAY_SIZE(sta->link); link_id++) {
+			link_sta = rcu_dereference(sta->link[link_id]);
+			if (!link_sta)
+				continue;
+
+			if (link_sta->ht_cap.ht_supported ||
+			    link_sta->vht_cap.vht_supported ||
+			    link_sta->eht_cap.has_eht ||
+			    link_sta->he_cap.has_he) {
+				is_legacy = false;
+				max_rx_nss = max(max_rx_nss, link_sta->rx_nss);
+			}
+		}
+		rcu_read_unlock();
+
+		if (!is_legacy) {
+			switch (max_rx_nss) {
 			case 1:
 				watermark = SF_W_MARK_SISO;
 				break;
@@ -151,7 +170,6 @@ static void iwl_mvm_fill_sf_command(struct iwl_mvm *mvm,
 		memcpy(sf_cmd->full_on_timeouts, sf_full_timeout_def,
 		       sizeof(sf_full_timeout_def));
 	}
-
 }
 
 static int iwl_mvm_sf_config(struct iwl_mvm *mvm, u8 sta_id,
@@ -275,5 +293,9 @@ int iwl_mvm_sf_update(struct iwl_mvm *mvm, struct ieee80211_vif *changed_vif,
 		/* If there are multiple active macs - change to SF_UNINIT */
 		new_state = SF_UNINIT;
 	}
+
+	/* For MLO it's ok to use deflink->sta_id as it's needed only to get
+	 * a pointer to mac80211 sta
+	 */
 	return iwl_mvm_sf_config(mvm, sta_id, new_state);
 }
-- 
2.38.1

