Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69AD7B7C50
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbjJDJhT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242035AbjJDJhQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B214DE1
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412233; x=1727948233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4JSUbuzSmIB2t05okfVvOne7mVv8yBp59LY+RunpIF4=;
  b=JhPGXA0E3bWDWaL6gN3HIwZ33EDb/d6+VNFT509vuJZs4I4anSYcp2aB
   WvRrLafGiaRVGMjUgq+51d7iaAxn9n5/Icyo2+uU2+kR7cJr8g2mlrMSS
   OcV3vLSja4rnOvKUsrIhtAgSmDpi8A+gEMQEqFVEtByjc3ZBcbwIZ7/1z
   zrfna3AVYpAAwc0BZ0aW8l0ADErAFWbdtNb4lLXShBo8GYqSPMQQQcu++
   uQ/YAHZ8rY+viD7CR6caUHpNk59SHAgvzIltea7uc456iCbyvma4U6Zt4
   cXpW7FcjAQEjTzNxAfPBf2uV7DMuMbtQgANxBH7L4nVp77stM4hcOE0xL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611873"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611873"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415196"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415196"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:37:11 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ayala Beker <ayala.beker@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: advertise support for SCS traffic description
Date:   Wed,  4 Oct 2023 12:36:31 +0300
Message-Id: <20231004123422.cc15de23b07b.I35fa1fbacf113b87ba7a13c37760f893eb57643a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Beker <ayala.beker@intel.com>

This doesn't require any special implementation from our device, just
allows transmission of SCS request frame containing a QoS
characteristics sub element.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 512af3605a2c..6015e1255d2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -671,7 +671,8 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
 					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
-					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2,
+					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2 |
+					IEEE80211_EHT_MAC_CAP0_SCS_TRAFFIC_DESC,
 				.phy_cap_info[0] =
 					IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ |
 					IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
-- 
2.38.1

