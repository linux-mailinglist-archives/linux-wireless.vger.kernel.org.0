Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9C763D4E1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406782AbfFKSDI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 14:03:08 -0400
Received: from durin.narfation.org ([79.140.41.39]:35990 "EHLO
        durin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406724AbfFKSDH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 14:03:07 -0400
Received: from sven-desktop.home.narfation.org (p200300C5970379EE000000000000070D.dip0.t-ipconnect.de [IPv6:2003:c5:9703:79ee::70d])
        by durin.narfation.org (Postfix) with ESMTPSA id DE01A1100EB;
        Tue, 11 Jun 2019 20:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560276186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XwqR15hopOXR+2mli3A8zuXGO/XCdO1dpSdhKwiBQx0=;
        b=i1OAq76N/PLzRy2al0bvUnA9ppZ/yeSiOmZ4SzRB182utVsYiEDqBjG3fTI4p+rq7pf1Fo
        pRzExcN9BfDr5jSybRMC1/caGnVgq0s18A/OvbBNbgFOMDhfXPQd0oHip6NsDkvCoqqJm5
        eaJpOi/7whoKyxvn6L1Trm5ACwWKtn0=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <seckelmann@datto.com>
Subject: [RFC PATCH v2 3/3] ath11k: register HE mesh capabilities
Date:   Tue, 11 Jun 2019 20:02:47 +0200
Message-Id: <20190611180247.19524-4-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611180247.19524-1-sven@narfation.org>
References: <20190611180247.19524-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1560276186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XwqR15hopOXR+2mli3A8zuXGO/XCdO1dpSdhKwiBQx0=;
        b=aERcUkwLcwxHutaXcu6uB8fnsWmWmpDdq0TjkrP1kWdNuVYFTXcm5kmmxx/3E+5yZ6uIMb
        0qVVUVq++aAUAj5mz3anq1OEmgJamhc7qqHjfOGN6RlhAfaDLkSRBtnZV8cSmdeTCKIdJv
        m0owGLtJ0MFqR2dmm17bUjzCdsqHUhs=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1560276186; a=rsa-sha256;
        cv=none;
        b=pvSrxqWSjGmKT+eKua0aT9E+o+PdldWXXI7Gayr/sTZoMT6/PXVl97aglUSGpW8kxQYaCY
        2ri8U62xSdNcbLf323qC4Q+PxbhJdzJl9+sXhMfd60tcANRVpSe409ppP8FdE+VKo6e88N
        IyXC6lpqpYOvKdjX8PXA9I/dxetjEiA=
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
This doesn't work currently as expected. No HE rates are used between
the two HE mesh peers:

    root@OpenWrt:/# cat /sys/kernel/debug/ieee80211/phy2/netdev:mesh2/stations/00:03:7f:12:bb:97/he_capa
    HE supported
    MAC-CAP: 0x09 0x0d 0x08 0x0a 0x40 0x00
                    HTC-HE
                    DYNAMIC-FRAG-LEVEL-1
                    MAX-NUM-FRAG-MSDU-1
                    MIN-FRAG-SIZE-128
                    TF-MAC-PAD-DUR-24US
                    MULTI-TID-AGG-RX-QOS-1
                    LINK-ADAPTATION-NO-FEEDBACK
                    BSR
                    OMI-CONTROL
                    MAX-AMPDU-LEN-EXP-VHT-1
                    AMSDU-IN-AMPDU
                    MULTI-TID-AGG-TX-QOS-0
    PHY CAP: 0x1c 0x70 0x0c 0x80 0x0d 0x43 0x81 0x1c 0x00 0x00 0x00
                    CHANNEL-WIDTH-SET-40MHZ-80MHZ-IN-5G
                    CHANNEL-WIDTH-SET-160MHZ-IN-5G
                    CHANNEL-WIDTH-SET-80PLUS80-MHZ-IN-5G
                    IEEE80211-HE-PHY-CAP1-DEVICE-CLASS-A
                    LDPC-CODING-IN-PAYLOAD
                    HY-CAP1-HE-LTF-AND-GI-FOR-HE-PPDUS-0-8US
                    MIDAMBLE-RX-MAX-NSTS-0
                    STBC-TX-UNDER-80MHZ
                    STBC-RX-UNDER-80MHZ
                    DCM-MAX-CONST-TX-NO-DCM
                    DCM-MAX-CONST-RX-NO-DCM
                    SU-BEAMFORMER
                    SU-BEAMFORMEE
                    BEAMFORMEE-MAX-STS-UNDER-7
                    BEAMFORMEE-MAX-STS-ABOVE-4
                    NUM-SND-DIM-UNDER-80MHZ-4
                    NUM-SND-DIM-ABOVE-80MHZ-1
                    NG16-SU-FEEDBACK
                    CODEBOOK-SIZE-42-SU
                    PPE-THRESHOLD-PRESENT
                    HE-SU-MU-PPDU-4XLTF-AND-08-US-GI
                    MAX-NC-4
                    DCM-MAX-RU-242
                    NOMINAL-PACKET-PADDING-0US
    RX-MCS-80: 0xffaa
                    RX-MCS-80-0-SUPPORT-0-11
                    RX-MCS-80-1-SUPPORT-0-11
                    RX-MCS-80-2-SUPPORT-0-11
                    RX-MCS-80-3-SUPPORT-0-11
    TX-MCS-80: 0xffaa
                    TX-MCS-80-0-SUPPORT-0-11
                    TX-MCS-80-1-SUPPORT-0-11
                    TX-MCS-80-2-SUPPORT-0-11
                    TX-MCS-80-3-SUPPORT-0-11
    RX-MCS-160: 0xfffa
                    RX-MCS-160-0-SUPPORT-0-11
                    RX-MCS-160-1-SUPPORT-0-11
                    RX-MCS-160-2-NOT-SUPPORTED
                    RX-MCS-160-3-NOT-SUPPORTED
    TX-MCS-160: 0xfffa
                    TX-MCS-160-0-SUPPORT-0-11
                    TX-MCS-160-1-SUPPORT-0-11
                    TX-MCS-160-2-NOT-SUPPORTED
                    TX-MCS-160-3-NOT-SUPPORTED
    RX-MCS-80P80: 0xfffa
                    RX-MCS-80P80-0-SUPPORT-0-11
                    RX-MCS-80P80-1-SUPPORT-0-11
                    RX-MCS-80P80-2-NOT-SUPPORTED
                    RX-MCS-80P80-3-NOT-SUPPORTED
    TX-MCS-80P80: 0xfffa
                    TX-MCS-80P80-0-SUPPORT-0-11
                    TX-MCS-80P80-1-SUPPORT-0-11
                    TX-MCS-80P80-2-NOT-SUPPORTED
                    TX-MCS-80P80-3-NOT-SUPPORTED
    PPE-THRESHOLDS: 0x3b 0x1c 0xc7 0x71 0x1c 0xc7 0x71 0x1c 0xc7 0x71
    root@OpenWrt:/# iw dev mesh2 station dump
    Station 00:03:7f:12:bb:97 (on mesh2)
            inactive time:  310 ms
            rx bytes:       161064
            rx packets:     1619
            tx bytes:       55454
            tx packets:     477
            tx retries:     405
            tx failed:      0
            rx drop misc:   6
            signal:         -95 dBm
            signal avg:     -67 dBm
            tx bitrate:     1733.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 4
            rx bitrate:     1733.3 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 4
            rx duration:    0 us
            mesh llid:      0
            mesh plid:      0
            mesh plink:     ESTAB
            mesh local PS mode:     ACTIVE
            mesh peer PS mode:      ACTIVE
            mesh non-peer PS mode:  ACTIVE
            authorized:     yes
            authenticated:  yes
            associated:     yes
            preamble:       long
            WMM/WME:        yes
            MFP:            no
            TDLS peer:      no
            DTIM period:    2
            beacon interval:1000
            connected time: 536 seconds

 drivers/net/wireless/ath/ath11k/mac.c | 56 +++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 13da2e8262ba..7dcf4bb896b5 100644
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
-- 
2.20.1

