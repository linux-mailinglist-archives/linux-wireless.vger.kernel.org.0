Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFEE76A81E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 07:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjHAFAP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 01:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjHAFAL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 01:00:11 -0400
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B651FC8
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 22:00:10 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id E4CC046D1E;
        Tue,  1 Aug 2023 08:00:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 40Ji1unDfW20-4uyQ2W04;
        Tue, 01 Aug 2023 08:00:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690866007;
        bh=VEn6iO0BoxDlCVA90xiICa5ns7TdRaqzC1bK670kNsg=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=mDWq1FaArXIBoauCUmK21IZlwObiFAzMGy2ao3AK3wqZFIzp7oTRCxvgwHJbmPRFZ
         we2d5sS6kY9lfJbh+mMsaRIfCu/3AOoqE+x3bID6CZas7IAAMLeCKpJLEX82kGazcm
         62rMXy/HkUyB+aMZY4bq1s0zkFYKKhD5/spigNNY=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/4] wifi: mt76: handle possible hardware timeout in mt76x0_phy_tssi_dc_calibrate()
Date:   Tue,  1 Aug 2023 07:57:22 +0300
Message-ID: <20230801050000.18864-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801050000.18864-1-dmantipov@yandex.ru>
References: <20230801050000.18864-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check for (and hopefully recover from) possible 'mt76_poll_msec()'
timeout in 'mt76x0_phy_tssi_dc_calibrate()' as it's done in
'mt76x0_phy_tssi_adc_calibrate()', convert the subject from 'void'
to return 'int' and 'WARN_ON()' on it in 'mt76x0_phy_calibrate()'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index d543ef3de65b..99e4b24e258d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -500,7 +500,7 @@ mt76x0_phy_bbp_set_bw(struct mt76x02_dev *dev, enum nl80211_chan_width width)
 	mt76x02_mcu_function_select(dev, BW_SETTING, bw);
 }
 
-static void mt76x0_phy_tssi_dc_calibrate(struct mt76x02_dev *dev)
+static int mt76x0_phy_tssi_dc_calibrate(struct mt76x02_dev *dev)
 {
 	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	u32 val;
@@ -523,7 +523,11 @@ static void mt76x0_phy_tssi_dc_calibrate(struct mt76x02_dev *dev)
 	/* enable TX with DAC0 input */
 	mt76_wr(dev, MT_BBP(TXBE, 6), BIT(31));
 
-	mt76_poll_msec(dev, MT_BBP(CORE, 34), BIT(4), 0, 200);
+	if (!mt76_poll_msec(dev, MT_BBP(CORE, 34), BIT(4), 0, 200)) {
+		mt76_clear(dev, MT_BBP(CORE, 34), BIT(4));
+		return -ETIMEDOUT;
+	}
+
 	dev->cal.tssi_dc = mt76_rr(dev, MT_BBP(CORE, 35)) & 0xff;
 
 	/* stop bypass ADDA */
@@ -537,6 +541,8 @@ static void mt76x0_phy_tssi_dc_calibrate(struct mt76x02_dev *dev)
 
 	if (chan->band == NL80211_BAND_5GHZ)
 		mt76x0_rf_rmw(dev, MT_RF(0, 67), 0xf, 0x4);
+
+	return 0;
 }
 
 static int
@@ -875,7 +881,7 @@ void mt76x0_phy_calibrate(struct mt76x02_dev *dev, bool power_on)
 		if (mt76x0_tssi_enabled(dev)) {
 			mt76_wr(dev, MT_MAC_SYS_CTRL,
 				MT_MAC_SYS_CTRL_ENABLE_RX);
-			mt76x0_phy_tssi_dc_calibrate(dev);
+			WARN_ON(mt76x0_phy_tssi_dc_calibrate(dev) < 0);
 			mt76_wr(dev, MT_MAC_SYS_CTRL,
 				MT_MAC_SYS_CTRL_ENABLE_TX |
 				MT_MAC_SYS_CTRL_ENABLE_RX);
-- 
2.41.0

