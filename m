Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE877D2496
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjJVQhu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 12:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJVQht (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 12:37:49 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B77BFB
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 09:37:44 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c008:0:640:847d:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id E07FC60A9C;
        Sun, 22 Oct 2023 19:37:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bbP9trODUa60-FqeiNzu8;
        Sun, 22 Oct 2023 19:37:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1697992658; bh=sgwwkisg6ICUgcPL/oLt8/dITqQf11m3ZDhDJoJMRcY=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=eR2AW+Y8E5uQ3NfH5DMxh/RTP3Z2WmESlNYO5mlxTPUpBCpeQn340NJsAYXArFV+7
         +BJGvd6e5KMsxgVtQLB5aZp/tTl35Dy2pvvppWG9PFZuqpK5FAaIig3CQ9ikRUIbYZ
         LRcoRRBR5TcD/cbWbJ9JBeWTx2HdFsc6c71TwwuQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtlwifi: cleanup struct rtl_hal
Date:   Sun, 22 Oct 2023 19:36:25 +0300
Message-ID: <20231022163628.111991-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused and set but otherwise unused 'bbrf_ready', 'external_pa',
'pa_mode', 'rx_tag', 'rts_en', 'wow_enable', 'wow_enabled' and
'hw_rof_enable' (which seems to be an erroneous duplication of the same
one of 'struct rtl_phy') fields of 'struct rtl_hal', adjust related
code. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c |  7 -------
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c |  1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c |  9 +++++----
 drivers/net/wireless/realtek/rtlwifi/wifi.h         | 10 ----------
 4 files changed, 5 insertions(+), 22 deletions(-)

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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 1633328bc3d1..da77069545a6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -1705,7 +1705,7 @@ static void _rtl8821ae_enable_ltr(struct ieee80211_hw *hw)
 static bool _rtl8821ae_wowlan_initialize_adapter(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	bool init_finished = true;
 	u8 tmp = 0;
 
@@ -1735,7 +1735,7 @@ static bool _rtl8821ae_wowlan_initialize_adapter(struct ieee80211_hw *hw)
 	rtl8821ae_set_fw_wowlan_mode(hw, false);
 	rtl8821ae_set_fw_remote_wake_ctrl_cmd(hw, 0);
 
-	if (rtlhal->hw_rof_enable) {
+	if (rtlphy->hw_rof_enable) {
 		tmp = rtl_read_byte(rtlpriv, REG_HSISR + 3);
 		if (tmp & BIT(1)) {
 			/* Clear GPIO9 ISR */
@@ -2042,7 +2042,7 @@ static enum version_8821ae _rtl8821ae_read_chip_version(struct ieee80211_hw *hw)
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8821AE) {
 		/*WL_HWROF_EN.*/
 		value32 = rtl_read_dword(rtlpriv, REG_MULTI_FUNC_CTRL);
-		rtlhal->hw_rof_enable = ((value32 & WL_HWROF_EN) ? 1 : 0);
+		rtlphy->hw_rof_enable = ((value32 & WL_HWROF_EN) ? 1 : 0);
 	}
 
 	switch (version) {
@@ -2340,6 +2340,7 @@ void rtl8821ae_card_disable(struct ieee80211_hw *hw)
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtlpriv);
 	struct rtl_mac *mac = rtl_mac(rtlpriv);
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	enum nl80211_iftype opmode;
 	bool support_remote_wakeup;
 	u8 tmp;
@@ -2449,7 +2450,7 @@ void rtl8821ae_card_disable(struct ieee80211_hw *hw)
 			"Wait Tx DMA Finished before host sleep. count=%d\n",
 			count);
 
-		if (rtlhal->hw_rof_enable) {
+		if (rtlphy->hw_rof_enable) {
 			printk("hw_rof_enable\n");
 			tmp = rtl_read_byte(rtlpriv, REG_HSISR + 3);
 			rtl_write_byte(rtlpriv, REG_HSISR + 3, tmp | BIT(1));
diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 31a481f43a07..3a837d62eda1 100644
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
@@ -1691,20 +1688,13 @@ struct rtl_hal {
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
 
-	u8 hw_rof_enable; /*Enable GPIO[9] as WL RF HW PDn source*/
-
 	bool real_wow_v2_enable;
 	bool re_init_llt_table;
 };
-- 
2.41.0

