Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6097222EE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 12:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjFEKHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 06:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFEKHd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 06:07:33 -0400
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D2EE3
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 03:07:32 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 2DF0360049;
        Mon,  5 Jun 2023 13:07:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id H7P24T2DaCg0-zt906IQZ;
        Mon, 05 Jun 2023 13:07:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685959649;
        bh=k3I2MRzPWJPZNPqE9Rqsvoq435M/fRntrShOV0+g3oQ=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=lHx0+L94XeVUpW1NzeQR5suzKQ5N9yR9s8TAh67/Ox4OqrozyRe1T5EbBviGuFki6
         EuMOB+rh7ruHgAMrLUusJ9Nyw9Qly1ldNc8UQechWniuJTb4LuZ1LsPg8tIRLTXkow
         fWzb4rFCYEwWGeJrOGcoYFvw73qsHhn1LwMWMzis=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: remove misused flag from HAL data
Date:   Mon,  5 Jun 2023 13:07:00 +0300
Message-Id: <20230605100700.111644-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
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

