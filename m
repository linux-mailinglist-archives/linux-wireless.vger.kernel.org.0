Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878FA1AD7C4
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgDQHrN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:13 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37020 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgDQHrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:10 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l3oH5020081, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l3oH5020081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:03 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:01 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:01 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 12/40] rtw88: decompose while(1) loop of power sequence polling command
Date:   Fri, 17 Apr 2020 15:46:25 +0800
Message-ID: <20200417074653.15591-13-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417074653.15591-1-yhchuang@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

The power polling command is one kind of power sequence commands. It's used
to check hardware situation, and subsequent comamnds will be executed if
hardware is ready. A special case is PCIE must toggle BIT_PFM_WOWL and try
again if first try is failed.

In order to reduce indentation to understand the code easier, move polling
part to a separate function. Then, the 'while (1)...loop' is replaced by
two statements to do first try and retry.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 72 +++++++++++++-----------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 21b5c7173f0f..ac5d35153c8a 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -108,51 +108,55 @@ static int rtw_mac_pre_system_cfg(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static bool do_pwr_poll_cmd(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target)
+{
+	u32 cnt;
+
+	target &= mask;
+
+	for (cnt = 0; cnt < RTW_PWR_POLLING_CNT; cnt++) {
+		if ((rtw_read8(rtwdev, addr) & mask) == target)
+			return true;
+
+		udelay(50);
+	}
+
+	return false;
+}
+
 static int rtw_pwr_cmd_polling(struct rtw_dev *rtwdev,
 			       const struct rtw_pwr_seq_cmd *cmd)
 {
 	u8 value;
-	u8 flag = 0;
 	u32 offset;
-	u32 cnt = RTW_PWR_POLLING_CNT;
 
 	if (cmd->base == RTW_PWR_ADDR_SDIO)
 		offset = cmd->offset | SDIO_LOCAL_OFFSET;
 	else
 		offset = cmd->offset;
 
-	do {
-		cnt--;
-		value = rtw_read8(rtwdev, offset);
-		value &= cmd->mask;
-		if (value == (cmd->value & cmd->mask))
-			return 0;
-		if (cnt == 0) {
-			if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE &&
-			    flag == 0) {
-				value = rtw_read8(rtwdev, REG_SYS_PW_CTRL);
-				if (rtwdev->chip->id == RTW_CHIP_TYPE_8723D) {
-					value &= ~BIT_PFM_WOWL;
-					rtw_write8(rtwdev, REG_SYS_PW_CTRL, value);
-				}
-				value |= BIT_PFM_WOWL;
-				rtw_write8(rtwdev, REG_SYS_PW_CTRL, value);
-				value &= ~BIT_PFM_WOWL;
-				rtw_write8(rtwdev, REG_SYS_PW_CTRL, value);
-				if (rtwdev->chip->id == RTW_CHIP_TYPE_8723D) {
-					value |= BIT_PFM_WOWL;
-					rtw_write8(rtwdev, REG_SYS_PW_CTRL, value);
-				}
-
-				cnt = RTW_PWR_POLLING_CNT;
-				flag = 1;
-			} else {
-				return -EBUSY;
-			}
-		} else {
-			udelay(50);
-		}
-	} while (1);
+	if (do_pwr_poll_cmd(rtwdev, offset, cmd->mask, cmd->value))
+		return 0;
+
+	if (rtw_hci_type(rtwdev) != RTW_HCI_TYPE_PCIE)
+		goto err;
+
+	/* if PCIE, toggle BIT_PFM_WOWL and try again */
+	value = rtw_read8(rtwdev, REG_SYS_PW_CTRL);
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8723D)
+		rtw_write8(rtwdev, REG_SYS_PW_CTRL, value & ~BIT_PFM_WOWL);
+	rtw_write8(rtwdev, REG_SYS_PW_CTRL, value | BIT_PFM_WOWL);
+	rtw_write8(rtwdev, REG_SYS_PW_CTRL, value & ~BIT_PFM_WOWL);
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8723D)
+		rtw_write8(rtwdev, REG_SYS_PW_CTRL, value | BIT_PFM_WOWL);
+
+	if (do_pwr_poll_cmd(rtwdev, offset, cmd->mask, cmd->value))
+		return 0;
+
+err:
+	rtw_err(rtwdev, "failed to poll offset=0x%x mask=0x%x value=0x%x\n",
+		offset, cmd->mask, cmd->value);
+	return -EBUSY;
 }
 
 static int rtw_sub_pwr_seq_parser(struct rtw_dev *rtwdev, u8 intf_mask,
-- 
2.17.1

