Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D956727BE8
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjFHJvu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjFHJvs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 05:51:48 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF82526AD
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 02:51:47 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5503:0:640:7fc3:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 699F6600C0;
        Thu,  8 Jun 2023 12:51:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8pRApaJDbuQ0-VdA4T3LX;
        Thu, 08 Jun 2023 12:51:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686217906;
        bh=rqNQm+V8c0Rpj1r2icIkRW1mMCIavsXoZ0UnxnjtR+E=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Kfa7aSyBjskbyw+0aCOq4DPRheo2Wa2ov/RoKwk0PiH5x4cq79kqm1GZYJl/WT1xa
         aNRGkA2cywnvNehJTBaOnS/bsfs2vUVCEZ6yCeDOhJXdmQ9s/HcAg4jhSKfqI3DFB0
         O/ZIAbcdVKTrzDnqL1N78IKXlK1xKlZdqVHctzag=
Authentication-Results: mail-nwsmtp-smtp-production-main-23.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/4] [v2] wifi: rtlwifi: remove misused flag from HAL data
Date:   Thu,  8 Jun 2023 12:50:50 +0300
Message-Id: <20230608095051.116702-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608095051.116702-1-dmantipov@yandex.ru>
References: <20230605100700.111644-1-dmantipov@yandex.ru>
 <20230608095051.116702-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Always rely on 'driver_is_goingto_unload' of 'struct rtl_hal'
and remove (presumably misused) 'driver_going2unload' from it.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: adjust to match series
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c | 6 +++---
 drivers/net/wireless/realtek/rtlwifi/wifi.h         | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
index a8b5bf45b1bb..4ae8f69c64f9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
@@ -1302,7 +1302,7 @@ static void _rtl92s_phy_set_rfhalt(struct ieee80211_hw *hw)
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	u8 u1btmp;
 
-	if (rtlhal->driver_going2unload)
+	if (rtlhal->driver_is_goingto_unload)
 		rtl_write_byte(rtlpriv, 0x560, 0x0);
 
 	/* Power save for BB/RF */
@@ -1323,7 +1323,7 @@ static void _rtl92s_phy_set_rfhalt(struct ieee80211_hw *hw)
 	rtl_write_word(rtlpriv, CMDR, 0x57FC);
 	rtl_write_word(rtlpriv, CMDR, 0x0000);
 
-	if (rtlhal->driver_going2unload) {
+	if (rtlhal->driver_is_goingto_unload) {
 		u1btmp = rtl_read_byte(rtlpriv, (REG_SYS_FUNC_EN + 1));
 		u1btmp &= ~(BIT(0));
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN + 1, u1btmp);
@@ -1345,7 +1345,7 @@ static void _rtl92s_phy_set_rfhalt(struct ieee80211_hw *hw)
 
 	/* Power save for MAC */
 	if (ppsc->rfoff_reason == RF_CHANGE_BY_IPS  &&
-		!rtlhal->driver_going2unload) {
+		!rtlhal->driver_is_goingto_unload) {
 		/* enable LED function */
 		rtl_write_byte(rtlpriv, 0x03, 0xF9);
 	/* SW/HW radio off or halt adapter!! For example S3/S4 */
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 307e059ec8aa..a16b779080cb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1673,8 +1673,6 @@ struct rtl_hal {
 	bool fw_clk_change_in_progress;
 	bool allow_sw_to_change_hwclc;
 	u8 fw_ps_state;
-	/**/
-	bool driver_going2unload;
 
 	/*AMPDU init min space*/
 	u8 minspace_cfg;	/*For Min spacing configurations */
-- 
2.40.1

