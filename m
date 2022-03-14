Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFFA4D7B62
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 08:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiCNHPC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 03:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiCNHPA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 03:15:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191A4E09C
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 00:13:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22E7DhEhA003304, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22E7DhEhA003304
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Mar 2022 15:13:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 14 Mar 2022 15:13:43 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 15:13:42 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 4/8] rtw89: ser: control hci interrupts on/off by state
Date:   Mon, 14 Mar 2022 15:12:46 +0800
Message-ID: <20220314071250.40292-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314071250.40292-1-pkshih@realtek.com>
References: <20220314071250.40292-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/14/2022 06:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTQgpFekyCAwNjowMDowMA==?=
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

While SER (system error recover) is processing, it's supposed to mean
something is under recovery. So, disable interrupts (excluding the one
of halt which could be used during SER) to avoid unexpected behavior.
And then, enable interrupts after SER is done.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 19 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c  | 29 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h  |  1 +
 drivers/net/wireless/realtek/rtw89/ser.c  |  4 ++++
 4 files changed, 53 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 483cf45fbcc99..e072e6859b301 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2025,6 +2025,13 @@ struct rtw89_hci_ops {
 	int (*mac_lv1_rcvy)(struct rtw89_dev *rtwdev, enum rtw89_lv1_rcvy_step step);
 	void (*dump_err_status)(struct rtw89_dev *rtwdev);
 	int (*napi_poll)(struct napi_struct *napi, int budget);
+
+	/* Deal with locks inside recovery_start and recovery_complete callbacks
+	 * by hci instance, and handle things which need to consider under SER.
+	 * e.g. turn on/off interrupts except for the one for halt notification.
+	 */
+	void (*recovery_start)(struct rtw89_dev *rtwdev);
+	void (*recovery_complete)(struct rtw89_dev *rtwdev);
 };
 
 struct rtw89_hci_info {
@@ -3023,6 +3030,18 @@ static inline void rtw89_hci_flush_queues(struct rtw89_dev *rtwdev, u32 queues,
 		return rtwdev->hci.ops->flush_queues(rtwdev, queues, drop);
 }
 
+static inline void rtw89_hci_recovery_start(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->hci.ops->recovery_start)
+		rtwdev->hci.ops->recovery_start(rtwdev);
+}
+
+static inline void rtw89_hci_recovery_complete(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->hci.ops->recovery_complete)
+		rtwdev->hci.ops->recovery_complete(rtwdev);
+}
+
 static inline u8 rtw89_read8(struct rtw89_dev *rtwdev, u32 addr)
 {
 	return rtwdev->hci.ops->read8(rtwdev, addr);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index e79bfc335b446..32e8283e22f3b 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -647,6 +647,29 @@ static void rtw89_pci_disable_intr(struct rtw89_dev *rtwdev,
 	rtw89_write32(rtwdev, R_AX_PCIE_HIMR10, 0);
 }
 
+static void rtw89_pci_ops_recovery_start(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+	rtwpci->under_recovery = true;
+	rtw89_write32(rtwdev, R_AX_PCIE_HIMR00, 0);
+	rtw89_write32(rtwdev, R_AX_PCIE_HIMR10, 0);
+	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+}
+
+static void rtw89_pci_ops_recovery_complete(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+	rtwpci->under_recovery = false;
+	rtw89_pci_enable_intr(rtwdev, rtwpci);
+	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+}
+
 static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 {
 	struct rtw89_dev *rtwdev = dev;
@@ -664,6 +687,9 @@ static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
 	if (unlikely(isrs.halt_c2h_isrs & B_AX_HALT_C2H_INT_EN))
 		rtw89_ser_notify(rtwdev, rtw89_mac_get_err_status(rtwdev));
 
+	if (unlikely(rtwpci->under_recovery))
+		return IRQ_HANDLED;
+
 	if (likely(rtwpci->running)) {
 		local_bh_disable();
 		napi_schedule(&rtwdev->napi);
@@ -2931,6 +2957,9 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.mac_lv1_rcvy	= rtw89_pci_ops_mac_lv1_recovery,
 	.dump_err_status = rtw89_pci_ops_dump_err_status,
 	.napi_poll	= rtw89_pci_napi_poll,
+
+	.recovery_start = rtw89_pci_ops_recovery_start,
+	.recovery_complete = rtw89_pci_ops_recovery_complete,
 };
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index b84acd0d0582a..2c8030af3e72f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -594,6 +594,7 @@ struct rtw89_pci {
 	/* protect TRX resources (exclude RXQ) */
 	spinlock_t trx_lock;
 	bool running;
+	bool under_recovery;
 	struct rtw89_pci_tx_ring tx_rings[RTW89_TXCH_NUM];
 	struct rtw89_pci_rx_ring rx_rings[RTW89_RXCH_NUM];
 	struct sk_buff_head h2c_queue;
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 5327b97b9c728..a20389cde7e23 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -302,8 +302,11 @@ static void hal_send_m4_event(struct rtw89_ser *ser)
 /* state handler */
 static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 {
+	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+
 	switch (evt) {
 	case SER_EV_STATE_IN:
+		rtw89_hci_recovery_complete(rtwdev);
 		break;
 	case SER_EV_L1_RESET:
 		ser_state_goto(ser, SER_RESET_TRX_ST);
@@ -312,6 +315,7 @@ static void ser_idle_st_hdl(struct rtw89_ser *ser, u8 evt)
 		ser_state_goto(ser, SER_L2_RESET_ST);
 		break;
 	case SER_EV_STATE_OUT:
+		rtw89_hci_recovery_start(rtwdev);
 	default:
 		break;
 	}
-- 
2.25.1

