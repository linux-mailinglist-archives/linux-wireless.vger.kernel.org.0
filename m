Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F417DE061
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 12:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjKALgH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 07:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjKALgF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 07:36:05 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92C3F4
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 04:35:58 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1f22:0:640:93cc:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 62D8F60AD6;
        Wed,  1 Nov 2023 14:35:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rZUntIRDWGk0-XIMUE0WG;
        Wed, 01 Nov 2023 14:35:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698838554; bh=q7XayJDp2EEfGYhA/wtHBezPXBoFzojBE8mxq90BAzc=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=kEYD2XLUz5bikrh+rP+0ZyDwurSCsg/Cepd9nLyy+vv+X1BebC+u49NvgSRByuifq
         JLB0O265zZPTKUfkxRm7TlelxT1FCNFKQ3tBQEoyJQqYMggSXeMIB3dFAoSATW83PQ
         OiRT+2fh4vd1gELQZPGcKezuuf3y2pq1nz/tboZU=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: rtlwifi: remove dead code in phy_get_tx_swing_8812A()
Date:   Wed,  1 Nov 2023 14:35:06 +0300
Message-ID: <20231101113510.51290-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'reg_swing_2g', 'swing_2g', 'reg_swing_5g', and 'swing_5g'
are compile-time constants, mark all of them as such and remove
never executed blocks in 'phy_get_tx_swing_8812A()'. Minor style
adjustments, compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/realtek/rtlwifi/rtl8821ae/phy.c  | 77 ++++---------------
 1 file changed, 16 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 5323ead30db0..c262770fea29 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -437,12 +437,11 @@ u32 phy_get_tx_swing_8812A(struct ieee80211_hw *hw, u8	band,
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_dm *rtldm = rtl_dm(rtlpriv);
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	s8 reg_swing_2g = -1;/* 0xff; */
-	s8 reg_swing_5g = -1;/* 0xff; */
-	s8 swing_2g = -1 * reg_swing_2g;
-	s8 swing_5g = -1 * reg_swing_5g;
-	u32  out = 0x200;
-	const s8 auto_temp = -1;
+	const s8 reg_swing_2g = -1; /* 0xff; */
+	const s8 reg_swing_5g = -1; /* 0xff; */
+	const s8 swing_2g = -1 * reg_swing_2g;
+	const s8 swing_5g = -1 * reg_swing_5g;
+	u32 out = 0x200;
 
 	rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
 		"===> PHY_GetTXBBSwing_8812A, bbSwing_2G: %d, bbSwing_5G: %d,autoload_failflag=%d.\n",
@@ -452,36 +451,16 @@ u32 phy_get_tx_swing_8812A(struct ieee80211_hw *hw, u8	band,
 	if (rtlefuse->autoload_failflag) {
 		if (band == BAND_ON_2_4G) {
 			rtldm->swing_diff_2g = swing_2g;
-			if (swing_2g == 0) {
-				out = 0x200; /* 0 dB */
-			} else if (swing_2g == -3) {
-				out = 0x16A; /* -3 dB */
-			} else if (swing_2g == -6) {
-				out = 0x101; /* -6 dB */
-			} else if (swing_2g == -9) {
-				out = 0x0B6; /* -9 dB */
-			} else {
-				rtldm->swing_diff_2g = 0;
-				out = 0x200;
-			}
+			rtldm->swing_diff_2g = 0;
+			out = 0x200;
 		} else if (band == BAND_ON_5G) {
 			rtldm->swing_diff_5g = swing_5g;
-			if (swing_5g == 0) {
-				out = 0x200; /* 0 dB */
-			} else if (swing_5g == -3) {
-				out = 0x16A; /* -3 dB */
-			} else if (swing_5g == -6) {
-				out = 0x101; /* -6 dB */
-			} else if (swing_5g == -9) {
-				out = 0x0B6; /* -9 dB */
+			if (rtlhal->hw_type == HARDWARE_TYPE_RTL8821AE) {
+				rtldm->swing_diff_5g = -3;
+				out = 0x16A;
 			} else {
-				if (rtlhal->hw_type == HARDWARE_TYPE_RTL8821AE) {
-					rtldm->swing_diff_5g = -3;
-					out = 0x16A;
-				} else {
-					rtldm->swing_diff_5g = 0;
-					out = 0x200;
-				}
+				rtldm->swing_diff_5g = 0;
+				out = 0x200;
 			}
 		} else {
 			rtldm->swing_diff_2g = -3;
@@ -492,35 +471,11 @@ u32 phy_get_tx_swing_8812A(struct ieee80211_hw *hw, u8	band,
 		u32 swing = 0, swing_a = 0, swing_b = 0;
 
 		if (band == BAND_ON_2_4G) {
-			if (reg_swing_2g == auto_temp) {
-				efuse_shadow_read(hw, 1, 0xC6, (u32 *)&swing);
-				swing = (swing == 0xFF) ? 0x00 : swing;
-			} else if (swing_2g ==  0) {
-				swing = 0x00; /* 0 dB */
-			} else if (swing_2g == -3) {
-				swing = 0x05; /* -3 dB */
-			} else if (swing_2g == -6) {
-				swing = 0x0A; /* -6 dB */
-			} else if (swing_2g == -9) {
-				swing = 0xFF; /* -9 dB */
-			} else {
-				swing = 0x00;
-			}
+			efuse_shadow_read(hw, 1, 0xC6, (u32 *)&swing);
+			swing = (swing == 0xFF) ? 0x00 : swing;
 		} else {
-			if (reg_swing_5g == auto_temp) {
-				efuse_shadow_read(hw, 1, 0xC7, (u32 *)&swing);
-				swing = (swing == 0xFF) ? 0x00 : swing;
-			} else if (swing_5g ==  0) {
-				swing = 0x00; /* 0 dB */
-			} else if (swing_5g == -3) {
-				swing = 0x05; /* -3 dB */
-			} else if (swing_5g == -6) {
-				swing = 0x0A; /* -6 dB */
-			} else if (swing_5g == -9) {
-				swing = 0xFF; /* -9 dB */
-			} else {
-				swing = 0x00;
-			}
+			efuse_shadow_read(hw, 1, 0xC7, (u32 *)&swing);
+			swing = (swing == 0xFF) ? 0x00 : swing;
 		}
 
 		swing_a = (swing & 0x3) >> 0; /* 0xC6/C7[1:0] */
-- 
2.41.0

