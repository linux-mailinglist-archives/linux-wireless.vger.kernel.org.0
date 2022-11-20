Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62529631552
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Nov 2022 18:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiKTRBc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Nov 2022 12:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiKTRBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Nov 2022 12:01:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D876F2B262
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 09:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668963689; x=1700499689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fg6CkdJYVmXB8bqGx/i+3uTbsPpbPsUI6TvAyxPSNhE=;
  b=jEkzI7tTgbEZ4WCmSF5bHCQgGBmovyCv+ZBKiN5c/7IoHeBs0s1G+L22
   r4vgYPuADvCIGsT3Sv47e07MDLYq+ccn94VlxrwTTszxlXOArqfcQ5YhG
   7vkbmKieBpXq3Le+Rz51HaujplTufJQYhbiOF3kYXs+ogY6010dvxJvhi
   oDbWGOSEAegRG1URJ8d/hHNpF0SU2d4SaXtQLz/uXoprE78FTlPLeuNrk
   ekJDHrKfZTd4FjDmopeDvSe/Rjau4qmSz0CFaxfs63Ia6PdsMUZ+5K9x4
   kdwR7Y1CJPe73Ut5G4g/pAfAiwV5sCR7wXlceXdXKxie61Pt8TavyQjTC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="315234839"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="315234839"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="765719434"
X-IronPort-AV: E=Sophos;i="5.96,179,1665471600"; 
   d="scan'208";a="765719434"
Received: from dwiener-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.87.2])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 09:01:27 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/9] wifi: iwlwifi: mvm: support 320 MHz PHY configuration
Date:   Sun, 20 Nov 2022 19:00:32 +0200
Message-Id: <20221120185147.fc33093422ef.If56c94a9bf20c050f35d2421b680e400a9f4aeb8@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221120170039.1788067-1-gregory.greenman@intel.com>
References: <20221120170039.1788067-1-gregory.greenman@intel.com>
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

Support 320 MHz PHY configuration and while doing so rewrite
the code since we'd otherwise double the number of cases in
the switch statement.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  | 33 ++++++------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 54 +++++++++----------
 3 files changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index e66f77924f83..2f7d8558becd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -13,10 +13,12 @@
 #define PHY_BAND_6 (2)
 
 /* Supported channel width, vary if there is VHT support */
-#define PHY_VHT_CHANNEL_MODE20	(0x0)
-#define PHY_VHT_CHANNEL_MODE40	(0x1)
-#define PHY_VHT_CHANNEL_MODE80	(0x2)
-#define PHY_VHT_CHANNEL_MODE160	(0x3)
+#define IWL_PHY_CHANNEL_MODE20	0x0
+#define IWL_PHY_CHANNEL_MODE40	0x1
+#define IWL_PHY_CHANNEL_MODE80	0x2
+#define IWL_PHY_CHANNEL_MODE160	0x3
+/* and 320 MHz for EHT */
+#define IWL_PHY_CHANNEL_MODE320	0x4
 
 /*
  * Control channel position:
@@ -24,20 +26,17 @@
  * For VHT - bit-2 marks if the control is lower/upper relative to center-freq
  *   bits-1:0 mark the distance from the center freq. for 20Mhz, offset is 0.
  *                                   center_freq
- *                                        |
- * 40Mhz                          |_______|_______|
- * 80Mhz                  |_______|_______|_______|_______|
- * 160Mhz |_______|_______|_______|_______|_______|_______|_______|_______|
- * code      011     010     001     000  |  100     101     110    111
+ * For EHT - bit-3 is used for extended distance
+ *                                                |
+ * 40Mhz                                     |____|____|
+ * 80Mhz                                |____|____|____|____|
+ * 160Mhz                     |____|____|____|____|____|____|____|____|
+ * 320MHz |____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|____|
+ * code    1011 1010 1001 1000 0011 0010 0001 0000 0100 0101 0110 0111 1100 1101 1110 1111
  */
-#define PHY_VHT_CTRL_POS_1_BELOW  (0x0)
-#define PHY_VHT_CTRL_POS_2_BELOW  (0x1)
-#define PHY_VHT_CTRL_POS_3_BELOW  (0x2)
-#define PHY_VHT_CTRL_POS_4_BELOW  (0x3)
-#define PHY_VHT_CTRL_POS_1_ABOVE  (0x4)
-#define PHY_VHT_CTRL_POS_2_ABOVE  (0x5)
-#define PHY_VHT_CTRL_POS_3_ABOVE  (0x6)
-#define PHY_VHT_CTRL_POS_4_ABOVE  (0x7)
+#define IWL_PHY_CTRL_POS_ABOVE		0x4
+#define IWL_PHY_CTRL_POS_OFFS_EXT	0x8
+#define IWL_PHY_CTRL_POS_OFFS_MSK	0x3
 
 /*
  * struct iwl_fw_channel_info_v1 - channel information
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a81dd488caa8..57aa10466637 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3777,7 +3777,7 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 	/* Set the channel info data */
 	iwl_mvm_set_chan_info(mvm, &aux_roc_req.channel_info, channel->hw_value,
 			      iwl_mvm_phy_band_from_nl80211(channel->band),
-			      PHY_VHT_CHANNEL_MODE20,
+			      IWL_PHY_CHANNEL_MODE20,
 			      0);
 
 	/* Set the time and duration */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index a3cefbc43e80..06f4203fb989 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -14,16 +14,18 @@ u8 iwl_mvm_get_channel_width(struct cfg80211_chan_def *chandef)
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_20:
-		return PHY_VHT_CHANNEL_MODE20;
+		return IWL_PHY_CHANNEL_MODE20;
 	case NL80211_CHAN_WIDTH_40:
-		return PHY_VHT_CHANNEL_MODE40;
+		return IWL_PHY_CHANNEL_MODE40;
 	case NL80211_CHAN_WIDTH_80:
-		return PHY_VHT_CHANNEL_MODE80;
+		return IWL_PHY_CHANNEL_MODE80;
 	case NL80211_CHAN_WIDTH_160:
-		return PHY_VHT_CHANNEL_MODE160;
+		return IWL_PHY_CHANNEL_MODE160;
+	case NL80211_CHAN_WIDTH_320:
+		return IWL_PHY_CHANNEL_MODE320;
 	default:
 		WARN(1, "Invalid channel width=%u", chandef->width);
-		return PHY_VHT_CHANNEL_MODE20;
+		return IWL_PHY_CHANNEL_MODE20;
 	}
 }
 
@@ -33,34 +35,32 @@ u8 iwl_mvm_get_channel_width(struct cfg80211_chan_def *chandef)
  */
 u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef)
 {
-	switch (chandef->chan->center_freq - chandef->center_freq1) {
-	case -70:
-		return PHY_VHT_CTRL_POS_4_BELOW;
-	case -50:
-		return PHY_VHT_CTRL_POS_3_BELOW;
-	case -30:
-		return PHY_VHT_CTRL_POS_2_BELOW;
-	case -10:
-		return PHY_VHT_CTRL_POS_1_BELOW;
-	case  10:
-		return PHY_VHT_CTRL_POS_1_ABOVE;
-	case  30:
-		return PHY_VHT_CTRL_POS_2_ABOVE;
-	case  50:
-		return PHY_VHT_CTRL_POS_3_ABOVE;
-	case  70:
-		return PHY_VHT_CTRL_POS_4_ABOVE;
-	default:
-		WARN(1, "Invalid channel definition");
-		fallthrough;
-	case 0:
+	int offs = chandef->chan->center_freq - chandef->center_freq1;
+	int abs_offs = abs(offs);
+	u8 ret;
+
+	if (offs == 0) {
 		/*
 		 * The FW is expected to check the control channel position only
 		 * when in HT/VHT and the channel width is not 20MHz. Return
 		 * this value as the default one.
 		 */
-		return PHY_VHT_CTRL_POS_1_BELOW;
+		return 0;
 	}
+
+	/* this results in a value 0-7, i.e. fitting into 0b0111 */
+	ret = (abs_offs - 10) / 20;
+	/*
+	 * But we need the value to be in 0b1011 because 0b0100 is
+	 * IWL_PHY_CTRL_POS_ABOVE, so shift bit 2 up to land in
+	 * IWL_PHY_CTRL_POS_OFFS_EXT (0b1000)
+	 */
+	ret = (ret & IWL_PHY_CTRL_POS_OFFS_MSK) |
+	      ((ret & BIT(2)) << 1);
+	/* and add the above bit */
+	ret |= (offs > 0) * IWL_PHY_CTRL_POS_ABOVE;
+
+	return ret;
 }
 
 /*
-- 
2.35.3

