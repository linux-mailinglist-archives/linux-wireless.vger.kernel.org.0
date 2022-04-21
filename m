Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482DF509F5B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Apr 2022 14:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383441AbiDUMNM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Apr 2022 08:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383529AbiDUMMd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Apr 2022 08:12:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2892ED71
        for <linux-wireless@vger.kernel.org>; Thu, 21 Apr 2022 05:09:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23LC9aKnA028987, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23LC9aKnA028987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Apr 2022 20:09:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 20:09:36 +0800
Received: from localhost (172.16.16.159) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 21 Apr
 2022 20:09:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 06/14] rtw89: ps: access TX/RX rings via another registers in low power mode
Date:   Thu, 21 Apr 2022 20:08:55 +0800
Message-ID: <20220421120903.73715-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421120903.73715-1-pkshih@realtek.com>
References: <20220421120903.73715-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.159]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/21/2022 11:49:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjEgpFekyCAxMDowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In low power mode, we need to pause PCI to configure IMR and PCI ring
index registers accordingly, because the regular registers are power-off
in this mode.

In the transition moment named paused in code, we can't touch ring index,
so don't kick off DMA immediately. Instead, queue them into pending queue,
and kick off after the moment.

There are three low power modes, which are RF off/clock gate/power gate,
but PCI enter low power mode in later two modes only. So, add a mask
to achieve this.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  14 +++
 drivers/net/wireless/realtek/rtw89/pci.c      | 103 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/pci.h      |  16 +++
 drivers/net/wireless/realtek/rtw89/ps.c       |  34 +++++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   2 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  10 ++
 8 files changed, 177 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f34aca70908e0..27a3ceda90b90 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2036,6 +2036,8 @@ struct rtw89_hci_ops {
 	void (*reset)(struct rtw89_dev *rtwdev);
 	int (*start)(struct rtw89_dev *rtwdev);
 	void (*stop)(struct rtw89_dev *rtwdev);
+	void (*pause)(struct rtw89_dev *rtwdev, bool pause);
+	void (*switch_mode)(struct rtw89_dev *rtwdev, bool low_power);
 	void (*recalc_int_mit)(struct rtw89_dev *rtwdev);
 
 	u8 (*read8)(struct rtw89_dev *rtwdev, u32 addr);
@@ -2067,6 +2069,7 @@ struct rtw89_hci_info {
 	enum rtw89_hci_type type;
 	u32 rpwm_addr;
 	u32 cpwm_addr;
+	bool paused;
 };
 
 struct rtw89_chip_ops {
@@ -2428,6 +2431,7 @@ struct rtw89_chip_info {
 	u8 rf_para_dlink_num;
 	const struct rtw89_btc_rf_trx_para *rf_para_dlink;
 	u8 ps_mode_supported;
+	u8 low_power_hci_modes;
 
 	u32 h2c_cctl_func_id;
 	u32 hci_func_en_addr;
@@ -3167,6 +3171,16 @@ static inline int rtw89_hci_deinit(struct rtw89_dev *rtwdev)
 	return rtwdev->hci.ops->deinit(rtwdev);
 }
 
+static inline void rtw89_hci_pause(struct rtw89_dev *rtwdev, bool pause)
+{
+	rtwdev->hci.ops->pause(rtwdev, pause);
+}
+
+static inline void rtw89_hci_switch_mode(struct rtw89_dev *rtwdev, bool low_power)
+{
+	rtwdev->hci.ops->switch_mode(rtwdev, low_power);
+}
+
 static inline void rtw89_hci_recalc_int_mit(struct rtw89_dev *rtwdev)
 {
 	rtwdev->hci.ops->recalc_int_mit(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index ad3db5aa890c6..31c62d116f44f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -919,6 +919,21 @@ u32 __rtw89_pci_check_and_reclaim_tx_fwcmd_resource(struct rtw89_dev *rtwdev)
 	return cnt;
 }
 
+static
+u32 __rtw89_pci_check_and_reclaim_tx_resource_noio(struct rtw89_dev *rtwdev,
+						   u8 txch)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[txch];
+	u32 cnt;
+
+	spin_lock_bh(&rtwpci->trx_lock);
+	cnt = rtw89_pci_get_avail_txbd_num(tx_ring);
+	spin_unlock_bh(&rtwpci->trx_lock);
+
+	return cnt;
+}
+
 static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 						     u8 txch)
 {
@@ -961,6 +976,9 @@ static u32 __rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 static u32 rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 						   u8 txch)
 {
+	if (rtwdev->hci.paused)
+		return __rtw89_pci_check_and_reclaim_tx_resource_noio(rtwdev, txch);
+
 	if (txch == RTW89_TXCH_CH12)
 		return __rtw89_pci_check_and_reclaim_tx_fwcmd_resource(rtwdev);
 
@@ -969,12 +987,17 @@ static u32 rtw89_pci_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 
 static void __rtw89_pci_tx_kick_off(struct rtw89_dev *rtwdev, struct rtw89_pci_tx_ring *tx_ring)
 {
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 	struct rtw89_pci_dma_ring *bd_ring = &tx_ring->bd_ring;
 	u32 host_idx, addr;
 
+	spin_lock_bh(&rtwpci->trx_lock);
+
 	addr = bd_ring->addr.idx;
 	host_idx = bd_ring->wp;
 	rtw89_write16(rtwdev, addr, host_idx);
+
+	spin_unlock_bh(&rtwpci->trx_lock);
 }
 
 static void rtw89_pci_tx_bd_ring_update(struct rtw89_dev *rtwdev, struct rtw89_pci_tx_ring *tx_ring,
@@ -995,9 +1018,27 @@ static void rtw89_pci_ops_tx_kick_off(struct rtw89_dev *rtwdev, u8 txch)
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 	struct rtw89_pci_tx_ring *tx_ring = &rtwpci->tx_rings[txch];
 
-	spin_lock_bh(&rtwpci->trx_lock);
+	if (rtwdev->hci.paused) {
+		set_bit(txch, rtwpci->kick_map);
+		return;
+	}
+
 	__rtw89_pci_tx_kick_off(rtwdev, tx_ring);
-	spin_unlock_bh(&rtwpci->trx_lock);
+}
+
+static void rtw89_pci_tx_kick_off_pending(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct rtw89_pci_tx_ring *tx_ring;
+	int txch;
+
+	for (txch = 0; txch < RTW89_TXCH_NUM; txch++) {
+		if (!test_and_clear_bit(txch, rtwpci->kick_map))
+			continue;
+
+		tx_ring = &rtwpci->tx_rings[txch];
+		__rtw89_pci_tx_kick_off(rtwdev, tx_ring);
+	}
 }
 
 static void __pci_flush_txch(struct rtw89_dev *rtwdev, u8 txch, bool drop)
@@ -1423,6 +1464,62 @@ static void rtw89_pci_ops_stop(struct rtw89_dev *rtwdev)
 	rtw89_core_napi_stop(rtwdev);
 }
 
+static void rtw89_pci_ops_pause(struct rtw89_dev *rtwdev, bool pause)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	struct pci_dev *pdev = rtwpci->pdev;
+
+	if (pause) {
+		rtw89_pci_disable_intr_lock(rtwdev);
+		synchronize_irq(pdev->irq);
+		if (test_bit(RTW89_FLAG_NAPI_RUNNING, rtwdev->flags))
+			napi_synchronize(&rtwdev->napi);
+	} else {
+		rtw89_pci_enable_intr_lock(rtwdev);
+		rtw89_pci_tx_kick_off_pending(rtwdev);
+	}
+}
+
+static
+void rtw89_pci_switch_bd_idx_addr(struct rtw89_dev *rtwdev, bool low_power)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_bd_idx_addr *bd_idx_addr = info->bd_idx_addr_low_power;
+	const struct rtw89_pci_ch_dma_addr_set *dma_addr_set = info->dma_addr_set;
+	struct rtw89_pci_tx_ring *tx_ring;
+	struct rtw89_pci_rx_ring *rx_ring;
+	int i;
+
+	if (WARN(!bd_idx_addr, "only HCI with low power mode needs this\n"))
+		return;
+
+	for (i = 0; i < RTW89_TXCH_NUM; i++) {
+		tx_ring = &rtwpci->tx_rings[i];
+		tx_ring->bd_ring.addr.idx = low_power ?
+					    bd_idx_addr->tx_bd_addrs[i] :
+					    dma_addr_set->tx[i].idx;
+	}
+
+	for (i = 0; i < RTW89_RXCH_NUM; i++) {
+		rx_ring = &rtwpci->rx_rings[i];
+		rx_ring->bd_ring.addr.idx = low_power ?
+					    bd_idx_addr->rx_bd_addrs[i] :
+					    dma_addr_set->rx[i].idx;
+	}
+}
+
+static void rtw89_pci_ops_switch_mode(struct rtw89_dev *rtwdev, bool low_power)
+{
+	enum rtw89_pci_intr_mask_cfg cfg;
+
+	WARN(!rtwdev->hci.paused, "HCI isn't paused\n");
+
+	cfg = low_power ? RTW89_PCI_INTR_MASK_LOW_POWER : RTW89_PCI_INTR_MASK_NORMAL;
+	rtw89_chip_config_intr_mask(rtwdev, cfg);
+	rtw89_pci_switch_bd_idx_addr(rtwdev, low_power);
+}
+
 static void rtw89_pci_ops_write32(struct rtw89_dev *rtwdev, u32 addr, u32 data);
 
 static u32 rtw89_pci_ops_read32_cmac(struct rtw89_dev *rtwdev, u32 addr)
@@ -3488,6 +3585,8 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.reset		= rtw89_pci_ops_reset,
 	.start		= rtw89_pci_ops_start,
 	.stop		= rtw89_pci_ops_stop,
+	.pause		= rtw89_pci_ops_pause,
+	.switch_mode	= rtw89_pci_ops_switch_mode,
 	.recalc_int_mit = rtw89_pci_recalc_int_mit,
 
 	.read8		= rtw89_pci_ops_read8,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index c203c8cbf1632..bb585ed191908 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -202,6 +202,15 @@
 #define B_AX_PCIE_DBG_STE_INT BIT(13)
 
 /* TX/RX */
+#define R_AX_DRV_FW_HSK_0	0x01B0
+#define R_AX_DRV_FW_HSK_1	0x01B4
+#define R_AX_DRV_FW_HSK_2	0x01B8
+#define R_AX_DRV_FW_HSK_3	0x01BC
+#define R_AX_DRV_FW_HSK_4	0x01C0
+#define R_AX_DRV_FW_HSK_5	0x01C4
+#define R_AX_DRV_FW_HSK_6	0x01C8
+#define R_AX_DRV_FW_HSK_7	0x01CC
+
 #define R_AX_RXQ_RXBD_IDX	0x1050
 #define R_AX_RPQ_RXBD_IDX	0x1054
 #define R_AX_ACH0_TXBD_IDX	0x1058
@@ -658,6 +667,11 @@ enum rtw89_pci_intr_mask_cfg {
 struct rtw89_pci_isrs;
 struct rtw89_pci;
 
+struct rtw89_pci_bd_idx_addr {
+	u32 tx_bd_addrs[RTW89_TXCH_NUM];
+	u32 rx_bd_addrs[RTW89_RXCH_NUM];
+};
+
 struct rtw89_pci_ch_dma_addr {
 	u32 num;
 	u32 idx;
@@ -703,6 +717,7 @@ struct rtw89_pci_info {
 
 	u32 rpwm_addr;
 	u32 cpwm_addr;
+	const struct rtw89_pci_bd_idx_addr *bd_idx_addr_low_power;
 	const struct rtw89_pci_ch_dma_addr_set *dma_addr_set;
 
 	int (*ltr_set)(struct rtw89_dev *rtwdev, bool en);
@@ -880,6 +895,7 @@ struct rtw89_pci {
 	struct rtw89_pci_rx_ring rx_rings[RTW89_RXCH_NUM];
 	struct sk_buff_head h2c_queue;
 	struct sk_buff_head h2c_release_queue;
+	DECLARE_BITMAP(kick_map, RTW89_TXCH_NUM);
 
 	u32 ind_intrs;
 	u32 halt_c2h_intrs;
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 7eaa01e41ef24..a90b337205885 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -29,6 +29,36 @@ static int rtw89_fw_leave_lps_check(struct rtw89_dev *rtwdev, u8 macid)
 	return 0;
 }
 
+static void rtw89_ps_power_mode_change_with_hci(struct rtw89_dev *rtwdev,
+						bool enter)
+{
+	ieee80211_stop_queues(rtwdev->hw);
+	rtwdev->hci.paused = true;
+	flush_work(&rtwdev->txq_work);
+	ieee80211_wake_queues(rtwdev->hw);
+
+	rtw89_hci_pause(rtwdev, true);
+	rtw89_mac_power_mode_change(rtwdev, enter);
+	rtw89_hci_switch_mode(rtwdev, enter);
+	rtw89_hci_pause(rtwdev, false);
+
+	rtwdev->hci.paused = false;
+
+	if (!enter) {
+		local_bh_disable();
+		napi_schedule(&rtwdev->napi);
+		local_bh_enable();
+	}
+}
+
+static void rtw89_ps_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
+{
+	if (rtwdev->chip->low_power_hci_modes & BIT(rtwdev->ps_mode))
+		rtw89_ps_power_mode_change_with_hci(rtwdev, enter);
+	else
+		rtw89_mac_power_mode_change(rtwdev, enter);
+}
+
 static void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev)
 {
 	if (!rtwdev->ps_mode)
@@ -37,7 +67,7 @@ static void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev)
 	if (test_and_set_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags))
 		return;
 
-	rtw89_mac_power_mode_change(rtwdev, true);
+	rtw89_ps_power_mode_change(rtwdev, true);
 }
 
 void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
@@ -46,7 +76,7 @@ void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
 		return;
 
 	if (test_and_clear_bit(RTW89_FLAG_LOW_POWER_MODE, rtwdev->flags))
-		rtw89_mac_power_mode_change(rtwdev, false);
+		rtw89_ps_power_mode_change(rtwdev, false);
 }
 
 static void __rtw89_enter_lps(struct rtw89_dev *rtwdev, u8 mac_id)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index cb93287d47222..5af618709dedd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2150,6 +2150,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
+	.low_power_hci_modes	= 0,
 	.h2c_cctl_func_id	= H2C_FUNC_MAC_CCTLINFO_UD,
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
 	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index c6937e5943ea7..190c4aefb02e3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -41,6 +41,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 
 	.rpwm_addr		= R_AX_PCIE_HRPWM,
 	.cpwm_addr		= R_AX_CPWM,
+	.bd_idx_addr_low_power	= NULL,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
 
 	.ltr_set		= rtw89_pci_ltr_set,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 510614630bfbb..1302d4324473e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2006,6 +2006,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dav_log_efuse_size	= 16,
 	.phycap_addr		= 0x590,
 	.phycap_size		= 0x60,
+	.low_power_hci_modes	= BIT(RTW89_PS_MODE_CLK_GATED) |
+				  BIT(RTW89_PS_MODE_PWR_GATED),
 	.h2c_cctl_func_id	= H2C_FUNC_MAC_CCTLINFO_UD_V1,
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN_V1,
 	.h2c_desc_size		= sizeof(struct rtw89_rxdesc_short),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 4d71cc87f7ba8..fc03944940130 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -9,6 +9,15 @@
 #include "reg.h"
 #include "rtw8852c.h"
 
+static const struct rtw89_pci_bd_idx_addr rtw8852c_bd_idx_addr_low_power = {
+	.tx_bd_addrs = {R_AX_DRV_FW_HSK_0, R_AX_DRV_FW_HSK_1, R_AX_DRV_FW_HSK_2,
+			R_AX_DRV_FW_HSK_3, 0, 0,
+			0, 0, R_AX_DRV_FW_HSK_4,
+			0, 0, 0,
+			R_AX_DRV_FW_HSK_5},
+	.rx_bd_addrs = {R_AX_DRV_FW_HSK_6, R_AX_DRV_FW_HSK_7},
+};
+
 static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
 	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
@@ -41,6 +50,7 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 
 	.rpwm_addr		= R_AX_PCIE_HRPWM_V1,
 	.cpwm_addr		= R_AX_PCIE_CRPWM,
+	.bd_idx_addr_low_power	= &rtw8852c_bd_idx_addr_low_power,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_v1,
 
 	.ltr_set		= rtw89_pci_ltr_set_v1,
-- 
2.25.1

