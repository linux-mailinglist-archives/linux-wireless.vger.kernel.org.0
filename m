Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367777D2DEC
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjJWJSJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 05:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJWJSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 05:18:06 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649DCE5
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 02:18:00 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c20c:0:640:6c41:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id 3088C60AC3;
        Mon, 23 Oct 2023 12:17:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tHJ9fb1DZSw0-7TLXGnqq;
        Mon, 23 Oct 2023 12:17:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1698052676; bh=z2dl1rbaPlgpfs+bQdRNH9PrVxyKgGycMMlAS4fvhdo=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=b8nduE1mS7CjzfmnUzV3BpfJeiqw22q6ga6dBZ2piHbJ2r1NzwLptjvx3O4h/6VG6
         TNwZPnxbcK69Z3mgBx0b1sjxINnvSvZ9zAlx3Kg5X8SDf7ZfV6WI4icRML4UlXLtsI
         tL+1J6EvHhmOPefyZLHDJTDzH/WF+0gBH4W2Xcz4=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/3] [v2] wifi: rtlwifi: cleanup struct rtl_hal
Date:   Mon, 23 Oct 2023 12:17:04 +0300
Message-ID: <20231023091722.52509-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <5b9ea29daaaa4ebb8bc75cd384aaee80@realtek.com>
References: <5b9ea29daaaa4ebb8bc75cd384aaee80@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused and set but otherwise unused 'bbrf_ready', 'external_pa',
'pa_mode', 'rx_tag', 'rts_en', 'wow_enable' and 'wow_enabled' fields
of 'struct rtl_hal', adjust related code. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: preserve 'hw_rof_enable' (Ping-Ke Shih) and start the series
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c | 7 -------
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c | 1 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h         | 8 --------
 3 files changed, 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
index 5a828a934fe9..fad132512a20 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
@@ -432,10 +432,8 @@ static void rtl92ee_dm_check_rssi_monitor(struct ieee80211_hw *hw)
 static void rtl92ee_dm_init_primary_cca_check(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	struct dynamic_primary_cca *primarycca = &rtlpriv->primarycca;
 
-	rtlhal->rts_en = 0;
 	primarycca->dup_rts_flag = 0;
 	primarycca->intf_flag = 0;
 	primarycca->intf_type = 0;
@@ -615,13 +613,11 @@ static void rtl92ee_dm_dynamic_primary_cca_ckeck(struct ieee80211_hw *hw)
 				rtl92ee_dm_write_dynamic_cca(hw, cur_mf_state);
 				primarycca->pricca_flag = 1;
 				primarycca->dup_rts_flag = 1;
-				rtlpriv->rtlhal.rts_en = 1;
 			} else {
 				primarycca->intf_type = 0;
 				primarycca->intf_flag = 0;
 				cur_mf_state = MF_USC_LSC;
 				rtl92ee_dm_write_dynamic_cca(hw, cur_mf_state);
-				rtlpriv->rtlhal.rts_en = 0;
 				primarycca->dup_rts_flag = 0;
 			}
 		} else if (sec_ch_offset == 1) {
@@ -642,13 +638,11 @@ static void rtl92ee_dm_dynamic_primary_cca_ckeck(struct ieee80211_hw *hw)
 				rtl92ee_dm_write_dynamic_cca(hw, cur_mf_state);
 				primarycca->pricca_flag = 1;
 				primarycca->dup_rts_flag = 1;
-				rtlpriv->rtlhal.rts_en = 1;
 			} else {
 				primarycca->intf_type = 0;
 				primarycca->intf_flag = 0;
 				cur_mf_state = MF_USC_LSC;
 				rtl92ee_dm_write_dynamic_cca(hw, cur_mf_state);
-				rtlpriv->rtlhal.rts_en = 0;
 				primarycca->dup_rts_flag = 0;
 			}
 		}
@@ -660,7 +654,6 @@ static void rtl92ee_dm_dynamic_primary_cca_ckeck(struct ieee80211_hw *hw)
 			cur_mf_state = MF_USC_LSC;
 			/* default */
 			rtl92ee_dm_write_dynamic_cca(hw, cur_mf_state);
-			rtlpriv->rtlhal.rts_en = 0;
 			primarycca->dup_rts_flag = 0;
 			primarycca->intf_type = 0;
 			primarycca->intf_flag = 0;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
index ebb7abd0c9ad..d4da5cdc8414 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
@@ -1320,7 +1320,6 @@ int rtl92ee_hw_init(struct ieee80211_hw *hw)
 		err = 1;
 		return err;
 	}
-	rtlhal->rx_tag = 0;
 	rtl_write_word(rtlpriv, REG_PCIE_CTRL_REG, 0x8000);
 	err = rtl92ee_download_fw(hw, false);
 	if (err) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 31a481f43a07..1f3163296836 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -1610,7 +1610,6 @@ struct rtl_hal {
 	bool up_first_time;
 	bool first_init;
 	bool being_init_adapter;
-	bool bbrf_ready;
 	bool mac_func_enable;
 	bool pre_edcca_enable;
 	struct bt_coexist_8723 hal_coex_8723;
@@ -1623,9 +1622,7 @@ struct rtl_hal {
 	u8 state;		/*stop 0, start 1 */
 	u8 board_type;
 	u8 package_type;
-	u8 external_pa;
 
-	u8 pa_mode;
 	u8 pa_type_2g;
 	u8 pa_type_5g;
 	u8 lna_type_2g;
@@ -1691,14 +1688,9 @@ struct rtl_hal {
 	bool master_of_dmsp;
 	bool slave_of_dmsp;
 
-	u16 rx_tag;/*for 92ee*/
-	u8 rts_en;
-
 	/*for wowlan*/
-	bool wow_enable;
 	bool enter_pnp_sleep;
 	bool wake_from_pnp_sleep;
-	bool wow_enabled;
 	time64_t last_suspend_sec;
 	u32 wowlan_fwsize;
 	u8 *wowlan_firmware;
-- 
2.41.0

