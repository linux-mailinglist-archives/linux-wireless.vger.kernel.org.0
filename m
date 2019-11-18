Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA46A1001D4
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 10:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfKRJyp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 04:54:45 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:40041 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfKRJyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 04:54:45 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAI9sdC6018268, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAI9sdC6018268
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Nov 2019 17:54:39 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 18 Nov 2019 17:54:39 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 4/4] rtw88: allows to enable/disable HCI link PS mechanism
Date:   Mon, 18 Nov 2019 17:54:32 +0800
Message-ID: <20191118095432.4507-5-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118095432.4507-1-yhchuang@realtek.com>
References: <20191118095432.4507-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Different interfaces have its own link-related power save mechanism.
Such as PCI can enter L1 state based on the traffic on the link, and
sometimes driver needs to enable/disable it to avoid some issues, like
throughput degrade when PCI trying to enter L1 state even if driver is
having heavy traffic.

For now, rtw88 only supports PCIE chips, and they just need to disable
ASPM L1 when driver is not in power save mode, such as IPS and LPS.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
 * no change

 drivers/net/wireless/realtek/rtw88/hci.h |  6 ++++
 drivers/net/wireless/realtek/rtw88/pci.c | 38 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/pci.h |  1 +
 drivers/net/wireless/realtek/rtw88/ps.c  |  6 ++++
 4 files changed, 51 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index 4afbf0d163d1..3d91aea942c3 100644
--- a/drivers/net/wireless/realtek/rtw88/hci.h
+++ b/drivers/net/wireless/realtek/rtw88/hci.h
@@ -14,6 +14,7 @@ struct rtw_hci_ops {
 	int (*start)(struct rtw_dev *rtwdev);
 	void (*stop)(struct rtw_dev *rtwdev);
 	void (*deep_ps)(struct rtw_dev *rtwdev, bool enter);
+	void (*link_ps)(struct rtw_dev *rtwdev, bool enter);
 
 	int (*write_data_rsvd_page)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
 	int (*write_data_h2c)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
@@ -53,6 +54,11 @@ static inline void rtw_hci_deep_ps(struct rtw_dev *rtwdev, bool enter)
 	rtwdev->hci.ops->deep_ps(rtwdev, enter);
 }
 
+static inline void rtw_hci_link_ps(struct rtw_dev *rtwdev, bool enter)
+{
+	rtwdev->hci.ops->link_ps(rtwdev, enter);
+}
+
 static inline int
 rtw_hci_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf, u32 size)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 6e99aad39487..a58e8276a41a 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1150,6 +1150,43 @@ static void rtw_pci_clkreq_set(struct rtw_dev *rtwdev, bool enable)
 	rtw_dbi_write8(rtwdev, RTK_PCIE_LINK_CFG, value);
 }
 
+static void rtw_pci_aspm_set(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 value;
+	int ret;
+
+	ret = rtw_dbi_read8(rtwdev, RTK_PCIE_LINK_CFG, &value);
+	if (ret) {
+		rtw_err(rtwdev, "failed to read ASPM, ret=%d", ret);
+		return;
+	}
+
+	if (enable)
+		value |= BIT_L1_SW_EN;
+	else
+		value &= ~BIT_L1_SW_EN;
+
+	rtw_dbi_write8(rtwdev, RTK_PCIE_LINK_CFG, value);
+}
+
+static void rtw_pci_link_ps(struct rtw_dev *rtwdev, bool enter)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+
+	/* Like CLKREQ, ASPM is also implemented by two HW modules, and can
+	 * only be enabled when host supports it.
+	 *
+	 * And ASPM mechanism should be enabled when driver/firmware enters
+	 * power save mode, without having heavy traffic. Because we've
+	 * experienced some inter-operability issues that the link tends
+	 * to enter L1 state on the fly even when driver is having high
+	 * throughput. This is probably because the ASPM behavior slightly
+	 * varies from different SOC.
+	 */
+	if (rtwpci->link_ctrl & PCI_EXP_LNKCTL_ASPM_L1)
+		rtw_pci_aspm_set(rtwdev, enter);
+}
+
 static void rtw_pci_link_cfg(struct rtw_dev *rtwdev)
 {
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
@@ -1292,6 +1329,7 @@ static struct rtw_hci_ops rtw_pci_ops = {
 	.start = rtw_pci_start,
 	.stop = rtw_pci_stop,
 	.deep_ps = rtw_pci_deep_ps,
+	.link_ps = rtw_pci_link_ps,
 
 	.read8 = rtw_pci_read8,
 	.read16 = rtw_pci_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 90efb73c607e..49bf29a92152 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -38,6 +38,7 @@
 
 #define RTK_PCIE_LINK_CFG	0x0719
 #define BIT_CLKREQ_SW_EN	BIT(4)
+#define BIT_L1_SW_EN		BIT(3)
 
 #define BIT_PCI_BCNQ_FLAG	BIT(4)
 #define RTK_PCI_TXBD_DESA_BCNQ	0x308
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 2226e3e7d7f8..913e6f47130f 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -31,6 +31,7 @@ int rtw_enter_ips(struct rtw_dev *rtwdev)
 	rtw_coex_ips_notify(rtwdev, COEX_IPS_ENTER);
 
 	rtw_core_stop(rtwdev);
+	rtw_hci_link_ps(rtwdev, true);
 
 	return 0;
 }
@@ -49,6 +50,8 @@ int rtw_leave_ips(struct rtw_dev *rtwdev)
 {
 	int ret;
 
+	rtw_hci_link_ps(rtwdev, false);
+
 	ret = rtw_ips_pwr_up(rtwdev);
 	if (ret) {
 		rtw_err(rtwdev, "failed to leave ips state\n");
@@ -150,6 +153,7 @@ static void rtw_leave_lps_core(struct rtw_dev *rtwdev)
 	conf->rlbm = 0;
 	conf->smart_ps = 0;
 
+	rtw_hci_link_ps(rtwdev, false);
 	rtw_fw_set_pwr_mode(rtwdev);
 	rtw_fw_leave_lps_state_check(rtwdev);
 
@@ -187,6 +191,8 @@ static void rtw_enter_lps_core(struct rtw_dev *rtwdev)
 	rtw_coex_lps_notify(rtwdev, COEX_LPS_ENABLE);
 
 	rtw_fw_set_pwr_mode(rtwdev);
+	rtw_hci_link_ps(rtwdev, true);
+
 	set_bit(RTW_FLAG_LEISURE_PS, rtwdev->flags);
 }
 
-- 
2.17.1

