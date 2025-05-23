Return-Path: <linux-wireless+bounces-23342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B6FAC1CF7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 08:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792064E1053
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F712DCBF9;
	Fri, 23 May 2025 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pT0FPy5n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75462236EE
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981671; cv=none; b=JZC59AY0IWX/nu0YmcbI0Nx9DW1yypnFJiIp031vPN0wuBN+B592sdGiNs1dNd1zYsE5xx34tsb3KDX9tK7treXQ4WziRLucTAD5dzOrqvlejglToxXcoBPtX9CxzPe9wGW5bh2WTUsjzwQMUTJvyA4BRbqqEKr8yL24OYb9ryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981671; c=relaxed/simple;
	bh=Lb9i67hsnj+rvx23Pn6QRrbJPvFV/JIX02sS2C2hA+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSY9wKKrJ+v11yw4p05+HxscD7aqdW5sDnaX4EKRKpBpTn5jX21Szj7dPJbLtYXQFUemxX9r7+GreQClVeMiaXwAEqt/5NALm2yeOLGLZxFxm00cGqBOrQ+vQGLiCdX7mLtS/Pqd9HS7rZz+OjGvPEALKHRSDWs4fUa278RRP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pT0FPy5n; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54N6RjTuA1769109, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1747981665; bh=wTQ2R6sVktfgv7pCWsgeoRqhDTVaRjgekZaAT8dP4Ik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pT0FPy5nTvbeb/kQ7pAXA3xtXTQvE179Ox7co7EMiIqpCnmDiBje9euIzjGh3L6fn
	 VjezltsfgU8q8d58eQhJ4Uw0iS5VKy/QUfg1HNO2pLhyLk2bvh4JHX5r6lIT3iftwL
	 OWNexrPo16lKZgBz4Zign04cMlz27zlDie48BzoZqVpw5OFW5Mg/PDkD0bZxJt4Ma2
	 WWFnNuJAoPqPUA1IAlOrCcBnZuaACqaBduq8D+/GIj3dQITa2eufepbqK0dRzAVRjb
	 xcqt2REC/Ycu39gEx98LLStjFaYfZlZvZ5hPr4iB9HgpLGIWELI5iJl0O32YaEHnkN
	 9rcEqdSO45Omg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54N6RjTuA1769109
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 14:27:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 May 2025 14:27:45 +0800
Received: from [127.0.1.1] (10.22.225.244) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 May
 2025 14:27:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH rtw-next 1/2] wifi: rtw88: pci: add PCI Express error handling
Date: Fri, 23 May 2025 14:27:10 +0800
Message-ID: <20250523062711.27213-2-pkshih@realtek.com>
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

  pcieport 0000:00:00.0: AER: Multiple Corrected error message received from 0000:00:00.0
  pcieport 0000:00:00.0: AER: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
  pcieport 0000:00:00.0: AER:   device [14c3:6786] error status/mask=000000c1/00006000
  pcieport 0000:00:00.0: AER:    [ 0] RxErr                  (First)
  pcieport 0000:00:00.0: AER:    [ 6] BadTLP
  pcieport 0000:00:00.0: AER:    [ 7] BadDLLP
  pcieport 0000:00:00.0: AER: Corrected error message received from 0000:00:00.0
  pcieport 0000:00:00.0: AER: found no error details for 0000:00:00.0
  pcieport 0000:00:00.0: AER: Multiple Corrected error message received from 0000:00:00.0
  pcieport 0000:00:00.0: AER: found no error details for 0000:00:00.0
  pcieport 0000:00:00.0: AER: Multiple Corrected error message received from 0000:00:00.0
  pcieport 0000:00:00.0: AER: found no error details for 0000:00:00.0

Setup callback function to call SER function to reset driver to recover
from these states

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     |  1 +
 drivers/net/wireless/realtek/rtw88/pci.c      | 37 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/pci.h      |  1 +
 .../net/wireless/realtek/rtw88/rtw8723de.c    |  1 +
 .../net/wireless/realtek/rtw88/rtw8821ce.c    |  1 +
 .../net/wireless/realtek/rtw88/rtw8822be.c    |  1 +
 .../net/wireless/realtek/rtw88/rtw8822ce.c    |  1 +
 7 files changed, 43 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c4de5d114eda..26b1479d3521 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -636,6 +636,7 @@ void rtw_fw_recovery(struct rtw_dev *rtwdev)
 	if (!test_bit(RTW_FLAG_RESTARTING, rtwdev->flags))
 		ieee80211_queue_work(rtwdev->hw, &rtwdev->fw_recovery_work);
 }
+EXPORT_SYMBOL(rtw_fw_recovery);
 
 static void __fw_recovery_work(struct rtw_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 7f2b6dc21f56..6655de2b9726 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1707,6 +1707,43 @@ static void rtw_pci_napi_deinit(struct rtw_dev *rtwdev)
 	free_netdev(rtwpci->netdev);
 }
 
+static pci_ers_result_t rtw_pci_io_err_detected(struct pci_dev *pdev,
+						pci_channel_state_t state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+
+	netif_device_detach(netdev);
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t rtw_pci_io_slot_reset(struct pci_dev *pdev)
+{
+	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
+	struct rtw_dev *rtwdev = hw->priv;
+
+	rtw_fw_recovery(rtwdev);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void rtw_pci_io_resume(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+
+	/* ack any pending wake events, disable PME */
+	pci_enable_wake(pdev, PCI_D0, 0);
+
+	netif_device_attach(netdev);
+}
+
+const struct pci_error_handlers rtw_pci_err_handler = {
+	.error_detected = rtw_pci_io_err_detected,
+	.slot_reset = rtw_pci_io_slot_reset,
+	.resume = rtw_pci_io_resume,
+};
+EXPORT_SYMBOL(rtw_pci_err_handler);
+
 int rtw_pci_probe(struct pci_dev *pdev,
 		  const struct pci_device_id *id)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 13988db1cb4c..8ffdea11378f 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -231,6 +231,7 @@ struct rtw_pci {
 };
 
 extern const struct dev_pm_ops rtw_pm_ops;
+extern const struct pci_error_handlers rtw_pci_err_handler;
 
 int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 void rtw_pci_remove(struct pci_dev *pdev);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723de.c b/drivers/net/wireless/realtek/rtw88/rtw8723de.c
index 87c8bc9d18a9..c6d0c88e5d81 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723de.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723de.c
@@ -23,6 +23,7 @@ static struct pci_driver rtw_8723de_driver = {
 	.remove = rtw_pci_remove,
 	.driver.pm = &rtw_pm_ops,
 	.shutdown = rtw_pci_shutdown,
+	.err_handler  = &rtw_pci_err_handler,
 };
 module_pci_driver(rtw_8723de_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821ce.c b/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
index 40637c079d99..52a19cb17daa 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821ce.c
@@ -27,6 +27,7 @@ static struct pci_driver rtw_8821ce_driver = {
 	.remove = rtw_pci_remove,
 	.driver.pm = &rtw_pm_ops,
 	.shutdown = rtw_pci_shutdown,
+	.err_handler  = &rtw_pci_err_handler,
 };
 module_pci_driver(rtw_8821ce_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822be.c b/drivers/net/wireless/realtek/rtw88/rtw8822be.c
index 0bb9f70e7920..dda597d73219 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822be.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822be.c
@@ -23,6 +23,7 @@ static struct pci_driver rtw_8822be_driver = {
 	.remove = rtw_pci_remove,
 	.driver.pm = &rtw_pm_ops,
 	.shutdown = rtw_pci_shutdown,
+	.err_handler  = &rtw_pci_err_handler,
 };
 module_pci_driver(rtw_8822be_driver);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822ce.c b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
index 9def732480af..7ae95415c224 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822ce.c
@@ -27,6 +27,7 @@ static struct pci_driver rtw_8822ce_driver = {
 	.remove = rtw_pci_remove,
 	.driver.pm = &rtw_pm_ops,
 	.shutdown = rtw_pci_shutdown,
+	.err_handler  = &rtw_pci_err_handler,
 };
 module_pci_driver(rtw_8822ce_driver);
 
-- 
2.25.1


