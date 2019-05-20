Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8047022F6E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 10:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbfETIzZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 04:55:25 -0400
Received: from nbd.name ([46.4.11.11]:41464 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731669AbfETIzX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 04:55:23 -0400
Received: from p548c87ba.dip0.t-ipconnect.de ([84.140.135.186] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hSe4k-0002Y7-PH; Mon, 20 May 2019 10:55:18 +0200
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V5 5/8] ath11k: extend reading of FW capabilities
Date:   Mon, 20 May 2019 10:55:05 +0200
Message-Id: <20190520085508.5888-6-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520085508.5888-1-john@phrozen.org>
References: <20190520085508.5888-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Read the additional mcs and extended mac capabilities field from the
service ready callback and store them inside the ath11k_pdev_cap
structure. This allows us to generate the sband_iftype_data dynamically.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/core.h | 3 ++-
 drivers/net/wireless/ath/ath11k/wmi.c  | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 994170e08cc5..a7c59ea0c228 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -523,7 +523,7 @@ struct ath11k {
 struct ath11k_band_cap {
 	u32 max_bw_supported;
 	u32 ht_cap_info;
-	u32 he_cap_info;
+	u32 he_cap_info[2];
 	u32 he_mcs;
 	u32 he_cap_phy_info[PSOC_HOST_MAX_PHY_SIZE];
 	struct ath11k_ppe_threshold he_ppet;
@@ -534,6 +534,7 @@ struct ath11k_pdev_cap {
 	u32 ampdu_density;
 	u32 vht_cap;
 	u32 vht_mcs;
+	u32 he_mcs;
 	u32 tx_chain_mask;
 	u32 rx_chain_mask;
 	u32 tx_chain_mask_shift;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 9ca44c4b24f8..807c42d5bb22 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -325,6 +325,7 @@ static int ath11k_pull_mac_phy_cap_service_ready_ext(
 	} else if (mac_phy_caps->supported_bands & WMI_HOST_WLAN_5G_CAP) {
 		pdev_cap->vht_cap = mac_phy_caps->vht_cap_info_5g;
 		pdev_cap->vht_mcs = mac_phy_caps->vht_supp_mcs_5g;
+		pdev_cap->he_mcs = mac_phy_caps->he_supp_mcs_5g;
 		pdev_cap->tx_chain_mask = mac_phy_caps->tx_chain_mask_5g;
 		pdev_cap->rx_chain_mask = mac_phy_caps->rx_chain_mask_5g;
 	} else {
@@ -347,7 +348,8 @@ static int ath11k_pull_mac_phy_cap_service_ready_ext(
 	cap_band = &pdev_cap->band[NL80211_BAND_2GHZ];
 	cap_band->max_bw_supported = mac_phy_caps->max_bw_supported_2g;
 	cap_band->ht_cap_info = mac_phy_caps->ht_cap_info_2g;
-	cap_band->he_cap_info = mac_phy_caps->he_cap_info_2g;
+	cap_band->he_cap_info[0] = mac_phy_caps->he_cap_info_2g;
+	cap_band->he_cap_info[1] = mac_phy_caps->he_cap_info_2g_ext;
 	cap_band->he_mcs = mac_phy_caps->he_supp_mcs_2g;
 	memcpy(cap_band->he_cap_phy_info, &mac_phy_caps->he_cap_phy_info_2g,
 	       sizeof(u32) * PSOC_HOST_MAX_PHY_SIZE);
@@ -357,7 +359,8 @@ static int ath11k_pull_mac_phy_cap_service_ready_ext(
 	cap_band = &pdev_cap->band[NL80211_BAND_5GHZ];
 	cap_band->max_bw_supported = mac_phy_caps->max_bw_supported_5g;
 	cap_band->ht_cap_info = mac_phy_caps->ht_cap_info_5g;
-	cap_band->he_cap_info = mac_phy_caps->he_cap_info_5g;
+	cap_band->he_cap_info[0] = mac_phy_caps->he_cap_info_5g;
+	cap_band->he_cap_info[1] = mac_phy_caps->he_cap_info_5g_ext;
 	cap_band->he_mcs = mac_phy_caps->he_supp_mcs_5g;
 	memcpy(cap_band->he_cap_phy_info, &mac_phy_caps->he_cap_phy_info_5g,
 	       sizeof(u32) * PSOC_HOST_MAX_PHY_SIZE);
-- 
2.20.1

