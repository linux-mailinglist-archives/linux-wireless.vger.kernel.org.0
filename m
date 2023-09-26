Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219EE7AE770
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 10:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjIZIIA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 04:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjIZIH6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 04:07:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7557210C
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715671; x=1727251671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7FAmHchlOBSa7LDqMVxlZ+YguQ7gFX3zExrEw967Er4=;
  b=YXI8FS2PuNZc0YUg+2SiXO/Lbb7cmv/T71LLGsg0T35FFZm9AaPZERju
   vsqpNNUA+T0vQmiygh8br4xdcQPkvP6OrvTYbxi33wTn4lkCVtSbWUMd2
   idwxvYEEDARRJtshIPiohFOs9jzuFF+bK6/nlkI06gJbC2aNmDm0AUb06
   GoOdeA6ZklISNxx+KdKftVOqtdg/T/w3SoInRIvFxGCpTiMtaWGQpU9yk
   AbDWTL21rqHhnKfkFR2IWXPi9fq6oCTYFET4YzVxDYzANEszFq39m0kjt
   0BiqW+I7XJiQeknij/gF+Ci56aldBBNghQXugxTwqvlFy9LABXbkG72KP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467797279"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467797279"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698369322"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698369322"
Received: from nbenitzh-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.250])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:07:49 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 7/9] wifi: iwlwifi: mvm: offload IGTK in AP if BIGTK is supported
Date:   Tue, 26 Sep 2023 11:07:19 +0300
Message-Id: <20230926110319.425ebc1ce484.If485ec962636c23d463b678e7da86e11b6fa86c9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926080721.876640-1-gregory.greenman@intel.com>
References: <20230926080721.876640-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We can't really know easily if a BIGTK will be used, but
in case firmware supports BIGTK it also supports the very
easy IGTK use (nothing to do on the host), and requires
that we program both IGTK and BIGTK to be able to use the
BIGTK. Thus, change the condition here to set the keys in
firmware (both IGTK/BIGTK) if BIGTK is supported.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f9a4168e3e1a..d342a53a8c46 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4185,12 +4185,21 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 			 * GTK on AP interface is a TX-only key, return 0;
 			 * on IBSS they're per-station and because we're lazy
 			 * we don't support them for RX, so do the same.
-			 * CMAC/GMAC in AP/IBSS modes must be done in software.
+			 * CMAC/GMAC in AP/IBSS modes must be done in software
+			 * on older NICs.
 			 *
 			 * Except, of course, beacon protection - it must be
-			 * offloaded since we just set a beacon template.
+			 * offloaded since we just set a beacon template, and
+			 * then we must also offload the IGTK (not just BIGTK)
+			 * for firmware reasons.
+			 *
+			 * So just check for beacon protection - if we don't
+			 * have it we cannot get here with keyidx >= 6, and
+			 * if we do have it we need to send the key to FW in
+			 * all cases (CMAC/GMAC).
 			 */
-			if (keyidx < 6 &&
+			if (!wiphy_ext_feature_isset(hw->wiphy,
+						     NL80211_EXT_FEATURE_BEACON_PROTECTION) &&
 			    (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
 			     key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
 			     key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256)) {
-- 
2.38.1

