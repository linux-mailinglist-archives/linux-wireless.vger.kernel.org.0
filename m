Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388E52D2039
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 02:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgLHBim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 20:38:42 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:34277 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgLHBim (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 20:38:42 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0B81btzY7000451, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0B81btzY7000451
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 8 Dec 2020 09:37:55 +0800
Received: from localhost (172.21.69.213) by RTEXMB04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 8 Dec 2020
 09:37:55 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw88: fix multiple definition of rtw_pm_ops
Date:   Tue, 8 Dec 2020 09:37:46 +0800
Message-ID: <20201208013746.11065-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXH365.realtek.com.tw (172.21.6.37) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

'const struct dev_pm_ops rtw_pm_ops' is declared by pci.c, and it should be
declare as 'extern' in pci.h. Without 'extern' causes every file including
pci.h has an individual instance of rtw_pm_ops but not reference to the one
declared in pci.c

If kernel config, like test robot, doesn't build driver as module, it leads
multiple definition.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 2e86ef413ab3 ("rtw88: pci: Add prototypes for .probe, .remove and .shutdown")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index cda56919a5f0..7cdefe229824 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -214,7 +214,7 @@ struct rtw_pci {
 	void __iomem *mmap;
 };
 
-const struct dev_pm_ops rtw_pm_ops;
+extern const struct dev_pm_ops rtw_pm_ops;
 
 int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 void rtw_pci_remove(struct pci_dev *pdev);
-- 
2.21.0

