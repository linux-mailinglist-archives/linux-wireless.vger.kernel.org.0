Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D0F733F6
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 18:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGXQeV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 12:34:21 -0400
Received: from dvalin.narfation.org ([213.160.73.56]:39136 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGXQeU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 12:34:20 -0400
Received: from sven-desktop.home.narfation.org (p200300C5970DABFC00000000000002FB.dip0.t-ipconnect.de [IPv6:2003:c5:970d:abfc::2fb])
        by dvalin.narfation.org (Postfix) with ESMTPSA id D268A2030E;
        Wed, 24 Jul 2019 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1563986056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWSd1eOHto5j2/qhL2QLoexxVltDSUsW2tdTq0nUnsY=;
        b=SwjZQrHnB2BK9CffExhXYLqm5bncgrBvKSDv9sfrUMZZokHlP4lv4s7l5vlhlhYC3hr8pr
        S26bv3I/zyvI99JTeGQqN4BpTvIuMHz655smKKcEOFLtp5NLTFdupXhf4rAz9wNUB6eIPd
        2713bd6ZLSzjNEsabDevfnJtMsiLigQ=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <seckelmann@datto.com>
Subject: [PATCH 2/2] mac80211_hwsim: Register support for HE meshpoint
Date:   Wed, 24 Jul 2019 18:33:57 +0200
Message-Id: <20190724163359.3507-3-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724163359.3507-1-sven@narfation.org>
References: <20190724163359.3507-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1563986056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWSd1eOHto5j2/qhL2QLoexxVltDSUsW2tdTq0nUnsY=;
        b=2gZ9489FisbZf2udk/MtuUN3Cq+gUMNj2zJdQTfkpzPGLj5wwQ0+4URaCc8nif3WfxbRbR
        KyXcL4223dAb4jO1CIt1w2BhZZUAYfw4zlJf4iXf+xgS7JoEbKCpPHcNYW7ggQMd6TbqjO
        hFRDk3yETlequljLZZ4QkkR4vDU3Mh8=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1563986056; a=rsa-sha256;
        cv=none;
        b=VHEa89f7Q/+kdQpDLh8dVmyJNLsy0UCFosuGZHMvzviiTzsl+yHMHyify9XZQAWBwAmJ1W
        gVil7MqgdNxgdfzkJUTa1kMYtcYBAkM9TNim9DbzoJbQ41pu/bLGDAfnmlMzTarnQFlKUU
        /4GsifLZCkN2DYogkLQrFYhwE67jtqg=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sven Eckelmann <seckelmann@datto.com>

Some features of 802.11ax without central organizing (AP) STA can also be
used in mesh mode. hwsim can be used to assist initial development of these
features without having access to HW.

Signed-off-by: Sven Eckelmann <seckelmann@datto.com>

Forwarded: https://patchwork.kernel.org/patch/11029301/
---
 drivers/net/wireless/mac80211_hwsim.c | 283 +++++++++++++++++---------
 1 file changed, 189 insertions(+), 94 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 519b4ee88c5c..a3913b75d715 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2496,116 +2496,211 @@ static void hwsim_mcast_new_radio(int id, struct genl_info *info,
 	nlmsg_free(mcast_skb);
 }
 
-static const struct ieee80211_sband_iftype_data he_capa_2ghz = {
-	/* TODO: should we support other types, e.g., P2P?*/
-	.types_mask = BIT(NL80211_IFTYPE_STATION) | BIT(NL80211_IFTYPE_AP),
-	.he_cap = {
-		.has_he = true,
-		.he_cap_elem = {
-			.mac_cap_info[0] =
-				IEEE80211_HE_MAC_CAP0_HTC_HE,
-			.mac_cap_info[1] =
-				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US |
-				IEEE80211_HE_MAC_CAP1_MULTI_TID_AGG_RX_QOS_8,
-			.mac_cap_info[2] =
-				IEEE80211_HE_MAC_CAP2_BSR |
-				IEEE80211_HE_MAC_CAP2_MU_CASCADING |
-				IEEE80211_HE_MAC_CAP2_ACK_EN,
-			.mac_cap_info[3] =
-				IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-				IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
-			.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
-			.phy_cap_info[1] =
-				IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
-				IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
-				IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
-				IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS,
-			.phy_cap_info[2] =
-				IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
-				IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
-				IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
-				IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
-				IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO,
-
-			/* Leave all the other PHY capability bytes unset, as
-			 * DCM, beam forming, RU and PPE threshold information
-			 * are not supported
-			 */
+static const struct ieee80211_sband_iftype_data he_capa_2ghz[] = {
+	{
+		/* TODO: should we support other types, e.g., P2P?*/
+		.types_mask = BIT(NL80211_IFTYPE_STATION) |
+			      BIT(NL80211_IFTYPE_AP),
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
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
+				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
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
+				.rx_mcs_160 = cpu_to_le16(0xffff),
+				.tx_mcs_160 = cpu_to_le16(0xffff),
+				.rx_mcs_80p80 = cpu_to_le16(0xffff),
+				.tx_mcs_80p80 = cpu_to_le16(0xffff),
+			},
 		},
-		.he_mcs_nss_supp = {
-			.rx_mcs_80 = cpu_to_le16(0xfffa),
-			.tx_mcs_80 = cpu_to_le16(0xfffa),
-			.rx_mcs_160 = cpu_to_le16(0xffff),
-			.tx_mcs_160 = cpu_to_le16(0xffff),
-			.rx_mcs_80p80 = cpu_to_le16(0xffff),
-			.tx_mcs_80p80 = cpu_to_le16(0xffff),
+	},
+#ifdef CONFIG_MAC80211_MESH
+	{
+		/* TODO: should we support other types, e.g., IBSS?*/
+		.types_mask = BIT(NL80211_IFTYPE_MESH_POINT),
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
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
+				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
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
+				.rx_mcs_160 = cpu_to_le16(0xffff),
+				.tx_mcs_160 = cpu_to_le16(0xffff),
+				.rx_mcs_80p80 = cpu_to_le16(0xffff),
+				.tx_mcs_80p80 = cpu_to_le16(0xffff),
+			},
 		},
 	},
+#endif
 };
 
-static const struct ieee80211_sband_iftype_data he_capa_5ghz = {
-	/* TODO: should we support other types, e.g., P2P?*/
-	.types_mask = BIT(NL80211_IFTYPE_STATION) | BIT(NL80211_IFTYPE_AP),
-	.he_cap = {
-		.has_he = true,
-		.he_cap_elem = {
-			.mac_cap_info[0] =
-				IEEE80211_HE_MAC_CAP0_HTC_HE,
-			.mac_cap_info[1] =
-				IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US |
-				IEEE80211_HE_MAC_CAP1_MULTI_TID_AGG_RX_QOS_8,
-			.mac_cap_info[2] =
-				IEEE80211_HE_MAC_CAP2_BSR |
-				IEEE80211_HE_MAC_CAP2_MU_CASCADING |
-				IEEE80211_HE_MAC_CAP2_ACK_EN,
-			.mac_cap_info[3] =
-				IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-				IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
-			.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
-			.phy_cap_info[0] =
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G,
-			.phy_cap_info[1] =
-				IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
-				IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
-				IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
-				IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS,
-			.phy_cap_info[2] =
-				IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
-				IEEE80211_HE_PHY_CAP2_STBC_TX_UNDER_80MHZ |
-				IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ |
-				IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
-				IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO,
-
-			/* Leave all the other PHY capability bytes unset, as
-			 * DCM, beam forming, RU and PPE threshold information
-			 * are not supported
-			 */
+static const struct ieee80211_sband_iftype_data he_capa_5ghz[] = {
+	{
+		/* TODO: should we support other types, e.g., P2P?*/
+		.types_mask = BIT(NL80211_IFTYPE_STATION) |
+			      BIT(NL80211_IFTYPE_AP),
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
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
+				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
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
 		},
-		.he_mcs_nss_supp = {
-			.rx_mcs_80 = cpu_to_le16(0xfffa),
-			.tx_mcs_80 = cpu_to_le16(0xfffa),
-			.rx_mcs_160 = cpu_to_le16(0xfffa),
-			.tx_mcs_160 = cpu_to_le16(0xfffa),
-			.rx_mcs_80p80 = cpu_to_le16(0xfffa),
-			.tx_mcs_80p80 = cpu_to_le16(0xfffa),
+	},
+#ifdef CONFIG_MAC80211_MESH
+	{
+		/* TODO: should we support other types, e.g., IBSS?*/
+		.types_mask = BIT(NL80211_IFTYPE_MESH_POINT),
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
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
+				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
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
 		},
 	},
+#endif
 };
 
 static void mac80211_hswim_he_capab(struct ieee80211_supported_band *sband)
 {
-	if (sband->band == NL80211_BAND_2GHZ)
+	u16 n_iftype_data;
+
+	if (sband->band == NL80211_BAND_2GHZ) {
+		n_iftype_data = ARRAY_SIZE(he_capa_2ghz);
 		sband->iftype_data =
-			(struct ieee80211_sband_iftype_data *)&he_capa_2ghz;
-	else if (sband->band == NL80211_BAND_5GHZ)
+			(struct ieee80211_sband_iftype_data *)he_capa_2ghz;
+	} else if (sband->band == NL80211_BAND_5GHZ) {
+		n_iftype_data = ARRAY_SIZE(he_capa_5ghz);
 		sband->iftype_data =
-			(struct ieee80211_sband_iftype_data *)&he_capa_5ghz;
-	else
+			(struct ieee80211_sband_iftype_data *)he_capa_5ghz;
+	} else {
 		return;
+	}
 
-	sband->n_iftype_data = 1;
+	sband->n_iftype_data = n_iftype_data;
 }
 
 #ifdef CONFIG_MAC80211_MESH
-- 
2.20.1

