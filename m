Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6654A7AA2CC
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjIUVe1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjIUVeC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:34:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5573E469A
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:22:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A390C116A5;
        Thu, 21 Sep 2023 07:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695282882;
        bh=KuqXgftjmuAxTqekmIMDq5iGa9Zxo5uom8X16GT8vtk=;
        h=From:To:Cc:Subject:Date:From;
        b=mnmYyyN+Fy4rtsBvsXCBdhCtsG8IaNBjpo+s0mxhVffLHPNiLfi7SSMH0fIG+jMqN
         8P7XSnI5GW92wygSnHKY84WLwnsLdXu4jFVjDgbuYIM5jI0wQCxzsenw56OjLTrOTw
         F2rcyqA1Z04+8SkfpBuHZv5Pvz2DbrinVcPR6LhbObaIrBDZ6yrKPClX9zJ6or59WS
         KOMgJXvENMBxWQRqt5vP7NegFogv4mcffLeKa7X6csmZAEN/f0Lb7LE40EtICjdpUu
         e2mv6kPgFwYc6i2XQTHRYR/aoGmrr9ailRwTOt4XFv4jOKnMpGvBX1geEPM8nbIYX/
         jbHW81hMhk2UQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath11k: mac: fix struct ieee80211_sband_iftype_data handling
Date:   Thu, 21 Sep 2023 10:54:40 +0300
Message-Id: <20230921075440.1539515-1-kvalo@kernel.org>
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
though we should use for_each_sband_iftype_data(). Now we iterate over each
item in the array and use the correct vif type which this vif is using.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6ed036b51dba..4bf302a43b0c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7913,11 +7913,13 @@ ath11k_mac_get_tx_mcs_map(const struct ieee80211_sta_he_cap *he_cap)
 
 static bool
 ath11k_mac_bitrate_mask_get_single_nss(struct ath11k *ar,
+				       struct ath11k_vif *arvif,
 				       enum nl80211_band band,
 				       const struct cfg80211_bitrate_mask *mask,
 				       int *nss)
 {
 	struct ieee80211_supported_band *sband = &ar->mac.sbands[band];
+	const struct ieee80211_sband_iftype_data *iftd, *iftype_data = NULL;
 	u16 vht_mcs_map = le16_to_cpu(sband->vht_cap.vht_mcs.tx_mcs_map);
 	u16 he_mcs_map = 0;
 	u8 ht_nss_mask = 0;
@@ -7949,7 +7951,17 @@ ath11k_mac_bitrate_mask_get_single_nss(struct ath11k *ar,
 			return false;
 	}
 
-	he_mcs_map = le16_to_cpu(ath11k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
+	for_each_sband_iftype_data(sband, i, iftd) {
+		if (iftd->types_mask & BIT(arvif->vif->type)) {
+			iftype_data = iftd;
+			break;
+		}
+	}
+
+	if (iftype_data == NULL)
+		return false;
+
+	he_mcs_map = le16_to_cpu(ath11k_mac_get_tx_mcs_map(&iftype_data->he_cap));
 
 	for (i = 0; i < ARRAY_SIZE(mask->control[band].he_mcs); i++) {
 		if (mask->control[band].he_mcs[i] == 0)
@@ -8365,7 +8377,7 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 		ieee80211_iterate_stations_atomic(ar->hw,
 						  ath11k_mac_disable_peer_fixed_rate,
 						  arvif);
-	} else if (ath11k_mac_bitrate_mask_get_single_nss(ar, band, mask,
+	} else if (ath11k_mac_bitrate_mask_get_single_nss(ar, arvif, band, mask,
 							  &single_nss)) {
 		rate = WMI_FIXED_RATE_NONE;
 		nss = single_nss;

base-commit: f00928012886a07ca6817ea70eb4856ce280ce05
-- 
2.39.2

