Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0386F1B497D
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDVQEp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 12:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgDVQEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 12:04:43 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856BC08E859
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1ycAbR2Pvs+JyTWeJ6ogIB87xV5giRRUC/7HdZc4DNE=; b=eeSyUZeihb10iJG3VTxMWnFMj+
        MLX0TvQRSsgXru/LX5il0wnefM2sFIx9p03DMn/nIw32MeTLaW/EBZ8oLj2o1MU0Wax+NcvBXGXIs
        2p0DRwPgCWewZli+5twB2D6k3FtZXh1tB/TG3eIFz+iI6OOJ364f5ckjzJQrNl50kqGY=;
Received: from p54ae965b.dip0.t-ipconnect.de ([84.174.150.91] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jRHrb-000556-Ut
        for linux-wireless@vger.kernel.org; Wed, 22 Apr 2020 18:04:40 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 9F92C841962E; Wed, 22 Apr 2020 18:04:38 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 5/9] mt76: mt7603: never use an 802.11b CF-End rate on 5GHz
Date:   Wed, 22 Apr 2020 18:04:33 +0200
Message-Id: <20200422160437.99466-5-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200422160437.99466-1-nbd@nbd.name>
References: <20200422160437.99466-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sometimes mt7615_mac_set_timing gets called while the slot time is still
configured to 20. Ensure that in this case it always uses the OFDM CFend
rate.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 73c6a3ff399c..d34828715e1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -51,10 +51,11 @@ void mt7603_mac_set_timing(struct mt7603_dev *dev)
 	int offset = 3 * dev->coverage_class;
 	u32 reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
 			 FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
+	bool is_5ghz = dev->mphy.chandef.chan->band == NL80211_BAND_5GHZ;
 	int sifs;
 	u32 val;
 
-	if (dev->mphy.chandef.chan->band == NL80211_BAND_5GHZ)
+	if (is_5ghz)
 		sifs = 16;
 	else
 		sifs = 10;
@@ -71,7 +72,7 @@ void mt7603_mac_set_timing(struct mt7603_dev *dev)
 		FIELD_PREP(MT_IFS_SIFS, sifs) |
 		FIELD_PREP(MT_IFS_SLOT, dev->slottime));
 
-	if (dev->slottime < 20)
+	if (dev->slottime < 20 || is_5ghz)
 		val = MT7603_CFEND_RATE_DEFAULT;
 	else
 		val = MT7603_CFEND_RATE_11B;
-- 
2.24.0

