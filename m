Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44FD55720B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 06:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiFWEqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 00:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiFWDrm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 23:47:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A6C38BEA
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 20:47:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25N3lZgS5019250, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25N3lZgS5019250
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jun 2022 11:47:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 23 Jun 2022 11:47:35 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Thu, 23 Jun
 2022 11:47:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 12/13] rtw89: support mac80211 chanctx ops by chip
Date:   Thu, 23 Jun 2022 11:46:34 +0800
Message-ID: <20220623034635.20964-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623034635.20964-1-pkshih@realtek.com>
References: <20220623034635.20964-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/23/2022 03:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMjMgpFekyCAxMjo1MTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

HW scan feature should be required after we support mac80211 chanctx ops.
However, not all chips have FW to support HW scan feature at this time
being. So, support_chanctx_num is added under chip info to deal with this.
If it's configured as 0, e.g. 8852c, which has not owned a FW to support
HW scan yet, we won't hook chanctx ops and then the chip could run without
mac80211 chanctx as before.

To 8852a which has owned a FW to support HW scan, we configure 1 to its
support_chanctx_num because we support only single channel concurrent
for now.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     |  3 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 49 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  5 ++
 drivers/net/wireless/realtek/rtw89/pci.c      | 11 ++---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 6 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 156a846363056..553e21925948f 100644
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
index 885ef1525868a..60c8043749e28 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3208,6 +3208,55 @@ void rtw89_core_unregister(struct rtw89_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw89_core_unregister);
 
+struct ieee80211_hw *rtw89_alloc_ieee80211_hw(u32 bus_data_size,
+					      const struct rtw89_chip_info *chip)
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
+	rtwdev->ops = ops;
+
+	return hw;
+
+err:
+	kfree(ops);
+	return NULL;
+}
+EXPORT_SYMBOL(rtw89_alloc_ieee80211_hw);
+
+void rtw89_free_ieee80211_hw(struct ieee80211_hw *hw)
+{
+	struct rtw89_dev *rtwdev;
+	const struct ieee80211_ops *ops;
+
+	rtwdev = hw->priv;
+	ops = rtwdev->ops;
+	kfree(ops);
+
+	ieee80211_free_hw(hw);
+}
+EXPORT_SYMBOL(rtw89_free_ieee80211_hw);
+
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11ax wireless core module");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 26f1fc9561e04..25292465a3718 100644
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
@@ -3963,6 +3965,9 @@ int rtw89_core_init(struct rtw89_dev *rtwdev);
 void rtw89_core_deinit(struct rtw89_dev *rtwdev);
 int rtw89_core_register(struct rtw89_dev *rtwdev);
 void rtw89_core_unregister(struct rtw89_dev *rtwdev);
+struct ieee80211_hw *rtw89_alloc_ieee80211_hw(u32 bus_data_size,
+					      const struct rtw89_chip_info *chip);
+void rtw89_free_ieee80211_hw(struct ieee80211_hw *hw);
 void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev);
 void rtw89_get_default_chandef(struct cfg80211_chan_def *chandef);
 void rtw89_set_channel(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 73b3b7e9fe6f5..a564f5b37c8a1 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3618,17 +3618,16 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct rtw89_dev *rtwdev;
 	const struct rtw89_driver_info *info;
 	const struct rtw89_pci_info *pci_info;
-	int driver_data_size;
 	int ret;
 
-	driver_data_size = sizeof(struct rtw89_dev) + sizeof(struct rtw89_pci);
-	hw = ieee80211_alloc_hw(driver_data_size, &rtw89_ops);
+	info = (const struct rtw89_driver_info *)id->driver_data;
+
+	hw = rtw89_alloc_ieee80211_hw(sizeof(struct rtw89_pci), info->chip);
 	if (!hw) {
 		dev_err(&pdev->dev, "failed to allocate hw\n");
 		return -ENOMEM;
 	}
 
-	info = (const struct rtw89_driver_info *)id->driver_data;
 	pci_info = info->bus.pci;
 
 	rtwdev = hw->priv;
@@ -3696,7 +3695,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_core_deinit:
 	rtw89_core_deinit(rtwdev);
 err_release_hw:
-	ieee80211_free_hw(hw);
+	rtw89_free_ieee80211_hw(hw);
 
 	return ret;
 }
@@ -3715,7 +3714,7 @@ void rtw89_pci_remove(struct pci_dev *pdev)
 	rtw89_pci_clear_resource(rtwdev, pdev);
 	rtw89_pci_declaim_device(rtwdev, pdev);
 	rtw89_core_deinit(rtwdev);
-	ieee80211_free_hw(hw);
+	rtw89_free_ieee80211_hw(hw);
 }
 EXPORT_SYMBOL(rtw89_pci_remove);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 2cf72dd322ba2..f6810fbb3fab1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2133,6 +2133,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.txpwr_factor_mac	= 1,
 	.dig_table		= &rtw89_8852a_phy_dig_table,
 	.tssi_dbw_table		= NULL,
+	.support_chanctx_num	= 1,
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

