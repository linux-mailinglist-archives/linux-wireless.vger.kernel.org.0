Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9AFA8FB18
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 08:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfHPGdB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 02:33:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46924 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfHPGdB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 02:33:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so1841274pgv.13
        for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2019 23:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=giKjf990G493iYKWj/Ui8wiow3juJNHrDaZUgCQRucg=;
        b=t45iSPu7tR8o35j/uLOMJwYsiha8ivSA5gVqNNkgQVFjcZB+4BP2Yk/b0rTwmLrlmb
         k0CaUBYT9Ns1Dt/VWQBuQhz4Y/1oGuvyvRACwzQGN45sgKHH6Z3a7bUTdE2YvIi0mO7g
         qIiUpWCGPNaZatrcktsx0njVruZBAN0VfRYSNdw4CIDjbtJNa1UrVYSzC6e6TJmPNP6X
         Iv2CKXUoP3keyIWU54zue3gheVqqnkUD/+/PJNwzUgIJ/5HZx99J5Q3f7BGFiOcOuUin
         X4QgV2nZKudS4hHLac7p9Ezwj3GVbwPMEXr4OA1uzlj7yVkqagPUBEQR/hGoOuH3x46n
         DpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=giKjf990G493iYKWj/Ui8wiow3juJNHrDaZUgCQRucg=;
        b=mnSdZEWMhctgn4KuHcbBm8Ph/Ca9CN3PZYAjRy9B16OJqXoZQL6ZtWcRzh57hoOaK1
         goeTWgmOfszinh00HwPQ2OLQzfWvjq/E3VZcpmyRL8gLE76XWmU6fFfGt4X8XO4hH6nV
         obHGQ8men1Mt3maKp1pGDMAAmRWudf43ORXDFzisEnve74YnnsNfltRHdwo7TQBtluBa
         +0jEffr2oRSEOJgKBCRrDD/XfTXACnK5JQ+xf2T8ZbQW/ZS4NTE7JFkoCqwOoHvKVxFe
         VcpZpRWrbRB3GscifGCUZMbylXKBEhjQurEuEOfYXX/gav7fO8kWVYKMHDiv6sYJG6OC
         C2tg==
X-Gm-Message-State: APjAAAW4RV/Cm9e7SfuB7mS2/g4Io34WyES/F0KyQ+i+5arXGf7cZYAj
        NMq4ie4PAkuTiJdmkOBG6aAhq+Lc05JliQ==
X-Google-Smtp-Source: APXvYqxBf8RxaN8Ch2BN2X+9nVBTNieL3l+Ic0s8PGxImNO8kNoljTjMy5t79+c6/oI7CXzdjJWHSw==
X-Received: by 2002:a65:6904:: with SMTP id s4mr6390422pgq.33.1565937180619;
        Thu, 15 Aug 2019 23:33:00 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id y14sm3721991pge.7.2019.08.15.23.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 23:32:59 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] rtw88: pci: Move a mass of jobs in hw IRQ to soft IRQ
Date:   Fri, 16 Aug 2019 14:31:10 +0800
Message-Id: <20190816063109.4699-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is a mass of jobs between spin lock and unlock in the hardware
IRQ which will occupy much time originally. To make system work more
efficiently, this patch moves the jobs to the soft IRQ (bottom half) to
reduce the time in hardware IRQ.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 36 +++++++++++++++++++-----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 00ef229552d5..355606b167c6 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -866,12 +866,29 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 {
 	struct rtw_dev *rtwdev = dev;
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
-	u32 irq_status[4];
+	unsigned long flags;
 
-	spin_lock(&rtwpci->irq_lock);
+	spin_lock_irqsave(&rtwpci->irq_lock, flags);
 	if (!rtwpci->irq_enabled)
 		goto out;
 
+	/* disable RTW PCI interrupt to avoid more interrupts before the end of
+	 * thread function
+	 */
+	rtw_pci_disable_interrupt(rtwdev, rtwpci);
+out:
+	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t rtw_pci_interrupt_threadfn(int irq, void *dev)
+{
+	struct rtw_dev *rtwdev = dev;
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	unsigned long flags;
+	u32 irq_status[4];
+
 	rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
 
 	if (irq_status[0] & IMR_MGNTDOK)
@@ -891,8 +908,11 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 	if (irq_status[0] & IMR_ROK)
 		rtw_pci_rx_isr(rtwdev, rtwpci, RTW_RX_QUEUE_MPDU);
 
-out:
-	spin_unlock(&rtwpci->irq_lock);
+	/* all of the jobs for this interrupt have been done */
+	spin_lock_irqsave(&rtwpci->irq_lock, flags);
+	if (rtw_flag_check(rtwdev, RTW_FLAG_RUNNING))
+		rtw_pci_enable_interrupt(rtwdev, rtwpci);
+	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -1152,8 +1172,10 @@ static int rtw_pci_probe(struct pci_dev *pdev,
 		goto err_destroy_pci;
 	}
 
-	ret = request_irq(pdev->irq, &rtw_pci_interrupt_handler,
-			  IRQF_SHARED, KBUILD_MODNAME, rtwdev);
+	ret = devm_request_threaded_irq(rtwdev->dev, pdev->irq,
+					rtw_pci_interrupt_handler,
+					rtw_pci_interrupt_threadfn,
+					IRQF_SHARED, KBUILD_MODNAME, rtwdev);
 	if (ret) {
 		ieee80211_unregister_hw(hw);
 		goto err_destroy_pci;
@@ -1192,7 +1214,7 @@ static void rtw_pci_remove(struct pci_dev *pdev)
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_destroy(rtwdev, pdev);
 	rtw_pci_declaim(rtwdev, pdev);
-	free_irq(rtwpci->pdev->irq, rtwdev);
+	devm_free_irq(rtwdev->dev, rtwpci->pdev->irq, rtwdev);
 	rtw_core_deinit(rtwdev);
 	ieee80211_free_hw(hw);
 }
-- 
2.20.1

