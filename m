Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0864304C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 21:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbfFLTgL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 15:36:11 -0400
Received: from durin.narfation.org ([79.140.41.39]:33990 "EHLO
        durin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387772AbfFLTgK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 15:36:10 -0400
Received: from sven-desktop.home.narfation.org (p200300C5971631EE000000000000070D.dip0.t-ipconnect.de [IPv6:2003:c5:9716:31ee::70d])
        by durin.narfation.org (Postfix) with ESMTPSA id E22AB110109;
        Wed, 12 Jun 2019 21:36:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560368169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNgY/HO91fUaSAW4h+RcL/4dMQgMlnTI5Tn5uIkoqNc=;
        b=2SqKODrUIIjxWA3XPzhPlh1g0NhbPW/gAONi5iWcYvXClP3tk28EDpGmvyFxBLCoL7rtIL
        bGnDrxxavM/XoQ9SU98Oxk5GC52YiVKn41bM3wddbkw5/rEDsqTSrNJY5wSo7g7W+mUpFf
        Yqu4O0mwQcO1lpn+Qpgxe5ZUuvNV8ew=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <seckelmann@datto.com>
Subject: [PATCH v3 3/3] ath11k: register HE mesh capabilities
Date:   Wed, 12 Jun 2019 21:35:10 +0200
Message-Id: <20190612193510.29489-4-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190612193510.29489-1-sven@narfation.org>
References: <20190612193510.29489-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560368169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qNgY/HO91fUaSAW4h+RcL/4dMQgMlnTI5Tn5uIkoqNc=;
        b=JF0IEsMshYAEt+pEBcr5F3MXfzJO5t950wdTwaST7UD/t0iUzsl7e1bWWmVwQyn5i0qG2V
        AE88MiLtg+g9vOi4eQ+z5mN9mD+kEjUVc54p+aGkXkYPjY0c2DkK1BVl9bROK0J2I5BYai
        XoowTM7hrONstxSPLGGyP+3zhatyo7c=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1560368169; a=rsa-sha256;
        cv=none;
        b=pDGwhLectbqf96Lv1/ufUM4CeXKa+hvH6KmdX2cWYlE++e0L/K+klYUpwFU0O3eP0nT/o8
        A8bGqwhpbw0DgtO9yP1VmrjM1+XCEpbcSwlyff+KHlydxWskIEidzb0i1cA9KKP++hFDr/
        2LVP2UV/bRC7JfyW1svS7giSmT+bbn0=
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
 drivers/net/wireless/ath/ath11k/mac.c | 63 +++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8c47e09a84e7..b55a98902fba 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3274,6 +3274,7 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 		switch (i) {
 		case NL80211_IFTYPE_STATION:
 		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_MESH_POINT:
 			break;
 
 		default:
@@ -3314,6 +3315,61 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
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
@@ -4239,6 +4295,13 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 	int he_support = arvif->vif->bss_conf.he_support;
 	int ret = 0;
 
+	/* mesh_point interfaces don't use bss_conf.he_support and still
+	 * requires HE PHY mode to be set during vdev restart to avoid
+	 * FW hangs when a sta with HE support tries to associate
+	 */
+	if (arvif->vif->type == NL80211_IFTYPE_MESH_POINT)
+		he_support = true;
+
 	lockdep_assert_held(&ar->conf_mutex);
 
 	reinit_completion(&ar->vdev_setup_done);
-- 
2.20.1

