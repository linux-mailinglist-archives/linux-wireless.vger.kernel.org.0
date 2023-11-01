Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2DD7DE062
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 12:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjKALgJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 07:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjKALgI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 07:36:08 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B669FD
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 04:36:01 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1f22:0:640:93cc:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 03D9160A63;
        Wed,  1 Nov 2023 14:35:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rZUntIRDWGk0-f3LJ4w82;
        Wed, 01 Nov 2023 14:35:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698838555; bh=BgMIquzgr2FzCtVMNyQVnh6Qc0UW+oo58AAmi9AQHKI=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=d8CZB/P7YyOCnourIKWkUOUFRAgKaD3sk/zOdRZp1gMpJm6X1+4jTDTd/DofbrfyY
         nu5fG3q5cJ32E5oGjwbs+HK42IF7FeGCSVVj5SUZj7owBXTXE3h6QZCsb0lDmuWT1C
         hHWtd15J618lxnJiCPFRVD/BVzHsll3BQMIWNn20=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: rtlwifi: simplify _rtl8812ae_phy_get_txpower_limit()
Date:   Wed,  1 Nov 2023 14:35:07 +0300
Message-ID: <20231101113510.51290-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101113510.51290-1-dmantipov@yandex.ru>
References: <20231101113510.51290-1-dmantipov@yandex.ru>
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

Since 'regulation' is a compile-time constant equal to
'TXPWR_LMT_WW', mark it as such and simplify few branches
in '_rtl8812ae_phy_get_txpower_limit()'. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/realtek/rtlwifi/rtl8821ae/phy.c  | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index c262770fea29..27e256a82f00 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -2278,16 +2278,15 @@ static s8 _rtl8812ae_phy_get_txpower_limit(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtlpriv);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
-	short band_temp = -1, regulation = -1, bandwidth_temp = -1,
-		 rate_section = -1, channel_temp = -1;
-	u16 regu, bdwidth, sec, chnl;
+	short band_temp = -1, bandwidth_temp = -1,
+		rate_section = -1, channel_temp = -1;
+	u16 bdwidth, sec, chnl;
 	s8 power_limit = MAX_POWER_INDEX;
+	const short regulation = TXPWR_LMT_WW;
 
 	if (rtlefuse->eeprom_regulatory == 2)
 		return MAX_POWER_INDEX;
 
-	regulation = TXPWR_LMT_WW;
-
 	if (band == BAND_ON_2_4G)
 		band_temp = 0;
 	else if (band == BAND_ON_5G)
@@ -2393,8 +2392,8 @@ static s8 _rtl8812ae_phy_get_txpower_limit(struct ieee80211_hw *hw,
 		;/* BAND_ON_BOTH don't care temporarily */
 	}
 
-	if (band_temp == -1 || regulation == -1 || bandwidth_temp == -1 ||
-		rate_section == -1 || channel_temp == -1) {
+	if (band_temp == -1 || bandwidth_temp == -1 ||
+	    rate_section == -1 || channel_temp == -1) {
 		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
 			"Wrong index value to access power limit table [band %d][regulation %d][bandwidth %d][rf_path %d][rate_section %d][chnl %d]\n",
 			band_temp, regulation, bandwidth_temp, rf_path,
@@ -2402,7 +2401,6 @@ static s8 _rtl8812ae_phy_get_txpower_limit(struct ieee80211_hw *hw,
 		return MAX_POWER_INDEX;
 	}
 
-	regu = regulation;
 	bdwidth = bandwidth_temp;
 	sec = rate_section;
 	chnl = channel_temp;
@@ -2415,10 +2413,7 @@ static s8 _rtl8812ae_phy_get_txpower_limit(struct ieee80211_hw *hw,
 			limits[i] = rtlphy->txpwr_limit_2_4g[i][bdwidth]
 			[sec][chnl][rf_path];
 
-		power_limit = (regulation == TXPWR_LMT_WW) ?
-			_rtl8812ae_phy_get_world_wide_limit(limits) :
-			rtlphy->txpwr_limit_2_4g[regu][bdwidth]
-					[sec][chnl][rf_path];
+		power_limit = _rtl8812ae_phy_get_world_wide_limit(limits);
 	} else if (band == BAND_ON_5G) {
 		s8 limits[10] = {0};
 		u8 i;
@@ -2427,10 +2422,7 @@ static s8 _rtl8812ae_phy_get_txpower_limit(struct ieee80211_hw *hw,
 			limits[i] = rtlphy->txpwr_limit_5g[i][bdwidth]
 			[sec][chnl][rf_path];
 
-		power_limit = (regulation == TXPWR_LMT_WW) ?
-			_rtl8812ae_phy_get_world_wide_limit(limits) :
-			rtlphy->txpwr_limit_5g[regu][chnl]
-			[sec][chnl][rf_path];
+		power_limit = _rtl8812ae_phy_get_world_wide_limit(limits);
 	} else {
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 			"No power limit table of the specified band\n");
-- 
2.41.0

