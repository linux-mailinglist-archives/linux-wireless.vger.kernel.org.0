Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20665394244
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbhE1MEo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 08:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbhE1MEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 08:04:43 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A850C061574
        for <linux-wireless@vger.kernel.org>; Fri, 28 May 2021 05:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Hepp8KdyzuMxA2jxSpOeNzfUtZdFfRzYq1qwP9/jflM=; b=eYdgBDExznM72nR0m4jR3hmXX4
        XylUJEz58B7Koie/VWhhR2JDN+78TaLetFh9d/rJ7xlCbS3lTwJoFZ5tnjHPFAZaZ67vObx3yw0/D
        zH49EcddTD2p+DCqET/L3iKAH7BfeXZgx0QJ2fQXL5iFnyvHK4s2X10X2XhQ+51H6mq4=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lmbCk-0000WG-EW; Fri, 28 May 2021 14:03:06 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH 5.13] mt76: mt7921: remove leftover 80+80 HE capability
Date:   Fri, 28 May 2021 14:03:04 +0200
Message-Id: <20210528120304.34751-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes interop issues with some APs that disable HE Tx if this is present

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index f4c27aa41048..97a0ef331ac3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -74,8 +74,7 @@ mt7921_init_he_caps(struct mt7921_phy *phy, enum nl80211_band band,
 				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
 		else if (band == NL80211_BAND_5GHZ)
 			he_cap_elem->phy_cap_info[0] =
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
-				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+				IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
 
 		he_cap_elem->phy_cap_info[1] =
 			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
-- 
2.30.1

