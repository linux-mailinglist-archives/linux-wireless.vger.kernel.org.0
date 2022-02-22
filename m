Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F934C01B7
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 19:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiBVS4A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 13:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiBVSz7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 13:55:59 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AA71375A3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 10:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=cz7oTX+tNcSrxjxfR8ibQf1myutfFkfLCok18Ju3vuU=; t=1645556133; x=1646765733; 
        b=jhMUItTZDcQl633GyAWENhmmZPY8v6MU1XVxZCAc7xjC95H2brhS0Z2T/posM1TiuiDA6W18AeH
        eUxHxHcM7HWUZR2j/7rCELVp7yunQXPoZ86oI29RafahBIRG99BzC6/kLLUKmGZ16U8cOQAsWNpxX
        pUejN+Y5VRwnp6dbB5rEGXUOS+w/ZKGiBp7CvuZEtTgINam71dLp8TqIRvv06JAK1iZ/xbE4MjcEi
        lW2oXVZ+9G28h2EyGlXspU7NLCf7FgAB9tx+4l9hFf2dPgfgaf26AnCZQAi2LChIOLjAjwwIDcBg0
        tThFhTp82CmqrfLvaE6eyLEPeuFDbWbZELYw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nMaJs-004MQL-IQ;
        Tue, 22 Feb 2022 19:55:28 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] rtw89: fix HE PHY bandwidth capability
Date:   Tue, 22 Feb 2022 19:55:25 +0100
Message-Id: <20220222195524.1e3cc6f7e4c3.I72ea8a9cad5eff93bcb3a0912727d03605ddb6e6@changeid>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Bit 0 is reserved on 5/6 GHz and bit 1 is reserved on 2.4 GHz,
so the driver should only set the non-reserved bits according
to band.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a0737eea9f81..1f0bea9a148c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2087,8 +2087,12 @@ static void rtw89_init_he_cap(struct rtw89_dev *rtwdev,
 				  IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
 		if (i == NL80211_IFTYPE_STATION)
 			mac_cap_info[5] = IEEE80211_HE_MAC_CAP5_HT_VHT_TRIG_FRAME_RX;
-		phy_cap_info[0] = IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
-				  IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+		if (band == NL80211_BAND_2GHZ)
+			phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+		else
+			phy_cap_info[0] =
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
 		phy_cap_info[1] = IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
 				  IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD |
 				  IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US;
-- 
2.35.1

