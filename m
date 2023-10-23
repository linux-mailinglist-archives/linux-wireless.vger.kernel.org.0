Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11FA7D2DEB
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 11:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjJWJSI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 05:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJWJSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 05:18:06 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172FBDF
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 02:17:59 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c20c:0:640:6c41:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id B0F8E60038;
        Mon, 23 Oct 2023 12:17:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tHJ9fb1DZSw0-bKPUHGma;
        Mon, 23 Oct 2023 12:17:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698052677; bh=uVX4rLvR3kwzWV+IU5yLuk1AUVnO43/icjjPHR/1MR4=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=e8l1CakVlXeojgdKjrMp32IfzP08AoBLgji6vw90Rg1+GeB6B0OaKIz0/WpmdoXy0
         Wb2aPQiYL9WRPsmqo7J2Mb/zMOQutnsH5Tszc+mrPPZr3Y6VqVugSpgIiF8FmCleEQ
         Jy4rOMWGaUQvk0AgzxE/MYMTqEq2reBA96LEDiQY=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/3] [v2] wifi: rtlwifi: cleanup struct rtl_phy
Date:   Mon, 23 Oct 2023 12:17:05 +0300
Message-ID: <20231023091722.52509-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023091722.52509-1-dmantipov@yandex.ru>
References: <5b9ea29daaaa4ebb8bc75cd384aaee80@realtek.com>
 <20231023091722.52509-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused and read by otherwise unused 'h2c_box_num',
'rfpienable', 'reserve_0', 'reserve_1', 'iqk_in_progress',
'apk_done' and 'hw_rof_enable' fields of 'struct rtl_phy',
adjust related code. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: split to not mix with 'struct rtl_hal' changes
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c | 4 ----
 drivers/net/wireless/realtek/rtlwifi/wifi.h                | 7 -------
 2 files changed, 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
index 3d29c8dbb255..d448efe2c229 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
@@ -1487,12 +1487,8 @@ EXPORT_SYMBOL(rtl92c_phy_lc_calibrate);
 
 void rtl92c_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta)
 {
-	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 
-	if (rtlphy->apk_done)
-		return;
 	if (IS_92C_SERIAL(rtlhal->version))
 		_rtl92c_phy_ap_calibrate(hw, delta, true);
 	else
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 1f3163296836..171a461cd812 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1316,7 +1316,6 @@ struct rtl_phy {
 	u8 sw_chnl_stage;
 	u8 sw_chnl_step;
 	u8 current_channel;
-	u8 h2c_box_num;
 	u8 set_io_inprogress;
 	u8 lck_inprogress;
 
@@ -1329,9 +1328,6 @@ struct rtl_phy {
 	s32 reg_ebc;
 	s32 reg_ec4;
 	s32 reg_ecc;
-	u8 rfpienable;
-	u8 reserve_0;
-	u16 reserve_1;
 	u32 reg_c04, reg_c08, reg_874;
 	u32 adda_backup[16];
 	u32 iqk_mac_backup[IQK_MAC_REG_NUM];
@@ -1345,7 +1341,6 @@ struct rtl_phy {
 	struct iqk_matrix_regs iqk_matrix[IQK_MATRIX_SETTINGS_NUM];
 
 	bool rfpi_enable;
-	bool iqk_in_progress;
 
 	u8 pwrgroup_cnt;
 	u8 cck_high_power;
@@ -1383,7 +1378,6 @@ struct rtl_phy {
 			 [MAX_RF_PATH_NUM];
 
 	u32 rfreg_chnlval[2];
-	bool apk_done;
 	u32 reg_rf3c[2];	/* pathA / pathB  */
 
 	u32 backup_rf_0x1a;/*92ee*/
@@ -1395,7 +1389,6 @@ struct rtl_phy {
 	struct phy_parameters hwparam_tables[MAX_TAB];
 	u16 rf_pathmap;
 
-	u8 hw_rof_enable; /*Enable GPIO[9] as WL RF HW PDn source*/
 	enum rt_polarity_ctl polarity_ctl;
 };
 
-- 
2.41.0

