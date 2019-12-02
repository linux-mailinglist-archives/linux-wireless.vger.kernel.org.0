Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 786FE10E6AE
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 09:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfLBIHq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 03:07:46 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:54016 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfLBIHq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 03:07:46 -0500
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 03:07:45 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1575273513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z+IfKs69GlzvzPxSUSClGfKItXK0H7cBQHFd/5JYlsE=;
        b=LLhSfCnu4h+ck5dbgrYq8MXOT8Ekhfe1NBDHDukINsGcnFx9TJ6r0Q4efr2lUNHoAsNVXK
        k5hEd1cFibaOjNrzr2OlSiV1RK+5gJcvkGGLo4TnE8tdqOrGNQfazWDCjIRundvEGnuYUc
        IMBqeiYM/XitkVct9ZF92eA1IQOFKwc=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
Subject: [PATCH v7] ath11k: register HE mesh capabilities
Date:   Mon,  2 Dec 2019 08:58:15 +0100
Message-Id: <20191202075815.20409-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
* v7

  - remove SU patch since the problems couldn't be reproduced (at the moment)
    with firmware WLAN.HK.2.0.0.1-00043-QCAHKSWPL_SILICONZ-1

* v6

  - remove upstream merged mac80211 patch
  - send only the ath11k relevant patches
  - drop (internal DEP-3-like) "Forwarded:" tag
  - switch from PATCH to RFC due to dropped HE support in ath11k

* v5

  - rebased patches
  - moved ath11k meshpoint HE capabilities filter to avoid lines over 80
    characters
  - add patch to disable HE SU phy capabilities to work around problems
    with WLAN.HK.2.1.0.1-00629-QCAHKSWPL_SILICONZ-1 firmware

* v4

  - switch order of the mac80211 HE mesh support and mac80211_hwsim support
  - drop ie_len variable from ieee80211_ie_len_he_cap and
    ieee80211_ie_build_he_oper
  - switch to function ieee80211_get_he_iftype_cap instead of implementing new
    function ieee80211_get_he_mesh_cap
  - allow ieee80211_ie_len_he_cap to calculate length for non-mesh HE cap
  - dropped he_support workaround in ath11k because now all phy_modes are
    HE phy modes

* v3

  - force ath11k PHY mode for meshpoint vif to HE mode to avoid hang of
    firmware when HE (or VHT on 2.4GHz) device tries to connect

* v2:

  - add of ath11k patch

* v1:

  - initial RFC

 drivers/net/wireless/ath/ath11k/mac.c | 75 +++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 978d8768d68a..65f6a2585577 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3346,6 +3346,77 @@ static void ath11k_gen_ppe_thresh(struct ath11k_ppe_threshold *fw_ppet,
 	}
 }
 
+static void
+ath11k_mac_filter_he_cap_mesh(struct ieee80211_he_cap_elem *he_cap_elem)
+{
+	u8 m;
+
+	m = IEEE80211_HE_MAC_CAP0_TWT_RES |
+	    IEEE80211_HE_MAC_CAP0_TWT_REQ;
+	he_cap_elem->mac_cap_info[0] &= ~m;
+
+	m = IEEE80211_HE_MAC_CAP2_TRS |
+	    IEEE80211_HE_MAC_CAP2_BCAST_TWT |
+	    IEEE80211_HE_MAC_CAP2_MU_CASCADING;
+	he_cap_elem->mac_cap_info[2] &= ~m;
+
+	m = IEEE80211_HE_MAC_CAP3_FLEX_TWT_SCHED |
+	    IEEE80211_HE_MAC_CAP2_BCAST_TWT |
+	    IEEE80211_HE_MAC_CAP2_MU_CASCADING;
+	he_cap_elem->mac_cap_info[3] &= ~m;
+
+	m = IEEE80211_HE_MAC_CAP4_BSRP_BQRP_A_MPDU_AGG |
+	    IEEE80211_HE_MAC_CAP4_BQR;
+	he_cap_elem->mac_cap_info[4] &= ~m;
+
+	m = IEEE80211_HE_MAC_CAP5_SUBCHAN_SELECVITE_TRANSMISSION |
+	    IEEE80211_HE_MAC_CAP5_UL_2x996_TONE_RU |
+	    IEEE80211_HE_MAC_CAP5_PUNCTURED_SOUNDING |
+	    IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX;
+	he_cap_elem->mac_cap_info[5] &= ~m;
+
+	m = IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+	    IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
+	he_cap_elem->phy_cap_info[2] &= ~m;
+
+	m = IEEE80211_HE_PHY_CAP3_RX_HE_MU_PPDU_FROM_NON_AP_STA |
+	    IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_MASK |
+	    IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK;
+	he_cap_elem->phy_cap_info[3] &= ~m;
+
+	m = IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+	he_cap_elem->phy_cap_info[4] &= ~m;
+
+	m = IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
+	he_cap_elem->phy_cap_info[5] &= ~m;
+
+	m = IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
+	    IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMER_FB |
+	    IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
+	    IEEE80211_HE_PHY_CAP6_PARTIAL_BANDWIDTH_DL_MUMIMO;
+	he_cap_elem->phy_cap_info[6] &= ~m;
+
+	m = IEEE80211_HE_PHY_CAP7_SRP_BASED_SR |
+	    IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_AR |
+	    IEEE80211_HE_PHY_CAP7_STBC_TX_ABOVE_80MHZ |
+	    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ;
+	he_cap_elem->phy_cap_info[7] &= ~m;
+
+	m = IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
+	    IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+	    IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
+	    IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
+	he_cap_elem->phy_cap_info[8] &= ~m;
+
+	m = IEEE80211_HE_PHY_CAP9_LONGER_THAN_16_SIGB_OFDM_SYM |
+	    IEEE80211_HE_PHY_CAP9_NON_TRIGGERED_CQI_FEEDBACK |
+	    IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
+	    IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
+	    IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+	    IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
+	he_cap_elem->phy_cap_info[9] &= ~m;
+}
+
 static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 				  struct ath11k_pdev_cap *cap,
 				  struct ieee80211_sband_iftype_data *data,
@@ -3362,6 +3433,7 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 		switch (i) {
 		case NL80211_IFTYPE_STATION:
 		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_MESH_POINT:
 			break;
 
 		default:
@@ -3402,6 +3474,9 @@ static int ath11k_mac_copy_he_cap(struct ath11k *ar,
 			he_cap_elem->phy_cap_info[9] |=
 				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
 			break;
+		case NL80211_IFTYPE_MESH_POINT:
+			ath11k_mac_filter_he_cap_mesh(he_cap_elem);
+			break;
 		}
 
 		he_cap->he_mcs_nss_supp.rx_mcs_80 =
-- 
2.20.1

