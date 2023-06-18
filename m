Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89567347CC
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjFRSvH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjFRSvG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:51:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDF61A4
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114258; x=1718650258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eXntbchZ94gh7ck44kgxoUP3xbVd93iVE4bdS7+Otn0=;
  b=bjUWpGj22XJHCGhFX8ZpAyHd1tnKwkLEaQwkGuTzJ3U1Deb8tFQbOWiD
   yX5Htl9tYV4gKWLquSvBn40vWM8tUCAMwmUQ5AlLauxbSGLkZM61ylrky
   RwEMQTTRABcb4mtUSLDkgzrSHFZp/F8Jnamc/otYdO+j0DuvJnADzMkz7
   Gj5lQaDdtx3caU+7K1UtMRg+qBKUttjaHWEhTEFW2aNRDdTRLea4ZTgQX
   JtnYAKz24bpit9ej+U7wsHiS6JToLEmi8eIxh7FR1gTRqEKX/jBArTeoT
   FhRCNNm2JNOEggSKKu/ZSOsvTU+p7WpjeIQp+d2xzKx/J9x6UEuHwweHi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116672"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116672"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:58 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747234090"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747234090"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/20] wifi: update multi-link element STA reconfig
Date:   Sun, 18 Jun 2023 21:49:59 +0300
Message-Id: <20230618214436.2e1383b31f07.I8055a111c8fcf22e833e60f5587a4d8d21caca5b@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Update the MLE STA reconfig sub-type to 802.11be D3.0
format, which includes the operation update field.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 8 ++++++--
 net/mac80211/mlme.c       | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index fc3c26f1b718..d2025c986b0f 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4893,7 +4893,9 @@ static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
 #define IEEE80211_MLE_STA_RECONF_CONTROL_LINK_ID			0x000f
 #define IEEE80211_MLE_STA_RECONF_CONTROL_COMPLETE_PROFILE		0x0010
 #define IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT		0x0020
-#define IEEE80211_MLE_STA_RECONF_CONTROL_DELETE_TIMER_PRESENT		0x0040
+#define IEEE80211_MLE_STA_RECONF_CONTROL_AP_REM_TIMER_PRESENT		0x0040
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_UPDATE_TYPE		0x0780
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_PARAMS_PRESENT	0x0800
 
 /**
  * ieee80211_mle_reconf_sta_prof_size_ok - validate reconfiguration multi-link
@@ -4916,7 +4918,9 @@ static inline bool ieee80211_mle_reconf_sta_prof_size_ok(const u8 *data,
 
 	if (control & IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT)
 		info_len += ETH_ALEN;
-	if (control & IEEE80211_MLE_STA_RECONF_CONTROL_DELETE_TIMER_PRESENT)
+	if (control & IEEE80211_MLE_STA_RECONF_CONTROL_AP_REM_TIMER_PRESENT)
+		info_len += 2;
+	if (control & IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_PARAMS_PRESENT)
 		info_len += 2;
 
 	return prof->sta_info_len >= info_len &&
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f0fa1f0991ed..06ba809f83a1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5723,7 +5723,7 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 		 * is not present assume immediate removal.
 		 */
 		if (control &
-		    IEEE80211_MLE_STA_RECONF_CONTROL_DELETE_TIMER_PRESENT)
+		    IEEE80211_MLE_STA_RECONF_CONTROL_AP_REM_TIMER_PRESENT)
 			link_removal_timeout[link_id] = le16_to_cpu(*(__le16 *)pos);
 	}
 
-- 
2.38.1

