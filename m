Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68555E1C5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGCKTD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 06:19:03 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:36516 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGCKTC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 06:19:02 -0400
Received: from sven-desktop.home.narfation.org (p4FCB2E24.dip0.t-ipconnect.de [79.203.46.36])
        by dvalin.narfation.org (Postfix) with ESMTPSA id 2E40D208EF;
        Wed,  3 Jul 2019 10:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562149141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFAdpu5W5pgQ6uC26s/F+q3bqzvGHMyyPnsJBTH91CQ=;
        b=WVk7kiZT2kKKR4ul2q9Dobvf/5d2rZnR2mczLfh6cwfAkJWr14odlqZmkusLnim8bCrJG5
        sFa6vfiSSsYyPcvES9lM23sQT5dzJPlfbrIl/1DE1Xz/dSzUlvsPYj+Rygz9WbNeWVFbbE
        qY6smh/1Es5k0pH1U4Eltq4kmZ2bvcI=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <seckelmann@datto.com>
Subject: [PATCH v4 3/3] ath11k: register HE mesh capabilities
Date:   Wed,  3 Jul 2019 12:18:39 +0200
Message-Id: <20190703101839.18827-4-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703101839.18827-1-sven@narfation.org>
References: <20190703101839.18827-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1562149141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFAdpu5W5pgQ6uC26s/F+q3bqzvGHMyyPnsJBTH91CQ=;
        b=bwpqJgV4P50rRq2lVxlp2l6x//rW6P7T2MLqGjV10xckf69FiTjbpJnWtZG7Uqktl//SsN
        xo72nd30DsZBkrpeFcrjWFOTXBnk9svP+vSMu8rLuDcfKWValG8rgBPMX/DMT6LFLHSUbm
        WkUAxfAtMXvN1P14hWTdiBSu9hwYc8s=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1562149141; a=rsa-sha256;
        cv=none;
        b=It4DZ7T36hhcIZT1lNYNGnoQtrpnEIRjTUA/ulbueIj7vZAC3jIe0RoMAl6bMq1Cz3sYiE
        2BM62NGMSL2b9d/xKQJAh3BYhEOSQ5oYVyguzCsWam+i+3k2enxYbNaj+tC0BDyTtmRr5R
        2xixP/IIQfE++yrOKc3yZs07zdFXkpM=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sven Eckelmann <seckelmann@datto.com>

The capabilities for the HE mesh are generated from the capabilities
reported by the fw. But the firmware only reports the overall capabilities
and not the one which are specific for mesh. Some of them (TWT, MU UL/DL,
TB PPDU, ...) require an infrastructure setup with a main STA (AP)
controlling the operations. This is not the case for mesh and thus these
capabilities are removed from the list of capabilities.

Signed-off-by: Sven Eckelmann <seckelmann@datto.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 56 +++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index dd164b5bb51a..3a3296b83cc1 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3150,6 +3150,7 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 		switch (i) {
 		case NL80211_IFTYPE_STATION:
 		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_MESH_POINT:
 			break;
 
 		default:
@@ -3190,6 +3191,61 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 			he_cap_elem->phy_cap_info[9] |=
 				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
 			break;
+		case NL80211_IFTYPE_MESH_POINT:
+			he_cap_elem->mac_cap_info[0] &=
+				~(IEEE80211_HE_MAC_CAP0_TWT_RES |
+				  IEEE80211_HE_MAC_CAP0_TWT_REQ);
+			he_cap_elem->mac_cap_info[2] &=
+				~(IEEE80211_HE_MAC_CAP2_TRS |
+				  IEEE80211_HE_MAC_CAP2_BCAST_TWT |
+				  IEEE80211_HE_MAC_CAP2_MU_CASCADING);
+			he_cap_elem->mac_cap_info[3] &=
+				~(IEEE80211_HE_MAC_CAP3_FLEX_TWT_SCHED |
+				  IEEE80211_HE_MAC_CAP2_BCAST_TWT |
+				  IEEE80211_HE_MAC_CAP2_MU_CASCADING);
+			he_cap_elem->mac_cap_info[4] &=
+				~(IEEE80211_HE_MAC_CAP4_BSRP_BQRP_A_MPDU_AGG |
+				  IEEE80211_HE_MAC_CAP4_BQR);
+			he_cap_elem->mac_cap_info[5] &=
+				~(IEEE80211_HE_MAC_CAP5_SUBCHAN_SELECVITE_TRANSMISSION |
+				  IEEE80211_HE_MAC_CAP5_UL_2x996_TONE_RU |
+				  IEEE80211_HE_MAC_CAP5_PUNCTURED_SOUNDING |
+				  IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX);
+
+			he_cap_elem->phy_cap_info[2] &=
+				~(IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+				  IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO);
+			he_cap_elem->phy_cap_info[3] &=
+				~(IEEE80211_HE_PHY_CAP3_RX_HE_MU_PPDU_FROM_NON_AP_STA |
+				  IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_MASK |
+				  IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK);
+			he_cap_elem->phy_cap_info[4] &=
+				~IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+			he_cap_elem->phy_cap_info[5] &=
+				~IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
+			he_cap_elem->phy_cap_info[6] &=
+				~(IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
+				  IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMER_FB |
+				  IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
+				  IEEE80211_HE_PHY_CAP6_PARTIAL_BANDWIDTH_DL_MUMIMO);
+			he_cap_elem->phy_cap_info[7] &=
+				~(IEEE80211_HE_PHY_CAP7_SRP_BASED_SR |
+				  IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_AR |
+				  IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ |
+				  IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ);
+			he_cap_elem->phy_cap_info[8] &=
+				~(IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
+				  IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+				  IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+				  IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU);
+			he_cap_elem->phy_cap_info[9] &=
+				~(IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+				  IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
+				  IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+				  IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+				  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+				  IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB);
+			break;
 		}
 
 		he_cap->he_mcs_nss_supp.rx_mcs_80 =
-- 
2.20.1

