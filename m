Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31F227806F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 08:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgIYGT3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 02:19:29 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39816 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgIYGT3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 02:19:29 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 02:19:27 EDT
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08P6CMvR4010490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08P6CMvR4010490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 14:12:22 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 25 Sep 2020 14:12:22 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <yhchuang@realtek.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] rtw88: increse the size of rx buffer size
Date:   Fri, 25 Sep 2020 14:12:15 +0800
Message-ID: <20200925061219.23754-2-tehuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925061219.23754-1-tehuang@realtek.com>
References: <20200925061219.23754-1-tehuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.222]
X-ClientProxiedBy: RTEXMB05.realtek.com.tw (172.21.6.98) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

The vht capability of MAX_MPDU_LENGTH is 11454 in rtw88; however, the rx
buffer size for each packet is 8192. When receiving packets that are
larger than rx buffer size, it will leads to rx buffer ring overflow.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 024c2bc275cb..ca17aa9cf7dc 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -9,8 +9,8 @@
 #define RTK_BEQ_TX_DESC_NUM	256
 
 #define RTK_MAX_RX_DESC_NUM	512
-/* 8K + rx desc size */
-#define RTK_PCI_RX_BUF_SIZE	(8192 + 24)
+/* 11K + rx desc size */
+#define RTK_PCI_RX_BUF_SIZE	(11454 + 24)
 
 #define RTK_PCI_CTRL		0x300
 #define BIT_RST_TRXDMA_INTF	BIT(20)
-- 
2.17.1

