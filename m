Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C203E376342
	for <lists+linux-wireless@lfdr.de>; Fri,  7 May 2021 12:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhEGKDT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 May 2021 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbhEGKDS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 May 2021 06:03:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF939C061761
        for <linux-wireless@vger.kernel.org>; Fri,  7 May 2021 03:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Nc0lQ5nnkCdm/LVtPMzE9G39GGJD3o2V5iCmOSN2xUU=; b=Pj8Wjwf3MI2lJHYAEmHhD0+jZN
        YC3Cr/MtECWObi2RKsQOYuGE1qdKvt6X7asHWlMNP3ed99rRhbjD9UcghfxGWrZ4mlRdVaofh7gh+
        djxWIrfyqbhAy/BAozoCNs7N1YsQXSqvDnYs9wqX1CgfQ70N81ecqv0arucx346GfKs4=;
Received: from p4ff13bc6.dip0.t-ipconnect.de ([79.241.59.198] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lexJI-0003bF-32; Fri, 07 May 2021 12:02:16 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@codeaurora.org
Subject: [PATCH 5.13 2/2] mt76: mt7921: fix max aggregation subframes setting
Date:   Fri,  7 May 2021 12:02:11 +0200
Message-Id: <20210507100211.15709-2-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210507100211.15709-1-nbd@nbd.name>
References: <20210507100211.15709-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The hardware can only handle 64 subframes in rx direction and 128 for tx.
Improves throughput with APs that can handle more than that

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index fe28bf4050c4..1763ea0614ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -76,8 +76,8 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	struct wiphy *wiphy = hw->wiphy;
 
 	hw->queues = 4;
-	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
-	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+	hw->max_rx_aggregation_subframes = 64;
+	hw->max_tx_aggregation_subframes = 128;
 
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
-- 
2.30.1

