Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFC97AF0CF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjIZQeB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQeA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 12:34:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7061BF
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 09:33:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2124C433C7;
        Tue, 26 Sep 2023 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695746033;
        bh=IvKOdEnBJNQyWkBCU4bVbujBnX9sEpD8UoOjF/qG9Ww=;
        h=From:To:Cc:Subject:Date:From;
        b=UV1ZoIUAArrZkb7hQWKPAXKrQ5FSLd6Pin1aECc2JD2BcZb81TgYX026LK/4plSe9
         xBaaP4hKE+TgUdpUu2vgoZN9RSiBrA+x476Z1B3O/ABXAwWDu2NGTHsk4qljARV44M
         uB8kJPvu2eGd1MfQKi1tEzWnCmIOK0vpO7oJUyW2sA7hL5dQ31OGs+Z1gNtDrao3ip
         2TrBjSnbD6WWQdBLiQIgURmRfl6yZAXtoOau5xHGOkfND8ht6z+qJA8kFGxCt5mbFI
         xHyJa0UDN+u/uoPKFuBP6twr/iij//YsM2l5iYjaDYRONd+q4PU2+VKiv0TMY+lqS6
         hJkRxk1nxi/WQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: ath11k: mac: fix struct ieee80211_sband_iftype_data handling
Date:   Tue, 26 Sep 2023 19:33:50 +0300
Message-Id: <20230926163350.2641064-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Commit e8c1841278a7 ("wifi: cfg80211: annotate iftype_data pointer with
sparse") added sparse checks for struct ieee80211_sband_iftype_data handling
which immediately found an issue in ath11k:

drivers/net/wireless/ath/ath11k/mac.c:7952:22: warning: incorrect type in argument 1 (different address spaces)
drivers/net/wireless/ath/ath11k/mac.c:7952:22:    expected struct ieee80211_sta_he_cap const *he_cap
drivers/net/wireless/ath/ath11k/mac.c:7952:22:    got struct ieee80211_sta_he_cap const [noderef] __iftype_data *

The problem here is that we are accessing sband->iftype_data directly even
though we should use for_each_sband_iftype_data() or similar. Fortunately
there's ieee80211_get_he_iftype_cap_vif() which is just we need here so use it
to get HE capabilities.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c071bf5841af..79059c42e730 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7910,12 +7910,14 @@ ath11k_mac_get_tx_mcs_map(const struct ieee80211_sta_he_cap *he_cap)
 
 static bool
 ath11k_mac_bitrate_mask_get_single_nss(struct ath11k *ar,
+				       struct ath11k_vif *arvif,
 				       enum nl80211_band band,
 				       const struct cfg80211_bitrate_mask *mask,
 				       int *nss)
 {
 	struct ieee80211_supported_band *sband = &ar->mac.sbands[band];
 	u16 vht_mcs_map = le16_to_cpu(sband->vht_cap.vht_mcs.tx_mcs_map);
+	const struct ieee80211_sta_he_cap *he_cap;
 	u16 he_mcs_map = 0;
 	u8 ht_nss_mask = 0;
 	u8 vht_nss_mask = 0;
@@ -7946,7 +7948,8 @@ ath11k_mac_bitrate_mask_get_single_nss(struct ath11k *ar,
 			return false;
 	}
 
-	he_mcs_map = le16_to_cpu(ath11k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, arvif->vif);
+	he_mcs_map = le16_to_cpu(ath11k_mac_get_tx_mcs_map(he_cap));
 
 	for (i = 0; i < ARRAY_SIZE(mask->control[band].he_mcs); i++) {
 		if (mask->control[band].he_mcs[i] == 0)
@@ -8362,7 +8365,7 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		ieee80211_iterate_stations_atomic(ar->hw,
 						  ath11k_mac_disable_peer_fixed_rate,
 						  arvif);
-	} else if (ath11k_mac_bitrate_mask_get_single_nss(ar, band, mask,
+	} else if (ath11k_mac_bitrate_mask_get_single_nss(ar, arvif, band, mask,
 							  &single_nss)) {
 		rate = WMI_FIXED_RATE_NONE;
 		nss = single_nss;

base-commit: 73e13f6a439b75a9dbc84bbfa0b0d6624b354853
-- 
2.39.2

