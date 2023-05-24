Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A417670FD0D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbjEXRq2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjEXRqU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:46:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0828CE65
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950353; x=1716486353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=defFKmQHJijjx896uzma6pxFWmuq76cuq0+gaKd3LjI=;
  b=huxNBWqZ0/qZvvjxYiSiRX3t8BqZmwmvVzVUY4z4sc7/jtHcJD0QnCBf
   L8JVOI6F8ZmosUdG/mDctsac2mDaNA7Kdor6zJ+z51MneNCR+YTIh2UDs
   vvqbMeiAqIZkYnH+F+w/ugzwoItGHicnxu9oEN7zgllcpuB19xE1Fa7dj
   52xKWrGvkg4RBTGL0g7Uw3w1TLn57ueZKqq6uBkKedhTKFl/Wni7uLY0G
   CFaTQtu5L5s378YHHn+W2I5zCHIqw7+IL+ayG6sqogVL62dq5KT9jZKk0
   aM2PQnj611jD8mKvdDPuLl+Q4NDcs2A4Qf3ggm6cmSpTT/aRYrAY5K3HR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000472"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000472"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769548047"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769548047"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:57 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/14] wifi: iwlwifi: disable RX STBC when a device doesn't support it
Date:   Wed, 24 May 2023 20:42:08 +0300
Message-Id: <20230524203151.65c3e09813e5.Iadfd8cdb0ea5a8088ae3daa555c780c423951894@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524174211.1482360-1-gregory.greenman@intel.com>
References: <20230524174211.1482360-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Some devices, like step A0 of GL FM device doesn't support RX STBC
for VHT/HE. Add a workaround to remove it from capabilities in
this case.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 7dcb1c3ab728..cf19e8a561e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -464,6 +464,9 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 		       IEEE80211_VHT_MAX_AMPDU_1024K <<
 		       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
 
+	if (!trans->cfg->ht_params->stbc)
+		vht_cap->cap &= ~IEEE80211_VHT_CAP_RXSTBC_MASK;
+
 	if (data->vht160_supported)
 		vht_cap->cap |= IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
 				IEEE80211_VHT_CAP_SHORT_GI_160;
@@ -986,6 +989,13 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->vendor_elems.data = iwl_vendor_caps;
 		iftype_data->vendor_elems.len = ARRAY_SIZE(iwl_vendor_caps);
 	}
+
+	if (!trans->cfg->ht_params->stbc) {
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[2] &=
+			~IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
+		iftype_data->he_cap.he_cap_elem.phy_cap_info[7] &=
+			~IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
+	}
 }
 
 static void iwl_init_he_hw_capab(struct iwl_trans *trans,
-- 
2.38.1

