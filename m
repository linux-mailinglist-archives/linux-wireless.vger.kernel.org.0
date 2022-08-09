Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0795158D7A6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbiHIKut (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 06:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242678AbiHIKuj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 06:50:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F048925CF
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 03:50:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 279AoKIg9018875, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 279AoKIg9018875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 9 Aug 2022 18:50:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 9 Aug 2022 18:50:30 +0800
Received: from localhost (172.16.16.191) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Aug 2022
 18:50:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 12/13] wifi: rtw89: declare support for mac80211 chanctx ops by chip
Date:   Tue, 9 Aug 2022 18:49:51 +0800
Message-ID: <20220809104952.61355-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809104952.61355-1-pkshih@realtek.com>
References: <20220809104952.61355-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.191]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2022 10:19:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvOSCkV6TIIDA4OjU0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Some HW features are required if we hook chanctx ops to mac80211. With it,
mac80211 would expect the HW-supported variant ops exists on some behavior,
e.g. HW scan. But, HW features may depend on chip's FW or its development.
Besides, how many chanctx can be supported also depends on chip design.
We can neither decide whether to generally support chanctx ops nor how many
chanctx can be supported.

So, support_chanctx_num is added under chip info to deal with this by chip.
For now, all chip configure support_chanctx_num as 0. We haven't really
hook chanctx ops yet. So, chip can run without mac80211 chanctx as before.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     |  3 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 47 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  6 +++
 drivers/net/wireless/realtek/rtw89/pci.c      | 20 ++++----
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 6 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index cccbd9c8c59b8..a4f61c2f65123 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -185,10 +185,11 @@ int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u8 idx;
 
 	idx = find_first_zero_bit(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
-	if (idx > RTW89_SUB_ENTITY_0)
+	if (idx >= chip->support_chanctx_num)
 		return -ENOENT;
 
 	rtw89_config_entity_chandef(rtwdev, idx, &ctx->def);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 885ef1525868a..90b18be4fd3a3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3208,6 +3208,53 @@ void rtw89_core_unregister(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_core_unregister);
 
+struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
+					   u32 bus_data_size,
+					   const struct rtw89_chip_info *chip)
+{
+	struct ieee80211_hw *hw;
+	struct rtw89_dev *rtwdev;
+	struct ieee80211_ops *ops;
+	u32 driver_data_size;
+
+	ops = kmemdup(&rtw89_ops, sizeof(rtw89_ops), GFP_KERNEL);
+	if (!ops)
+		goto err;
+
+	if (chip->support_chanctx_num == 0) {
+		ops->add_chanctx = NULL;
+		ops->remove_chanctx = NULL;
+		ops->change_chanctx = NULL;
+		ops->assign_vif_chanctx = NULL;
+		ops->unassign_vif_chanctx = NULL;
+	}
+
+	driver_data_size = sizeof(struct rtw89_dev) + bus_data_size;
+	hw = ieee80211_alloc_hw(driver_data_size, ops);
+	if (!hw)
+		goto err;
+
+	rtwdev = hw->priv;
+	rtwdev->hw = hw;
+	rtwdev->dev = device;
+	rtwdev->ops = ops;
+	rtwdev->chip = chip;
+
+	return rtwdev;
+
+err:
+	kfree(ops);
+	return NULL;
+}
+EXPORT_SYMBOL(rtw89_alloc_ieee80211_hw);
+
+void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev)
+{
+	kfree(rtwdev->ops);
+	ieee80211_free_hw(rtwdev->hw);
+}
+EXPORT_SYMBOL(rtw89_free_ieee80211_hw);
+
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11ax wireless core module");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 26f1fc9561e04..3c7b8d9dc1397 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2408,6 +2408,7 @@ struct rtw89_chip_info {
 	const struct rtw89_hfc_param_ini *hfc_param_ini;
 	const struct rtw89_dle_mem *dle_mem;
 	u32 rf_base_addr[2];
+	u8 support_chanctx_num;
 	u8 support_bands;
 	bool support_bw160;
 	bool hw_sec_hdr;
@@ -3152,6 +3153,7 @@ struct rtw89_phy_efuse_gain {
 struct rtw89_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
+	const struct ieee80211_ops *ops;
 
 	bool dbcc_en;
 	struct rtw89_hw_scan_info scan_info;
@@ -3963,6 +3965,10 @@ int rtw89_core_init(struct rtw89_dev *rtwdev);
 void rtw89_core_deinit(struct rtw89_dev *rtwdev);
 int rtw89_core_register(struct rtw89_dev *rtwdev);
 void rtw89_core_unregister(struct rtw89_dev *rtwdev);
+struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
+					   u32 bus_data_size,
+					   const struct rtw89_chip_info *chip);
+void rtw89_free_ieee80211_hw(struct rtw89_dev *rtwdev);
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
 void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
 void rtw89_set_channel(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index c68fec9eb5a64..7fdd592bfb825 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3614,27 +3614,23 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	struct ieee80211_hw *hw;
 	struct rtw89_dev *rtwdev;
 	const struct rtw89_driver_info *info;
 	const struct rtw89_pci_info *pci_info;
-	int driver_data_size;
 	int ret;
 
-	driver_data_size = sizeof(struct rtw89_dev) + sizeof(struct rtw89_pci);
-	hw = ieee80211_alloc_hw(driver_data_size, &rtw89_ops);
-	if (!hw) {
+	info = (const struct rtw89_driver_info *)id->driver_data;
+
+	rtwdev = rtw89_alloc_ieee80211_hw(&pdev->dev,
+					  sizeof(struct rtw89_pci),
+					  info->chip);
+	if (!rtwdev) {
 		dev_err(&pdev->dev, "failed to allocate hw\n");
 		return -ENOMEM;
 	}
 
-	info = (const struct rtw89_driver_info *)id->driver_data;
 	pci_info = info->bus.pci;
 
-	rtwdev = hw->priv;
-	rtwdev->hw = hw;
-	rtwdev->dev = &pdev->dev;
-	rtwdev->chip = info->chip;
 	rtwdev->pci_info = info->bus.pci;
 	rtwdev->hci.ops = &rtw89_pci_ops;
 	rtwdev->hci.type = RTW89_HCI_TYPE_PCIE;
@@ -3696,7 +3692,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_core_deinit:
 	rtw89_core_deinit(rtwdev);
 err_release_hw:
-	ieee80211_free_hw(hw);
+	rtw89_free_ieee80211_hw(rtwdev);
 
 	return ret;
 }
@@ -3715,7 +3711,7 @@ void rtw89_pci_remove(struct pci_dev *pdev)
 	rtw89_pci_clear_resource(rtwdev, pdev);
 	rtw89_pci_declaim_device(rtwdev, pdev);
 	rtw89_core_deinit(rtwdev);
-	ieee80211_free_hw(hw);
+	rtw89_free_ieee80211_hw(rtwdev);
 }
 EXPORT_SYMBOL(rtw89_pci_remove);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 2cf72dd322ba2..3516e480e622b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2133,6 +2133,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.txpwr_factor_mac	= 1,
 	.dig_table		= &rtw89_8852a_phy_dig_table,
 	.tssi_dbw_table		= NULL,
+	.support_chanctx_num	= 0,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 7a2822f3bdf04..0218fa90526ca 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2981,6 +2981,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
 	.tssi_dbw_table		= &rtw89_8852c_tssi_dbw_table,
+	.support_chanctx_num	= 0,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ) |
 				  BIT(NL80211_BAND_6GHZ),
-- 
2.25.1

