Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C3D45EAC4
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 10:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376425AbhKZJ5V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 04:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376492AbhKZJzV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 04:55:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD39C0613F6
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 01:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=EC1Ov/420zT4euqn0ZZTIxvZ4ZwVhU0s/8xRkdxEu2E=; t=1637920107; x=1639129707; 
        b=ZyQFu3kh34FHOsF1O928RGK9YjbZ3Nd02ukEXTFJqki3B+/RYAj8jCBuu9CMh6PW2eLbK6ScLEe
        4UxnDzr0+MUQSg0nY6qIeb38olmChhtMFZq59mTVXJpxg57dmv4rR+VVjJsbJ3k5fLWTEmu9j6Bq3
        07FbmuTkSRFXa+dK6NV3AIZEvLKlIlpZI9Vn7oj3LYQYCgSqOg6rKOv9WwRXMAUL+UCnjwjuPDfKn
        jAeIoaSqia1Rz4RraLs+MkyiCZ1m7gI6cy2Hn5xMxhZleoOvVhvivD70WKvd/vnFaohezHN8fe2LW
        xgeKc6nyflIHLKlfx+FlEp/75Uja6cCNLJew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mqXqA-00387S-Ki;
        Fri, 26 Nov 2021 10:48:22 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] ieee80211: change HE nominal packet padding value defines
Date:   Fri, 26 Nov 2021 10:48:19 +0100
Message-Id: <20211126104817.7c29a05b8eb5.I2ca9faf06e177e3035bec91e2ae53c2f91d41774@changeid>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

It's easier to use and understand, and to extend for EHT later,
if we use the values here instead of the shifted values.

Unfortunately, we need to add _POS so that we can use it in
places like iwlwifi/mvm where constants are needed.

While at it, fix the typo ("NOMIMAL") which also helps catch any
conflicts.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c   |  6 ++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c    | 16 ++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7915/init.c |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |  3 ++-
 drivers/net/wireless/realtek/rtw89/core.c        |  3 ++-
 drivers/net/wireless/realtek/rtw89/fw.c          |  2 +-
 include/linux/ieee80211.h                        | 11 ++++++-----
 net/mac80211/debugfs_sta.c                       |  9 +++++----
 8 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index f470f9aea50f..881ede4a4aa2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -607,7 +607,8 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 				.phy_cap_info[9] =
 					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
 					IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
-					IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_RESERVED,
+					(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED <<
+					IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_POS),
 				.phy_cap_info[10] =
 					IEEE80211_HE_PHY_CAP10_HE_MU_M1RU_MAX_LTF,
 			},
@@ -664,7 +665,8 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
 					IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_242,
 				.phy_cap_info[9] =
-					IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_RESERVED,
+					IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED
+					<< IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_POS,
 			},
 			/*
 			 * Set default Tx/Rx HE MCS NSS Support field.
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9fb9c7dad314..b96ccabd1596 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2126,24 +2126,24 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 		}
 
 		flags |= STA_CTXT_HE_PACKET_EXT;
-	} else if ((sta->he_cap.he_cap_elem.phy_cap_info[9] &
-		    IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_MASK) !=
-		  IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_RESERVED) {
+	} else if (u8_get_bits(sta->he_cap.he_cap_elem.phy_cap_info[9],
+			       IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK)
+		   != IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED) {
 		int low_th = -1;
 		int high_th = -1;
 
 		/* Take the PPE thresholds from the nominal padding info */
-		switch (sta->he_cap.he_cap_elem.phy_cap_info[9] &
-			IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_MASK) {
-		case IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_0US:
+		switch (u8_get_bits(sta->he_cap.he_cap_elem.phy_cap_info[9],
+				    IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK)) {
+		case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_0US:
 			low_th = IWL_HE_PKT_EXT_NONE;
 			high_th = IWL_HE_PKT_EXT_NONE;
 			break;
-		case IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_8US:
+		case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_8US:
 			low_th = IWL_HE_PKT_EXT_BPSK;
 			high_th = IWL_HE_PKT_EXT_NONE;
 			break;
-		case IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US:
+		case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US:
 			low_th = IWL_HE_PKT_EXT_NONE;
 			high_th = IWL_HE_PKT_EXT_BPSK;
 			break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 4fa8e7ba93e6..d054cdecd5f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -853,7 +853,8 @@ mt7915_init_he_caps(struct mt7915_phy *phy, enum nl80211_band band,
 			mt7915_gen_ppe_thresh(he_cap->ppe_thres, nss);
 		} else {
 			he_cap_elem->phy_cap_info[9] |=
-				IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US;
+				u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
+					       IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
 		}
 		idx++;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 633c6d2a57ac..e2eef9b5f63b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -140,7 +140,8 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 			mt7921_gen_ppe_thresh(he_cap->ppe_thres, nss);
 		} else {
 			he_cap_elem->phy_cap_info[9] |=
-				IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US;
+				u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
+					       IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
 		}
 
 		if (band == NL80211_BAND_6GHZ) {
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d02ec5a735cb..d5a4608d2d65 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2115,7 +2115,8 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 				  IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
 				  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
 				  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
-				  IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US;
+				  u8_encode_bits(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US,
+				  		 IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
 		if (i == NL80211_IFTYPE_STATION)
 			phy_cap_info[9] |= IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
 		he_cap->he_mcs_nss_supp.rx_mcs_80 = cpu_to_le16(mcs_map);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 212aaf577d3c..460d63dd6779 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -780,7 +780,7 @@ static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
 	if (!ppe_th) {
 		u8 pad;
 
-		pad = FIELD_GET(IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_MASK,
+		pad = FIELD_GET(IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK,
 				sta->he_cap.he_cap_elem.phy_cap_info[9]);
 
 		for (i = 0; i < RTW89_PPE_BW_NUM; i++)
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 11d7af260f20..559b6c644938 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2258,11 +2258,12 @@ enum ieee80211_client_reg_power {
 #define IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU		0x08
 #define IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB	0x10
 #define IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB	0x20
-#define IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_0US			0x00
-#define IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_8US			0x40
-#define IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US			0x80
-#define IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_RESERVED		0xc0
-#define IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_MASK			0xc0
+#define IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_0US			0x0
+#define IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_8US			0x1
+#define IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US			0x2
+#define IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED		0x3
+#define IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_POS			6
+#define IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK			0xc0
 
 #define IEEE80211_HE_PHY_CAP10_HE_MU_M1RU_MAX_LTF			0x01
 
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 481f01b0f65c..9479f2787ea7 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -936,14 +936,15 @@ static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
 	PFLAG(PHY, 9, RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB,
 	      "RX-FULL-BW-SU-USING-MU-WITH-NON-COMP-SIGB");
 
-	switch (cap[9] & IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_MASK) {
-	case IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_0US:
+	switch (u8_get_bits(cap[9],
+			    IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK)) {
+	case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_0US:
 		PRINT("NOMINAL-PACKET-PADDING-0US");
 		break;
-	case IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_8US:
+	case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_8US:
 		PRINT("NOMINAL-PACKET-PADDING-8US");
 		break;
-	case IEEE80211_HE_PHY_CAP9_NOMIMAL_PKT_PADDING_16US:
+	case IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US:
 		PRINT("NOMINAL-PACKET-PADDING-16US");
 		break;
 	}
-- 
2.33.1

