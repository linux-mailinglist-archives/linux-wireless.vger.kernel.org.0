Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F15416533
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 20:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbhIWS3p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 14:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbhIWS3o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 14:29:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C0AC061574;
        Thu, 23 Sep 2021 11:28:12 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id j13so7082580qtq.6;
        Thu, 23 Sep 2021 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYnb5ab4lp0ROjl6/6NT8Tp6t+DQKceitF9LWDOIDoA=;
        b=BTZY7dEu9PSwyWJgCpleiuPCpeKSsMa4O1GTGrNe+ShXG1VdwfjZYjH9NKikLYOTqR
         ZoaX+psqkvq1yQn1sy5MJr0mPI3wCCX3L44rPeX6CavnCbw/VdITYpi1hVCOOetk9DLz
         9c502/ERtL6Uol+ycu/ZQ4DYKhAyxW4knizeQTNzZzH3nqfn2ezaNAT6wnEb4hG80eNx
         w3G1EM8cVU0j2/GRJwcQsDzPx2vB4fCsLJlMrGW8Xj/YIg5ISuBlimYFZECGeMb4nVpw
         yOAImdxfyBGdgMrU3Bfcwlig4XIpA52bIFvVtAdZINn8v6YWvHDJGN3EGzDqlFFvuqts
         VacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYnb5ab4lp0ROjl6/6NT8Tp6t+DQKceitF9LWDOIDoA=;
        b=6A3UiTTBWltbW1Fqexf2atcJxhJz5MV34tUum//LOSj6iFNT5QLGPm+iVmtYQ9UfBj
         /RhCGDmUekHkc1OWmhUmVrQ5pVu9NOFZIvKccjwS+kDbE/Q1fWsulFFMgwuU9gPWxXJT
         hUoFigY2OwBZ3ZeoDpMzpkm87kfLnwW8OJk9i64SoKfnth3L08AHtH4ef3MwLPywreJ3
         5+xruUCdOMamg51w18QLU8T7SeOUtdSZox5omApowrgOw/kPZbwQooUXEogQ8flwR+eL
         NKzNpD7MYXx2ZyBI949ixzeerFA4vDSJ9jtzide6QPRsu15G6UGt0vl8nPb7YIROi6lx
         bAtw==
X-Gm-Message-State: AOAM533NrBRwMS71DgZNbdwjqyuCh31hAV/0JjSiEJkolvvuPMtS8Dmi
        /j7YdwkhA4NpG+fHX4j31wpXBxJzDZb7vA==
X-Google-Smtp-Source: ABdhPJxrigMHTVkDkmCHzNd2Kc6K+hdfoRtLjyNxUNk34+qVcBCGdzlUalVNDLhY9/BHeqIqLXF89A==
X-Received: by 2002:ac8:4d48:: with SMTP id x8mr86324qtv.415.1632421691108;
        Thu, 23 Sep 2021 11:28:11 -0700 (PDT)
Received: from localhost.localdomain ([170.84.227.206])
        by smtp.gmail.com with ESMTPSA id bj31sm4570971qkb.43.2021.09.23.11.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 11:28:10 -0700 (PDT)
From:   Ramon Fontes <ramonreisfontes@gmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, kvalo@codeaurora.org,
        davem@davemloft.net, Ramon Fontes <ramonreisfontes@gmail.com>
Subject: [PATCH] mac80211_hwsim: enable 6GHz channels
Date:   Thu, 23 Sep 2021 15:28:05 -0300
Message-Id: <20210923182805.27122-1-ramonreisfontes@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This adds 6 GHz capabilities and reject HT/VHT

Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 154 +++++++++++++++++++++++---
 1 file changed, 141 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index ffa894f73..a11eb730e 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2988,6 +2988,122 @@ static const struct ieee80211_sband_iftype_data he_capa_5ghz[] = {
 #endif
 };
 
+static const struct ieee80211_sband_iftype_data he_capa_6ghz[] = {
+	{
+		/* TODO: should we support other types, e.g., P2P?*/
+		.types_mask = BIT(NL80211_IFTYPE_STATION) |
+			      BIT(NL80211_IFTYPE_AP),
+		.he_6ghz_capa = {
+			.capa = cpu_to_le16(IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START |
+					    IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP |
+					    IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN |
+					    IEEE80211_HE_6GHZ_CAP_SM_PS |
+					    IEEE80211_HE_6GHZ_CAP_RD_RESPONDER |
+					    IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS |
+					    IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS),
+		},
+		.he_cap = {
+			.has_he = true,
+			.he_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_HE_MAC_CAP0_HTC_HE,
+				.mac_cap_info[1] =
+					IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US |
+					IEEE80211_HE_MAC_CAP1_MULTI_TID_AGG_RX_QOS_8,
+				.mac_cap_info[2] =
+					IEEE80211_HE_MAC_CAP2_BSR |
+					IEEE80211_HE_MAC_CAP2_MU_CASCADING |
+					IEEE80211_HE_MAC_CAP2_ACK_EN,
+				.mac_cap_info[3] =
+					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
+				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
+				.phy_cap_info[0] =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G,
+				.phy_cap_info[1] =
+					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
+					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+					IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
+					IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS,
+				.phy_cap_info[2] =
+					IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+					IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
+					IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
+					IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
+					IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO,
+
+				/* Leave all the other PHY capability bytes
+				 * unset, as DCM, beam forming, RU and PPE
+				 * threshold information are not supported
+				 */
+			},
+			.he_mcs_nss_supp = {
+				.rx_mcs_80 = cpu_to_le16(0xfffa),
+				.tx_mcs_80 = cpu_to_le16(0xfffa),
+				.rx_mcs_160 = cpu_to_le16(0xfffa),
+				.tx_mcs_160 = cpu_to_le16(0xfffa),
+				.rx_mcs_80p80 = cpu_to_le16(0xfffa),
+				.tx_mcs_80p80 = cpu_to_le16(0xfffa),
+			},
+		},
+	},
+#ifdef CONFIG_MAC80211_MESH
+	{
+		/* TODO: should we support other types, e.g., IBSS?*/
+		.types_mask = BIT(NL80211_IFTYPE_MESH_POINT),
+		.he_6ghz_capa = {
+			.capa = cpu_to_le16(IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START |
+					    IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP |
+					    IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN |
+					    IEEE80211_HE_6GHZ_CAP_SM_PS |
+					    IEEE80211_HE_6GHZ_CAP_RD_RESPONDER |
+					    IEEE80211_HE_6GHZ_CAP_TX_ANTPAT_CONS |
+					    IEEE80211_HE_6GHZ_CAP_RX_ANTPAT_CONS),
+		},
+		.he_cap = {
+			.has_he = true,
+			.he_cap_elem = {
+				.mac_cap_info[0] =
+					IEEE80211_HE_MAC_CAP0_HTC_HE,
+				.mac_cap_info[1] =
+					IEEE80211_HE_MAC_CAP1_MULTI_TID_AGG_RX_QOS_8,
+				.mac_cap_info[2] =
+					IEEE80211_HE_MAC_CAP2_ACK_EN,
+				.mac_cap_info[3] =
+					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
+				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
+				.phy_cap_info[0] =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G,
+				.phy_cap_info[1] =
+					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
+					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
+					IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
+					IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS,
+				.phy_cap_info[2] = 0,
+
+				/* Leave all the other PHY capability bytes
+				 * unset, as DCM, beam forming, RU and PPE
+				 * threshold information are not supported
+				 */
+			},
+			.he_mcs_nss_supp = {
+				.rx_mcs_80 = cpu_to_le16(0xfffa),
+				.tx_mcs_80 = cpu_to_le16(0xfffa),
+				.rx_mcs_160 = cpu_to_le16(0xfffa),
+				.tx_mcs_160 = cpu_to_le16(0xfffa),
+				.rx_mcs_80p80 = cpu_to_le16(0xfffa),
+				.tx_mcs_80p80 = cpu_to_le16(0xfffa),
+			},
+		},
+	},
+#endif
+};
+
 static void mac80211_hwsim_he_capab(struct ieee80211_supported_band *sband)
 {
 	u16 n_iftype_data;
@@ -3000,6 +3116,10 @@ static void mac80211_hwsim_he_capab(struct ieee80211_supported_band *sband)
 		n_iftype_data = ARRAY_SIZE(he_capa_5ghz);
 		sband->iftype_data =
 			(struct ieee80211_sband_iftype_data *)he_capa_5ghz;
+	} else if (sband->band == NL80211_BAND_6GHZ) {
+		n_iftype_data = ARRAY_SIZE(he_capa_6ghz);
+		sband->iftype_data =
+			(struct ieee80211_sband_iftype_data *)he_capa_6ghz;
 	} else {
 		return;
 	}
@@ -3290,6 +3410,12 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			sband->vht_cap.vht_mcs.tx_mcs_map =
 				sband->vht_cap.vht_mcs.rx_mcs_map;
 			break;
+		case NL80211_BAND_6GHZ:
+			sband->channels = data->channels_6ghz;
+			sband->n_channels = ARRAY_SIZE(hwsim_channels_6ghz);
+			sband->bitrates = data->rates + 4;
+			sband->n_bitrates = ARRAY_SIZE(hwsim_rates) - 4;
+			break;
 		case NL80211_BAND_S1GHZ:
 			memcpy(&sband->s1g_cap, &hwsim_s1g_cap,
 			       sizeof(sband->s1g_cap));
@@ -3300,19 +3426,21 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			continue;
 		}
 
-		sband->ht_cap.ht_supported = true;
-		sband->ht_cap.cap = IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
-				    IEEE80211_HT_CAP_GRN_FLD |
-				    IEEE80211_HT_CAP_SGI_20 |
-				    IEEE80211_HT_CAP_SGI_40 |
-				    IEEE80211_HT_CAP_DSSSCCK40;
-		sband->ht_cap.ampdu_factor = 0x3;
-		sband->ht_cap.ampdu_density = 0x6;
-		memset(&sband->ht_cap.mcs, 0,
-		       sizeof(sband->ht_cap.mcs));
-		sband->ht_cap.mcs.rx_mask[0] = 0xff;
-		sband->ht_cap.mcs.rx_mask[1] = 0xff;
-		sband->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
+		if (band != NL80211_BAND_6GHZ){
+			sband->ht_cap.ht_supported = true;
+			sband->ht_cap.cap = IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
+					    IEEE80211_HT_CAP_GRN_FLD |
+					    IEEE80211_HT_CAP_SGI_20 |
+					    IEEE80211_HT_CAP_SGI_40 |
+					    IEEE80211_HT_CAP_DSSSCCK40;
+			sband->ht_cap.ampdu_factor = 0x3;
+			sband->ht_cap.ampdu_density = 0x6;
+			memset(&sband->ht_cap.mcs, 0,
+			       sizeof(sband->ht_cap.mcs));
+			sband->ht_cap.mcs.rx_mask[0] = 0xff;
+			sband->ht_cap.mcs.rx_mask[1] = 0xff;
+			sband->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
+		}
 
 		mac80211_hwsim_he_capab(sband);
 
-- 
2.25.1

