Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0F39CDED
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jun 2021 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhFFHxF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Jun 2021 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhFFHxF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Jun 2021 03:53:05 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F4DC061766
        for <linux-wireless@vger.kernel.org>; Sun,  6 Jun 2021 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3TYLAwAr9BYAZhu8Z8iErL3tTOVG8cYhBABdtRu4tW4=; b=PSzEVMHTtx07ROI7LUlVZzhzgX
        XclZ2buOs3xxMa0lIZtGIbPmmk9SUKBRVlNimSYfPzJQLYC3TR7fc5VFtd++/URKv2MQRp8mmGn1Y
        11xBkHZTI6RQ1yFqIwbGXfnIgFsr12SsrSb/JOn4tIZ7DL9fhwQQhSZRzWhJCzcabLbg=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lpnYu-0007dP-IQ; Sun, 06 Jun 2021 09:51:12 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     deren.wu@mediatek.com
Subject: [PATCH v2] mt76: mt7921: enable VHT BFee capability
Date:   Sun,  6 Jun 2021 09:51:07 +0200
Message-Id: <20210606075107.343-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enables VHT beamformee functionality

Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 19ce9ca72542..021abd75e522 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -215,7 +215,11 @@ int mt7921_register_device(struct mt7921_dev *dev)
 			IEEE80211_HT_CAP_MAX_AMSDU;
 	dev->mphy.sband_5g.sband.vht_cap.cap |=
 			IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
-			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
+			IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
+			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+			IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+			(3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 
-- 
2.30.1

