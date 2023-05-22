Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5B70BE50
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 14:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjEVM3t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 08:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjEVM1s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 08:27:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BABD1A1
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 05:25:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34MCPZp04030927, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34MCPZp04030927
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 22 May 2023 20:25:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 22 May 2023 20:25:46 +0800
Received: from [127.0.1.1] (172.16.17.50) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 22 May
 2023 20:25:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: add chip_ops::query_rxdesc() and rxd_len as helpers to support newer chips
Date:   Mon, 22 May 2023 20:25:09 +0800
Message-ID: <20230522122513.13559-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522122513.13559-1-pkshih@realtek.com>
References: <20230522122513.13559-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.50]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The next generation chips use different RX descriptor format, so add
a chip_ops to hook suitable handlers. Also, the length of RX descriptor is
different, so add a variable to store the length according to chip and
descriptor content dynamically. Then, the code can be more general.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  4 ++++
 drivers/net/wireless/realtek/rtw89/core.h     | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c      | 12 ++++--------
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 7 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index fbcb9b6e6f754..ae547b38dfaa8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1819,6 +1819,10 @@ void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
 	shift_len = desc_info->shift << 1; /* 2-byte unit */
 	drv_info_len = desc_info->drv_info_size << 3; /* 8-byte unit */
 	desc_info->offset = data_offset + shift_len + drv_info_len;
+	if (desc_info->long_rxdesc)
+		desc_info->rxd_len = sizeof(struct rtw89_rxdesc_long);
+	else
+		desc_info->rxd_len = sizeof(struct rtw89_rxdesc_short);
 	desc_info->ready = true;
 
 	if (!desc_info->long_rxdesc)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fe464b7212f55..7a486a7207074 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -776,6 +776,7 @@ struct rtw89_rx_desc_info {
 	u8 sec_cam_id;
 	u8 mac_id;
 	u16 offset;
+	u16 rxd_len;
 	bool ready;
 };
 
@@ -2824,6 +2825,9 @@ struct rtw89_chip_ops {
 				       s8 pw_ofst, enum rtw89_mac_idx mac_idx);
 	int (*pwr_on_func)(struct rtw89_dev *rtwdev);
 	int (*pwr_off_func)(struct rtw89_dev *rtwdev);
+	void (*query_rxdesc)(struct rtw89_dev *rtwdev,
+			     struct rtw89_rx_desc_info *desc_info,
+			     u8 *data, u32 data_offset);
 	void (*fill_txdesc)(struct rtw89_dev *rtwdev,
 			    struct rtw89_tx_desc_info *desc_info,
 			    void *txdesc);
@@ -4854,6 +4858,16 @@ static inline void rtw89_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
 		chip->ops->ctrl_btg(rtwdev, btg);
 }
 
+static inline
+void rtw89_chip_query_rxdesc(struct rtw89_dev *rtwdev,
+			     struct rtw89_rx_desc_info *desc_info,
+			     u8 *data, u32 data_offset)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	chip->ops->query_rxdesc(rtwdev, desc_info, data, data_offset);
+}
+
 static inline
 void rtw89_chip_fill_txdesc(struct rtw89_dev *rtwdev,
 			    struct rtw89_tx_desc_info *desc_info,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 92bfef942d3a9..9402f1a0caea8 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -265,7 +265,7 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 			goto err_sync_device;
 		}
 
-		rtw89_core_query_rxdesc(rtwdev, desc_info, skb->data, rxinfo_size);
+		rtw89_chip_query_rxdesc(rtwdev, desc_info, skb->data, rxinfo_size);
 
 		new = rtw89_alloc_skb_for_rx(rtwdev, desc_info->pkt_size);
 		if (!new)
@@ -274,9 +274,7 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 		rx_ring->diliver_skb = new;
 
 		/* first segment has RX desc */
-		offset = desc_info->offset;
-		offset += desc_info->long_rxdesc ? sizeof(struct rtw89_rxdesc_long) :
-			  sizeof(struct rtw89_rxdesc_short);
+		offset = desc_info->offset + desc_info->rxd_len;
 	} else {
 		offset = sizeof(struct rtw89_pci_rxbd_info);
 		if (!new) {
@@ -546,12 +544,10 @@ static u32 rtw89_pci_release_tx_skbs(struct rtw89_dev *rtwdev,
 		return cnt;
 	}
 
-	rtw89_core_query_rxdesc(rtwdev, &desc_info, skb->data, rxinfo_size);
+	rtw89_chip_query_rxdesc(rtwdev, &desc_info, skb->data, rxinfo_size);
 
 	/* first segment has RX desc */
-	offset = desc_info.offset;
-	offset += desc_info.long_rxdesc ? sizeof(struct rtw89_rxdesc_long) :
-					  sizeof(struct rtw89_rxdesc_short);
+	offset = desc_info.offset + desc_info.rxd_len;
 	for (; offset + rpp_size <= rx_info->len; offset += rpp_size) {
 		rpp = (struct rtw89_pci_rpp_fmt *)(skb->data + offset);
 		rtw89_pci_release_rpp(rtwdev, rpp);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 6ecdd3d3f776f..b19579874b2b7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1713,6 +1713,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.rfe_gpio		= rtw8851b_rfe_gpio,
 	.pwr_on_func		= rtw8851b_pwr_on_func,
 	.pwr_off_func		= rtw8851b_pwr_off_func,
+	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
 	.h2c_dctl_sec_cam	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 541ad2f4b0c2b..559835ce86bb6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2050,6 +2050,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852a_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= NULL,
 	.pwr_off_func		= NULL,
+	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 4e4023f114ec8..2a143751abc5f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2472,6 +2472,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852b_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8852b_pwr_on_func,
 	.pwr_off_func		= rtw8852b_pwr_off_func,
+	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index e4c984c87d6cc..9c7c9812d4f45 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2780,6 +2780,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
 	.pwr_off_func		= rtw8852c_pwr_off_func,
+	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc_v1,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc_fwcmd_v1,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path_v1,
-- 
2.25.1

