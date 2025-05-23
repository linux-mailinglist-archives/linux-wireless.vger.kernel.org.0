Return-Path: <linux-wireless+bounces-23343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034F3AC1CF8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 08:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97DC4E4C84
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 06:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955002236EE;
	Fri, 23 May 2025 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Jmq2koCv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226BE22618F
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981672; cv=none; b=EgUAti48QKbB0nd/FNRBeixiBKwQBFEyLjpn54ybgVu1sT1GygRWJ9YeD5C4ufMc0C0PrvaPhzWyaEEQl2HIXKVDVTScAJnXUNxwJpRjGOX3Iw3Wp95wso5yBprQ0vJS/PbZDRFbfgVI9jaD5wnqimjkNPtFxm4KzBYXPTChCZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981672; c=relaxed/simple;
	bh=qXb8LLfcLHk0jFI80Da+QWafZkKz1EAkxl9TvBLKvD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyVO3HIbtZkt6I2Rt1ZnnrQxFxgKuK25DewP1IRzQz39J0TNWeukpMZ3fMW/U/A6+pe+8JMqjwhIBTMlHXrFhJsnBQ0Si/ECl4iwdhNOcsr3Qh8UG/WykzGAbyE4OOTwurVcsQWGiGa7X0+avcOJoSzANWf6G1nU8HIKEq5tg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Jmq2koCv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54N6RlyS61769362, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1747981667; bh=GMuEfBmNwFeZeE5vcElP6dmot7EcMsEg5k0yIAETXO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Jmq2koCvzDQA22v7zS/ibjYHRymKemVUu5UL02qn8CskJfkVBGmh9fD8SFzqYH6QT
	 wbQd3NJ55177D4xd/Xb/GHFI56evoBKLQrr7N4f9+BxnHtSOKQk/7NX1byEwf7JNBw
	 z6oNQviCaIm+8wUjerZm3yYsy5wmwC7E7B41GqJH0ICQyau6yn0eeSJkY9iMIer+SI
	 J6xCo/LaXG4yWDpzmlqxavI78a3Qyhm/WyV/gVudWfzWvP7mC5gfgSW2de3NK8oHiX
	 ybyw6F5UAx1zTjNmBRwDeVjmGAVuC4DIEgPgT4tELIwb29Yl2EU/XH9Reoj4APCegS
	 02f8kxIVacsGg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54N6RlyS61769362
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 14:27:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 May 2025 14:27:48 +0800
Received: from [127.0.1.1] (10.22.225.244) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 May
 2025 14:27:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH rtw-next 2/2] wifi: rtw89: pci: add PCI Express error handling
Date: Fri, 23 May 2025 14:27:11 +0800
Message-ID: <20250523062711.27213-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523062711.27213-1-pkshih@realtek.com>
References: <20250523062711.27213-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Chin-Yen Lee <timlee@realtek.com>

Sometimes PCIe Advanced Error Reporting(AER), like bad TLP or
Data link protocol error, happens due to unstable pci signal or
no response from PCI host.

  pcieport 0000:00:1c.0: AER: Uncorrected (Non-Fatal) error message received from 0000:01:00.0
  rtw89_8852be 0000:01:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
  rtw89_8852be 0000:01:00.0:   device [10ec:b852] error status/mask=00004000/00400000
  rtw89_8852be 0000:01:00.0:    [14] CmpltTO                (First)
  rtw89_8852be 0000:01:00.0: SER catches error: 0x4000
  pcieport 0000:00:1c.0: AER: device recovery successful
  rtw89_8852be 0000:01:00.0: FW backtrace invalid key: 0xbb6c3214
  ieee80211 phy0: Hardware restart was requested

Setup callback function to call SER function to reset driver to recover
from these states.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 37 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h      |  1 +
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 8 files changed, 44 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 064f6a940107..204a3748d913 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4353,6 +4353,43 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(rtw89_pm_ops, rtw89_pci_suspend, rtw89_pci_resume);
 EXPORT_SYMBOL(rtw89_pm_ops);
 
+static pci_ers_result_t rtw89_pci_io_error_detected(struct pci_dev *pdev,
+						    pci_channel_state_t state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+
+	netif_device_detach(netdev);
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t rtw89_pci_io_slot_reset(struct pci_dev *pdev)
+{
+	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	rtw89_ser_notify(rtwdev, MAC_AX_ERR_ASSERTION);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void rtw89_pci_io_resume(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+
+	/* ack any pending wake events, disable PME */
+	pci_enable_wake(pdev, PCI_D0, 0);
+
+	netif_device_attach(netdev);
+}
+
+const struct pci_error_handlers rtw89_pci_err_handler = {
+	.error_detected = rtw89_pci_io_error_detected,
+	.slot_reset = rtw89_pci_io_slot_reset,
+	.resume = rtw89_pci_io_resume,
+};
+EXPORT_SYMBOL(rtw89_pci_err_handler);
+
 const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.isr_rdu = B_AX_RDU_INT,
 	.isr_halt_c2h = B_AX_HALT_C2H_INT_EN,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 79fef5f90140..52f527069da6 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1622,6 +1622,7 @@ static inline bool rtw89_pci_ltr_is_err_reg_val(u32 val)
 
 extern const struct dev_pm_ops rtw89_pm_ops;
 extern const struct dev_pm_ops rtw89_pm_ops_be;
+extern const struct pci_error_handlers rtw89_pci_err_handler;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_v1;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_be;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index 5810af825242..598730831707 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -89,6 +89,7 @@ static struct pci_driver rtw89_8851be_driver = {
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
 	.driver.pm	= &rtw89_pm_ops,
+	.err_handler    = &rtw89_pci_err_handler,
 };
 module_pci_driver(rtw89_8851be_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 2037713e3952..90ffaf9f4f6a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -91,6 +91,7 @@ static struct pci_driver rtw89_8852ae_driver = {
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
 	.driver.pm	= &rtw89_pm_ops,
+	.err_handler    = &rtw89_pci_err_handler,
 };
 module_pci_driver(rtw89_8852ae_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index abdeafc14b0b..b0726f590ca2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -93,6 +93,7 @@ static struct pci_driver rtw89_8852be_driver = {
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
 	.driver.pm	= &rtw89_pm_ops,
+	.err_handler    = &rtw89_pci_err_handler,
 };
 module_pci_driver(rtw89_8852be_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
index b69fa17beb33..a584c75b801d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bte.c
@@ -95,6 +95,7 @@ static struct pci_driver rtw89_8852bte_driver = {
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
 	.driver.pm	= &rtw89_pm_ops,
+	.err_handler    = &rtw89_pci_err_handler,
 };
 module_pci_driver(rtw89_8852bte_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 5d864fd5974e..db01d3966c27 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -118,6 +118,7 @@ static struct pci_driver rtw89_8852ce_driver = {
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
 	.driver.pm	= &rtw89_pm_ops,
+	.err_handler    = &rtw89_pci_err_handler,
 };
 module_pci_driver(rtw89_8852ce_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 0ea8d5281c10..b730d79edd10 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -106,6 +106,7 @@ static struct pci_driver rtw89_8922ae_driver = {
 	.probe		= rtw89_pci_probe,
 	.remove		= rtw89_pci_remove,
 	.driver.pm	= &rtw89_pm_ops_be,
+	.err_handler    = &rtw89_pci_err_handler,
 };
 module_pci_driver(rtw89_8922ae_driver);
 
-- 
2.25.1


