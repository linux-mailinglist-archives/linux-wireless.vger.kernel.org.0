Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA778A6D9
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 09:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjH1Hy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 03:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjH1Hyw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 03:54:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AF8115
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 00:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=j3iyK8f11zr/CKrvaxsMJPih7UwdmYTvXoHoCtsEM6U=; t=1693209286; x=1694418886; 
        b=a98ZeFw+MwUEUzDkPFLEwR1xTEH+w1Uy80a7hBzAeIepYT4GIuFsCwfbNQkdAPKwKaPvOQn2XbN
        zgFHTbQVzoSW2cEFu6/0XwczPCI1IdO1dTjS6Mv8OcwU/VxwgGiAUX0cfKqf9HxPDCT1d1styhzRi
        4TWUzdDO4fVQjhRVnCry8WlO3G6VSMAwAXE1c0VJoNK9hnMDawVfYadXs+8ELverBqs7oMMiPos4O
        zjFrqemZT5rKh5yYu0nDlceg3+y6kDpvtBONUng4IirlUxaW0ro9yiKnA6spV4YvYvyrU76ZmUuDW
        rNfrVpjYb02ToBMFT2bRWUBRrhcRJNnq+oyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaX59-00GV9i-0w;
        Mon, 28 Aug 2023 09:54:43 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cfg80211: annotate iftype_data pointer with sparse
Date:   Mon, 28 Aug 2023 09:54:39 +0200
Message-ID: <20230828095438.498745967c5e.I769379d32d239247a3ad80e26b14f16aba348bd2@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There were are a number of cases in mac80211 and iwlwifi (at
least) that used the sband->iftype_data pointer directly,
instead of using the accessors to find the right array entry
to use.

Make sparse warn when such a thing is done.

To not have a lot of casts, add two helper functions/macros

 - ieee80211_set_sband_iftype_data()
 - for_each_sband_iftype_data()

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath11k/mac.c         | 15 +++--
 drivers/net/wireless/ath/ath12k/mac.c         | 12 ++--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  9 +--
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  9 +--
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  3 +-
 .../net/wireless/quantenna/qtnfmac/commands.c |  5 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c |  2 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 15 +++--
 drivers/net/wireless/realtek/rtw89/regd.c     |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c | 30 ++++------
 include/net/cfg80211.h                        | 59 +++++++++++++++++--
 net/mac80211/main.c                           |  7 +--
 net/wireless/chan.c                           |  5 +-
 net/wireless/core.c                           |  8 +--
 net/wireless/nl80211.c                        |  6 +-
 16 files changed, 112 insertions(+), 79 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c071bf5841af..6ed036b51dba 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5893,8 +5893,9 @@ static void ath11k_mac_setup_he_cap(struct ath11k *ar,
 					       ar->mac.iftype[NL80211_BAND_2GHZ],
 					       NL80211_BAND_2GHZ);
 		band = &ar->mac.sbands[NL80211_BAND_2GHZ];
-		band->iftype_data = ar->mac.iftype[NL80211_BAND_2GHZ];
-		band->n_iftype_data = count;
+		_ieee80211_set_sband_iftype_data(band,
+						 ar->mac.iftype[NL80211_BAND_2GHZ],
+						 count);
 	}
 
 	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP) {
@@ -5902,8 +5903,9 @@ static void ath11k_mac_setup_he_cap(struct ath11k *ar,
 					       ar->mac.iftype[NL80211_BAND_5GHZ],
 					       NL80211_BAND_5GHZ);
 		band = &ar->mac.sbands[NL80211_BAND_5GHZ];
-		band->iftype_data = ar->mac.iftype[NL80211_BAND_5GHZ];
-		band->n_iftype_data = count;
+		_ieee80211_set_sband_iftype_data(band,
+						 ar->mac.iftype[NL80211_BAND_5GHZ],
+						 count);
 	}
 
 	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP &&
@@ -5912,8 +5914,9 @@ static void ath11k_mac_setup_he_cap(struct ath11k *ar,
 					       ar->mac.iftype[NL80211_BAND_6GHZ],
 					       NL80211_BAND_6GHZ);
 		band = &ar->mac.sbands[NL80211_BAND_6GHZ];
-		band->iftype_data = ar->mac.iftype[NL80211_BAND_6GHZ];
-		band->n_iftype_data = count;
+		_ieee80211_set_sband_iftype_data(band,
+						 ar->mac.iftype[NL80211_BAND_6GHZ],
+						 count);
 	}
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88346e66bb75..24113709972d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4647,8 +4647,8 @@ static void ath12k_mac_setup_sband_iftype_data(struct ath12k *ar,
 							  ar->mac.iftype[band],
 							  band);
 		sband = &ar->mac.sbands[band];
-		sband->iftype_data = ar->mac.iftype[band];
-		sband->n_iftype_data = count;
+		_ieee80211_set_sband_iftype_data(sband, ar->mac.iftype[band],
+						 count);
 	}
 
 	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP) {
@@ -4657,8 +4657,8 @@ static void ath12k_mac_setup_sband_iftype_data(struct ath12k *ar,
 							  ar->mac.iftype[band],
 							  band);
 		sband = &ar->mac.sbands[band];
-		sband->iftype_data = ar->mac.iftype[band];
-		sband->n_iftype_data = count;
+		_ieee80211_set_sband_iftype_data(sband, ar->mac.iftype[band],
+						 count);
 	}
 
 	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP &&
@@ -4668,8 +4668,8 @@ static void ath12k_mac_setup_sband_iftype_data(struct ath12k *ar,
 							  ar->mac.iftype[band],
 							  band);
 		sband = &ar->mac.sbands[band];
-		sband->iftype_data = ar->mac.iftype[band];
-		sband->n_iftype_data = count;
+		_ieee80211_set_sband_iftype_data(sband, ar->mac.iftype[band],
+						 count);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 31176897b746..cff1f97536e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1077,8 +1077,8 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 
 	memcpy(iftype_data, iwl_he_eht_capa, sizeof(iwl_he_eht_capa));
 
-	sband->iftype_data = iftype_data;
-	sband->n_iftype_data = ARRAY_SIZE(iwl_he_eht_capa);
+	_ieee80211_set_sband_iftype_data(sband, iftype_data,
+					 ARRAY_SIZE(iwl_he_eht_capa));
 
 	for (i = 0; i < sband->n_iftype_data; i++)
 		iwl_nvm_fixup_sband_iftd(trans, data, sband, &iftype_data[i],
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 35fdf4f98d80..b27d04e02aba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1127,8 +1127,7 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 		n = mt7915_init_he_caps(phy, NL80211_BAND_2GHZ, data);
 
 		band = &phy->mt76->sband_2g.sband;
-		band->iftype_data = data;
-		band->n_iftype_data = n;
+		_ieee80211_set_sband_iftype_data(band, data, n);
 	}
 
 	if (phy->mt76->cap.has_5ghz) {
@@ -1136,8 +1135,7 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 		n = mt7915_init_he_caps(phy, NL80211_BAND_5GHZ, data);
 
 		band = &phy->mt76->sband_5g.sband;
-		band->iftype_data = data;
-		band->n_iftype_data = n;
+		_ieee80211_set_sband_iftype_data(band, data, n);
 	}
 
 	if (phy->mt76->cap.has_6ghz) {
@@ -1145,8 +1143,7 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 		n = mt7915_init_he_caps(phy, NL80211_BAND_6GHZ, data);
 
 		band = &phy->mt76->sband_6g.sband;
-		band->iftype_data = data;
-		band->n_iftype_data = n;
+		_ieee80211_set_sband_iftype_data(band, data, n);
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 0844d28b3223..62e6da1386aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -196,8 +196,7 @@ void mt7921_set_stream_he_caps(struct mt792x_phy *phy)
 		n = mt7921_init_he_caps(phy, NL80211_BAND_2GHZ, data);
 
 		band = &phy->mt76->sband_2g.sband;
-		band->iftype_data = data;
-		band->n_iftype_data = n;
+		_ieee80211_set_sband_iftype_data(band, data, n);
 	}
 
 	if (phy->mt76->cap.has_5ghz) {
@@ -205,16 +204,14 @@ void mt7921_set_stream_he_caps(struct mt792x_phy *phy)
 		n = mt7921_init_he_caps(phy, NL80211_BAND_5GHZ, data);
 
 		band = &phy->mt76->sband_5g.sband;
-		band->iftype_data = data;
-		band->n_iftype_data = n;
+		_ieee80211_set_sband_iftype_data(band, data, n);
 
 		if (phy->mt76->cap.has_6ghz) {
 			data = phy->iftype[NL80211_BAND_6GHZ];
 			n = mt7921_init_he_caps(phy, NL80211_BAND_6GHZ, data);
 
 			band = &phy->mt76->sband_6g.sband;
-			band->iftype_data = data;
-			band->n_iftype_data = n;
+			_ieee80211_set_sband_iftype_data(band, data, n);
 		}
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 26e03b28935f..0d6cc214ce10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -827,8 +827,7 @@ __mt7996_set_stream_he_eht_caps(struct mt7996_phy *phy,
 		n++;
 	}
 
-	sband->iftype_data = data;
-	sband->n_iftype_data = n;
+	_ieee80211_set_sband_iftype_data(sband, data, n);
 }
 
 void mt7996_set_stream_he_eht_caps(struct mt7996_phy *phy)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index 68ae9c7ea95a..9540ad6196d7 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -1335,7 +1335,7 @@ static int qtnf_cmd_band_fill_iftype(const u8 *data,
 		return -EINVAL;
 	}
 
-	kfree(band->iftype_data);
+	kfree((__force void *)band->iftype_data);
 	band->iftype_data = NULL;
 	band->n_iftype_data = tlv->n_iftype_data;
 	if (band->n_iftype_data == 0)
@@ -1347,7 +1347,8 @@ static int qtnf_cmd_band_fill_iftype(const u8 *data,
 		band->n_iftype_data = 0;
 		return -ENOMEM;
 	}
-	band->iftype_data = iftype_data;
+
+	_ieee80211_set_sband_iftype_data(band, iftype_data, tlv->n_iftype_data);
 
 	for (i = 0; i < band->n_iftype_data; i++)
 		qtnf_cmd_conv_iftype(iftype_data++, &tlv->iftype_data[i]);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 2a63ffdc4b2c..677bac835330 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -535,7 +535,7 @@ static void qtnf_core_mac_detach(struct qtnf_bus *bus, unsigned int macid)
 		if (!wiphy->bands[band])
 			continue;
 
-		kfree(wiphy->bands[band]->iftype_data);
+		kfree((__force void *)wiphy->bands[band]->iftype_data);
 		wiphy->bands[band]->n_iftype_data = 0;
 
 		kfree(wiphy->bands[band]->channels);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 133bf289bacb..e3145660a685 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3359,8 +3359,7 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 		idx++;
 	}
 
-	sband->iftype_data = iftype_data;
-	sband->n_iftype_data = idx;
+	_ieee80211_set_sband_iftype_data(sband, iftype_data, idx);
 }
 
 static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
@@ -3405,11 +3404,11 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 	hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
 	hw->wiphy->bands[NL80211_BAND_6GHZ] = NULL;
 	if (sband_2ghz)
-		kfree(sband_2ghz->iftype_data);
+		kfree((__force void *)sband_2ghz->iftype_data);
 	if (sband_5ghz)
-		kfree(sband_5ghz->iftype_data);
+		kfree((__force void *)sband_5ghz->iftype_data);
 	if (sband_6ghz)
-		kfree(sband_6ghz->iftype_data);
+		kfree((__force void *)sband_6ghz->iftype_data);
 	kfree(sband_2ghz);
 	kfree(sband_5ghz);
 	kfree(sband_6ghz);
@@ -3421,11 +3420,11 @@ static void rtw89_core_clr_supported_band(struct rtw89_dev *rtwdev)
 	struct ieee80211_hw *hw = rtwdev->hw;
 
 	if (hw->wiphy->bands[NL80211_BAND_2GHZ])
-		kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]->iftype_data);
+		kfree((__force void *)hw->wiphy->bands[NL80211_BAND_2GHZ]->iftype_data);
 	if (hw->wiphy->bands[NL80211_BAND_5GHZ])
-		kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]->iftype_data);
+		kfree((__force void *)hw->wiphy->bands[NL80211_BAND_5GHZ]->iftype_data);
 	if (hw->wiphy->bands[NL80211_BAND_6GHZ])
-		kfree(hw->wiphy->bands[NL80211_BAND_6GHZ]->iftype_data);
+		kfree((__force void *)hw->wiphy->bands[NL80211_BAND_6GHZ]->iftype_data);
 	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
 	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
 	kfree(hw->wiphy->bands[NL80211_BAND_6GHZ]);
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 9e2328db1865..c956a8b971c6 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -377,7 +377,7 @@ static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 		return;
 
 	wiphy->bands[NL80211_BAND_6GHZ] = NULL;
-	kfree(sband->iftype_data);
+	kfree((__force void *)sband->iftype_data);
 	kfree(sband);
 }
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 1f524030b186..b6a53341f1c3 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4899,25 +4899,19 @@ static const struct ieee80211_sband_iftype_data sband_capa_6ghz[] = {
 
 static void mac80211_hwsim_sband_capab(struct ieee80211_supported_band *sband)
 {
-	u16 n_iftype_data;
-
-	if (sband->band == NL80211_BAND_2GHZ) {
-		n_iftype_data = ARRAY_SIZE(sband_capa_2ghz);
-		sband->iftype_data =
-			(struct ieee80211_sband_iftype_data *)sband_capa_2ghz;
-	} else if (sband->band == NL80211_BAND_5GHZ) {
-		n_iftype_data = ARRAY_SIZE(sband_capa_5ghz);
-		sband->iftype_data =
-			(struct ieee80211_sband_iftype_data *)sband_capa_5ghz;
-	} else if (sband->band == NL80211_BAND_6GHZ) {
-		n_iftype_data = ARRAY_SIZE(sband_capa_6ghz);
-		sband->iftype_data =
-			(struct ieee80211_sband_iftype_data *)sband_capa_6ghz;
-	} else {
-		return;
+	switch (sband->band) {
+	case NL80211_BAND_2GHZ:
+		ieee80211_set_sband_iftype_data(sband, sband_capa_2ghz);
+		break;
+	case NL80211_BAND_5GHZ:
+		ieee80211_set_sband_iftype_data(sband, sband_capa_5ghz);
+		break;
+	case NL80211_BAND_6GHZ:
+		ieee80211_set_sband_iftype_data(sband, sband_capa_6ghz);
+		break;
+	default:
+		break;
 	}
-
-	sband->n_iftype_data = n_iftype_data;
 }
 
 #ifdef CONFIG_MAC80211_MESH
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3a4b684f89bf..bf666c76f12c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -410,6 +410,19 @@ struct ieee80211_sta_eht_cap {
 	u8 eht_ppe_thres[IEEE80211_EHT_PPE_THRES_MAX_LEN];
 };
 
+/* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
+#ifdef __CHECKER__
+/*
+ * This is used to mark the sband->iftype_data pointer which is supposed
+ * to be an array with special access semantics (per iftype), but a lot
+ * of code got it wrong in the past, so with this marking sparse will be
+ * noisy when the pointer is used directly.
+ */
+# define __iftd		__attribute__((noderef, address_space(__iftype_data)))
+#else
+# define __iftd
+#endif /* __CHECKER__ */
+
 /**
  * struct ieee80211_sband_iftype_data - sband data per interface type
  *
@@ -543,9 +556,47 @@ struct ieee80211_supported_band {
 	struct ieee80211_sta_s1g_cap s1g_cap;
 	struct ieee80211_edmg edmg_cap;
 	u16 n_iftype_data;
-	const struct ieee80211_sband_iftype_data *iftype_data;
+	const struct ieee80211_sband_iftype_data __iftd *iftype_data;
 };
 
+/**
+ * _ieee80211_set_sband_iftype_data - set sband iftype data array
+ * @sband: the sband to initialize
+ * @iftd: the iftype data array pointer
+ * @n_iftd: the length of the iftype data array
+ *
+ * Set the sband iftype data array; use this where the length cannot
+ * be derived from the ARRAY_SIZE() of the argument, but prefer
+ * ieee80211_set_sband_iftype_data() where it can be used.
+ */
+static inline void
+_ieee80211_set_sband_iftype_data(struct ieee80211_supported_band *sband,
+				 const struct ieee80211_sband_iftype_data *iftd,
+				 u16 n_iftd)
+{
+	sband->iftype_data = (const void __iftd __force *)iftd;
+	sband->n_iftype_data = n_iftd;
+}
+
+/**
+ * ieee80211_set_sband_iftype_data - set sband iftype data array
+ * @sband: the sband to initialize
+ * @iftd: the iftype data array
+ */
+#define ieee80211_set_sband_iftype_data(sband, iftd)	\
+	_ieee80211_set_sband_iftype_data(sband, iftd, ARRAY_SIZE(iftd))
+
+/**
+ * for_each_sband_iftype_data - iterate sband iftype data entries
+ * @sband: the sband whose iftype_data array to iterate
+ * @i: iterator counter
+ * @iftd: iftype data pointer to set
+ */
+#define for_each_sband_iftype_data(sband, i, iftd)				\
+	for (i = 0, iftd = (const void __force *)&(sband)->iftype_data[i];	\
+	     i < (sband)->n_iftype_data;					\
+	     i++, iftd = (const void __force *)&(sband)->iftype_data[i])
+
 /**
  * ieee80211_get_sband_iftype_data - return sband data for a given iftype
  * @sband: the sband to search for the STA on
@@ -557,6 +608,7 @@ static inline const struct ieee80211_sband_iftype_data *
 ieee80211_get_sband_iftype_data(const struct ieee80211_supported_band *sband,
 				u8 iftype)
 {
+	const struct ieee80211_sband_iftype_data *data;
 	int i;
 
 	if (WARN_ON(iftype >= NL80211_IFTYPE_MAX))
@@ -565,10 +617,7 @@ ieee80211_get_sband_iftype_data(const struct ieee80211_supported_band *sband,
 	if (iftype == NL80211_IFTYPE_AP_VLAN)
 		iftype = NL80211_IFTYPE_AP;
 
-	for (i = 0; i < sband->n_iftype_data; i++)  {
-		const struct ieee80211_sband_iftype_data *data =
-			&sband->iftype_data[i];
-
+	for_each_sband_iftype_data(sband, i, data) {
 		if (data->types_mask & BIT(iftype))
 			return data;
 	}
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 24315d7b3126..0da72a7c10cf 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1055,6 +1055,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	supp_he = false;
 	supp_eht = false;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		const struct ieee80211_sband_iftype_data *iftd;
 		struct ieee80211_supported_band *sband;
 
 		sband = local->hw.wiphy->bands[band];
@@ -1101,11 +1102,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		supp_ht = supp_ht || sband->ht_cap.ht_supported;
 		supp_vht = supp_vht || sband->vht_cap.vht_supported;
 
-		for (i = 0; i < sband->n_iftype_data; i++) {
-			const struct ieee80211_sband_iftype_data *iftd;
-
-			iftd = &sband->iftype_data[i];
-
+		for_each_sband_iftype_data(sband, i, iftd) {
 			supp_he = supp_he || iftd->he_cap.has_he;
 			supp_eht = supp_eht || iftd->eht_cap.has_eht;
 		}
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 0b7e81db383d..81e0155ec7c6 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -6,7 +6,7 @@
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright 2018-2022	Intel Corporation
+ * Copyright 2018-2023	Intel Corporation
  */
 
 #include <linux/export.h>
@@ -1162,8 +1162,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 		if (!sband)
 			return false;
 
-		for (i = 0; i < sband->n_iftype_data; i++) {
-			iftd = &sband->iftype_data[i];
+		for_each_sband_iftype_data(sband, i, iftd) {
 			if (!iftd->eht_cap.has_eht)
 				continue;
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 25bc2e50a061..7a40056702b7 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010		Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -821,6 +821,7 @@ int wiphy_register(struct wiphy *wiphy)
 
 	/* sanity check supported bands/channels */
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		const struct ieee80211_sband_iftype_data *iftd;
 		u16 types = 0;
 		bool have_he = false;
 
@@ -877,14 +878,11 @@ int wiphy_register(struct wiphy *wiphy)
 				return -EINVAL;
 		}
 
-		for (i = 0; i < sband->n_iftype_data; i++) {
-			const struct ieee80211_sband_iftype_data *iftd;
+		for_each_sband_iftype_data(sband, i, iftd) {
 			bool has_ap, has_non_ap;
 			u32 ap_bits = BIT(NL80211_IFTYPE_AP) |
 				      BIT(NL80211_IFTYPE_P2P_GO);
 
-			iftd = &sband->iftype_data[i];
-
 			if (WARN_ON(!iftd->types_mask))
 				return -EINVAL;
 			if (WARN_ON(types & iftd->types_mask))
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index de47838aca4f..0d96f55a0d55 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1913,20 +1913,20 @@ static int nl80211_send_band_rateinfo(struct sk_buff *msg,
 		struct nlattr *nl_iftype_data =
 			nla_nest_start_noflag(msg,
 					      NL80211_BAND_ATTR_IFTYPE_DATA);
+		const struct ieee80211_sband_iftype_data *iftd;
 		int err;
 
 		if (!nl_iftype_data)
 			return -ENOBUFS;
 
-		for (i = 0; i < sband->n_iftype_data; i++) {
+		for_each_sband_iftype_data(sband, i, iftd) {
 			struct nlattr *iftdata;
 
 			iftdata = nla_nest_start_noflag(msg, i + 1);
 			if (!iftdata)
 				return -ENOBUFS;
 
-			err = nl80211_send_iftype_data(msg, sband,
-						       &sband->iftype_data[i]);
+			err = nl80211_send_iftype_data(msg, sband, iftd);
 			if (err)
 				return err;
 
-- 
2.41.0

